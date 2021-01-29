<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Claim_MarineCargo.aspx.cs" Inherits="ClaimApp.ClaimApp_MarineCargo" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <section class="content-header">
        <h1>CLAIM MARINE CARGO</h1>
        <ol class="breadcrumb">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Transaksi</a></li>
            <li class="active">Marine Cargo</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-primary">
            <div class="box-footer">
                <dx:BootstrapButton ID="btNew" runat="server" AutoPostBack="false" Text="New Claim" CausesValidation="False" UseSubmitBehavior="False" OnClick="btNew_Click">
                    <SettingsBootstrap RenderOption="Info" />
                    <CssClasses Icon="fa fa-plus-square" />
                </dx:BootstrapButton>
            </div>
            <div class="box-body">
                <fieldset>
                    <div class="table-responsive">
                        <dx:BootstrapGridView ID="gridMarineCargo" runat="server" AutoGenerateColumns="False" KeyFieldName="Pid" DataSourceID="">
                             <Settings ShowHeaderFilterButton="True" />
                            <Columns>

                            </Columns>
                            <SettingsSearchPanel ShowClearButton="True" Visible="True" />
                        </dx:BootstrapGridView>
                    </div>
                </fieldset>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
