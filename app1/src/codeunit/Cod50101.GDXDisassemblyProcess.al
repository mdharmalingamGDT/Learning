codeunit 50101 GDXDisassemblyManagement
{
    procedure FillDisassemblyLines(DocumentNo: Code[20]; "Item No.": code[50])
    var
        HeaderRec: Record GDXDisassemblyHeader;
        LineRec: Record GDXDisassemblyLine;
        BOMLineRec: Record "BOM Component";
        ItemRec: Record Item;
        LineNo: Integer;
    begin
        HeaderRec.Reset();
        if HeaderRec.Get(DocumentNo) then begin
            ItemRec.Reset();
            ItemRec.SetRange("No.", "Item No.");
            ItemRec.SetRange("Assembly BOM", true);
            if not ItemRec.FindFirst() then
                Error('Item %1 has no Assembly BOM.', ItemRec."No.");
        end;

        LineRec.SetRange("GDX Document No.", DocumentNo);
        LineRec.DeleteAll();

        BOMLineRec.Reset();
        BOMLineRec.SetRange("Parent Item No.", ItemRec."No.");
        LineNo := 0;
        if BOMLineRec.FindSet() then
            repeat
                LineNo += 10000;
                LineRec.Init();
                LineRec.Validate("GDX Document No.", DocumentNo);
                LineRec.Validate("GDX Line No.", LineNo);
                LineRec.Validate("GDX Type", BOMLineRec.Type);
                LineRec.Validate("GDX No.", BOMLineRec."No.");
                LineRec.Validate("GDX Location Code", HeaderRec."GDX Location Code");
                LineRec.Validate("GDX Quantity", BOMLineRec."Quantity per" * HeaderRec."GDX Quantity");
                LineRec.Validate("GDX Scrap", false); // default 0%
                LineRec.Insert(true);
            until BOMLineRec.Next() = 0;
    end;
}
