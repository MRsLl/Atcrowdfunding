<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%--静态包含样式页面--%>
    <%@include file="/WEB-INF/common/css.jsp"%>
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        .tree-closed {
            height : 40px;
        }
        .tree-expanded {
            height : auto;
        }
    </style>
</head>

<body>

<%--静态包含头部页面--%>
<%@include file="/WEB-INF/common/nav.jsp"%>

<div class="container-fluid">
    <div class="row">

        <%--静态包含侧边控制栏--%>
        <%--<jsp:include page="/WEB-INF/common/side.jsp"/>--%>
            <%@include file="/WEB-INF/common/side.jsp"%>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">你没有权限访问${err}</h1>
        </div>
    </div>
</div>

<%--静态包含js资源--%>
<%@include file="/WEB-INF/common/js.jsp"%>
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