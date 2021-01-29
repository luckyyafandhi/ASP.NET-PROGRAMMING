<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MasterBengkel.aspx.cs" Inherits="ClaimApp.MasterBengkel" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <script type="text/javascript">
        function State_OnKeyUp(s, e) {
            s.SetText(s.GetText().toUpperCase());
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <section class="content-header">
        <h1>MASTER WORKSHOP
        </h1>
        <ol class="breadcrumb">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Master</a></li>
            <li class="active">Workshop</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-primary">
            <div class="box-body">
                <asp:HiddenField ID="hidPID" runat="server" Value="0" />
                <asp:HiddenField ID="hidExit" runat="server" Value="1" />
                <asp:HiddenField ID="hidTransaction" runat="server" Value="0" />
                <div class="table-responsive">
                    <dx:BootstrapGridView ID="gridBengkel" runat="server" AutoGenerateColumns="False" KeyFieldName="Pid" DataSourceID="dsMasterBengkel">
                        <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsEditing Mode="PopupEditForm">
                            <FormLayoutProperties LayoutType="Vertical">
                                <Items>
                                    <dx:BootstrapGridViewColumnLayoutItem Caption="Name Workshop" ColSpanLg="6" ColumnName="Name" RequiredMarkDisplayMode="Required">
                                    </dx:BootstrapGridViewColumnLayoutItem>
                                    <dx:BootstrapGridViewColumnLayoutItem Caption="Mobile" ColumnName="No Telp">
                                    </dx:BootstrapGridViewColumnLayoutItem>
                                    <dx:BootstrapGridViewColumnLayoutItem Caption="Address" ColSpanLg="12" ColumnName="Alamat">
                                    </dx:BootstrapGridViewColumnLayoutItem>
                                    <dx:BootstrapGridViewColumnLayoutItem ColSpanLg="6" ColumnName="Status">
                                    </dx:BootstrapGridViewColumnLayoutItem>
                                    <dx:BootstrapEditModeCommandLayoutItem>
                                    </dx:BootstrapEditModeCommandLayoutItem>
                                </Items>
                            </FormLayoutProperties>
                        </SettingsEditing>
                        <SettingsCommandButton>
                            <NewButton IconCssClass="fa fa-plus-circle" />
                            <UpdateButton IconCssClass="fa fa-save" CssClass="btn btn-success color-white" />
                            <CancelButton IconCssClass="fa fa-close" CssClass="btn btn-default color-grey m-l-5" />
                            <EditButton IconCssClass="fa fa-edit" />
                            <DeleteButton IconCssClass="fa fa-trash-o" />
                        </SettingsCommandButton>
                        <Columns>
                            <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                            </dx:BootstrapGridViewCommandColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" Visible="False" VisibleIndex="1">
                                <SettingsEditForm Visible="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Name" VisibleIndex="2" caption="Workshop">
                                <PropertiesTextEdit>
                                    <ValidationSettings>
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </PropertiesTextEdit>
                                <Settings AllowFilterBySearchPanel="True" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Alamat" VisibleIndex="3" caption="Address">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="NoTelp" VisibleIndex="4" caption="Mobile">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="Status" VisibleIndex="5" caption="Status">
                            </dx:BootstrapGridViewCheckColumn>
                        </Columns>


                        <SettingsSearchPanel ShowClearButton="True" Visible="True" />


                    </dx:BootstrapGridView>
                </div>
            </div>
        </div>
        <asp:SqlDataSource ID="dsMasterBengkel" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringLive %>" SelectCommand="Select * from Master_Bengkel"
             DeleteCommand="update Master_Bengkel set Status = 0, Cdatetime = getdate() Where Pid = @Pid" 
            InsertCommand="insert into Master_Bengkel (Name,Alamat,NoTelp,Status) values (@Name,@Alamat,@NoTelp,@Status)" 
            UpdateCommand="update Master_Bengkel set Name = @Name,Alamat = @Alamat,NoTelp = @NoTelp,Status = @Status Where Pid = @Pid">
            <DeleteParameters>
                <asp:Parameter Name="Pid" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Name" />
                <asp:Parameter Name="Alamat" />
                <asp:Parameter Name="NoTelp" />
                <asp:Parameter Name="Status" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" />
                <asp:Parameter Name="Alamat" />
                <asp:Parameter Name="NoTelp" />
                <asp:Parameter Name="Status" />
                <asp:Parameter Name="Pid" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
