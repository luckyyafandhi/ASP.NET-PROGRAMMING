using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.Configuration;
using System.IO;
using System.Data;
using Upload = ClaimApp.classes.ClsUpload;
using AuditTrail = ClaimApp.classes.ClsAuditTrail;
using System.Threading;
using ClaimApp.classes;

namespace ClaimApp
{
    public partial class ClaimManualData : System.Web.UI.Page
    {
        public Upload myClass = new Upload();
        DataTable mytable = new DataTable();
        
        public DataTable getGenerateTransactionNumber = Upload.getGenerateTransacNum();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] == null)
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
            }
            lblTitle.Text = (Request.QueryString["Pid"] == null ? "New Claim" : "Edit Claim");
            hidPID.Value = (Request.QueryString["Pid"] == null ? "0" : Request.QueryString["Pid"]);

            btnSave.Text = (Request.QueryString["Pid"] == null ? "Save" : "Update");

            txtDivision.Enabled = false;

            if (Request.QueryString["Pid"] != null)
            {
                long xID = Convert.ToInt64(Request.QueryString["Pid"]);
                DataTable getTransactionNumber = Upload.getTransactionNum(xID);
                Int64 PolID = Upload.getPOLID(xID);
                DataTable ckDB = Upload.getDB(xID);
                string dbclaim = ckDB.Rows[0]["DataSource"].ToString().Trim();
                string db = "131.100.100.100\\\\sql2008";
                if (dbclaim == db)
                {
                    rbIBOS.Checked = true;
                }
                
                string Status = Upload.CheckStatusPaid(PolID);
                string TransactionNumber = getTransactionNumber.Rows[0]["TransactionNumber"].ToString().Trim();
                var strStatus = Status.Split('-');
                string ClientToBroker = strStatus[0];
                string BrokerToInsurance = strStatus[1];
                string xLiterial = "Client To Broker :<b> " + ClientToBroker + "</b> , Broker To Insurance : <b>" + BrokerToInsurance + "</b>";
                lblStatusPaid.Text = xLiterial;
                lblTransactionNumber.Text = TransactionNumber;
                cbPoliceNumber2.Enabled = false;
                cbChasisNo.Enabled = false;
                cbPolicyNo.Enabled = false;
                cbEngineNo.Enabled = false;
                cbInsurance.Enabled = false;
                DateofLoss.Enabled = false;
                WorkshopEntryDate.Enabled = false;
                cbWorkshop.Enabled = false;
                cbVehicleModel.Enabled = false;
                WorkshopEntryDate.Enabled = false;
                WorkshopEntryDate.Enabled = false;
                SPKDate.Enabled = false;
                rbIBOS.Enabled = false;
                rbjagoan.Enabled = false;
                rbMerimen.Enabled = false;
                cbClient.Enabled = false;
                txtDivision.Enabled = false;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (rbIBOS.Checked == false || rbjagoan.Checked == false || rbMerimen.Checked == false)
            {
                popupSave.ShowOnPageLoad = false;
                string msg = "Please the select Database first";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Oops...',html: '" + msg + "' });</script>",
                false);

                return;
            }
            if (cbPolicyNo.Text.ToString().Trim() == "" || cbChasisNo.Text.ToString().Trim() == "" || cbEngineNo.ToString().Trim() == "" || cbInsurance.ToString().Trim() == "")
            {
                popupSave.ShowOnPageLoad = false;
                string msg = "<b>Policy / Chasis / Engine / Insurance</b> Can not be empty!";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Oops...',html: '" + msg + "' });</script>",
                false);
                return;
            }
            if (DateofLoss.Text.ToString().Trim() == "" || WorkshopEntryDate.Text.ToString().Trim() == "" || WorkshopEntryDate.Text.ToString().Trim() == "")
            {
                popupSave.ShowOnPageLoad = false;
                string msg = "<b>Date Off Loss / Workshop Entry Date / repairer Estimate</b> Can not be empty!";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Oops...',html: '" + msg + "' });</script>",
                false);
                
                return;
            }
 

        }

        private void Update_DataClaim()
        {
            string xID = Request.QueryString["Pid"];
            DataTable getTransactionNumber = Upload.getTransactionNum(Convert.ToInt64(xID));
            string PolNo = cbPolicyNo.Text.ToString().Trim();
            string ChasisNo = cbChasisNo.Text.ToString().Trim();
            string EngineNo = cbEngineNo.Text.ToString().Trim();
            string TransactionNumber = getTransactionNumber.Rows[0]["TransactionNumber"].ToString().Trim();
            string DateOfLoss = DateofLoss.Text.ToString().Trim();
            string ClaimDemage = cbClaimDemage.Text;
            float AmountApproved = 0;
            if (txtAmountApproved.Text.Trim() != "")
            {
                AmountApproved = Convert.ToSingle(txtAmountApproved.Text.Trim());
            }
            string finishdate = txtFinishDate.Text.ToString().Trim();
            string RepiereStatus = RepairingStatus.Text.Trim();

            myClass.InsertDataToHistory(PolNo, ChasisNo, EngineNo, DateOfLoss);
            long UpdateToDatabase = Upload.UpdateDataToDatabase(xID, AmountApproved, RepiereStatus, finishdate, ClaimDemage);

            if (UpdateToDatabase > 0)
            {
                string session = Session["userName"].ToString().Trim();
                string Amount = txtAmountApproved.Text.ToString().Trim();
                string InsuranceName = cbInsurance.Text.ToString().Trim();
                string Module = "ClaimApp";
                string Form = "ClaimManual";
                string Action = "Update";
                string Remark = "Username : " + session + "<br>Has updated code data Transaction : <b>" + TransactionNumber + "</b><br>Polcy No : <b>" + PolNo + "</b> , Chasis Number : <b>" + ChasisNo + "</b> , ";
                Remark += "Engine Number : <b>" + EngineNo + "</b> , Insurance name : <b>" + InsuranceName + "</b> , Amount Approve : <b>" + Amount + "</b> , ";
                Remark += "Finish Date : <b>" + finishdate + "</b> , Repairing Status : <b>" + RepiereStatus + "</b> , ClaimDemage : <b>" + ClaimDemage + "</b>";
                AuditTrail.SaveAuditTrail(Module, Form, Action, Remark, session);

                ClearItemsUpdate();
                string msg = "Your Transaction Data by Number <br> <b>" + TransactionNumber + "</b> <br>Success has been Update!";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'success',title: 'Yeay...',html: '" + msg + "' });</script>",
                false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                ClearItemsUpdate();
                string msg = " We have stored your data with the Transaction Number <br><b>" + TransactionNumber + "</b><br>Failed Update! <br>Please Contach to Administration";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Oops...',html: '" + msg + "' });</script>",
                false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        private void ClearItemsUpdate()
        {
            cbClient.Enabled = false;
            txtDivision.Enabled = false;
            cbClient.Enabled = false;
            txtRepairerEstimate.Enabled = false;
            txtFinishDate.Enabled = false;
            cbPoliceNumber2.Enabled = false;
            cbChasisNo.Enabled = false;
            cbPolicyNo.Enabled = false;
            cbEngineNo.Enabled = false;
            cbInsurance.Enabled = false;
            DateofLoss.Enabled = false;
            WorkshopEntryDate.Enabled = false;
            cbWorkshop.Enabled = false;
            cbVehicleModel.Enabled = false;
            WorkshopEntryDate.Enabled = false;
            txtAmountApproved.Enabled = false;
            RepairingStatus.Enabled = false;
            WorkshopEntryDate.Enabled = false;
            SPKDate.Enabled = false;
        }

        private void Save_DataClaim()
        {
            string ClientCode = cbClient.Value.ToString().Trim();
            string DivName = txtDivision.Text.ToString().Trim();
            string Db = hidDB.Value.ToString().Trim();
            string PolNo = cbPolicyNo.Text.ToString().Trim();
            string ClientName = cbClient.Text.ToString().Trim();
            string ChasisNo = cbChasisNo.Text.ToString().Trim();
            string EngineNo = cbEngineNo.Text.ToString().Trim();
            string InsuranceName = cbInsurance.Text.ToString().Trim();
            string DateOfLoss = DateofLoss.Text.ToString().Trim();
            string Workshop = cbWorkshop.Text.Trim();
            string VehicleModel = cbVehicleModel.Text.ToString().Trim();
            string PoliceNumber = cbPoliceNumber2.Text.ToString().Trim();
            string RepiererEstimated = WorkshopEntryDate.Text.ToString().Trim();
            float AmountApproved = 0;
            if (txtAmountApproved.Text.Trim() != "")
            {
                AmountApproved = Convert.ToSingle(txtAmountApproved.Text.Trim());
            }
            string WorkEntryDate = WorkshopEntryDate.Text.ToString().Trim();
            string FinishDate = "";
            if (txtFinishDate.Text.ToString().Trim() == "")
            {
                FinishDate = "01/01/1900";
            }
            string RepiereStatus = RepairingStatus.Text.Trim();
            string SpkDate = SPKDate.Text.ToString().Trim();
            string Type = string.Empty;
            Int64 PolID = 0;
            Int64 PolMain = 0;
            string TransactionNumber = getGenerateTransactionNumber.Rows[0]["TransactionNumber"].ToString().Trim();
            DataTable getDataPolInsurance = new DataTable();
            getDataPolInsurance = Upload.getDataInsurance(PolNo, ChasisNo, EngineNo, InsuranceName, ref Type, ref PolID, ref PolMain);
            if (getDataPolInsurance.Rows.Count > 0)
            {
                Type = getDataPolInsurance.Rows[0]["CLIENT_TYPE"].ToString().Trim();
                PolID = Convert.ToInt64(getDataPolInsurance.Rows[0]["POLID_A"].ToString().Trim());
                PolMain = Convert.ToInt64(getDataPolInsurance.Rows[0]["POLMAINID"].ToString().Trim());
            }
            string session = Session["userName"].ToString().Trim();
            string ClaimDemage = cbClaimDemage.Text;
            DataTable dtcheck = Upload.CheckData(PolNo, ChasisNo, EngineNo, DateOfLoss);
            if (dtcheck.Rows.Count > 0)
            {
                myClass.DeleteDataAndInsertToHistory(PolNo, ChasisNo, EngineNo, DateOfLoss);
            }
            long InsertToDatabase = Upload.InsertSingleDataToDatabase(Db,PolNo, ChasisNo, EngineNo, InsuranceName, DateOfLoss, WorkEntryDate, FinishDate,
                Workshop, VehicleModel, AmountApproved, PoliceNumber, RepiererEstimated, RepiereStatus, Type, PolID, PolMain, session, TransactionNumber,SpkDate, ClaimDemage, DivName, ClientCode, ClientName);

            if (InsertToDatabase > 0)
            {
                string Amount = txtAmountApproved.Text.Trim();
                string Module = "ClaimApp";
                string Form = "ClaimManual";
                string Action = "Save";
                string Remark = "Username : " + session + "<br>Have Stored Data with Code Transaction : <b>" + TransactionNumber + "</b><br>Polcy No : <b>" + PolNo + "</b> , Chasis Number : <b>" + ChasisNo + "</b> , ";
                Remark += "Engine Number : <b>" + EngineNo + "</b> , Insurance name : <b>" + InsuranceName + "</b> , Workshop : <b>" + Workshop + "</b>  , DateOfLoss : <b>" + DateOfLoss + "</b> , Police Number : <b>" + PoliceNumber + "</b> , ";
                Remark += "Vehicle Model : <b>" + VehicleModel + "</b> , WorkshopEntryDate : <b>" + WorkEntryDate + "</b> , Repairer Estimate : <b>" + RepiererEstimated + "</b> , Amount Approve : <b>" + Amount + "</b> , ";
                Remark += "Finish Date : <b>" + FinishDate + "</b> , Repairing Status : <b>" + RepiereStatus + "</b> , SpkDate : <b>" + SpkDate + "</b> , ClaimDemage : <b>" + ClaimDemage + "</b>";
                AuditTrail.SaveAuditTrail(Module, Form, Action, Remark, session);

                ClearItems();
                string msg = " We have stored your data with the Transaction Number <b>" + TransactionNumber + "</b>";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'success',title: 'Yeay...',html: '" + msg + "' });</script>",
                false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                ClearItems();
                string msg = "Sorry, your data failed to save, please contact the administrator";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Oops...',html: '" + msg + "' });</script>",
                false);
                Context.ApplicationInstance.CompleteRequest();
            }
            
        }

        private void ClearItems()
        {
            btnSave.Enabled = false;
            txtDivision.Enabled = false;
            cbClient.Enabled = false;
            txtRepairerEstimate.Enabled = false;
            txtFinishDate.Enabled = false;
            cbPoliceNumber2.Enabled = false;
            cbChasisNo.Enabled = false;
            cbPolicyNo.Enabled = false;
            cbEngineNo.Enabled = false;
            cbInsurance.Enabled = false;
            DateofLoss.Enabled = false;
            WorkshopEntryDate.Enabled = false;
            cbWorkshop.Enabled = false;
            cbVehicleModel.Enabled = false;
            WorkshopEntryDate.Enabled = false;
            txtAmountApproved.Enabled = false;
            RepairingStatus.Enabled = false;
            WorkshopEntryDate.Enabled = false;
            SPKDate.Enabled = false;
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClaimMV_Manual.aspx");
            Context.ApplicationInstance.CompleteRequest();
        }
        protected void btnSaveYes_Click(object sender, EventArgs e)
        {
            if (btnSave.Text == "Save")
            {
                Save_DataClaim();
                string TransactionNumber = getGenerateTransactionNumber.Rows[0]["TransactionNumber"].ToString().Trim();
                lblTransactionNumber.Text = TransactionNumber;
                Context.ApplicationInstance.CompleteRequest();
            }
            else if (btnSave.Text == "Update")
            {
                Update_DataClaim();
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void cbInsurance_SelectedIndexChanged(object sender, EventArgs e)
        {
            string PolNo = cbPolicyNo.Text.ToString().Trim();
            string ChasisNo = cbChasisNo.Text.ToString().Trim();
            string EngineNo = cbEngineNo.Text.ToString().Trim();
            string InsuranceName = cbInsurance.Text.ToString().Trim();
            string Type = string.Empty;
            Int64 PolID = 0;
            Int64 PolMain = 0;
            DataTable getDataPolInsurance = new DataTable();
            getDataPolInsurance = Upload.getDataInsurance(PolNo, ChasisNo, EngineNo, InsuranceName, ref Type, ref PolID, ref PolMain);
            PolID = Convert.ToInt64(getDataPolInsurance.Rows[0]["POLID_A"].ToString().Trim());
            string Status =  Upload.CheckStatusPaid(PolID);
            var strStatus = Status.Split('-');
            string ClientToBroker = strStatus[0];
            string BrokerToInsurance = strStatus[1];
            string xLiterial = "Client To Broker :<b> " + ClientToBroker + "</b> , Broker To Insurance : <b>" + BrokerToInsurance + "</b>";
            lblStatusPaid.Text = xLiterial;
        }

        protected void cbChasisNo_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void cbPolicyNo_SelectedIndexChanged(object sender, EventArgs e)
        {
            string polno = cbPolicyNo.Text.ToString().Trim();
            string clientcode = cbClient.Value.ToString().Trim();
            string divname = "";
            divname = Upload.getDivName(polno, clientcode);
            if (divname != null || divname != "")
            {
                txtDivision.Text = divname;
            }
        }

        protected void btnChoosedb_Click(object sender, EventArgs e)
        {
            if (rbMerimen.Checked == true)
            {
                string msg = "currently this feature is not available";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Sorry',html: '" + msg + "' });</script>",
                false);
            }
            else if (rbjagoan.Checked == true)
            {
                string msg = "currently this feature is not available";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Sorry',html: '" + msg + "' });</script>",
                false);
            }
            else if (rbIBOS.Checked == true)
            {
                cbPolicyNo.DataSource = dsCbPolicyNo;
                //cbPolicyNo.DataBind();
                hidDB.Value = "131.100.100.100\\sql2008";
            }

            //select DISTINCT PolID,ChassisNo,EngineNo,PoliceNo,Type AS TypeVehicle from POLDetail_3
        }

        protected void cbPoliceNumber2_TextChanged(object sender, EventArgs e)
        {
            string NoPolice = cbPoliceNumber2.Text.ToString().Trim();
            mytable = myClass.getDataClaim(NoPolice);
            if (mytable.Rows.Count > 0)
            {

                //cbClient.Value = mytable.Rows[0]["ClientName"].ToString().Trim();
                //cbClient.DataSource = dsClientName;
                //cbClient.DataBind();
                cbPolicyNo.Value = mytable.Rows[0]["PolNo"].ToString().Trim();
                cbChasisNo.Value = mytable.Rows[0]["ChassisNo"].ToString().Trim();
                cbEngineNo.Value = mytable.Rows[0]["EngineNo"].ToString().Trim();
                cbVehicleModel.Value = mytable.Rows[0]["TypeVehicle"].ToString().Trim();
                //txtDivision1.Value = mytable.Rows[0]["DivName"].ToString().Trim();
            }
            else
            {
                string msg = "Sorry,Data Not Found";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Oops...',html: '" + msg + "' });</script>",
                false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        private void cbClient_Bind(DataTable mytable)
        {

        }
    }
}