package com.mypro.biz.impl;

import com.mypro.biz.BrandIndexBiz;
import com.mypro.dao.BrandIndexDao;
import com.mypro.domain.BrandIndex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@SuppressWarnings("serial")
@Service
public class BrandIndexImpl implements BrandIndexBiz {

    private final
    BrandIndexDao brandIndexDao;

    @Autowired
    public BrandIndexImpl(BrandIndexDao brandIndexDao) {
        this.brandIndexDao = brandIndexDao;
    }

    public List<BrandIndex> findByFiled(String filed) {
        return brandIndexDao.findByFiled(filed);
    }

    public BrandIndex findByFiledAndId(String filed, Integer id) {
        return brandIndexDao.findByFiledAndId(filed,id);
    }

    public Boolean insertBrandIndex(BrandIndex brandIndex) {
        return brandIndexDao.insertBrandIndex(brandIndex);
    }

    public Boolean updateBrandIndex(BrandIndex brandIndex) {
        return brandIndexDao.updateBrandIndex(brandIndex);
    }
}
