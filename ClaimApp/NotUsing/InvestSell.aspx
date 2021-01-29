<%@ Page Title="Penjualan" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="InvestSell.aspx.cs" Inherits="ClaimApp.InvestSell" %>

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
        }

        .UpperCaseStyle {
            text-transform: uppercase;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ScriptManager ID="SM" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="Upanel" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <h1>DAFTAR PEMBELIAN</h1>
                <ol class="breadcrumb">
                    <li><a href="Home.aspx">Home</a></li>
                    <li><a href="#">Transaksi</a></li>
                    <li class="active">Penjualan</li>
                </ol>
            </section>
            <section class="content">
                <div class="box box-primary">
                    <div class="box-body">
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
                                <Settings ShowHeaderFilterButton="true" />
                                <SettingsPager PageSize="15">
                                </SettingsPager>
                                <Columns>
                                    <%--<dx:BootstrapGridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                                    </dx:BootstrapGridViewCommandColumn>--%>
                                    <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="1" Visible="false">
                                        <SettingsEditForm Visible="False" />
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewDateColumn FieldName="TanggalBeli" VisibleIndex="2" PropertiesDateEdit-DisplayFormatString="dd-MMMMM-yyyy" HorizontalAlign="Center" PropertiesDateEdit-CalendarProperties-DayHeaderStyle-HorizontalAlign="Center" MaxWidth="100">
                                        <PropertiesDateEdit DisplayFormatString="dd-MMMMM-yyyy">
                                        </PropertiesDateEdit>
                                        <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                                    </dx:BootstrapGridViewDateColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Company_Initial" VisibleIndex="3" PropertiesTextEdit-DisplayFormatString="#,##.#0" Caption="Nama Perusahaan">
                                        <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewComboBoxColumn FieldName="InvestmentType" VisibleIndex="4" Caption="Jenis Investasi">
                                        <PropertiesComboBox DataSourceID="dsCboInvestmentType" TextField="InvestmentType" ValueField="Pid" ValueType="System.String"></PropertiesComboBox>
                                        <CssClasses HeaderCell="centerText"></CssClasses>
                                    </dx:BootstrapGridViewComboBoxColumn>
                                    <dx:BootstrapGridViewComboBoxColumn FieldName="InvestmentName" VisibleIndex="5" Caption="Produk Investasi">
                                        <PropertiesComboBox DataSourceID="dsCboInvestmentName" TextField="InvestmentName" ValueField="Pid" ValueType="System.String"></PropertiesComboBox>
                                        <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                                    </dx:BootstrapGridViewComboBoxColumn>
                                    <dx:BootstrapGridViewComboBoxColumn FieldName="CurrencyInitial" VisibleIndex="6" Caption="Mata Uang">
                                        <PropertiesComboBox DataSourceID="dsCboMataUang" TextField="CurrencyInitial" ValueField="Pid" ValueType="System.String"></PropertiesComboBox>
                                        <CssClasses HeaderCell="centerText" DataCell="centerText"></CssClasses>
                                    </dx:BootstrapGridViewComboBoxColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="KursValue" VisibleIndex="7" PropertiesTextEdit-DisplayFormatString="#,##.#0" Caption="Kurs">
                                        <Settings AllowHeaderFilter="False" />
                                        <PropertiesTextEdit DisplayFormatString="#,##.#0">
                                        </PropertiesTextEdit>
                                        <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Price" VisibleIndex="8" PropertiesTextEdit-DisplayFormatString="#,##.#0" Caption="Harga">
                                        <Settings AllowHeaderFilter="False" />
                                        <PropertiesTextEdit DisplayFormatString="#,##.#0">
                                        </PropertiesTextEdit>
                                        <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="UnitBeli" VisibleIndex="9" PropertiesTextEdit-DisplayFormatString="#,##.#0" Caption="Unit Beli">
                                        <Settings AllowHeaderFilter="False" />
                                        <PropertiesTextEdit DisplayFormatString="#,##.#0">
                                        </PropertiesTextEdit>
                                        <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="SisaUnit" VisibleIndex="10" PropertiesTextEdit-DisplayFormatString="#,##.#0" Caption="Sisa Unit">
                                        <Settings AllowHeaderFilter="False" />
                                        <PropertiesTextEdit DisplayFormatString="#,##.#0">
                                        </PropertiesTextEdit>
                                        <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewDataColumn VisibleIndex="11">
                                        <DataItemTemplate>
                                            <asp:HyperLink ID="linkSell" runat="server" NavigateUrl='<%# "InvestSell_Data.aspx?BuyPid=" + Eval("Pid") + "&SisaUnit=" + Eval("SisaUnit") %>' Target="_blank" CssClass="fa fa-sellsy" Text="&nbspJual" />
                                            <%--<a onclick="window.location='TodoListData.aspx?TRHeader_Pid=<%# Eval("TRHeader_Pid") %>&JobDetail_Pid=<%# Eval("JobDetail_Pid") %>&ClientCode=<%# Eval("ClientCode") %>';" href="javascript:void(0);"><i class="fa fa-plus-circle"></i><span>Submit Progress</span></a>--%>
                                        </DataItemTemplate>
                                        <CssClasses HeaderCell="centerText" DataCell="UpperCaseStyle"></CssClasses>
                                    </dx:BootstrapGridViewDataColumn>
                                </Columns>
                            </dx:BootstrapGridView>
                        </div>
                    </div>

                    <asp:SqlDataSource ID="dsGridBuy" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="select a.Pid,
       a.BuyDate as TanggalBeli,
       a.InvestmentName_Pid as InvestmentName,
	   a.Currency_Pid as CurrencyInitial,
	   KursValue,
	   Price,
       a.TotalUnit as UnitBeli,
	   Cast(a.TotalUnit - isnull((select distinct sum(TotalUnit) TotalJual from Reksa_TRSell zz where zz.TRBuy_Pid=a.Pid),0) as float) as SisaUnit,
	   f.Pid as InvestmentType,
       Company_Initial
from reksa_trbuy a
inner join Reksa_MasterInvestmentName b on a.InvestmentName_Pid=b.Pid
inner join Reksa_MasterCurrency c on a.Currency_Pid=c.Pid
inner join Reksa_MasterKurs d on a.Kurs_Pid=d.Pid
inner join Reksa_MasterPriceInvestment e on a.PriceInvestment_Pid=e.Pid
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>


