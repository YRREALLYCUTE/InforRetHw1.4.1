package com.mypro.biz.impl;

import com.mypro.biz.ReviewIndexBiz;
import com.mypro.dao.ReviewIndexDao;
import com.mypro.domain.ReviewIndex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@SuppressWarnings("serial")
@Service
public class ReviewIndexImpl implements ReviewIndexBiz {

    private final ReviewIndexDao reviewIndexDao;

    @Autowired
    public ReviewIndexImpl(ReviewIndexDao reviewIndexDao) {
        this.reviewIndexDao = reviewIndexDao;
    }

    public List<ReviewIndex> findByFiled(String filed) {
        return reviewIndexDao.findByFiled(filed);
    }

    public ReviewIndex findByFiledAndId(String filed, Integer id) {
        return reviewIndexDao.findByFiledAndId(filed,id);
    }

    public Boolean insertReviewIndex(ReviewIndex reviewIndex) {
        return reviewIndexDao.insertReviewIndex(reviewIndex);
    }

    public Boolean updateReviewIndex(ReviewIndex reviewIndex) {
        return reviewIndexDao.updateReviewIndex(reviewIndex);
    }
}
