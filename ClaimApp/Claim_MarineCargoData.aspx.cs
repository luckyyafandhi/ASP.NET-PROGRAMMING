using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MarineCargo = ClaimApp.classes.ClsMarineCargo;

namespace ClaimApp
{

    public partial class Claim_MarineCargoData : System.Web.UI.Page
    {
        #region Support
        private void EmptyTemp()
        {
            ViewState["Detail"] = CreateDetailTable();
            GVMarineCargoDetail_bind();
        }

        private void EmptyDetail()
        {
            txtEstimate.Text = "";
            txtAdjustedLoss.Text = "";
            txtSalvage.Text = "";
            txtDeductible.Text = "";
            NetClaim.Value = "";
            txtQuantity.Text = "";
            txtQuantityAsPerBL.Text = "";
            txtQuantityShortage.Text = "";
        }

        private void GVMarineCargoDetail_bind()
        {
            DataTable Temp = ViewState["Detail"] as DataTable;
            gridMarineCargoDetail.DataSource = Temp;
            gridMarineCargoDetail.DataBind();
        }

        private static DataTable CreateDetailTable()
        {
            DataTable myDataTable = new DataTable();
            DataColumn myDataColumn;

            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "Pid";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "Currency";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "Estimate";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "AdjustedLoss";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "Salvage";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "Deductible";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "NetClaim";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "QuantityAsPerBL";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "QuantityReceived";
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.DataType = Type.GetType("System.String");
            myDataColumn.ColumnName = "QuantityShortage";
            myDataTable.Columns.Add(myDataColumn);
            return myDataTable;
        }
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] == null)
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
            }

            lblTitle.Text = (Request.QueryString["Pid"] == null ? "New Marine Cargo" : "Edit Marine Cargo");
            hidPID.Value = (Request.QueryString["Pid"] == null ? "0" : Request.QueryString["Pid"]);

            //if (!Page.IsPostBack)
            //{

            //    EmptyDetail();
            //    string xFunction = "";
            //    string xID = "";
            //    if (Request["Function"] != null)
            //    {
            //        xFunction = Request["Function"].ToString();
            //    }
            //    if (Request["ID"] != null)
            //    {
            //        xID = Request["ID"].ToString();
            //    }

            //    if (xFunction != "" && xID != "")
            //    {
            //        if (xFunction == "AddDetail")
            //        {
            //            if (ViewState["Detail"] == null)
            //            {
            //                EmptyTemp();
            //                pnlDetail.Visible = true;
            //                pnlHeader.Visible = false;
            //            }
            //            else
            //            {
            //                pnlDetail.Visible = true;
            //                pnlHeader.Visible = false;
            //            }

            //        }
            //    }
            //    else
            //    {
            //        pnlHeader.Visible = true;
            //        pnlDetail.Visible = false;
            //        //GVMarineCargoDetail_bind();
            //    }
            //}
            pnlHeader.Visible = true;
            pnlDetail.Visible = false;
        }

        protected void btNew_Click(object sender, EventArgs e)
        {
            //string xID = "AddNewDetail";
            //ViewState["AddDetail"] = xID;
            DataTable dt = ViewState["Detail"] as DataTable;
            //if (dt == null)
            //{
            //    Response.Redirect("Claim_MarineCargoData.aspx?Function=AddDetail&ID=" + xID);
            //}
            //else
            //{
            //    pnlDetail.Visible = true;
            //    pnlHeader.Visible = false;
            //}
            if (dt == null)
            {
                pnlDetail.Visible = true;
                pnlHeader.Visible = false;
                EmptyTemp();
            }
            else
            {
                pnlDetail.Visible = true;
                pnlHeader.Visible = false;
            }
        }

        protected void btnSaveDetail_Click(object sender, EventArgs e)
        {
            saveDataDetail();
        }

        protected void btnbackDetail_Click(object sender, EventArgs e)
        {
            pnlHeader.Visible = true;
            pnlDetail.Visible = false;
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {

        }
        private void saveDataDetail()
        {
            string xCurrency = cbCurrency.Text.ToString().Trim();
            float xEstimate = 0;
            if (txtEstimate.Text.ToString().Trim() != "")
            {
                xEstimate = Convert.ToSingle(txtEstimate.Text.ToString().Trim());
            }
            float xAdjustedLoss = 0;
            if (txtAdjustedLoss.Text.ToString().Trim() != "")
            {
                xAdjustedLoss = Convert.ToSingle(txtAdjustedLoss.Text.ToString().Trim());
            }
            float xSalvage = 0;
            if (txtSalvage.Text.ToString().Trim() != "")
            {
                xSalvage = Convert.ToSingle(txtSalvage.Text.ToString().Trim());
            }
            float xdeductible = 0;
            if (txtDeductible.Text.ToString().Trim() != "")
            {
                xdeductible = Convert.ToSingle(txtDeductible.Text.ToString().Trim());
            }
            float xNetClaim = 0;
            if (NetClaim.Value.ToString().Trim() != "")
            {
                xNetClaim = Convert.ToSingle(NetClaim.Value.ToString().Trim());
            }
            float xQuantityAsPerBL = 0;
            if (txtQuantityAsPerBL.Text.ToString().Trim() != "")
            {
                xQuantityAsPerBL = Convert.ToSingle(txtQuantityAsPerBL.Text.ToString().Trim());
            }
            float xQuantityReceived = 0;
            if (txtQuantity.Text.ToString().Trim() != "")
            {
                xQuantityReceived = Convert.ToSingle(txtQuantity.Text.ToString().Trim());
            }
            float xQuantityShortage = 0;
            if (txtQuantityShortage.Text.ToString().Trim() != "")
            {
                xQuantityShortage = Convert.ToSingle(txtQuantityShortage.Text.ToString().Trim());
            }
            DataTable dt = ViewState["Detail"] as DataTable;
            #region Progress
            int LastID = dt.Rows.Count;
            int xID = LastID + 1;
            AddDetailTemp(xID, xCurrency, xEstimate, xAdjustedLoss, xSalvage, xdeductible, xNetClaim, xQuantityAsPerBL, xQuantityReceived, xQuantityShortage, dt);
            GVMarineCargoDetail_bind();
            EmptyDetail();
            pnlDetail.Visible = true;
            pnlHeader.Visible = false;
            #endregion

        }

        private void AddDetailTemp(int xID, string xCurrency, float xEstimate, float xAdjustedLoss, float xSalvage, float xdeductible, float xNetClaim, float xQuantityAsPerBL, float xQuantityReceived, float xQuantityShortage, DataTable myTable)
        {
            try
            {
                DataRow row;
                row = myTable.NewRow();
                row["Pid"] = xID;
                row["Currency"] = xCurrency;
                row["Estimate"] = xEstimate;
                row["AdjustedLoss"] = xAdjustedLoss;
                row["Salvage"] = xSalvage;
                row["Deductible"] = xdeductible;
                row["NetClaim"] = xNetClaim;
                row["QuantityAsPerBL"] = xQuantityAsPerBL;
                row["QuantityReceived"] = xQuantityReceived;
                row["QuantityShortage"] = xQuantityShortage;

                myTable.Rows.Add(row);
            }
            catch (Exception)
            {
                throw;
            }
        }
        [System.Web.Services.WebMethod]
        protected void btnSave_Click(object sender, EventArgs e)
        {

        }

        protected void btnSaveYes_Click(object sender, EventArgs e)
        {
            #region Variable
            bool IBURE = chkboxIBURE.Checked;
            string Sertificate = cbSertificate.Text.ToString().Trim();
            string MOPno = txtMOPno.Text.ToString().Trim();
            string InterestInsure = txtareaRemarkInterest.Text.ToString().Trim();
            string DOR = "";
            if (txtDOR.Text.ToString() != "")
            {
                DOR = txtDOR.Text.ToString().Trim();
            }
            string DOL = "";
            if (txtDOL.Text.ToString() != "")
            {
                DOL = txtDOL.Text.ToString().Trim();
            }
            string Rdate = "";
            if (txtRdate.Text.ToString() != "")
            {
                Rdate = txtRdate.Text.ToString().Trim();
            }
            string CauseOfLoss = cbCouseOfLoss.Text.ToString();
            string dateSurvey = "";
            if (txtSurveyDate.Text.ToString() != "")
            {
                dateSurvey = txtSurveyDate.Text.ToString();
            }
            string Status = cbSurveyType.Text.ToString().Trim();
            string StatusDate = txtStatusDate.Text.ToString().Trim();
            string Conveyence = cbConveyence.Text.ToString().Trim();
            string RemarkCoveyence = txtareaRemarkConveyence.Text.ToString().Trim();
            string Remark = txtareaRemark.Text.ToString().Trim();
            DataTable dt = ViewState["Detail"] as DataTable;
            #endregion

            #region Validation
            if (dt == null)
            {
                popupSave.ShowOnPageLoad = false;
                string msg = "Data Detail in Table Can not be empty!";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Oops...',html: '" + msg + "' });</script>",
                false);

                return;
            }
            else if (dt.Rows.Count < 0)
            {
                popupSave.ShowOnPageLoad = false;
                string msg = "Data Detail in Table Can not be empty!";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Oops...',html: '" + msg + "' });</script>",
                false);

                return;
            }
            else if (Sertificate == "" || MOPno == "" )
            {
                popupSave.ShowOnPageLoad = false;
                string msg = "Sertificate or MOPNo Can not be empty!";
                ScriptManager.RegisterStartupScript(
                this,
                typeof(Page),
                "Alert", "<script>Swal.fire({ icon: 'error',title: 'Oops...',html: '" + msg + "' });</script>",
                false);

                return;
            }
            else
            {
                #region Progress
                //Progress Insert
                #endregion
            }
            #endregion
        }

        protected void gridMarineCargoDetail_RowCommand(object sender, DevExpress.Web.ASPxGridViewRowCommandEventArgs e)
        {
            string xPid = e.CommandArgs.CommandArgument.ToString().Trim();
            DataTable dtDetail = ViewState["Detail"] as DataTable;

            switch (e.CommandArgs.CommandName)
            {
                case "DeleteRow":
                    if (dtDetail.Rows.Count > 0)
                    {
                        DataRow rowDetail = dtDetail.Select("Pid = '" + xPid + "'").FirstOrDefault();
                        rowDetail.Delete();

                        GVMarineCargoDetail_bind();
                    }
                    break;
            }
        }

        protected void cbSertificate_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Client = cbClient.Value.ToString().Trim();
            string Certificate = cbSertificate.Value.ToString().Trim();
            string MOP = MarineCargo.GetMOPNoByCertificateClient(Client, Certificate);
            txtMOPno.Text = MOP;
        }
    }
}