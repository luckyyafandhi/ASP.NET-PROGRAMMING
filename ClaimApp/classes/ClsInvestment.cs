using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web.Security;
using ClaimApp.classes;

namespace ClaimApp.classes
{
    public class ClsInvestment
    {
        public static long AddInvestmentType(string InvestmentTypeDesc, bool isActive)
        {
            long result = 0;
            
            try
            {
                string sql = "insert into Reksa_MasterInvestmentType (InvestmentType, isActive) " +
                                "Output Inserted.Pid values " +
                                "(@InvestmentType, @isActive)";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@InvestmentType", InvestmentTypeDesc);
                        cmd.Parameters.AddWithValue("@isActive", isActive);
                        result = (long)cmd.ExecuteScalar();
                    }
                    catch (SqlException ex)
                    {
                        ClsMain.saveErrorLog("ClsInvestment : AddInvestmentType : " + ex.ToString());
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
                ClsMain.saveErrorLog("ClsInvestment : AddInvestmentType : " + ex.ToString());
            }
            finally { }

            return result;
        }
    }
}