package com.mypro.controller;


import com.mypro.biz.GoodBiz;
import com.mypro.biz.ProductDetailsBiz;
import com.mypro.domain.Good;
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
public class GoodController {

    private final GoodBiz goodBiz;
    private final ProductDetailsBiz productDetailsBiz;

    @Autowired
    public GoodController(GoodBiz goodBiz, ProductDetailsBiz productDetailsBiz) {
        this.goodBiz = goodBiz;
        this.productDetailsBiz = productDetailsBiz;
    }

    @RequestMapping(value = "/findGoodById", method = RequestMethod.GET)
    @ResponseBody
    public Good findGoodById(@RequestParam Integer Id){
        return goodBiz.findById(Id);
    }

    @RequestMapping(value = "/findByGoodName", method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findByGoodName(@RequestParam String goodName){
        List<ProductDetails> temp = new ArrayList<ProductDetails>();

        List<Good> goods = goodBiz.findByName(goodName);

        for(Good good : goods){
            temp.add(productDetailsBiz.findById(good.getId()));
        }

        return temp;
    }
}
