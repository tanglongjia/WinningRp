<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div style="overflow-x: auto; overflow-y: auto; ">
<table  class="table-container table table-hover  table-striped"  id="sqlData_table">
<thead >
   <tr>
   	   <c:forEach items="${theadList}" var="thead" varStatus="sta">
	  	 <th data-align="center">${thead}</th>
	   </c:forEach>
  </tr>
</thead>
	  <tbody>
	  <c:forEach items="${dataList}" var="item" varStatus="sta">
	  	<tr>
	  	<c:forEach items="${theadList}" var="thead" varStatus="sta">
	  	 <td>
	  	 	${item[thead]}
	  	 </td>
	   	</c:forEach>
	   	</tr>
	  </c:forEach>
</tbody>
</table>
</div>