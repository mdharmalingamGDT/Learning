table 50103 GDXDisassemblyLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "GDX Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = GDXDisassemblyHeader."GDX No.";
        }

        field(2; "GDX Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }

        field(10; "GDX Type"; Enum "BOM Component Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                // Optional logic
            end;
        }

        field(11; "GDX No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            TableRelation =
                if ("GDX Type" = const(Item)) Item where(Type = filter(Inventory | "Non-Inventory"))
            else
            if ("GDX Type" = const(Resource)) Resource;

            trigger OnValidate()
            begin
                case "GDX Type" of
                    "GDX Type"::Item:
                        CopyFromItem();
                    "GDX Type"::Resource:
                        CopyFromResource();
                end;
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

        field(6; "GDX Scrap"; Boolean)
        {
            Caption = 'Scrap';
            DataClassification = CustomerContent;
        }

        field(7; "GDX Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "GDX Document No.", "GDX Line No.")
        {
            Clustered = true;
        }
    }

    var
        Item: Record Item;
        Resource: Record Resource;

    local procedure CopyFromItem()
    begin
        GetItemResource();
    end;

    local procedure CopyFromResource()
    begin
        GetItemResource();
    end;

    local procedure GetItemResource()
    begin
        if "GDX Type" = "GDX Type"::Item then
            if Item."No." <> "GDX No." then
                Item.Get("GDX No.");

        if "GDX Type" = "GDX Type"::Resource then
            if Resource."No." <> "GDX No." then
                Resource.Get("GDX No.");
    end;
}
