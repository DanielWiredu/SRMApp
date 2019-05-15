﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ItemsReceived.aspx.cs" Inherits="SRMApp.Inventory.ItemsReceived" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Items Received</h5>
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
                        <div class="row">
                                        <div class="col-sm-4 pull-right" style="width:inherit">
                                           <asp:Button runat="server" ID="btnExcelExport" CssClass="btn btn-primary" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click"/>
                                            <asp:Button runat="server" ID="btnPDFExport" CssClass="btn btn-warning" Text="PDF" CausesValidation="false" OnClick="btnPDFExport_Click"/>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddItem" CssClass="btn btn-success" Text="Add Received" CausesValidation="false" PostBackUrl="~/Inventory/NewItemReceived.aspx" />  
                                            </div>
                                        </div>
                                    </div>

                          <asp:UpdatePanel runat="server">
                           <ContentTemplate>
                               <telerik:RadGrid ID="itemReceivedGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="itemReceivedSource" GroupPanelPosition="Top" OnItemCommand="itemReceivedGrid_ItemCommand" OnDeleteCommand="itemReceivedGrid_DeleteCommand">
                                   <ClientSettings>
                                       <Selecting AllowRowSelect="True" />
                                       <Scrolling AllowScroll="true" ScrollHeight="400px" />
                                   </ClientSettings>
                                   <GroupingSettings CaseSensitive="false" />
                                   <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="items_received" HideStructureColumns="true" >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Items Received" PageWidth="1050"></Pdf>
                                    </ExportSettings>
                                   <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="itemReceivedSource">
                                       <Columns>
                                           <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id" Display="false">
                                           </telerik:GridBoundColumn>
                                           <telerik:GridDateTimeColumn DataField="ReceivedDate" DataType="System.DateTime" FilterControlAltText="Filter ReceivedDate column" HeaderText="ReceivedDate" SortExpression="ReceivedDate" UniqueName="ReceivedDate" AutoPostBackOnFilter="true" FilterControlWidth="120px" DataFormatString="{0:dd-MMM-yyyy}">
                                           <HeaderStyle Width="140px" />
                                           </telerik:GridDateTimeColumn>
                                           <telerik:GridBoundColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" SortExpression="Department" UniqueName="Department" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px">
                                           <HeaderStyle Width="120px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn Display="false" DataField="ItemId" SortExpression="ItemId" UniqueName="ItemId">
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description"  AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                           <HeaderStyle Width="200px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="Quantity" DataType="System.Int32" FilterControlAltText="Filter Quantity column" HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                           <HeaderStyle Width="80px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="SupplierName" FilterControlAltText="Filter SupplierName column" HeaderText="SupplierName" SortExpression="SupplierName" UniqueName="SupplierName" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                           <HeaderStyle Width="200px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="ReceivedBy" FilterControlAltText="Filter ReceivedBy column" HeaderText="ReceivedBy" SortExpression="ReceivedBy" UniqueName="ReceivedBy" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px">
                                           <HeaderStyle Width="120px" />
                                           </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                            <HeaderStyle Width="40px" />
                                            </telerik:GridButtonColumn>
                                            <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                            <HeaderStyle Width="50px" />
                                            </telerik:GridButtonColumn>
                                       </Columns>
                                   </MasterTableView>
                               </telerik:RadGrid>
                               <asp:SqlDataSource ID="itemReceivedSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vwItemsReceived]"></asp:SqlDataSource>
                           </ContentTemplate>
                               <Triggers>
                                  <asp:PostBackTrigger ControlID="btnExcelExport" />
                                  <asp:PostBackTrigger ControlID="btnPDFExport" />
                              </Triggers>
                       </asp:UpdatePanel>   
                    </div>
                </div>
        </div>
</asp:Content>
