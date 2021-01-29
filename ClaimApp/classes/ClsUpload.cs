using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web.Security;
using ClaimApp.classes;

namespace ClaimApp.classes
{
    public class ClsUpload
    {

        public static void InsertExcelToTemp(object Parameters)
        //(DataTable dtExcel, string session,string type_input)
        {
            ClsMain.saveDebugLog("Lagi Jalan Upload Claim MV");
            object[] parameterArray = (object[])Parameters;
            DataTable dtExcel = (DataTable)parameterArray[0];
            string session = (string)parameterArray[1];
            string type_input = (string)parameterArray[2];
            string db = (string)parameterArray[3];

            try
            {
                #region ValidateExcelToSP
                DataTable dt = new DataTable();
                #region Connection
                //Connection To Live Database
                //using (SqlConnection connection = new SqlConnection(ClsMain.ClaimAppConnectionStringLive()))
                //Connection To Development
                using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionString2()))
                #endregion
                {

                    connection.Open();
                    using (SqlCommand cmd = new SqlCommand("[usp_UploadClaimMV]", connection))
                    {
                        try
                        {

                            cmd.CommandTimeout = 1000000;
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@DataExcel", dtExcel);
                            cmd.Parameters.AddWithValue("@session", session);
                            cmd.Parameters.AddWithValue("Type_Input", type_input);
                            cmd.Parameters.AddWithValue("DataSource", db);
                            SqlDataAdapter da = new SqlDataAdapter(cmd);
                            da.Fill(dt);
                            connection.Close();
                            ClsMain.saveDebugLog("Sudah Selesai");
                        }
                        catch (System.OutOfMemoryException)
                        {

                        }
                        catch (Exception ex)
                        {
                            ClsMain.saveErrorLog("ClsUpload : InsertExcelToTemp : " + ex.ToString());
                        }

                    }
                }
                #endregion 
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable getDB(long xID)
        {
            DataTable dt = new DataTable();
            #region Connection
            //Connection To Live Database
            //using (SqlConnection connection = new SqlConnection(ClsMain.ClaimAppConnectionStringLive()))
            //Connection To Development
            using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionString2()))
                #endregion
                try
                {
                    connection.Open();
                    string strSql = "Select DataSource From ClaimMotorVehicle Where Pid = '" + xID + "'";
                    using (SqlCommand cmd = new SqlCommand(strSql, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                        connection.Close();
                    }
                    return dt;
                }
                catch (Exception)
                {

                    throw;
                }
        }

