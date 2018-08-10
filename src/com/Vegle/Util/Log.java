package com.Vegle.Util;

import java.util.Date;

public class Log {

    public void info(String mess){
        System.out.println("-------------------------------------------------");
        System.out.println("info    "+mess+"    "+new Date());
        System.out.println("-------------------------------------------------");

    }
    public void danger(String mess){
        System.out.println("danger:"+mess);
    }
}

