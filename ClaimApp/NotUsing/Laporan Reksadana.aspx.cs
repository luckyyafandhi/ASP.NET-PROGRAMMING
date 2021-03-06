﻿using DevExpress.Export;
using DevExpress.XtraPrinting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClaimApp
{
    public partial class Laporan_Reksadana : System.Web.UI.Page
    {
        double LastAmount = 0, TotalLastAmount = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] == null)
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
            }
            


        }

        protected void Page_Init(object sender, EventArgs e)
        {
            DateTime _Now = DateTime.Today;
            txtPeriod.Value = _Now;
        }

        protected void cboCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            dsGridReportReksa.DataBind();
            gridReportReksa.DataBind();
        }

        protected void Xls_Click(object sender, EventArgs e)
        {
            gridReportReksa.ExportXlsToResponse(new XlsExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }

        protected void Xlsx_Click(object sender, EventArgs e)
        {
            gridReportReksa.ExportXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }

        protected void txtPeriod_ValueChanged(object sender, EventArgs e)
        {
            string Period = classes.ClsMain.getDate_YMD((DateTime)txtPeriod.Value);
            dsGridReportReksa.SelectParameters["BuyDate"].DefaultValue = Period;
            dsGridReportReksa.DataBind();
            gridReportReksa.DataBind();
        }

        protected void dsGridReportReksa_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            string Period = classes.ClsMain.getDate_YMD((DateTime)txtPeriod.Value);
            e.Command.Parameters["@BuyDate"].Value = Period;
        }

        protected void CSV_Click(object sender, EventArgs e)
        {
            gridReportReksa.ExportCsvToResponse(new CsvExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        }

        //protected void gridReportReksa_CustomSummaryCalculate(object sender, DevExpress.Data.CustomSummaryEventArgs e)
        //{
        //    if (e.IsTotalSummary)
        //    {
        //        if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Start)
        //        {
        //            LastAmount = 0;
        //            TotalLastAmount = 0;
        //        }
        //        else if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Calculate)
        //        {
        //            LastAmount += Convert.ToDouble(e.GetValue("LastAmount"));
        //            TotalLastAmount += Convert.ToDouble(e.GetValue("TotalLastAmount"));
        //        }
        //        else if (e.SummaryProcess == DevExpress.Data.CustomSummaryProcess.Finalize)
        //        {
        //            e.TotalValue = string.Format("Total €{0}; ${1}", FormatDecimal(eur), FormatDecimal(usd));
        //        }
        //    }
        //}
    }
}