        public static long getPOLID(long xID)
        {
            Int64 result;
            DataTable dt = new DataTable();
            try
            {
                #region Connection
                //Connection To Live Database
                //using (SqlConnection connection = new SqlConnection(ClsMain.ClaimAppConnectionStringLive()))
                //Connection To Development
                using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionString2()))
                #endregion
                {
                    connection.Open();
                    string strSql = "Select PolID From ClaimMotorVehicle Where Pid = '" + xID + "'";
                    using (SqlCommand cmd = new SqlCommand(strSql, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                        connection.Close();
                    }
                }
                result = Convert.ToInt64(dt.Rows[0]["PolID"].ToString());
                return result;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public static DataTable getTotalUploadFile(string session)
        {
            DataTable dt = new DataTable();
            try
            {
                ClsMain.saveDebugLog("Star Class getTotalUploadFile");

                #region Connection
                //Connection To Live Database
                //using (SqlConnection connection = new SqlConnection(ClsMain.ClaimAppConnectionStringLive()))
                //Connection To Development
                using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionString2()))
                #endregion
                {
                    connection.Open();
                    string strSql = " select (select COUNT(TransactionNumber) from ClaimMotorVehicle_Temp Where TransactionNumber = (select Max(TransactionNumber) from TransactionNumber Where TransactionType = 0 And CreateBy = '" + session + "') And Type_Input = 'Upload Input' And CreateBy = '" + session + "')  ";
                    strSql += " + (select COUNT(TransactionNumber) from ClaimMotorVehicle Where TransactionNumber = (select Max(TransactionNumber) from TransactionNumber Where TransactionType = 0 And CreateBy = '" + session + "') And Type_Input = 'Upload Input' And CreateBy = '" + session + "') AS Total ";
                    using (SqlCommand cmd = new SqlCommand(strSql, connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                        connection.Close();
                        return dt;
                    }
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public static string GetStatusPaid(string xID)
        {
            string Status = "";
            long polID = 0;
            DataTable dt = new DataTable();
            #region Connection
            //Connection To Live Database
            //using (SqlConnection connection = new SqlConnection(ClsMain.ClaimAppConnectionStringLive()))
            //Connection To Development
            using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionString2()))
            #endregion
            {
                connection.Open();
                string strSql = "Select * From ClaimMotorVehicle Where Pid = '" + xID + "'";
                using (SqlCommand command = new SqlCommand(strSql, connection))
                {
                    SqlDataAdapter da = new SqlDataAdapter(command);

                    da.Fill(dt);
                    connection.Close();
                }
            }
            polID = Convert.ToInt64(dt.Rows[0]["PolID"].ToString().Trim());

            DataTable dtpaidClient = new DataTable();
            string strSql1 = "Select dbo.[fDNCNOutstandingInquiry]('IBU000',@PolID,'CL',NULL)";
            #region Connection
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql1, new SqlConnection(ClsMain.ClaimAppConnectionCoreLive())))
            //Connection To Development
            using (SqlCommand cmd = new SqlCommand(strSql1, new SqlConnection(ClsMain.ReksaAppCoreConnectionString())))
            #endregion
            {
                try
                {
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@PolID", polID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dtpaidClient);
                    cmd.Connection.Close();
                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : CheckStatusPaid : " + ex.ToString());
                }

            }
            DataTable dtPaidInsurance = new DataTable();
            string strSql2 = "Select dbo.[fDNCNOutstandingInquiry]('IBU000',@PolID,'UW',NULL)";
            #region Connection
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql2, new SqlConnection(ClsMain.ClaimAppConnectionCoreLive())))
            //Connection To Development
            using (SqlCommand cmd = new SqlCommand(strSql2, new SqlConnection(ClsMain.ReksaAppCoreConnectionString())))
            #endregion
            {
                try
                {
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@PolID", polID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dtPaidInsurance);
                    cmd.Connection.Close();
                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : CheckStatusPaid : " + ex.ToString());
                }
            }
            Status = dtpaidClient.Rows[0]["Column1"].ToString().Trim() + " - " + dtPaidInsurance.Rows[0]["Column1"].ToString().Trim();
            return Status;
        }

        public static DataTable getGenerateTransacNum()
        {

            DataTable dt = new DataTable();
            try
            {
                ClsMain.saveDebugLog("Star Class getGenerateTransacNum");
                #region Connection
                //Connection To Live Database
                //using (SqlConnection connection = new SqlConnection(ClsMain.ClaimAppConnectionStringLive()))
                //Connection To Development
                using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionString2()))
                #endregion
                {
                    connection.Open();
                    using (SqlCommand cmd = new SqlCommand("[usp_GenerateTransactionNumberClaim]", connection))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                        connection.Close();
                        ClsMain.saveDebugLog("Sudah Selesai menjalankan getGenerateTransacNum");
                    }
                }
            }
            catch (Exception ex)
            {
                ClsMain.saveErrorLog("ClsUpload : getGenerateTransacNum : " + ex.ToString());
            }
            finally { }
            return dt;
        }

        public static DataTable getTransactionNum(long xID)
        {
            DataTable dt = new DataTable();
            string strSql = "Select TransactionNumber From ClaimMotorVehicle Where Pid = @Pid";
            #region Connection
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ClaimAppConnectionStringLive())))
            //Connection To Development
            using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ReksaAppConnectionString2())))
            #endregion
            {
                try
                {
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@Pid", xID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    cmd.Connection.Close();
                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : getTransactionNum : " + ex.ToString());
                }
                finally { }
                return dt;
            }
        }

        public static DataTable CheckData(string polNo, string chasisNo, string engineNo, string dateOfLoss)
        {
            DataTable dt = new DataTable();
            string strSql = " Select * from ClaimMotorVehicle  ";
            strSql += " WHERE PolicyNo = @PolicyNo AND ChasisNumber = @ChasisNo AND DateOfLoss = Convert(varchar,@DateOfLoss,103) AND EngineNumber = @EngineNo";
            #region Connection
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ClaimAppConnectionStringLive())))
            //Connection To Development
            using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ReksaAppConnectionString2())))
            #endregion
            {
                try
                {
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@PolicyNo", polNo);
                    cmd.Parameters.AddWithValue("@ChasisNo", chasisNo);
                    cmd.Parameters.AddWithValue("@DateOfLoss", dateOfLoss);
                    cmd.Parameters.AddWithValue("@EngineNo", engineNo);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    cmd.Connection.Close();
                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : CheckDataClaim : " + ex.ToString());
                }
                finally { }
                return dt;
            }
        }

        public static string CheckStatusPaid(long PolID)
        {
            string Status = "";
            DataTable dt = new DataTable();
            DataTable dt2 = new DataTable();
            string strSql = "Select dbo.[fDNCNOutstandingInquiry]('IBU000',@PolID,'CL',NULL)";
            #region Connection
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ClaimAppConnectionCoreLive())))
            //Connection To Development
            using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ReksaAppCoreConnectionString())))
            #endregion
            {
                try
                {
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@PolID", PolID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    cmd.Connection.Close();
                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : CheckStatusPaid : " + ex.ToString());
                }

            }
            string strSql2 = "Select dbo.[fDNCNOutstandingInquiry]('IBU000',@PolID,'UW',NULL)";
            #region Connection
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql2, new SqlConnection(ClsMain.ClaimAppConnectionCoreLive())))
            //Connection To Development
            using (SqlCommand cmd = new SqlCommand(strSql2, new SqlConnection(ClsMain.ReksaAppCoreConnectionString())))
            #endregion
            {
                try
                {
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@PolID", PolID);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt2);
                    cmd.Connection.Close();
                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : CheckStatusPaid : " + ex.ToString());
                }
            }
            Status = dt.Rows[0]["Column1"].ToString().Trim() + " - " + dt2.Rows[0]["Column1"].ToString().Trim();
            return Status;
        }
        public static DataTable getDataInsurance(string polNo, string chasisNo, string engineNo, string insuranceName, ref string type, ref long PolID, ref long PolMain)
        {
            //bool ret = false;
            DataTable dt = new DataTable();
            string strSql = " SELECT DISTINCT A.PolID AS POLID_A,A.PolNo AS POLICY_NO,A.PolMainID AS POLMAINID,B.PolID AS POLID_B,C.ClientType AS CLIENT_TYPE,C.Type,C.Name AS INSURANCE,UPPER(C.Type + C.Name) AS INSURANCENAME ";
            strSql += " FROM POLMain A ";
            strSql += " LEFT OUTER JOIN POLDetail_3 B ON A.PolID = B.PolID ";
            strSql += " LEFT OUTER JOIN MSTClient C ON B.CompanyID = C.CompanyID ";
            strSql += " WHERE A.PolNo = @PolNo AND B.ChassisNo = @ChasisNo AND B.EngineNo = @EngineNo AND C.Name = @Insurance AND C.ClientType = 'U'";
            #region Connection
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ClaimAppConnectionCoreLive())))
            //Connection To Development
            using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ReksaAppCoreConnectionString())))
            #endregion
            {
                try
                {
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@PolNo", polNo);
                    cmd.Parameters.AddWithValue("@ChasisNo", chasisNo);
                    cmd.Parameters.AddWithValue("@EngineNo", engineNo);
                    cmd.Parameters.AddWithValue("@Insurance", insuranceName.Substring(3));
                    //cmd.ExecuteNonQuery();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    cmd.Connection.Close();
                    //ClsMain.saveDebugLog("Sudah Selesai");
                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : getDataInsurance : " + ex.ToString());
                }
                finally { }
                return dt;
            }

        }

        public static string getDivName(string polno, string clientcode)
        {
            try
            {
                string divname = "";
                DataTable dt = new DataTable();
                string strSql = "select DISTINCT a.ClientCode,a.DivCode,b.DivName";
                strSql += " from Polmain a ";
                strSql += " left outer join SETDivision b on a.DivCode = b.DivCode ";
                strSql += " Where a.clientcode= '" + clientcode + "' and a.PolNo = '" + polno + "' ";
                #region Connection
                //Connection To Live Database
                //using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ClaimAppConnectionCoreLive())))
                //Connection To Development
                using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ReksaAppCoreConnectionString())))
                #endregion
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    cmd.Connection.Close();
                    divname = dt.Rows[0]["DivName"].ToString().Trim();
                    return divname;
                }
            }
            catch (Exception)
            {

                throw;
            }
          
        }

        public DataTable getDataClaim(string noPolice)
        {
            DataTable myTable = new DataTable();
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ClaimAppConnectionCoreLive())))
            //Connection To Development
            using (SqlConnection Connection = new SqlConnection(ClsMain.ReksaAppCoreConnectionString()))
            {
                Connection.Open();
                string strSql = "Select DISTINCT B.PolMainID,A.PolID,B.ClientCode,B.ClientName,B.PolNo,A.ChassisNo,A.EngineNo,A.PoliceNo,A.Type AS TypeVehicle,C.DivName from POLDetail_3 A";
                strSql += " LEFT OUTER JOIN PolMain B ON A.PolID = B.PolMainID";
                strSql += " LEFT OUTER JOIN SETDivision C ON B.DivCode = C.DivCode ";
                strSql += " Where PoliceNo = '" + noPolice + "' AND  B.PolTo > convert(date,getdate(),103) AND B.ClassCode = '3' AND B.Status in('v','P')";
                using (SqlCommand command = new SqlCommand(strSql, Connection))
                {
                    SqlDataAdapter da = new SqlDataAdapter(command);
                    da.Fill(myTable);
                    Connection.Close();
                    return myTable;
                }
            }
        }

        public void DeleteDataBefore(string polNo, string chasisNo, string engineNo, string dateOfLoss)
        {
            #region Connection
            //Connection To Live Database
            //using (SqlConnection connection = new SqlConnection(ClsMain.ClaimAppConnectionStringLive()))
            //Connection To Development
            using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionString2()))
            #endregion
            {
                try
                {
                    ClsMain.saveDebugLog("Proses Delete Data Sebelumnya ");
                    connection.Open();
                    string strSql = " DELETE FROM  ClaimMotorVehicle ";
                    strSql += " WHERE PolicyNo = '" + polNo + "' AND ChasisNumber = '" + chasisNo + "' AND DateOfLoss = Convert(varchar,'" + dateOfLoss + "',103) AND EngineNumber = '" + engineNo + "' AND Type_Input = 'Manual Input' ";
                    SqlCommand cmd = new SqlCommand(strSql, connection);
                    cmd.ExecuteNonQuery();
                    connection.Close();
                }
                catch (System.OutOfMemoryException)
                {

                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : DeleteDataBefore : " + ex.ToString());
                }

            }
        }
        public void InsertDataToHistory(string polNo, string chasisNo, string engineNo, string dateOfLoss)
        {
            #region Connection
            //Connection To Live Database
            //using (SqlConnection connection = new SqlConnection(ClsMain.ClaimAppConnectionStringLive()))
            //Connection To Development
            using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionString2()))
            #endregion
            {
                try
                {
                    ClsMain.saveDebugLog("Proses Insert Ke History ");
                    connection.Open();
                    string strSql = " INSERT INTO ClaimMotorVehicle_History (CdateTime,InsuranceCode,InsuranceName,Workshop,PolID,PolMainID,PolicyNo,DateOfLoss,PoliceNumber,VehicleModel,ChasisNumber,EngineNumber,WorkshopEntryDate,RepairerEstimate,AmountApproved,FinishDate,RepairingStatus,CreateBy,Type_Input,TransactionNumber,SpkDate,ClaimDemage,DivName,ClientCode,ClientName) ";
                    strSql += " Select CdateTime, InsuranceCode, InsuranceName, Workshop, PolID, PolMainID, PolicyNo, DateOfLoss, PoliceNumber, VehicleModel, ChasisNumber, EngineNumber, WorkshopEntryDate, RepairerEstimate, AmountApproved, FinishDate, RepairingStatus, CreateBy, Type_Input, TransactionNumber , SpkDate , ClaimDemage,DivName ,ClientCode,ClientName from ClaimMotorVehicle  ";
                    strSql += " WHERE PolicyNo = '" + polNo + "' AND ChasisNumber = '" + chasisNo + "' AND DateOfLoss = Convert(varchar,'" + dateOfLoss + "',103) AND EngineNumber = '" + engineNo + "'";
                    SqlCommand cmd = new SqlCommand(strSql, connection);
                    cmd.ExecuteNonQuery();
                    connection.Close();
                }
                catch (System.OutOfMemoryException)
                {

                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : InsertDataToHistory : " + ex.ToString());
                }

            }
        }

        public static long UpdateDataToDatabase(string xid, float amountApproved, string repiereStatus, string finisDate, string claimDemage)
        {
            long result = 0;
            string strSql = "Update ClaimMotorVehicle set ";
            strSql += " AmountApproved = @AmountApproved, RepairingStatus = @RepairingStatus,FinishDate = Convert(varchar,@FinishDate,103), ClaimDemage = @ClaimDemage Where Pid = @Pid ";
            #region Connection
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ClaimAppConnectionStringLive())))
            //Connection To Development
            using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ReksaAppConnectionString2())))
            #endregion
            {
                try
                {
                    ClsMain.saveDebugLog("Proses Update Ke Table ClaimMotorVehicle");
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@Pid", Convert.ToInt64(xid));
                    cmd.Parameters.AddWithValue("@RepairingStatus", repiereStatus);
                    cmd.Parameters.AddWithValue("@AmountApproved", amountApproved);
                    cmd.Parameters.AddWithValue("@FinishDate", finisDate);
                    cmd.Parameters.AddWithValue("@ClaimDemage", claimDemage);
                    result = (long)cmd.ExecuteNonQuery();
                }
                catch (System.OutOfMemoryException)
                {

                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : UpdateDataToDatabase : " + ex.ToString());
                }
                finally
                {
                    if (cmd.Connection.State == System.Data.ConnectionState.Open)
                        cmd.Connection.Close();
                }
                return result;
            }
        }



        public static long InsertSingleDataToDatabase(string Db, string polNo, string chasisNo, string engineNo, string insuranceName,
            string dateOfLoss, string workEntryDate, string finishDate, string workshop, string vehicleModel, float amountApproved,
            string policeNumber, string repiererEstimated, string repiereStatus, string Type, Int64 PolID, Int64 PolMain, string session,
            string TransactionNumber, string SpkDate, string claimDemage, string DivName, string ClientCode, string ClientName)
        {
            long result = 0;
            string strSql = "insert into ClaimMotorVehicle (InsuranceCode,InsuranceName,Workshop,PolID,PolMainID,PolicyNo,DateOfLoss,PoliceNumber,VehicleModel,ChasisNumber,EngineNumber,WorkshopEntryDate,RepairerEstimate,AmountApproved,FinishDate,RepairingStatus,CreateBy,Type_Input,TransactionNumber,SpkDate,ClaimDemage,DataSource,DivName,ClientCode,ClientName) values";
            strSql += " (@InsuranceCode,@InsuranceName,@Workshop,@PolID,@PolMainID,@PolicyNo,Convert(varchar,@DateOfLoss,103),@PoliceNumber,@VehicleModel,@ChasisNumber,@EngineNumber,Convert(varchar,@WorkshopEntryDate,103),Convert(varchar,@RepairerEstimate,103),@AmountApproved,Convert(varchar,@FinishDate,103),@RepairingStatus,@CreateBy,@Type_Input,@TransactionNumber,@SpkDate,@ClaimDemage,@DataSource,@DivName,@ClientCode,@ClientName) ";
            strSql += " Insert into TransactionNumber (TransactionNumber,TransactionType,CreateBy) Values";
            strSql += " (@TransactionNumber,1,@CreateBy) ";
            #region Connection
            //Connection To Live Database
            //using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ClaimAppConnectionStringLive())))
            //Connection To Development
            using (SqlCommand cmd = new SqlCommand(strSql, new SqlConnection(ClsMain.ReksaAppConnectionString2())))
            #endregion
            {
                try
                {
                    ClsMain.saveDebugLog("Proses Insert Ke Table ClaimMotorVehicle");
                    cmd.Connection.Open();
                    cmd.Parameters.AddWithValue("@DivName", DivName);
                    cmd.Parameters.AddWithValue("@ClientCode", ClientCode);
                    cmd.Parameters.AddWithValue("@ClientName", ClientName);
                    cmd.Parameters.AddWithValue("@DataSource", Db);
                    cmd.Parameters.AddWithValue("@InsuranceCode", Type);
                    cmd.Parameters.AddWithValue("@InsuranceName", insuranceName);
                    cmd.Parameters.AddWithValue("@Workshop", workshop);
                    cmd.Parameters.AddWithValue("@PolID", PolID);
                    cmd.Parameters.AddWithValue("@PolMainID", PolMain);
                    cmd.Parameters.AddWithValue("@PolicyNo", polNo);
                    cmd.Parameters.AddWithValue("@DateOfLoss", dateOfLoss);
                    cmd.Parameters.AddWithValue("@PoliceNumber", policeNumber);
                    cmd.Parameters.AddWithValue("@VehicleModel", vehicleModel);
                    cmd.Parameters.AddWithValue("@ChasisNumber", chasisNo);
                    cmd.Parameters.AddWithValue("@EngineNumber", engineNo);
                    cmd.Parameters.AddWithValue("@WorkshopEntryDate", workEntryDate);
                    cmd.Parameters.AddWithValue("@RepairerEstimate", repiererEstimated);
                    cmd.Parameters.AddWithValue("@AmountApproved", amountApproved);
                    cmd.Parameters.AddWithValue("@FinishDate", finishDate);
                    cmd.Parameters.AddWithValue("@RepairingStatus", repiereStatus);
                    cmd.Parameters.AddWithValue("@CreateBy", session);
                    cmd.Parameters.AddWithValue("@Type_Input", "Manual Input");
                    cmd.Parameters.AddWithValue("@TransactionNumber", TransactionNumber);
                    cmd.Parameters.AddWithValue("@SpkDate", SpkDate);
                    cmd.Parameters.AddWithValue("@ClaimDemage", claimDemage);
                    result = (long)cmd.ExecuteNonQuery();
                }
                catch (System.OutOfMemoryException)
                {

                }
                catch (SqlException ex)

                {

                    ClsMain.saveErrorLog("ClsUpload : InsertSingleDataToDatabase : " + ex.ToString());
                }
                finally
                {
                    if (cmd.Connection.State == System.Data.ConnectionState.Open)
                        cmd.Connection.Close();
                }
            }
            return result;
        }



        public void DeleteDataAndInsertToHistory(string polNo, string chasisNo, string engineNo, string dateoffLoss)
        {
            #region Connection
            //Connection To Live Database
            //using (SqlConnection connection = new SqlConnection(ClsMain.ClaimAppConnectionStringLive()))
            //Connection To Development
            using (SqlConnection connection = new SqlConnection(ClsMain.ReksaAppConnectionString2()))
            #endregion
            {
                try
                {
                    ClsMain.saveDebugLog("Proses Insert Ke History ");
                    connection.Open();
                    string strSql = " INSERT INTO ClaimMotorVehicle_History Select * from ClaimMotorVehicle ";
                    strSql += " WHERE PolicyNo = '" + polNo + "' AND ChasisNumber = '" + chasisNo + "' AND DateOfLoss = Convert(varchar,'" + dateoffLoss + "',103) AND EngineNumber = '" + engineNo + "'";
                    strSql += " DELETE FROM  ClaimMotorVehicle ";
                    strSql += " WHERE PolicyNo = '" + polNo + "' AND ChasisNumber = '" + chasisNo + "' AND DateOfLoss = Convert(varchar,'" + dateoffLoss + "',103) AND EngineNumber = '" + engineNo + "'";
                    SqlCommand cmd = new SqlCommand(strSql, connection);
                    cmd.ExecuteNonQuery();
                    connection.Close();
                }
                catch (System.OutOfMemoryException)
                {

                }
                catch (Exception ex)
                {
                    ClsMain.saveErrorLog("ClsUpload : DeleteDataAndInsertToHistory : " + ex.ToString());
                }
            }
        }
    }
}
