﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TitheStatement.aspx.cs" Inherits="SRMApp.Reports.Tithe.TitheStatement" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="TitheReport" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="false" OnLoad="TitheReport_Load" />
    </div>
    </form>
</body>
</html>
