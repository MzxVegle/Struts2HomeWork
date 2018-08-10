<%--
  Created by IntelliJ IDEA.
  User: Vegle
  Date: 2018/3/7
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="0">
    <title>后台管理系统</title>

    <link rel="stylesheet" href="css/MyWebCMS.css">
    <link rel="stylesheet" href="css/font-awesome-4.7.0/css/font-awesome.css">

    <link rel="stylesheet" href="plugs/bootstrap/css/bootstrap.min.css">

    <link href="css/jquery-ui.min.css" rel="stylesheet">

    <script src="js/jquery/jquery-3.3.1.min.js"></script>

    <script type="text/javascript" src="plugs/bootstrap/js/bootstrap.js"></script>

    <script src="js/jquery/jquery-ui.js"></script>


    <script type="text/javascript" src="js/CMSjs.js"></script>
    <style>
        .child_li{
            font-size: 15px;
            padding-left: 70px;
        }

        ul a{
            color: white;
        }
        ul li a{
            font-size: 20px;
            margin-bottom: 5px;
        }
        .nav li a:hover{

            background: #337ab7;
            color: white;
            border-radius: 0px;
        }
        .nav li a:focus{

            background: #295d90;
            color: white;
            border-radius: 0px;
        }
        th{
            text-align: center;
        }
    </style>


</head>
<body style="font-family: 'Glyphicons Halflings';src:url('fonts/glyphicons-halflings-regular.ttf')">
<div class="col-lg-12" style="background-color: #298fcc;height: auto;text-align: center;line-height: 70px;font-size: 35px;color: white">
    <label style="text-align: center">欢迎使用后台管理系统</label>

    <div style="float: right;font-size: 10px;">
        <label >用户名：${sessionScope.user.id}</label>

        <a href="#" id="releaseID" class="btn btn-danger" style="width: 100px">注销</a>



    </div>

</div>



    <div class="col-md-2" style="height:auto;padding-left:0px;padding-right:0px;background-color: rgb(41,143,204);margin-top:1px;border-right:1px solid #eeeeee;padding-left: 0px;">

        <div class="list-group" >
        <ul class="nav nav-pills nav-stacked">
            <li role="presentation" >
            <!--

                    用户管理标签

            -->

                <a href="" onclick="toggle_blind('user_child_menu');return false" id = "user_main_menu" >
                    <i class="fa fa-user-o" style="margin-right: 2px"></i>
                    管理用户</a>
                <ul class="nav nav-pills nav-stacked hide_menu" id="user_child_menu" >
                    <li >
                        <a href="#" id="view_user">
                            <span class="child_li" >查看用户</span>
                            <span class="fa fa-arrow-right" style="float:right;margin-top: 2px"></span>
                        </a>
                    </li>
                    <li>
                        <a href="#" id="adduser" >
                            <span class="child_li" >添加用户</span>
                            <span class="fa fa-arrow-right" style="float:right;margin-top: 2px"></span>
                        </a>
                    </li>

                </ul>
            </li>
        </ul>
    </div>
    </div>
    <div class="col-md-10" id="right"></div>
</body>
</html>
