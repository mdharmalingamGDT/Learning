permissionset 50101 "GDX REMAN USER"
{
    Assignable = true;
    Caption = 'REMAN USER', MaxLength = 30;
    Permissions =
        table GDXDisassemblyHeader = X,
        tabledata GDXDisassemblyHeader = RMI,
        table "GDX Core Entry" = X,
        tabledata "GDX Core Entry" = RMI,
        table GDXDisassemblyLine = X,
        tabledata GDXDisassemblyLine = RMI,
        page "GDX Core Entries" = X,
        page "GDX Disassembly Orders" = X,
        page "GDX Disassembly order" = X,
        page "GDX Disassembly Subform" = X,
        codeunit GDXTableSubscriptionCU = X,
        codeunit GDX_DisassemblyPost = X,
        codeunit GDXDisassemblyManagement = X;
}
