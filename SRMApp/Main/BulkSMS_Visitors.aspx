<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="BulkSMS_Visitors.aspx.cs" Inherits="SRMApp.Main.BulkSMS_Visitors" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Bulk SMS - Visitors</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                             <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                               
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="modal-body">
                               
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upVisitors">
                           <ProgressTemplate>
                            <div class="divWaiting">            
	                            <asp:Label ID="lblWait" runat="server" Text="Processing... " />
	                              <asp:Image ID="imgWait" runat="server" ImageAlign="Top" ImageUrl="/Content/img/loader.gif" />
                                </div>
                             </ProgressTemplate>
                       </asp:UpdateProgress>

                         <asp:UpdatePanel runat="server" ID="upVisitors" >
                    <ContentTemplate>
                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnSMS" CssClass="btn btn-success" Text="New SMS" OnClick="btnSMS_Click" CausesValidation="false" />  
                                            </div>
                                        </div>
                                    </div>

                         <telerik:RadGrid ID="visitorGrid" runat="server" AllowMultiRowSelection="true" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="True" AllowPaging="False" AllowSorting="True" CellSpacing="-1" DataSourceID="visitorSource" GridLines="Both" OnItemDataBound="visitorGrid_ItemDataBound">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="true" />
                               <Scrolling AllowScroll="true" ScrollHeight="350px" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                           
                            <MasterTableView DataKeyNames="VisitorID" DataSourceID="visitorSource" CommandItemDisplay="None" CommandItemSettings-AddNewRecordText="Add New Member" AllowAutomaticDeletes="false">
                                <Columns>
                                    <telerik:GridClientSelectColumn>
                                        <HeaderStyle Width="25px" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="VisitorID" FilterControlAltText="Filter VisitorID column" HeaderText="VisitorID" ReadOnly="True" SortExpression="VisitorID" UniqueName="VisitorID" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="90px" >
                                        <HeaderStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Surname" FilterControlAltText="Filter Surname column" HeaderText="Surname" SortExpression="Surname" UniqueName="Surname" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Othername" FilterControlAltText="Filter Othername column" HeaderText="Othername" SortExpression="Othername" UniqueName="Othername" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Gender" FilterControlAltText="Filter Gender column" HeaderText="Gender" SortExpression="Gender" UniqueName="Gender" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Telephone" FilterControlAltText="Filter Telephone column" HeaderText="Telephone" SortExpression="Telephone" UniqueName="Telephone" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px" >
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                           
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="visitorSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT VisitorID, Surname, Othername, Gender, Telephone FROM Visitors">
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
    </div>


        <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server" ID="upMessage">
            <ContentTemplate>
                  <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New SMS</h4>
                </div>
                        <div class="modal-body">
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upMessage">
                                <ProgressTemplate>
                                    Sending....
                                    <img alt="" src="/Content/img/loader.gif" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                              <div class="form-group">
                               <label>Send As</label>
                               <asp:TextBox ID="txtHeader" runat="server" Width="100%" MaxLength="11" Text="SRM"></asp:TextBox>
                               <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHeader" Display="Dynamic" ForeColor="Red" ErrorMessage="Required Field" SetFocusOnError="true"></asp:RequiredFieldValidator>
                           </div>
                         <div class="form-group">
                               <label>Message</label>
                               <asp:TextBox ID="txtMessage" runat="server" Width="100%" TextMode="MultiLine" Rows="5" ></asp:TextBox>
                              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMessage" Display="Dynamic" ForeColor="Red" ErrorMessage="Required Field" SetFocusOnError="true"></asp:RequiredFieldValidator>
                           </div>
                       </div>
                <div class="modal-footer">
                     <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSend" runat="server" Text="Send" CssClass="btn btn-success" OnClick="btnSend_Click" />
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
    </script>
</asp:Content>
