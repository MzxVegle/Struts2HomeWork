package com.Vegle.Service;

import java.sql.*;

public class DBconnector {
    static String url = "jdbc:mysql://localhost:3306/mydatabase?useSSL=false";
    static Connection con = null;
    static String usname = "root";
    static String pwd = "root";
   public static Connection getConnnection(){
        try {
            //  加载驱动
            Class.forName("com.mysql.jdbc.Driver");
            //  获取con，连接数据库
            con = DriverManager.getConnection(url,usname,pwd);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //  返回连接的con
        return con;
    }

    public void releaseResource(Connection con, PreparedStatement preparedStatement, ResultSet rs) throws SQLException {
        /*
            如果rs存在（！=null）的情况就清除rs
            同理con和preparedStatement也是一样

         */
       if (rs!=null){
            rs.close();
        }
        if(preparedStatement!=null){
            preparedStatement.close();
        }
        if(con!=null){
            con.close();
        }
    }
    public void releaseResource(Connection con, CallableStatement callableStatement, ResultSet rs) throws SQLException {
        if (rs!=null){
            rs.close();
        }
        if(callableStatement!=null){
            callableStatement.close();
        }
        if(con!=null){
            con.close();
        }
    }
    public void releaseResource(Connection con, CallableStatement callableStatement) throws SQLException {

        if(callableStatement!=null){
            callableStatement.close();
        }
        if(con!=null){
            con.close();
        }
    }
    public void releaseResource(Connection con, PreparedStatement preparedStatement) throws SQLException {

        if(preparedStatement!=null){
            preparedStatement.close();
        }
        if(con!=null){
            con.close();
        }
    }
}
