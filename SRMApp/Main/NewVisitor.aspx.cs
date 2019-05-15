using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace SRMApp.Main
{
    public partial class NewVisitor : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        SqlDataReader reader;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            command = new SqlCommand("spAddVisitor", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@visitorid", SqlDbType.Int).Direction = ParameterDirection.Output;
            command.Parameters.Add("@surname", SqlDbType.VarChar).Value = txtSurname.Text.ToUpper();
            command.Parameters.Add("@othername", SqlDbType.VarChar).Value = txtOthernames.Text.ToUpper();
            command.Parameters.Add("@gender", SqlDbType.VarChar).Value = dlGender.SelectedText;
            command.Parameters.Add("@resaddress", SqlDbType.VarChar).Value = txtResAddress.Text;
            command.Parameters.Add("@telephone", SqlDbType.VarChar).Value = txtTelephone.Text;
            command.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmail.Text;
            command.Parameters.Add("@visitreason", SqlDbType.VarChar).Value = txtReason.Text;
            command.Parameters.Add("@visitdate", SqlDbType.Date).Value = dpVisitDate.SelectedDate;
            command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                command.ExecuteNonQuery();
                int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                if (retVal == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('New Visitor Saved Successfully', 'Success')", true);
                    txtVisitorID.Text = command.Parameters["@visitorid"].Value.ToString();
                    btnSave.Enabled = false;
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