package com.Vegle.Action;

import com.Vegle.Modle.User;
import com.Vegle.Service.DBconnector;
import com.Vegle.Util.Log;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

/**
 * @program: Struts2实训项目
 * @description: 更新用户的Action
 * @author: VEGLE
 * @time: 2018-06-22
 **/
public class UpdateAction extends ActionSupport {
    public void updateUser() throws IOException, SQLException {
        System.out.println("执行！");
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        String tag = request.getParameter("tag");
        System.out.println(tag);
        request.setCharacterEncoding("utf-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        PrintWriter pw = response.getWriter();


        Connection con = new DBconnector().getConnnection();
        Boolean flag = false;
        if(tag.equals("update_info")){
            User user = new User();
            user.setId(request.getParameter("id"));
            user.setUsername(request.getParameter("username"));
            user.setPwd(request.getParameter("pwd"));
            user.setAge(Integer.parseInt(request.getParameter("age")));
            user.setRealname(request.getParameter("realname"));
            user.setSex(request.getParameter("sex"));
            update_info(user,con,pw);
        }
        else if(tag.equals("update_pwd")){
            update_pwd(con,pw,request);
        }
    }
    void update_info(User user,Connection con,PrintWriter pw){
        boolean flag = false;
        new Log().info("执行信息更新");
        String sql="{CALL update_user_info(?,?,?,?,?,?)}";
        System.out.println(user.getId());
        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setObject(1,user.getId());
            cs.setObject(2,user.getUsername());
            cs.setObject(3,user.getRealname());
            cs.setObject(4,user.getSex());
            cs.setObject(5,user.getAge());
            cs.registerOutParameter(6, Types.VARCHAR);
            cs.execute();
            Object mess = cs.getObject(6);
            new Log().info(mess.toString());
            new DBconnector().releaseResource(con,cs);
            pw.print(mess);
            pw.flush();
            pw.close();
            new DBconnector().releaseResource(con,cs);
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

    void update_pwd(Connection con,PrintWriter pw,HttpServletRequest request) throws SQLException {
        boolean flag = false;
        new Log().info("执行密码更新");
        String sql = "{CALL update_user_pwd(?,?,?)}";
        CallableStatement cs = con.prepareCall(sql);
        cs.setObject(1,request.getParameter("id"));
        cs.setObject(2,request.getParameter("pwd"));
        cs.registerOutParameter(3, Types.VARCHAR);
        cs.execute();
        Object mess = cs.getObject(3);
        pw.append(mess.toString());
        pw.flush();
        pw.close();

    }
}
