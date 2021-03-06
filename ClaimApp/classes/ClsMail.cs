﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Threading;
using System.IO;

namespace ClaimApp.classes
{
    public enum Email_Status
    {
        None = 0,
        To = 1,
        CC = 2,
        BCC = 3,
        BadAddr = 4
    }
    public class ClsMail
    {
        const string CHILKAT_MAIL_UNLOCKCODE = "HARTONMAILQ_5yoQuqcSoK6e";

        static readonly Object _validateEmail = new Object();
        //public static bool validateEmail(string keyPass, string toList)
        //{
        //    lock (_validateEmail)
        //    {
        //        bool ret = false;
        //        if (string.IsNullOrEmpty(toList))
        //        { return ret; }

        //        try
        //        {
        //            string ccList = string.Empty;
        //            string bccList = string.Empty;
        //            string subject = string.Empty;
        //            string body = string.Empty;
        //            string attachment = string.Empty;
        //            string replyaddr = string.Empty;

        //            string mailtoaddr = toList;

        //            using (Chilkat.MailMan mailman = new Chilkat.MailMan())
        //            {
        //                mailman.UnlockComponent(CHILKAT_MAIL_UNLOCKCODE);
        //                mailman.SmtpHost = ClsSystem.getSysConfig_PropValue(keyPass, "smtpServer");
        //                mailman.SmtpPort = Convert.ToInt32(ClsSystem.getSysConfig_PropValue(keyPass, "smtpPort"));
        //                mailman.SmtpUsername = (Convert.ToBoolean(ClsSystem.getSysConfig_PropValue(keyPass, "smtpAuth")) ? ClsSystem.getSysConfig_PropValue(keyPass, "smtpUserId") : "");
        //                mailman.SmtpPassword = (Convert.ToBoolean(ClsSystem.getSysConfig_PropValue(keyPass, "smtpAuth")) ? ClsSystem.getSysConfig_PropValue(keyPass, "smtpUserPwd") : "");
        //                mailman.SmtpSsl = Convert.ToBoolean(ClsSystem.getSysConfig_PropValue(keyPass, "smtpSSL"));
        //                mailman.StartTLS = Convert.ToBoolean(ClsSystem.getSysConfig_PropValue(keyPass, "smtpTLS"));
        //                using (Chilkat.Email email = new Chilkat.Email())
        //                {
        //                    email.FromName = ClsSystem.getSysConfig_PropValue(keyPass, "smtpSenderDisplayName");
        //                    email.FromAddress = ClsSystem.getSysConfig_PropValue(keyPass, "smtpSenderAddress");
        //                    email.ReplyTo = (replyaddr.Trim() == string.Empty ? ClsSystem.getSysConfig_PropValue(keyPass, "smtpReplyAddress") : replyaddr);
        //                    email.Subject = subject;
        //                    email.Body = body;
        //                    email.ClearTo();
        //                    email.AddTo(toList, toList);

        //                    Chilkat.StringArray badAddrs = new Chilkat.StringArray();
        //                    if (mailman.VerifyRecips(email, badAddrs))
        //                    {
        //                        ret = (badAddrs.Count > 0 ? false : true);
        //                    }
        //                    else
        //                    { ret = true; }
        //                }
        //            }
        //        }
        //        catch (Exception ex) { saveMailErrorLog("ClsMail:validateEmail: " + ex.ToString()); }
        //        finally { }
        //        return ret;
        //    }
        //}

        public static void saveMailErrorLog(string perror)
        {
            System.IO.StreamWriter writer;
            try
            {
                string mtoday = string.Format("{0:yyyyMMdd}", System.DateTime.Today);
                string mtime = String.Format("{0:HH:mm:ss}", System.DateTime.Now);
                string sfullname = ClsMain.logFolder() + "\\" + "Indosurance_Mail_" + mtoday + ".log";
                string merror = mtime + ";" + perror;
                if (!File.Exists(sfullname))
                {
                    writer = File.CreateText(sfullname);
                    writer.Close();
                }
                using (StreamWriter sw = File.AppendText(sfullname))
                {
                    sw.WriteLine(merror);
                    sw.Flush();
                    sw.Close();
                }
            }
            catch { }
            finally { }
        }

