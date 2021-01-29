using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web.Security;
using ClaimApp.classes;

namespace ClaimApp.classes
{

    public class ClsUser
    {
        public string userLogin(string UserName, string password, ref string userID,
                            ref string _userName, ref string UserDivision, ref string UserGroup, ref string CompanyID, ref string divcode, string returnUrl = "")
        {
            string result = String.Empty, userEmail = string.Empty;
            userID = string.Empty;
            _userName = string.Empty;

            try
            {
                login(UserName, password, ref userID, ref _userName);

                if (userID != string.Empty)
                {
                    GetUserDivision(UserName, ref UserDivision, ref UserGroup, ref CompanyID, ref divcode);
                    //addUserLogin(userID);
                    System.Web.Security.FormsAuthentication.SetAuthCookie(userID.ToString(), false);

                    if (returnUrl == "")
                    {
                        result = "Home.aspx";
                    }
                    else
                    {
                        result = returnUrl;
                    }
                }
            }
            catch (Exception ex)
            {
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }

            return result;
        }

        private void login(string UserName, string password, ref string userID, ref string _userName)
        {
            try
            {
                string encPassword = ClsSystem.MD5Hash(password);
                string sql = "SELECT * FROM indoins_live.dbo.SYSUser  where UserID = @UserID and Password = @password";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppCoreConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@UserID", UserName);
                        cmd.Parameters.AddWithValue("@password", encPassword);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.HasRows)
                            {
                                if (dr.Read())
                                {
                                    userID = dr.GetString(dr.GetOrdinal("UserID"));
                                    _userName = dr.GetString(dr.GetOrdinal("UserID"));
                                }
                            }
                            else
                            {
                                userID = string.Empty;
                                _userName = string.Empty;
                            }
                        }
                    }
                    catch (SqlException ex)
                    {
                        ClsMain.saveErrorLog(ex.ToString());
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
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }
        }


        private void GetUserDivision(string UserName, ref string UserDivision, ref string UserGroup, ref string companyID, ref string divcode)
        {
            try
            {

                string sql = "select distinct divName, right(rtrim(userGroupID),3) as userGroupID, a.CompanyID, b.divcode from indoins_back.[dbo].sysuser a " +
                             "inner join indoins_live.[dbo].Setdivision b on a.DivisionID = b.divcode where userID =@UserID";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppCoreConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@UserID", UserName);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.HasRows)
                            {
                                if (dr.Read())
                                {
                                    UserDivision = dr.GetString(dr.GetOrdinal("divName")).Trim();
                                    UserGroup = dr.GetString(dr.GetOrdinal("userGroupID")).Trim();
                                    companyID = dr.GetString(dr.GetOrdinal("CompanyID")).Trim();
                                    divcode = dr.GetString(dr.GetOrdinal("divcode")).Trim();
                                }
                            }
                            else
                            {

                                UserDivision = string.Empty;
                                companyID = string.Empty;
                            }
                        }
                    }
                    catch (SqlException ex)
                    {
                        ClsMain.saveErrorLog("ClsUser_GetUserDivision : " + ex.ToString());
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
                ClsMain.saveErrorLog("ClsUser_GetUserDivision : " + ex.ToString());
            }
            finally { }
        }

        public bool changePassword(string email, string oldPass, string newPass)
        {
            bool result = false;

            try
            {
                string userID = string.Empty;
                string userName = string.Empty;

                oldPass = oldPass.Trim();
                login(email, oldPass, ref userID, ref userName);
                if (userID != string.Empty)
                {
                    newPass = ClsSystem.encryptString(newPass.Trim());
                    string sql = "update ReportEB_MasterUser set password = @newPass where Pid = @userPid";
                    using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                    {
                        try
                        {
                            cmd.Connection.Open();
                            cmd.Parameters.AddWithValue("@newPass", newPass);
                            cmd.Parameters.AddWithValue("@userPid", userID);
                            cmd.ExecuteNonQuery();
                            result = true;
                        }
                        catch (SqlException ex)
                        {
                            ClsMain.saveErrorLog(ex.ToString());
                        }
                        finally
                        {
                            if (cmd.Connection.State == System.Data.ConnectionState.Open)
                                cmd.Connection.Close();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }

            return result;
        }


        public bool addUserLogin(long usersPID)
        {
            bool result = false;
            try
            {
                string sql = "update ReportEB_MasterUser set LastLogin = getdate() where Pid = @UsersPid";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@UsersPid", usersPID);
                        cmd.ExecuteNonQuery();
                        result = true;
                    }
                    catch (SqlException ex)
                    {
                        ClsMain.saveErrorLog(ex.ToString());
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
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }

            return result;
        }

        public bool addUserLog(int usersPID, string activityRemarks)
        {
            bool result = false;
            try
            {
                string sql = "insert into ReportEB_UserLog (User_Pid, ActivityRemark) values " +
                                "(@User_Pid, @ActivityRemark)";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@UsersPid", usersPID);
                        cmd.Parameters.AddWithValue("@ActivityRemarks", activityRemarks);
                        cmd.ExecuteNonQuery();
                        result = true;
                    }
                    catch (SqlException ex)
                    {
                        ClsMain.saveErrorLog(ex.ToString());
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
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }

            return result;
        }

        public static long addUser(string UserName, string Password, string UserMail, bool isActive)
        {
            long result = 0;

            try
            {
                string encPassword = ClsSystem.encryptString(Password.Trim());
                string sql = "insert into ReportEB_MasterUser (UserName, Password, UserMail, isActive) " +
                                "Output Inserted.Pid values " +
                                "(@UserName, @Password, @UserMail, @isActive)";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@UserName", UserName);
                        cmd.Parameters.AddWithValue("@Password", encPassword);
                        cmd.Parameters.AddWithValue("@UserMail", UserMail);
                        cmd.Parameters.AddWithValue("@isActive", isActive);
                        result = (long)cmd.ExecuteScalar();
                    }
                    catch (SqlException ex)
                    {
                        ClsMain.saveErrorLog(ex.ToString());
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
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }

            return result;
        }

        public static bool updateUser(long pid, string email, string name, bool active)
        {
            bool result = false;

            try
            {
                string sql = "update ReportEB_MasterUser set Usermail = @Usermail, UserName = @UserName, isActive = @isActive where Pid = @pid";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@Usermail", email.Trim());
                        cmd.Parameters.AddWithValue("@UserName", name.Trim());
                        cmd.Parameters.AddWithValue("@isActive", active);
                        cmd.Parameters.AddWithValue("@pid", pid);
                        cmd.ExecuteNonQuery();
                        result = true;
                    }
                    catch (SqlException ex)
                    {
                        ClsMain.saveErrorLog(ex.ToString());
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
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }

            return result;
        }

        public static bool updatePassword(long pid, string password)
        {
            bool result = false;

            try
            {
                string encPassword = ClsSystem.encryptString(password.Trim());
                string sql = "update ReportEB_MasterUser set password = @password where Pid = @pid";
                using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                {
                    try
                    {
                        cmd.Connection.Open();
                        cmd.Parameters.AddWithValue("@password", encPassword);
                        cmd.Parameters.AddWithValue("@pid", pid);
                        cmd.ExecuteNonQuery();
                        result = true;
                    }
                    catch (SqlException ex)
                    {
                        ClsMain.saveErrorLog(ex.ToString());
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
                ClsMain.saveErrorLog(ex.ToString());
            }
            finally { }

            return result;
        }




    }
}