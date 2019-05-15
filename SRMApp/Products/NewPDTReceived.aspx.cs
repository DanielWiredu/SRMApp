﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace SRMApp.Products
{
    public partial class NewPDTReceived : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spAddProductReceived", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@receiveddate", SqlDbType.Date).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@department", SqlDbType.VarChar).Value = dlDepartment.SelectedValue;
                    command.Parameters.Add("@productId", SqlDbType.Int).Value = dlProduct.SelectedValue;
                    command.Parameters.Add("@quantity", SqlDbType.Int).Value = txtQuantity.Text;
                    command.Parameters.Add("@receivedby", SqlDbType.VarChar).Value = txtReceiver.Text;
                    command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
                    command.Parameters.Add("@createdby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                    command.Parameters.Add("@createddate", SqlDbType.Date).Value = DateTime.UtcNow;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Product Received Successfully', 'Success');", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}