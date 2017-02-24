<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<form name="bhForm" id="bhForm">
    <table class="table-container table table-hover  table-striped" id="bgpz_table">
        <thead>
        <tr>
            <th data-align="center">表格代码</th>
            <th data-align="center">表格名称</th>
            <th data-align="center">查询条件</th>
            <th data-align="center">记录状态</th>
            <th data-align="center">表格类型</th>
            <th data-align="center">填报表名称</th>
            <th data-align="center">访问URL</th>
            <th data-align="center">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${bgpzList}" var="item" varStatus="sta">
            <tr>
                <td>
                    <input type="hidden" name="delbgdm" value="${item['BGDM'] }"/>
                    <a onclick="showBg('${item['BGDM'] }');return false;">${item['BGDM'] }</a>
                </td>
                <td>${item['BGMC'] }</td>
                <td>
                    <c:if test="${item['CXTJXS']  == '0' }">
                        显示
                    </c:if>
                    <c:if test="${item['CXTJXS']  == '1' }">
                        隐藏
                    </c:if>
                </td>
                <td>
                    <c:if test="${item['JLZT'] == '0' }">
                        启用
                    </c:if>
                    <c:if test="${item['JLZT'] == '1' }">
                        停用
                    </c:if>
                </td>
                <td>
                    <c:if test="${item['BGLX'] == '0' }">
                        查询
                    </c:if>
                    <c:if test="${item['BGLX'] == '1' }">
                        填报
                    </c:if>
                </td>
                <td>${item['TBBMC'] }</td>
                <td>${item['URL'] }</td>
                <td>
                    <button class="btn btn-default btn-xs" onclick="preview('${item['URL'] }');return false;">预览
                    </button>
                    <button id="btn_xg" class="btn btn-default btn-xs"
                            onclick="updateBg('${item['BGDM'] }');return false;">修改配置
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <input type="hidden" id="bgpzListId" value="${page.recordCount }"/>
    <input type="hidden" id="selfbgdm" value=""/>
</form>
