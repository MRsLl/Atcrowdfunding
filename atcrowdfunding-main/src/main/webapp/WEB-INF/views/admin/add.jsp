<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <%--动态包含css样式页面--%>
    <jsp:include page="/WEB-INF/common/css.jsp"></jsp:include>

    <link rel="stylesheet" href="${appPath}/static/css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>
<%--动态包含顶部导航菜单--%>
<jsp:include page="/WEB-INF/common/nav.jsp"></jsp:include>

<div class="container-fluid">
    <div class="row">

        <%--动态包含侧边菜单--%>
        <jsp:include page="/WEB-INF/common/side.jsp"></jsp:include>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form role="form" method="post" action="${appPath}/admin/add" id="form">
                        <div class="form-group">
                            <label for="exampleInputPassword1">登陆账号</label>
                            <input name="loginacct" type="text" class="form-control" id="exampleInputPassword1" placeholder="请输入登陆账号">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword2">用户名称</label>
                            <input name="username" type="text" class="form-control" id="exampleInputPassword2" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">邮箱地址</label>
                            <input name="email" type="email" class="form-control" id="exampleInputEmail1" placeholder="请输入邮箱地址">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <button type="button" class="btn btn-success" onclick="$('#form').submit()"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                        <button type="button" class="btn btn-danger" onclick="$('#queryForm').submit()"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%--动态包含js页面--%>
<jsp:include page="/WEB-INF/common/js.jsp"></jsp:include>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });
</script>
</body>
</html>