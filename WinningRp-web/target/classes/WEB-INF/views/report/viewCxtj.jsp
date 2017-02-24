<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%
	String headPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+headPath+"/";
	String bgdm=request.getParameter("bgdm");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<script type="text/javascript" src="<%=basePath%>assertsRp/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>assertsRp/js/toastr.min.js"></script>
<script type="text/javascript" src="<%=basePath%>assertsRp/js/bootstrap_extra.js"></script>
<script src="<%=basePath%>assertsRp/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="<%=basePath%>assertsRp/bootstrap-table/bootstrap-table.js"></script>
<script src="<%=basePath%>assertsRp/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="<%=basePath%>assertsRp/bootstrap-table/bootstrap-fixed-column.js"></script>
<script src="<%=basePath%>assertsRp/bootstrap-dialog/bootstrap-dialog.min.js"></script>
<script src="<%=basePath%>assertsRp/bootstrap-datepicker/bootstrap-datepicker.js"></script>

<link rel="stylesheet" href="<%=basePath%>assertsRp/css/toastr.min.css">
<link href="<%=basePath%>assertsRp/bootstrap/dist/css/bootstrap.css" rel="stylesheet">
<link href="<%=basePath%>assertsRp/bootstrap-table/bootstrap-table.css" rel="stylesheet"/>
<link href="<%=basePath%>assertsRp/bootstrap-dialog/bootstrap-dialog.min.css" rel="stylesheet"/>
<link href="<%=basePath%>assertsRp/bootstrap-table/bootstrap-table-fixed-columns.css" rel="stylesheet"/>
<link href="<%=basePath%>assertsRp/bootstrap-datepicker/datepicker.css" rel="stylesheet"/>
<style>
<!--
 
 -->
</style>

<script type="text/javascript">
$(function () {
	
});

function Export(){
	window.open("<%=basePath%>vr/export?bgdm=<%=bgdm %>");
}

function Import(){
	 $("#uploadForm").submit();
 
}
 

/**
function eventListen(id){
	jQuery.ajax({ 
	    url: 'linkage', 
	    type: 'POST', 
	    dataType: 'json',
	    data:{id: id, rpid: '<%=bgdm %>'}
	}) 
	.done(function(jsonObj) { 
		if(jsonObj.length > 0){
			for ( var i = 0; i < jsonObj.length; i++) {
				triggerEvent(jsonObj[i].KJMC, jsonObj[i].KJZ);
			}
		 }
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
}

function triggerEvent(kjmc, kjz){
	var signsCount=kjz.split("{").length-1;
	for ( var k = 0; k < signsCount; k++) {
		var before=kjz.indexOf('{');
		var after=kjz.indexOf('}');
		var kjmc_t=kjz.substring(before+1, after);
		if($("#"+kjmc_t).length>0){
			kjz=kjz.replace("{"+kjmc_t+"}",  "'"+$("#"+kjmc_t).val()+"'" );
		}else{
			if($("input[name='"+kjmc_t+"']").length>0){
				kjz=kjz.replace("{"+kjmc_t+"}",  "'"+$("input[name='"+kjmc_t+"']").val()+"'" );
			}
		} 
	}
	var signsCount1=kjz.split("{").length-1;
	for ( var x = 0; x < signsCount1; x++) {
		var before1=kjz.indexOf('{');
		var after1=kjz.indexOf('}');
		var kjmc_t1=kjz.substring(before1+1, after1);
		kjz=kjz.replace("{"+kjmc_t1+"}",  "''" );
	}
	jQuery.ajax({ 
	    url: 'linkageControl', 
	    type: 'POST', 
	    dataType: 'json',
	    data:{kjz: kjz}
	}) 
	.done(function(jsonObj) { 
		$("#"+kjmc).val("");
		var option="";
		if(jsonObj.length > 0){
			for ( var i = 0; i < jsonObj.length; i++) {
				option+="<option value=\""+jsonObj[i].code+"\">"+jsonObj[i].name+"</option>";
			}
		 }
		$("#"+kjmc).html(option);
		eventListen(kjmc);
	})
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
}
*/
</script>


