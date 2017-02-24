<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<table  id="table" class="table-container table table-hover table-striped table-condensed">
	<thead>
        <tr >
		   <th>序号</th>
		   <th>合同模版ID</th>
		   <th>合同模版模版名称</th>
		   <th>访问路径</th>
		   <th>操作</th>
 		</tr>
  </thead>
  <tbody>
  	<c:forEach items="${lists}" var="item" varStatus="sta">
  	 <tr>
         <td>${sta.index+1}</td>
         <td>${item.id}</td>
         <td>${item.name}</td>
         <td><%=basePath %>index.jsp?id=${item.id}</td>
         <td> 
         	<a onclick="skipToModel('${item.id}')" >修改</a>&nbsp;&nbsp;&nbsp;&nbsp;
         	<a onclick="previewHTML('${item.id}')" >预览</a>&nbsp;&nbsp;&nbsp;&nbsp;
         	<a onclick="hrefConfig('${item.id}','${item.name}')" >URL配置</a>
         </td>
     </tr>
  </c:forEach>
  </tbody>
  </table>
	 