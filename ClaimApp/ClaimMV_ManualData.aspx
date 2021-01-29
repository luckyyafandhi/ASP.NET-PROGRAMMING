<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ClaimMV_ManualData.aspx.cs" Inherits="ClaimApp.ClaimManualData" %>

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
                <h1>CLAIM MOTOR VEHICLE</h1>
                <ol class="breadcrumb">
                    <li><a href="Home.aspx">Home</a></li>
                    <li><a href="#">Transaction</a></li>
                    <li class="active">Claim Manual</li>
                </ol>
            </section>

            <section class="content">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <asp:Label ID="lblTitle" runat="server" Text="" CssClass="box-title"></asp:Label>
                    </div>
                    <!--<div class="box-body">-->
                    <asp:HiddenField ID="hidPID" runat="server" />
                    <asp:HiddenField ID="hidDB" runat="server" />
                    <asp:HiddenField ID="clientcode" runat="server" />

                    <div class="box-header with-border">
                        <section class="col-md-12">
                            <div class="input">
                                <div class="input-group">
                                    <label class="control-label">Choose Database</label>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <dx:BootstrapRadioButton runat="server" Text="IBOS" ID="rbIBOS" GroupName="badge" ClientInstanceName="rbIBOS">
                                            </dx:BootstrapRadioButton>
                                        </div>
                                        <div class="col-md-3">
                                            <dx:BootstrapRadioButton runat="server" Text="New MV Application" ID="rbMerimen" GroupName="badge" ClientInstanceName="rbMerimen">
                                            </dx:BootstrapRadioButton>
                                        </div>
                                        <div class="col-md-3">
                                            <dx:BootstrapRadioButton runat="server" Text="Jagoan Premi" ID="rbjagoan" GroupName="badge" ClientInstanceName="rbjagoan">
                                            </dx:BootstrapRadioButton>
                                        </div>
                                        <div class="col-md-3">
                                            <dx:BootstrapButton runat="server" ID="btnChoosedb" Text="Choose" CausesValidation="False" UseSubmitBehavior="False" OnClick="btnChoosedb_Click">
                                                <SettingsBootstrap RenderOption="Info" />
                                                <CssClasses Icon="fa fa-check-square-o" />
                                            </dx:BootstrapButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>



                    <dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" AlignItemCaptionsInAllGroups="True" ShowItemCaptionColon="False" DataSourceID="dsClaimManual">
                        <Items>

                            <dx:BootstrapLayoutItem Caption="Transaction Number" ColSpanLg="6" HorizontalAlign="Left" BeginRow="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <h5><strong>
                                            <asp:Label ID="lblTransactionNumber" runat="server" Text=""></asp:Label></strong></h5>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem Caption="Status Payment" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <h5><strong>
                                            <asp:Literal ID="ltrStatus" runat="server"></asp:Literal>
                                            <asp:Label ID="lblStatusPaid" runat="server" Text=""></asp:Label></strong></h5>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="PoliceNumber" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <%--    <dx:BootstrapComboBox ID="cbPoliceNumber" runat="server" DataSourceID="dsNoPoliceAndVehicle" TextField="PoliceNo" ValueField="PoliceNo">
                                        </dx:BootstrapComboBox>--%>
                                        <dx:BootstrapTextBox runat="server" ID="cbPoliceNumber2" AutoPostBack="true" OnTextChanged="cbPoliceNumber2_TextChanged">
                                        </dx:BootstrapTextBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem Caption="Client Name" ColSpanLg="6" HorizontalAlign="Left" FieldName="ClientName">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapComboBox ID="cbClient" runat="server" DataSourceID="dsClientName" AutoPostBack="true" TextField="ClientName" ValueField="ClientCode">
                                        </dx:BootstrapComboBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>

                            <dx:BootstrapLayoutItem ColSpanLg="6" Caption="Policy No" FieldName="PolicyNo" BeginRow="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapComboBox ID="cbPolicyNo" runat="server" EnableCallbackMode="True" DataSourceID="dsCbPolicyNo" AutoPostBack="true" TextField="PolNo" ValueField="PolNo" OnSelectedIndexChanged="cbPolicyNo_SelectedIndexChanged">
                                        </dx:BootstrapComboBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="ChasisNumber" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapComboBox ID="cbChasisNo" runat="server" DataSourceID="dsCbChasisNo" AutoPostBack="true" TextField="CHASSIS_NO" ValueField="CHASSIS_NO" OnSelectedIndexChanged="cbChasisNo_SelectedIndexChanged">
                                        </dx:BootstrapComboBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="EngineNumber" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapComboBox ID="cbEngineNo" runat="server" DataSourceID="dsCbEngineNo" AutoPostBack="true" TextField="ENGINE_NO" ValueField="ENGINE_NO">
                                        </dx:BootstrapComboBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="InsuranceName" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapComboBox ID="cbInsurance" runat="server" DataSourceID="dsCbInsurance" TextField="INSURANCENAME" AutoPostBack="true" ValueField="INSURANCENAME" OnSelectedIndexChanged="cbInsurance_SelectedIndexChanged">
                                        </dx:BootstrapComboBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="Workshop" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapComboBox ID="cbWorkshop" runat="server" DataSourceID="dsWorkshop" TextField="Name" ValueField="Name">
                                        </dx:BootstrapComboBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="DateOfLoss" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapDateEdit ID="DateofLoss" runat="server" DisplayFormatString="dd/MM/yyyy">
                                        </dx:BootstrapDateEdit>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>

                            <dx:BootstrapLayoutItem FieldName="VehicleModel" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapComboBox ID="cbVehicleModel" runat="server" DataSourceID="dsNoPoliceAndVehicle" TextField="VehicleModel" ValueField="VehicleModel">
                                        </dx:BootstrapComboBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="WorkshopEntryDate" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapDateEdit ID="WorkshopEntryDate" runat="server" DisplayFormatString="dd/MM/yyyy">
                                        </dx:BootstrapDateEdit>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="RepairerEstimate" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapDateEdit ID="txtRepairerEstimate" runat="server" DisplayFormatString="dd/MM/yyyy">
                                        </dx:BootstrapDateEdit>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="AmountApproved" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapTextBox ID="txtAmountApproved" runat="server" DisplayFormatString="#,###.#0">
                                        </dx:BootstrapTextBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="FinishDate" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapDateEdit ID="txtFinishDate" runat="server" DisplayFormatString="dd/MM/yyyy">
                                        </dx:BootstrapDateEdit>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem FieldName="RepairingStatus" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapTextBox ID="RepairingStatus" runat="server"></dx:BootstrapTextBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem Caption="Spk Date" FieldName="SpkDate" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapDateEdit ID="SPKDate" runat="server" DisplayFormatString="dd/MM/yyyy">
                                        </dx:BootstrapDateEdit>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem Caption="Claim Demage" FieldName="ClaimDemage" ColSpanLg="6">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapComboBox ID="cbClaimDemage" runat="server" SelectedIndex="0">
                                            <Items>
                                                <dx:BootstrapListEditItem Text="COLLISION" Value="0" />
                                                <dx:BootstrapListEditItem Text="CTL/TLO" Value="1" />
                                                <dx:BootstrapListEditItem Text="FLOOD" Value="2" />
                                            </Items>
                                        </dx:BootstrapComboBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                            <dx:BootstrapLayoutItem Caption="Division" ColSpanLg="6" HorizontalAlign="Left" FieldName="DivName">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                          <dx:BootstrapComboBox runat="server" ID="txtDivision" AutoPostBack="true">
                                        </dx:BootstrapComboBox>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:BootstrapLayoutItem>
                        </Items>
                    </dx:BootstrapFormLayout>
                    <div class="box-footer text-right">
                        <dx:BootstrapButton ID="btnSave" runat="server" AutoPostBack="False" Text="Save" OnClick="btnSave_Click">
                            <CssClasses Icon="fa fa-save" />
                            <SettingsBootstrap RenderOption="Success" />
                            <ClientSideEvents Click="onSave" />
                        </dx:BootstrapButton>
                        <dx:BootstrapButton ID="btnClose" runat="server" AutoPostBack="false" Text="Close" OnClick="btnClose_Click">
                            <CssClasses Icon="fa fa-sign-out" />
                        </dx:BootstrapButton>
                    </div>
                    <asp:SqlDataSource ID="dsClaimManual" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionString2 %>" SelectCommand="select * from ClaimMotorVehicle Where ([Pid] = @Pid)">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="0" Name="Pid" QueryStringField="Pid" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsWorkshop" runat="server" ConnectionString="<%$ ConnectionStrings:ReksaAppConnectionString2 %>" SelectCommand="Select * from Master_Bengkel Where Status = 'True'"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsCbPolicyNo" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringCore %>" SelectCommand="  select PolNo from PolMain Where PolTo &gt; convert(date,getdate(),103) AND ClassCode = '3' AND Status in('v','P') and ClientCode = @ClientCode">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbClient" Name="ClientCode" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsNoPoliceAndVehicle" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringCore %>" SelectCommand=" SELECT DISTINCT B.PoliceNo , B.Type AS VehicleModel
 FROM indoins_back.dbo.POLMain A
 LEFT OUTER JOIN indoins_back.dbo.POLDetail_3 B ON A.PolID = B.PolID
 WHERE A.PolNo = @PolNo AND B.ChassisNo = @ChasisNo AND B.EngineNo = @EngineNo">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbPolicyNo" DefaultValue="0" Name="PolNo" PropertyName="Value" />
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbChasisNo" DefaultValue="0" Name="ChasisNo" PropertyName="Value" />
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbEngineNo" DefaultValue="0" Name="EngineNo" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsCbChasisNo" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringCore %>" SelectCommand="SELECT DISTINCT B.ChassisNo AS CHASSIS_NO
 FROM POLMain A
 LEFT OUTER JOIN POLDetail_3 B ON A.PolID = B.PolID
 WHERE A.PolNo = @PolNo">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbPolicyNo" DefaultValue="0" Name="PolNo" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsCbEngineNo" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringCore %>" SelectCommand="SELECT DISTINCT B.EngineNo AS ENGINE_NO
 FROM POLMain A
 LEFT OUTER JOIN POLDetail_3 B ON A.PolID = B.PolID
 WHERE A.PolNo = @PolNo  AND B.ChassisNo = @ChasisNo ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbPolicyNo" DefaultValue="0" Name="PolNo" PropertyName="Value" />
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbChasisNo" DefaultValue="0" Name="ChasisNo" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsClientName" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringCore %>" SelectCommand="   Select DISTINCT b.ClientCode,B.ClientName,C.DivName,a.PoliceNo from POLDetail_3 A
  LEFT OUTER JOIN PolMain B ON A.PolID = B.PolMainID
  LEFT OUTER JOIN SETDivision C ON B.DivCode = C.DivCode 
  Where PoliceNo = @PoliceNo  AND  B.PolTo &gt; convert(date,getdate(),103) AND B.ClassCode = '3' AND B.Status in('v','P')">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbPoliceNumber2" Name="PoliceNo" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsCbInsurance" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringCore %>" SelectCommand=" SELECT DISTINCT C.ClientType AS CLIENT_TYPE,C.Type,C.Name AS INSURANCE,UPPER(C.Type + C.Name) AS INSURANCENAME
 FROM indoins_back.dbo.POLMain A
 LEFT OUTER JOIN indoins_back.dbo.POLDetail_3 B ON A.PolID = B.PolID
 LEFT OUTER JOIN indoins_back.dbo.MSTClient C ON B.CompanyID = C.CompanyID
 WHERE A.PolNo = @PolNo AND B.ChassisNo = @ChasisNo AND B.EngineNo = @EngineNo AND C.ClientType = 'U'">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbPolicyNo" DefaultValue="0" Name="PolNo" PropertyName="Value" />
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbChasisNo" DefaultValue="0" Name="ChasisNo" PropertyName="Value" />
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbEngineNo" DefaultValue="0" Name="EngineNo" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsDivName" runat="server" ConnectionString="<%$ ConnectionStrings:ClaimAppConnectionStringCore %>" SelectCommand="select DISTINCT a.ClientCode,a.DivCode,b.DivName
from Polmain a 
left outer join SETDivision b on a.DivCode = b.DivCode
Where a.clientcode= @clientcode and a.PolNo = @PolNo">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbClient" Name="clientcode" PropertyName="Value" />
                            <asp:ControlParameter ControlID="ctl00$bodyPlaceHolder$BootstrapFormLayout1$cbPolicyNo" Name="PolNo" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <!--</div>-->
                </div>

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
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footerPlaceHolder" runat="server">
</asp:Content>
