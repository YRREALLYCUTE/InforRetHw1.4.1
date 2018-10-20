import com.mypro.biz.BrandIndexBiz;
import com.mypro.biz.GoodBiz;
import com.mypro.biz.ProductDetailsBiz;
import com.mypro.biz.UserBiz;
import com.mypro.domain.BrandIndex;
import com.mypro.domain.Good;
import com.mypro.domain.ProductDetails;
import com.mypro.domain.User;
import org.fnlp.nlp.cn.CNFactory;
import org.fnlp.util.exception.LoadModelException;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;


@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class test_api {
    @Autowired
    private UserBiz userBiz;
    @Autowired
    private GoodBiz goodBiz;
    @Autowired
    private ProductDetailsBiz productDetailsBiz;
    @Autowired
    private BrandIndexBiz brandIndexBiz;

    @Test
    public void findUser(){
        User user = userBiz.findById(1);
        System.out.println(user.getId());
    }
    @Test
    public void findAll(){
        List<User> users = userBiz.findAll();
        for(User user : users){
            System.out.println(user.getId());
        }
    }
    @Test
    public void findByGoodId(){
        Good good = goodBiz.findById(1);
        System.out.println(good.getGoodName());
    }

    @Test
    public void findByProductDetailsId()
    {
        ProductDetails productDetails = productDetailsBiz.findById(1);
        System.out.println(productDetails.getGood().getGoodName());
    }

    @Test
    public void findAllcpu(){
       List<ProductDetails > productDetailses = productDetailsBiz.findAllCpu();

       for(ProductDetails productDetails : productDetailses){
           System.out.println(productDetails.getCpu());
       }
    }

    @Test
    public void findAllProducts(){
        List<ProductDetails > productDetailses = productDetailsBiz.findAll();

        for(ProductDetails productDetails : productDetailses){
            System.out.println(productDetails.getTimeToMarket());
        }
    }


    @Test
    public void testFnlp() throws LoadModelException {

        List<BrandIndex> temp = new ArrayList<BrandIndex>();

        // 创建中文处理工厂对象，并使用“models”目录下的模型文件初始化
        CNFactory factory = CNFactory.getInstance("./fnlp/models");

        // 使用分词器对中文句子进行分词，得到分词结果
        String[] words = factory.seg("联想笔记本");

        // 将关键词分词后进行查询 然后返回结果
        for(String word : words) {
            if(!word.equals("，") || !word.equals("。") || !word.equals("“") || !word.equals("”")) {
                List<BrandIndex> temp1 = brandIndexBiz.findByFiled(word);
                if(!temp1.isEmpty())
                    for(BrandIndex temp2 :temp1){
                        if(temp2 != null)
                        System.out.println(temp2.getProductDetails().getGood().getGoodName());
                    }
            }
        }
    }

    @Test
    public void testInsert(){
        BrandIndex tempBrand = new BrandIndex();
        ProductDetails tempProductDetails = new ProductDetails();
        tempProductDetails = productDetailsBiz.findById(2);
        tempBrand.setFiled("123");
        tempBrand.setId(2);
        tempBrand.setFrequence(1);
        tempBrand.setProductDetails(tempProductDetails);
        brandIndexBiz.insertBrandIndex(tempBrand);
    }

    @Test
    public void testUpdate(){
        BrandIndex tempBrand = new BrandIndex();
        ProductDetails tempProductDetails = new ProductDetails();
        tempProductDetails = productDetailsBiz.findById(2);
        tempBrand.setFiled("123");
        tempBrand.setId(2);
        tempBrand.setFrequence(2);
        tempBrand.setProductDetails(tempProductDetails);
        brandIndexBiz.updateBrandIndex(tempBrand);
    }

    @Test
    public void testFindByFiledAndId(){
        BrandIndex temp = brandIndexBiz.findByFiledAndId("联想",1);
        System.out.println(temp.getFrequence());
    }

    @Test
    public void testSpilt(){

        List<ProductDetails> temp = new ArrayList<ProductDetails>();

        String filed = "//你好 N 匹配";

        String []allWords = filed.split("/");

        int i = 0;

        for(String item : allWords){
            if(i == 0){
                String []andWords = allWords[0].split(" AND ");
                for(String itemA : andWords){
                    if(!itemA.equals("")) {
                        System.out.println(itemA);
                        List<BrandIndex> tempA = brandIndexBiz.findByFiled(itemA);
                        List<ProductDetails> tempB = new ArrayList<ProductDetails>();

                        for (BrandIndex temp1s : tempA) {
                            tempB.add(temp1s.getProductDetails());
                        }

                        if (!tempB.isEmpty()) {
                            if (!temp.isEmpty())
                                temp.retainAll(tempB);
                            else
                                temp.addAll(tempB);
                        }
                    }
                }
                for(ProductDetails productDetails : temp){
                    System.out.println(productDetails.getGood().getGoodName());
                }
            }
            if(i == 1){
                String []orWords = allWords[1].split(" OR ");
                for(String itemA : orWords){
                    System.out.println(itemA);
                }
            }
            if(i == 2){
                String []nWords = allWords[2].split(" N ");
                for(String itemA : nWords){
                    System.out.println(itemA);
                }
            }
            i++;
        }

    }
}
