<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 
 <%
 	String contextPath = request.getContextPath();
 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath+"/";
 %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>合同数据源配置</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link href="<%=basePath%>assertsRp/UE/bootstrap/css/bootstrap.css" rel="stylesheet">
    <!-- Theme style -->
    <!-- Theme style -->
    <link href="<%=basePath%>assertsRp/UE/bootstrap/css/AdminLTE.min.css" rel="stylesheet">
    <link href="<%=basePath%>assertsRp/UE/bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>assertsRp/UE/bootstrap/css/_all-skins.min.css" rel="stylesheet" >
    <link href="<%=basePath%>assertsRp/UE/bootstrap/css/bootstrap_extra.css"  rel="stylesheet" />
    <link href="<%=basePath%>assertsRp/UE/bootstrap/css/bootstrap-table.css" rel="stylesheet"/>
    <link href="<%=basePath%>assertsRp/UE/bootstrap/css/bootstrap-table-fixed-columns.css" rel="stylesheet"/>
    <link href="<%=basePath%>assertsRp/UE/bootstrap/css/tooltip.css" rel="stylesheet"/>  
     <!-- jQuery 1.9 -->
    <script src="<%=basePath%>assertsRp/UE/bootstrap/js/jquery-1.9.1.js"></script>
    <script src="<%=basePath%>assertsRp/UE/bootstrap/js/jquery.easyui.min.js"  ></script>
    <script src="<%=basePath%>assertsRp/UE/bootstrap/js/jquery.placeholder.js"></script>
    <link href="<%=basePath%>assertsRp/UE/bootstrap/css/formValidation.css" rel="stylesheet"/>
    <script src="<%=basePath%>assertsRp/UE/bootstrap/js/formValidation.js"></script>
    <script src="<%=basePath%>assertsRp/UE/bootstrap/js/formValidation_extra.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="<%=basePath%>assertsRp/UE/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>assertsRp/UE/bootstrap/js/bootstrap-table.js"></script>
    <script src="<%=basePath%>assertsRp/UE/bootstrap/js/bootstrap-table-zh-CN.js"></script>
    <script src="<%=basePath%>assertsRp/UE/bootstrap/js/bootstrap-fixed-column.js"></script>
	<script src="<%=basePath%>assertsRp/UE/bootstrap/js/bootstrap_extra.js"></script>
    <script src="<%=basePath%>assertsRp/UE/bootstrap/js/base64.js"></script>
    <style type="text/css">
    	.skin-green .table thead tr {
		    background-color: #ff23ff;
		}
    </style>
  </head>
  <body>
 		<div class="box-body" style="font-size: 13px;">
			<form id="mjForm" method="post" class="form-horizontal"  onclick="return false;"   style="font-size: 13px;">
			    <div class="box win-search-box">
			        <div class="box-header">
			            <li class="fa box-search"></li>
			            <div class="box-title"> </div>
			            <div class="box-tools" >
								<button onclick="insertHandler('1')" class=" btn-default glyphicon glyphicon-plus"></button>
							    <button onclick="insertHandler('0')" class="  btn-default glyphicon glyphicon-pencil"></button>
							    <button onclick="deleteHandler()" class="  btn-default glyphicon glyphicon-remove"></button>
							    <button onclick="saveHandler()" class="  btn-default glyphicon glyphicon-saved"></button>
			            </div>
			            </div>
			            <div class="box-body">
			            	<div class="form-group">
			            		<div class="col-md-3" style="border-right: 1px solid #EEEEEE;min-height:500px;" id="tab">
				       				
						        </div>
						        <div class="col-md-9" style="border-right: 1px solid #EEEEEE; min-height: 500px;">
						        	<div class="row">
						        		<div class="col-md-2 col-md-2" style="text-align:right">
						        			<label class="  control-label">数据源名称：</label>
						        		</div>
						        		<div class="col-md-10">
						        			<input class="form-control input-sm" disabled="disabled" type="text" id="name" name="name" />
						        		</div>
						        	</div>
						        	<br/>
				       				<div class="row">
				       					<div class="col-md-2 col-md-2" style="text-align:right">
						        			<label class="control-label">配置SQL：</label>
						        		</div>
				       					<div class="col-md-10">
				       						<textarea class=" col-lg-2 form-control input-sm" disabled="disabled" rows="15" id="sql" name="sql"></textarea>
				       					</div>
				       				</div>
				       				<br/>
				       				<div class="row">
				       					<div class="col-md-2 col-md-2" style="text-align:right">
						        			<label class="control-label">配置列：</label>
						        		</div>
				       					<div class="col-md-10">
				       						<textarea class=" col-lg-2 form-control input-sm" disabled="disabled" rows="3" id="clm" name="clm" ></textarea>
				       					</div>
				       				</div>
						        </div>
					    	</div>       
						</div>
				</div>
			</form>
		</div>
  </body>
