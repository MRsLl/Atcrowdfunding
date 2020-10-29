<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@include file="/WEB-INF/common/css.jsp" %>

    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }

        table tbody tr:nth-child(odd) {
            background: #F4F4F4;
        }

        table tbody td:nth-child(even) {
            color: #C00;
        }
    </style>
</head>

<body>

<%@include file="/WEB-INF/common/nav.jsp" %>

<div class="container-fluid">
    <div class="row">
        <%--静态包含侧边栏菜单--%>
        <%@include file="/WEB-INF/common/side.jsp" %>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form id="queryForm" class="form-inline" role="form" style="float:left;"
                          action="${appPath}/admin/index" method="post">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input name="keyWord" value="${param.keyWord}" class="form-control has-success"
                                       type="text"
                                       placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning" onclick="$('#queryForm').submit()"><i
                                class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>

                    <button id="deleteBatch" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i
                            class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;"
                            onclick="window.location.href='${appPath}/admin/toAdd'"><i
                            class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input id="checkAllAdmins" type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody id="adminBody">
                            <c:forEach items="${pageInfo.list}" var="tAdmin" varStatus="state">
                                <tr>
                                    <td>${state.count}</td>
                                    <td><input id="${tAdmin.id}" type="checkbox" class="adminCheck"></td>
                                    <td>${tAdmin.loginacct}</td>
                                    <td>${tAdmin.username}</td>
                                    <td>${tAdmin.email}</td>
                                    <td>
                                        <button type="button" class="btn btn-success btn-xs"
                                                onclick="location.href='${appPath}/admin/toEdit?pageNum=${pageInfo.pageNum}&id=${tAdmin.id}'">
                                            <i class=" glyphicon glyphicon-check"></i></button>
                                        <button type="button" class="btn btn-primary btn-xs"
                                            <%--onclick="location.href='${appPath}/admin/toEdit?id=${tAdmin.id}&pageNum=${pageInfo.pageNum}'"--%>
                                                onclick="location.href='${appPath}/admin/toEdit?pageNum=${pageInfo.pageNum}&id=${tAdmin.id}'">
                                            <i class=" glyphicon glyphicon-pencil"></i></button>
                                        <button type="button" class="btn btn-danger btn-xs"
                                                onclick="location.href='${appPath}/admin/delete?id=${tAdmin.id}'"><i
                                                class=" glyphicon glyphicon-remove"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>

                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <c:if test="${pageInfo.isFirstPage}">
                                            <li class="disabled"><a href="#">上一页</a></li>
                                        </c:if>
                                        <c:if test="${not pageInfo.isFirstPage}">
                                            <li>
                                                <a href="${appPath}/admin/index?keyWord=${param.keyWord}&pageNum=${pageInfo.pageNum-1}">上一页</a>
                                            </li>
                                        </c:if>

                                        <c:forEach items="${pageInfo.navigatepageNums}" var="i">
                                            <c:if test="${pageInfo.pageNum == i}">
                                                <li class="active"><a
                                                        href="${appPath}/admin/index?keyWord=${param.keyWord}&pageNum=${i}">${i}<span
                                                        class="sr-only">(current)</span></a></li>
                                            </c:if>

                                            <c:if test="${pageInfo.pageNum != i}">
                                                <li>
                                                    <a href="${appPath}/admin/index?keyWord=${param.keyWord}&pageNum=${i}">${i}<span
                                                            class="sr-only">(current)</span></a></li>
                                            </c:if>
                                        </c:forEach>

                                        <c:if test="${pageInfo.isLastPage}">
                                            <li class="disabled"><a href="#">下一页</a></li>
                                        </c:if>
                                        <c:if test="${not pageInfo.isLastPage}">
                                            <li>
                                                <a href="${appPath}/admin/index?keyWord=${param.keyWord}&pageNum=${pageInfo.pageNum+1}">下一页</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/common/js.jsp" %>

<script src="${appPath}/static/layer/layer.js"></script>

<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function () {
            if ($(this).find("ul")) {
                $(this).toggleClass("tree-closed");
                if ($(this).hasClass("tree-closed")) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

    //总复选框选中后全选所有子复选框
    $("#checkAllAdmins").click(function () {
        var checkBoxs = $("#adminBody .adminCheck");
        $.each(checkBoxs, function (i, check) {
            check.checked = $("#checkAllAdmins")[0].checked;
        });
    });

    //批量删除且有弹层提示
    $("#deleteBatch").click(function (){
        var adminCheckedBoxs = $(".adminCheck:checked");
        var ids = new Array();
        if (adminCheckedBoxs.length == 0) {
            layer.msg("没有选中要删除的选项!!", {time: 2000, icon: 5, shift: 6});
        } else {
            layer.confirm("你确定要删除么",{btn:["确定","取消"]},
            function() {
                for (var i = 0;i < adminCheckedBoxs.length;i++) {
                    var id = $(adminCheckedBoxs[i]).attr("id");
                    ids.push(id);
                }
                location.href = "${appPath}/admin/deleteBatch?ids=" + ids;
            },
            function() {
                layer.alert("取消删除");
            });
        }
    });
</script>
</body>
</html>