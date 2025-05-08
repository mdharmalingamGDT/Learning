pageextension 50101 GDXSalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        addafter(Description)
        {

            field("GDX Core Type"; Rec."GDX Core Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Core Type field.', Comment = '%';
            }
            field("GDX Core Item No."; Rec."GDX Core Item No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Core Item No. field.', Comment = '%';
            }
            field("GDX Core Line Created"; Rec."GDX Core Line Created")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Core Type field.', Comment = '%';
            }
            field("GDX Ignore Core Component"; Rec."GDX Ignore Core Component")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Ignore Core Component field.', Comment = '%';
            }
            field("GDX Core Line No."; Rec."GDX Core Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Core Type field.', Comment = '%';
            }
            field("GDX Core Counter Exchange"; Rec."GDX Core Counter Exchange")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Core Counter Exchange field.', Comment = '%';
            }
        }
    }
}