</html>

<script type="text/javascript">
	var oper = "";
	id = "";
	$(document).ready(function(){
		initTab();
	});

	function initTab(){
		$("#name").attr("disabled","disabled");
		$("#sql").attr("disabled","disabled");
		$.ajax({
            type: 'POST',
            url : '<%=contextPath%>/sjy.do?action=sjyInit',
            success : function(data){
                $("#tab").html(data);
                $("#data_table").bootstrapTable({
                	showHeader : true,
                	onClickRow:function(row,ele){
	                	$("#name").attr("disabled","disabled");
	            		$("#sql").attr("disabled","disabled");
                		var name = $(ele).attr("data-name");
                		var id = $(ele).attr("data-id");
                		var clm = $(ele).attr("data-clm");
                		var sql = $(ele).attr("data-sql");
                		$("#name").val(name);
                		$("#clm").val(clm);
                		$("#sql").val(sql);  
                		window.id = $(ele).attr("data-id");
                	} 
                	 
                });
                clickRowFirst();
            } 
           
        });
	}

	function clickRowFirst(){
		window.id = $("#firstId").val();
		$("#name").val($("#firstName").val());
		$("#clm").val($("#firstClm").val());
		$("#sql").val($("#firstSql").val());  
	}

	function insertHandler(type){
		if(type=='1'){
			oper = "insert";
			$("#name").removeAttr("disabled").val('');
			$("#sql").removeAttr("disabled").val('');
			$("#clm").val('');
		}else{
			oper = "update";
			$("#name").removeAttr("disabled");
			$("#sql").removeAttr("disabled");
		}
	}

	function saveHandler(){
		if(oper){
			var name = $("#name").val();
			var sql = $("#sql").val(); 
			if(!name){alert('未填写数据源名称！');}
			if(!sql){alert('未填写数据源SQL！');}
			$.ajax({
				type : "POST",
				data : {"name":name,"sql":sql,"oper":oper,"id":window.id},
				url : '<%=contextPath%>/sjy.do?action=operHandler',    
				success : function(data){
					oper = "update";
					window.id="";
					if(data==1){
						initTab();
						alert("保存成功！");
					}else if(data=='2'){
						alert("数据源名称不能重复！");
					}else{
						alert("保存失败，确认脚本是否正确！");
					}
				}
			});
		}
	}

	function deleteHandler(){
		if(window.id){
			$.ajax({
				type : "POST",
				data : {"id":window.id},
				url : '<%=contextPath%>/sjy.do?action=deleteHandler',    
				success : function(data){
					oper = "";
					window.id="";
					if(data==1){
						initTab();
						alert("删除成功！");
					}else if(data==0){
						alert("该数据源已经被模版引用不能删除！");
					}else if(data==2){
						alert("系统异常，删除失败！");
					}
				}
			});
		}else{
			alert("选择要删除的数据源！");
		}
		
	}
</script>

 



