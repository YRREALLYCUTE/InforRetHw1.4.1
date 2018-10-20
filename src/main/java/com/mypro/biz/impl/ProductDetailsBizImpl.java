package com.mypro.biz.impl;

import com.mypro.biz.ProductDetailsBiz;
import com.mypro.dao.ProductDetailsDao;
import com.mypro.domain.ProductDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.List;

@SuppressWarnings("serial")
@Service
public class ProductDetailsBizImpl implements ProductDetailsBiz {

    private final ProductDetailsDao productDetailsDao;

    @Autowired
    public ProductDetailsBizImpl(ProductDetailsDao productDetailsDao) {
        this.productDetailsDao = productDetailsDao;
    }

    public List<ProductDetails> findByConditions(String review, String weight, String productPosition, String productType, String timeToMarket, String cpu, String ram, String hardDisk, String screenSzie, String gpu) {
        return productDetailsDao.findByConditions(review,weight,productPosition,productType,timeToMarket,cpu,ram,hardDisk,screenSzie,gpu);
    }

    public ProductDetails findById(Integer id) {
        return productDetailsDao.findById(id);
    }

    public List<ProductDetails> findAll() {
        return productDetailsDao.findAll();
    }

    public List<ProductDetails> findAllCpu() {
        return productDetailsDao.findAllCpu();
    }

    public List<ProductDetails> findAllType() {
        return productDetailsDao.findAllType();
    }

    public List<ProductDetails> findAllPosition() {
        return productDetailsDao.findAllPosition();
    }

    public List<ProductDetails> findAllBrand() {
        return productDetailsDao.findAllBrand();
    }
}
