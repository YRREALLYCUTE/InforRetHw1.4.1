<%--
  Created by IntelliJ IDEA.
  User: 该读过
  Date: 2018/10/13
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>一个检索系统</title>
    <meta charset="UTF-8">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../node_modules/element-ui/lib/theme-chalk/index.css">
</head>
<body>
<div>
    <img src="../images/header.JPG" style="width: 100%; height: auto;">
</div>

<div style="margin-left: 12%;margin-right: 12%;">
    <img src="../images/h1_ps.jpg" style="width: 100%;height: auto">
</div>
<div id="app">
    <el-card style="margin-left: 12%;margin-right: 12%">

        <div>
            <el-input placeholder="请输入内容" v-model="input3" v-on:keyup.enter.native="gotoHttp">
                <template slot="prepend">Http://</template>
            </el-input>
        </div>

        <div style="margin-top:15px">
            <el-tabs type="border-card">
                <el-tab-pane>
                    <span slot="label"><i class="el-icon-search"></i>简单检索</span>
                    <el-row>
                        <el-col :span="4" >
                            <el-select v-model="simpleSearchFirst" placeholder="请选择" size="medium" style="width: 100%">
                                <el-option v-for="item in simpleSearchFirstItems"
                                           :key="item.value"
                                           :value="item.value"
                                           :label="item.label"
                                ></el-option>
                            </el-select>
                        </el-col>
                        <el-col :span="4" >
                            <el-select v-model="simpleSearchSecond" placeholder="请选择" size="medium" style="width: 100%">
                                <el-option v-for="item in simpleSearchSecondItems"
                                           :key="item.value"
                                           :value="item.value"
                                           :label="item.label"
                                ></el-option>
                            </el-select>
                        </el-col>
                        <el-col :span="11">
                            <el-input v-model="inputStaff" size="medium" placeholder="请输入......">
                            </el-input>
                        </el-col>
                        <el-col :offset="1" :span="1">
                            <el-button size="medium" type="success" v-on:click="simpleSearch(inputStaff)"><i class="el-icon-search"></i>&nbsp;查询</el-button>
                        </el-col>
                        <el-col :offset="1" :span="2">
                            <el-button size="medium" type="info" v-on:click="moreConditions" v-if="condition===false"><i class="el-icon-circle-plus-outline"></i>&nbsp;更多条件</el-button>
                            <el-button size="medium" type="info" v-on:click="moreConditions" v-if="condition===true"><i class="el-icon-remove-outline"></i>&nbsp;取消</el-button>
                        </el-col>
                    </el-row>
                    <!-- 以下三个el-row为限制条件  下面为检索结果  需要建立一个el-card  加入动画效果-->
                    <el-row>
                        <div style="margin-top: 15px">
                            <el-collapse-transition>

                                <div v-show="condition">
                                    <hr class="myStyle">
                                    <el-col :span="2" style="text-align: right;margin-top: 4px">
                                        <span style="font-weight: bold;font-size: 15px" >排序方式：</span>
                                    </el-col>
                                    <el-col  :span="4">
                                        <el-select v-model="oderRules" placeholder="请选择" size="mini" style="width: 100%;border: none">
                                            <el-option v-for="item in orderRuleItems"
                                                       :key=item.value
                                                       :value=item.value
                                                       :label=item.label>
                                            </el-option>
                                        </el-select>
                                    </el-col>
                                    <el-col :offset="1" :span="10" style="margin-left:10px">
                                        <el-radio-group v-model="radioOrder" style="margin-top: 7px">
                                            <el-radio :label="3" size="mini">升序排列</el-radio>
                                            <el-radio :label="6" size="mini">降序排列</el-radio>
                                            <el-radio :label="9" size="mini">默认显示</el-radio>
                                        </el-radio-group>
                                    </el-col>
                                </div>
                            </el-collapse-transition>
                        </div>
                    </el-row>
                    <el-row>
                        <div style="margin-top: 15px">
                            <el-collapse-transition>

                                <div v-show="condition">
                                    <el-col :span="2" style="text-align: right;margin-top: 4px">
                                        <span style="font-weight: bold;font-size: 15px" >显示方式：</span>
                                    </el-col>
                                    <el-col  :span="4">
                                        <el-select v-model="displayRule" placeholder="请选择 条数/页" size="mini" style="width: 100%;border: none">
                                            <el-option v-for="item in displayRuleItems"
                                                       :key=item.value
                                                       :value=item.value
                                                       :label=item.label>
                                            </el-option>
                                        </el-select>
                                    </el-col>
                                    <el-col :offset="1" :span="10" style="margin-left:10px">
                                        <el-radio-group v-model="radioDisplay" style="margin-top: 7px">
                                            <el-radio :label="3" size="mini">列表显示</el-radio>
                                            <el-radio :label="6" size="mini">卡片显示</el-radio>
                                        </el-radio-group>
                                    </el-col>
                                </div>
                            </el-collapse-transition>
                        </div>
                    </el-row>
                    <el-row>
                        <div style="margin-top: 15px">
                            <el-collapse-transition>

                                <div v-show="condition">
                                    <el-col :span="2" style="text-align: right;margin-top: 4px">
                                        <span style="font-weight: bold;font-size: 15px" >检索方式：</span>
                                    </el-col>
                                    <el-col  :span="4">
                                        <el-select v-model="areaRule" placeholder="请选择" size="mini" style="width: 100%;border: none">
                                            <el-option v-for="item in areaRuleItems"
                                                       :key=item.value
                                                       :value=item.value
                                                       :label=item.label>
                                            </el-option>
                                        </el-select>
                                    </el-col>
                                </div>
                            </el-collapse-transition>
                        </div>
                    </el-row>

                    <!-- 以下为查询列表？分别以表格形式以及带图片的card展示 -->
                    <div style="margin-top: 15px">
                        <!-- card -->
                        <el-collapse-transition>
                                <!-- 此部分以 card 形式展示部分信息 -->
                                <div v-show="radioDisplay != 3">
                                    <el-row v-for="(item,index) in productList">
                                        <div v-if="index % 3==0 && (index + 2) < productList.length" style="margin-top: 15px">
                                            <el-col :span="7" :offset="0">
                                                <el-card :body-style="{ padding: '0px' }" shadow="hover">
                                                    <img v-bind:src="productList[index].good.goodImage" class="image">
                                                    <div style="padding: 14px;">
                                                        <span>{{productList[index].good.goodName}}</span>
                                                        <div class="bottom clearfix">
                                                            <time class="time">上市时间：{{productList[index].timeToMarket}}</time>
                                                            <el-popover placement="bottom" width="700" trigger="click">
                                                                <el-form label-position="left" inline class="demo-table-expand">
                                                                    <el-form-item label="商品名称">
                                                                        <span>{{ productList[index].good.goodName }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="价格">
                                                                        <span>￥{{ productList[index].good.goodPrice }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品 ID">
                                                                        <span>No.{{ productList[index].good.id }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品类型">
                                                                        <span>{{ productList[index].productType }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品定位">
                                                                        <span>{{ productList[index].productPosition }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="重量">
                                                                        <span>{{productList[index].weight }}g</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="上市日期">
                                                                        <i class="el-icon-time"></i>
                                                                        <span>{{ productList[index].timeToMarket }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="处理器cpu">
                                                                        <span>{{ productList[index].cpu }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="内存">
                                                                        <span>{{ productList[index].ram }}GB</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="硬盘容量">
                                                                        <span>{{ productList[index].hardDisk }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="显卡">
                                                                        <span>{{ productList[index].gpu }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品描述">
                                                                        <span>{{ productList[index].review }}</span>
                                                                    </el-form-item>
                                                                </el-form>
                                                                <el-button slot="reference" type="text" class="button">查看更多</el-button>
                                                            </el-popover>
                                                        </div>
                                                    </div>
                                                </el-card>
                                            </el-col>
                                            <el-col :span="7" :offset="1">
                                                <el-card :body-style="{ padding: '0px' }" shadow="hover">
                                                    <img v-bind:src="productList[index+1].good.goodImage" class="image">
                                                    <div style="padding: 14px;">
                                                        <span>{{productList[index+1].good.goodName}}</span>
                                                        <div class="bottom clearfix">
                                                            <time class="time">上市时间：{{ productList[index+1].timeToMarket}}</time>
                                                            <el-popover placement="bottom" width="700" trigger="click">
                                                                <el-form label-position="left" inline class="demo-table-expand">
                                                                    <el-form-item label="商品名称">
                                                                        <span>{{ productList[index+1].good.goodName }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="价格">
                                                                        <span>￥{{ productList[index+1].good.goodPrice }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品 ID">
                                                                        <span>No.{{ productList[index+1].good.id }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品类型">
                                                                        <span>{{ productList[index+1].productType }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品定位">
                                                                        <span>{{ productList[index+1].productPosition }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="重量">
                                                                        <span>{{productList[index+1].weight }}g</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="上市日期">
                                                                        <i class="el-icon-time"></i>
                                                                        <span>{{ productList[index+1].timeToMarket }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="处理器cpu">
                                                                        <span>{{ productList[index+1].cpu }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="内存">
                                                                        <span>{{ productList[index+1].ram }}GB</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="硬盘容量">
                                                                        <span>{{ productList[index+1].hardDisk }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="显卡">
                                                                        <span>{{ productList[index+1].gpu }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品描述">
                                                                        <span>{{ productList[index+1].review }}</span>
                                                                    </el-form-item>
                                                                </el-form>
                                                                <el-button slot="reference" type="text" class="button">查看更多</el-button>
                                                            </el-popover>
                                                        </div>
                                                    </div>
                                                </el-card>
                                            </el-col>
                                            <el-col :span="7" :offset="1">
                                                <el-card :body-style="{ padding: '0px' }" shadow="hover">
                                                    <img v-bind:src="productList[index+2].good.goodImage" class="image">
                                                    <div style="padding: 14px;">
                                                        <span>{{productList[index+2].good.goodName}}</span>
                                                        <div class="bottom clearfix">
                                                            <time class="time">上市时间：{{ productList[index+2].timeToMarket}}</time>
                                                            <el-popover placement="bottom" width="700" trigger="click">
                                                                <el-form label-position="left" inline class="demo-table-expand">
                                                                    <el-form-item label="商品名称">
                                                                        <span>{{ productList[index+2].good.goodName }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="价格">
                                                                        <span>￥{{ productList[index+2].good.goodPrice }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品 ID">
                                                                        <span>No.{{ productList[index+2].good.id }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品类型">
                                                                        <span>{{ productList[index+2].productType }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品定位">
                                                                        <span>{{ productList[index+2].productPosition }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="重量">
                                                                        <span>{{productList[index+2].weight }}g</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="上市日期">
                                                                        <i class="el-icon-time"></i>
                                                                        <span>{{ productList[index+2].timeToMarket }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="处理器cpu">
                                                                        <span>{{ productList[index+2].cpu }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="内存">
                                                                        <span>{{ productList[index+2].ram }}GB</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="硬盘容量">
                                                                        <span>{{ productList[index+2].hardDisk }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="显卡">
                                                                        <span>{{ productList[index+2].gpu }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品描述">
                                                                        <span>{{ productList[index+2].review }}</span>
                                                                    </el-form-item>
                                                                </el-form>
                                                                <el-button slot="reference" type="text" class="button">查看更多</el-button>
                                                            </el-popover>
                                                        </div>
                                                    </div>
                                                </el-card>
                                            </el-col>
                                        </div>
                                    </el-row>
                                    <el-row v-if="productList.length % 3 != 0">
                                        <div v-if="productList.length % 3 === 1" style="margin-top: 15px;">
                                            <el-col :span="7" :offset="0">
                                            <el-card :body-style="{ padding: '0px' }" shadow="hover">
                                                <img v-bind:src="productList[productList.length-1].good.goodImage" class="image">
                                                <div style="padding: 14px;">
                                                    <span>{{productList[productList.length-1].good.goodName}}</span>
                                                    <div class="bottom clearfix">
                                                        <time class="time">上市时间：{{productList[productList.length-1].timeToMarket}}</time>
                                                        <el-popover placement="bottom" width="700" trigger="click">
                                                            <el-form label-position="left" inline class="demo-table-expand">
                                                                <el-form-item label="商品名称">
                                                                    <span>{{ productList[productList.length-1].good.goodName }}</span>
                                                                </el-form-item>
                                                                <el-form-item label="价格">
                                                                    <span>￥{{ productList[productList.length-1].good.goodPrice }}</span>
                                                                </el-form-item>
                                                                <el-form-item label="商品 ID">
                                                                    <span>No.{{ productList[productList.length-1].good.id }}</span>
                                                                </el-form-item>
                                                                <el-form-item label="商品类型">
                                                                    <span>{{ productList[productList.length-1].productType }}</span>
                                                                </el-form-item>
                                                                <el-form-item label="商品定位">
                                                                    <span>{{ productList[productList.length-1].productPosition }}</span>
                                                                </el-form-item>
                                                                <el-form-item label="重量">
                                                                    <span>{{productList[productList.length-1].weight }}g</span>
                                                                </el-form-item>
                                                                <el-form-item label="上市日期">
                                                                    <i class="el-icon-time"></i>
                                                                    <span>{{ productList[productList.length-1].timeToMarket }}</span>
                                                                </el-form-item>
                                                                <el-form-item label="处理器cpu">
                                                                    <span>{{ productList[productList.length-1].cpu }}</span>
                                                                </el-form-item>
                                                                <el-form-item label="内存">
                                                                    <span>{{ productList[productList.length-1].ram }}GB</span>
                                                                </el-form-item>
                                                                <el-form-item label="硬盘容量">
                                                                    <span>{{ productList[productList.length-1].hardDisk }}</span>
                                                                </el-form-item>
                                                                <el-form-item label="显卡">
                                                                    <span>{{ productList[productList.length-1].gpu }}</span>
                                                                </el-form-item>
                                                                <el-form-item label="商品描述">
                                                                    <span>{{ productList[productList.length-1].review }}</span>
                                                                </el-form-item>
                                                            </el-form>
                                                            <el-button slot="reference" type="text" class="button">查看更多</el-button>
                                                        </el-popover>
                                                    </div>
                                                </div>
                                            </el-card>
                                        </el-col>
                                        </div>
                                        <div v-if="productList.length % 3 === 2" style="margin-top: 15px;">
                                            <el-col :span="7" :offset="0">
                                                <el-card :body-style="{ padding: '0px' }" shadow="hover">
                                                    <img v-bind:src="productList[productList.length-1].good.goodImage" class="image">
                                                    <div style="padding: 14px;">
                                                        <span>{{productList[productList.length-1].good.goodName}}</span>
                                                        <div class="bottom clearfix">
                                                            <time class="time">上市时间：{{ productList[productList.length-1].timeToMarket}}</time>
                                                            <el-popover placement="bottom" width="700" trigger="click">
                                                                <el-form label-position="left" inline class="demo-table-expand">
                                                                    <el-form-item label="商品名称">
                                                                        <span>{{ productList[productList.length-1].good.goodName }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="价格">
                                                                        <span>￥{{ productList[productList.length-1].good.goodPrice }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品 ID">
                                                                        <span>No.{{ productList[productList.length-1].good.id }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品类型">
                                                                        <span>{{ productList[productList.length-1].productType }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品定位">
                                                                        <span>{{ productList[productList.length-1].productPosition }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="重量">
                                                                        <span>{{productList[productList.length-1].weight }}g</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="上市日期">
                                                                        <i class="el-icon-time"></i>
                                                                        <span>{{ productList[productList.length-1].timeToMarket }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="处理器cpu">
                                                                        <span>{{ productList[productList.length-1].cpu }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="内存">
                                                                        <span>{{ productList[productList.length-1].ram }}GB</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="硬盘容量">
                                                                        <span>{{ productList[productList.length-1].hardDisk }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="显卡">
                                                                        <span>{{ productList[productList.length-1].gpu }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品描述">
                                                                        <span>{{ productList[productList.length-1].review }}</span>
                                                                    </el-form-item>
                                                                </el-form>
                                                                <el-button slot="reference" type="text" class="button">查看更多</el-button>
                                                            </el-popover>
                                                        </div>
                                                    </div>
                                                </el-card>
                                            </el-col>
                                            <el-col :span="7" :offset="1">
                                                <el-card :body-style="{ padding: '0px' }" shadow="hover">
                                                    <img v-bind:src="productList[productList.length-2].good.goodImage" class="image">
                                                    <div style="padding: 14px;">
                                                        <span>{{productList[productList.length-2].good.goodName}}</span>
                                                        <div class="bottom clearfix">
                                                            <time class="time">上市时间：{{ productList[productList.length-2].timeToMarket}}</time>
                                                            <el-popover placement="bottom" width="700" trigger="click">
                                                                <el-form label-position="left" inline class="demo-table-expand">
                                                                    <el-form-item label="商品名称">
                                                                        <span>{{ productList[productList.length-2].good.goodName }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="价格">
                                                                        <span>￥{{ productList[productList.length-2].good.goodPrice }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品 ID">
                                                                        <span>No.{{ productList[productList.length-2].good.id }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品类型">
                                                                        <span>{{ productList[productList.length-2].productType }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品定位">
                                                                        <span>{{ productList[productList.length-2].productPosition }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="重量">
                                                                        <span>{{productList[productList.length-2].weight }}g</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="上市日期">
                                                                        <i class="el-icon-time"></i>
                                                                        <span>{{ productList[productList.length-2].timeToMarket }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="处理器cpu">
                                                                        <span>{{ productList[productList.length-2].cpu }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="内存">
                                                                        <span>{{ productList[productList.length-2].ram }}GB</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="硬盘容量">
                                                                        <span>{{ productList[productList.length-2].hardDisk }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="显卡">
                                                                        <span>{{ productList[productList.length-2].gpu }}</span>
                                                                    </el-form-item>
                                                                    <el-form-item label="商品描述">
                                                                        <span>{{ productList[productList.length-2].review }}</span>
                                                                    </el-form-item>
                                                                </el-form>
                                                                <el-button slot="reference" type="text" class="button">查看更多</el-button>
                                                            </el-popover>
                                                        </div>
                                                    </div>
                                                </el-card>
                                            </el-col>
                                        </div>
                                    </el-row>
                                </div>
                            </el-collapse-transition>
                        <!-- table -->
                        <el-collapse-transition>
                                <!-- 此部分以列表形式展示信息 -->
                                <div v-show = "radioDisplay === 3" style="margin-top: 30px">
                                    <el-table
                                            :data="productList"
                                            style="width: 92%;margin-left: 4%">
                                        <el-table-column type="expand">
                                            <template slot-scope="props">
                                                <el-form label-position="left" inline class="demo-table-expand">
                                                    <el-form-item label="商品名称">
                                                        <span>{{ props.row.good.goodName }}</span>
                                                    </el-form-item>
                                                    <el-form-item label="价格">
                                                        <span>￥{{ props.row.good.goodPrice }}</span>
                                                    </el-form-item>
                                                    <el-form-item label="商品 ID">
                                                        <span>No.{{ props.row.good.id }}</span>
                                                    </el-form-item>
                                                    <el-form-item label="商品类型">
                                                        <span>{{ props.row.productType }}</span>
                                                    </el-form-item>
                                                    <el-form-item label="商品定位">
                                                        <span>{{ props.row.productPosition }}</span>
                                                    </el-form-item>
                                                    <el-form-item label="重量">
                                                        <span>{{ props.row.weight }}g</span>
                                                    </el-form-item>
                                                    <el-form-item label="上市日期">
                                                        <i class="el-icon-time"></i>
                                                        <span>{{ props.row.timeToMarket }}</span>
                                                    </el-form-item>
                                                    <el-form-item label="处理器cpu">
                                                        <span>{{ props.row.cpu }}</span>
                                                    </el-form-item>
                                                    <el-form-item label="内存">
                                                        <span>{{ props.row.ram }}GB</span>
                                                    </el-form-item>
                                                    <el-form-item label="硬盘容量">
                                                        <span>{{ props.row.hardDisk }}</span>
                                                    </el-form-item>
                                                    <el-form-item label="显卡">
                                                        <span>{{ props.row.gpu }}</span>
                                                    </el-form-item>
                                                    <el-form-item label="商品描述">
                                                        <span>{{ props.row.review }}</span>
                                                    </el-form-item>
                                                </el-form>
                                            </template>
                                        </el-table-column>
                                        <el-table-column
                                                label="商品名称"
                                                prop="good.goodName">
                                        </el-table-column>
                                        <el-table-column
                                                label="商品价格(￥)"
                                                prop="good.goodPrice"
                                                sortable>
                                        </el-table-column>
                                        <el-table-column
                                                label="描述"
                                                prop="review">
                                        </el-table-column>
                                    </el-table>
                                </div>
                            </el-collapse-transition>
                    </div>
                </el-tab-pane>

                <!-- 以下为多字段检索部分 -->
                <el-tab-pane disabled>
                    <span slot="label"><i class="el-icon-menu"></i>多字段检索</span>
                    <el-row>
                        <el-col :offset="1" :span="1" style="text-align: right;margin-top: 5px">
                            品牌：
                        </el-col>
                        <el-col :span="3" style="text-align: center">
                            <el-autocomplete
                                    size="medium"
                                    v-model="brand"
                                    :fetch-suggestions="querySearchAsync"
                                    placeholder="请输入品牌"
                                    @select="handleSelect"
                                    style="width: 96%"
                            ></el-autocomplete>
                        </el-col>
                        <el-col :span="2" style="text-align: right;margin-top: 5px">
                            <span >描述：</span>
                        </el-col>
                        <el-col :span="3" style="text-align: center">
                            <el-input size="medium" v-model="Review" placeholder="例如：背光键盘 或者 双摄像头等"></el-input>
                        </el-col>
                        <el-col :span="2" style="text-align: right;margin-top: 5px">
                            <span>
                                重量：
                            </span>
                        </el-col>
                        <el-col :span="5" style="text-align: center">
                            <el-input v-model="lowerWeight" placeholder="单位：Kg" size="medium" style="width: 45%"></el-input>
                            <span>
                                &nbsp;~&nbsp;
                            </span>
                            <el-input v-model="higherWeight" placeholder="单位：Kg" size="medium" style="width: 45%"></el-input>
                        </el-col>
                        <el-col :span="2" style="text-align: right;margin-top: 5px">
                            <span >
                                商品定位：
                            </span>
                        </el-col>
                        <el-col :span="3" style="text-align: center">
                            <el-select v-model="position" placeholder="请选择" size="medium" style="width: 96%">
                                <el-option v-for="item in positionItems"
                                           :key="item.productPosition"
                                           :value="item.productPosition"
                                           :label="item.productPosition">
                                </el-option>
                            </el-select>
                        </el-col>
                    </el-row>
                    <div style="margin-top:15px"></div>
                    <el-row>
                        <el-col :offset="1" :span="1" style="text-align: right;margin-top: 5px">
                            <span>类型：</span>
                        </el-col>
                        <el-col :span="3" style="text-align: center">
                            <el-select v-model="type" placeholder="请选择类型" size="medium" style="width: 96%">
                                <el-option v-for="item in typeItems"
                                           :key="item.productType"
                                           :value="item.productType"
                                           :label="item.productType"
                                >
                                </el-option>
                            </el-select>
                        </el-col>
                        <el-col :span="2" style="text-align: right;margin-top: 5px">
                            <span >上市时间：</span>
                        </el-col>
                        <el-col :span="3" style="text-align: center">
                            <div class="block">
                                <el-date-picker
                                        size="medium"
                                        style="width: 100%"
                                        v-model="dateValue"
                                        type="daterange"
                                        align="right"
                                        unlink-panels
                                        range-separator="至"
                                        start-placeholder="开始日期"
                                        end-placeholder="结束日期"
                                        :picker-options="pickerOptions2">
                                </el-date-picker>
                            </div>
                        </el-col>
                        <el-col :span="2" style="text-align: right;margin-top: 5px">
                                <span>
                                    屏幕尺寸：
                                </span>
                        </el-col>
                        <el-col :span="5" style="text-align: center">
                            <el-input v-model="lowerSize" placeholder="单位：英寸" size="medium" style="width: 45%"></el-input>
                            <span>
                                    &nbsp;~&nbsp;
                                </span>
                            <el-input v-model="higherSize" placeholder="单位：英寸" size="medium" style="width: 45%"></el-input>
                        </el-col>
                        <el-col :span="2" style="text-align: right;margin-top: 5px">
                                <span >
                                    内存：
                                </span>
                        </el-col>
                        <el-col :span="3" style="text-align: center">
                            <el-select v-model="ram" placeholder="请选择" size="medium" style="width: 96%">
                                <el-option v-for="item in ramItems"
                                           :key="item.value"
                                           :value="item.value"
                                           :label="item.label">
                                </el-option>
                            </el-select>
                        </el-col>
                    </el-row>
                    <div style="margin-top:15px"></div>
                    <el-row>
                        <el-col :offset="1" :span="1" style="text-align: right;margin-top: 5px">
                            <span>处理器CPU:</span>
                        </el-col>
                        <el-col :span="3" style="text-align: center">
                            <el-select v-model="CPUType" placeholder="请选择" size="medium" style="width: 96%">
                                <el-option v-for="item in CPUTypeItems"
                                           :key="item.cpu"
                                           :value="item.cpu"
                                           :label="item.cpu"
                                >
                                </el-option>
                            </el-select>
                        </el-col>
                        <el-col :span="2" style="text-align: right;margin-top: 5px">
                            <span >显卡：</span>
                        </el-col>
                        <el-col :span="3" style="text-align: center">
                            <el-input v-model="GPUType" placeholder="请输入" size="medium" style="width: 96%">
                            </el-input>
                        </el-col>
                        <el-col :span="2" style="text-align: right;margin-top: 5px">
                                    <span>
                                        硬盘容量：
                                    </span>
                        </el-col>
                        <el-col :span="5" style="text-align: center">
                            <el-input v-model="lowerHD" placeholder="单位：GB" size="medium" style="width: 45%"></el-input>
                            <span>
                                        &nbsp;~&nbsp;
                                    </span>
                            <el-input v-model="higherHD" placeholder="单位：GB" size="medium" style="width: 45%"></el-input>
                        </el-col>
                        <el-col :span="3" style="text-align: right">
                            <el-button size="medium" v-on:click="multiConditionSearch" type="success"><i class="el-icon-search"></i>搜索</el-button>
                        </el-col>
                        <el-col :span="2" style="text-align: right">
                            <el-button size="medium" type="info" v-on:click="resetOptions"><i class="el-icon-delete"></i>&nbsp;重置</el-button>
                        </el-col>
                    </el-row>
                </el-tab-pane>
            </el-tabs>
        </div>
    </el-card>
</div>
</body>
</html>

<!-- import Vue before Element -->
<script src="../node_modules/vue/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="../node_modules/element-ui/lib/index.js"></script>
<!--import Axios-->
<script src="../node_modules/axios/dist/axios.min.js"></script>
<script>
    new Vue({
        el:'#app',
        data: {
            productList:[], // 产品列表
            //---------------------------简单查询的选项-------------------------------------------//
            simpleSearchFirst:1,           //简单查询第一条件的值
            simpleSearchSecond:1,         //简单查询的第二条件的值
            inputStaff:'',                 //关键字部分
            simpleSearchFirstItems:[
                {
                    label:'商品品牌',
                    value:1
                },
                {
                    label:'商品 ID',
                    value:2
                },
                {
                    label:'商品描述',
                    value:3
                }
            ],     //简单查询的第一条件
            simpleSearchSecondItems:[
                {
                    label:'关键字匹配',
                    value:1
                },
                {
                    label:'完全匹配',
                    value:2
                }
            ],   //简单查询的第二条件
            condition:false,       //显示高级查询
            radioOrder: 3,         //单选框的默认选中状态
            radioDisplay: 6,        //单选框
            oderRules:'',
            orderRuleItems:[{
                label:'价格',
                value:1
                },
                {
                    label:'库存量',
                    value:2
                },
                ],      //排序方式
            displayRule:'',
            displayRuleItems:[
                {
                    value:1,
                    label:'50/页'
                },
                {
                    value: 2,
                    label:'150/页'
                },
                {
                    value: 3,
                    label:'200/页'
                }
            ],   //显示规则********此处应该与分页处理相关联，故之后需要处理下
            areaRule:1,           //检索范围
            areaRuleItems:[
                {
                    value:1,
                    label:'或'
                },
                {
                    value:2,
                    label:'与'
                }
            ],     //检索范围的选项

            //--------------------------------多选项查询的变量---------------------------------//
            brand:'',
            restaurants:[],     //品牌的测试部分。。待删改
            Review:'',         //简介
            position:'',      //定位
            positionItems:[],  //定位的类型
            pickerOptions2: {
                shortcuts: [{
                    text: '最近一周',
                    onClick(picker) {
                        const end = new Date();
                        const start = new Date();
                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                        picker.$emit('pick', [start, end]);
                    }
                }, {
                    text: '最近一个月',
                    onClick(picker) {
                        const end = new Date();
                        const start = new Date();
                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                        picker.$emit('pick', [start, end]);
                    }
                }, {
                    text: '最近三个月',
                    onClick(picker) {
                        const end = new Date();
                        const start = new Date();
                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
                        picker.$emit('pick', [start, end]);
                    }
                }]
            },
            dateValue: '',
            lowerWeight:'',//重量（范围）
            higherWeight:'',//
            lowerSize:'',//屏幕尺寸
            higherSize:'',//
            lowerHD:'',//硬盘容量
            higherHD:'',//
            ram:'', //内存容量
            ramItems:[
                {
                    value:2,
                    label:'2G'
                },
                {
                    value:4,
                    label:'4G'
                },
                {
                    value:8,
                    label:'8G'
                },
                {
                    value:16,
                    label:'16G'
                },
                {
                    value:32,
                    label:'32G'
                }
            ],//选项
            type:'',//类型
            typeItems:[],//类型选项
            CPUType:'',//处理器类型
            CPUTypeItems:[],//选项
            GPUType:'',//显卡类型
            GPUTypeItems:[],//选项


            //------------------------------以下为-暂未用到的一些变量，但是加上了会变得好看0.0待删除---------------------------------------------//


            input3: '',
            input4: '',
            input5: '',
            value:'',
            testSelect:'',
            options: [
                {
                label:'A-label',
                value:1
                },
                {
                    label:'B-label',
                    value:2
                },
                {
                    label:'C-label',
                    value:3
                }
            ],
            testOptions:[
                {
                value:'test1'
            },
                {
                    value:'test2'
                },
            ]
        },

        mounted() {
            this.restaurants = this.loadAll();
            this.getAllCpu();
            this.getAllPositions();
            this.getAllType();
            //this.initBrand();  执行一次即可
            //this.initReview();
        },

        methods:{

            //执行一次，建立 品牌\描述 的倒排索引
            initBrand:function(){
                axios.post('${pageContext.request.contextPath}/initBrand').then(function(response){
                    if(response.data === true){
                        console.log(true);
                    }else {

                    }
                }).catch(function(error){
                    console.log(error);
                })
            },

            initReview:function(){
                axios.post('${pageContext.request.contextPath}/initReview').then(function(response){
                    if(response.data === true){
                        console.log(true);
                    }else {

                    }
                }).catch(function(error){
                    console.log(error);
                })
            },

            //简单查询实现
            simpleSearch:function(inputStaff){
                let vm = this;
                if(inputStaff===''){
                    axios.get('${pageContext.request.contextPath}/findAll').then(
                        function (response){
                            if(vm.oderRules === 1) {
                                if (vm.radioOrder === 3) {
                                    vm.productList = response.data.sort(function (a, b) {
                                        return a.good.goodPrice > b.good.goodPrice ? 1 : -1;
                                    });
                                } else if (vm.radioOrder === 6) {
                                    vm.productList = response.data.sort(function (a, b) {
                                        return a.good.goodPrice < b.good.goodPrice ? 1 : -1;
                                    });
                                } else {
                                    vm.productList = response.data
                                }
                            }else if(vm.oderRules === 2){
                                if (vm.radioOrder === 3) {
                                    vm.productList = response.data.sort(function (a, b) {
                                        return a.good.goodStock > b.good.goodStock? 1 : -1;
                                    });
                                } else if (vm.radioOrder === 6) {
                                    vm.productList = response.data.sort(function (a, b) {
                                        return a.good.goodStock < b.good.goodStock ? 1 : -1;
                                    });
                                } else {
                                    vm.productList = response.data
                                }
                            }else vm.productList = response.data
                            // for(let i=0;i<vm.productList.length;i++){
                            //     vm.productList[i].timeToMarket = vm.changeDateFormat(vm.productList[i].timeToMarket)
                            // }//对json 形式的时间进行转换  目前使用字符串类型 故不需要再进行转换
                           // console.log(vm.productList[0].good.goodImage);
                        }
                    ).catch(function(error){
                        console.log(error);
                    })
                }
                else{
                    if(vm.simpleSearchFirst === 1){
                        if(vm.simpleSearchSecond === 1){
                            if(vm.areaRule === 1){
                                axios.get('${pageContext.request.contextPath}/findByBrandFiled',{
                                    params: {
                                        filed: inputStaff
                                    }
                                }).then(
                                    function (response) {
                                        if(vm.oderRules === 1) {
                                            if (vm.radioOrder === 3) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodPrice > b.good.goodPrice ? 1 : -1;
                                                });
                                            } else if (vm.radioOrder === 6) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodPrice < b.good.goodPrice ? 1 : -1;
                                                });
                                            } else {
                                                vm.productList = response.data
                                            }
                                        }else if(vm.oderRules === 2){
                                            if (vm.radioOrder === 3) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodStock > b.good.goodStock? 1 : -1;
                                                });
                                            } else if (vm.radioOrder === 6) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodStock < b.good.goodStock ? 1 : -1;
                                                });
                                            } else {
                                                vm.productList = response.data
                                            }
                                        }else vm.productList = response.data
                                    }
                                ).catch(function(error){
                                    //console.log(error);
                                })
                            }else{
                                axios.get('${pageContext.request.contextPath}/findByBrandFiledAnd',{
                                    params: {
                                        filed: inputStaff
                                    }
                                }).then(
                                    function (response) {
                                        if(vm.oderRules === 1) {
                                            if (vm.radioOrder === 3) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodPrice > b.good.goodPrice ? 1 : -1;
                                                });
                                            } else if (vm.radioOrder === 6) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodPrice < b.good.goodPrice ? 1 : -1;
                                                });
                                            } else {
                                                vm.productList = response.data
                                            }
                                        }else if(vm.oderRules === 2){
                                            if (vm.radioOrder === 3) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodStock > b.good.goodStock? 1 : -1;
                                                });
                                            } else if (vm.radioOrder === 6) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodStock < b.good.goodStock ? 1 : -1;
                                                });
                                            } else {
                                                vm.productList = response.data
                                            }
                                        }else vm.productList = response.data
                                    }
                                ).catch(function(error){
                                    //console.log(error);
                                })
                            }
                        }else{
                            axios.get('${pageContext.request.contextPath}/findByGoodName',{
                                params:{
                                    goodName : inputStaff
                                }
                            }).then(function (response) {
                                if(vm.oderRules === 1) {
                                    if (vm.radioOrder === 3) {
                                        vm.productList = response.data.sort(function (a, b) {
                                            return a.good.goodPrice > b.good.goodPrice ? 1 : -1;
                                        });
                                    } else if (vm.radioOrder === 6) {
                                        vm.productList = response.data.sort(function (a, b) {
                                            return a.good.goodPrice < b.good.goodPrice ? 1 : -1;
                                        });
                                    } else {
                                        vm.productList = response.data
                                    }
                                }else if(vm.oderRules === 2){
                                    if (vm.radioOrder === 3) {
                                        vm.productList = response.data.sort(function (a, b) {
                                            return a.good.goodStock > b.good.goodStock? 1 : -1;
                                        });
                                    } else if (vm.radioOrder === 6) {
                                        vm.productList = response.data.sort(function (a, b) {
                                            return a.good.goodStock < b.good.goodStock ? 1 : -1;
                                        });
                                    } else {
                                        vm.productList = response.data
                                    }
                                }else vm.productList = response.data
                            }).catch(function (error) {
                                console.log(error);
                            })
                        }
                    }else if(vm.simpleSearchFirst === 2){
                        if(vm.simpleSearchSecond === 1){
                            vm.$message({
                                type:'info',
                                message:'请使用 -- 完全匹配 -- '
                            })
                        }else{
                            axios.get('${pageContext.request.contextPath}/findByProductDetailsId',
                                {
                                    params:{
                                        id: inputStaff
                                    }
                                }).then(function (response) {
                                if(vm.oderRules === 1) {
                                    if (vm.radioOrder === 3) {
                                        vm.productList = response.data.sort(function (a, b) {
                                            return a.good.goodPrice > b.good.goodPrice ? 1 : -1;
                                        });
                                    } else if (vm.radioOrder === 6) {
                                        vm.productList = response.data.sort(function (a, b) {
                                            return a.good.goodPrice < b.good.goodPrice ? 1 : -1;
                                        });
                                    } else {
                                        vm.productList = response.data
                                    }
                                }else if(vm.oderRules === 2){
                                    if (vm.radioOrder === 3) {
                                        vm.productList = response.data.sort(function (a, b) {
                                            return a.good.goodStock > b.good.goodStock? 1 : -1;
                                        });
                                    } else if (vm.radioOrder === 6) {
                                        vm.productList = response.data.sort(function (a, b) {
                                            return a.good.goodStock < b.good.goodStock ? 1 : -1;
                                        });
                                    } else {
                                        vm.productList = response.data
                                    }
                                }else vm.productList = response.data
                            }).catch(function (error) {
                                console.log(error);
                            })
                        }
                    }else if(vm.simpleSearchFirst === 3){
                        if(vm.simpleSearchSecond === 1){
                            if(vm.areaRule === 1){
                                axios.get('${pageContext.request.contextPath}/findByReviewFiled',{
                                    params: {
                                        filed: inputStaff
                                    }
                                }).then(
                                    function (response) {
                                        if(vm.oderRules === 1) {
                                            if (vm.radioOrder === 3) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodPrice > b.good.goodPrice ? 1 : -1;
                                                });
                                            } else if (vm.radioOrder === 6) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodPrice < b.good.goodPrice ? 1 : -1;
                                                });
                                            } else {
                                                vm.productList = response.data
                                            }
                                        }else if(vm.oderRules === 2){
                                            if (vm.radioOrder === 3) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodStock > b.good.goodStock? 1 : -1;
                                                });
                                            } else if (vm.radioOrder === 6) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodStock < b.good.goodStock ? 1 : -1;
                                                });
                                            } else {
                                                vm.productList = response.data
                                            }
                                        }else vm.productList = response.data
                                    }
                                ).catch(function(error){
                                    //console.log(error);
                                })
                            }else{
                                axios.get('${pageContext.request.contextPath}/findByReviewFiledAnd',{
                                    params: {
                                        filed: inputStaff
                                    }
                                }).then(
                                    function (response) {
                                        if(vm.oderRules === 1) {
                                            if (vm.radioOrder === 3) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodPrice > b.good.goodPrice ? 1 : -1;
                                                });
                                            } else if (vm.radioOrder === 6) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodPrice < b.good.goodPrice ? 1 : -1;
                                                });
                                            } else {
                                                vm.productList = response.data
                                            }
                                        }else if(vm.oderRules === 2){
                                            if (vm.radioOrder === 3) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodStock > b.good.goodStock? 1 : -1;
                                                });
                                            } else if (vm.radioOrder === 6) {
                                                vm.productList = response.data.sort(function (a, b) {
                                                    return a.good.goodStock < b.good.goodStock ? 1 : -1;
                                                });
                                            } else {
                                                vm.productList = response.data
                                            }
                                        }else vm.productList = response.data
                                    }
                                ).catch(function(error){
                                    //console.log(error);
                                })
                            }
                        }else{
                            vm.$message({
                                type:'info',
                                message:'请使用 -- 关键字匹配 -- '
                            })
                        }
                    }
                }

            },

            //多条件选择实现
            multiConditionSearch:function(){

            },
            //重置选择条件
            resetOptions:function(){
                this.brand=null;
                this.Review=null;
                this.lowerWeight=null;
                this.higherWeight=null;
                this.type=null;
                this.position=null;
                this.dateValue=null;
                this.higherSize=null;
                this.lowerSize=null;
                this.ram=null;
                this.CPUType=null;
                this.GPUType=null;
                this.higherHD=null;
                this.lowerHD=null;
            },
            //显示更多条件
            moreConditions:function(){
                this.condition = this.condition === false;
            },

//---------------------------------------以下全是自动补全的实现-----------------------------------------------------//
            loadAll:function() {
                return [
                    { "value": "联想", "address": "联想" },
                    { "value": "惠普", "address": "惠普" },
                    { "value": "华为", "address": "华为" },
                    { "value": "苹果", "address": "苹果" },
                    { "value": "雷神", "address": "雷神" },
                    { "value": "外星人", "address": "外星人" },
                    { "value": "msi", "address": "msi" },
                    { "value": "戴尔", "address": "戴尔" },
                    { "value": "微软", "address": "微软" },
                    { "value": "华硕", "address": "华硕" },
                    { "value": "小米", "address": "小米" },
                    { "value": "台电", "address": "台电" },
                ];
            },
            querySearchAsync:function(queryString, cb) {
                let restaurants = this.restaurants;
                let results = queryString ? restaurants.filter(this.createStateFilter(queryString)) : restaurants;

                clearTimeout(this.timeout);
                this.timeout = setTimeout(() => {
                    cb(results);
            }, 3000 * Math.random());
            },
            createStateFilter:function(queryString) {
                return (state) => {
                    return (state.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
                };
            },
            handleSelect:function(item) {
                console.log(item);
            },
//---------------------------------------------------------------------------------------------------------------------//
            gotoHttp:function(){
              window.location = "http://"+this.input3;
            },

            getAllCpu(){
                let vm=this;
                axios.get('${pageContext.request.contextPath}/findAllCpu').then(
                    function(response){
                        vm.CPUTypeItems = response.data;
                        console.log(response);
                    }
                ).catch(function(error){
                    console.log(error);
                })
            },

            getAllType(){
                let vm=this;
                axios.get('${pageContext.request.contextPath}/findAllType').then(
                    function(response){
                        vm.typeItems=response.data;
                    }
                ).catch(function(error){
                    console.log(error);
                })
            },

            getAllPositions(){
                let vm=this;
                axios.get('${pageContext.request.contextPath}/findAllPosition').then(
                    function(response){
                        vm.positionItems=response.data;
                    }
                ).catch(function(error){
                    console.log(error);
                })
            },


            //转换日期格式

            changeDateFormat:function (cellval) {
                if (cellval!=null) {
                    var date = new Date(parseInt(cellval.replace("/Date(", "").replace(")/", ""), 10)).toLocaleString();
                    return date;
                }
            }
    },
        components:{

        }
    })
</script>
<style>
    hr.myStyle {
        border: 0;
        height: 1px;
        background-image: linear-gradient(to right, rgba(192, 192, 192, 0.1), rgba(192, 192, 192, 0.75), rgba(192, 192, 192, 0.1));
    }

    .time {
        font-size: 13px;
        color: #999;
    }

    .bottom {
        margin-top: 13px;
        line-height: 12px;
    }

    .button {
        padding: 0;
        float: right;
    }

    .image {
        width: 100%;
        display: block;
    }

    .clearfix:before,
    .clearfix:after {
        display: table;
        content: "";
    }

    .clearfix:after {
        clear: both
    }

    .demo-table-expand {
        font-size: 0;
    }
    .demo-table-expand label {
        width: 90px;
        color: #99a9bf;
    }
    .demo-table-expand .el-form-item {
        margin-right: 0;
        margin-bottom: 0;
        width: 50%;
    }
</style>
