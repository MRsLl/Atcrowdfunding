<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <jsp:include page="/WEB-INF/common/css.jsp"></jsp:include>
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

        a:hover {
            cursor: pointer
        }
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/common/nav.jsp"></jsp:include>

<div class="container-fluid">

    <div class="row">
        <jsp:include page="/WEB-INF/common/side.jsp"></jsp:include>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="roleName" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="btnSearch" type="button" class="btn btn-warning"><i
                                class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <%--权限框架控制页面元素显示--%>
                    <sec:authorize access="hasRole('TL - 组长')">
                    <button type="button" id="deleteBatchButton" class="btn btn-danger"
                            style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button id="roleSaveButton" type="button" class="btn btn-primary" style="float:right;"><i
                            class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    </sec:authorize>

                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input id="checkAll" type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody id="roleBody">
                            <%--异步获取角色数据--%>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <%--异步显示分页数据--%>
                                    <ul class="pagination">

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

    <!-- 隐藏的模态框 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="exampleInputPassword2">角色名称</label>
                        <input name="name" type="text" class="form-control" id="exampleInputPassword2"
                               placeholder="请输入用户名称">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button id="btnAdd" type="button" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/common/js.jsp"></jsp:include>
<%--导入layer 弹层的js文件--%>
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

        loadData(1);//页面加载完成，发送异步请求获取角色数据和分页数据
    });

    var keyWord = "";//查询的条件

    //从后台获取角色数据和
    function loadData(pageNum) {
        $("#checkAll").attr("checked", false);
        $.getJSON("${appPath}/role/loadData", {
            "pageNum": pageNum,
            "pageSize": 2,
            "keyWord": keyWord
        }, function (pageInfo) {
            if (pageInfo == "403") {
                layer.msg("没有权限查询",{"time":1000,"shift":3});
            } else {
                showRole(pageInfo.list);
                showPage(pageInfo);
            }
        })
    }

    //在页面上异步显示角色数据
    function showRole(pageList) {
        var content = "";
        for (var i = 0; i < pageList.length; i++) {
            content += '<tr>';
            content += '	<td> ' + (i + 1) + '</td>';
            content += '	<td><input idStr="' + (pageList[i].id) + '" class="roleCheck" type="checkbox"></td>';
            content += '  <td>' + (pageList[i].name) + '</td>';
            content += '  <td>';
            content += '  	<button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
            content += '      <button type="button" class="btn btn-primary btn-xs" onclick="getRoleById(' + (pageList[i].id) + ')"><i class=" glyphicon glyphicon-pencil"></i></button>';
            content += '      <button id="btnDelete" type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
            content += '  </td>';
            content += '</tr>';
        }

        $("#roleBody").html(content);
    }

    //在页面上异步显示分页数据
    function showPage(pageInfo) {
        var content = "";

        if (pageInfo.isFirstPage) {
            content += '		<li class="disabled"><a href="#">上一页</a></li>';
        } else {
            content += '		<li><a onclick="loadData(' + (pageInfo.pageNum - 1) + ')">上一页</a></li>';
        }

        for (var i = 0; i < pageInfo.navigatepageNums.length; i++) {
            if (pageInfo.pageNum == pageInfo.navigatepageNums[i]) {
                content += '		<li class="active"><a onclick="loadData(' + pageInfo.navigatepageNums[i] + ')">' + pageInfo.navigatepageNums[i] + '<span class="sr-only">(current)</span></a></li>';
            } else {
                content += '		<li><a onclick="loadData(' + pageInfo.navigatepageNums[i] + ')">' + pageInfo.navigatepageNums[i] + '<span class="sr-only">(current)</span></a></li>';

            }
        }

        if (pageInfo.isLastPage) {
            content += '		<li class="disabled"><a href="#">下一页</a></li>';
        } else {
            content += '		<li><a onclick="loadData(' + (pageInfo.pageNum + 1) + ')">下一页</a></li>';
        }

        $(".pagination").html(content);
    }

    //点击搜索按钮后搜索角色并返回
    $("#btnSearch").click(function () {
        keyWord = $("#roleName").val();
        loadData(1);
    });

    //弹出增加角色的模态框
    $("#roleSaveButton").click(function () {
        $("input[name='name']").val("");
        $("input[name='name']").attr("idStr", "");

        $('#myModal').modal({
            show: true,
            backdrop: 'static',
            keyboard: true
        });
        $("#myModalLabel").text("添加");
    });

    //弹出修改角色的模态框并回显要修改的角色信息
    function getRoleById(id) {
        $.getJSON("${appPath}/role/getRoleById?id=" + id, null, function (role) {
            $("#myModalLabel").text("修改");
            //给模态框内的name 输入框添加值为返回的角色 id 的属性 idStr
            $("input[name = 'name']").attr("idStr", role.id);
            //在模态框内的name 输入框中回显角色的 name
            $("input[name = 'name']").val(role.name);
            $('#myModal').modal({
                show: true,
                backdrop: 'static',
                keyboard: true
            });
        });
    };

    //点击模态框内的保存按钮后保存角色（添加/修改）并返回信息
    $("#btnAdd").click(function () {
        //获取name 输入框的输入值
        var name = $("input[name='name']").val();
        //获取name 输入框的 idStr 属性值
        var id = $("input[name='name']").attr("idStr");

        //id 为空证明是添加角色操作
        if (id == "" || id == null) {
            $.post("${appPath}/role/add", {"name": name}, function (res) {
                if (res == "yes") {
                    layer.msg("添加成功", {time: 1000, icon: 6}, function () {
                        $("#myModal").modal("hide");//隐藏模态框
                        loadData(10000000);//重新查询最新添加的数据
                    });
                } else {
                    layer.msg("添加失败");
                }
            });
        } else {
            //id 不为空证明是修改角色操作
            $.post("${appPath}/role/update", {"id": id, "name": name}, function (res) {
                if (res == "yes") {
                    layer.msg("修改成功", {time: 1000, icon: 6}, function () {
                        $("#myModal").modal("hide");//隐藏模态框
                        loadData(1);//重新查询最新添加的数据
                    });
                } else {
                    layer.msg("修改失败");
                }
            });
        }
    });

    //总复选框选中后全选所有子复选框
    $("#checkAll").click(function () {
        var checkBoxs = $("#roleBody .roleCheck");
        $.each(checkBoxs, function (i, check) {
            check.checked = $("#checkAll")[0].checked;
        });
    });

    //实现批量删除选中角色记录的功能
    $("#deleteBatchButton").click(function () {
        var checkBoxs = $("#roleBody .roleCheck:checked");
        var ids = new Array();
        for (var i = 0; i < checkBoxs.length; i++) {
            var id = $(checkBoxs[i]).attr("idStr");
            ids.push(id);
        }
        layer.confirm("你确定要删除么", {btn: ["确定", "取消"]}, function () {
            $.get("${appPath}/role/deleteBatch?idStr=" + ids, null,
                //确定
                function (res) {
                    if (res == "yes") {
                        layer.msg("删除成功");
                        $("#checkAll").attr("checked", false);
                        loadData(1);
                    } else {
                        layer.msg("删除失败");
                    }
                });
        }), //取消
            function () {

            }

    });
</script>
</body>
</html>
