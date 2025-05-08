permissionset 50100 "GDX REMAN ADMIN"
{
    Assignable = true;
    Caption = 'REMAN ADMIN', MaxLength = 30;
    Permissions =
        table GDXDisassemblyHeader = X,
        tabledata GDXDisassemblyHeader = RMID,
        table "GDX Core Entry" = X,
        tabledata "GDX Core Entry" = RMID,
        table GDXDisassemblyLine = X,
        tabledata GDXDisassemblyLine = RMID,
        page "GDX Core Entries" = X,
        page "GDX Disassembly Orders" = X,
        page "GDX Disassembly order" = X,
        page "GDX Disassembly Subform" = X,
        codeunit GDXTableSubscriptionCU = X,
        codeunit GDX_DisassemblyPost = X,
        codeunit GDXDisassemblyManagement = X;
}
