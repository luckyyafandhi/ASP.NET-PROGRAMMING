﻿<%@ Page Title="Laporan Reksadana" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ReportReksa.aspx.cs" Inherits="ClaimApp.ReportReksa" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <section class="content-header">
        <h1>LAPORAN REKSADANA</h1>
        <ol class="breadcrumb">
            <li><a href="Home.aspx">Home</a></li>
            <li class="#">Laporan</li>
            <li class="Active">Reksadana</li>
        </ol>
    </section>
    <section class="content" id="GeneralSect" runat="server">
        <div class="box box-primary">
            <div class="box-body">
                <div class="box-input" runat="server">
                    <div class="box-input">
                        <asp:Label ID="Label1" runat="server" Text="Pilih Perusahaan" CssClass="box-title"></asp:Label>
                    </div>
                    <dx:BootstrapComboBox ID="cboCompany" runat="server" DataSourceID="dsCBOCompany" TextField="Company_Name" ValueField="Pid" ValueType="System.Int32" OnSelectedIndexChanged="cboCompany_SelectedIndexChanged" AutoPostBack="True" Width="300px"></dx:BootstrapComboBox>
                </div>
                <br />
                <div class="table-responsive">
                    <dx:BootstrapGridView ID="gridReportReksa" runat="server" AutoGenerateColumns="False" DataSourceID="dsGridReportReksa" KeyFieldName="pid">
                        <Columns>
                            <dx:BootstrapGridViewTextColumn FieldName="pid" ReadOnly="True" VisibleIndex="0" Visible="false">
                                <SettingsEditForm Visible="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="InvestmentName" VisibleIndex="1">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="TanggalBeli" ReadOnly="True" VisibleIndex="2" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy">
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="CurrencyInitial" VisibleIndex="3">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="KursValue" VisibleIndex="4">
                                <PropertiesTextEdit DisplayFormatString="#,##.##"></PropertiesTextEdit>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="price" VisibleIndex="5">
                                <PropertiesTextEdit DisplayFormatString="#,##.##"></PropertiesTextEdit>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="TotalUnit" VisibleIndex="6">
                                <PropertiesTextEdit DisplayFormatString="#,##.##"></PropertiesTextEdit>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="TotalAmount" ReadOnly="True" VisibleIndex="7">
                                <PropertiesTextEdit DisplayFormatString="#,##.##"></PropertiesTextEdit>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="TanggalJual" ReadOnly="True" VisibleIndex="8" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy">
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="CurrencyJual" ReadOnly="True" VisibleIndex="9">

                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="KursJual" ReadOnly="True" VisibleIndex="10">
                                <PropertiesTextEdit DisplayFormatString="#,##.##"></PropertiesTextEdit>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="PriceJual" ReadOnly="True" VisibleIndex="11">
                                <PropertiesTextEdit DisplayFormatString="#,##.##"></PropertiesTextEdit>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="TotalUnitJual" ReadOnly="True" VisibleIndex="12">
                                <PropertiesTextEdit DisplayFormatString="#,##.##"></PropertiesTextEdit>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="TotalAmountJual" ReadOnly="True" VisibleIndex="13">
                                <PropertiesTextEdit DisplayFormatString="#,##.##"></PropertiesTextEdit>
                            </dx:BootstrapGridViewTextColumn>
                        </Columns>
                    </dx:BootstrapGridView>
                </div>
            </div>
        </div>
        <asp:SqlDataSource ID="dsGridReportReksa" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="select b.pid,
	   InvestmentName, 
	   cast(b.Cdatetime as date) as TanggalBeli,
	   CurrencyInitial,
	   KursValue,
	   price,
	   TotalUnit,
	   (KursValue * Price * TotalUnit) as TotalAmount,
	   (select cdatetime from Reksa_TRSell x where x.TRBuy_Pid = b.pid) as TanggalJual,
	   (select CurrencyInitial from Reksa_TRSell x 
		 inner join reksa_mastercurrency y on x.Currency_Pid=y.Pid where x.TRBuy_Pid = b.pid) as CurrencyJual,
	   (select KursValue from Reksa_TRSell x 
		 inner join Reksa_MasterKurs y on x.Kurs_Pid=y.Pid where x.TRBuy_Pid = b.pid) as KursJual,
	   (select Price from Reksa_TRSell x 
		 inner join Reksa_MasterPriceInvestment y on x.PriceInvestment_Pid=y.Pid where x.TRBuy_Pid = b.pid) as PriceJual,
	   (select TotalUnit from Reksa_TRSell x where x.TRBuy_Pid = b.pid) as TotalUnitJual,
	   (select (KursValue * Price * TotalUnit) from Reksa_TRSell x 
		 inner join Reksa_MasterPriceInvestment y on x.PriceInvestment_Pid=y.Pid 
		 inner join Reksa_MasterKurs z on x.Kurs_Pid=z.Pid
		 inner join reksa_mastercurrency w on x.Currency_Pid=w.Pid
		 where x.TRBuy_Pid = b.pid) as TotalAmountJual
from Reksa_MasterInvestmentName a
inner join Reksa_TRBuy b on a.Pid=b.InvestmentName_Pid
inner join Reksa_MasterCurrency c on b.Currency_Pid=c.Pid
inner join Reksa_MasterKurs d on b.Kurs_Pid = d.Pid
inner join Reksa_MasterPriceInvestment e on b.PriceInvestment_Pid=e.Pid
where a.Company_Pid=@Company_Pid">
            <SelectParameters>
                <asp:ControlParameter ControlID="cboCompany" DefaultValue="0" Name="Company_Pid" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsCBOCompany" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT [Pid], [Company_Name] FROM [Reksa_MasterCompany] WHERE ([isActive] = @isActive)">
            <SelectParameters>
                <asp:Parameter DefaultValue="true" Name="isActive" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
