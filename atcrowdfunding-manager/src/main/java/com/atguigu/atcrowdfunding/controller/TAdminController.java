package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.service.TAdminService;
import com.atguigu.atcrowdfunding.service.TMenuService;
import com.atguigu.atcrowdfunding.service.impl.TAdminServiceImpl;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TAdminController {
    @Autowired
    private TAdminService tAdminService;
    @Autowired
    private TMenuService tMenuService;

    @RequestMapping(value = "/main")
    public String main(HttpSession session) {
        List<TMenu> tMenus = tMenuService.listAllMenus();
        session.setAttribute("tMenus",tMenus);
        return "main";
    }

/*    @RequestMapping("/login")
    public String login(TAdmin tAdmin, HttpSession session) {
        try {
            TAdmin tAdmin1 = tAdminService.getTAdmin(tAdmin);
            session.setAttribute("loginAdmin",tAdmin1);
        } catch (Exception e) {
            session.setAttribute("errMessage", e.getMessage());
            return "redirect:/welcome.jsp";
        }
        return "redirect:/main";
    }*/

/*    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:welcome.jsp";
    }*/

    /**
     *
     * @param pageNum   当前页码
     * @param pageSize  每页数据的行数
     * @param keyWord   模糊查询条件
     * @param model     视图
     * @return
     */
    @RequestMapping("/admin/index")
    public String index(
            @RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize",required = false,defaultValue = "2") Integer pageSize,
            @RequestParam(value = "keyWord",required = false,defaultValue = "") String keyWord,
            Model model
    ) {
        //分页插件
        PageHelper.startPage(pageNum,pageSize);//limit ?,?
        List<TAdmin> tAdminsByKeyWord = tAdminService.getTAdminsByKeyWord(keyWord);//select * from t_admin where loginacct like %?% or username like %?% or email like %?%;

        PageInfo pageInfo = new PageInfo(tAdminsByKeyWord,5);

        model.addAttribute("pageInfo",pageInfo);

        return "/admin/index";
    }

//    跳转到新增用户页面
    @PreAuthorize("hasRole('学徒')")
    @RequestMapping("/admin/toAdd")
    public String toAdd() {
        return "admin/add";
    }

    /**
     * 增加管理员账户并重定向到index 方法
     * @param tAdmin
     * @return
     */
    @RequestMapping("/admin/add")
    public String add(TAdmin tAdmin) {
        tAdminService.saveTAdmin(tAdmin);

        return "redirect:/admin/index?pageNum=" + Integer.MAX_VALUE;
    }

    /**
     * 根据id 查询管理员用户并将数据回显，跳转到edit.jsp
     * @param id
     * @param map
     * @return
     */
    @PreAuthorize("hasRole('学徒')")
    @RequestMapping("/admin/toEdit")
    public String toEdit(Integer id,Map<String,Object> map) {
        TAdmin tAdminById = tAdminService.getTAdminById(id);
        map.put("tAdminById",tAdminById);
        return "admin/edit";
    }

    /**
     * 修改管理员数据
     * @param tAdmin
     * @param pageNum
     * @return
     */
    @RequestMapping("/admin/edit")
    public String edit(TAdmin tAdmin,Integer pageNum) {
        tAdminService.updateTAdmin(tAdmin);

        return "redirect:/admin/index?pageNum=" + pageNum;
    }

    /**
     * 根据id 删除管理员
     * @param id
     * @return
     */
    @RequestMapping("/admin/delete")
    public String delete(Integer id) {
        tAdminService.deleteTAdmin(id);
        return "redirect:/admin/index";
    }

    /**
     * 根据ids 批量删除管理员
     * @param ids
     * @return
     */
    @RequestMapping("/admin/deleteBatch")
    public String deleteBatch(String ids) {
        String[] idStrs = ids.split(",");
        List<Integer> idInts = new ArrayList<>();
        for (String idStr : idStrs) {
            Integer id = Integer.parseInt(idStr);
            idInts.add(id);
        }
        tAdminService.deleteTAdminBatch(idInts);
        return "redirect:/admin/index";
    }
}
