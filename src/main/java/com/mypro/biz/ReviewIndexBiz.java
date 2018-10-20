package com.mypro.biz;

import com.mypro.domain.ReviewIndex;

import java.util.List;

public interface ReviewIndexBiz {

    List<ReviewIndex> findByFiled(String filed);

    ReviewIndex findByFiledAndId(String filed, Integer id);

    Boolean insertReviewIndex(ReviewIndex reviewIndex);

    Boolean updateReviewIndex(ReviewIndex reviewIndex);

}
