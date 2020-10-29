package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.TRoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
public class TRoleController {
    @Autowired
    private TRoleService tRoleService;

    @RequestMapping("/role/index")
    public String index() {
        return "role/index";
    }

    /**
     * 根据条件查询并回传角色数据和分页数据
     * @return
     */
    @PreAuthorize("hasAuthority('role')")
    @ResponseBody
    @RequestMapping("/role/loadData")
    public PageInfo<TRole> loadData(
            @RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize",required = false,defaultValue = "2") Integer pageSize,
            @RequestParam(value = "keyWord",required = false,defaultValue = "") String keyWord
    ) {
        PageHelper.startPage(pageNum,pageSize);

        List<TRole> tRolesByKeyWord = tRoleService.getTRolesByKeyWord(keyWord);

        PageInfo<TRole> pageInfo = new PageInfo<>(tRolesByKeyWord,5);

        return pageInfo;
    }


    /**
     * 添加角色数据
     * @param tRole
     * @return
     */
    @ResponseBody
    @RequestMapping("/role/add")
    public String add(TRole tRole) {
        int row = tRoleService.saveRole(tRole);
        if (row == 1) {
            return "yes";
        } else {
            return "no";
        }
    }

    /**
     * 根据id 获取角色
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/role/getRoleById")
    public TRole getTRoleById(Integer id){
        TRole tRoleById = tRoleService.getTRoleById(id);
        return tRoleById;
    }

    /**
     * 修改角色
     * @param tRole
     * @return
     */
    @ResponseBody
    @RequestMapping("/role/update")
    public String update(TRole tRole) {
        int row = tRoleService.updateTRole(tRole);
        if (row == 1) {
            return "yes";
        } else {
            return "no";
        }
    }

    /**
     * 批量删除角色
     * @param idStr
     * @return
     */
    @ResponseBody
    @RequestMapping("/role/deleteBatch")
    public String deleteBatch(String idStr) {
        String[] ids = idStr.split(",");
        List<Integer> idsInt = new ArrayList<>();

        for (String id : ids) {
            int idInt = Integer.parseInt(id);
            idsInt.add(idInt);
        }

        int row = tRoleService.deleteBatchByIds(idsInt);

        if (row > 0) {
            return "yes";
        } else {
          return "no";
        }
    }

}
