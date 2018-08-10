package com.Vegle.Action;

import com.Vegle.Modle.User;
import com.Vegle.Service.DBconnector;
import com.Vegle.Service.Pagination;
import com.Vegle.Util.Log;
import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.JSONArray;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @program: Struts2实训项目
 * @description: 查看用户Action
 * @author: VEGLE
 * @time: 2018-06-21
 **/
public class ViewAction extends ActionSupport {
    public void viewDefault() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        PrintWriter printWriter = response.getWriter();
        String flag  = request.getParameter("flag");
        System.out.println(flag);
        new Log().info("开始读取用户信息数据");
        DBconnector dbcon = new DBconnector();
        Connection con = dbcon.getConnnection();
        PreparedStatement preparedStatement = null;

        ResultSet rs = null;
        String sql = "select * from `User` JOIN UserInfo ON UserInfo.ID = `User`.id";
        try {
            preparedStatement = con.prepareStatement(sql);
            rs = preparedStatement.executeQuery();
            List<User> userList = new ArrayList<User>();
            while(rs.next()){
                //新建用户类实例
                User user = new User();
                //填充用户信息
                user.setId(rs.getString("id"));
                user.setUsername(rs.getString("username"));
                user.setPermission(rs.getString("permission"));
                user.setSex(rs.getString("sex"));
                user.setAge(rs.getInt("age"));
                user.setRealname(rs.getString("realname"));
                user.setReg_date(rs.getString("reg_time"));
                //          将用户添加到userList中
                userList.add(user);
            }
            JSONArray array = new JSONArray();
            if(flag.equals("default")){
                System.out.println("默认页");
                array = defaultPage(userList);
            }else if(flag.equals("previous")){
                int currentPage = Integer.parseInt(request.getParameter("currentPage"));
                array = movePage(currentPage,userList);
                new Log().info("上一页");

            }else if(flag.equals("next")){
                int currentPage = Integer.parseInt(request.getParameter("currentPage"));
                array = movePage(currentPage,userList);
                new Log().info("下一页");
            }else if(flag.equals("selectindex")){
                int currentPage = Integer.parseInt(request.getParameter("currentPage"));
                array = customPage(currentPage,userList);
                new Log().info("自定义跳转页:"+currentPage);
            }


            printWriter.print(array);/*                                      输出到前台的ajax      */
            printWriter.flush();
            printWriter.close();
            dbcon.releaseResource(con,preparedStatement,rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

        JSONArray movePage(int pageindex, List<User> listuser){

        Pagination pgt = new Pagination(pageindex,3,listuser);
        int totalPage = pgt.getTotalPage();
        int currentPageNo = pgt.getCurrentPageNo();

        List<User> list = pgt.disapart();
        Object[] obj = {totalPage,currentPageNo,list};
        JSONArray json = JSONArray.fromObject(obj);/*              将用户list转换为json对象*/
        return json;
    }

    JSONArray defaultPage(List<User> listuser){
        Pagination pgt = new Pagination(1,3,listuser);
        int totalPage = pgt.getTotalPage();
        int currentPageNo = pgt.getCurrentPageNo();

        List<User> list = pgt.disapart();
        Object[] obj = {totalPage,currentPageNo,list};
        JSONArray json = JSONArray.fromObject(obj);/*              将用户list转换为json对象*/
        return json;

    }

    JSONArray customPage(int pageindex,List<User> listuser){
        Pagination pgt = new Pagination(pageindex,3,listuser);
        int totalPage = pgt.getTotalPage();
        int currentPageNo = pgt.getCurrentPageNo();

        List<User> list = pgt.disapart();
        Object[] obj = {totalPage,currentPageNo,list};
        JSONArray json = JSONArray.fromObject(obj);/*              将用户list转换为json对象*/
        return json;
    }

}