        static readonly Object _verifyEmail = new object();
        //public static bool verifyEmail(object parameters)
        //{
        //    bool ret = false;
        //    object[] parameterArray = (object[])parameters;
        //    string keyPass = (string)parameterArray[0];
        //    string toList = (string)parameterArray[1];
        //    try
        //    {
        //        using (Chilkat.MailMan mailman = new Chilkat.MailMan())
        //        {
        //            mailman.UnlockComponent(CHILKAT_MAIL_UNLOCKCODE);
        //            mailman.SmtpHost = ClsSystem.getSysConfig_PropValue(keyPass, "smtpServer");
        //            mailman.SmtpPort = Convert.ToInt32(ClsSystem.getSysConfig_PropValue(keyPass, "smtpPort"));
        //            mailman.SmtpUsername = (Convert.ToBoolean(ClsSystem.getSysConfig_PropValue(keyPass, "smtpAuth")) ? ClsSystem.getSysConfig_PropValue(keyPass, "smtpUserId") : "");
        //            mailman.SmtpPassword = (Convert.ToBoolean(ClsSystem.getSysConfig_PropValue(keyPass, "smtpAuth")) ? ClsSystem.getSysConfig_PropValue(keyPass, "smtpUserPwd") : "");
        //            mailman.SmtpSsl = Convert.ToBoolean(ClsSystem.getSysConfig_PropValue(keyPass, "smtpSSL"));
        //            mailman.StartTLS = Convert.ToBoolean(ClsSystem.getSysConfig_PropValue(keyPass, "smtpTLS"));

        //            using (Chilkat.Email email = new Chilkat.Email())
        //            {
        //                email.AddTo(toList, toList);

        //                Chilkat.StringArray badAddrs = new Chilkat.StringArray();
        //                ret = mailman.VerifyRecips(email, badAddrs);
        //            }
        //        }
        //    }
        //    catch (Exception ex) { ClsMain.saveDebugLog("VerifyEmail:" + ex.ToString()); }
        //    finally { }
        //    return ret;
        //}

