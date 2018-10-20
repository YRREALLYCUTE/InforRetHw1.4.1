package com.mypro.biz.impl;

import com.mypro.biz.GoodBiz;
import com.mypro.dao.GoodDao;
import com.mypro.domain.Good;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@SuppressWarnings("serial")
@Service
public class GoodBizImpl implements GoodBiz {

    private final
    GoodDao goodDao;

    @Autowired
    public GoodBizImpl(GoodDao goodDao) {
        this.goodDao = goodDao;
    }


    public Good findById(Integer id) {
        return goodDao.findById(id);
    }

    public List<Good> findByName(String goodName) {
        return goodDao.findByName(goodName);
    }

    public List<Good> findAll() {
        return goodDao.findAll();
    }
}
