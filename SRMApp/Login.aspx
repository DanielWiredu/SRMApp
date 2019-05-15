<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SRMApp.Login" %>

<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SRM Church Management System</title>

    <link href="/Content/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Content/font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="/Content/css/animate.css" rel="stylesheet">
    <link href="/Content/css/style.css" rel="stylesheet">

    <link href="/Content/css/plugins/toastr/toastr.min.css" rel="stylesheet"/>

</head>

<body style="background:url(/Content/img/ChurchLifeLoginBg.jpg) no-repeat center center fixed; background-size:cover; ">

    <div class="loginColumns animated fadeInDown">
        <div class="row">
            <div class="col-md-5" style="color:white">
                <%--<h2 class="font-bold">SPIRITLIFE REVIVAL MINISTRIES</h2>--%>

                <p>
                    In the year 2006, Prophet Bernard ElBernard Nelson-Eshun received a commission from the Lord to move to the city of Accra and raise for Him a people of impact.
                </p>

                <p>
                     It was out of this commission that Spiritlife Revival Ministries ministries was born. It was officially inaugurated on the 24th of Ferburary 2008, in Accra, Ghana. The first meeting was held at the conference hall of Sunny-Fm, Kanda.
                </p>

                <p>
                    The history of Spiritlife Revival Ministries is still being written with many phases yet to unfold.

                We invite you to join us on this destiny transforming path.
                </p>
            </div>
            <div class="col-md-3">

            </div>

            <div class="col-md-4">
                <div class="ibox-content">
                    <form class="m-t" runat="server" defaultbutton="btnLogin">
                            <asp:ScriptManager runat="server"></asp:ScriptManager>

                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Username" id="txtUsername" required="required" runat="server">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="Password" id="txtPassword" required="required" runat="server">
                        </div>
                            <asp:Button runat="server"  Text="Login" ID="btnLogin" CssClass="btn btn-primary block full-width m-b" OnClick="btnLogin_Click" />
                        <%--<button type="submit" class="btn btn-primary block full-width m-b" runat="server" onclick="return ValidateForm()" onserverclick="btnLogin_Click">Login</button>--%>

                        <%--<a href="#">
                            <small>Forgot password?</small>
                        </a>--%>

                        <%--<p class="text-muted text-center">
                            <small>Do not have an account?</small>
                        </p>--%>
                        <%--<a class="btn btn-sm btn-white btn-block" href="register.html">Create an account</a>--%>
                   
                        </ContentTemplate>
                    </asp:UpdatePanel>
                     </form>
                    <p class="m-t">
                        <small>Enter your username and password to sign in</small>
                    </p>
                </div>
            </div>
        </div>
        <hr/>
        <div class="row">
            <div class="col-md-6"> 
                <%--Powered by <a href="http://www.eupacwebs.com/" target="_blank">Eupac Web Solutions Limited</a>--%>
            </div>
            <div class="col-md-6 text-right" style="color:darkgray">
               <strong>Copyright &copy; <%=DateTime.UtcNow.Year.ToString() %> <a href="http://eupacwebs.com/" target="_blank" >Eupac Web Solutions Limited</a>.</strong> 
            </div>
        </div>
    </div>

    <script src="/Content/js/jquery-2.1.1.js"></script>
    <script src="/Content/js/bootstrap.min.js"></script>
    <script src="/Content/js/plugins/toastr/toastr.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            setTimeout(function () {
                toastr.options = {
                    closeButton: true,
                    progressBar: true,
                    showMethod: 'slideDown',
                    timeOut: 3000
                };
            }, 1300);
        });

        function ValidateForm() {
            var valid = true;
            //All Validations. If any validations failed, set valid = false;
            if ($('#txtUsername').val() == "" || $('#txtUsername').val() == null) {
                toastr.error('Username Required', 'Error');
                $('#txtUsername').focus();
                valid = false;
            }
            if ($('#txtPassword').val() == "" || $('#txtPassword').value() == null) {
                toastr.error('Password Required', 'Error');
                $('#txtPassword').focus();
                valid = false;
            }
            return valid;
        }
    </script>

    </body>
</html>
