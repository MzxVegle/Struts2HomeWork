<%--
  Created by IntelliJ IDEA.
  User: vegle
  Date: 2018/2/15
  Time: 下午11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登陆</title>
    <link rel="stylesheet" href="plugs/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome-4.7.0/css/font-awesome.min.css">
    <script type="text/javascript" src="js/jquery/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="plugs/bootstrap/js/bootstrap.js"></script>


</head>
<%
    request.setAttribute("Error"," ");
%>

<body style="background-color: #4cae4c" onload="document.form1.usname.focus()">
    <div id="container" style="width: 500px;margin: 120px auto;">
        <div class="col-md-12">
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <h3 class="panel-title">登陆</h3>
                </div>
                <div class=" panel-body">
                    <form id="form1" name="form1" style="text-align: center">
                        <div class="input-group">
                            <span class="input-group-addon" id="sizing-addon2"><i class="fa fa-user"></i></span>
                            <input type="text" class="form-control" id="usname" name="usname" placeholder="Username" aria-describedby="sizing-addon2">
                        </div>
                        <br>
                        <br>
                        <div class="input-group ">
                            <span class="input-group-addon " id="sizing-addon3"><i class="fa fa-lock"></i></span>
                            <input type="password" class="form-control" id="pwd" name="pwd" placeholder="PassWord"  aria-describedby="sizing-addon3">

                        </div>
                        <p id="mes" style="color:red"></p>

                        <input type="button" id="btnsubmit" class="btn btn-primary" style="width: 200px"  value="登陆">
                        <input type="button" class="btn btn-danger" style="width: 200px" value="返回主页" onclick="window.location.href= 'index.jsp'">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnsubmit").on("click",function () {
                $.ajax({
                    url:"/login",
                    type: "post",
                    data:$("#form1").serialize(),
                    success:function(){
                        window.location.href="MyWebCMS.jsp";
                    },
                    error:function (data) {
                        $("#mes").text("登陆失败！用户名或密码错误！");
                    }
                })
            })

        })
    </script>
</body>
</html>
