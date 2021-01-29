﻿<%@ Page Title="Harga Investasi" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SetupPrice.aspx.cs" Inherits="ClaimApp.SetupPrice" %>

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
                <h1>HARGA INVESTASI</h1>
                <ol class="breadcrumb">
                    <li><a href="Home.aspx">Home</a></li>
                    <li><a href="#">Master</a></li>
                    <li class="active">Harga Investasi</li>
                </ol>
            </section>
            <section class="content">
                <div class="box box-primary">
                    <div class="box-body">
                        <asp:HiddenField ID="hidPID" runat="server" Value="0" />
                        <asp:HiddenField ID="hidExit" runat="server" Value="1" />
                        <asp:HiddenField ID="hidTransaction" runat="server" Value="0" />
                        <div class="table-responsive">
                            <dx:BootstrapGridView ID="gridPrice" runat="server" DataSourceID="dsGridPrice" AutoGenerateColumns="False" KeyFieldName="Pid">
                                <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                                <Settings ShowHeaderFilterButton="True" />
                                <SettingsEditing Mode="PopupEditForm">
                                    <FormLayoutProperties LayoutType="Vertical">
                                        <Items>
                                            <dx:BootstrapGridViewColumnLayoutItem ColumnName="InvestmentName_Pid" ColSpanMd="12" Caption="Nama Investasi">
                                            </dx:BootstrapGridViewColumnLayoutItem>
                                            <dx:BootstrapGridViewColumnLayoutItem ColumnName="Currency_Pid" ColSpanMd="12" Caption="Inisial Mata Uang">
                                            </dx:BootstrapGridViewColumnLayoutItem>
                                            <dx:BootstrapGridViewColumnLayoutItem ColumnName="Price" ColSpanMd="12" Caption="Harga">
                                            </dx:BootstrapGridViewColumnLayoutItem>
                                            <dx:BootstrapGridViewColumnLayoutItem ColumnName="EffectiveDate" ColSpanMd="12" Caption="Tanggal Efektif">
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
                                    <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" Width="50" MaxWidth="50">
                                    </dx:BootstrapGridViewCommandColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="1" Width="50" MaxWidth="50" Visible="false">
                                        <SettingsEditForm Visible="False" />
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewComboBoxColumn FieldName="InvestmentName_Pid" VisibleIndex="2" Caption="Nama Investasi">
                                        <PropertiesComboBox DataSourceID="dsCboInvestName" TextField="InvestName" ValueField="Pid" ValueType="System.Int32">
                                             <ValidationSettings>
                                                 <RequiredField IsRequired="true" />
                                             </ValidationSettings>
                                        </PropertiesComboBox>
                                    </dx:BootstrapGridViewComboBoxColumn>
                                    <dx:BootstrapGridViewComboBoxColumn FieldName="Currency_Pid" VisibleIndex="3" Caption="Inisial Mata Uang">
                                         <PropertiesComboBox DataSourceID="dsCboCurrency" TextField="CurrencyInitial" ValueField="Pid" ValueType="System.Int32">
                                              <ValidationSettings>
                                                 <RequiredField IsRequired="true" />
                                             </ValidationSettings>
                                         </PropertiesComboBox>
                                    </dx:BootstrapGridViewComboBoxColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Price" VisibleIndex="4" Caption="Harga">
                                        <PropertiesTextEdit DisplayFormatString="#,###.#0">
                                            <ValidationSettings>
                                                <RequiredField IsRequired="true" />
                                            </ValidationSettings>
                                        </PropertiesTextEdit>
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewDateColumn FieldName="EffectiveDate" VisibleIndex="5" Caption="Tanggal Efektif" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy">
                                        <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                        </PropertiesDateEdit>
                                    </dx:BootstrapGridViewDateColumn>
                                    <dx:BootstrapGridViewDateColumn FieldName="CdateTime" VisibleIndex="6" Caption="Terakhir Update" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy">
                                        <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                        </PropertiesDateEdit>
                                    </dx:BootstrapGridViewDateColumn>
                                    <dx:BootstrapGridViewCheckColumn FieldName="isActive" VisibleIndex="7" Caption="Status Aktif">
                                    </dx:BootstrapGridViewCheckColumn>
                                </Columns>
                            </dx:BootstrapGridView>
                        </div>
                    </div>

                    <asp:SqlDataSource ID="dsGridPrice" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT [Pid]
      ,[InvestmentName_Pid]
      ,[Currency_Pid]
      ,[Price]
      ,[CdateTime]
      ,[isActive]
      ,[EffectiveDate]
FROM [Reksa_MasterPriceInvestment]" DeleteCommand="Update [Reksa_MasterPriceInvestment] set isActive=0, Cdatetime=getdate() where Pid=@Pid" InsertCommand="Insert Into [Reksa_MasterPriceInvestment] (InvestmentName_Pid, Currency_Pid, Price, isActive, EffectiveDate) Values (@InvestmentName_Pid, @Currency_Pid, @Price, @isActive, @EffectiveDate); Select @Pid = SCOPE_IDENTITY();" UpdateCommand="Update [Reksa_MasterPriceInvestment] set InvestmentName_Pid=@InvestmentName_Pid,Currency_Pid=@Currency_Pid, Price=@Price, isActive=@isActive, Cdatetime=getdate(), EffectiveDate=@EffectiveDate where Pid=@Pid">
                        <DeleteParameters>
                            <asp:Parameter Name="Pid" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="InvestmentName_Pid" />
                            <asp:Parameter Name="Currency_Pid" />
                            <asp:Parameter Name="Price" />
                            <asp:Parameter Name="isActive" />
                            <asp:Parameter Name="Pid" />
                            <asp:Parameter Name="EffectiveDate" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="InvestmentName_Pid" />
                            <asp:Parameter Name="Currency_Pid" />
                            <asp:Parameter Name="Price" />
                            <asp:Parameter Name="isActive" />
                            <asp:Parameter Name="Pid" />
                            <asp:Parameter Name="EffectiveDate" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="dsCboCurrency" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT [Pid], [CurrencyInitial] FROM [Reksa_MasterCurrency] WHERE ([isActive] = @isActive)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="true" Name="isActive" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="dsCboInvestName" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT a.[Pid], upper([InvestmentName] + ' - ' + Company_initial) as InvestName FROM [Reksa_MasterInvestmentName] a inner join reksa_mastercompany b on a.Company_Pid=b.pid WHERE (a.[isActive] = @isActive)">
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