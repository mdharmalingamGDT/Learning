page 50105 "GDX Disassembly Subform"
{
    Caption = 'GDX Disassembly Subform';
    PageType = ListPart;
    SourceTable = GDXDisassemblyLine;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."GDX Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                }
                field("Line No."; Rec."GDX Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Type"; Rec."GDX Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }

                field("Item No."; Rec."GDX No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field(Quantity; Rec."GDX Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Location Code"; Rec."GDX Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Scrap"; Rec."GDX Scrap")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scrap  field.', Comment = '%';
                }
                field(Description; Rec."GDX Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
            }
        }
    }
}
