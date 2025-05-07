permissionset 50102 "GDX REMAN VIEW"
{
    Assignable = true;
    Caption = 'REMAN VIEW', MaxLength = 30;
    Permissions =
        table GDXDisassemblyHeader = X,
        tabledata GDXDisassemblyHeader = R,
        table "GDX Core Entry" = X,
        tabledata "GDX Core Entry" = R,
        table GDXDisassemblyLine = X,
        tabledata GDXDisassemblyLine = R,
        page "GDX Core Entries" = X,
        page "GDX Disassembly Orders" = X,
        page "GDX Disassembly order" = X,
        page "GDX Disassembly Subform" = X,
        codeunit GDXTableSubscriptionCU = X;
}
