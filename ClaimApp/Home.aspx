<%@ Page Title="Home" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ClaimApp.Home" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <script type="text/javascript">
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">

    <section class="content-header">
        <h1>DASHBOARD</h1>
        <ol class="breadcrumb">
            <li><a href="Home.aspx">Dashboard</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-primary">
            <div class="well">
                <div class="table-responsive">
                    <dx:BootstrapCardView ClientInstanceName="cardView" runat="server" DataSourceID="dsTesting" KeyFieldName="ClientCode" AutoGenerateColumns="False">
                        <Columns>
                            <dx:BootstrapCardViewHyperLinkColumn FieldName="ClientCode">
                                <PropertiesHyperLinkEdit NavigateUrlFormatString="FormReportDetail.aspx?ClientCode={0}">
                                </PropertiesHyperLinkEdit>
                            </dx:BootstrapCardViewHyperLinkColumn>
                            <dx:BootstrapCardViewColumn FieldName="ClientName" />
                            <dx:BootstrapCardViewColumn FieldName="PolNo" />
                        </Columns>
                        <CardLayoutProperties>
                            <Items>
                                <dx:BootstrapCardViewColumnLayoutItem ColumnName="ClientCode" Caption="Client Code" />
                                <dx:BootstrapCardViewColumnLayoutItem ColumnName="ClientName" Caption="Nama Client" />
                                <dx:BootstrapCardViewColumnLayoutItem ColumnName="PolNo" Caption="Jumlah Policy" />
                            </Items>
                        </CardLayoutProperties>
                        <SettingsPager NumericButtonCount="6" ItemsPerPage="4">
                            <PageSizeItemSettings Visible="true" Items="4,8,16,32" />
                        </SettingsPager>
                        <SettingsLayout CardColSpanLg="6" CardColSpanSm="12" />

<StylesExport>
<Card BorderSize="1" BorderSides="All"></Card>

<Group BorderSize="1" BorderSides="All"></Group>

<TabbedGroup BorderSize="1" BorderSides="All"></TabbedGroup>

<Tab BorderSize="1"></Tab>
</StylesExport>

                        <SettingsSearchPanel ColumnNames="ClientCode" Visible="True" />

<SettingsExport ExportSelectedCardsOnly="False"></SettingsExport>
                    </dx:BootstrapCardView>
                </div>
            </div>
        </div>
    </section>
    <asp:SqlDataSource ID="dsTesting" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionCoreLive %>" SelectCommand="select  DISTINCT A.ClientCode,A.ClientName,(select count(PolNo) from POLMain where ClientCode = a.ClientCode And polto &gt;= cast(getdate() as date) 
and ClassCode = '3' and IntPolEnd = 000 ) as PolNo
from POLMain A where A.polto &gt;= cast(getdate() as date) 
and A.ClassCode = '3' and A.IntPolEnd = 000
group by  ClientCode, ClientName,PolNo
"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsCbClient" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionCoreLive %>" SelectCommand="select Distinct ClientCode,ClientName from POLMain 
Where PolTo &gt; GETDATE() and ClassCode='3'"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
