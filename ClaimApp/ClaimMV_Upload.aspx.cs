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
    public partial class ClaimUpload : System.Web.UI.Page
    {
        public DataTable getGenerateTransactionNumber = Upload.getGenerateTransacNum();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] == null)
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();

            }
            string session = Session["userName"].ToString().Trim();
            DataTable getTotal = Upload.getTotalUploadFile(session);
            lblTotal.Text = getTotal.Rows[0]["Total"].ToString().Trim();
            gridClaimMotorVehicle.DataBind();
            BootstrapGridView1.DataBind();
            //if (Session["path"] != null)
            //{
            //    lblTitle.Text = Session["path"].ToString().Trim();
            //}

        }

        protected void buFileUpload_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            e.CallbackData = SavePostedFile(e.UploadedFile);
        }

        private string SavePostedFile(UploadedFile uploadedFile)
        {
            try
            {
                //Session["path"] = null;
                string TransactionNumber = getGenerateTransactionNumber.Rows[0]["TransactionNumber"].ToString().Trim();
                //lblTitle.Text = TransactionNumber;
                string cekfile = Server.MapPath(ConfigurationManager.AppSettings["Upload"].ToString()) + uploadedFile.FileName;
                if (File.Exists(cekfile))
                {
                    File.Delete(cekfile);
                }
                uploadedFile.SaveAs(Server.MapPath(ConfigurationManager.AppSettings["Upload"].ToString()) + uploadedFile.FileName);

                #region Validate Excel And Database
                DataTable dtExcel = Excel.Excel.ExcelPackageToDataTable(cekfile);

                string session = Session["username"].ToString().Trim();
                string type_input = "Upload Input";
                string db = "131.100.100.100\\sql2008";
                new Thread(new ParameterizedThreadStart(Upload.InsertExcelToTemp)).Start(new object[] { dtExcel, session, type_input, db });

                string Module = "ClaimApp";
                string Form = "ClaimUpload";
                string Action = "UploadFile";
                string Remark = "Username : " + session + "<br>Has Been upload File With Name File Upload : <b>" + uploadedFile.FileName + "</b> , TransactionNumber : <b>" + TransactionNumber + "</b>";
                AuditTrail.SaveAuditTrail(Module, Form, Action, Remark, session);
                #endregion

                return uploadedFile.FileName;
            }
            catch (Exception ex)
            {
                //lblTitle.Text = ex.Message;
                throw ex;
            }
        }
        protected void btnChoosedb_Click(object sender, EventArgs e)
        {
            if (rbIBOS.Checked == true)
            {
                buFileUpload.Visible = true;
                buFileUploadJagoan.Visible = false;
                buFileUploadMerimen.Visible = false;
               
            }
            else if (rbMerimen.Checked == true)
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
        }

        protected void gridClaimMotorVehicle_RowCommand(object sender, ASPxGridViewRowCommandEventArgs e)
        {
            try
            {
                string msg = "";
                string xID = e.CommandArgs.CommandArgument.ToString();
                string statusPaidClient = Upload.GetStatusPaid(xID);
                //string statusPaidInsurance = Upload.GetStatusInsurance(xID);
                if (statusPaidClient != null)
                {
                    //var strSplit = statusPaidClient.Split(new char[] { '-' });
                    var strSplit = statusPaidClient.Split('-');
                    string ClientToBroker = strSplit[0];
                    string BrokerToInsurance = strSplit[1];
                    msg = "Status Payment <br> Client To Broker : <b>" + ClientToBroker + "</b><br> Broker To Insurance : <b>" + BrokerToInsurance + "</b>";
                    ScriptManager.RegisterStartupScript(
                    this,
                    typeof(Page),
                    "Alert", "<script>Swal.fire({ icon: 'info',title: 'Information',html: '" + msg + "' });</script>",
                    false);
                    return;
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            string xFileName = "report_ibu.xlsx";
            string Path = Server.MapPath(ConfigurationManager.AppSettings["Upload"].ToString())+xFileName;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path);
            Response.WriteFile(Path);
            Response.End();
        }
    }
}