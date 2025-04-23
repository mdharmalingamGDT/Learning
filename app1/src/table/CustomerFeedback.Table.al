table 50100 "Customer Feedback"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(2; "Customer Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Feedback"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Rating"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}