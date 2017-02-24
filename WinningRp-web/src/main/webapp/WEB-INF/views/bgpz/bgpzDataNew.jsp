<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
	<div style="width:100%;height:700px;overflow:auto">
	    <table class="table-container table table-hover  table-striped" id="leftTable"  >
	        <thead>
	        	 
	        </thead>
	        <tbody>
	        <c:forEach items="${tables}" var="item" varStatus="sta">
	            <tr data-BGDM="${item.BGDM}" onclick="setSelectItem('${item.BGDM}')">
	                 <td>
	                 	<div style="width:100%;height:100%; ">
	                 		<div style="width:80%;height:100%; float:left;text-align:left">${item.BGMC}</div>
	                 		<div style="width:20%;height:100%; float:right">
	                 			<button onclick="previewNew('${item['URL'] }',event);return false;"   style="background: url('assertsRp/css/images/button_yl.png;') no-repeat;border: none;outline:none">
	                 				<span style="color:#75abd3; outline:none">预览</span>
	                 			</button>
	                 		</div>
	                 	</div>
	                 </td>
	            </tr>
	        </c:forEach>
	        </tbody>
	    </table>
    </div>
    
    <input type="hidden" value="${firstBGDM}" id="firstBGDM"/>
  
