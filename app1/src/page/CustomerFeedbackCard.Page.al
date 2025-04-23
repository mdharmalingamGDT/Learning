page 50101 "Customer Feedback Card"
{
    PageType = Card;
    SourceTable = "Customer Feedback";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Entry No."; Rec."Entry No.") { }
                field("Customer Name"; Rec."Customer Name") { }
                field("Feedback"; Rec."Feedback") { }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.', Comment = '%';
                }
                field("Rating"; Rec."Rating") { }
            }
        }
    }
}