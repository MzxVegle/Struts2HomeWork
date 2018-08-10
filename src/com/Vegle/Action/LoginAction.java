package com.Vegle.Action;

import com.Vegle.Modle.User;
import com.Vegle.Service.DBconnector;
import com.opensymphony.xwork2.ActionSupport;

import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @program: Struts2实训项目
 * @description: 登陆的Action路由
 * @author: VEGLE
 * @time: 2018-06-21
 **/
public class LoginAction extends ActionSupport {
    public void login(){
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        String id,pwd;
        PreparedStatement ps;
        ResultSet rs;
        id = request.getParameter("usname");
        pwd=request.getParameter("pwd");
        System.out.println(id+" "+pwd);
        Connection con = new DBconnector().getConnnection();
        String sql = "SELECT * FROM user join userinfo on `user`.id=userinfo.id WHERE `user`.id=? and `user`.password=?";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1,id);
            ps.setString(2,pwd);
            rs = ps.executeQuery();
            if(rs.next()){
                User user = new User();
                user.setAge(rs.getInt("age"));
                user.setId(rs.getString("id"));
                user.setRealname(rs.getString("realname"));
                user.setSex(rs.getString("sex"));
                user.setUsername(rs.getString("username"));
                user.setPermission(rs.getString("permission"));
                user.setPwd(rs.getString("password"));
                user.setReg_date(rs.getString("reg_time"));
                HttpSession session = request.getSession();
                session.setAttribute("user",user);
                System.out.println(user.getPermission());
                if (user.getPermission().equals("admin")) {

                    response.sendRedirect("MyWebCMS.jsp");
                }else{
                    response.sendRedirect("MyWebCMS.jsp");
                }

            }else{

                response.setStatus(500);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
