﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SRMApp.Reports
{
    public partial class ChequeReports : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnReport_Click(object sender, EventArgs e)
        {
            Session["sdate"] = dpSdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            Session["edate"] = dpEdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            Session["currency"] = dlCurrency.SelectedValue;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Cheques/ChequeRegister.aspx');", true);
        }
    }
}