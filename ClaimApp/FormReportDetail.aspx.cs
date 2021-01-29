using DevExpress.Web.Bootstrap;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportDetail = ClaimApp.classes.ClsReportDetail;

namespace ClaimApp
{
    public partial class FormReportDetail : Page
    {
        public ReportDetail MyClass = new ReportDetail();
        public string PolMainIDReport = "";
        public string ProgramModeReport = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] == null)
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
            }
            if (Request["ClientCode"] == null)
            {
                Response.Redirect("Home.aspx");
                Context.ApplicationInstance.CompleteRequest();
            }
            string xcode = "";
            xcode = Request["ClientCode"].ToString();
            lblTitle.Text = (Request.QueryString["ClientCode"] == null ? "Dashboard" : xcode);

            string ClientName = MyClass.GetClientName(xcode);
            lblClientName.Text = ClientName;
            pnlReportDetailAll.Visible = false;
            pnlGVReportDetailCN.Visible = false;
            pnlGVReportDetailDN.Visible = false;
        }

        protected void cbPolNo_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlReportDetailAll.Visible = true;
            pnlGVReportDetailCN.Visible = true;
            pnlGVReportDetailDN.Visible = true;

            int PolMainID = Convert.ToInt32(cbPolNo.Value.ToString());
            Session["PolMainID"] = PolMainID;
        }


        protected void gridRerportDetailDN_History_CustomUnboundColumnData(object sender, DevExpress.Web.Bootstrap.BootstrapGridViewColumnDataEventArgs e)
        {

        }

        protected void gridRerportDetailDN_History_BeforePerformDataSelect(object sender, EventArgs e)
        {

            Session["StringKey"] = (sender as BootstrapGridView).GetMasterRowKeyValue();

            string DataObject = Session["StringKey"].ToString();
            var Data = DataObject.Split('|');
            string PolID = Data[0];
            string ChassisNo = Data[1];
            string EngineNo = Data[2];

            Session["PolID"] = PolID;
            Session["ChassisNo"] = ChassisNo;
            Session["EngineNo"] = EngineNo;

        }

        protected void gridRerportDetailCN_History_CustomUnboundColumnData(object sender, BootstrapGridViewColumnDataEventArgs e)
        {

        }

        protected void gridRerportDetailCN_History_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["StringKey"] = (sender as BootstrapGridView).GetMasterRowKeyValue();
            string DataObject = Session["StringKey"].ToString();
            var Data = DataObject.Split('|');
            string PolID = Data[0];
            string ChassisNo = Data[1];
            string EngineNo = Data[2];

            Session["PolID"] = PolID;
            Session["ChassisNo"] = ChassisNo;
            Session["EngineNo"] = EngineNo;
        }
    }
}