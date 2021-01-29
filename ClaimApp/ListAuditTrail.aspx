<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ListAuditTrail.aspx.cs" Inherits="ClaimApp.ListAuditTrail" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <section class="content-header">
        <h1>List Audit & Trail</h1>
        <ol class="breadcrumb">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Audit & Trail</a></li>
            <li class="active">List</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-primary">
            <div class="box-body">
                <fieldset>
                    <div class="table-responsive">
                        <dx:BootstrapGridView ID="gridAuditTrail" runat="server" AutoGenerateColumns="False"  KeyFieldName="Pid" DataSourceID="dsAuditTrail">
                            <Settings ShowHeaderFilterButton="True" />
                            <Columns>
                                <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="1" Visible="false">
                                    <SettingsEditForm Visible="False" ShowCaption="False" />
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="Module" VisibleIndex="2">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="Form" VisibleIndex="3">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="Action" VisibleIndex="4">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="Remark" VisibleIndex="5" PropertiesTextEdit-EncodeHtml="false">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="CreatedDate" VisibleIndex="6" Caption="Date">
                                </dx:BootstrapGridViewTextColumn>
                            </Columns>
                             <SettingsSearchPanel ShowClearButton="True" Visible="True" />
                        </dx:BootstrapGridView>
                    </div>
                </fieldset>
            </div>
        </div>
    </section>
    <asp:SqlDataSource ID="dsAuditTrail" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionString2 %>" SelectCommand="SELECT * FROM [AuditTrail]"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
