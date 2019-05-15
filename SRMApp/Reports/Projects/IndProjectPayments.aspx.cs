﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using CrystalDecisions.Shared;

namespace SRMApp.Reports.Projects
{
    public partial class IndProjectPayments : System.Web.UI.Page
    {
        rptIndProjectPayments rpt = new rptIndProjectPayments();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataSet ds = new DataSet();
        string projectId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                projectId = Request.QueryString["pid"].ToString();
            }
        }

        protected void IndProjectPaymentReport_Load(object sender, EventArgs e)
        {
            adapter = new SqlDataAdapter("SELECT * FROM [dbo].[rptIndProjectPayments](@projectId)", connection);
            adapter.SelectCommand.Parameters.Add("@projectId", SqlDbType.Int).Value = projectId;
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "Command");
            rpt.SetDataSource(ds);

            IndProjectPaymentReport.ReportSource = rpt;
        }
    }
}