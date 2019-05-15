﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="IndProjectPayments.aspx.cs" Inherits="SRMApp.Financials.IndProjectPayments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Project Payments</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <asp:HiddenField runat="server" ID="hfProjectId" />
                    <div class="ibox-content">
                  <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                        <div class="alert alert-info" runat="server" id="lblProjectName"></div>
                      <div class="form-group">
                 <div class="row">
                      <div class="col-md-3">
                         <label>Payer ID</label>
                         <asp:TextBox ID="txtPayerID" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                     </div>
                     <div class="col-md-4">
                         <label>Name</label>
                         <asp:TextBox ID="txtFullname" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                     </div>
                     <div class="col-md-2">
                         <label>Telephone</label>
                         <asp:TextBox ID="txtTelephone" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                     </div>
                    <div class="col-md-3">
                         <label>Balance</label>
                        <asp:TextBox ID="txtBalance" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                     </div>
                 </div>
             </div>
                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button ID="btnNewPayment" runat="server" Text="Add Payment" CssClass="btn btn-success" OnClientClick="newModal()"/>
                                                <asp:LinkButton ID="btnReturn" runat="server" Text="Back" CssClass="btn btn-warning"></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>

                        <telerik:RadGrid ID="paymentGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="paymentSource" GroupPanelPosition="Top" OnItemCommand="paymentGrid_ItemCommand" OnDeleteCommand="paymentGrid_DeleteCommand">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="paymentSource" PageSize="50">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridDateTimeColumn DataField="paydate" DataType="System.DateTime" FilterControlAltText="Filter paydate column" HeaderText="Date" SortExpression="paydate" UniqueName="paydate" AutoPostBackOnFilter="true" ShowFilterIcon="true" FilterControlWidth="120px" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridDateTimeColumn>
                                    <telerik:GridBoundColumn DataField="payamt" DataType="System.Decimal" FilterControlAltText="Filter payamt column" HeaderText="Amount" SortExpression="payamt" UniqueName="payamt" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px" DataFormatString="{0:N02}">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="receiptno" FilterControlAltText="Filter receiptno column" HeaderText="Receipt No" SortExpression="receiptno" UniqueName="receiptno" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="paytype" FilterControlAltText="Filter paytype column" HeaderText="Description" SortExpression="paytype" UniqueName="paytype" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="paymentSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT id, paydate, payamt, receiptno, case paytype when 1 then 'Contribution' when 2 then 'Pledge' end as paytype FROM ProjectPayments WHERE (payerid = @payerid) and (projectid = @projectid) ORDER BY paydate DESC">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtPayerID" DefaultValue=" " Name="payerid" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="hfProjectId" DefaultValue="0" Name="projectid" PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>


      <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Payment</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                   <label>Payment Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpPaydate" Width="100%"></telerik:RadDatePicker>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpPaydate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                              <div class="form-group">
                               <label>Amount [GHC]</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtAmount" MinValue="0" Width="100%" Value="0" ShowSpinButtons="true"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtAmount" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Receipt No</label>
                                <asp:TextBox runat="server" ID="txtReceiptNo" Width="100%" ClientIDMode="Static"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="txtReceiptNo" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Required Field" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Pledge</label>
                                <asp:CheckBox runat="server" ID="chkPledge" ClientIDMode="Static" onclick="setReceipt();"  />
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" ValidationGroup="new" OnClick="btnSave_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <!-- edit modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Payment</h4>
                </div>
                     <div class="modal-body">
                             <div class="form-group">
                                   <label>Payment Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpPaydate1" Width="100%"></telerik:RadDatePicker>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpPaydate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                              <div class="form-group">
                               <label>Amount [GHC]</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtAmount1" MinValue="0" Width="100%" Value="0" ShowSpinButtons="true"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtAmount1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                         <div class="form-group">
                                <label>Receipt No</label>
                                <asp:TextBox runat="server" ID="txtReceiptNo1" Width="100%"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="txtReceiptNo1" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Required Field" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Pledge</label>
                                <asp:CheckBox runat="server" ID="chkPledge1" />
                            </div>
                       </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" ValidationGroup="edit" OnClick="btnUpdate_Click"/>
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

        <script type="text/javascript">
            function newModal() {
                $('#newmodal').modal('show');
                $('#newmodal').appendTo($("form:first"));
            }
            function closenewModal() {
                $('#newmodal').modal('hide');
            }
            function editModal() {
                $('#editmodal').modal('show');
                $('#editmodal').appendTo($("form:first"));
            }
            function closeeditModal() {
                $('#editmodal').modal('hide');
            }
            
            function setReceipt() {
                if (document.getElementById('chkPledge').checked) {
                    $('#txtReceiptNo').val('PLEDGE');
                } else {
                    $('#txtReceiptNo').val('');
                }
            }
    </script>
</asp:Content>
