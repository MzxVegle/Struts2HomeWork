package com.Vegle.Service;

import com.Vegle.Modle.User;

import java.util.List;


public class Pagination {

    int currentPageNo = 1;/*      当前页面*/

    int totalPage;/*              总页面*/

    int totalRecord;/*          总记录数*/


    int pageSize ;/*            每页记录数*/

    int fromindex ;

    int toindex ;
    List<User> obj;

    public Pagination(){

    }
    public  Pagination(int No,int pageSize,List<User> obj){
        System.out.println(pageSize);
        this.currentPageNo = No;
        this.pageSize = pageSize;
        this.obj = obj;
        totalRecord = obj.size();
        totalPage = totalRecord/pageSize;

        if((totalRecord % pageSize) > 0){
            totalPage += 1;
        }

        fromindex = (currentPageNo-1)*pageSize;

        toindex = (currentPageNo)*pageSize;

        if(toindex>totalRecord){
            toindex = totalRecord;
        }

    }
    public List<User> disapart(){
        List<User> disapartList = obj;

        System.out.println("总页面："+totalPage+"页,当前页面："+currentPageNo+"页,每页显示数据："+(toindex-fromindex)+"条,数据总量:"+totalRecord+"条");

        return disapartList.subList(fromindex,toindex);
    }
    public int getCurrentPageNo() {
        return currentPageNo;
    }

    public int getTotalPage() {
        return totalPage;
    }

}
