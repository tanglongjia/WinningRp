<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
  <style type="text/css">
    	.skin-green .table thead tr {
		    background-color: #ff23ff;
		}
    </style>


<table  id="data_table" class="table-container table table-hover table-striped table-condensed">
	<thead>
		<tr>
			 <th>数据源</th>
		</tr>
	</thead>
	<tbody>
	  	<c:forEach items="${list}" var="item">
	  		<tr data-name="${item.name}" data-id="${item.id}" data-clm="${item.clm}" data-sql="${item.sql}"> 
	  			<td>
	  				${item.name}
	  			</td> 
	  		</tr>
	  	</c:forEach>
	</tbody>
</table>
<input type="hidden" id="firstId" value="${firstId}"  />
<input type="hidden" id="firstName" value="${firstName}"  />
<input type="hidden" id="firstClm" value="${firstClm}"  />
<input type="hidden" id="firstSql" value="${firstSql}"  />



