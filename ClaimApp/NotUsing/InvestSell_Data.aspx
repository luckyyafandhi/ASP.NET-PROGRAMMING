<%@ Page Title="Penjualan" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="InvestSell_Data.aspx.cs" Inherits="ClaimApp.InvestSell_Data" %>

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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ScriptManager ID="SM" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="Upanel" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <h1>PENJUALAN</h1>
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
                        <dx:BootstrapFormLayout ID="bfl1" runat="server" ShowItemCaptionColon="False" AlignItemCaptionsInAllGroups="True" LayoutType="Vertical">
                            <Items>
                                <dx:BootstrapLayoutItem FieldName="TglJual" Caption="Tanggal Penjualan" ColSpanMd="12">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapDateEdit ID="txtTglJual" runat="server" DisplayFormatString="dd-MMM-yyyy" AutoPostBack="true" EditFormatString="dd-MMM-yyyy">
                                                <ValidationSettings ValidationGroup="Validation">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="NamaInvestasi" Caption="Nama Investasi" ColSpanMd="12">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox ID="cboInvestName" runat="server" DataSourceID="dsCboInvestName" TextField="InvestName" ValueField="Pid" ValueType="System.Int32" AutoPostBack="true" SelectedIndex="0">
                                                <ValidationSettings ValidationGroup="Validation">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="MataUang" Caption="Inisial Mata Uang" ColSpanMd="12">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox ID="cboCurrency" runat="server" DataSourceID="dsCboCurrency" TextField="CurrencyInitial" ValueField="Pid" ValueType="System.Int32" AutoPostBack="true">
                                                <ValidationSettings ValidationGroup="Validation">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="Kurs" Caption="Kurs" ColSpanMd="12">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox ID="cboKurs" runat="server" DataSourceID="dsCboKurs" TextField="KursValue" ValueField="Pid" ValueType="System.Int32" AutoPostBack="true" DisplayFormatString="#,##.#0">
                                                <ValidationSettings ValidationGroup="Validation">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="Harga" Caption="Harga" ColSpanMd="12">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox ID="cboPrice" runat="server" DataSourceID="dsCboPrice" TextField="Price" ValueField="Pid" ValueType="System.Int32" AutoPostBack="true" DisplayFormatString="#,##.#0">
                                                <ValidationSettings ValidationGroup="Validation">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="Rate" Caption="Rate" ColSpanMd="12">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtRate" runat="server" DisplayFormatString="##.#00">
                                                <ValidationSettings ValidationGroup="Validation">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="UnitBeli" Caption="Sisa Unit" ColSpanMd="12">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtSisaUnit" runat="server" DisplayFormatString="{0:n0}" Enabled="false">
                                            </dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="Unit" Caption="Unit" ColSpanMd="12">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtUnit" runat="server" DisplayFormatString="{0:n0}" OnTextChanged="txtUnit_TextChanged">
                                                <ValidationSettings ValidationGroup="Validation" SetFocusOnError="True">
                                                    <RequiredField IsRequired="true" />
                                                </ValidationSettings>
                                            </dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="btn" Caption="" HorizontalAlign="Right" ColSpanMd="12">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapButton ID="btnSave" runat="server" AutoPostBack="False" Text="Save" OnClick="btnSave_Click">
                                                <CssClasses Icon="fa fa-save" />
                                                <SettingsBootstrap RenderOption="Success" />
                                                <ClientSideEvents Click="onSave" />
                                            </dx:BootstrapButton>
                                            <dx:BootstrapButton ID="btnClose" runat="server" AutoPostBack="false" Text="Close" CausesValidation="False" UseSubmitBehavior="False" OnClick="btnClose_Click">
                                                <CssClasses Icon="fa fa-sign-out" />
                                            </dx:BootstrapButton>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                            </Items>
                        </dx:BootstrapFormLayout>
                    </div>

                    <asp:SqlDataSource ID="dsGridBuy" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT [Pid]
      ,[InvestmentName_Pid]
      ,[Currency_Pid]
      ,[Price]
      ,[CdateTime]
      ,[isActive]
