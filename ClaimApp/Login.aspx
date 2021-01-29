<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ClaimApp.Login" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="bower_components/Ionicons/css/ionicons.min.css" />
    <link rel="stylesheet" href="assets/css/AdminLTE.min.css" />
    <link rel="stylesheet" href="assets/css/style.css" />

    <script src="bower_components/sweetalert/sweetalert2.all.min.js"></script>
</head>
<body class="hold-transition login-page">
    <div class="login-box">
        <div class="login-box-body">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/assets/img/logo.png" Height="100px" CssClass="m-b-20 center-block" />
            <asp:Label ID="lblError" runat="server" Text="WRONG USERNAME/PASSWORD" CssClass="alert alert-danger" Visible="False"></asp:Label>
            <form id="formLogin" runat="server">
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="User ID" autocomplete="off" autofocus="autofocus" Text=""></asp:TextBox>
                    <span class="glyphicon glyphicon-user form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="PASSWORD" Text=""></asp:TextBox>
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
                <div class="row">
                    <div class="col-xs-12">
                        <dx:BootstrapButton ID="btnLogin" runat="server" Text="SIGN IN" OnClick="btnLogin_Click">
                            <CssClasses Control="btn btn-success btn-block color-white" Icon="fa fa-sign-in color-white" />
                        </dx:BootstrapButton>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
</body>
</html>
