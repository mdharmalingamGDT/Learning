permissionset 50100 "Cust. Feedback Read"
{
    Assignable = true;
    Caption = 'Customer Feedback Read', MaxLength = 30;
    Permissions =
        table "Customer Feedback" = X,
        tabledata "Customer Feedback" = R,
        page "Customer Feedback List" = X,
        page "Customer Feedback Card" = X;
}
