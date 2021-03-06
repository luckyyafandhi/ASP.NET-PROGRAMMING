﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClaimApp.classes;
using System.Data.SqlClient;

namespace ClaimApp
{
    public partial class InvestBuy : System.Web.UI.Page
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
            lblSuccess.Visible = false;
            lblError.Visible = false;

            string _TransNumb = string.Empty;
            long _BuyPid = 0;

            if (ClsTransactions.createNewSeqNo("Buy", ref _TransNumb))
            {
                try
                {
                    _BuyPid = ClsTransactions.addBuyTransaction(_TransNumb, Convert.ToInt64(cboInvestName.Value), Convert.ToInt64(cboCurrency.Value), Convert.ToInt64(cboKurs.Value), Convert.ToInt64(cboPrice.Value), Convert.ToDouble(txtUnit.Text), Session["userName"].ToString(), (DateTime)txtTglBeli.Value, Convert.ToDouble(txtRate.Text), Convert.ToInt64(cboSecuritas.Value));
                }
                catch (SqlException ex)
                {
                    classes.ClsMain.saveErrorLog("InvestBuy.aspx : btnSaveYes_Click : " + ex.ToString());
                    lblErrorText.InnerText = "Gagal Menyimpan Transaksi Pembelian, Harap Hubungi Administrator";
                    lblError.Visible = true;
                    return;
                }
                finally
                {
                }
            }

            if (_BuyPid > 0)
            {
                lblSuccessText.InnerHtml = "Transaksi Pembelian Berhasil Disimpan";
                lblSuccess.Visible = true;
                bfl1.Enabled = false;
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                lblErrorText.InnerText = "Gagal Menyimpan Transaksi Pembelian, Harap Hubungi Administrator";
                lblError.Visible = true;
                return;
            }
        }
    }
}