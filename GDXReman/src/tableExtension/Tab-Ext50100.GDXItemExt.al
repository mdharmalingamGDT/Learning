tableextension 50100 "GDX Item Ext" extends Item
{
    fields
    {
        field(50100; "GDX Core Item"; Boolean)
        {
            Caption = 'Core Item';
            DataClassification = ToBeClassified;
        }
        field(50101; "GDX Core Item No."; Code[50])
        {
            Caption = 'Core Item No.';
            DataClassification = ToBeClassified;
        }

    }
}
