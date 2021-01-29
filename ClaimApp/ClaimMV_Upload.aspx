<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ClaimMV_Upload.aspx.cs" Inherits="ClaimApp.ClaimUpload" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <script type="text/javascript">
        function alertUpload(s, e) {
            Swal.fire(
            'Yeay...',
            'We have received your file, we will process it further, thank you',
            'success'
            )

            setTimeout(function () {
                location.reload();
            }, 5000)
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:ScriptManager ID="SM" runat="server"></asp:ScriptManager>

    <section class="content-header">
        <h1>LAST UPLOAD DATA CLAIM</h1>
        <ol class="breadcrumb">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Transaction</a></li>
            <li class="active">Claim Upload</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-body">
                <asp:Label ID="lblTitle" runat="server" Text="" Visible="true"></asp:Label>

                <%--<fieldset>--%>

                <div class="row">
                    <section class="col-md-12">
                        <div class="input">
                            <div class="input-group">
                                <label class="control-label">Choose Database</label>
                                <div class="row">
                                    <div class="col-md-3">
                                        <dx:BootstrapRadioButton runat="server" Text="IBOS" ID="rbIBOS" GroupName="badge">
                                        </dx:BootstrapRadioButton>
                                    </div>
                                    <div class="col-md-3">
                                        <dx:BootstrapRadioButton runat="server" Text="New MV Application" ID="rbMerimen" GroupName="badge">
                                        </dx:BootstrapRadioButton>
                                    </div>
                                    <div class="col-md-3">
                                        <dx:BootstrapRadioButton runat="server" Text="Jagoan Premi" ID="rbjagoan" GroupName="badge">
                                        </dx:BootstrapRadioButton>
                                    </div>
                                    <div class="col-md-3">
                                        <dx:BootstrapButton runat="server" ID="btnChoosedb" Text="Choose" CausesValidation="False" UseSubmitBehavior="False" OnClick="btnChoosedb_Click">
                                            <SettingsBootstrap RenderOption="Info" />
                                            <%--<ClientSideEvents Click="btNewData" />--%>
                                            <CssClasses Icon="fa fa-check-square-o" />
                                        </dx:BootstrapButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
                <div class="row">
                    <section class="col-md-12">
                        <div class="input">
                            <div class="input-group">
                                <label class="control-label">Download Example</label>
                                <div class="row">
                                    <div class="col-md-3">
                                        <dx:BootstrapButton runat="server" ID="btnDownload" Text="Download" CausesValidation="False" UseSubmitBehavior="False" OnClick="btnDownload_Click">
                                            <SettingsBootstrap RenderOption="success" />
                                            <CssClasses Icon="fa fa-download" />
                                        </dx:BootstrapButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
                <br />
                <div class="row">
                    <section class="col col-md-10">
                        <div class="input">
                            <div class="input-group">
                                <label class="control-label">Uploaded </label>
                                <dx:BootstrapUploadControl ID="buFileUpload" ClientInstanceName="buFileUpload" Visible="false" runat="server" ShowProgressPanel="True" AutoStartUpload="True" Enabled="true" OnFileUploadComplete="buFileUpload_FileUploadComplete">
                                    <ValidationSettings MaxFileSize="5120000" AllowedFileExtensions=".xlsx,.xls" />
                                    <ClientSideEvents FilesUploadComplete="alertUpload" />
                                    <AdvancedModeSettings EnableDragAndDrop="True" />
                                </dx:BootstrapUploadControl>
                                <dx:BootstrapUploadControl ID="buFileUploadMerimen" ClientInstanceName="buFileUploadMerimen" Visible="false" runat="server" ShowProgressPanel="True" AutoStartUpload="True" Enabled="true">
                                    <ValidationSettings MaxFileSize="5120000" AllowedFileExtensions=".xlsx,.xls" />
                                    <ClientSideEvents FilesUploadComplete="alertUpload" />
                                    <AdvancedModeSettings EnableDragAndDrop="True" />
                                </dx:BootstrapUploadControl>
                                <dx:BootstrapUploadControl ID="buFileUploadJagoan" ClientInstanceName="buFileUploadJagoan" Visible="false" runat="server" ShowProgressPanel="True" AutoStartUpload="True" Enabled="true">
                                    <ValidationSettings MaxFileSize="5120000" AllowedFileExtensions=".xlsx,.xls" />
                                    <ClientSideEvents FilesUploadComplete="alertUpload" />
                                    <AdvancedModeSettings EnableDragAndDrop="True" />
                                </dx:BootstrapUploadControl>
                            </div>
                        </div>
                    </section>
                    <section class="col col-md-2">
                    </section>
                </div>
                <br />
                <section class="content-header">
                    <h1>DATA CLAIM VALID</h1>
                </section>
                <asp:HiddenField ID="hidDB" runat="server" />
                <div class="table-responsive">
                    <dx:BootstrapGridView ID="gridClaimMotorVehicle" runat="server" AutoGenerateColumns="False" KeyFieldName="Pid" DataSourceID="dsClaimUpload" OnRowCommand="gridClaimMotorVehicle_RowCommand" Width="100%">
                        <Settings ShowHeaderFilterButton="True" ShowFooter="True" />
                        <Settings ColumnMinWidth="200" />
                        <Columns>
                            <dx:BootstrapGridViewDataColumn VisibleIndex="0">
                                <DataItemTemplate>
                                    <dx:BootstrapButton runat="server" ID="btnCheckPaid" Text="Check Paid" CausesValidation="False" CommandName="CheckRow" CommandArgument='<%#Eval("Pid") %>'>
                                        <SettingsBootstrap RenderOption="Info" />
                                        <CssClasses Icon="fa fa-check-square-o" />
                                    </dx:BootstrapButton>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewDataColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="1" Visible="False">
                                <SettingsEditForm Visible="False" ShowCaption="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="InsuranceName" VisibleIndex="3" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Workshop" VisibleIndex="10" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" VisibleIndex="4" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="DateOfLoss" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy" VisibleIndex="9" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy"></PropertiesDateEdit>
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="PoliceNumber" VisibleIndex="6" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="VehicleModel" VisibleIndex="5" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="ChasisNumber" VisibleIndex="7" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="EngineNumber" VisibleIndex="8" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="WorkshopEntryDate" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy" VisibleIndex="11" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy"></PropertiesDateEdit>
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="AmountApproved" VisibleIndex="12" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="RepairingStatus" VisibleIndex="14" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="TransactionNumber" VisibleIndex="2" GroupIndex="0" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="SpkDate" VisibleIndex="13" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="DivName" VisibleIndex="15" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                            </dx:BootstrapGridViewTextColumn>
                        </Columns>
                        <SettingsResizing ColumnResizeMode="Control" />
                        <SettingsSearchPanel Visible="True" />
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="InsuranceName" SummaryType="Count" />
                        </TotalSummary>
                    </dx:BootstrapGridView>
                </div>
                <br />
                <section class="content-header">
                    <h1>DATA CLAIM NOT VALID</h1>
                </section>
                <div class="table-responsive">
                    <dx:BootstrapGridView ID="BootstrapGridView1" runat="server" AutoGenerateColumns="False" KeyFieldName="Pid" DataSourceID="ClaimTemp">
                        <Settings ShowHeaderFilterButton="True" ShowFooter="True" />
                        <Columns>
                            <dx:BootstrapGridViewDataColumn VisibleIndex="0">
                                <DataItemTemplate>
                                    <%-- <a onclick="window.location='ClaimManualData.aspx?Pid=<%# Eval("Pid") %>';" href="javascript:void(0);"><i class="fa fa-pencil-square"></i>&nbsp;&nbsp;Check Paid</a>--%>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewDataColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Pid" ReadOnly="True" VisibleIndex="1" Visible="False">
                                <SettingsEditForm Visible="False" ShowCaption="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="InsuranceName" VisibleIndex="3" MinWidth="250" CssClasses-HeaderCell="centerText">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Workshop" VisibleIndex="10" MinWidth="250" CssClasses-HeaderCell="centerText">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="PolicyNo" VisibleIndex="4">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="DateOfLoss" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy" VisibleIndex="9" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy"></PropertiesDateEdit>
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="PoliceNumber" VisibleIndex="6" MinWidth="250" CssClasses-HeaderCell="centerText">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="VehicleModel" VisibleIndex="5" MinWidth="250" CssClasses-HeaderCell="centerText">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="ChasisNumber" VisibleIndex="7" MinWidth="250" CssClasses-HeaderCell="centerText">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="EngineNumber" VisibleIndex="8" MinWidth="250" CssClasses-HeaderCell="centerText">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="WorkshopEntryDate" PropertiesDateEdit-DisplayFormatString="dd-MMM-yyyy" VisibleIndex="11" MinWidth="250" CssClasses-HeaderCell="centerText">
                                <CssClasses HeaderCell="centerText"></CssClasses>
                                <PropertiesDateEdit DisplayFormatString="dd-MMM-yyyy"></PropertiesDateEdit>
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="AmountApproved" VisibleIndex="12" MinWidth="250" CssClasses-HeaderCell="centerText">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="RepairingStatus" VisibleIndex="14" MinWidth="250" CssClasses-HeaderCell="centerText">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="TransactionNumber" VisibleIndex="2" GroupIndex="0" MinWidth="250" CssClasses-HeaderCell="centerText">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="SpkDate" VisibleIndex="13" MinWidth="250" CssClasses-HeaderCell="centerText">
                            </dx:BootstrapGridViewDateColumn>
                        </Columns>
                        <SettingsResizing ColumnResizeMode="Control" />
                        <SettingsSearchPanel Visible="True" />
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="InsuranceName" SummaryType="Count" />
                        </TotalSummary>
                    </dx:BootstrapGridView>
                    <div class="text-left">
                        <label class="control-label">Total Data : </label>
                        <asp:Label runat="server" ID="lblTotal" class="control-label" />
                    </div>
                </div>
            </div>
            <asp:SqlDataSource ID="dsLastClaim" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionString2 %>" SelectCommand="select MAX(TransactionNumber) AS TransactionNumber,PolicyNo,ChasisNumber,EngineNumber from ClaimMotorVehicle 
WHERE Type_Input = 'Upload Input' AND CreateBy = @session GROUP BY PolicyNo,ChasisNumber,EngineNumber">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="0" Name="session" QueryStringField="userName" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="ClaimTemp" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionString2 %>" SelectCommand="select * from ClaimMotorVehicle_Temp 
Where TransactionNumber = (SELECT MAX(TransactionNumber) AS TransactionNumber from ClaimMotorVehicle_Temp WHERE Type_Input = 'Upload Input' AND CreateBy = @SA)
EXCEPT
select * from ClaimMotorVehicle 
Where TransactionNumber = (SELECT MAX(TransactionNumber) AS TransactionNumber from ClaimMotorVehicle WHERE Type_Input = 'Upload Input' AND CreateBy = @SA)">
                <SelectParameters>
                    <asp:SessionParameter Name="SA" SessionField="userName" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsClaimUpload" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionString2 %>" SelectCommand="select * from ClaimMotorVehicle Where TransactionNumber = (SELECT MAX(TransactionNumber) AS TransactionNumber from ClaimMotorVehicle WHERE Type_Input = 'Upload Input' AND CreateBy = @SA)">
                <SelectParameters>
                    <asp:SessionParameter Name="SA" SessionField="userName" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
