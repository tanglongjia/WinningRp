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
			            <div class="box-title">${htmlname}（${html_id}）</div>
			            <div class="box-tools" >
								<button onclick="skipHandler('${html_id}')" class=" btn-default glyphicon glyphicon-send"></button>
			            </div>
			            </div>
			            <div class="box-body">
			            	<div class="form-group">
						        <div id="contentDiv" class="col-md-12" style="border-right: 1px solid #EEEEEE; min-height: 500px;">
						        		<c:forEach items="${beanList}" var="item">
						        			<div class="row">
						        				 <label>${item.sourceName}</label>：${item.sql}
						        			</div>
							        		<div class="row" style="margin-top:10px;">
							        			<c:forEach items="${item.paramsList}" var="para">
								        			<div class="col-lg-1" style="margin-top:5px;">
								        				<label class="control-label">${para}</label>
								        			</div>
								        			<div class="col-lg-2" style="margin-top:5px;">
								        				<input class="form-control input-sm" name="${para}" type="text"  />
								        			</div>
							        			</c:forEach>
							        			
							        		</div>
							        		<hr/>
						        		</c:forEach>
						        	</div>
					    	</div>       
						</div>
				</div>
			</form>
		</div>
  </body>
</html>

<script type="text/javascript">
	function skipHandler(id){
		 
			var urlPara = "&id="+id;
			var inputs = $("#contentDiv input[type=text]").each(function(){
				console.log($(this).val());
				if($(this).val() !=  ""){
					urlPara = urlPara + "&" + $(this).attr("name") + "=" + $(this).val();
				} 
			}); 
			var url = "<%=basePath %>skip.do?action=init"+urlPara;
			window.open(url);
		 
	}
</script>

 



