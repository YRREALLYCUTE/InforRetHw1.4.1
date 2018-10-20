package com.mypro.controller;

import com.mypro.biz.ProductDetailsBiz;
import com.mypro.domain.ProductDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping
public class ProductDetailsController {

    private final ProductDetailsBiz productDetailsBiz;

    @Autowired
    public ProductDetailsController(ProductDetailsBiz productDetailsBiz) {
        this.productDetailsBiz = productDetailsBiz;
    }

    @RequestMapping(value="/findAllCpu",method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findAllCpu(){
        return productDetailsBiz.findAllCpu();
    }

    @RequestMapping(value="/findAllType",method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findAllType(){
        return productDetailsBiz.findAllType();
    }

    @RequestMapping(value="/findAllPosition",method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findAllPosition(){
        return productDetailsBiz.findAllPosition();
    }

    @RequestMapping(value = "/findAll", method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findAllProducts(){
        return productDetailsBiz.findAll();
    }

    @RequestMapping(value = "/findAllBrand",method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findAllBrand(){
        return productDetailsBiz.findAllBrand();
    }

    @RequestMapping(value = "/findByProductDetailsId", method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findByGoodId(@RequestParam Integer id){

        List<ProductDetails> temp = new ArrayList<ProductDetails>();

        temp.add(productDetailsBiz.findById(id));

        return temp;
    }
}
