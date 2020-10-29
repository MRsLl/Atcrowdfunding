package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.service.TAdminService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.DateUtil;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.atguigu.atcrowdfunding.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.scrypt.SCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TAdminServiceImpl implements TAdminService {

    @Autowired
    private TAdminMapper tAdminMapper;

    public TAdmin getTAdmin(TAdmin tAdmin) {
//        根据tAdmin 对象的登录用户名和密码查询用户
        TAdminExample tAdminExample = new TAdminExample();

        TAdminExample.Criteria criteria = tAdminExample.createCriteria();

        criteria.andLoginacctEqualTo(tAdmin.getLoginacct());

        criteria.andUserpswdEqualTo(MD5Util.digest(tAdmin.getUserpswd()));

        List<TAdmin> tAdmins = tAdminMapper.selectByExample(tAdminExample);


        if (tAdmins == null || tAdmins.size() == 0) {
            throw new RuntimeException("用户名或密码错误");
        }
        return tAdmins.get(0);
    }

    /**
     * 通过条件模糊查询管理员用户
     * @return
     */
    @Override
    public List<TAdmin> getTAdminsByKeyWord(String keyWord) {
        TAdminExample tAdminExample = new TAdminExample();
        if (StringUtil.isNotEmpty(keyWord)) {
            TAdminExample.Criteria criteria1 = tAdminExample.createCriteria();
            criteria1.andLoginacctLike("%" + keyWord + "%");

            TAdminExample.Criteria criteria2 = tAdminExample.createCriteria();
            criteria2.andUsernameLike("%" + keyWord + "%");

            TAdminExample.Criteria criteria3 = tAdminExample.createCriteria();
            criteria3.andEmailLike("%" + keyWord + "%");

            tAdminExample.or(criteria2);
            tAdminExample.or(criteria3);
        }
        List<TAdmin> tAdmins = tAdminMapper.selectByExample(tAdminExample);

        return tAdmins;
    }

    /**
     * 保存管理员到数据库
     * @param tAdmin
     */
    @Override
    public void saveTAdmin(TAdmin tAdmin) {
        //设置将保存用户的默认密码和创建时间
        tAdmin.setUserpswd(new BCryptPasswordEncoder().encode(Const.DEFALUT_PASSWORD));
        tAdmin.setCreatetime(DateUtil.getFormatTime());

        tAdminMapper.insertSelective(tAdmin);
    }

    /**
     * 根据id 查询管理员
     * @param id
     * @return
     */
    @Override
    public TAdmin getTAdminById(Integer id) {
        TAdmin tAdmin = tAdminMapper.selectByPrimaryKey(id);
        return tAdmin;
    }

    /**
     * 更新管理员数据
     * @param tAdmin
     */
    @Override
    public void updateTAdmin(TAdmin tAdmin) {
        tAdminMapper.updateByPrimaryKeySelective(tAdmin);
    }

    /**
     * 根据id 删除管理员
     * @param id
     */
    @Override
    public void deleteTAdmin(Integer id) {
        tAdminMapper.deleteByPrimaryKey(id);
    }

    /**
     * 根据id 批量删除管理员
     * @param idInts
     */
    @Override
    public void deleteTAdminBatch(List<Integer> idInts) {
        TAdminExample example = new TAdminExample();
        TAdminExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(idInts);

        tAdminMapper.deleteByExample(example);
    }


}
