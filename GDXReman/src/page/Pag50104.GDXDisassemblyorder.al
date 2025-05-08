page 50104 "GDX Disassembly order"
{
    Caption = 'Disassembly order';
    PageType = Document;
    SourceTable = GDXDisassemblyHeader;
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {

                field("No."; Rec."GDX No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Location Code"; Rec."GDX Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Posting Date"; Rec."GDX Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(Status; Rec."GDX Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Item No."; Rec."GDX Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field(Description; Rec."GDX Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Quantity; Rec."GDX Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
            }

            part(Lines; "GDX Disassembly Subform")
            {
                SubPageLink = "GDX Document No." = FIELD("GDX No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                trigger OnAction()
                var
                    PostCU: Codeunit GDX_DisassemblyPost;
                begin
                    PostCU.PostDisassembly(Rec."GDX No.");
                    CurrPage.Update();
                end;
            }
        }
    }
}
