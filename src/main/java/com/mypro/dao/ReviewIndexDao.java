package com.mypro.dao;

import com.mypro.domain.ReviewIndex;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReviewIndexDao {

    List<ReviewIndex> findByFiled(String filed);

    ReviewIndex findByFiledAndId(@Param("filed") String filed, @Param("id") Integer id);

    Boolean insertReviewIndex(ReviewIndex reviewIndex);

    Boolean updateReviewIndex(ReviewIndex reviewIndex);

}
