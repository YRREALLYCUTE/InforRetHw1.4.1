package com.mypro.domain;

import java.sql.Date;

public class ProductDetails {

    private Integer id;
    private String goodId;
    private Good good;
    private String review;
    private Integer weight;
    private String productPosition;
    private String productType;
    private String timeToMarket;
    private String packageList;
    private String cpu;
    private String ram;
    private String hardDisk;
    private Double screenSize;
    private String gpu;
    private String brand;


    public ProductDetails() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Good getGood() {
        return good;
    }

    public void setGoodId(Good good) {
        this.good= good;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public String getProductPosition() {
        return productPosition;
    }

    public void setProductPosition(String productPosition) {
        this.productPosition = productPosition;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getTimeToMarket() {
        return timeToMarket;
    }

    public void setTimeToMarket(String timeToMarket) {
        this.timeToMarket = timeToMarket;
    }

    public String getPackageList() {
        return packageList;
    }

    public void setPackageList(String packageList) {
        this.packageList = packageList;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getHardDisk() {
        return hardDisk;
    }

    public void setHardDisk(String hardDisk) {
        this.hardDisk = hardDisk;
    }

    public Double getScreenSize() {
        return screenSize;
    }

    public void setScreenSize(Double screenSize) {
        this.screenSize = screenSize;
    }

    public String getGpu() {
        return gpu;
    }

    public void setGpu(String gpu) {
        this.gpu = gpu;
    }

    public String getGoodId() {
        return goodId;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public void setGoodId(String goodId) {
        this.goodId = goodId;
    }

    @Override
    public boolean equals(Object obj) {
        if(this == obj)
            return true;
        if(obj == null)
            return false;
        if(obj instanceof ProductDetails){
            ProductDetails p = (ProductDetails) obj;
            return p.goodId.equals(goodId);
        }
        return false;
    }
}
