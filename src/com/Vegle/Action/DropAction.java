package com.Vegle.Action;

import com.Vegle.Service.DBconnector;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

/**
 * @program: Struts2实训项目
 * @description: 删除用户的Action
 * @author: VEGLE
 * @time: 2018-06-22
 **/
public class DropAction extends ActionSupport {
    public void dropUser() throws IOException {
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setCharacterEncoding("utf-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        String userid = request.getParameter("userid");
        DBconnector dBconnector = new DBconnector();
        Connection con = dBconnector.getConnnection();
        try {

            CallableStatement cst = con.prepareCall("{CALL delete_data(?,?)}");
            cst.setObject(1,userid);
            cst.registerOutParameter(2, Types.VARCHAR);
            cst.execute();
            Object mess = cst.getObject(2);
            PrintWriter pw = response.getWriter();
            System.out.println(mess);
            pw.println(mess);
            pw.flush();
            pw.close();
            dBconnector.releaseResource(con,cst);


        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
