<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="TitheReports.aspx.cs" Inherits="SRMApp.Reports.TitheReports" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Tithe Reports</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                          <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                          <div class="bg-primary">Select duration for Report</div>
             
                       <div class="form-group">
                          <div class="row">
                              <div class="col-md-1">

                              </div>
                              <div class="col-md-3">
                                  <label>Start Date</label>
                                  <telerik:RadDatePicker ID="dpSdate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpSdate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Start date required"></asp:RequiredFieldValidator>
                              </div>
                                <div class="col-md-3">
                                  <label>End Date</label>
                                  <telerik:RadDatePicker ID="dpEdate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpEdate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="End date required"></asp:RequiredFieldValidator>
                              </div>
                              <div class="col-md-4">
                                  <label>Member ID</label>
                                  <asp:TextBox runat="server" ID="txtMemberID" Width="100%"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMemberID" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Enter Member ID"></asp:RequiredFieldValidator>

                              </div>
                              <div class="col-md-1">

                              </div>
                          </div>
                      </div>

                     <div class="modal-footer">
                    <asp:Button ID="btnReport" CssClass="btn btn-primary" runat="server" Text="Generate Report" OnClick="btnReport_Click"/>         
                </div>

                         <div class="divider"></div>
                        <div>&nbsp;</div>
                         <div class="bg-primary">Select Period for Report</div>
                       <div class="form-group">
                          <div class="row">
                              <div class="col-md-1">

                              </div>
                              <div class="col-md-3">
                                  <label>Type</label>
                                  <asp:RadioButtonList ID="rdType" runat="server" RepeatDirection="Horizontal">
                                      <asp:ListItem Text="Monthly" Value="Monthly" Selected="True"></asp:ListItem>
                                      <asp:ListItem Text="Yearly" Value="Yearly"></asp:ListItem>
                                  </asp:RadioButtonList>
                              </div>
                              <div class="col-md-3">
                                  <label>Month/Year</label>
                                  <telerik:RadMonthYearPicker ID="dpPeriod" runat="server" DateInput-ReadOnly="true" Width="100%"></telerik:RadMonthYearPicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpPeriod" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Report Period required" ValidationGroup="payers"></asp:RequiredFieldValidator>
                              </div>
                              <div class="col-md-1">

                              </div>
                          </div>
                      </div>

                     <div class="modal-footer">
                    <asp:Button ID="btnReportPayers" CssClass="btn btn-primary" runat="server" Text="Generate Report" OnClick="btnReportPayers_Click" ValidationGroup="payers"/>         
                </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
