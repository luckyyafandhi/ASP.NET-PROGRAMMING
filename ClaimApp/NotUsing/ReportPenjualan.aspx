<%@ Page Title="List Penjualan" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ReportPenjualan.aspx.cs" Inherits="ClaimApp.ReportPenjualan" %>

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
        <h1>LIST PENJUALAN</h1>
        <ol class="breadcrumb">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Laporan</a></li>
            <li class="active">Penjualan</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-primary">
            <div class="box-body">
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
                    <dx:BootstrapGridView ID="gridBuy" runat="server" DataSourceID="dsGridBuy" AutoGenerateColumns="False" KeyFieldName="Pid" OnCustomColumnDisplayText="gridBuy_CustomColumnDisplayText">
                        <Settings ShowHeaderFilterButton="true" ShowFooter="True" />
                        <SettingsPager PageSize="15">
                        </SettingsPager>
                        <Columns>
                            <%--<dx:BootstrapGridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                                    </dx:BootstrapGridViewCommandColumn>--%>
                            <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="1" Visible="false">
                                <SettingsEditForm Visible="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Company_Initial" VisibleIndex="2" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Nama Perusahaan">
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewComboBoxColumn FieldName="InvestmentType" VisibleIndex="3" Caption="Jenis Investasi">
                                <PropertiesComboBox DataSourceID="dsCboInvestmentType" TextField="InvestmentType" ValueField="Pid" ValueType="System.String"></PropertiesComboBox>
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewComboBoxColumn>
                            <dx:BootstrapGridViewComboBoxColumn FieldName="InvestmentName" VisibleIndex="4" Caption="Produk Investasi" MinWidth="250">
                                <PropertiesComboBox DataSourceID="dsCboInvestmentName" TextField="InvestmentName" ValueField="Pid" ValueType="System.String"></PropertiesComboBox>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewComboBoxColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Transaction_Number" VisibleIndex="5" Caption="Nomor Transaksi">
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="TanggalJual" VisibleIndex="6" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy" HorizontalAlign="Center" PropertiesDateEdit-CalendarProperties-DayHeaderStyle-HorizontalAlign="Center" MaxWidth="100">
                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                </PropertiesDateEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="UnitJual" VisibleIndex="7" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Unit Jual">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Price" VisibleIndex="8" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Harga">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewComboBoxColumn FieldName="CurrencyInitial" VisibleIndex="9" Caption="Mata Uang">
                                <PropertiesComboBox DataSourceID="dsCboMataUang" TextField="CurrencyInitial" ValueField="Pid" ValueType="System.String"></PropertiesComboBox>
                                <CssClasses HeaderCell="centerText" DataCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewComboBoxColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Amount" VisibleIndex="10" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Amount">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="KursValue" VisibleIndex="11" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Kurs">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="TotalAmount" VisibleIndex="12" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Total Amount">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                             <dx:BootstrapGridViewTextColumn FieldName="UnitBeli" VisibleIndex="13" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Unit Beli">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="hargabeli" VisibleIndex="14" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Harga Beli">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="KursBeli" VisibleIndex="15" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Kurs Beli">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="NomorBeli" VisibleIndex="16" Caption="Nomor Transaksi Pembelian">
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                             <dx:BootstrapGridViewTextColumn FieldName="SisaUnit" VisibleIndex="17" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Sisa Unit">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LossGain" VisibleIndex="18" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Loss / Gain by Price" UnboundExpression="[Price] - [hargabeli]" UnboundType="Decimal">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LossGainKurs" VisibleIndex="19" PropertiesTextEdit-DisplayFormatString="{0:N}" Caption="Loss / Gain by Kurs" UnboundExpression="[KursValue] - [KursBeli]" UnboundType="Decimal">
                                <Settings AllowHeaderFilter="False" />
                                <PropertiesTextEdit DisplayFormatString="{0:N}">
                                </PropertiesTextEdit>
                                <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                        </Columns>
                        <SettingsExport FileName="Report Penjualan">
                        </SettingsExport>
                        <FormatConditions>
                            <dx:GridViewFormatConditionHighlight FieldName="LossGain" Expression="[Price] > [hargabeli]" Format="GreenFillWithDarkGreenText" />
                            <dx:GridViewFormatConditionHighlight FieldName="LossGain" Expression="[Price] < [hargabeli]" Format="LightRedFillWithDarkRedText" />
                            <dx:GridViewFormatConditionIconSet FieldName="LossGain" Format="PositiveNegativeTriangles" />
                            <dx:GridViewFormatConditionHighlight FieldName="LossGainKurs" Expression="[KursValue] > [KursBeli]" Format="GreenFillWithDarkGreenText" />
                            <dx:GridViewFormatConditionIconSet FieldName="LossGainKurs" Format="PositiveNegativeTriangles" />
                            <dx:GridViewFormatConditionHighlight FieldName="LossGainKurs" Expression="[KursValue] < [KursBeli]" Format="LightRedFillWithDarkRedText" />
                        </FormatConditions>
                        <TotalSummary>
                            <%-- <dx:ASPxSummaryItem FieldName="LossGain" SummaryType="Sum" ShowInColumn="LossGain" DisplayFormat="Total {0:N}" />
                            <dx:ASPxSummaryItem FieldName="LossGainKurs" SummaryType="Sum" ShowInColumn="LossGainKurs" DisplayFormat="Total {0:N}" />--%>
                            <dx:ASPxSummaryItem FieldName="TotalAmount" SummaryType="Sum" ShowInColumn="TotalAmount" DisplayFormat="Total {0:N}" />
                        </TotalSummary>
                    </dx:BootstrapGridView>
                </div>
            </div>

            <asp:SqlDataSource ID="dsGridBuy" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="select cv.Pid,
       cv.SellDate as TanggalJual,
       a.InvestmentName_Pid as InvestmentName,
	   cv.Currency_Pid as CurrencyInitial,
	   KursValue,
	   Price,
       cv.TotalUnit as UnitJual,
	   f.Pid as InvestmentType,
       Company_Initial,
	   Price * cv.TotalUnit as Amount,
	   Price * cv.TotalUnit * KursValue as TotalAmount,
	   (select Price from Reksa_MasterPriceInvestment xy where xy.pid=a.PriceInvestment_Pid and isActive=1) as hargabeli,
	   (select KursValue from Reksa_MasterKurs xy where xy.Pid=a.Kurs_Pid and isActive=1) as KursBeli,
	   Price - (select Price from Reksa_MasterPriceInvestment xy where xy.pid=a.PriceInvestment_Pid and isActive=1)  as LossGain,
	   KursValue - (select KursValue from Reksa_MasterKurs xy where xy.Pid=a.Kurs_Pid and isActive=1) as LossGainKurs, cv.Transaction_Number, a.Transaction_Number as NomorBeli,
       a.TotalUnit as UnitBeli, 
       a.Pid as BuyPid,
       Cast(a.TotalUnit - isnull((select distinct sum(TotalUnit) TotalJual from Reksa_TRSell zz where zz.TRBuy_Pid=a.Pid),0) as float) as SisaUnit
from reksa_trsell cv
inner join reksa_trbuy a on cv.TRBuy_Pid=a.pid
inner join Reksa_MasterInvestmentName b on a.InvestmentName_Pid=b.Pid
inner join Reksa_MasterCurrency c on cv.Currency_Pid=c.Pid
inner join Reksa_MasterKurs d on cv.Kurs_Pid=d.Pid
inner join Reksa_MasterPriceInvestment e on cv.PriceInvestment_Pid=e.Pid
inner join Reksa_MasterInvestmentType f on b.InvestmentType_Pid=f.Pid
inner join Reksa_MasterCompany g on b.Company_Pid=g.pid"></asp:SqlDataSource>

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
