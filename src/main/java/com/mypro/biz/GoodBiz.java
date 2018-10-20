package com.mypro.biz;

import com.mypro.domain.Good;

import java.util.List;

public interface GoodBiz {

    Good findById(Integer id);

    List<Good> findByName(String goodName);

    List<Good> findAll();
}
