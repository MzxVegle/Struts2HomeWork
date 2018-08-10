package com.Vegle.Action;

import com.Vegle.Modle.User;
import com.Vegle.Util.Log;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @program: Struts2实训项目
 * @description: 注销用户Action
 * @author: VEGLE
 * @time: 2018-06-22
 **/
public class ReleaseAction {
    public void releaseUser() throws IOException {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        HttpSession session = request.getSession(false);
        if(session == null ) {
            new Log().danger("这个用户已经过期！");
            response.sendRedirect("CMSlogin.jsp");
        }else{

            User user = (User) session.getAttribute("user");
            new Log().info("注销用户名为：" + user.getId());
            session.removeAttribute("user");
            session =null;
            response.sendRedirect("CMSlogin.jsp");
        }

    }
}