<div class="panel-body" style="font-size: 13px;">
	<div class="box win-search-box">
       <div class="box-header">
           <li class="fa box-search"></li>
           <div class="box-title"> 查询条件</div>
           <div class="box-tools">
	  		   ${toobal} 
           </div>
        </div>
        <div class="box-body" style="padding-top:50px;">
        <form class="form-inline">
        	${html} 
 			<!-- 
			<div class="row" style="padding-top:5px;"> 
		   <div class="col-md-3 col-sm-3"> 
		    <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年</label> 
		    <input type="text" class="form-control" style="width:180px;" name="nf" id="nf" /> 
		   </div>
		   <script type="text/javascript">	$('#nf').datepicker({ format: 'yyyy',  minViewMode:2 });
								 </script> 
		   <div class="col-md-3 col-sm-3"> 
		    <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期</label> 
		    <input type="text" class="form-control" style="width:180px;" name="rq" id="rq" /> 
		   </div>
		   <script type="text/javascript">	$('#rq').datepicker({ format: 'yyyy-mm-dd',  minViewMode:0 }); </script> 
		   <div class="col-md-3 col-sm-3"> 
		    <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名</label> 
		    <input type="text" class="form-control" style="width:180px;" placeholder="姓名" name="xm" id="xm" /> 
		   </div> 
		   <div class="col-md-3 col-sm-3"> 
		    <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月份</label> 
		    <input type="text" class="form-control" style="width:180px;" name="yf" id="yf" /> 
		   </div> 
		   <script type="text/javascript">	$('#yf').datepicker({ format: 'yyyy-mm',  minViewMode:1 }); </script> 
		  </div> 
		  <div class="row" style="padding-top:5px;"> 
		   <div class="col-md-3 col-sm-3"> 
		    <label>&nbsp;&nbsp;&nbsp;&nbsp;公司部门</label> 
		    <select class="form-control" style="width:180px;" name="bm" id="bm" onchange="eventListen(this.id)"> <option value="01">全科医生</option> <option value="02">社区护士</option> <option value="03">公卫医生</option> <option selected="selected" value="04">医技</option> <option value="05">管理</option> <option value="06">助理</option> <option value="07">其他</option> </select> 
		   </div> 
		   <div class="col-md-3 col-sm-3"> 
		    <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;民族</label> 
		    <select class="form-control" style="width:180px;" name="mz" id="mz"> <option value="01">全科医生</option> <option value="02">社区护士</option> <option value="03">公卫医生</option> <option selected="selected" value="04">医技</option> <option value="05">管理</option> <option value="06">助理</option> <option value="07">其他</option> </select> 
		   </div> 
		   <div class="col-md-3 col-sm-3"> 
		    <label>性别啊啊啊</label> 
		    <select class="form-control" style="width:180px;" name="xb" id="xb"> <option value="01">全科医生</option> <option value="02">社区护士</option> <option value="03">公卫医生</option> <option selected="selected" value="04">医技</option> <option value="05">管理</option> <option value="06">助理</option> <option value="07">其他</option> </select> 
		   </div> 
		   <div class="col-md-3 col-sm-3"> 
		    <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;职业</label> 
		    <select class="form-control" style="width:180px;" name="zy" id="zy"> <option value="01">全科医生</option> <option value="02">社区护士</option> <option value="03">公卫医生</option> <option selected="selected" value="04">医技</option> <option value="05">管理</option> <option value="06">助理</option> <option value="07">其他</option> </select> 
		   </div> 
		  </div>  
		  -->
			</form>
		
		</div>
	</div>
	
	<form action="import" method="post" id="uploadForm" class="form-horizontal" enctype="multipart/form-data">
		<div class="form-group">
            <label class="control-label col-lg-2">选择EXCEL：</label>
            
            <div class="col-lg-6">
                <input type="file" class="btn btn-default btn-sm"
                onchange="document.getElementById('filepath').value=this.value;" name="excelFile" id="excelFile">
		        <input type='text' name='filepath' id='filepath'>
		        <input type="hidden" name='bgdm' id='bgdm' value="<%=bgdm %>">
            </div>
        </div>
	</form>
	<input type="hidden" name='dazx' id='dazx' value="<%=request.getParameter("dazx") %>">
	<table class="table-container table table-hover"  id="data_table">
      	<thead>
       		<tr>
       			<c:forEach var="item" items="${btmc}">
		 			<th>${item.BTMC}</th>
		 		</c:forEach>
       		</tr>
       	</thead>
       	<tbody>
		 	<c:forEach var="item" items="${dataList}">
		 		<tr>
		 			<td>${item.studentId}</td>
		 			<td>${item.studentName}</td>
		 			<td>${item.studentSex}</td>
		 			<td>${item.studentDormitory}</td>
		 			<td>${item.studentSept}</td>
		 		</tr>
		 	</c:forEach>
      	</tbody>
     </table>
	
</div>	
