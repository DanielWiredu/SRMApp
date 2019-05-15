using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SRMApp.Reports
{
    public partial class VisitorReports : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            string startdate = dpSdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            string enddate = dpEdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Visitors/vwVisitorsByGender.aspx?sdate="+ startdate +"&edate=" + enddate + "');", true);
        }
    }
}