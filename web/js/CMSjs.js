var List;
var totalPage ;
var currentPage ;
$(document).ready(function () {
    $("#alter_btn").button();
    $("#delete_btn").button();


    $("#releaseID").on("click",function () {           //注销ID点击事件
        var result = confirm("您确定注销吗？");
        if(result == true){
            window.location.href="/Release"
        }
    })

    $("#view_user").on("click",function () {            //view_user点击事件

        show_user();

    });

    //添加用户绑定事件
    $("#adduser").on("click",function () {
        $("#right").load("midForm/adduser.jsp")
    })
    //修改用户绑定事件
    $("#updateuser").on("click",function(){
        $("#right").load("midForm/updateuser.jsp");

    })
});

function show_user() {
    /*
        *
        * ajax
        * 提交模式：poat
        * 返回类型：json
        * success接受json对象，
        * 其中封装了list<user>
        * 如果执行成功，则会回调success中的函数输出一系列表格
        *
        * */
    $.ajax({
        type: "post",
        url: "/ViewUser.action?flag=default",
        responseText: "json",
        success: function (data) {
            var data2 = eval(data);
            List = data2[2];
            totalPage = data2[0];
            currentPage = data2[1];
            $("#right").html(
                "<div class=\"panel panel-primary\" id='user_panel' style=\"width: 900px;margin: 0px auto;margin-top: 10px;\">\n" +
                "        <div class=\"panel-heading\">\n" +
                "            <h3 class=\"panel-title\">用户列表</h3>\n" +
                "        </div>\n" +
                "        <div class=\"panel-body\" id=\"view_box\" >\n" +
                "        </div>\n" +
                    "<div class='col-md-offset-5' id='pagebar'>" +
                    "<ul class=\"pagination\"  style='margin: 0px '>\n" +
                    "    <li id='previous'><a href=\"#\" id='previousbtn' onclick='pageUtil(\"previous\")'>&laquo;</a></li>\n" +

                    /*

                       generatepagebar函数中填充

                    */
                    "    <li id='next'><a href=\"#\" onclick='pageUtil(\"next\")'>&raquo;</a></li>\n" +
                    "</ul>"+
                    "</div>" +
                "</div>");
            generatetable(List);
            generatepagebar();
            $("#right").append("<div id='update' ></div>");
            $("#right").append("<div id='messdialog' ></div>");
        }
    })
}

/**
 * @name generatepagebar
 * @author VEGLE
 * @description 生成页数条
 *
 * **/
function generatepagebar() {

    for(var i = 1;i<totalPage+1;i++){
        $("#next").before(
            "<li id="+i+" ><a  href='#' onclick=customPage("+i+")>"+i+"</a></li>"
        );

    }
    $("#"+currentPage).addClass("active");
}

            /**
             * @name generatetable
             * @author VEGLE
             * @description 生成用户列表的表格
             * @param List
             * **/
function generatetable(List){

    $("#view_box").html("<table  class=\"table table-responsive table-hover table-striped table-bordered table-condensed\" id=\"table_box\" width=\"30%\" style=\"text-align: center ;margin-bottom: 0px\">\n" +
        "            </table>");

    var table_head =
        "                   <tr  class=\"info\" >\n" +
        "                    <th>ID</th>\"" +
        "                    <th>用户名</th>" +
        "                    <th>真实姓名</th>" +
        "                    <th>性别</th>" +
        "                    <th>权限</th>\n" +
        "                    <th>年龄</th>" +
        "                    <th>注册日期</th>   " +
        "                    <th>操作</th>" +
        "                </tr>"

    var table_body;

    for (var i in List) {
        table_body +=
            "               <tr >" +
            "                    <td><label >" + List[i].id + "</label></td>\" " +
            "                    <td><label >" + List[i].username + "</label></td>" +
            "                    <td><label >" + List[i].realname + "</label></td>" +
            "                    <td><label >" + List[i].sex + "</label></td>\n" +
            "                    <td><label >" + List[i].permission + "</label></td>\n" +
            "                    <td><label >" + List[i].age + "</label></td>\n" +
            "                    <td><label >" + List[i].reg_date + "</label></td>" +
            "                    <td>" +
            "                        <a href='#' class='btn btn-primary' onclick=update_userinfo(" + i + ")>修改</a>" +
            "                        <a href='#' class='btn btn-danger' onclick=delete_user(" + i + ")>删除</a>" +
            "                        <a href='#' class='btn btn-warning' onclick=update_pwd(" + i + ")>修改密码</a>" +
            "                    </td>" +
            "                </tr>"
    }
    $("#table_box").html("<thead >" + table_head + "</thead>" + "<tbody>" + table_body + "</tbody>");

}


