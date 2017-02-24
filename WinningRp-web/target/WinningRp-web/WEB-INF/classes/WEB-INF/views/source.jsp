<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>合同模版</title>
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
	a{
		color:blue;
	}
	a:link {
	    color:blue;
	    text-decoration:underline;
	    cursor:pointer;
    }
    a:visited {
	    color:blue;
	   text-decoration:underline;
	   cursor:pointer;
    }
    a:hover {
	    color:blue;
	    text-decoration:underline;
	    cursor:pointer;
    }
    a:active {
	    color:#blue;
	    text-decoration:underline;
	    cursor:pointer;
    }
    li{
     	list-style-type:none;
     	line-height:25px;
    }
</style>
<script type="text/javascript">
	 $(document).ready(function(){
		 init();
	 });

	 function init(){
		 $.ajax({
             type: 'POST',
             url : './skip.do?action=source',
             dataType : 'text',
             success : function(data){
                 $("#tab").html(data);
             }
         });
	 } 
	 
	 function skipToModel(id){
		var url = "<%=basePath %>assertsRp/UE/index.jsp?id="+id;
		window.open(url);
	 }

	 function previewHTML(id){
		var url = "<%=basePath %>skip.do?action=init&id="+id;
		window.open(url);
	 }

	 function hrefConfig(id,name){
		var url = "<%=basePath %>skip.do?action=hrefConfig&id="+id+"&htmlname="+name;
		window.open(url);
	 }
</script>
</head>
<body>
	<div class="box-body" style="font-size: 13px;">
			<form id="mjForm" method="post" class="form-horizontal"  onclick="return false;"   style="font-size: 13px;">
			    <div class="box win-search-box">
			        <div class="box-header">
			            <li class="fa box-search"></li>
			            <div class="box-title"> </div>
			            <div class="box-tools" >
								<button onclick="skipToModel()" class="btn-default glyphicon glyphicon-plus"></button>
			            </div>
			            </div>
			            <div class="box-body">
			            	<div class="form-group">
			            		<div class="col-md-12" style="border-right: 1px solid #EEEEEE; " id="tab">
				       				
						        </div>
					    	</div>       
						</div>
				</div>
			</form>
		</div>
</body>
</html>
