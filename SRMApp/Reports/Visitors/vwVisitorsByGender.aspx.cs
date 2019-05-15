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

namespace SRMApp.Reports.Visitors
{
    public partial class vwVisitorsByGender : System.Web.UI.Page
    {
        rptByGender rpt = new rptByGender();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        DataSet ds = new DataSet();

        string sdate = "";
        string edate = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void VisitorsByGenderReport_Load(object sender, EventArgs e)
        {
            sdate = Request.QueryString["sdate"].ToString();
            edate = Request.QueryString["edate"].ToString();

            ParameterValues parameters = new ParameterValues();
            ParameterDiscreteValue startdate = new ParameterDiscreteValue();
            ParameterDiscreteValue enddate = new ParameterDiscreteValue();

            startdate.Value = sdate;
            enddate.Value = edate;

            adapter = new SqlDataAdapter("select gender, visitorid, surname, Othername, telephone, visitdate from visitors where visitdate between @startdate and @enddate", connection);
            adapter.SelectCommand.Parameters.Add("@startdate", SqlDbType.DateTime).Value = sdate;
            adapter.SelectCommand.Parameters.Add("@enddate", SqlDbType.DateTime).Value = edate;
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "visitors");
            rpt.SetDataSource(ds);

            parameters.Add(startdate);
            rpt.DataDefinition.ParameterFields["sDate"].ApplyCurrentValues(parameters);
            parameters.Add(enddate);
            rpt.DataDefinition.ParameterFields["eDate"].ApplyCurrentValues(parameters);

            VisitorsByGenderReport.ReportSource = rpt;
        }
    }
}