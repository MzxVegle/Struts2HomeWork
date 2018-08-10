<%--
  Created by IntelliJ IDEA.
  User: Vegle
  Date: 2018/3/11
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="0">


</head>
<script>
    $(document).ready(function () {
        $("#submit").on("click",function () {
            $.ajax({
                type:"post",
                url:"/AddUser",
                datatype:"text",
                data:$("#form").serialize(),
                success:function (result) {
                    alert(result);
                }

            })
        })
    })
</script>
<body>
<div class="panel panel-info" style="margin:0 auto;margin-top: 100px;width: 600px">
    <div class="panel-heading">
        <h3 class="panel-title">添加用户</h3>
    </div>
    <div class="panel-body">
        <form id="form" style="margin: 0px auto" role="form" action="##" onsubmit="return false;" method="post">
            <div class="form-group">
                <div class="input-group ">
                    <span class="input-group-addon" id="sizing-addon0"><i class="fa fa-user"></i></span>
                    <input type="text" class="form-control" id="id" name="id" placeholder="登陆ID(必填)" aria-describedby="sizing-addon0">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group ">
                    <span class="input-group-addon" id="sizing-addon1"><i class="fa fa-id-badge"></i></span>
                    <input type="text" class="form-control" id="usname" name="usname" placeholder="用户名(必填)" aria-describedby="sizing-addon1">
                </div>
            </div>
            <div class="form-group ">
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"><label for="sizing-addon2">P</label></span>
                    <input type="text" class="form-control" id="pwd" name="pwd" placeholder="密码(必填)" aria-describedby="sizing-addon2">
                </div>
            </div>

            <div class="form-group" id="radiobox" >
                <label for="radiobox">性别</label>
                <input type="radio" name="sex" value="男" id="male"><label for="male">男</label>
                <input type="radio" name="sex" value="女" id="female"><label for="female">女</label>
            </div>

            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon3"><label for="sizing-addon3">@</label></span>
                    <input type="text" class="form-control" id="age" name="age" placeholder="年龄" aria-describedby="sizing-addon3">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group ">
                    <span class="input-group-addon" id="sizing-addon4"><i class="fa fa-id-badge"></i></span>
                    <input type="text" class="form-control" id="realname" name="realname" placeholder="真实姓名" aria-describedby="sizing-addon4">
                </div>
            </div>

            <label for="permission">权限</label>   <select id="permission" class="form-group" name="permission">
            <option value="admin">管理员</option>
            <option value="normal">普通用户</option>
        </select>   <label style="color: red">*</label>

            <div class="form-group" style="margin-left:130px">
                <input type="button" class="btn btn-primary" style="width: 300px" id="submit" value="添加用户">
            </div>


        </form>

    </div>
</div>
</body>
</html>
