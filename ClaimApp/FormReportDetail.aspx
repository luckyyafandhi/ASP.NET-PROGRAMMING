<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="FormReportDetail.aspx.cs" Inherits="ClaimApp.FormReportDetail" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <script type="text/javascript">
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
     <asp:ScriptManager ID="SM" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="Upanel" runat="server">
        <ContentTemplate>
    <section class="content-header">
        <h1>Dashboard</h1>
        <ol class="breadcrumb">
            <li><a href="Home.aspx">Dashboard</a></li>
            <li><a href="#">Report Detail</a></li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-primary">

            <div class="box-header with-border">
                <asp:Label ID="lbltext" runat="server" Text="Client Code : " CssClass="box-title"></asp:Label>
                <asp:Label ID="lblTitle" runat="server" Text="" CssClass="box-title"></asp:Label>
            </div>

            <div class="box-header with-border">
                <asp:HiddenField ID="hidClientCode" runat="server" />
                <dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" AlignItemCaptionsInAllGroups="True" ShowItemCaptionColon="False">
                    <Items>
                        <dx:BootstrapLayoutItem Caption="Client Name" ColSpanLg="6" HorizontalAlign="Left">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <h5><strong>
                                        <asp:Label ID="lblClientName" runat="server" Text=""></asp:Label></strong></h5>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                        <dx:BootstrapLayoutItem ColSpanLg="6" Caption="Policy No" FieldName="PolNo">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapComboBox ID="cbPolNo" runat="server" TextField="PolNo" ValueField="PolMainID" DataSourceID="DsClientCode" OnSelectedIndexChanged="cbPolNo_SelectedIndexChanged" AutoPostBack="true">
                                    </dx:BootstrapComboBox>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                    </Items>
                </dx:BootstrapFormLayout>
            </div>
            <asp:Panel runat="server" ID="pnlReportDetailAll">
                <div class="well">

                    <asp:Panel ID="pnlGVReportDetailDN" runat="server">
                        <div class="box-header with-border">
                            <div class="box-title">
                                <b>Asset Active</b>
                            </div>
                        </div>
                        <dx:BootstrapGridView ID="gridReportDetailDN" runat="server" AutoGenerateColumns="False" DataSourceID="dsGetReportClaimAppActive" KeyFieldName="PolID;ChassisNo;EngineNo">
                            <Settings ShowHeaderFilterButton="True" />
                            <SettingsDetail ShowDetailRow="true" />
                            <Columns>
                                <dx:BootstrapGridViewTextColumn FieldName="PolID" ReadOnly="True" VisibleIndex="1" Visible="false">
                                    <SettingsEditForm Visible="False" ShowCaption="False" />
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="ChassisNo" VisibleIndex="2">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="EngineNo" VisibleIndex="3">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="PoliceNo" VisibleIndex="4">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="Type" VisibleIndex="5">
                                </dx:BootstrapGridViewTextColumn>
                            </Columns>
                            <Templates>
                                <DetailRow>
                                    <dx:BootstrapGridView ID="gridRerportDetailDN_History" runat="server" AutoGenerateColumns="False" KeyFieldName="PolMainID" DataSourceID="dsClaimMotorVehicle_History"
                                        OnBeforePerformDataSelect="gridRerportDetailDN_History_BeforePerformDataSelect" OnCustomUnboundColumnData="gridRerportDetailDN_History_CustomUnboundColumnData">
                                        <Columns>
                                            <dx:BootstrapGridViewTextColumn FieldName="PolID" Caption="Pol ID" VisibleIndex="1" Visible="false">
                                                  <SettingsEditForm Visible="False" ShowCaption="False" />
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewTextColumn FieldName="InsuranceName" VisibleIndex="2" />
                                            <dx:BootstrapGridViewTextColumn FieldName="Workshop" VisibleIndex="3" />
                                            <dx:BootstrapGridViewDateColumn FieldName="DateOfLoss" VisibleIndex="4" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy">
                                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                                </PropertiesDateEdit>
                                            </dx:BootstrapGridViewDateColumn>
                                            <dx:BootstrapGridViewDateColumn FieldName="WorkshopEntryDate" VisibleIndex="5">
                                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                                </PropertiesDateEdit>
                                            </dx:BootstrapGridViewDateColumn>
                                            <dx:BootstrapGridViewDateColumn FieldName="RepairerEstimate" VisibleIndex="6">
                                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                                </PropertiesDateEdit>
                                            </dx:BootstrapGridViewDateColumn>
                                            <dx:BootstrapGridViewTextColumn FieldName="AmountApproved" VisibleIndex="7">
                                                <PropertiesTextEdit DisplayFormatString="#,###.#0">
                                                </PropertiesTextEdit>
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewTextColumn FieldName="TransactionNumber" VisibleIndex="8" />
                                            <dx:BootstrapGridViewDateColumn FieldName="SpkDate" VisibleIndex="9">
                                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                                </PropertiesDateEdit>
                                            </dx:BootstrapGridViewDateColumn>
                                            <dx:BootstrapGridViewTextColumn FieldName="ClaimDemage" VisibleIndex="10" />
                                        </Columns>
                                        <SettingsPager PageSize="5"></SettingsPager>
                                    </dx:BootstrapGridView>
                                </DetailRow>
                            </Templates>
                            <SettingsSearchPanel ShowClearButton="True" Visible="True" />
                        </dx:BootstrapGridView>

                    </asp:Panel>


                    <asp:Panel ID="pnlGVReportDetailCN" runat="server">
                        <div class="box-header with-border">
                            <div class="box-title">
                                <b>Asset InActive</b>
                            </div>
                        </div>
                        <dx:BootstrapGridView ID="gridReportDetailCN" runat="server" AutoGenerateColumns="False" KeyFieldName="PolID;ChassisNo;EngineNo" DataSourceID="dsReportClaimAppInActive">
                            <Settings ShowHeaderFilterButton="True" />
                            <SettingsDetail ShowDetailRow="true" />
                            <Columns>
                                <dx:BootstrapGridViewTextColumn FieldName="PolID" ReadOnly="True" VisibleIndex="1" Visible="false">
                                    <SettingsEditForm Visible="False" ShowCaption="False" />
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="ChassisNo" VisibleIndex="2">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="EngineNo" VisibleIndex="3">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="PoliceNo" VisibleIndex="4">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="Type" VisibleIndex="5">
                                </dx:BootstrapGridViewTextColumn>
                            </Columns>
                            <Templates>
                                <DetailRow>
                                    <dx:BootstrapGridView ID="gridRerportDetailCN_History" runat="server" AutoGenerateColumns="False" KeyFieldName="PolMainID" DataSourceID="dsClaimMotorVehicle_History"
                                        OnBeforePerformDataSelect="gridRerportDetailCN_History_BeforePerformDataSelect" OnCustomUnboundColumnData="gridRerportDetailCN_History_CustomUnboundColumnData">
                                        <Columns>
                                            <dx:BootstrapGridViewTextColumn FieldName="PolID" Caption="Pol ID" VisibleIndex="1" />
                                            <dx:BootstrapGridViewTextColumn FieldName="InsuranceName" VisibleIndex="2" />
                                            <dx:BootstrapGridViewTextColumn FieldName="Workshop" VisibleIndex="3" />
                                            <dx:BootstrapGridViewDateColumn FieldName="DateOfLoss" VisibleIndex="4" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy">
                                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                                </PropertiesDateEdit>
                                            </dx:BootstrapGridViewDateColumn>
                                            <dx:BootstrapGridViewDateColumn FieldName="WorkshopEntryDate" VisibleIndex="5">
                                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                                </PropertiesDateEdit>
                                            </dx:BootstrapGridViewDateColumn>
                                            <dx:BootstrapGridViewDateColumn FieldName="RepairerEstimate" VisibleIndex="6">
                                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                                </PropertiesDateEdit>
                                            </dx:BootstrapGridViewDateColumn>
                                            <dx:BootstrapGridViewTextColumn FieldName="AmountApproved" VisibleIndex="7">
                                                <PropertiesTextEdit DisplayFormatString="#,###.#0">
                                                </PropertiesTextEdit>
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewTextColumn FieldName="TransactionNumber" VisibleIndex="8" />
                                            <dx:BootstrapGridViewDateColumn FieldName="SpkDate" VisibleIndex="9">
                                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                                </PropertiesDateEdit>
                                            </dx:BootstrapGridViewDateColumn>
                                            <dx:BootstrapGridViewTextColumn FieldName="ClaimDemage" VisibleIndex="10" />
                                        </Columns>
                                        <SettingsPager PageSize="5"></SettingsPager>
                                    </dx:BootstrapGridView>
                                </DetailRow>
                            </Templates>
                            <SettingsSearchPanel ShowClearButton="True" Visible="True" />
                        </dx:BootstrapGridView>
                    </asp:Panel>
                </div>
            </asp:Panel>

        </div>
        <asp:SqlDataSource ID="dsClaimMotorVehicle_History" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringLive %>" SelectCommand="Select * from ClaimMotorVehicle_History Where PolMainID = @PolID and ChasisNumber = @ChassisNo and EngineNumber = @EngineNo Order By Pid DESC">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="PolID" SessionField="PolID" />
                <asp:SessionParameter DefaultValue="" Name="ChassisNo" SessionField="ChassisNo" />
                <asp:SessionParameter Name="EngineNo" SessionField="EngineNo" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsGetReportClaimAppActive" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringLive %>" SelectCommand="Select DISTINCT * from PolDetail_3_Temp Where PolID = @PolMainID and ProgramMode = 'DN'">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="PolMainID" SessionField="PolMainID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsReportClaimAppInActive" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringLive %>" SelectCommand="Select * From POLDetail_3_Temp Where PolID = @PolMainID and ProgramMode in ('CN','CC')">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="PolMainID" SessionField="PolMainID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DsClientCode" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionCoreLive %>" SelectCommand="select PolNo,PolMainID,ClientName from POLMain where ClientCode = @ClientCode and polto &gt;= cast(getdate() as date) 
and ClassCode = '3' and IntPolEnd = 000">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" QueryStringField="ClientCode" Name="ClientCode" />
            </SelectParameters>
        </asp:SqlDataSource>
    </section>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
