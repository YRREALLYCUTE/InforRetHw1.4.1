package com.mypro.domain;

public class Good {
    private Integer id;
    private String goodId;
    private String goodName;
    private double goodPrice;
    private String goodImage;
    private Integer goodStock;
    private Integer goodSaleNum;
    private Integer deleteStatus;

    public Good() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGoodId() {
        return goodId;
    }

    public void setGoodId(String goodId) {
        this.goodId = goodId;
    }

    public String getGoodName() {
        return goodName;
    }

    public void setGoodName(String goodName) {
        this.goodName = goodName;
    }

    public double getGoodPrice() {
        return goodPrice;
    }

    public void setGoodPrice(double goodPrice) {
        this.goodPrice = goodPrice;
    }

    public String getGoodImage() {
        return goodImage;
    }

    public void setGoodImage(String goodImage) {
        this.goodImage = goodImage;
    }

    public Integer getGoodStock() {
        return goodStock;
    }

    public void setGoodStock(Integer goodStock) {
        this.goodStock = goodStock;
    }

    public Integer getGoodSaleNum() {
        return goodSaleNum;
    }

    public void setGoodSaleNum(Integer goodSaleNum) {
        this.goodSaleNum = goodSaleNum;
    }

    public Integer getdeleteStatus() {
        return deleteStatus;
    }

    public void setDeleteStatus(Integer deleteStatus) {
        this.deleteStatus = deleteStatus;
    }

}
