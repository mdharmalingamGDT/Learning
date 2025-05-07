table 50102 GDXDisassemblyHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "GDX No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }

        field(2; "GDX Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }

        field(3; "GDX Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
            trigger OnValidate()
            var
                GDXItem: Record Item;
                GDXDisMgt: Codeunit GDXDisassemblyManagement;
            begin
                if GDXItem.Get("GDX Item No.") then
                    "GDX Description" := GDXItem.Description;

                if "GDX Status" = "GDX Status"::Open then
                    GDXDisMgt.FillDisassemblyLines("GDX No.", "GDX Item No.");
            end;
        }

        field(4; "GDX Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }

        field(5; "GDX Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }

        field(6; "GDX Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = Open,Posted;
        }

        field(7; "GDX Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "GDX No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        GDXNoSeriesMgt: Codeunit "No. Series";
    begin
        if "GDX No." = '' then
            "GDX No." := GDXNoSeriesMgt.GetNextNo('DISASSEMBLY');
    end;
}
