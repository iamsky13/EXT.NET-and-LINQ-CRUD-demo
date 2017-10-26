<%@ Page Language="C#" %>
 
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            Store store = this.GridPanel1.GetStore();
            store.DataSource = new object[] 
            { 
                new 
                {
                    test1 = "test1",
                    test2 = "test2"  
                },
                new 
                {
                    test1 = "test3",
                    test2 = "test4"  
                }
            };
            store.DataBind();
        }
    }

    protected void OnAfterEdit(object sender, DirectEventArgs e)
    {
        string oldValues = e.ExtraParams["old"];
        string newValues = e.ExtraParams["new"];
        X.Msg.Alert("OnAfterEdit", oldValues + "<br/>" + newValues).Show();
    }
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ext.NET Example</title>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        <ext:GridPanel ID="GridPanel1" runat="server" Height="200">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="test1" />
                                <ext:ModelField Name="test2" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Header="Test1" DataIndex="test1">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                    <ext:Column runat="server" Header="Test2" DataIndex="test2">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <Plugins>
                <ext:RowEditing runat="server">
                    <Listeners>
                        <BeforeEdit Handler="this.oldValues = Ext.net.clone(e.record.data);" />
                    </Listeners>
                    <DirectEvents>
                        <Edit OnEvent="OnAfterEdit">
                            <ExtraParams>
                                <ext:Parameter Name="old" Value="this.oldValues" Mode="Raw" Encode="true" />
                                <ext:Parameter Name="new" Value="e.record.data" Mode="Raw" Encode="true" />
                            </ExtraParams>
                        </Edit>
                    </DirectEvents>
                </ext:RowEditing>
            </Plugins>
        </ext:GridPanel>
    </form>
</body>
</html>