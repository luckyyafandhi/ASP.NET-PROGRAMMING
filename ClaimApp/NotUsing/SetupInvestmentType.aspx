﻿<%@ Page Title="Jenis Investasi" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SetupInvestmentType.aspx.cs" Inherits="ClaimApp.SetupInvestmentType" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <script type="text/javascript">
        function onSave(s, e) {
            var isValid = ASPxClientEdit.ValidateGroup('Validation');

            if (isValid) {
                popupSave.Show();
            }
        }
        function onSaveWork(s, e) {
            var isValid = ASPxClientEdit.ValidateGroup('ValidationWork');

            if (isValid) {
                popupSave.Show();
            }
        }

        function onLeavePage(s, e) {

            popupLeavePage.Show();

        }
        function onAddWorkLocation(s, e) {

            popupAddWorkLocation.Show();

        }

        function onAddAllWorkLocation(s, e) {

            popupAddAllWorkLocation.Show();

        }

        function onResetPassword(s, e) {

            popupResetPassword.Show();

        }

        function onReactivate(s, e) {

            popupReactivate.Show();

        }
        function State_OnKeyUp(s, e) {
            s.SetText(s.GetText().toUpperCase());
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ScriptManager ID="SM" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="Upanel" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <h1>JENIS INVESTASI</h1>
                <ol class="breadcrumb">
                    <li><a href="Home.aspx">Home</a></li>
                    <li><a href="#">Master</a></li>
                    <li class="active">Jenis Investasi</li>
                </ol>
            </section>
            <section class="content">
                <div class="box box-primary">
                    <div class="box-body">
                        <asp:HiddenField ID="hidPID" runat="server" Value="0" />
                        <asp:HiddenField ID="hidExit" runat="server" Value="1" />
                        <asp:HiddenField ID="hidTransaction" runat="server" Value="0" />
                        <div class="table-responsive">
                            <dx:BootstrapGridView ID="gridInvestmentType" runat="server" DataSourceID="dsGridInvestmentType" AutoGenerateColumns="False" KeyFieldName="Pid">
                                <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                                <Settings ShowHeaderFilterButton="True" />
                                <SettingsPager Visible="False">
                                </SettingsPager>
                                <SettingsEditing Mode="PopupEditForm">
                                    <FormLayoutProperties LayoutType="Vertical">
                                        <Items>
                                            <dx:BootstrapGridViewColumnLayoutItem ColumnName="InvestmentType" ColSpanMd="12" Caption="Jenis Investasi">
                                            </dx:BootstrapGridViewColumnLayoutItem>
                                            <dx:BootstrapGridViewColumnLayoutItem ColumnName="isActive" ColSpanMd="12" Caption="Status Aktif">
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
                                    <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" MaxWidth="50" Width="50" ShowClearFilterButton="True">
                                    </dx:BootstrapGridViewCommandColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Pid" VisibleIndex="1" ReadOnly="True" Visible="false">
                                        <SettingsEditForm Visible="False" />
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="InvestmentType" VisibleIndex="2" Caption="Jenis Investasi">
                                        <PropertiesTextEdit>
                                             <ValidationSettings>
                                                 <RequiredField IsRequired="true" />
                                             </ValidationSettings>
                                            <ClientSideEvents KeyUp="State_OnKeyUp" />
                                        </PropertiesTextEdit>
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewCheckColumn FieldName="isActive" VisibleIndex="3" Caption="Status Aktif">
                                    </dx:BootstrapGridViewCheckColumn>
                                </Columns>
                            </dx:BootstrapGridView>
                        </div>
                    </div>

                    <asp:SqlDataSource ID="dsGridInvestmentType" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT Pid,[InvestmentType], [isActive] FROM [Reksa_MasterInvestmentType]" DeleteCommand="Update Reksa_MasterInvestmentType set isActive=0 where Pid=@Pid" InsertCommand="Insert Into Reksa_MasterInvestmentType (InvestmentType, isActive) Values (@InvestmentType, @isActive); Select @Pid = SCOPE_IDENTITY();" UpdateCommand="Update Reksa_MasterInvestmentType set InvestmentType=@InvestmentType, isActive=@isActive where Pid=@Pid">
                        <DeleteParameters>
                            <asp:Parameter Name="isActive" />
                            <asp:Parameter Name="Pid" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="InvestmentType" />
                            <asp:Parameter Name="isActive" />
                            <asp:Parameter Name="Pid" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="InvestmentType" />
                            <asp:Parameter Name="isActive" />
                            <asp:Parameter Name="Pid" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                </div>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
