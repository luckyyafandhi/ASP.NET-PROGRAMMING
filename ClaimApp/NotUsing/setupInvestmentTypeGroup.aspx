﻿<%@ Page Title="Group Investasi" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="setupInvestmentTypeGroup.aspx.cs" Inherits="ClaimApp.setupInvestmentTypeGroup" %>

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
    <asp:ScriptManager ID="SM" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="Upanel" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <h1>GROUP INVESTASI</h1>
                <ol class="breadcrumb">
                    <li><a href="Home.aspx">Home</a></li>
                    <li><a href="#">Master</a></li>
                    <li class="active">Group Investasi</li>
                </ol>
            </section>
            <section class="content">
                <div class="box box-primary">
                    <div class="box-body">
                        <asp:HiddenField ID="hidPID" runat="server" Value="0" />
                        <asp:HiddenField ID="hidExit" runat="server" Value="1" />
                        <asp:HiddenField ID="hidTransaction" runat="server" Value="0" />
                        <div class="table-responsive">
                            <dx:BootstrapGridView ID="gridInvestmentTypeGroup" runat="server" DataSourceID="dsGridInvestmentGroup" AutoGenerateColumns="False" KeyFieldName="Pid">
                                <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                                <Settings ShowHeaderFilterButton="True" />
                                <SettingsEditing Mode="PopupEditForm">
                                    <FormLayoutProperties LayoutType="Vertical">
                                        <Items>
                                            <dx:BootstrapGridViewColumnLayoutItem ColumnName="InvestmentType_Pid" ColSpanMd="12" Caption="Jenis Investasi">
                                            </dx:BootstrapGridViewColumnLayoutItem>
                                            <dx:BootstrapGridViewColumnLayoutItem ColumnName="InvestmentTypeGroupName" ColSpanMd="12" Caption="Group Investasi">
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
                                    <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0"  MaxWidth="50" Width="50">
                                    </dx:BootstrapGridViewCommandColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Pid" VisibleIndex="1" ReadOnly="True" Visible="false">
                                        <SettingsEditForm Visible="False" />
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewComboBoxColumn FieldName="InvestmentType_Pid" VisibleIndex="2" PropertiesComboBox-DataSourceID="dsCboInvestmentType" PropertiesComboBox-TextField="InvestmentType" PropertiesComboBox-ValueField="Pid" PropertiesComboBox-ValueType="System.Int32" Caption="Jenis Investasi">
                                        <PropertiesComboBox>
                                            <ValidationSettings>
                                                <RequiredField IsRequired="true" />
                                            </ValidationSettings>
                                        </PropertiesComboBox>
                                    </dx:BootstrapGridViewComboBoxColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="InvestmentTypeGroupName" VisibleIndex="3" Caption="Group Investasi">
                                        <PropertiesTextEdit>
                                            <ValidationSettings>
                                                <RequiredField IsRequired="true" />
                                            </ValidationSettings>
                                            <ClientSideEvents KeyUp="State_OnKeyUp" />
                                        </PropertiesTextEdit>
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewCheckColumn FieldName="isActive" VisibleIndex="4" Caption="Status Aktif">
                                    </dx:BootstrapGridViewCheckColumn>
                                </Columns>
                            </dx:BootstrapGridView>
                        </div>
                    </div>

                    <asp:SqlDataSource ID="dsGridInvestmentGroup" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT Pid,[InvestmentType_Pid]
      ,[InvestmentTypeGroupName], [isActive] FROM Reksa_MasterInvestmentTypeGroup" DeleteCommand="Update Reksa_MasterInvestmentTypeGroup set isActive=0 where Pid=@Pid" InsertCommand="Insert Into Reksa_MasterInvestmentTypeGroup (InvestmentType_Pid, InvestmentTypeGroupName, isActive) Values (@InvestmentType_Pid, @InvestmentTypeGroupName, @isActive); Select @Pid = SCOPE_IDENTITY();" UpdateCommand="Update Reksa_MasterInvestmentTypeGroup set InvestmentType_Pid=@InvestmentType_Pid, InvestmentTypeGroupName=@InvestmentTypeGroupName, isActive=@isActive where Pid=@Pid">
                        <DeleteParameters>
                            <asp:Parameter Name="Pid" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="InvestmentType_Pid" />
                            <asp:Parameter Name="InvestmentTypeGroupName" />
                            <asp:Parameter Name="isActive" />
                            <asp:Parameter Name="Pid" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="InvestmentType_Pid" />
                            <asp:Parameter Name="InvestmentTypeGroupName" />
                            <asp:Parameter Name="isActive" />
                            <asp:Parameter Name="Pid" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="dsCboInvestmentType" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT [Pid], [InvestmentType] FROM [Reksa_MasterInvestmentType] WHERE ([isActive] = @isActive)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="true" Name="isActive" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </div>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
