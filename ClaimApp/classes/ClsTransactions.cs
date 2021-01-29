using ClaimApp.classes;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ClaimApp
{
    public class ClsTransactions
    {
        private static readonly Object _seqLock = new Object();
        public static bool createNewSeqNo(string TransDesc, ref string TransNumb)
        {
            bool ret = false;
            int newSeqNo = 0;
            try
            {
                lock (_seqLock)
                {
                    if (getTransactions_NewSeqNo(TransDesc, ref newSeqNo))
                    {
                        string _today = string.Format("{0:yyyy-MM-dd}", DateTime.Now);
                        string period = _today.Replace("-", "").Substring(0, 6);

                        if (TransDesc == "Buy")
                        {
                            TransNumb = "BUY-" + period + "-" + newSeqNo.ToString().PadLeft(6, '0');
                        }
                        else
                        {
                            TransNumb = "SELL-" + period + "-" + newSeqNo.ToString().PadLeft(6, '0');
                        }
                        
                        long newTranasction_Pid = addTransactions(newSeqNo, TransDesc, TransNumb);
                        if (newTranasction_Pid == 0)
                        { newSeqNo = 0; TransNumb = string.Empty; ret = false; }
                        else
                        { ret = true; }
                    }
                }
            }
            catch (Exception ex) { ClsMain.saveErrorLog("ClsTransactions:createNewSeqNo:" + ex.ToString()); }
            finally { }
            return ret;
        }


        private static readonly Object _addTransactions = new Object();
        private static long addTransactions(Int32 SeqNo, string TransDesc, string TransNumb)
        {
            lock (_addTransactions)
            {
                long ret = 0;
                try
                {

                    // untuk mendapatkan Lat/Lng nya pakai sql command di bawah ini..
                    //string sql = "select GeoPos.Lat,GeoPos.Long From Transaction";

                    string sql = "Insert Into ibu.dbo.Reksa_TransactionNumber " +
                                  "(SeqNo, TransDesc, Cdatetime, TransNumb) " +
                                  "Output Inserted.Pid Values " +
                                  "(@SeqNo, @TransDesc, getdate(), @TransNumb)";
                    using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                    {
                        try
                        {
                            cmd.Connection.Open();
                            cmd.CommandTimeout = CONST.COMMAND_TIMEOUT;
                            cmd.Parameters.AddWithValue("@SeqNo", SeqNo);
                            cmd.Parameters.AddWithValue("@TransDesc", TransDesc);
                            cmd.Parameters.AddWithValue("@TransNumb", TransNumb);
                            ret = (long)cmd.ExecuteScalar();
                        }
                        catch (SqlException ex) { ClsMain.saveErrorLog("ClsTransactions:addTransaction: " + ex.ToString()); }
                        finally
                        {
                            if (cmd.Connection.State == System.Data.ConnectionState.Open)
                                cmd.Connection.Close();
                        }
                    }
                }
                catch (Exception ex) { ClsMain.saveErrorLog("ClsTransactions:addTransaction: " + ex.ToString()); }
                finally { }
                return ret;
            }
        }

        private static readonly Object _getTransactions_NewSeqNo = new Object();
        private static bool getTransactions_NewSeqNo(string TransDesc, ref int new_seqno)
        {
            lock (_getTransactions_NewSeqNo)
            {
                bool ret = false;
                new_seqno = 0;
                try
                {

                    string sql = "Select isnull(Max(SeqNo),0) as SeqNo From ibu.dbo.Reksa_TransactionNumber WITH (NOLOCK) where Year(Cdatetime) = Year(getdate()) And Month(Cdatetime) = Month(Getdate()) And TransDesc=@TransDesc";
                    using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                    {
                        try
                        {
                            cmd.Connection.Open();
                            cmd.CommandTimeout = CONST.COMMAND_TIMEOUT;
                            cmd.Parameters.AddWithValue("@TransDesc", TransDesc);
                            using (SqlDataReader dr = cmd.ExecuteReader())
                            {
                                if (dr.Read())
                                {
                                    new_seqno = dr.GetInt32(dr.GetOrdinal("SeqNo"));
                                }
                                new_seqno++;
                                ret = true;
                            }
                        }
                        catch (SqlException ex) { ClsMain.saveErrorLog("ClsTransactions:getTransactions_NewSeqNo: " + ex.ToString()); }
                        finally
                        {
                            if (cmd.Connection.State == System.Data.ConnectionState.Open)
                                cmd.Connection.Close();
                        }
                    }
                }
                catch (Exception ex) { ClsMain.saveErrorLog("ClsTransactions:getTransactions_NewSeqNo:" + ex.ToString()); }
                finally { }
                return ret;
            }
        }
        public static long addBuyTransaction(string Transaction_Number, long InvestmentName_Pid, long Currency_Pid, long Kurs_Pid, long PriceInvestment_Pid, double TotalUnit, string UserID, DateTime BuyDate, double Rate, long Securitas_Pid)
        {
            long result = 0;

            try
            {

                string sql = "insert into ibu.dbo.Reksa_TRBuy " +
                                "(" +
                                "    InvestmentName_Pid, " +
                                "    Currency_Pid, " +
                                "    Kurs_Pid, " +
                                "    PriceInvestment_Pid, " +
                                "    TotalUnit, " +
                                "    UserID, " +
                                "    Transaction_Number, " +
                                "    BuyDate, " +
                                "    Rate, " +
                                "    Securitas_Pid " +
                                ") Output Inserted.Pid values " +
                                "(" +
                                "    @InvestmentName_Pid, " +
                                "    @Currency_Pid, " +
                                "    @Kurs_Pid, " +
                                "    @PriceInvestment_Pid, " +
                                "    @TotalUnit, " +
                                "    @UserID, " +
                                "    @Transaction_Number, " +
                                "    @BuyDate, " +
                                "    @Rate, " +
                                "    @Securitas_Pid " +
                                ")";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@InvestmentName_Pid", InvestmentName_Pid);
                        cmd.Parameters.AddWithValue("@Currency_Pid", Currency_Pid);
                        cmd.Parameters.AddWithValue("@Kurs_Pid", Kurs_Pid);
                        cmd.Parameters.AddWithValue("@PriceInvestment_Pid", PriceInvestment_Pid);
                        cmd.Parameters.AddWithValue("@TotalUnit", TotalUnit);
                        cmd.Parameters.AddWithValue("@UserID", UserID);
                        cmd.Parameters.AddWithValue("@Transaction_Number", Transaction_Number);
                        cmd.Parameters.AddWithValue("@BuyDate", BuyDate);
                        cmd.Parameters.AddWithValue("@Rate", Rate);
                        cmd.Parameters.AddWithValue("@Securitas_Pid", Securitas_Pid);
                        result = (long)cmd.ExecuteScalar();
                    }
                    catch (SqlException ex)
                    {
                        ClsMain.saveErrorLog("ClsTransactions : addBuyTransaction : " + ex.ToString());
                    }
                    finally
                    {
                        if (cmd.Connection.State == System.Data.ConnectionState.Open)
                            cmd.Connection.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                ClsMain.saveErrorLog("ClsTransactions : addBuyTransaction : " + ex.ToString());
            }
            finally { }

            return result;
        }
        public static long addSellTransaction(string Transaction_Number, long TRBuy_Pid, long Currency_Pid, long Kurs_Pid, long PriceInvestment_Pid, double TotalUnit, string UserID, DateTime SellDate, double Rate)
        {
            long result = 0;

            try
            {

                string sql = "insert into ibu.dbo.Reksa_TRSell " +
                                "(" +
                                "    TRBuy_Pid, " +
                                "    Currency_Pid, " +
                                "    Kurs_Pid, " +
                                "    PriceInvestment_Pid, " +
                                "    TotalUnit, " +
                                "    UserID, " +
                                "    Transaction_Number, " +
                                "    SellDate, " +
                                "    Rate " +
                                ") Output Inserted.Pid values " +
                                "(" +
                                "    @TRBuy_Pid, " +
                                "    @Currency_Pid, " +
                                "    @Kurs_Pid, " +
                                "    @PriceInvestment_Pid, " +
                                "    @TotalUnit, " +
                                "    @UserID, " +
                                "    @Transaction_Number, " +
                                "    @SellDate, " +
                                "    @Rate " +
                                ")";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@TRBuy_Pid", TRBuy_Pid);
                        cmd.Parameters.AddWithValue("@Currency_Pid", Currency_Pid);
                        cmd.Parameters.AddWithValue("@Kurs_Pid", Kurs_Pid);
                        cmd.Parameters.AddWithValue("@PriceInvestment_Pid", PriceInvestment_Pid);
                        cmd.Parameters.AddWithValue("@TotalUnit", TotalUnit);
                        cmd.Parameters.AddWithValue("@UserID", UserID);
                        cmd.Parameters.AddWithValue("@Transaction_Number", Transaction_Number);
                        cmd.Parameters.AddWithValue("@SellDate", SellDate);
                        cmd.Parameters.AddWithValue("@Rate", Rate);
                        result = (long)cmd.ExecuteScalar();
                    }
                    catch (SqlException ex)
                    {
                        ClsMain.saveErrorLog("ClsTransactions : addSellTransaction : " + ex.ToString());
                    }
                    finally
                    {
                        if (cmd.Connection.State == System.Data.ConnectionState.Open)
                            cmd.Connection.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                ClsMain.saveErrorLog("ClsTransactions : addSellTransaction : " + ex.ToString());
            }
            finally { }

            return result;
        }
    }
}