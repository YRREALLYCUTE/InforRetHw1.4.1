<%--
  Created by IntelliJ IDEA.
  User: 该读过
  Date: 2018/10/12
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>test_vue_element</title>
    <meta charset="UTF-8">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../node_modules/element-ui/lib/theme-chalk/index.css">
    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
</head>
<body>
<div id="app">
    <el-card style="margin-left: 4%;margin-right: 4%">
<div>
    <el-input placeholder="请输入内容" v-model="input3">
        <template slot="prepend">Http://</template>
    </el-input>
</div>
<div style="margin-top: 15px;">
    <el-input placeholder="请输入内容" v-model="input4">
        <template slot="append">.com</template>
    </el-input>
</div>
<div style="margin-top: 15px;">
    <el-input placeholder="请输入内容" v-model="input5" class="input-with-select">
        <el-select v-model="select" slot="prepend" placeholder="请选择">
            <el-option v-for="item in selectOptions"
                       :key="item.id"
                       :label="item.userName"
                       :value="item.id"
            ></el-option>
        </el-select>
        <el-button slot="append" icon="el-icon-search"></el-button>
    </el-input>

    <el-select v-model="test" placeholder="选择">
        <el-option
        v-for="item in selectOptions"
        :key="item.id"
        :label="item.userName"
        :value="item.id">
        </el-option>
    </el-select>
    <span >{{test_jiajia}}</span>
</div>
    </el-card>
</div>
</body>

</html>
<!-- import Vue before Element -->
<script src="../node_modules/vue/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="../node_modules/element-ui/lib/index.js"></script>

<script src="../node_modules/axios/dist/axios.min.js"></script>
<script>
    new Vue({
        el:'#app',
        data: {
            input3: '',
            input4: '',
            input5: '',
            select: '',
            test:'',
            test_jiajia:1,
            selectOptions:[{
                id:'0',
                userName:'0',
                userId:'0'
            }]
        },
        mounted(){
            this.getSelectOptions()
        },
        methods:{
            getSelectOptions:function(){
                var vm = this;
/*                this.test_jiajia++;
                let temp = null;
                $.ajax({
                    url: "/test",
                    type: "get",
                    dateType: "json",
                    success(result) {
                        console.log(result.length);
                        //this.selectOptions = result;
                        //temp=result;
                        //console.log(temp[0].id)
                    }
                });
                this.selectOptions=temp;
                console.log(this.selectOptions[0].id)*/

                axios.get('${pageContext.request.contextPath}/test')
                    .then(function (response){
                        vm.selectOptions=response.data;
                        console.log(vm.selectOptions[0].id);
                        console.log(response);
                }).catch(function(error){
                    console.log(error);
                })
            }
        }
    })
</script>