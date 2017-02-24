<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%
	String headPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+headPath+"/";
	String dsname = request.getParameter("dsname")  == null ? "" : request.getParameter("dsname");
	String sqlscript = request.getParameter("sqlscript") == null ? "" : request.getParameter("sqlscript");
	String view = request.getParameter("view");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">
	var view = '<%=view%>'
	if(view == 'view'){
		 $("input").attr("disabled",true);
      	 $("textarea").attr("disabled",true);
	}
</script>
<div>
	<div class="row" style="padding-left: 13px; padding-top: 10px;" >
	       <form class="form-inline">
		       	<div class="col-md-12" id="sjy">
		       		<label class="control-label">数据源名称</label>
					<input class="form-control" style="min-width:200px;" type="text" id="ds_name" value='<%=dsname%>'/>
		  		</div>
	 	  </form>
	</div>
	<div class="row" style="padding-top:10px; padding-right:10px; padding-left:10px;">
	    <div class="col-md-12" id="ta_id">
	      	<textarea class="form-control" rows="8" id="sjysql" ><%=sqlscript%></textarea>
		</div>
	</div>
	<div class="row" style="padding-top:10px;padding-left: 30px;">
	            	您可以键入一个 {abc} 作为一个参数，这里的abc是参数名称。例如： 
	            	select * from table where id = {abc} 
		<button id="btn_refresh" class="btn btn-default " style="float: right; margin-right: 25px;" onclick="refresh();return false;">刷新参数</button>
		<button id="btn_refresh" class="btn btn-default " style="float: right; margin-right: 5px;" onclick="getData();return false;">预览数据</button>
	</div>
    <div class="row" style="padding-top:10px; padding-right:25px; padding-left:25px;">
    	<table  class="table table-hover  table-striped skin-blue" style="background-color: white;"  id="column_table" >
			<thead >
			   <tr>
				   <th data-align="center">参数名称</th>
				   <th data-align="center">参数值</th>
			   </tr>
			</thead>
		  	<tbody id="tbody">
		  	</tbody>
	  </table>
    </div>
</div>
<script type="text/javascript">
	$(function () {
		refresh();
	})
	
	function refresh(){
		var sqlscript = $("#sjysql").val();
		jQuery.ajax({ 
		    url: 'bt_bgpz.do?action=getRow', 
		    type: 'POST',
		    dataType: 'json',
		    data:{ sqlscript: sqlscript  }
		})
		.done(function(jsonObj) {
			if(jsonObj.length>0){
				var tbodyHtml="";
				for(var i= 0;i<jsonObj.length;i++){
					tbodyHtml = tbodyHtml+"<tr><td>"+jsonObj[i]+"</td><td><input type='text' name='"+jsonObj[i]+"'/></td></tr>";
				}
				$("#tbody").html(tbodyHtml);
			}
		}) 
		.fail(function() { 
			console.log("error"); 
		}) 
		.always(function() { 
			console.log("complete"); 
		});
	}
	
	function getData(){
		var alertMsg='';
		var sqlscript = $("#sjysql").val();
		
		$("#tbody input").each(function(){
			if(this.value == ''){
				alertMsg = alertMsg + this.name+"值为填写,";
			}
		});
		if(alertMsg !=''){
			toastr.info(alertMsg);
			return ;
		}
		
		var param = '&';
		$("#tbody input").each(function(){
			param = param + this.name+"="+this.value+"&";
		});
		param = param.substring(0,param.length-1);
		var url = "bt_bgpz.do?action=getSqlData&sqlscript="+sqlscript+param;
		var updateBg_dialog = new PWindow({
			title: "预览数据",
	        url:encodeURI(url,'UTF-8'),
	        buttons: [
	                  {
	                     label: '关闭',
	                     cssClass: 'btn-default btn-sm',
	                     action: function(dialogItself){
	                         dialogItself.close();
	                  		}
	               	  }
	                ]
		});
		
	}
	
</script>