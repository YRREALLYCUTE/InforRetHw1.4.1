package com.mypro.domain;

public class BrandIndex {

    private Integer id;
    private String filed;
    private Integer frequence;
    private ProductDetails productDetails;

    public BrandIndex() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFiled() {
        return filed;
    }

    public void setFiled(String field) {
        this.filed = field;
    }

    public Integer getFrequence() {
        return frequence;
    }

    public void setFrequence(Integer frequence) {
        this.frequence = frequence;
    }

    public ProductDetails getProductDetails() {
        return productDetails;
    }

    public void setProductDetails(ProductDetails productDetails) {
        this.productDetails = productDetails;
    }

}
