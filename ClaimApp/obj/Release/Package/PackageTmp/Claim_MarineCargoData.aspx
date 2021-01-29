﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Claim_MarineCargoData.aspx.cs" Inherits="ClaimApp.Claim_MarineCargoData" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <script type="text/javascript">
        //Javascript
        function onSave(s, e) {
            var isValid = ASPxClientEdit.ValidateGroup('Validation');
            if (isValid) {
                popupSave.Show();
            }
        }
        function ConfirmSave() {
            var confirmValue = document.createElement("INPUT");
            confirmValue.type = "hidden";
            confirmValue.name = "confirmValue";
            if (confirm("Mau di save?")) {
                confirmValue.value = "Yes";
            } else {
                confirmValue.value = "No";
            }
            document.forms[0].appendChild(confirmValue);
        }

        function State_OnKeyUp(s, e) {
            s.SetText(s.GetText().toUpperCase());
        }
        function GetNetClaim(s, e) {
            var netclaim = txtEstimate.GetText();
            var adjustice = txtAdjustedLoss.GetText();
            var salvage = txtSalvage.GetText();
            var deductible = txtDeductible.GetText();

            if (netclaim != null && adjustice != null && salvage != null && deductible != null) {
                var Return = (netclaim - adjustice - salvage - deductible);
                lblNetClaimTotal.SetText(Return);
            } else {
                lblNetClaimTotal.SetText(netclaim);
            }
            var total = lblNetClaimTotal.GetText();
            var hidfield = document.getElementById('<%=NetClaim.ClientID %>');
            hidfield.value = total;
        }
        function Calt1(s, e) {
            var netclaim = txtEstimate.GetText();
            var adjustice = txtAdjustedLoss.GetText();
            var salvage = txtSalvage.GetText();
            var deductible = txtDeductible.GetText();
            if (netclaim != null && adjustice != null && salvage != null && deductible != null) {
                var Return = (netclaim - adjustice - salvage - deductible);
                lblNetClaimTotal.SetText(Return);
            } else {
                var Return = (netclaim - adjustice);

                lblNetClaimTotal.SetText(Return);
            }
            var total = lblNetClaimTotal.GetText();
            var hidfield = document.getElementById('<%=NetClaim.ClientID %>');
            hidfield.value = total;
        }
        function Calt2(s, e) {
            var netclaim = txtEstimate.GetText();
            var adjustice = txtAdjustedLoss.GetText();
            var salvage = txtSalvage.GetText();
            var deductible = txtDeductible.GetText();
            if (netclaim != null && adjustice != null && salvage != null && deductible != null) {
                var Return = (netclaim - adjustice - salvage - deductible);
                lblNetClaimTotal.SetText(Return);
            } else {
                var Return = (netclaim - adjustice - salvage);

                lblNetClaimTotal.SetText(Return);
            }
            var total = lblNetClaimTotal.GetText();
            var hidfield = document.getElementById('<%=NetClaim.ClientID %>');
            hidfield.value = total;
        }
        function Calt3(s, e) {
            var netclaim = txtEstimate.GetText();
            var adjustice = txtAdjustedLoss.GetText();
            var salvage = txtSalvage.GetText();
            var deductible = txtDeductible.GetText();
            var Return = (netclaim - adjustice - salvage - deductible);
            var hidfield = document.getElementById('<%=NetClaim.ClientID %>');
            var aa = lblNetClaimTotal.SetText(Return);
            var total = lblNetClaimTotal.GetText();

            hidfield.value = total;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" ClientIDMode="Static" runat="server">
    <asp:HiddenField runat="server" ID="NetClaim" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="ConfirmBack" ClientIDMode="Static" />
    <asp:ScriptManager ID="SM" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="Upanel" runat="server">
        <ContentTemplate>
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
                    <div class="box-header with-border">
                        <asp:Label ID="lblTitle" runat="server" Text="" CssClass="box-title"></asp:Label>
                    </div>
                    <asp:HiddenField ID="hidPID" runat="server" />
                    <asp:Panel ID="pnlHeader" runat="server" ClientIDMode="Static">
                        <dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" AlignItemCaptionsInAllGroups="True" ShowItemCaptionColon="False" DataSourceID="">
                            <Items>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="IBURE">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapCheckBox ID="chkboxIBURE" runat="server"></dx:BootstrapCheckBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Sertificate" BeginRow="true">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtClaimNo" runat="server"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Policy No">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="BootstrapTextBox1" runat="server"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Underwriter">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="BootstrapTextBox2" runat="server"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Interest Insured">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapMemo runat="server" NullText="Enter Your Interest"></dx:BootstrapMemo>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Premium Paid Status">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="BootstrapTextBox4" runat="server"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="DOR" BeginRow="true">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapDateEdit runat="server"></dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="DOL">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapDateEdit runat="server"></dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Rdate">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapDateEdit runat="server"></dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Cause Of Loss">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox runat="server" SelectedIndex="0">
                                                <Items>
                                                    <dx:BootstrapListEditItem Text="Select" Value="0" />
                                                    <dx:BootstrapListEditItem Text="Contamination" Value="1" />
                                                    <dx:BootstrapListEditItem Text="Leakege" Value="2" />
                                                    <dx:BootstrapListEditItem Text="washing overboard" Value="3" />
                                                    <dx:BootstrapListEditItem Text="Stranded" Value="4" />
                                                    <dx:BootstrapListEditItem Text="Collision" Value="5" />
                                                    <dx:BootstrapListEditItem Text="Loading incident" Value="6" />
                                                    <dx:BootstrapListEditItem Text="Theft" Value="7" />
                                                    <dx:BootstrapListEditItem Text="Fire" Value="8" />
                                                    <dx:BootstrapListEditItem Text="Wet damage" Value="9" />
                                                    <dx:BootstrapListEditItem Text="Concealed Damage" Value="10" />
                                                    <dx:BootstrapListEditItem Text="Rough Handling" Value="11" />
                                                    <dx:BootstrapListEditItem Text="Shortage" Value="12" />
                                                </Items>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Survey">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapDateEdit runat="server"></dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="3" Caption="Status">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox runat="server" SelectedIndex="0">
                                                <Items>
                                                    <dx:BootstrapListEditItem Text="Doc Incomplete" Value="0" />
                                                    <dx:BootstrapListEditItem Text="Doc Complete" Value="1" />
                                                    <dx:BootstrapListEditItem Text="DSS Released" Value="2" />
                                                    <dx:BootstrapListEditItem Text="DFR Released" Value="3" />
                                                    <dx:BootstrapListEditItem Text="LOD Received" Value="4" />
                                                    <dx:BootstrapListEditItem Text="Paid" Value="5" />
                                                    <dx:BootstrapListEditItem Text="Cancelled" Value="6" />
                                                </Items>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="3" Caption="">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapDateEdit runat="server"></dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="3" Caption="Conveyence">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox runat="server" SelectedIndex="0">
                                                <Items>
                                                    <dx:BootstrapListEditItem Text="Select" Value="1" />
                                                    <dx:BootstrapListEditItem Text="Vessel" Value="1" />
                                                    <dx:BootstrapListEditItem Text="Truck" Value="2" />
                                                    <dx:BootstrapListEditItem Text="AirPlane" Value="3" />
                                                </Items>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="3" Caption="">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapMemo runat="server" NullText="Enter Your Description"></dx:BootstrapMemo>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Remark">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapMemo runat="server" NullText="Enter Your Remark"></dx:BootstrapMemo>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                            </Items>
                        </dx:BootstrapFormLayout>

                        <div class="box-body with-border">
                            <section class="col-md-12">
                                <div class="input">
                                    <div class="input-group">
                                        <dx:BootstrapButton ID="btNew" runat="server" AutoPostBack="false" Text="Add" CausesValidation="False" UseSubmitBehavior="False" OnClick="btNew_Click">
                                            <SettingsBootstrap RenderOption="Info" />
                                            <CssClasses Icon="fa fa-plus-square" />
                                            <%--<ClientSideEvents Click="formDetail" />--%>
                                        </dx:BootstrapButton>
                                    </div>
                                </div>
                            </section>
                            <br />
                            <br />
                            <section class="col-lg-12">
                                <div class="input">
                                    <div class="input">
                                        <dx:BootstrapGridView ID="gridMarineCargoDetail" runat="server" AutoGenerateColumns="False" KeyFieldName="Pid">
                                            <Settings ShowHeaderFilterButton="True" />
                                            <Columns>
                                                <dx:BootstrapGridViewDataColumn VisibleIndex="0">
                                                    <DataItemTemplate>
                                                        <%--<a onclick="window.location='ClaimMV_ManualData.aspx?Pid=<%# Eval("Pid") %>';" href="javascript:void(0);"><i class="fa fa-pencil-square"></i>&nbsp;&nbsp;Edit Claim</a>--%>
                                                        <asp:LinkButton runat="server" ID="lbtnDelete" CommandName="Delete" OnClientClick="return ConfirmDelete();"><i class="fa fa-pencil-square"></i>&nbsp;&nbsp;Delete</asp:LinkButton>
                                                    </DataItemTemplate>
                                                </dx:BootstrapGridViewDataColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="1" Visible="false">
                                                    <SettingsEditForm Visible="False" ShowCaption="False" />
                                                </dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="Currency" VisibleIndex="2" Caption="Currency">
                                                </dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="Estimate" VisibleIndex="3" Caption="Estimate">
                                                </dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="AdjustedLoss" VisibleIndex="4" Caption="Adjusted Loss">
                                                </dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="Salvage" VisibleIndex="5" Caption="Salvage">
                                                </dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="Deductible" VisibleIndex="6" Caption="Deductible">
                                                </dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="NetClaim" VisibleIndex="7" Caption="Net Claim">
                                                </dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="QuantityAsPerBL" VisibleIndex="8" Caption="Quantity As Per B/L">
                                                </dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="QuantityReceived" VisibleIndex="9" Caption="Quantity Received">
                                                </dx:BootstrapGridViewTextColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="QuantityShortage" VisibleIndex="10" Caption="Quantity Shortage">
                                                </dx:BootstrapGridViewTextColumn>
                                            </Columns>
                                        </dx:BootstrapGridView>
                                    </div>
                                </div>
                            </section>
                        </div>
                        <div class="box-footer text-right">
                            <dx:BootstrapButton ID="btnSave" runat="server" AutoPostBack="false" Text="Save" CausesValidation="False" UseSubmitBehavior="False" OnClick="btnSave_Click">
                                <CssClasses Icon="fa fa-save" />
                                <SettingsBootstrap RenderOption="Success" />
                                <ClientSideEvents Click="onSave" />
                            </dx:BootstrapButton>
                            <dx:BootstrapButton ID="btnClose" runat="server" AutoPostBack="false" Text="Close" OnClick="btnClose_Click">
                                <CssClasses Icon="fa fa-sign-out" />
                            </dx:BootstrapButton>
                        </div>
                    </asp:Panel>

                    <asp:Panel runat="server" ID="pnlDetail" ClientIDMode="Static">
                        <dx:BootstrapFormLayout ID="BootstrapFormLayout2" runat="server" ClientInstanceName="Detail" AlignItemCaptionsInAllGroups="True" ShowItemCaptionColon="False" DataSourceID="">
                            <Items>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="3" Caption="Currency">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox ID="cbCurrency" runat="server" SelectedIndex="0">
                                                <Items>
                                                    <dx:BootstrapListEditItem Text="IDR" Value="0" />
                                                </Items>
                                            </dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Estimate" BeginRow="true">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtEstimate" runat="server" ClientInstanceName="txtEstimate" DisplayFormatString="#,###.#0">
                                                <ClientSideEvents KeyUp="GetNetClaim" />
                                            </dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Quantity As Per B/L">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtQuantityAsPerBL" ClientInstanceName="txtQuantityAsPerBL" runat="server" DisplayFormatString="#,###.#0"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Adjusted Loss">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtAdjustedLoss" runat="server" DisplayFormatString="#,###.#0" ClientInstanceName="txtAdjustedLoss">
                                                <ClientSideEvents KeyUp="Calt1" />
                                            </dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Quantity Received">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtQuantity" runat="server" DisplayFormatString="#,###.#0"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Salvage">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtSalvage" runat="server" DisplayFormatString="#,###.#0" ClientInstanceName="txtSalvage">
                                                <ClientSideEvents KeyUp="Calt2" />
                                            </dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Quantity Shortage">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtQuantityShortage" runat="server" DisplayFormatString="#,###.#0"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Deductible">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtDeductible" runat="server" DisplayFormatString="#,###.#0" ClientInstanceName="txtDeductible">
                                                <ClientSideEvents KeyUp="Calt3" />
                                            </dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Net Claim" BeginRow="true">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <h6>
                                                <dx:ASPxLabel ID="lblNetClaimTotal" Font-Bold="true" Font-Size="15" runat="server" ClientInstanceName="lblNetClaimTotal"></dx:ASPxLabel>
                                            </h6>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                            </Items>
                        </dx:BootstrapFormLayout>
                        <div class="box-footer text-right">
                            <dx:BootstrapButton ID="btnSaveDetail" runat="server" AutoPostBack="false" Text="Save" CausesValidation="False" UseSubmitBehavior="False" OnClick="btnSaveDetail_Click">
                                <CssClasses Icon="fa fa-save" />
                                <SettingsBootstrap RenderOption="Success" />
                            </dx:BootstrapButton>
                            <dx:BootstrapButton ID="btnbackDetail" runat="server" AutoPostBack="false" Text="Back" OnClick="btnbackDetail_Click">
                                <CssClasses Icon="fa fa-repeat" />
                                <ClientSideEvents Click="ConfirmBack" />
                            </dx:BootstrapButton>
                        </div>
                    </asp:Panel>
                </div>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
    <dx:BootstrapPopupControl ID="popupSave" ClientInstanceName="popupSave" runat="server" CloseAction="CloseButton" CloseOnEscape="True" Modal="True" Text="Simpan Perubahan?" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" HeaderText="Claim" SettingsAdaptivity-Mode="Always">
        <SettingsAdaptivity Mode="Always" />
        <ContentCollection>
            <dx:ContentControl runat="server">
                <div class="p-15 text-center">
                    <dx:BootstrapButton ID="btnSaveYes" ClientInstanceName="btnSaveYes" runat="server" AutoPostBack="False" Text="Yes" >
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
