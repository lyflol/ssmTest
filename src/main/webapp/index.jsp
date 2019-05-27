<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<% String path=request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%>
<html>
<head>
    <script src="<%=basePath%>JS/function.js" charset="UTF-8"></script>
    <script type="text/javascript" src="<%=basePath%>jquery-easyui-1.7.6/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>jquery-easyui-1.7.6/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>jquery-easyui-1.7.6/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>jquery-easyui-1.7.6/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>jquery-easyui-1.7.6/themes/default/easyui.css">

    <style type="text/css">
        div{
            font-size: 40px;
            color: brown;
            margin-left: auto;
            margin-right: auto;
        }
        .p{
            font-size: 20px;
            color: blue;
        }


    </style>
</head>
<body>
<%--注意把dialog和进入按钮放到同一个div标签里--%>
<div align="center">
<h2>欢迎来到漫威宇宙!</h2>
    <button id="enter" class="p" onclick="den()">点击进入</button>

<div id="denglu" align="center" class="easyui-dialog" style="width:410px;height:250px;padding:10px 10px; top:150px; left:470px;"
      closed="true" buttons="#denglu-buttons">
    <table align="center">
        <tr style="height: 50px"><td>用户名：</td><td><input name="username" id="username" class="easyui-textbox" required="true"></td></tr>
        <tr style="height: 50px"><td>密码</td><td><input name="password" id="password" class="easyui-passwordbox" required="true"></td></tr>
        <tr style="height: 50px"><td align="left"> <a href="#" class="easyui-linkbutton" iconCls="icon-back" onclick="denglu()">登录</a></td>
         <td td align="right"><a href="#" class="easyui-linkbutton" iconCls="icon-lock" onclick="zhuce()">注册</a></td></tr>
    </table>
</div>

    <%--注册对话框--%>
    <div id="zhuce" align="center" class="easyui-dialog" style="width:530px;height:320px;padding:10px 10px; top:150px; left:450px;"
         closed="true" buttons="#zhuceA">
        <div class="fitem">
            <label style="font-size: 19px">用&nbsp&nbsp户&nbsp名：</label>
            <input name="username" id="usernameA" class="easyui-textbox" required="true" >
        </div>
        <div class="fitem">
            <label style="font-size: 20px">密&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp码：</label>
            <input name="password" id="passwordA" class="easyui-passwordbox" required="true">
        </div>
        <div class="fitem">
            <label style="font-size: 20px">确认密码：</label>
            <input name="password" id="passwordB" class="easyui-passwordbox" required="true">
        </div>
        <div id="zhuceA">
            <a href="#" class="easyui-linkbutton" iconCls="icon-lock" onclick="zhuceA()">注册</a>
        </div>
    </div>
</div>
</body>
</html>
