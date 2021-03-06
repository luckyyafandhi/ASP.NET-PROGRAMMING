﻿<%@ Page Title="List Pembelian" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ReportPembelian.aspx.cs" Inherits="ClaimApp.ReportPembelian" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <script type="text/javascript">
        function State_OnKeyUp(s, e) {
            s.SetText(s.GetText().toUpperCase());
        }
        function onSave(s, e) {
            var isValid = ASPxClientEdit.ValidateGroup('Validation');
            if (isValid) {
                popupSave.Show();
            }
        }

    </script>
    <style type="text/css">
        .centerText {
            text-align: center;
            text-transform: uppercase;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .UpperCaseStyle {
            text-transform: uppercase;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <%-- <asp:ScriptManager ID="SM" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="Upanel" runat="server">
        <ContentTemplate>--%>
    <section class="content-header">
        <h1>LIST PEMBELIAN</h1>
        <ol class="breadcrumb">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Laporan</a></li>
            <li class="active">Pembelian</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-primary">
            <div class="box-body">
                <div class="box-input" runat="server">
                    <div class="box-input">
                        <asp:Label ID="Label1" runat="server" Text="Pilih Periode" CssClass="box-title"></asp:Label>
                    </div>
                    <dx:BootstrapDateEdit ID="txtPeriod" runat="server" EditFormatString="dd-MMM-yyyy" DisplayFormatString="dd-MMM-yyyy" AutoPostBack="True" OnValueChanged="txtPeriod_ValueChanged"></dx:BootstrapDateEdit>
                </div>
                <div class="box-footer">
                    <div class="box-input">
                        <asp:Label ID="Label2" runat="server" Text="EXPORT TO" CssClass="box-title"></asp:Label>
                    </div>
                    <dx:BootstrapButton ID="Xls" runat="server" AutoPostBack="false" OnClick="Xls_Click" Text="XLS" Visible="false">
                        <CssClasses Icon="fa fa-file-excel-o" />
                    </dx:BootstrapButton>
                    <dx:BootstrapButton ID="Xlsx" runat="server" AutoPostBack="false" OnClick="Xlsx_Click" Text="XLSX">
                        <CssClasses Icon="fa fa-file-excel-o" />
                    </dx:BootstrapButton>
                    <dx:BootstrapButton ID="CSV" runat="server" AutoPostBack="false" OnClick="CSV_Click" Text="CSV">
                        <CssClasses Icon="fa fa-file" />
                    </dx:BootstrapButton>
                </div>
                <br />
                <div id="lblSuccess" class="alert alert-success alert-dismissable" runat="server" visible="false">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close" runat="server">&times;</a>
                    <div id="lblSuccessText" runat="server"></div>
                </div>
                <div id="lblError" class="alert alert-error alert-dismissable" runat="server" visible="false">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close" runat="server">&times;</a>
                    <div id="lblErrorText" runat="server"></div>
                </div>
                <asp:HiddenField ID="hidPID" runat="server" Value="0" />
                <asp:HiddenField ID="hidExit" runat="server" Value="1" />
                <asp:HiddenField ID="hidTransaction" runat="server" Value="0" />
                <div class="table-responsive">
                    <dx:BootstrapGridView ID="gridBuy" runat="server" DataSourceID="dsGridBuy" AutoGenerateColumns="False" KeyFieldName="Pid">
                        <Settings ShowHeaderFilterButton="true" ShowFooter="True" />
                        <SettingsBehavior AllowFocusedRow="True" />
                        <SettingsPager PageSize="15">
                            <PageSizeItemSettings Visible="True" />
                        </SettingsPager>
                        <Columns>
                            <%--<dx:BootstrapGridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                                    </dx:BootstrapGridViewCommandColumn>--%>
                            <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="1" Visible="false">
                                <SettingsEditForm Visible="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="SecuritasName" Caption="Securitas" VisibleIndex="2">
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Company_Initial" VisibleIndex="3" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Nama Perusahaan">
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewComboBoxColumn FieldName="InvestmentType" VisibleIndex="4" Caption="Jenis Investasi">
                                <PropertiesComboBox DataSourceID="dsCboInvestmentType" TextField="InvestmentType" ValueField="Pid" ValueType="System.String"></PropertiesComboBox>
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewComboBoxColumn>
                            <dx:BootstrapGridViewComboBoxColumn FieldName="InvestmentName" VisibleIndex="5" Caption="Produk Investasi" MinWidth="250">
                                <PropertiesComboBox DataSourceID="dsCboInvestmentName" TextField="InvestmentName" ValueField="Pid" ValueType="System.String"></PropertiesComboBox>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewComboBoxColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="NAB" Caption="NAB" VisibleIndex="6">
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="KursNAB" Caption="Kurs NAB" VisibleIndex="7">
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Transaction_Number" VisibleIndex="8" Caption="Nomor Transaksi">
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="BuyDate" VisibleIndex="9" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy" HorizontalAlign="Center" PropertiesDateEdit-CalendarProperties-DayHeaderStyle-HorizontalAlign="Center" MaxWidth="100">
                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                </PropertiesDateEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Beli" VisibleIndex="10" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Unit Beli">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="HargaAwalBulan" VisibleIndex="11" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Harga">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewComboBoxColumn FieldName="CurrencyInitial" VisibleIndex="12" Caption="Mata Uang">
                                <%--<PropertiesComboBox DataSourceID="dsCboMataUang" TextField="CurrencyInitial" ValueField="Pid" ValueType="System.String"></PropertiesComboBox>--%>
                                <CssClasses HeaderCell="centerText" DataCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewComboBoxColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="AmountBuy" VisibleIndex="13" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Amount">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="AdminFee" VisibleIndex="14" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Biaya Admin">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="KursAwalBulan" VisibleIndex="15" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Kurs">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="TotalAmountBuy" VisibleIndex="16" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Total Amount">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LastPrice" VisibleIndex="17" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Harga Penutupan">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LastKurs" VisibleIndex="18" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Kurs Penutupan">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LossProfitValueByPrice" VisibleIndex="19" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Loss / Gain by Price" UnboundExpression="[LastPrice] - [Price]" UnboundType="Decimal">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LossProfitValueByKurs" VisibleIndex="20" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Loss / Gain by Kurs" UnboundExpression="[LastKurs] - [Kurs]" UnboundType="Decimal">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Saldo" VisibleIndex="21" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Sisa Unit">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="UnrealizeGain" VisibleIndex="22" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Unrealize Gains">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Forex" VisibleIndex="23" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Forex Gains">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LastBalanceByBuyPrice" VisibleIndex="24" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Last Amount">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LastBalanceByLastPrice" VisibleIndex="25" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Last Total Amount">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                        </Columns>
                        <SettingsExport FileName="Report Pembelian">
                        </SettingsExport>
                        <FormatConditions>
                            <dx:GridViewFormatConditionHighlight FieldName="InvestmentName" Expression="[LastBalanceByLastPrice] > [LastBalanceByBuyPrice]" Format="GreenFillWithDarkGreenText" ApplyToRow="false" />
                            <dx:GridViewFormatConditionHighlight FieldName="InvestmentName" Expression="[LastBalanceByLastPrice] < [LastBalanceByBuyPrice]" Format="LightRedFillWithDarkRedText" ApplyToRow="false" />
                            <%--<dx:GridViewFormatConditionHighlight FieldName="InvestmentName" Expression="[LastBalanceByLastPrice] =LastBalanceByBuyPrice]" Format="YellowFillWithDarkYellowText" ApplyToRow="false"/>--%>
                            <dx:GridViewFormatConditionIconSet FieldName="UnrealizeGain" Format="Symbols3Uncircled" />
                            <dx:GridViewFormatConditionHighlight FieldName="LossProfitValueByKurs" Expression="[KursJual] > [KursValue]" Format="GreenFillWithDarkGreenText" />
                            <%--<dx:GridViewFormatConditionIconSet FieldName="LastBalanceByLastPrice" Format="PositiveNegativeTriangles" />--%>
                            <dx:GridViewFormatConditionHighlight FieldName="LossProfitValueByKurs" Expression="[KursJual] < [KursValue]" Format="LightRedFillWithDarkRedText" />
                        </FormatConditions>
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="LastBalanceByBuyPrice" SummaryType="Sum" ShowInColumn="LastBalanceByBuyPrice" DisplayFormat="Total {0:N}" />
                            <dx:ASPxSummaryItem FieldName="LastBalanceByLastPrice" SummaryType="Sum" ShowInColumn="LastBalanceByLastPrice" DisplayFormat="Total {0:N}" />
                            <dx:ASPxSummaryItem FieldName="UnrealizeGain" SummaryType="Sum" ShowInColumn="UnrealizeGain" DisplayFormat="Total {0:N}" />
                            <dx:ASPxSummaryItem FieldName="Forex" SummaryType="Sum" ShowInColumn="Forex" DisplayFormat="Total {0:N}" />
                            <dx:ASPxSummaryItem FieldName="TotalAmountBuy" SummaryType="Sum" ShowInColumn="TotalAmountBuy" DisplayFormat="Total {0:N}" />
                        </TotalSummary>
                    </dx:BootstrapGridView>
                </div>
            </div>

            <asp:SqlDataSource ID="dsGridBuy" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="sp_Reksa_GetReportInvestAll" SelectCommandType="StoredProcedure" OnSelecting="dsGridBuy_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="BuyDate" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsCboInvestmentType" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT [Pid], [InvestmentType] FROM [Reksa_MasterInvestmentType] WHERE ([isActive] = @isActive)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="true" Name="isActive" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsCboMataUang" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT [Pid], [CurrencyInitial] FROM [Reksa_MasterCurrency] WHERE ([isActive] = @isActive)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="true" Name="isActive" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsCboInvestmentName" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT [Pid], [InvestmentName] FROM [Reksa_MasterInvestmentName] WHERE ([isActive] = @isActive)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="true" Name="isActive" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </section>

    <dx:BootstrapPopupControl ID="popupSave" ClientInstanceName="popupSave" runat="server" CloseAction="CloseButton" CloseOnEscape="True" Modal="True" Text="Simpan Perubahan?" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" HeaderText="Pembelian" SettingsAdaptivity-Mode="Always">
        <ContentCollection>
            <dx:ContentControl runat="server">
                <div class="p-15 text-center">
                    <dx:BootstrapButton ID="btnSaveYes" ClientInstanceName="btnSaveYes" runat="server" AutoPostBack="False" Text="Yes" OnClick="btnSaveYes_Click">
                        <CssClasses Icon="fa fa-check" />
                        <SettingsBootstrap RenderOption="Success" />
                        <ClientSideEvents Click="function(s, e) {
	    $('#bodyPlaceHolder_btnSave').button('loading');
    popupSave.Hide();
    e.processOnServer = true;
    }" />
                    </dx:BootstrapButton>
                    <dx:BootstrapButton ID="btnSaveNo" ClientInstanceName="btnSaveNo" runat="server" AutoPostBack="false" Text="No">
                        <CssClasses Control="m-l-10" Icon="fa fa-times" />
                        <SettingsBootstrap RenderOption="Danger" />
                        <ClientSideEvents Click="function(s, e) {
	    popupSave.Hide();
    }" />
                    </dx:BootstrapButton>
                </div>
            </dx:ContentControl>
        </ContentCollection>
    </dx:BootstrapPopupControl>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
