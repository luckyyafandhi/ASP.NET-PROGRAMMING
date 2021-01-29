<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ClaimMV_Manual.aspx.cs" Inherits="ClaimApp.ClaimManual" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <script type="text/javascript">
        function btNewData(s, e) {

        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">

    <section class="content-header">
        <h1>CLAIM MOTOR VEHICLE</h1>
        <ol class="breadcrumb">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Transaction</a></li>
            <li class="active">Claim Manual</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-primary">
            <div class="box-footer">
                <dx:BootstrapButton ID="btNew" runat="server" AutoPostBack="false" Text="New Claim" CausesValidation="False" UseSubmitBehavior="False" OnClick="btNew_Click">
                    <SettingsBootstrap RenderOption="Info" />
                    <ClientSideEvents Click="btNewData" />
                    <CssClasses Icon="fa fa-plus-square" />
                </dx:BootstrapButton>
            </div>
            <div class="box-body">
                <fieldset>
                    <div class="table-responsive">
                        <dx:BootstrapGridView ID="gridClaimMotorVehicle" runat="server" AutoGenerateColumns="False" KeyFieldName="Pid" DataSourceID="dsClaimManual">
                            <Settings ShowHeaderFilterButton="True" />
                            <SettingsPager EnableAdaptivity="True">
                            <PageSizeItemSettings Position="Left" Visible="True" />
                        </SettingsPager>
                            <Columns>
                                <dx:BootstrapGridViewDataColumn VisibleIndex="0" MinWidth="250" Caption="Action">
                                    <DataItemTemplate>
                                        <a onclick="window.location='ClaimMV_ManualData.aspx?Pid=<%# Eval("Pid") %>';" href="javascript:void(0);"><i class="fa fa-pencil-square"></i>&nbsp;&nbsp;Edit Claim</a>
                                    </DataItemTemplate>
                                </dx:BootstrapGridViewDataColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="1" Visible="false">
                                    <SettingsEditForm Visible="False" ShowCaption="False" />
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="Workshop" HorizontalAlign="Center" CssClasses-HeaderCell="centerText" VisibleIndex="9" MinWidth="250">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewDateColumn FieldName="DateOfLoss" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy" MinWidth="250" HorizontalAlign="Center" CssClasses-HeaderCell="centerText" VisibleIndex="8">
                                    <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                    </PropertiesDateEdit>
                                </dx:BootstrapGridViewDateColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="PoliceNumber" HorizontalAlign="Center" CssClasses-HeaderCell="centerText" VisibleIndex="5" MinWidth="250">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="VehicleModel" HorizontalAlign="Center" CssClasses-HeaderCell="centerText" VisibleIndex="4" MinWidth="250">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewDateColumn FieldName="WorkshopEntryDate" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy" MinWidth="250" HorizontalAlign="Center" CssClasses-HeaderCell="centerText" VisibleIndex="10">
                                    <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                    </PropertiesDateEdit>
                                </dx:BootstrapGridViewDateColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="AmountApproved" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText" VisibleIndex="11">
                                    <PropertiesTextEdit DisplayFormatString="#,###.#0">
                                    </PropertiesTextEdit>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="RepairingStatus" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText" VisibleIndex="13">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="TransactionNumber" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText" VisibleIndex="14" ReadOnly="True">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewComboBoxColumn FieldName="PolicyNo" Name="PolicyNo" VisibleIndex="3" MinWidth="250" HorizontalAlign="Center" CssClasses-HeaderCell="centerText">
                                    <%-- <PropertiesComboBox DataSourceID="dsCbPolicyNo" TextField="PolNo" ValueField="PolNo" EnableSynchronization="False"
                                    IncrementalFilteringMode="StartsWith">
                                </PropertiesComboBox>--%>
                                    <Settings AllowFilterBySearchPanel="True" />
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewComboBoxColumn FieldName="InsuranceName" VisibleIndex="2" MinWidth="250" HorizontalAlign="Center" CssClasses-HeaderCell="centerText">
                                    <PropertiesComboBox TextField="Name" ValueField="Name">
                                    </PropertiesComboBox>
                                    <Settings AllowFilterBySearchPanel="True" />
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewComboBoxColumn FieldName="ChasisNumber" VisibleIndex="6" MinWidth="250" HorizontalAlign="Center" CssClasses-HeaderCell="centerText">
                                    <PropertiesComboBox TextField="ChassisNo" ValueField="ChassisNo">
                                    </PropertiesComboBox>
                                    <Settings AllowFilterBySearchPanel="True" />
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewComboBoxColumn FieldName="EngineNumber" MinWidth="250" VisibleIndex="7" HorizontalAlign="Center" CssClasses-HeaderCell="centerText">
                                    <PropertiesComboBox TextField="EngineNo" ValueField="EngineNo">
                                    </PropertiesComboBox>
                                    <Settings AllowFilterBySearchPanel="True" />
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewDateColumn FieldName="SpkDate" MinWidth="250" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy" VisibleIndex="12" HorizontalAlign="Center" CssClasses-HeaderCell="centerText">
                                    <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy">
                                    </PropertiesDateEdit>
                                </dx:BootstrapGridViewDateColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="DivName" MinWidth="250" HorizontalAlign="Center" CssClasses-HeaderCell="centerText" VisibleIndex="14">
                                </dx:BootstrapGridViewTextColumn>
                            </Columns>
                            <SettingsSearchPanel ShowClearButton="True" Visible="True" />
                            <SettingsResizing ColumnResizeMode="Control" />
                        </dx:BootstrapGridView>
                    </div>
                </fieldset>
            </div>
        </div>
        <asp:SqlDataSource ID="dsClaimManual" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringLive %>" SelectCommand="SELECT * FROM [ClaimMotorVehicle]"></asp:SqlDataSource>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
