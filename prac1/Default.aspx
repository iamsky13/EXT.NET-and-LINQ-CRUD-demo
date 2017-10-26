<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="prac1.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .icon-exclamation {
            padding-left: 25px !important;
            background: url(/icons/exclamation-png/ext.axd) no-repeat 3px 0px !important;
        }

        .icon-accept {
            padding-left: 25px !important;
            background: url(/icons/accept-png/ext.axd) no-repeat 3px 0px !important;
        }
    </style>
    <script src="common.js" type="text/javascript"></script>
 <script>
     var processEvent = function (view, record, node, index, event) {
         // Load the event with the extra information needed by the mappings
         event.gridView = view;
         event.store = view.getStore();
         event.record = record;
         event.index = index;
         return event;
     };

     var deleteRows = function (keyCode, e) {
         Ext.Msg.confirm(
             'Delete Rows',
             'Are you sure?',
             function (btn) {
                 if (btn == 'yes') {
                     alert(e);
                 }

                 // Attempt to select the record that's now in its place
                 e.gridView.getSelectionModel().select(e.index);
                 e.gridView.el.focus();
             });
     };
    </script>

</head>
<body>
     <ext:ResourceManager runat="server" />
     <form id="myform" runat="server">
     <input type="hidden" id="abc" runat="server" name="country" value="Norway"/>

    <%-- aakash --%>
       
    <ext:Panel
            runat="server"
            Layout="FitLayout"
            Width="600"
            Height="250">
            <Items>
                <ext:FormPanel
                    ID="FormPanel1"
                    runat="server"
                    Title="FormPanel Validation (all fields required)"
                    BodyPadding="5"
                    ButtonAlign="Right"
                    Layout="Column">
                    <Items>
                        <ext:Panel
                            runat="server"
                            Border="false"
                            Header="false"
                            ColumnWidth=".8"
                            Layout="Form"
                            LabelAlign="Top">
                            <Defaults>
                                <ext:Parameter Name="AllowBlank" Value="false" Mode="Raw" />
                                <ext:Parameter Name="MsgTarget" Value="side" />
                            </Defaults>
                            <Items>
                                <ext:TextField runat="server" ColumnWidth="1"    FieldLabel="First Name" ID="txtName" AnchorHorizontal="92%" />
                                <ext:ComboBox
                                    runat="server"
                                    Id="CategoryComboBox"
                                    DisplayField="Name"
                                    FieldLabel="Category"
                                    ValueField="CategoryID"
                                    Width="320"
                                    LabelWidth="130"
                                    TypeAhead="true">
                                        <Store>
                                            <ext:Store runat="server" ID="Store1" AutoDataBind="true">
                                                <Model>
                                                    <ext:Model runat="server">
                                                        <Fields>
                                         
                                                             <ext:ModelField Name="CategoryID" />
                                                             <ext:ModelField Name="Name" />
                                        
                                                        </Fields>
                                                    </ext:Model>
                                                </Model>

                                            </ext:Store>
                                        </Store>
                                    </ext:ComboBox>
                                <ext:TextField runat="server" ColumnWidth="1" FieldLabel="Unit Price" ID="txtUnitPrice" AnchorHorizontal="92%" />
                            </Items>
                        </ext:Panel>
                      
                    </Items>
                    <BottomBar>
                        <ext:StatusBar runat="server" />
                    </BottomBar>
                    <Listeners>
                        <ValidityChange Handler="this.dockedItems.get(1).setStatus({
                                                     text : valid ? 'Form is valid' : 'Form is invalid',
                                                     iconCls: valid ? 'icon-accept' : 'icon-exclamation'
                                                 });
                                                 #{Button1}.setDisabled(!valid);" />
                    </Listeners>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button
                    ID="Button1"
                    runat="server"
                    Text="Save"
                    Disabled="true"
                    FormBind="true">
                    <DirectEvents>
                    <Click OnEvent="Save_click">
                        <EventMask ShowMask="true" />                       
                    </Click>
                </DirectEvents>
                </ext:Button>
                
            </Buttons>
        </ext:Panel>
         
    <%-- aakash --%>

    <ext:GridPanel
        ID="GridPanel1"
        
        runat="server"
        Title="Array Grid"
        Width="700"
        Height="350">
        <Store>
            <ext:Store ID="Store" runat="server">
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                             <ext:ModelField Name="ProductID" Type="String" />
                             <ext:ModelField Name="CategoryID" />
                             <ext:ModelField Name="Name" />
                             <ext:ModelField Name="UnitPrice" />                            
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel>
            <Columns>
                <ext:Column Header="Name" runat="server" Width="150"   Text="editedtext" DataIndex="Name" >
                <Editor>
                        <ext:TextField ID="Name" runat="server"  />
                </Editor> 
                </ext:Column>    
                <ext:Column Header="UnitPrice" Width="150" runat="server" DataIndex="UnitPrice" >
                <Editor>
                        <ext:TextField runat="server"  />
                </Editor> 
                </ext:Column>
            </Columns>
            
        </ColumnModel>
        <BottomBar>
           <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server"></ext:ToolbarFill>
                        <ext:Button ID="Button2" Text="Submit" runat="server">
                            <DirectEvents>
                                <Click OnEvent="Submit_Click">
                                    <EventMask ShowMask="true" />  
                                    <ExtraParams>
                                            <%--<ext:Parameter Name="GridData" Value="#{GridPanel1}.getStore().getTotalCount()" Mode="Raw" ></ext:Parameter>--%>
                                            <ext:Parameter Name="GridData" Value="Ext.encode(#{GridPanel1}.getRowsValues({selectedOnly : true}))" Mode="Raw" ></ext:Parameter>
                                    </ExtraParams>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Items>
            </ext:Toolbar>
        </BottomBar>
        

        <SelectionModel>
            
            <ext:RowSelectionModel runat="server" />
           
        </SelectionModel>
        
        <Plugins>
                <ext:RowEditing runat="server">
                    <Listeners>
                        <%--<BeforeEdit Handler="this.oldValues = Ext.net.clone(e.record.data);" />--%>
                    </Listeners>
                    <DirectEvents>
                        <Edit OnEvent="OnAfterEdit">
                            <ExtraParams>
                                <%--<ext:Parameter Name="old" Value="this.oldValues" Mode="Raw" Encode="true" />--%>
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
