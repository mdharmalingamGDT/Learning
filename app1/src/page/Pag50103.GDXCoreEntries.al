page 50103 "GDX Core Entries"
{
    ApplicationArea = All;
    Caption = 'GDX Core Entries';
    PageType = List;
    SourceTable = "GDX Core Entry";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("GDX Document No."; Rec."GDX Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GDX Document No. field.', Comment = '%';
                }
                field("GDX Line No."; Rec."GDX Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GDX Line No. field.', Comment = '%';
                }
                field("GDX Item No."; Rec."GDX Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GDX Item No. field.', Comment = '%';
                }
                field("GDX Quantity"; Rec."GDX Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GDX Quantity field.', Comment = '%';
                }
                field("GDX Location Code"; Rec."GDX Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GDX Location Code field.', Comment = '%';
                }
                field("GDX Posting Date"; Rec."GDX Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GDX Posting Date field.', Comment = '%';
                }
                field("GDX Journal Posted"; Rec."GDX Journal Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GDX Journal Posted field.', Comment = '%';
                }
                field("GDX Posted By"; Rec."GDX Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GDX Posted By field.', Comment = '%';
                }
                field("GDX Posting DateTime"; Rec."GDX Posting DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GDX Posting DateTime field.', Comment = '%';
                }
            }
        }
    }
}
