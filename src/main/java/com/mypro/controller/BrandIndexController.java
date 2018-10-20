package com.mypro.controller;

import com.mypro.biz.BrandIndexBiz;
import com.mypro.biz.GoodBiz;
import com.mypro.biz.ProductDetailsBiz;
import com.mypro.domain.BrandIndex;
import com.mypro.domain.Good;
import com.mypro.domain.ProductDetails;
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


@Controller
@RequestMapping
public class BrandIndexController {

    private final BrandIndexBiz brandIndexBiz;

    private final GoodBiz goodBiz;

    private final ProductDetailsBiz productDetailsBiz;

    @Autowired
    public BrandIndexController(BrandIndexBiz brandIndexBiz, GoodBiz goodBiz, ProductDetailsBiz productDetailsBiz) {
        this.brandIndexBiz = brandIndexBiz;
        this.goodBiz= goodBiz;
        this.productDetailsBiz = productDetailsBiz;
    }

    @RequestMapping(value = "/initBrand" , method = RequestMethod.POST)
    @ResponseBody
    public void initBrand() throws LoadModelException {
        List<Good> goods = goodBiz.findAll();

        String temp;
        Integer i;

        for(Good good : goods){
            temp = good.getGoodName();
            i = good.getId();

            // 创建中文处理工厂对象，并使用“models”目录下的模型文件初始化
            CNFactory factory = CNFactory.getInstance("E:\\工作 学习\\大三上\\信息检索\\作业\\1.4\\fnlp\\models");

            // 使用分词器对中文句子进行分词，得到分词结果
            String[] words = factory.seg(temp);

            // 将分词后的结果存入数据库中
            for(String word : words) {
                BrandIndex brandIndex = brandIndexBiz.findByFiledAndId(word,i);
                if(brandIndex == null){
                    BrandIndex tempBrand = new BrandIndex();
                    ProductDetails tempProductDetails = productDetailsBiz.findById(i);
                    tempBrand.setFiled(word);
                    tempBrand.setId(i);
                    tempBrand.setFrequence(1);
                    tempBrand.setProductDetails(tempProductDetails);
                    brandIndexBiz.insertBrandIndex(tempBrand);
                }else{
                    if(brandIndex.getFrequence() != null) {
                        brandIndex.setFrequence(brandIndex.getFrequence() + 1);
                        brandIndexBiz.updateBrandIndex(brandIndex);
                    }
                }
            }
        }
    }


    @RequestMapping(value = "/findByBrandFiled", method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findByBrandFiled(@RequestParam String filed) throws LoadModelException {

        List<ProductDetails> temp = new ArrayList<ProductDetails>();

        CNFactory factory = CNFactory.getInstance("E:\\工作 学习\\大三上\\信息检索\\作业\\1.4\\fnlp\\models");

        String[] words = factory.seg(filed);

        int judge_lang = 0;
        //此处暂时不实现 自动补字段的功能// **** //  实现方法：加一次 模糊查询，若能够查到结果，将用户所输入的filed 作为一个分词 插入到数据库中
        for(String word : words) {

            if(filed.charAt(0) == '/'){
                judge_lang = 1;
                break;
            }

            if(!word.equals("，") && !word.equals("。") && !word.equals("“") && !word.equals("”") && !word.equals("（") && !word.equals("）")) {
                List<BrandIndex> temp1 = brandIndexBiz.findByFiled(word);
                List<ProductDetails> temp2 = new ArrayList<ProductDetails>();

                for(BrandIndex temp1s : temp1){
                    temp2.add(temp1s.getProductDetails());
                }

                if(!temp2.isEmpty()) {
                    temp2.removeAll(temp);
                    temp.addAll(temp2);
                }
            }
        }

        if(judge_lang == 1){
            String []allWords = filed.split("/");

            int i = 0;

            for(String item : allWords){
                if(i == 1){
                    String []andWords = allWords[1].split(" AND ");
                    for(String items : andWords){
                        List<BrandIndex> tempA = brandIndexBiz.findByFiled(items);
                        List<ProductDetails> tempB = new ArrayList<ProductDetails>();

                        for(BrandIndex temp1s : tempA){
                            tempB.add(temp1s.getProductDetails());
                        }

                        if(!tempB.isEmpty()) {
                            if(!temp.isEmpty())
                                temp.retainAll(tempB);
                            else
                                temp.addAll(tempB);
                        }
                    }
                }
                if(i == 2){
                    String []orWords = allWords[2].split(" OR ");
                    for(String items : orWords){
                        List<BrandIndex> tempA = brandIndexBiz.findByFiled(items);
                        List<ProductDetails> tempB = new ArrayList<ProductDetails>();

                        for(BrandIndex temp1s : tempA){
                            tempB.add(temp1s.getProductDetails());
                        }

                        if(!tempB.isEmpty()) {
                            tempB.removeAll(temp);
                            temp.addAll(tempB);
                        }
                    }
                }
                if(i == 3){
                    String []nWords = allWords[3].split(" N ");
                    for(String items : nWords) {
                        List<BrandIndex> tempA = brandIndexBiz.findByFiled(items);
                        List<ProductDetails> tempB = new ArrayList<ProductDetails>();

                        for (BrandIndex temp1s : tempA) {
                            tempB.add(temp1s.getProductDetails());
                        }

                        if(!tempB.isEmpty()){
                            if(!temp.isEmpty())
                                temp.removeAll(tempB);
                            else {
                                temp = productDetailsBiz.findAll();
                                temp.removeAll(tempB);
                            }
                        }
                    }
                }
                i++;
            }
        }

        return temp;
    }

    @RequestMapping(value = "/findByBrandFiledAnd", method = RequestMethod.GET)
    @ResponseBody
    public List<ProductDetails> findByBrandFiledAnd(@RequestParam String filed) throws LoadModelException {

        List<ProductDetails> temp = new ArrayList<ProductDetails>();

        CNFactory factory = CNFactory.getInstance("E:\\工作 学习\\大三上\\信息检索\\作业\\1.4\\fnlp\\models");

        String[] words = factory.seg(filed);

        //此处暂时不实现 自动补字段的功能// **** //  实现方法：加一次 模糊查询，若能够查到结果，将用户所输入的filed 作为一个分词 插入到数据库中
        for(String word : words) {
            if(!word.equals("，") && !word.equals("。") && !word.equals("“") && !word.equals("”") && !word.equals("（") && !word.equals("）")) {
                List<BrandIndex> temp1 = brandIndexBiz.findByFiled(word);
                List<ProductDetails> temp2 = new ArrayList<ProductDetails>();

                for(BrandIndex temp1s : temp1){
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
