<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Claim_MarineCargoData.aspx.cs" Inherits="ClaimApp.Claim_MarineCargoData" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <script type="text/javascript">
        //Javascript
        function showModal(s, e) {
            modalInfo.Show();
        }
        function exitPage() {
            //Alertnya Make SweetAlert confirm
            Swal.fire({
                title: 'Are you sure?',
                text: "You want to leave this page?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#5cb85c',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, leave now!'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "Claim_MarineCargo.aspx";
                }
            })
        }
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
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:HiddenField runat="server" ID="NetClaim" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="ConfirmBack" ClientIDMode="Static" />
    <asp:ScriptManager ID="SM" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="Upanel" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <h1>CLAIM MARINE CARGO</h1>
                <ol class="breadcrumb">
                    <li><a href="Home.aspx">Home</a></li>
                    <li><a href="#">Transaction</a></li>
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
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Client" BeginRow="true">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox ID="cbClient" runat="server" AutoPostBack="true" TextField="InsuredName" ValueField="InsuredCode" DataSourceID="dsClient"></dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Certificate">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox ID="cbSertificate" runat="server" AutoPostBack="true" TextField="CertificateNo" ValueField="CertificateNo" DataSourceID="dsSertificate" OnSelectedIndexChanged="cbSertificate_SelectedIndexChanged"></dx:BootstrapComboBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="MOP No">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapTextBox ID="txtMOPno" runat="server"></dx:BootstrapTextBox>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Interest Insured">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapMemo runat="server" ID="txtareaRemarkInterest" NullText="Enter Your Interest"></dx:BootstrapMemo>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem Caption=" " ColSpanLg="6">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapButton runat="server" Text="Info" ClientInstanceName="btnInformation" ID="btnInfo">
                                                <SettingsBootstrap RenderOption="warning" />
                                                <CssClasses Icon="fa fa-exclamation-circle" />
                                                <ClientSideEvents Click="showModal" />
                                            </dx:BootstrapButton>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="DOR" BeginRow="true">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapDateEdit runat="server" ID="txtDOR" DisplayFormatString="dd/MM/yyyy"></dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="DOL">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapDateEdit runat="server" ID="txtDOL" DisplayFormatString="dd/MM/yyyy"></dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Rdate">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapDateEdit runat="server" ID="txtRdate" DisplayFormatString="dd/MM/yyyy"></dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Cause Of Loss">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox runat="server" SelectedIndex="0" ID="cbCouseOfLoss">
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
                                            <dx:BootstrapDateEdit runat="server" ID="txtSurveyDate" DisplayFormatString="dd/MM/yyyy"></dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="3" Caption="Status">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox runat="server" SelectedIndex="0" ID="cbSurveyType">
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
                                            <dx:BootstrapDateEdit runat="server" ID="txtStatusDate" DisplayFormatString="dd/MM/yyyy"></dx:BootstrapDateEdit>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="3" Caption="Conveyence">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapComboBox runat="server" SelectedIndex="0" ID="cbConveyence">
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
                                            <dx:BootstrapMemo runat="server" NullText="Enter Your Description" ID="txtareaRemarkConveyence"></dx:BootstrapMemo>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:BootstrapLayoutItem>
                                <dx:BootstrapLayoutItem FieldName="" ColSpanLg="6" Caption="Remark">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <dx:BootstrapMemo runat="server" NullText="Enter Your Remark" ID="txtareaRemark"></dx:BootstrapMemo>
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
                                        <dx:BootstrapGridView ID="gridMarineCargoDetail" runat="server" AutoGenerateColumns="False" KeyFieldName="Pid" OnRowCommand="gridMarineCargoDetail_RowCommand">
                                            <Settings ShowHeaderFilterButton="True" />
                                            <Columns>
                                                <dx:BootstrapGridViewDataColumn VisibleIndex="1">
                                                    <DataItemTemplate>
                                                        <%--<asp:LinkButton runat="server" ID="lbtnDelete" CommandName="Delete" OnClientClick="return ConfirmDelete();"><i class="fa fa-pencil-square"></i>&nbsp;&nbsp;Delete</asp:LinkButton>--%>
                                                        <asp:Button runat="server" ID="btnDelete" CommandName="DeleteRow" CssClass="btn btn-danger" CommandArgument='<%#Eval("Pid")%>' Text="Delete" OnClientClick="return confirm('Are you sure want to delete this data ? ');" />
                                                    </DataItemTemplate>
                                                </dx:BootstrapGridViewDataColumn>
                                                <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="0" Visible="false">
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
                            <dx:BootstrapButton ID="btnClose" runat="server" AutoPostBack="false" Text="Close" OnClick="btnClose_Click" ClientInstanceName="btnClose">
                                <CssClasses Icon="fa fa-sign-out" />
                                <ClientSideEvents Click="exitPage" />
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
    <dx:BootstrapPopupControl ID="ModalInformation" Width="500px" ClientInstanceName="modalInfo" runat="server" CloseAction="CloseButton" CloseOnEscape="True" Modal="True" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" HeaderText="Information" SettingsAdaptivity-Mode="Always">
        <SettingsAdaptivity Mode="Always" />
        <ContentCollection>
            <dx:ContentControl runat="server">
                <div class="p-15 text-center">
                    <fieldset>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label for="">Deductible</label>
                                </div>
                                <div class="col-sm-8">
                                    <dx:BootstrapMemo runat="server" ID="txtDeductibleMemo" Enabled="false"></dx:BootstrapMemo>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label for="">Interest Insured</label>
                                </div>
                                <div class="col-sm-8">
                                    <dx:BootstrapMemo runat="server" ID="txtInterestInsureMemo" Enabled="false"></dx:BootstrapMemo>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-4">
                                    <h4><label for="">Conveyence</label></h4>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <dx:BootstrapGridView ID="gridConveyence" runat="server" AutoGenerateColumns="False" KeyFieldName="IdConCert" Width="100%">
                                <Settings ShowHeaderFilterButton="True" />
                                <Settings ColumnMinWidth="200" />
                                <SettingsPager EnableAdaptivity="True">
                                    <PageSizeItemSettings Position="Left" Visible="True" />
                                </SettingsPager>
                                <Columns>
                                    <dx:BootstrapGridViewTextColumn FieldName="IdConCert" ReadOnly="True" VisibleIndex="0" Visible="false" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                        <SettingsEditForm Visible="False" ShowCaption="False" />
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="VesselType" VisibleIndex="1" Caption="Vessel Type" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Construction" VisibleIndex="2" Caption="Construction" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Classification" VisibleIndex="3" Caption="Classification" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Class" VisibleIndex="4" Caption="Class" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="VesselName" VisibleIndex="5" Caption="Vessel Name" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="YearBuilt" VisibleIndex="6" Caption="Year Build" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Tonage" VisibleIndex="7" Caption="Tonage" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="HorsePower" VisibleIndex="8" Caption="Horse Power" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                </Columns>
                                <SettingsResizing ColumnResizeMode="Control" />
                            </dx:BootstrapGridView>
                        </div>
                         <div class="form-group">
                            <div class="row">
                                <div class="col-sm-4">
                                    <h4><label for="">Underwriter</label></h4>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <dx:BootstrapGridView ID="gridUnderwriter" runat="server" AutoGenerateColumns="False" KeyFieldName="" Width="100%">
                                <Settings ShowHeaderFilterButton="True" />
                                <Settings ColumnMinWidth="200" />
                                <SettingsPager EnableAdaptivity="True">
                                    <PageSizeItemSettings Position="Left" Visible="True" />
                                </SettingsPager>
                                <Columns>
                                    <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="0" Visible="false" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                        <SettingsEditForm Visible="False" ShowCaption="False" />
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="" VisibleIndex="2" Caption="Insured Code" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="" VisibleIndex="3" Caption="Share" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="" VisibleIndex="4" Caption="Info" HorizontalAlign="Center" MinWidth="250" CssClasses-HeaderCell="centerText">
                                    </dx:BootstrapGridViewTextColumn>
                                </Columns>
                                <SettingsResizing ColumnResizeMode="Control" />
                            </dx:BootstrapGridView>
                        </div>
                    </fieldset>


                </div>
                <div class="modal-footer">
                    <dx:BootstrapButton ID="BootstrapButton1" runat="server" AutoPostBack="false" Text="Close" CausesValidation="False" UseSubmitBehavior="False">
                        <CssClasses Control="m-l-10" Icon="fa fa-times" />
                        <SettingsBootstrap RenderOption="danger" />
                        <ClientSideEvents Click="function(s, e) {
	    modalInfo.Hide();
    }" />
                    </dx:BootstrapButton>
                </div>
            </dx:ContentControl>
        </ContentCollection>
    </dx:BootstrapPopupControl>
    <dx:BootstrapPopupControl ID="popupSave" ClientInstanceName="popupSave" runat="server" CloseAction="CloseButton" CloseOnEscape="True" Modal="True" Text="Save Change?" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" HeaderText="Claim" SettingsAdaptivity-Mode="Always">
        <SettingsAdaptivity Mode="Always" />
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
    <asp:SqlDataSource ID="dsClient" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="select DISTINCT InsuredCode,InsuredName from t_tr_MOP where PeriodMOPTo &gt;= getdate()"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsSertificate" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionStringDevX %>" SelectCommand="select * from t_tr_MOPCertificate WHERE ClientCode = @ClientCode">
        <SelectParameters>
            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbClient" Name="ClientCode" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsMOPno" runat="server"></asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
