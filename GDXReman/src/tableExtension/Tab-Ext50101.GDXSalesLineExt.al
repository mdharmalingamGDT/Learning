tableextension 50101 "GDX Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(50100; "GDX Core Item No."; Code[50])
        {
            Caption = 'Core Item No.';
            DataClassification = ToBeClassified;
        }
        field(50101; "GDX Ignore Core Component"; Boolean)
        {
            Caption = 'Ignore Core Component';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                gdxsaleslinerec: Record "Sales Line";
            begin
                if (rec."GDX Core Line Created" = true) then begin
                    gdxsaleslinerec.Reset();
                    gdxsaleslinerec.SetRange("Document No.", Rec."Document No.");
                    gdxsaleslinerec.SetRange("Document Type", rec."Document Type");
                    gdxsaleslinerec.SetRange("Line No.", rec."GDX Core Line No.");
                    if gdxsaleslinerec.FindFirst() then begin
                        gdxsaleslinerec.delete(true);
                    end;
                    Rec."GDX Core Line Created" := false;
                    Clear(rec."GDX Core Line No.");
                    rec.Modify();
                end;
            end;
        }
        field(50102; "GDX Core Type"; Enum "GDX Core Type")
        {
            Caption = 'Core Type';
            DataClassification = ToBeClassified;
        }
        field(50103; "GDX Core Line Created"; Boolean)
        {
            Caption = 'Core Line Created';
            DataClassification = ToBeClassified;
        }
        field(50104; "GDX Core Line No."; Integer)
        {
            Caption = 'Core Line No.';
            DataClassification = ToBeClassified;
        }
        field(50105; "GDX Core Counter Exchange"; Boolean)
        {
            Caption = 'Core Counter Exchange';
            DataClassification = ToBeClassified;
        }
        field(50106; "GDX Counter Exchange Posted"; Boolean)
        {
            Caption = 'GDX Counter Exchange Posted';
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                gdxitemRec: record Item;
            begin
                if (rec.Type = rec.Type::Item) then begin
                    gdxitemRec.Reset();
                    gdxitemRec.SetRange("No.", Rec."No.");
                    gdxitemRec.SetRange("GDX Core Item", false);
                    if gdxitemRec.FindFirst() then begin
                        Rec."GDX Core Item No." := gdxitemRec."GDX Core Item No.";
                    end;
                end;
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                gdxsaleslinerec: Record "Sales Line";
            begin
                if (rec."GDX Core Item No." <> '') and (rec."GDX Core Line Created" = false) then begin
                    Rec."GDX Core Line Created" := true;
                    rec."GDX Core Line No." := rec."Line No." + 10000;
                    rec.Modify();
                    gdxsaleslinerec.Init();
                    gdxsaleslinerec."Document No." := Rec."Document No.";
                    gdxsaleslinerec."Document Type" := rec."Document Type";
                    gdxsaleslinerec."Line No." := rec."Line No." + 10000;
                    gdxsaleslinerec.Validate(Type, gdxsaleslinerec.Type::Item);
                    gdxsaleslinerec.Validate("No.", Rec."GDX Core Item No.");
                    gdxsaleslinerec.Validate(Quantity, Rec.Quantity);
                    gdxsaleslinerec.Validate("GDX Core Type", gdxsaleslinerec."GDX Core Type"::Core);
                    gdxsaleslinerec.Insert(true);
                end;
            end;
        }
    }
}
