permissionset 50101 "Cust. Feedback Admin"
{
    Assignable = true;
    Caption = 'Customer Feedback Admin', MaxLength = 30;
    Permissions =
        table "Customer Feedback" = X,
        tabledata "Customer Feedback" = RMID,
        page "Customer Feedback List" = X,
        page "Customer Feedback Card" = X;
}