function toggle_blind(ID) {
    $("#"+ID).toggle("blind",500);
}

function customPage(tag) {
    $("#"+currentPage).removeClass("active");
    currentPage = tag;
    pageUtil("selectindex");
}

function pageUtil(flag){
    if(flag == "previous"){

        if((currentPage-1)<1){
            alert("前面没有更多的数据了哦");
            return 0;
        }else{
            $("#"+currentPage).removeClass("active");
            currentPage -=1;
        }

    }else if(flag == "next"){

        if((currentPage+1)>totalPage){
            alert("后面没有更多的数据了哦");
            return 0;
        }else{
            $("#"+currentPage).removeClass("active");
            currentPage +=1;
        }
    }else if (flag == "selectindex"){

    }

    $.ajax({
        method:"post",
        url: "/ViewUser?flag="+flag+"&currentPage="+currentPage,
        responseText:"json",
        success:function(data){
            var data2 = eval(data);
            List = data2[2];
            totalPage = data2[0];
            currentPage = data2[1];
            generatetable(List);
            $("#"+currentPage).addClass("active");
            console.log("执行ajax成功");
        }

    })
}


function update_userinfo(which){

        //修改用户信息函数

        $("#update").html(
            "<div  style='width: 600px;' >" +
            "<form action='##' id='update_user_form' method='post'>" +
            "   <div class=\"form-group\">\n" +
            "      <div class=\"input-group \">\n" +
            "           <span class=\"input-group-addon\" id=\"sizing-addon0\"><label for='sizing-addon0'>ID</label></span>\n" +
            "           <input type=\"text\" class=\"form-control\" id=\"id\" name=\"id\" value="+List[which].id+" aria-describedby=\"sizing-addon0\" readonly>\n" +
            "      </div>" +
            "    </div>" +
            "   <div class=\"form-group \">\n" +
            "       <div class=\"input-group\">\n" +
            "           <span class=\"input-group-addon fa fa-user\" id=\"sizing-addon1\"></span>\n" +
            "           <input type=\"text\" value="+List[which].username+" class=\"form-control\" id=\"username\" name=\"username\" placeholder=\"用户名\" aria-describedby=\"sizing-addon1\">\n" +
            "       </div>" +
            "   </div>" +
            "   <div class=\"form-group \">\n" +
            "       <div class=\"input-group\">\n" +
            "           <span class=\"input-group-addon \" id=\"sizing-addon2\"><label for='sizing-addon2'>Real</label></span>\n" +
            "           <input type=\"text\"  value='"+List[which].realname+"' class=\"form-control\" id=\"realname\" name=\"realname\" placeholder=\"真实姓名\" aria-describedby=\"sizing-addon2\">\n" +
            "       </div>" +
            "   </div>" +
            "   <div class=\"form-group \">\n" +
            "       <div class=\"input-group\">\n" +
            "            <span class=\"input-group-addon fa fa-lock\" id=\"sizing-addon3\"></span>\n" +
            "            <input type=\"text\" value="+List[which].sex+" class=\"form-control\" id=\"sex\" name=\"sex\" placeholder=\"性别\" aria-describedby=\"sizing-addon3\">\n" +
            "        </div>\n" +
            "    </div>" +
            "<div class=\"form-group\">\n" +
            "                <div class=\"input-group\">\n" +
            "                    <span class=\"input-group-addon\" id=\"sizing-addon4\"><label for=\"sizing-addon3\">age</label></span>\n" +
            "                    <input type=\"text\" class=\"form-control\" value="+List[which].age+" id=\"age\" name=\"age\" placeholder=\"年龄\" aria-describedby=\"sizing-addon4\">\n" +
            "                </div>\n" +
            "            </div>" +
            "</form>" +
            "</div>" );

    $("#update").dialog({
        title:"修改用户信息",
        resizable:false,
        modal:true,
        width:'auto',
        show:{effect:"fold",duration:500},
        close:{effect:"fold",duration:500},
        buttons:{
            "修改":function () {

                var flag = confirm("是否修改"+List[which].id+"用户的信息？");
                if(flag){
                $.ajax({
                    method:"post",
                    url:"/UpdateUser?tag=update_info",
                    data:$("#update_user_form").serialize(),
                    dataType:"text",
                    success:function (data) {
                        customPage(currentPage);

                        $("#messdialog").html(data);
                        $("#messdialog").dialog({
                            buttons:{
                                "确定":function () {

                                    $(this).dialog("close");

                                }
                            }
                        });

                    }
                })

                }
            }
        }
    });


}
function delete_user(which) {
    var userid = List[which].id
    var flag = confirm("是否删除用户:"+userid);
    if(flag){
        $.ajax({
            type:"post",
            url:"/DropData",
            dataType:"text",
            data:{userid :userid},
            success:function (data) {
                var messbox = $("#messdialog");
                messbox.html(data);
                messbox.dialog({
                    buttons:{
                        "确定":function () {
                            $(this).dialog("close");
                            show_user();
                        }
                    }

                })
            }

        })
    }
}
function update_pwd(which) {
        var userid = List[which].id;

        $("#update").html(
            "<div style='width: 600px'>"+
            "<form action='##' id='update_user_pwd_form' method='post'>" +
            "   <div class=\"form-group\">\n" +
            "      <div class=\"input-group \">\n" +
            "           <span class=\"input-group-addon\" id=\"sizing-addon0\"><i class=\"fa fa-user\"></i></span>\n" +
            "           <input type=\"text\" class=\"form-control\" id=\"id\" name=\"id\"  value='"+userid+"' aria-describedby=\"sizing-addon0\" readonly>\n" +
            "      </div>" +
            "    </div>" +
            "   <div class=\"form-group \">\n" +
            "       <div class=\"input-group\">\n" +
            "           <span class=\"input-group-addon\" id=\"sizing-addon1\"><label for=\"sizing-addon2\">P</label></span>\n" +
            "           <input type=\"text\" class=\"form-control\" id=\"pwd\" name=\"pwd\" value=\"密码(必填)\" aria-describedby=\"sizing-addon1\">\n" +
            "       </div>" +
            "   </div>" +
            "</form>"+
            "</div>" );
    $("#update").dialog({
        title:"修改用户密码",
        resizable:false,
        modal:true,
        width:'auto',
        show:{effect:"fold",duration:500},
        buttons:{
            "提交":function () {
                var flag = confirm("是否修改用户:"+userid+"的密码?");
                if(flag){
                $.ajax({
                    type:"post",
                    url:"/UpdateUser?tag=update_pwd",
                    data:$("#update_user_pwd_form").serialize(),
                    dataType:"text",
                    success:function (data) {
                        var messbox = $("#messdialog");
                        messbox.html(data);
                        messbox.dialog({
                            buttons:{
                                "确定":function () {
                                    $(this).dialog("close");
                                    show_user();
                                }
                            }

                        })
                    }

                })
            }
            }
        }
    });


}