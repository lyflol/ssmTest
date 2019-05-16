//打开登陆窗口
function  den() {
    $("#denglu").dialog("open").dialog("setTitle","请登录");
}
//登录按钮功能实现
function denglu() {
    var username=$("#username").val();//获取用户名
    var password=$("#password").val();//获取密码
    if(username=="" || password==""){
        $.messager.show({
            height:"300px",
            title:"登录提醒",
            msg:"用户名和密码不能为空！"
        });
    }else{
        $.ajax({
            type:'post',
            url:'app/checklogin',
            dataType:"json",//注意使用的是打他dataType，而不是Content-Type
            async: true,
            data:{"username":username,"password":password},
            success:function(data){
                var str=data.result;
                if(str=="failA"){
                    alert("没有这个用户!");
                }else if(str=="failB"){
                    alert(password+" 密码错误");
                }
                else{
                    alert("身份验证通过..")
                    window.location.href ="/app/allHero";
                }
            }
        });

    }
}

//注册按钮打开注册对话窗口
function zhuce(){
    $("#denglu").dialog("close");
    $("#zhuce").dialog("open").dialog("setTitle","开始注册");
}
//注册业务交由控制层，并处理一些小业务，如验证账号密码为空，两次密码不一致等问题
function zhuceA(){
    var usernameA= $("#usernameA").val();
    var passwordA=$("#passwordA").val();
    var passwordB=$("#passwordB").val();
    if(passwordA==""||passwordB=="" || usernameA==null){
        $.messager.show({
            height:"300px",
            title:"请检查",
            msg:"用户名或密码均不能为空！"
        });
    }else if(passwordA!=passwordB){
        $.messager.show({
            height:"300px",
            title:"注册提醒",
            msg:"两次输入密码不一致！"
        });
    }
    else{
        $.ajax({
            type:"post",
            url:"app/checkZhuce",
            dataType:"json",
            data:{"username":usernameA,"password":passwordA},
            async:true,
            success:function(data) {
                var str=data.result;
                if(str=="yes"){
                    alert("注册成功！");
                }else{
                    alert("用户名已存在！");
                }
            },
            error:function () {
                alert("未知错误");
            }
        });
    }
}

//模糊查询，id name动态sql拼接
function find(){
    var id=$("#findid").val();
    var name=$("#findname").val();
    $("#Herotable").datagrid({
        queryParams:{"id":id,"name":name},
        url:"find",
    });
}
//新增
function newHero() {
    $("#dialog").dialog("open").dialog("setTitle","添加新英雄");
    $("#fm").form("clear");
    url="insert";

}
//修改  与新增公用一个对话窗口 下方
function editHero() {
    var row=$("#Herotable").datagrid("getSelected");
    if(row){
        $.messager.confirm({width: 380,
            height: 160,title:"提示",msg:"你确定要修改这个超级英雄吗？",fn:function(yes){
                if(yes){
                    var id=row.id;var name=row.name;var money=row.money;
                    $("#id").val(id); $("#name").val(name); $("#money").val(money);
                    $("#id").attr("disabled","disabled");//设置个id不可编辑
                    $("#dialog").dialog("open").dialog("setTitle","修改英雄");
                    url="update";
                }
            }});
    }
}
//新增和修改时共有的对话窗口
function saveHero() {
    var id=$("#id").val();
    var name=$("#name").val();
    var money=$("#money").val();
    $.ajax({
        type:'post',
        url:url,
        dataType:"json",
        async: true,//异步加载
        data:{"id":id,"name":name,"money":money},
        success:function(data){
            var str=data.result;
            if(str=="fail"){
                $.messager.show({
                    height:"300px",
                    title:"错误",
                    msg:"保存失败"
                });
            }
            else{
                $.messager.show({
                    height:"300px",
                  title:"成功",
                  msg:"保存成功"
                });
                $('#dialog').dialog('close');
                $('#Herotable').datagrid('reload');
            }
        }
    });
    //乱码的方法，放弃了
    // $('#fm').form('submit',{
    //     url:url,
    //     onSubmit:function(){
    //         return $(this).form('validate');
    //     },
    //     success:function(result){
    //         var result=eval('('+result+')');
    //         if(result.boo){
    //             $.messager.alert("系统提示",result.boo);
    //             return;
    //         }else{
    //             $.messager.alert("系统提示","保存成功");
    //             $('#dialog').dialog('close');
    //             $("#Herotable").datagrid("reload");
    //         }
    //     }
    // });

}
//删除
function deleteHero() {
    var row=$("#Herotable").datagrid("getSelected");
    if(row){
        $.messager.confirm("提示","你确定要删除这个超级英雄吗？",function (yes) {
            if (yes) {
                $.post('delete', {id: row.id},function (status) {
                    if (status.result=="success") {
                        $.messager.show({
                            height:"300px",
                            title:"成功",
                            msg:"删除成功"
                        });
                        $("#Herotable").datagrid('reload');    // reload the user data
                    } else {
                        $.messager.show({    // show error message
                            height:"300px",
                            title: 'Error',
                            msg: "删除失败"
                        });
                    }
                }, 'json');
            }
        })
    }
}

//转账操作先打开转账界面
function transf() {
    $("#transdialog").dialog("open").dialog("setTitle","添加新英雄");
    url="transf";
}
function transfer() {
    var idA=$("#idA").val();
    var idB=$("#idB").val();
    var moneyA=$("#moneyA").val();

    $.ajax({
        type:"post",
        url:url,
        dataType:"json",
        async:true,
        data:{"idA":idA,"idB":idB,"moneyA":moneyA},
        success:function (data) {
            if(data.result=="success"){
                $.messager.show({
                    height:"300px",
                    title:"转账提示！",
                    msg:"您的转账交易已成功"
                });
                $("#Herotable").datagrid("reload");
            }else{
                $.messager.show({
                    height:"300px",
                    title:"转账提示！",
                    msg:"转账失败"
                });
            }
        }

    });
}


