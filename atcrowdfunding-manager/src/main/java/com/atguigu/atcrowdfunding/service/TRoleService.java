package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TRole;

import java.util.List;

public interface TRoleService {
    List<TRole> getTRolesByKeyWord(String keyWord);

    int saveRole(TRole tRole);

    TRole getTRoleById(Integer id);

    int updateTRole(TRole tRole);

    int deleteBatchByIds(List<Integer> idsInt);
}
