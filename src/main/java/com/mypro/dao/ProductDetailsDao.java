package com.mypro.dao;

import com.mypro.domain.ProductDetails;

import java.sql.Date;
import java.util.List;

public interface ProductDetailsDao {

    List<ProductDetails> findByConditions(String review, String weight, String productPosition, String productType, String timeToMarket, String cpu, String ram, String hardDisk, String screenSzie, String gpu);

    ProductDetails findById(Integer id);

    List<ProductDetails> findAll();

    List<ProductDetails> findAllCpu();

    List<ProductDetails> findAllType();

    List<ProductDetails> findAllPosition();

    List<ProductDetails> findAllBrand();
 }
