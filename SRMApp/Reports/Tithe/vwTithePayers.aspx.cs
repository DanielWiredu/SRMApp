using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using CrystalDecisions.Shared;

namespace SRMApp.Reports.Tithe
{
    public partial class vwTithePayers : System.Web.UI.Page
    {
        rptTithePayers rpt = new rptTithePayers();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TithePayersReport_Load(object sender, EventArgs e)
        {
            string payperiod = Request.QueryString["payperiod"].ToString();

            ParameterValues parameters = new ParameterValues();
            ParameterDiscreteValue yearmm = new ParameterDiscreteValue();

            yearmm.Value = payperiod;

            adapter = new SqlDataAdapter("select * from MemberTithes where yearmm like '%' + @payperiod + '%'", connection);
            adapter.SelectCommand.Parameters.Add("@payperiod", SqlDbType.VarChar).Value = payperiod;
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "MemberTithes");
            rpt.SetDataSource(ds);

            parameters.Add(yearmm);
            rpt.DataDefinition.ParameterFields["payyyyymm"].ApplyCurrentValues(parameters);

            TithePayersReport.ReportSource = rpt;
        }
    }
}