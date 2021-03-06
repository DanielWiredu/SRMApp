﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace SRMApp.Main
{
    public partial class BulkSMS_Visitors : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSMS_Click(object sender, EventArgs e)
        {
            if (visitorGrid.SelectedItems.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.warning('No Visitor(s) Selected', 'Info');", true);
                return;
            }
            else
            {
                //txtMessage.Text = "";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "newModal();", true);
            }
        }

        protected void visitorGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                if (item["Telephone"].Text.Length < 10)
                {
                    //item.SelectableMode = GridItemSelectableMode.None;
                    item.Display = false;
                    //item.
                }
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            string receiver = "";
            string header = txtHeader.Text.Trim();
            string message = txtMessage.Text;
            string telephone;
            int sentsms = 0; int failedsms = 0;
            foreach (GridDataItem item in visitorGrid.SelectedItems)
            {
                telephone = item["Telephone"].Text;
                if (telephone.Length == 10)
                    receiver = telephone.Substring(1, 9);
                try
                {
                    string url = "http://api.mytxtbox.com/v3/messages/send?" +
                    "From=" + header + "&To=%2B233" + receiver +
                    "&Content=" + message +
                    "&ClientId=qfhjdgwb" +
                    "&ClientSecret=ynvijlcd" +
                    "&RegisteredDelivery=true";
                    WebClient client = new WebClient();
                    string text = client.DownloadString(url);
                    //successWriter.WriteLine(DateTime.UtcNow.ToString() + "  " + telephone);
                    sentsms++;
                }
                catch (Exception ex)
                {
                    //failedWriter.WriteLine(DateTime.UtcNow.ToString() + "  " + telephone);
                    failedsms++;
                }
            }
            //successWriter.Close();
            //successWriter.Dispose();
            //failedWriter.Close();
            //failedWriter.Dispose();

            if (sentsms > 0)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "sent", "toastr.success('" + sentsms + " Message(s) Sent Successfully','Success');", true);
            if (failedsms > 0)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "failed", "toastr.error('" + failedsms + " Message(s) could not be sent','Failed');", true);

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "log", "toastr.info('Check messaging log','Log');", true);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
        }
    }
}