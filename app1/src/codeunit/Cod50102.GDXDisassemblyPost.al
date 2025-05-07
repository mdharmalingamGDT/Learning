codeunit 50102 "GDX_DisassemblyPost"
{
    Subtype = Normal;

    procedure PostDisassembly(DocumentNo: Code[20])
    var
        Header: Record "GDXDisassemblyHeader";
        Line: Record "GDXDisassemblyLine";
        ItemJnlLine: Record "Item Journal Line";
        ResJnlLine: Record "Res. Journal Line";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ResJnlTemplate: Record "Res. Journal Template";
        ResJnlBatch: Record "Res. Journal Batch";
        ItemPostLineCU: Codeunit "Item Jnl.-Post Line";
        ResPostLineCU: Codeunit "Res. Jnl.-Post Line";
        LineNo: Integer;
        ResEntryType: Enum "Res. Journal Line Entry Type";
    begin
        // 1. Validate document and its lines
        ValidateDisassemblyDocument(DocumentNo);

        // 2. Fetch Header
        Header.Get(DocumentNo);
        if Header."GDX Status" <> Header."GDX Status"::Open then
            Error('Document already posted.');

        // 3. Prepare Journal Templates/Batches
        ItemJnlTemplate.Get('GENERAL');
        ItemJnlBatch.Get('GENERAL', 'DEFAULT');
        ResJnlTemplate.Get('RESOURCES');
        ResJnlBatch.Get('RESOURCES', 'GENERAL');

        // 4. Post Finished Item as Negative Adjustment
        LineNo := 10000;
        PostItemJournalLine(
            ItemJnlTemplate.Name, ItemJnlBatch.Name, Header."GDX Posting Date",
            LineNo, DocumentNo, Header."GDX Item No.", Header."GDX Location Code",
            -1 * Header."GDX Quantity", "Item Journal Entry Type"::"Negative Adjmt."
        );

        // 5. Post Component Lines
        Line.SetRange("GDX Document No.", DocumentNo);
        if Line.FindSet() then
            repeat
                LineNo += 10000;

                case Line."GDX Type" of
                    Line."GDX Type"::Item:
                        PostItemJournalLine(
                            ItemJnlTemplate.Name, ItemJnlBatch.Name, Header."GDX Posting Date",
                            LineNo, DocumentNo, Line."GDX No.", Line."GDX Location Code",
                            Line."GDX Quantity",
                            ChooseItemEntryType(Line."GDX Scrap")
                        );

                    Line."GDX Type"::Resource:
                        PostResourceJournalLine(
                            ResJnlTemplate.Name, ResJnlBatch.Name, Header."GDX Posting Date",
                            LineNo, DocumentNo, Line."GDX No.", Line."GDX Quantity",
                            ResEntryType::Purchase
                        );
                end;
            until Line.Next() = 0;

        // 6. Update header status to posted
        Header."GDX Status" := Header."GDX Status"::Posted;
        Header.Modify();
    end;

    // ---------------------- Helper Functions ----------------------

    local procedure PostItemJournalLine(
        TemplateName: Code[10];
        BatchName: Code[10];
        PostingDate: Date;
        LineNo: Integer;
        DocumentNo: Code[20];
        ItemNo: Code[20];
        LocationCode: Code[10];
        Quantity: Decimal;
        EntryType: Enum "Item Journal Entry Type"
    )
    var
        ItemJnlLine: Record "Item Journal Line";
        PostCU: Codeunit "Item Jnl.-Post Line";
    begin
        Clear(ItemJnlLine);
        ItemJnlLine.Init();
        ItemJnlLine."Journal Template Name" := TemplateName;
        ItemJnlLine."Journal Batch Name" := BatchName;
        ItemJnlLine."Line No." := LineNo;
        ItemJnlLine."Document No." := DocumentNo;
        ItemJnlLine."Posting Date" := PostingDate;
        ItemJnlLine.Validate("Item No.", ItemNo);
        ItemJnlLine.Validate("Location Code", LocationCode);
        ItemJnlLine.Validate("Entry Type", EntryType);
        ItemJnlLine.Validate(Quantity, Quantity);
        ItemJnlLine.Insert();
        PostCU.RunWithCheck(ItemJnlLine);
        ItemJnlLine.Delete();
    end;

    local procedure PostResourceJournalLine(
        TemplateName: Code[10];
        BatchName: Code[10];
        PostingDate: Date;
        LineNo: Integer;
        DocumentNo: Code[20];
        ResourceNo: Code[20];
        Quantity: Decimal;
        EntryType: Enum "Res. Journal Line Entry Type"
    )
    var
        ResJnlLine: Record "Res. Journal Line";
        PostCU: Codeunit "Res. Jnl.-Post Line";
    begin
        Clear(ResJnlLine);
        ResJnlLine.Init();
        ResJnlLine."Journal Template Name" := TemplateName;
        ResJnlLine."Journal Batch Name" := BatchName;
        ResJnlLine."Line No." := LineNo;
        ResJnlLine."Document No." := DocumentNo;
        ResJnlLine."Posting Date" := PostingDate;

        ResJnlLine.Validate("Resource No.", ResourceNo);
        ResJnlLine.Validate("Entry Type", EntryType);
        ResJnlLine.Validate(Quantity, Quantity);
        ResJnlLine.Insert();
        PostCU.RunWithCheck(ResJnlLine);
        ResJnlLine.Delete();
    end;

    local procedure ChooseItemEntryType(Scrap: Boolean): Enum "Item Journal Entry Type"
    begin
        if Scrap then
            exit("Item Journal Entry Type"::"Negative Adjmt.")
        else
            exit("Item Journal Entry Type"::"Positive Adjmt.");
    end;

    local procedure ValidateDisassemblyDocument(DocumentNo: Code[20])
    var
        Header: Record "GDXDisassemblyHeader";
        Line: Record "GDXDisassemblyLine";
        Item: Record Item;
        Res: Record Resource;
        Errors: List of [Text[250]];
        ErrorText: Text[2048];
        i: Integer;
    begin
        if not Header.Get(DocumentNo) then
            Errors.Add('Header not found.');

        if Header."GDX Item No." = '' then
            Errors.Add('Header: Item No. is blank.');

        if Header."GDX Quantity" = 0 then
            Errors.Add('Header: Quantity is zero.');

        Line.SetRange("GDX Document No.", DocumentNo);
        if not Line.FindFirst() then
            Errors.Add('No lines found for the document.')
        else begin
            repeat
                if Line."GDX Quantity" = 0 then
                    Errors.Add(StrSubstNo('Line %1: Quantity is zero.', Line."GDX Line No."));

                case Line."GDX Type" of
                    Line."GDX Type"::Item:
                        if not Item.Get(Line."GDX No.") then
                            Errors.Add(StrSubstNo('Line %1: Item "%2" does not exist.', Line."GDX Line No.", Line."GDX No."));
                    Line."GDX Type"::Resource:
                        if not Res.Get(Line."GDX No.") then
                            Errors.Add(StrSubstNo('Line %1: Resource "%2" does not exist.', Line."GDX Line No.", Line."GDX No."));
                end;
            until Line.Next() = 0;
        end;

        // Use a for loop to iterate over the error list by index
        ErrorText := '';
        for i := 1 to Errors.Count() do
            ErrorText += Errors.Get(i) + '\';

        if ErrorText <> '' then
            Error('Disassembly validation failed:\n%1', ErrorText);
    end;
}
