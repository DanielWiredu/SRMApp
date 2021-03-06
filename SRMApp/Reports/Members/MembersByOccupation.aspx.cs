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

namespace SRMApp.Reports.Members
{
    public partial class MembersByOccupation : System.Web.UI.Page
    {
        rptByOccupation rpt = new rptByOccupation();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        DataSet ds = new DataSet();

        string sdate = "";
        string edate = "";
        string occupation = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void MemberReport_Load(object sender, EventArgs e)
        {
            sdate = Session["sdate"].ToString();
            edate = Session["edate"].ToString();
            occupation = Session["occupation"].ToString();

            ParameterValues parameters = new ParameterValues();
            ParameterDiscreteValue startdate = new ParameterDiscreteValue();
            ParameterDiscreteValue enddate = new ParameterDiscreteValue();

            startdate.Value = sdate;
            enddate.Value = edate;

            adapter = new SqlDataAdapter("select occupation, memberid, surname, Othername, telephone, regdate from members where occupation like '" + occupation + "%' and regdate between '" + sdate + "' and '" + edate + "' and active = 1", connection);
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "members");
            rpt.SetDataSource(ds);

            parameters.Add(startdate);
            rpt.DataDefinition.ParameterFields["sDate"].ApplyCurrentValues(parameters);
            parameters.Add(enddate);
            rpt.DataDefinition.ParameterFields["eDate"].ApplyCurrentValues(parameters);

            MemberReport.ReportSource = rpt;
        }
    }
}