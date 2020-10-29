package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TAdmin;

import java.util.List;

public interface TAdminService {

    TAdmin getTAdmin(TAdmin tAdmin);


    List<TAdmin> getTAdminsByKeyWord(String keyWord);

    void saveTAdmin(TAdmin tAdmin);

    TAdmin getTAdminById(Integer id);

    void updateTAdmin(TAdmin tAdmin);

    void deleteTAdmin(Integer id);

    void deleteTAdminBatch(List<Integer> idInts);
}
