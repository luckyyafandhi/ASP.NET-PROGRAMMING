﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClaimApp
{
    public partial class InvestSell : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] == null)
            {
                Response.Redirect("Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
            }
        }
        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
            Context.ApplicationInstance.CompleteRequest();
        }

        protected void btnSaveYes_Click(object sender, EventArgs e)
        {
            //lblSuccess.Visible = false;
            //lblError.Visible = false;

            //string _TransNumb = string.Empty;
            //long _SellPid = 0;

            //if (ClsTransactions.createNewSeqNo("Sell", ref _TransNumb))
            //{
            //    try
            //    {
            //        _SellPid = ClsTransactions.addSellTransaction(_TransNumb, Convert.ToInt64(cboInvestName.Value), Convert.ToInt64(cboCurrency.Value), Convert.ToInt64(cboKurs.Value), Convert.ToInt64(cboPrice.Value), Convert.ToDouble(txtUnit.Text), Session["userName"].ToString());
            //    }
            //    catch (SqlException ex)
            //    {
            //        classes.ClsMain.saveErrorLog("InvestSell_Data.aspx : btnSaveYes_Click : " + ex.ToString());
            //        lblErrorText.InnerText = "Gagal Menyimpan Transaksi Penjualan, Harap Hubungi Administrator";
            //        lblError.Visible = true;
            //        return;
            //    }
            //    finally
            //    {
            //    }
            //}

            //if (_SellPid > 0)
            //{
            //    lblSuccessText.InnerHtml = "Transaksi Penjualan Berhasil Disimpan";
            //    lblSuccess.Visible = true;
            //    bfl1.Enabled = false;
            //    Context.ApplicationInstance.CompleteRequest();

            //}
        }

        protected void gridBuy_CustomColumnDisplayText(object sender, DevExpress.Web.Bootstrap.BootstrapGridViewColumnDisplayTextEventArgs e)
        {
            if (e.Column.FieldName == "SisaUnit")
            {
                if(Convert.ToDouble(e.Value) == 0D)
                {
                    e.DisplayText = "0";
                }
            }
        }
    }
}