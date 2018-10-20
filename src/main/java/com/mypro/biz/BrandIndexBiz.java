package com.mypro.biz;

import com.mypro.domain.BrandIndex;

import java.util.List;

public interface BrandIndexBiz {

    List<BrandIndex> findByFiled(String filed);

    BrandIndex findByFiledAndId(String filed,Integer id);

    Boolean insertBrandIndex(BrandIndex brandIndex);

    Boolean updateBrandIndex(BrandIndex brandIndex);
}
