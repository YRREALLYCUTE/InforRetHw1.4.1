package com.mypro.dao;

import com.mypro.domain.Good;

import java.util.List;

public interface GoodDao {

    Good findById(Integer id);
    List<Good> findByName(String goodName);
    List<Good> findAll();

}
