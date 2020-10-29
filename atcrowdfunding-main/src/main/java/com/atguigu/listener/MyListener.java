package com.atguigu.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class MyListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        //获取ServletContext 对象
        ServletContext servletContext = servletContextEvent.getServletContext();
        //获取工程地址
        String appPath = servletContext.getContextPath();
        //将工程地址存入servletContext 域中
        servletContext.setAttribute("appPath",appPath);
        System.out.println(appPath);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
