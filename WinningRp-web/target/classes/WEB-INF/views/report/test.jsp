<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%
	String headPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+headPath+"/";
	String bgdm=request.getParameter("bgdm");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

<script type="text/javascript">
$(function () {
	$(".modal-dialog").width("95%");
	queryTable();
});
 
function queryTable(){
	pk_params.rpid =  $("#rpid").val();
	jQuery.ajax({
	    url: 'queryTable', 
	    type: 'POST', 
	    dataType: 'text',
	    data: pk_params
	}) 
	.done(function(jsonObj) { 
		//if(jsonObj.length > 0){
			//console.log(jsonObj);
			$("#formTable").html(jsonObj);
			
		 //}
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
}

function saveForm(){
	loadMessage();
	var request = new HttpRequest(encodeURI('saveForm','utf-8'),"post",{
		onRequestSuccess : function(responseText){
			 hideMessage();		
			 console.log(responseText);
			 if(responseText.success){
				alertMsg("保存失败！");
				return;
			 }else{
				alertMsg("保存成功！");
				if(pk_params.update == 1){
					update_dialog.close();
				}else{
					add_dialog.close();
				}
				
				$("#search").trigger("click");
			 }
		}
	});
	request.addParameter("rpid",$("#rpid").val());
	request.fillWithForm("formTable");
	request.sendRequest();
}

</script>
<form name="formTable" id="formTable" class="form-horizontal"  onclick="return false;" >
</form>
