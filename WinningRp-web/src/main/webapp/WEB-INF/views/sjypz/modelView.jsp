<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script>
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
<body id="all">
	${html}
</body>
</html>
