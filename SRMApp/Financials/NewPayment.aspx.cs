﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace SRMApp.Financials
{
    public partial class NewPayment : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpValueDate.SelectedDate = DateTime.UtcNow;
                if (Session["npType"].ToString() == "Income")
                    btnReturn.PostBackUrl = "/Financials/IncomeList.aspx";
                else
                    btnReturn.PostBackUrl = "/Financials/ExpenseList.aspx";
            }
        }
        protected void dlPaymode_ItemSelected(object sender, DropDownListEventArgs e)
        {
            if (dlPaymode.SelectedText == "Cash")
            {
                dlBank.ClearSelection();
                dlBank.Enabled = false;
                txtChequeno.Text = "";
                txtChequeno.Enabled = false;
                dpValueDate.SelectedDate = DateTime.UtcNow;
                dpValueDate.Enabled = false;
            }
            else if (dlPaymode.SelectedText == "Cheque")
            {
                dlBank.Enabled = true;
                txtChequeno.Enabled = true;
                dpValueDate.Enabled = true;
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string Payyyyymm = dpPaydate.SelectedDate.Value.ToString("yyyyMM");
            string query = "insert into Payments(paydate,payname,description,paytype,paymode,currency,amount,paybank,chequeno,valuedate,remarks,preparedby,payyyyymm) ";
            query += "values(@paydate,@payname,@description,@paytype,@paymode,@currency,@amount,@paybank,@chequeno,@valuedate,@remarks,@preparedby,@payyyyymm)";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@paydate", SqlDbType.Date).Value = dpPaydate.SelectedDate;
            command.Parameters.Add("@payname", SqlDbType.VarChar).Value = txtName.Text;
            command.Parameters.Add("@description", SqlDbType.VarChar).Value = dlDescription.SelectedText;
            command.Parameters.Add("@paytype", SqlDbType.VarChar).Value = dlDescription.SelectedValue;
            command.Parameters.Add("@paymode", SqlDbType.VarChar).Value = dlPaymode.SelectedText;
            command.Parameters.Add("@currency", SqlDbType.VarChar).Value = dlCurrency.SelectedText;
            command.Parameters.Add("@amount", SqlDbType.VarChar).Value = txtAmount.Text;
            command.Parameters.Add("@paybank", SqlDbType.VarChar).Value = dlBank.SelectedValue;
            command.Parameters.Add("@chequeno", SqlDbType.VarChar).Value = txtChequeno.Text;
            command.Parameters.Add("@valuedate", SqlDbType.Date).Value = dpValueDate.SelectedDate;
            command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
            command.Parameters.Add("@preparedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
            command.Parameters.Add("@payyyyymm", SqlDbType.VarChar).Value = Payyyyymm;
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                    dpPaydate.Clear();
                }
                command.Dispose();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }

    }
}