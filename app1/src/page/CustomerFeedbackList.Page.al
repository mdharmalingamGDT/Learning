page 50102 "Customer Feedback List"
{
    PageType = List;
    SourceTable = "Customer Feedback";
    CardPageId = "Customer Feedback Card";
    ApplicationArea = All;
    Caption = 'Customer Feedback List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.") { }
                field("Customer Name"; Rec."Customer Name") { }
                field("Rating"; Rec."Rating") { }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ViewDetails)
            {
                ApplicationArea = All;
                Caption = 'View Feedback';
                RunObject = Page "Customer Feedback Card";
                RunPageMode = View;
            }
        }
    }
}