        public static void mailReply(object parameters)
        {
            try
            {
                //string toList, string ccList, string bccList, string subject, string body, string attachment, string replyaddr = ""
                object[] parameterArray = (object[])parameters;
                string toList = (string)parameterArray[0];
                string ccList = (string)parameterArray[1];
                string bccList = (string)parameterArray[2];
                string subject = (string)parameterArray[3];
                string body = (string)parameterArray[4];
                string replyaddr = (string)parameterArray[5];
                string attachments = (string)parameterArray[6];
                string keyPass = (string)parameterArray[7];

                string mailtoaddr = toList;

                using (Chilkat.MailMan mailman = new Chilkat.MailMan())
                {
                    mailman.UnlockComponent(CHILKAT_MAIL_UNLOCKCODE);
                    mailman.SmtpHost = "mail.indosurance.com";
                    mailman.SmtpPort = Convert.ToInt32("587");
                    mailman.SmtpUsername = "nikko@indosurance.com";
                    mailman.SmtpPassword = "[zFWSl=t#l2H";
                    mailman.SmtpSsl = false;
                    mailman.StartTLS = false;

                    using (Chilkat.Email email = new Chilkat.Email())
                    {
                        email.FromName = "System Notification";
                        email.FromAddress = "noreply@indosurance.com";
                        email.ReplyTo = replyaddr;
                        email.Subject = subject;
                        email.Body = body;
                        email.ClearTo();

                        string htmlBody = body;

                        string top = ClsMain.EmailFolder() + "logo.png";

                        //string background = ClsSystem.getSysConfig_PropValue(keyPass, "appData") + "\\" + ClsSystem.getSysConfig_PropValue(keyPass, "Background");

                        //string _cid1 = email.AddRelatedFile(top);
                        //htmlBody = htmlBody.Replace("IMAGE_CID1", _cid1);


                        //string _cid4 = email.AddRelatedFile(background);
                        //htmlBody = htmlBody.Replace("IMAGE_CID4", _cid4);

                        email.SetHtmlBody(htmlBody);

                        if (toList.IndexOf(",") > 0)
                        { email.AddMultipleTo(toList); }
                        else
                        { email.AddTo(toList, toList); }

                        if (ccList.IndexOf(",") > 0)
                        { email.AddMultipleTo(ccList); }
                        else
                        { email.AddCC(ccList, ccList); }

                        if (bccList.IndexOf(",") > 0)
                        { email.AddMultipleBcc(bccList); }
                        else
                        { email.AddBcc(bccList, bccList); }

                        Chilkat.StringArray badAddrs = new Chilkat.StringArray();
                        if (mailman.VerifyRecips(email, badAddrs))
                        {
                            DateTime _now = DateTime.Now;

                            email.AddFileAttachment(attachments);
                            if (!mailman.SendEmail(email))
                            {
                                string lastError = mailman.LastErrorText;
                                for (int iTo = 0; iTo < email.NumTo; iTo++)
                                {
                                    string emailAddr = email.GetToAddr(iTo);
                                    new Thread(new ParameterizedThreadStart(ClsMail.addMail_Log)).Start(new object[] { _now, keyPass, emailAddr, Email_Status.To, subject, lastError });
                                }
                                for (int iCC = 0; iCC < email.NumCC; iCC++)
                                {
                                    string emailAddr = email.GetCcAddr(iCC);
                                    new Thread(new ParameterizedThreadStart(ClsMail.addMail_Log)).Start(new object[] { _now, keyPass, emailAddr, Email_Status.CC, subject, lastError });
                                }
                                for (int iBCC = 0; iBCC < email.NumBcc; iBCC++)
                                {
                                    string emailAddr = email.GetBccAddr(iBCC);
                                    new Thread(new ParameterizedThreadStart(ClsMail.addMail_Log)).Start(new object[] { _now, keyPass, emailAddr, Email_Status.BCC, subject, lastError });
                                }
                            }

                            if (badAddrs.Count > 0)
                            {
                                string lastError = "Bad Address";
                                for (int ibadAddr = 0; ibadAddr < badAddrs.Count; ibadAddr++)
                                {
                                    string badAddr = badAddrs.GetString(ibadAddr);
                                    new Thread(new ParameterizedThreadStart(ClsMail.addMail_Log)).Start(new object[] { _now, keyPass, badAddr, Email_Status.BadAddr, subject, lastError });
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex) { saveMailErrorLog("ClsMail:mailReply: " + ex.ToString()); }
            finally { }
        }

        static readonly Object _addMail_Log = new Object();
        public static void addMail_Log(object parameters)
        {
            lock (_addMail_Log)
            {
                object[] parameterArray = (object[])parameters;

                DateTime _now = (DateTime)parameterArray[0];
                string keyPass = (string)parameterArray[1];
                string _addr = (string)parameterArray[2];
                Email_Status _status = (Email_Status)parameterArray[3];
                string _subject = (string)parameterArray[4];
                string _lastError = (string)parameterArray[5];

                try
                {
                    string sql = "Insert Into Mail_Log " +
                                "(Addr, Status, Subject, LastError, cdatetime) " +
                                "Output Inserted.Pid Values " +
                                "(@Addr, @Status, @Subject, @LastError, @cdatetime)";
                    using (SqlCommand cmd = new SqlCommand(sql, new SqlConnection(ClsMain.ReksaAppConnectionString())))
                    {
                        try
                        {
                            cmd.Connection.Open();
                            cmd.CommandTimeout = CONST.COMMAND_TIMEOUT;
                            cmd.Parameters.AddWithValue("@cdatetime", _now);
                            cmd.Parameters.AddWithValue("@Addr", _addr);
                            cmd.Parameters.AddWithValue("@Status", _status);
                            cmd.Parameters.AddWithValue("@Subject", _subject);
                            cmd.Parameters.AddWithValue("@LastError", _lastError);
                            long newPid = (long)cmd.ExecuteScalar();
                        }
                        catch (Exception ex) { ClsMain.saveErrorLog("ClsMail:addMail_Log:" + ex.ToString()); }
                        finally
                        {
                            if (cmd.Connection.State == System.Data.ConnectionState.Open)
                                cmd.Connection.Close();
                        }
                    }
                }
                catch (Exception ex) { ClsMain.saveErrorLog("ClsMail:addMail_Log:" + ex.ToString()); }
                finally { }
            }
        }
    }
}