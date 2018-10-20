package com.mypro.dao;

import com.mypro.domain.BrandIndex;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BrandIndexDao {

    List<BrandIndex> findByFiled(String filed);

    BrandIndex findByFiledAndId(@Param("filed") String filed,@Param("id") Integer id);

    Boolean insertBrandIndex(BrandIndex brandIndex);

    Boolean updateBrandIndex(BrandIndex brandIndex);
}
