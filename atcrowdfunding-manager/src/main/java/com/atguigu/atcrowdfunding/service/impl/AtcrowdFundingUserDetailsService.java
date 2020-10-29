package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.mapper.TPermissionMapper;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;
import com.atguigu.atcrowdfunding.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class AtcrowdFundingUserDetailsService implements UserDetailsService {
    @Autowired
    private TAdminMapper tAdminMapper;
    @Autowired
    private TRoleMapper tRoleMapper;
    @Autowired
    private TPermissionMapper tPermissionMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //根据id 查询管理员用户
        TAdminExample tAdminExample = new TAdminExample();
        TAdminExample.Criteria criteria = tAdminExample.createCriteria();
        criteria.andLoginacctEqualTo(username);

        List<TAdmin> tAdmins = tAdminMapper.selectByExample(tAdminExample);
        TAdmin tAdmin = tAdmins.get(0);

        //根据管理员id 查询所拥有的角色
        List<TRole> tRoles = tRoleMapper.listRolesByTAdminId(tAdmin.getId());
        //根据管理员id 查询所拥有的权限
        List<TPermission> tPermissions = tPermissionMapper.listPermissionsByTAdminId(tAdmin.getId());
        //角色和权限集合
        Set<GrantedAuthority> authorities = new HashSet<>();

        //遍历查到的角色和权限，并加入同一个Set 集合
        for (TRole tRole : tRoles) {
            authorities.add(new SimpleGrantedAuthority("ROLE_" + tRole.getName()));
        }

        for (TPermission tPermission : tPermissions) {
            if (StringUtil.isNotEmpty(tPermission.getName())) {
                authorities.add(new SimpleGrantedAuthority(tPermission.getName()));
            }
        }

        return new User(tAdmin.getLoginacct(),tAdmin.getUserpswd(),authorities);
    }
}
