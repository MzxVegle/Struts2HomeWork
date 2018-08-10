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
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

/**
 * @program: Struts2实训项目
 * @description: 增加用户的Action
 * @author: VEGLE
 * @time: 2018-06-22
 **/
public class AddAction extends ActionSupport {
    public void insert() throws IOException {

        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        request.setCharacterEncoding("utf-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        PrintWriter pw = response.getWriter();
        User user = new User();
        user.setId(request.getParameter("id"));
        user.setUsername(request.getParameter("usname"));
        user.setPwd(request.getParameter("pwd"));
        user.setPermission(request.getParameter("permission"));
        user.setSex(request.getParameter("sex"));
        user.setAge(Integer.parseInt(request.getParameter("age")));
        user.setRealname(request.getParameter("realname"));
        Connection con = new DBconnector().getConnnection();
        try {
            String sql="{CALL reg_user(?,?,?,?,?,?,?,?)}";
            CallableStatement call = con.prepareCall(sql);
            call.setObject(1,user.getId());
            call.setObject(2,user.getPwd());
            call.setObject(3,user.getPermission());
            call.setObject(4,user.getUsername());
            call.setObject(5,user.getRealname());
            call.setObject(6,user.getSex());
            call.setObject(7,user.getAge());
            call.registerOutParameter(8,Types.VARCHAR);
            call.execute();
            System.out.println(user.getSex());
            Object mess = call.getObject(8);
            new DBconnector().releaseResource(con,call);
            pw.print(mess);
        } catch (SQLException e) {
            e.printStackTrace();
            new Log().info("注册用户失败！原因:"+e.getMessage());
            pw.print("注册用户失败！原因:"+e.getMessage());

        }
        pw.flush();
        pw.close();
    }
}
