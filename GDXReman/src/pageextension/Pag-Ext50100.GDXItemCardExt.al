pageextension 50100 "GDX Item Card Ext" extends "Item Card"
{
    layout
    {
        addlast("Posting Details")
        {
            group("Core")
            {
                Caption = 'Core';

                field("Core Item"; Rec."GDX Core Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Core Item field.', Comment = '%';
                }
                field("Core Item No."; Rec."GDX Core Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Core Item No. field.', Comment = '%';
                }
            }
        }

    }
    actions
    {
        addlast(Navigation)
        {
            action(GDXCoreEntries)
            {
                Caption = 'Core Entries';
                ApplicationArea = All;
                RunObject = page "GDX Core Entries";
                RunPageLink = "GDX Item No." = field("No.");
            }
        }



    }
}
