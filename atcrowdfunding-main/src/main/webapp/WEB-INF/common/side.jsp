<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="col-sm-3 col-md-2 sidebar">
    <div class="tree">

        <ul style="padding-left:0px;" class="list-group">
            <c:forEach items="${sessionScope.tMenus}" var="tMenu">
                <%--没有子菜单的父菜单样式--%>
                <c:if test="${empty tMenu.childMenus}">
                    <li class="list-group-item tree-closed" >
                        <a href="${appPath}/${tMenu.url}"><i class="${tMenu.icon}"></i>${tMenu.name}</a>
                    </li>
                </c:if>
                <%--有子菜单的父菜单样式--%>
                <c:if test="${not empty tMenu.childMenus}">
                    <li class="list-group-item tree-closed" >
                        <span><i class="${tMenu.icon}"></i> ${tMenu.name} <span class="badge" style="float:right">${tMenu.childMenus.size()}</span></span>
                        <ul style="margin-top:10px;display:none;">
                            <c:forEach items="${tMenu.childMenus}" var="childMenu">
                                <li style="height:30px;">
                                    <a href="${appPath}/${childMenu.url}"><i class="${childMenu.icon}"></i> ${childMenu.name}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
</div>


