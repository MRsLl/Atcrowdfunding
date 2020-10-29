package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.mapper.TMenuMapper;
import com.atguigu.atcrowdfunding.service.TMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TMenuServiceImpl implements TMenuService {
    @Autowired
    private TMenuMapper tMenuMapper;

    @Override
    public List<TMenu> listAllMenus() {
        //1.无条件查询所有菜单
        List<TMenu> tMenus = tMenuMapper.selectByExample(null);
        //2.声明父菜单列表
        List<TMenu> parentMenus = new ArrayList<>();
        //3.声明一个 map，保存父菜单的id和对象以方便操作
        Map<Integer,TMenu> cache = new HashMap<>();
        //4.循环遍历所有菜单，将父菜单加入父菜单列表
        for (TMenu tMenu : tMenus) {
            if (tMenu.getPid() == 0) {
                parentMenus.add(tMenu);
                cache.put(tMenu.getId(),tMenu);
            }
        }
        //5.循环遍历所有菜单，将子菜单添加到相应的父菜单对象的childMenus 中
        for (TMenu tMenu : tMenus) {
            if (tMenu.getPid() != 0) {
                TMenu parentMenu = cache.get(tMenu.getPid());
                parentMenu.getChildMenus().add(tMenu);
            }
        }
        return parentMenus;

    }
}
