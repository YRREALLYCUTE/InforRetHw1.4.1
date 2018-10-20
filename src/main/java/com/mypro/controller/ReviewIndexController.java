package com.mypro.controller;


import com.mypro.biz.GoodBiz;
import com.mypro.biz.ProductDetailsBiz;
import com.mypro.biz.ReviewIndexBiz;
import com.mypro.domain.Good;
import com.mypro.domain.ProductDetails;
import com.mypro.domain.ReviewIndex;
import org.fnlp.nlp.cn.CNFactory;
import org.fnlp.util.exception.LoadModelException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@RequestMapping
@Controller
public class ReviewIndexController {

    private final ReviewIndexBiz reviewIndexBiz;

    private final GoodBiz goodBiz;

    private final ProductDetailsBiz productDetailsBiz;

    @Autowired
    public ReviewIndexController(ReviewIndexBiz reviewIndexBiz, GoodBiz goodBiz, ProductDetailsBiz productDetailsBiz) {
        this.reviewIndexBiz = reviewIndexBiz;
        this.goodBiz= goodBiz;
        this.productDetailsBiz = productDetailsBiz;
    }

    @RequestMapping(value = "/initReview" , method = RequestMethod.POST)
    @ResponseBody
    public void initBrand() throws LoadModelException {
        List<ProductDetails> productDetails = productDetailsBiz.findAll();

        String temp;
        Integer i;

        for(ProductDetails productDetail : productDetails){
            temp = productDetail.getReview();
            i = productDetail.getId();

            // 创建中文处理工厂对象，并使用“models”目录下的模型文件初始化
            CNFactory factory = CNFactory.getInstance("E:\\工作 学习\\大三上\\信息检索\\作业\\1.4\\fnlp\\models");

            // 使用分词器对中文句子进行分词，得到分词结果
            String[] words = factory.seg(temp);

            // 将分词后的结果存入数据库中
            for(String word : words) {
                if (!word.equals("，") && !word.equals("。") && !word.equals("“") && !word.equals("”") && !word.equals("（") && !word.equals("）")) {
                    ReviewIndex reviewIndex = reviewIndexBiz.findByFiledAndId(word, i);
                    if (reviewIndex == null) {
                        ReviewIndex tempBrand = new ReviewIndex();
                        ProductDetails tempProductDetails = productDetailsBiz.findById(i);
                        tempBrand.setFiled(word);
                        tempBrand.setId(i);
                        tempBrand.setFrequence(1);
                        tempBrand.setProductDetails(tempProductDetails);
                        reviewIndexBiz.insertReviewIndex(tempBrand);
                    } else {
                        if (reviewIndex.getFrequence() != null) {
                            reviewIndex.setFrequence(reviewIndex.getFrequence() + 1);
                            reviewIndexBiz.updateReviewIndex(reviewIndex);
                        }
                    }
                }
            }
        }
    }


    @RequestMapping(value = "/findByReviewFiled", method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findByBrandFiled(@RequestParam String filed) throws LoadModelException {

        List<ProductDetails> temp = new ArrayList<ProductDetails>();

        CNFactory factory = CNFactory.getInstance("E:\\工作 学习\\大三上\\信息检索\\作业\\1.4\\fnlp\\models");

        String[] words = factory.seg(filed);

        //此处暂时不实现 自动补字段的功能// **** //  实现方法：加一次 模糊查询，若能够查到结果，将用户所输入的filed 作为一个分词 插入到数据库中
        for(String word : words) {
            if(!word.equals("，") && !word.equals("。") && !word.equals("“") && !word.equals("”") && !word.equals("（") && !word.equals("）")) {
                List<ReviewIndex> temp1 = reviewIndexBiz.findByFiled(word);
                List<ProductDetails> temp2 = new ArrayList<ProductDetails>();

                for(ReviewIndex temp1s : temp1){
                    temp2.add(temp1s.getProductDetails());
                }

                if(!temp2.isEmpty()) {
                    temp2.removeAll(temp);
                    temp.addAll(temp2);
                }
            }
        }
        return temp;
    }

    @RequestMapping(value = "/findByReviewFiledAnd", method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findByBrandFiledAnd(@RequestParam String filed) throws LoadModelException {

        List<ProductDetails> temp = new ArrayList<ProductDetails>();

        CNFactory factory = CNFactory.getInstance("E:\\工作 学习\\大三上\\信息检索\\作业\\1.4\\fnlp\\models");

        String[] words = factory.seg(filed);

        for(String word : words) {
            if(!word.equals("，") && !word.equals("。") && !word.equals("“") && !word.equals("”") && !word.equals("（") && !word.equals("）")) {
                List<ReviewIndex> temp1 = reviewIndexBiz.findByFiled(word);
                List<ProductDetails> temp2 = new ArrayList<ProductDetails>();

                for(ReviewIndex temp1s : temp1){
                    temp2.add(temp1s.getProductDetails());
                }

                if(!temp2.isEmpty()) {
                    if(!temp.isEmpty())
                        temp.retainAll(temp2);
                    else
                        temp.addAll(temp2);
                }
            }
        }
        return temp;
    }

}
