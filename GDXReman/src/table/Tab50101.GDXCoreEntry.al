table 50101 "GDX Core Entry"
{
    Caption = 'GDX Core Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "GDX Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(2; "GDX Document No."; Code[20])
        {
            Caption = 'Document No.';
        }

        field(3; "GDX Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(4; "GDX Item No."; Code[20])
        {
            Caption = 'Item No.';
        }

        field(5; "GDX Quantity"; Decimal)
        {
            Caption = 'Quantity';
        }

        field(6; "GDX Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }

        field(7; "GDX Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }

        field(8; "GDX Journal Posted"; Boolean)
        {
            Caption = 'Journal Posted';
        }

        field(9; "GDX Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = SystemMetadata;
        }

        field(10; "GDX Posting DateTime"; DateTime)
        {
            Caption = 'Posting DateTime';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "GDX Entry No.")
        {
            Clustered = true;
        }
    }
}
