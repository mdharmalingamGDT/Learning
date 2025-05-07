codeunit 50100 GDXTableSubscriptionCU
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    var
        SalesLine: Record "Sales Line";
        RecSalesLine: Record "Sales Line";
        GDXCoreEntry: Record "GDX Core Entry";
    begin
        RecSalesLine.Reset();
        RecSalesLine.SetRange("Document Type", SalesHeader."Document Type");
        RecSalesLine.SetRange("Document No.", SalesHeader."No.");
        RecSalesLine.SetRange("GDX Core Counter Exchange", true);
        if RecSalesLine.FindSet() then
            repeat
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetFilter(Type, '%1', RecSalesLine.Type::Item);
                SalesLine.SetRange("No.", RecSalesLine."GDX Core Item No.");
                SalesLine.SetRange("Line No.", RecSalesLine."GDX Core Line No.");
                SalesLine.SetRange("GDX Core Type", SalesLine."GDX Core Type"::Core);
                SalesLine.SetFilter("GDX Counter Exchange Posted", '%1', false);
                if SalesLine.FindSet() then begin
                    GDXCoreEntry.Init();
                    GDXCoreEntry."GDX Document No." := SalesLine."Document No.";
                    GDXCoreEntry."GDX Line No." := SalesLine."Line No.";
                    GDXCoreEntry."GDX Item No." := SalesLine."No.";
                    GDXCoreEntry."GDX Quantity" := SalesLine.Quantity;
                    GDXCoreEntry."GDX Location Code" := SalesLine."Location Code";
                    GDXCoreEntry."GDX Posting Date" := SalesHeader."Posting Date";
                    GDXCoreEntry."GDX Journal Posted" := false;
                    GDXCoreEntry.Insert();
                end;
            until RecSalesLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        PostGDXCoreItemJournal(SalesHeader."No.");
    end;

    local procedure PostGDXCoreItemJournal(DocumentNo: Code[20])
    var
        GDXCoreEntry: Record "GDX Core Entry";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
    begin
        if not ItemJournalBatch.Get('ITEM', 'DEFAULT') then
            Error('Item Journal Batch DEFAULT not found.');

        GDXCoreEntry.SetRange("GDX Document No.", DocumentNo);
        GDXCoreEntry.SetRange("GDX Journal Posted", false);
        if GDXCoreEntry.FindSet() then
            repeat
                LineNo := 0;
                if ItemJournalLine.FindLast() then
                    LineNo := ItemJournalLine."Line No." + 10000;

                ItemJournalLine.Init();
                ItemJournalLine."Journal Template Name" := ItemJournalBatch."Journal Template Name";
                ItemJournalLine."Journal Batch Name" := ItemJournalBatch.Name;
                ItemJournalLine."Line No." := LineNo;
                ItemJournalLine."Document No." := 'CE-' + GDXCoreEntry."GDX Document No.";
                ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                ItemJournalLine.Validate("Item No.", GDXCoreEntry."GDX Item No.");
                ItemJournalLine.Validate(Quantity, GDXCoreEntry."GDX Quantity");
                ItemJournalLine.Validate("Location Code", GDXCoreEntry."GDX Location Code");
                ItemJournalLine.Validate("Posting Date", GDXCoreEntry."GDX Posting Date");
                ItemJournalLine.Insert(true);

                ItemJnlPostLine.RunWithCheck(ItemJournalLine);

                GDXCoreEntry."GDX Journal Posted" := true;
                GDXCoreEntry."GDX Posted By" := UserId;
                GDXCoreEntry."GDX Posting DateTime" := CurrentDateTime;
                GDXCoreEntry.Modify();

                // Mark Sales Line as processed
                SalesLine.SetRange("Document No.", GDXCoreEntry."GDX Document No.");
                SalesLine.SetRange("Line No.", GDXCoreEntry."GDX Line No.");
                if SalesLine.FindFirst() then begin
                    SalesLine."GDX Counter Exchange Posted" := true;
                    SalesLine.Modify();
                end;
            until GDXCoreEntry.Next() = 0;
    end;
}
