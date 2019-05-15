using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SRMApp.Reports
{
    public partial class TitheReports : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnReport_Click(object sender, EventArgs e)
        {
            Session["sdate"] = dpSdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            Session["edate"] = dpEdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            Session["rptMemberID"] = txtMemberID.Text;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Tithe/TitheStatement.aspx');", true);
        }

        protected void btnReportPayers_Click(object sender, EventArgs e)
        {
            string payperiod = "";
            if (rdType.SelectedValue == "Monthly")
                payperiod = dpPeriod.SelectedDate.Value.ToString("yyyyMM");
            else if (rdType.SelectedValue == "Yearly")
                payperiod = dpPeriod.SelectedDate.Value.ToString("yyyy");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Tithe/vwTithePayers.aspx?payperiod=" + payperiod + "');", true);
        }
    }
}