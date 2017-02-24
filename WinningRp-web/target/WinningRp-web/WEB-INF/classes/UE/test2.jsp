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
<title></title>
<style type="text/css">
	input{
		border-top-style:none;
		border-left-style:none;
		border-right-style:none;
	}
</style>
<script type="text/javascript">
	window.onload=function(){
		//文本框设置 只读
		var inputs = document.getElementsByTagName("input");
		for(var i=0;i<inputs.length;i++){
			inputs[i].readOnly=true;
		}
	}
	
</script>
</head>
<body>
	<p>方案信息：</p><p>&nbsp;&nbsp;&nbsp;&nbsp;方案流水号：<input name="leipiNewField" type="text" title="falsh" value=" 1" leipiplugins="label" orgalign="left" orgwidth="150" orgdatasource="s1" orgdatacolumn="FALSH" style="text-align: left; width: 150px;" orgfontsize="" orgheight=""/></p><p>&nbsp;&nbsp;&nbsp;&nbsp;分类名称：<input name="leipiNewField" type="text" title="flmc" value="" leipiplugins="label" orgalign="left" orgwidth="150" orgdatasource="s1" orgdatacolumn="FLMC" style="text-align: left; width: 150px;"/></p><p>&nbsp; &nbsp;&nbsp;</p>
 <%=path %>
 	<%=basePath %>
</body>
</html>
