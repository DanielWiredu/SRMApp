using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;

namespace SRMApp.Financials
{
    public partial class TithePayment : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        SqlDataReader reader;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtMemberID.Text = Session["memberid"].ToString();
                txtFullname.Text = Session["surname"].ToString() + " " + Session["othernames"].ToString();
                txtTelephone.Text = Session["telephone"].ToString();

                getTotalTithe();

                int year = DateTime.UtcNow.Year;
                for (int i = 2015; i <= year; i++)
                {
                    dlYear.Items.Add(i.ToString());
                    dlYear1.Items.Add(i.ToString());
                }

                dpPaydate.SelectedDate = DateTime.UtcNow;
                //dpValueDate.SelectedDate = DateTime.UtcNow;
            }
        }

        protected void getTotalTithe()
        {
            try
            {
                double totalamt = 0.0;
                string query = "select isnull(sum(payamt),0) as totaltithe from tithes where memberid = '" + txtMemberID.Text + "'";
                command = new SqlCommand(query, connection);
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    totalamt = Convert.ToDouble(reader["totaltithe"]);
                }
                reader.Close();
                txtTotalAmt.Text = String.Format("{0:0.00}", totalamt);
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }

        protected void titheGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["titheid"] = item["id"].Text;
                try
                {
                    string query = "select * from tithes where id = '" + ViewState["titheid"].ToString() + "'";
                    command = new SqlCommand(query, connection);
                    if (connection.State == ConnectionState.Closed)
                        connection.Open();
                    reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        dpPaydate1.SelectedDate = Convert.ToDateTime(reader["paydate"]);
                        string yearmm = reader["yearmm"].ToString();
                        dlMonth1.SelectedValue = yearmm.Substring(4, 2);
                        dlYear1.SelectedText = yearmm.Substring(0, 4);
                        txtAmount1.Text = reader["payamt"].ToString();
                        //dlPaymode1.SelectedText = reader["paymode"].ToString();
                        //txtChequeno1.Text = reader["chequeno"].ToString();
                        //dpValueDate1.SelectedDate = Convert.ToDateTime(reader["valuedate"]);

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                    }
                    reader.Close();
                }
                catch (SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                }
                finally
                {
                    connection.Close();
                }

                e.Canceled = true;
            }
        }

        //protected void dlPaymode_ItemSelected(object sender, DropDownListEventArgs e)
        //{
        //    if (dlPaymode.SelectedText == "Cash")
        //    {
        //        txtChequeno.Text = ""; 
        //        txtChequeno.Enabled = false;
        //        dpValueDate.SelectedDate = DateTime.UtcNow;
        //        dpValueDate.Enabled = false;
        //    }
        //    else if (dlPaymode.SelectedText == "Cheque")
        //    {
        //        txtChequeno.Enabled = true;
        //        dpValueDate.Enabled = true;
        //    }
        //}

        //protected void dlPaymode1_ItemSelected(object sender, DropDownListEventArgs e)
        //{
        //    if (dlPaymode1.SelectedText == "Cash")
        //    {
        //        txtChequeno1.Text = "";
        //        txtChequeno1.Enabled = false;
        //        dpValueDate1.SelectedDate = DateTime.UtcNow;
        //        dpValueDate1.Enabled = false;
        //    }
        //    else if (dlPaymode1.SelectedText == "Cheque")
        //    {
        //        txtChequeno1.Enabled = true;
        //        dpValueDate1.Enabled = true;
        //    }
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string yearmm = dlYear.SelectedText + dlMonth.SelectedValue;
                string paymsg = dlMonth.SelectedText + " " + dlYear.SelectedText;
                string query = "insert into tithes(memberid,paydate,paymode,yearmm,paymsg,payamt,chequeno,valuedate,signedby) ";
                query += "values(@memberid,@paydate,@paymode,@yearmm,@paymsg,@payamt,@chequeno,@valuedate,@signedby)";
                command = new SqlCommand(query, connection);
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.Parameters.Add("@memberid", SqlDbType.VarChar).Value = txtMemberID.Text;
                command.Parameters.Add("@paydate", SqlDbType.Date).Value = dpPaydate.SelectedDate;
                command.Parameters.Add("@paymode", SqlDbType.VarChar).Value = "Cash";
                command.Parameters.Add("@yearmm", SqlDbType.NChar).Value = yearmm;
                command.Parameters.Add("@paymsg", SqlDbType.VarChar).Value = paymsg;
                command.Parameters.Add("@payamt", SqlDbType.Money).Value = txtAmount.Text;
                command.Parameters.Add("@chequeno", SqlDbType.VarChar).Value = "";
                command.Parameters.Add("@valuedate", SqlDbType.Date).Value = DateTime.UtcNow;
                command.Parameters.Add("@signedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Tithe Record Saved Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);

                    sendSMS(txtMemberID.Text, txtFullname.Text, txtAmount.Value.Value.ToString("N2"), string.Format("{0:MMM dd, yyyy}", dpPaydate.SelectedDate.Value), paymsg, Context.User.Identity.Name);

                    titheGrid.Rebind();
                    txtAmount.Text = "0.0"; 
                    //txtChequeno.Text = "";
                    getTotalTithe();

                    
                }
                command.Dispose();
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }
        protected void sendSMS(string memberid, string membername, string payamount, string paymtdate, string paymsg, string receivedby)
        {
            string receiver = "";
            string header = "SRM";
            string message = memberid + "-" + membername + ", we have received your Tithe Payment. Desc.: " + paymsg + ". Amount: GHS" + payamount + " Date: " + paymtdate + ". Received By: " + receivedby + ". God bless you";
            string telephone = txtTelephone.Text;
            if (telephone.Length == 10)
                receiver = telephone.Substring(1, 9);
            try
            {
                string url = "http://api.mytxtbox.com/v3/messages/send?" +
                "From=" + header + "&To=%2B233" + receiver +
                "&Content=" + message +
                "&ClientId=qfhjdgwb" +
                "&ClientSecret=ynvijlcd" +
                "&RegisteredDelivery=true";

                //string url = "http://api.mytxtbox.com/v3/messages/send?" +
                //"From=" + header + "&To=%2B233" + receiver +
                //"&Content=" + message +
                //"&ClientId=ysyigczg" +
                //"&ClientSecret=lgbwgrbj" +
                //"&RegisteredDelivery=true";

                WebClient client = new WebClient();
                string text = client.DownloadString(url);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "sent", "toastr.success('Message Sent Successfully','Success');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "failed", "toastr.error('Message could not be sent','Failed');", true);
            }           
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string yearmm = dlYear1.SelectedText + dlMonth1.SelectedValue;
                string paymsg = dlMonth1.SelectedText + " " + dlYear1.SelectedText;
                string query = "update tithes set paydate=@paydate,paymode=@paymode,yearmm=@yearmm,paymsg=@paymsg,payamt=@payamt,";
                query += "chequeno=@chequeno,valuedate=@valuedate,signedby=@signedby where id = '" + ViewState["titheid"].ToString() + "'";
                command = new SqlCommand(query, connection);
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.Parameters.Add("@paydate", SqlDbType.Date).Value = dpPaydate1.SelectedDate;
                command.Parameters.Add("@paymode", SqlDbType.VarChar).Value = "Cash";
                command.Parameters.Add("@yearmm", SqlDbType.NChar).Value = yearmm;
                command.Parameters.Add("@paymsg", SqlDbType.VarChar).Value = paymsg;
                command.Parameters.Add("@payamt", SqlDbType.Money).Value = txtAmount1.Text;
                command.Parameters.Add("@chequeno", SqlDbType.VarChar).Value = "";
                command.Parameters.Add("@valuedate", SqlDbType.Date).Value = DateTime.UtcNow;
                command.Parameters.Add("@signedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Tithe Record Updated Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                    titheGrid.Rebind();
                    getTotalTithe();
                }
                command.Dispose();
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }

        protected void titheGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
                getTotalTithe();
            }
        }
    }
}