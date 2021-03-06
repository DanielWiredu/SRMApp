﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Members.aspx.cs" Inherits="SRMApp.Main.Members" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Members</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                             <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="/Main/InactiveMembers.aspx">Inactive Members</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                            <asp:Button runat="server" Text="Add Member" CssClass="btn btn-success" PostBackUrl="~/Main/NewMember.aspx" />
                             <a href="/Main/InactiveMembers.aspx" class="btn btn-warning" >Inactive Members</a>

                         <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                         <telerik:RadGrid ID="memberGrid" runat="server" AutoGenerateColumns="False"  GroupPanelPosition="Top" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="-1" DataSourceID="memeberSource" GridLines="Both" OnItemCommand="memberGrid_ItemCommand" OnItemDeleted="memberGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="true" />
                               <Scrolling AllowScroll="true" ScrollHeight="350px" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                           
                            <MasterTableView DataKeyNames="MemberID" DataSourceID="memeberSource" CommandItemDisplay="None" CommandItemSettings-AddNewRecordText="Add New Member" AllowAutomaticDeletes="false">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="MemberID" FilterControlAltText="Filter MemberID column" HeaderText="MemberID" ReadOnly="True" SortExpression="MemberID" UniqueName="MemberID" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="90px" >
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
                                    <telerik:GridDateTimeColumn DataField="Birthday" DataType="System.DateTime" FilterControlAltText="Filter Birthday column" HeaderText="Birthday" SortExpression="Birthday" UniqueName="Birthday" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px" DataFormatString="{0:dd-MMM-yyyy}">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridDateTimeColumn>
                                    <telerik:GridBoundColumn DataField="Telephone" FilterControlAltText="Filter Telephone column" HeaderText="Telephone" SortExpression="Telephone" UniqueName="Telephone" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px" >
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                     <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Deactivate" ButtonCssClass="btn-warning" Text="Deactivate" ConfirmText="Make Member Inactive?">
                                        <HeaderStyle Width="80px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Member and all related tithe records?" ButtonType="PushButton" ButtonCssClass="btn-danger" Visible="false">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                           
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="memeberSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT MemberID, Surname, Othername, Gender, Birthday, Telephone FROM Members Where Active = 1" DeleteCommand="DELETE FROM [Members] WHERE [MemberID] = @MemberID">
                            <DeleteParameters>
                                <asp:Parameter Name="MemberID" Type="String" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