FROM [Reksa_MasterPriceInvestment]"
                        DeleteCommand="Update [Reksa_MasterPriceInvestment] set isActive=0, Cdatetime=getdate() where Pid=@Pid" InsertCommand="Insert Into [Reksa_MasterPriceInvestment] (InvestmentName_Pid, Currency_Pid, Price, isActive) Values (@InvestmentName_Pid, @Currency_Pid, @Price, @isActive); Select @Pid = SCOPE_IDENTITY();" UpdateCommand="Update [Reksa_MasterPriceInvestment] set InvestmentName_Pid=@InvestmentName_Pid,Currency_Pid=@Currency_Pid, Price=@Price, isActive=@isActive, Cdatetime=getdate() where Pid=@Pid">
                        <DeleteParameters>
                            <asp:Parameter Name="Pid" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="InvestmentName_Pid" />
                            <asp:Parameter Name="Currency_Pid" />
                            <asp:Parameter Name="Price" />
                            <asp:Parameter Name="isActive" />
                            <asp:Parameter Name="Pid" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="InvestmentName_Pid" />
                            <asp:Parameter Name="Currency_Pid" />
                            <asp:Parameter Name="Price" />
                            <asp:Parameter Name="isActive" />
                            <asp:Parameter Name="Pid" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="dsCboCurrency" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT distinct a.[Pid], [CurrencyInitial] FROM [Reksa_MasterCurrency] a inner join Reksa_MasterPriceInvestment b on a.pid=b.Currency_Pid WHERE (a.[isActive] = @isActive and b.InvestmentName_Pid=@InvestmentName_Pid)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$bfl1$cboInvestName" DefaultValue="0" Name="InvestmentName_Pid" PropertyName="Value" Type="Int64" />
                            <asp:Parameter DefaultValue="true" Name="isActive" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="dsCboInvestName" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT a.[Pid], upper([InvestmentName] + ' - ' + Company_initial) as InvestName FROM [Reksa_MasterInvestmentName] a 
inner join reksa_mastercompany b on a.Company_Pid=b.pid 
inner join Reksa_TRBuy c on c.InvestmentName_Pid=a.Pid
WHERE c.Pid=@Pid">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="0" Name="Pid" QueryStringField="BuyPid" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="dsCboKurs" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT top 1 [Pid], [KursValue] FROM [Reksa_MasterKurs] WHERE (([Currency_Pid] = @Currency_Pid) AND ([isActive] = @isActive) and EffectiveDate=@EffectiveDate) ORDER BY [Cdatetime] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$bfl1$cboCurrency" DefaultValue="0" Name="Currency_Pid" PropertyName="Value" Type="Int64" />
                            <asp:Parameter DefaultValue="true" Name="isActive" Type="Boolean" />
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$bfl1$txtTglJual" DefaultValue="1900-01-01" Name="EffectiveDate" PropertyName="Value" Type="DateTime" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsCboPrice" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="SELECT a.[Pid], Price FROM [Reksa_MasterPriceInvestment] a WHERE (a.[isActive] = @isActive and InvestmentName_Pid=@InvestmentName_Pid and Currency_Pid=@Currency_Pid and a.EffectiveDate=@EffectiveDate) order by Cdatetime desc">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="true" Name="isActive" Type="Boolean" />
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$bfl1$cboInvestName" DefaultValue="0" Name="InvestmentName_Pid" PropertyName="Value" Type="Int64" />
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$bfl1$cboCurrency" DefaultValue="0" Name="Currency_Pid" PropertyName="Value" Type="Int64" />
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$bfl1$txtTglJual" DefaultValue="1900-01-01" Name="EffectiveDate" PropertyName="Value" Type="DateTime" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </div>
            </section>

            <dx:BootstrapPopupControl ID="popupSave" ClientInstanceName="popupSave" runat="server" CloseAction="CloseButton" CloseOnEscape="True" Modal="True" Text="Simpan Perubahan?" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" HeaderText="Penjualan" SettingsAdaptivity-Mode="Always">
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


