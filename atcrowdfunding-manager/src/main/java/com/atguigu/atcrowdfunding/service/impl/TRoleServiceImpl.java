package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.bean.TRoleExample;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;
import com.atguigu.atcrowdfunding.service.TRoleService;
import com.atguigu.atcrowdfunding.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TRoleServiceImpl implements TRoleService {
    @Autowired
    private TRoleMapper tRoleMapper;

    /**
     * 根据条件模糊查询角色数据
     * @param keyWord
     * @return
     */
    @Override
    public List<TRole> getTRolesByKeyWord(String keyWord) {
        TRoleExample example = new TRoleExample();
        if (StringUtil.isNotEmpty(keyWord)) {
            TRoleExample.Criteria criteria = example.createCriteria();
            criteria.andNameLike("%" + keyWord + "%");
        }

        List<TRole> tRoles = tRoleMapper.selectByExample(example);

        return tRoles;
    }

    /**
     * 根据角色名添加角色
     * @param tRole
     * @return
     */
    @Override
    public int saveRole(TRole tRole) {
        int row = tRoleMapper.insertSelective(tRole);
        return row;
    }

    /**
     * 根据id 获取角色
     * @param id
     * @return
     */
    @Override
    public TRole getTRoleById(Integer id) {
        TRole tRole = tRoleMapper.selectByPrimaryKey(id);
        return tRole;
    }

    /**
     * 修改角色
     * @param tRole
     * @return
     */
    @Override
    public int updateTRole(TRole tRole) {
        return tRoleMapper.updateByPrimaryKeySelective(tRole);
    }

    /**
     * 根据id 值批量删除角色数据
     * @param idsInt
     * @return
     */
    @Override
    public int deleteBatchByIds(List<Integer> idsInt) {
        TRoleExample example = new TRoleExample();
        TRoleExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(idsInt);

        int row = tRoleMapper.deleteByExample(example);
        return row;
    }
}
