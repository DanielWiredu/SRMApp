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
    public partial class EditVisitor : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        SqlDataReader reader;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = "select * from Visitors where visitorid = @visitorid";
                command = new SqlCommand(query, connection);
                command.Parameters.Add("@visitorid", SqlDbType.VarChar).Value = Session["visitorid"].ToString();
                try
                {
                    if (connection.State == ConnectionState.Closed)
                        connection.Open();
                    reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        txtVisitorID.Text = reader["visitorid"].ToString();
                        txtSurname.Text = reader["surname"].ToString();
                        txtOthernames.Text = reader["othername"].ToString();
                        dlGender.SelectedText = reader["gender"].ToString();
                        txtResAddress.Text = reader["resaddress"].ToString();
                        txtTelephone.Text = reader["telephone"].ToString();
                        txtEmail.Text = reader["email"].ToString();
                        txtReason.Text = reader["visitreason"].ToString();
                        dpVisitDate.SelectedDate = Convert.ToDateTime(reader["visitdate"]);
                    }
                    reader.Close();
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            command = new SqlCommand("spUpdateVisitor", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@surname", SqlDbType.VarChar).Value = txtSurname.Text.ToUpper();
            command.Parameters.Add("@othername", SqlDbType.VarChar).Value = txtOthernames.Text.ToUpper();
            command.Parameters.Add("@gender", SqlDbType.VarChar).Value = dlGender.SelectedText;
            command.Parameters.Add("@resaddress", SqlDbType.VarChar).Value = txtResAddress.Text;
            command.Parameters.Add("@telephone", SqlDbType.VarChar).Value = txtTelephone.Text;
            command.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmail.Text;
            command.Parameters.Add("@visitreason", SqlDbType.VarChar).Value = txtReason.Text;
            command.Parameters.Add("@visitdate", SqlDbType.Date).Value = dpVisitDate.SelectedDate;
            command.Parameters.Add("@visitorid", SqlDbType.VarChar).Value = txtVisitorID.Text;
            command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.ExecuteNonQuery();
                int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                if (retVal == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Visitor Updated Successfully', 'Success')", true);
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