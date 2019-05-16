
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String path=request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%>
<html>
<head>
    <title>一览无余</title>
    <script src="<%=basePath%>JS/function.js" charset="UTF-8"></script>
    <script type="text/javascript" src="<%=basePath%>jquery-easyui-1.7.6/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>jquery-easyui-1.7.6/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>jquery-easyui-1.7.6/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>jquery-easyui-1.7.6/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>jquery-easyui-1.7.6/themes/default/easyui.css">

    <style type="text/css">
       th{
            font-size: 20px;
           color: blue;
        }
        body{
            background: url("/denglu.jpg");
        }
    </style>
</head>
<body><div align="center">
        <table id="Herotable" title="超级英雄" class="easyui-datagrid" style="width:800px" toolbar="#toolbar">
            <thead align="center">
            <tr>
                <th field="id" align="center" width="50">英雄ID</th>
                <th field="name" align="center" width="50">英雄绰号</th>
                <th field="money" align="center" width="50">英雄财富</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar">
            <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newHero()">新增英雄</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editHero()">编辑英雄</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteHero()">删除英雄</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="transf()">英雄交易</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="find()">英雄查询</a>
            <label style="font-size: 15px;color: blueviolet">ID:</label>
            <input id="findid" style="height: 20px;width:50px;padding-bottom: 5px;border-radius:5px;border:1px solid green" type="text" />
            <label  style="font-size: 15px;color: blueviolet">Name:</label>
            <select id="findname" style="height: 25px;width:100px;border-radius:10px;border:1px solid green" class="easyui-combobox">
             <option>侠</option>
            <option>队长</option>
            <option>人</option>
            <option>神</option>
            </select>
            <a href="/app/allHero" class="easyui-linkbutton" iconCls="icon-reload" plain="true">显示全部</a>
        </div>
    <%--创建表单对话框用于编辑和新增--%>
    <div id="dialog" class="easyui-dialog" style="width:420px;height:250px;padding:10px 20px"
         closed="true" buttons="#dlg-buttons">
        <form id="fm" method="post">
            <div class="fitem">
                <label>英雄代号:</label>
                <input name="id" id="id" class="easyui-validatebox" required="true">
            </div><br>
            <div class="fitem">
                <label>英雄绰号:</label>
                <input id="name"  name="name" class="easyui-validatebox" required="true">
            </div><br>
            <div class="fitem">
                <label>财富指数:</label>
                <input id="money" name="money" class="easyui-validatebox" required="true"><br>
            </div><br>
        </form>
        <div id="dlg-buttons">
            <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveHero()">保存</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dialog').dialog('close')">取消</a>
        </div>
    </div>
    <%--交易对话框--%>
    <div id="transdialog" align="center" class="easyui-dialog" style="width:480px;height:280px;padding:10px 20px;top: 200px;"
         closed="true" buttons="#transButton">
        <table align="center">
            <tr><td height="50">转账人ID</td><td><input id="idA" name="idA" class="easyui-textbox"></td></tr>
            <tr><td height="50">收账人ID</td><td><input id="idB" name="idB" class="easyui-textbox"></td></tr>
            <tr><td height="50">转账金额</td><td><input id="moneyA" name="moneyA" class="easyui-textbox"></td></tr>
            <tr><td height="100px" width="480px"><a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="transfer()" id="transButton" >转账</a></td></tr>
        </table>
    </div>
</div>
<script>
    <%--给数据网格添加分页操作，这里用的假分页，后台的的分页功能没用到--%>
    $("#Herotable").datagrid({loadFilter:pagerFilter}).datagrid({
        url:"allA",
        fitColumns:"true",//自适应宽度
        rownumbers:"true",
        singleSelect:"true",
        pagination:true

    });

    function pagerFilter(data) {
        if (typeof data.length == 'number' && typeof data.splice == 'function') {
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            pageList:[5,10,15,20],
            onSelectPage: function (pageNum, pageSize) {
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh', {
                    pageNumber: pageNum,
                    pageSize: pageSize
                });
                dg.datagrid('loadData', data);
            }
        });
        if (!data.originalRows) {
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }
</script>
</body>
</html>
