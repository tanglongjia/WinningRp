<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%
	String headPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+headPath+"/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="<%=basePath%>assertsRp/js/json2.js"></script>
<style>
<!--
.ft{  background-color: white;  }
.ft1{ background-color: #CCCCCC;  }

.text-overflow{
width:100%;
overflow:hidden;
text-overflow:ellipsis;
white-space:nowrap;
text-align: left;
}

 -->
</style>

<div class="panel-body" style="font-size: 13px; text-align: left; padding:0px; margin-left: -10px; margin-right: -10px; background-color: #ECEFF4;">
    <div class="row" >
        <div class="col-md-12" >
        <!-- 表格管理----------------------------------------- -->			
          <div class="box win-search-box">
            <div class="box-header with-border">
            	  <li class="fa box-search"></li>
                  <div class="box-title">表格管理</div>
            </div>
            <div class="box-body" >
	            <form class="form-inline" onSubmit="return false">
		            <div class="row" >
		            	<div class="col-md-3">
		            		<input type="hidden" id="bgid" value="${dataMap['bgpz']['ID'] }"/>
	        				 表格代码: 
						    <input class="form-control" id="bgdm" style="min-width: 180px;" readonly="true" value="${dataMap['bgpz']['BGDM'] }" />
				        </div>
	        			<div class="col-md-3">
	        				 表格名称: 
						    <input class="form-control" id="bgmc" style="min-width: 180px;" value="${dataMap['bgpz']['BGMC'] }" />
				        </div>
				        <div class="col-md-3">
	        				 类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别: 
						    <select class="form-control" id="lb" style="min-width: 180px;" >
						    	<option value='0'>无</option>
						    </select>
				        </div>
	        			<div class="col-md-3">
	        				 分&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类: 
						    <select class="form-control" id="fl" style="min-width: 180px;"></select>
				        </div>
				    </div>
				    <div class="row" style="padding-top:5px">
		            	<div class="col-md-3">
	        				 查询条件: 
						    <select class="form-control" id="cxtj" style="min-width: 180px;">
						    	<option value='0' <c:if test="${dataMap['bgpz']['CXTJXS'] == 0 }">selected</c:if> >显示</option>
						    	<option value='1' <c:if test="${dataMap['bgpz']['CXTJXS'] == 1 }">selected</c:if>>隐藏</option>
						    </select>
				        </div>
	        			<div class="col-md-3">
	        				 记录状态: 
						    <select class="form-control" id="jlzt" style="min-width: 180px;">
						    	<option value='0' <c:if test="${dataMap['bgpz']['JLZT'] == 0 }">selected</c:if>>启用</option>
						    	<option value='1' <c:if test="${dataMap['bgpz']['JLZT'] == 1 }">selected</c:if>>停用</option>
						    </select>
				        </div>
				        <div class="col-md-3">
	        				 表格类型: 
						    <select class="form-control" id="bglx" style="min-width: 180px;">
						    	<option value='1' <c:if test="${dataMap['bgpz']['BGLX'] == 1 }">selected</c:if>>填报</option>
						    	<option value='0' <c:if test="${dataMap['bgpz']['BGLX'] == 0 }">selected</c:if>>查询</option>
						    </select>
				        </div>
	        			<div class="col-md-3">
	        				 填报表名称: 
						    <input class="form-control" id="tbbmc" style="min-width: 180px;" value="${dataMap['bgpz']['TBBMC']}" onchange="getCsjyl(this.value)"/>
				        </div>
				    </div>
				  <%--   <div class="row" style="padding-top:5px">
				    	<div class="col-md-12">
	        				 访问URL: 
						    <input class="form-control" id="url" style="min-width: 470px;" value="${dataMap['bgpz']['URL']}"/>
				        </div>
				    </div> --%>
				</form>
			</div>
	     </div>
	     
         <!-- 数据源 ----------------------------------------->	
	    <div class="row" style="margin-top:-10px;">
           	<div class="col-md-2" style="border-right: 1px solid #EEEEEE; min-height: 400px; padding-right:0px;">
            	<div class="box win-search-box">
					<div class="box-header with-border">
				         <li class="fa box-search"></li>
	        			 <div class="box-title">数据源</div>
					</div>
					<div class="box-body" style="min-height:642px;">
						<form class="form-inline" onSubmit="return false">
						    <button onclick="ds_update()" class="btn btn-warning glyphicon glyphicon-pencil" style="padding-left: 5px; padding-right: 5px; padding-top: 2px; padding-bottom: 2px;"></button>
						    <br/>
						    <div class="row">
						    	<div class="col-md-12" id="ds_map">
						    		
						    	</div>
						    </div>
						</form>
					</div>
		    	</div>
           		 
	        </div> 
			
	     <div class="col-md-10" style="border-right: 1px solid #EEEEEE; padding-left:10px;">
	 <!-- 按钮管理----------------------------------------- -->				      
		 <div class="box win-search-box">
				<div class="row">
					<div class="col-md-2">
						<div class="box-header with-border" style="background-color: white; border: 0px;">
							<li class="fa box-search"></li>
							<div class="box-title">按钮管理</div>
						</div>
				    </div>
					<div class="col-md-10" style="padding-top:10px; margin-left:-40px;" id="buttonTool">
					
					</div>
				</div>
	         </div>
	 <!-- 查询条件 ---------------------------------------->
		        <div class="box win-search-box" style="margin-top:-10px;">
					<div class="box-header with-border">
			          		 <li class="fa box-search"></li>
			       		 <div class="box-title">查询条件</div>
					</div>
					<div class="box-body" >
						<form class="form-inline" onSubmit="return false">
							<div class="row">
			       				<div class="col-md-6" style="border-right: 1px solid #EEEEEE;">
			       					<div class="row" style="min-height: 150px;">
			        					<div class="col-md-12" >
					        				  <div class="row">
					        				  	<div class="col-md-12" id="cxtjJh">
					        				  		<table id="cxtj_table">
					        				  			 
					        				  		</table>
					        				  	</div>
					        				  </div>
			        					</div>
			        				</div>
			       				</div>
			       				
			      				<div class="col-md-6" style="border-right: 1px solid #EEEEEE;">
			       					<div class="row" style="min-height: 150px;">
			        				 	<div class="col-md-12">
			        				 		<div class="col-md-4">
						        				 条件名称:
						        				 <input class="form-control" id="tjmc" style="width: 70px;"/>
				        					</div>
				        					<div class="col-md-4">
						        				 控件名称:
						        				 <input class="form-control" id="kjmc" style="width: 70px;"/>
				        					</div>
				        					<div class="col-md-4">
						        				 控件类型:
											    <select class="form-control" id="kjlx" onchange="changeTip(this.id)" style="width: 70px;padding: 0px;">
											    	 
											    </select>
									        </div>
			        				 	</div>
			        					<div class="col-md-12" style="padding-top: 10px;">
			        				 		<div class="col-md-4">
						        				 控件状态: 
											    <select class="form-control" id="kjzt" style="width: 70px; padding: 0px;">
											    	<option value='0'>显示</option>
											    	<option value='1'>隐藏</option>
											    </select>
									        </div>
				        					<div class="col-md-4">
						        				控&nbsp;&nbsp;件&nbsp;&nbsp;值:
						        				 <input class="form-control" id="kjz" title="" onchange="validateScript(this.id)" style="width: 70px;"/>
				        					</div>
				        					<div class="col-md-4">
						        				 默&nbsp;&nbsp;认&nbsp;&nbsp;值:
						        				 <input class="form-control" id="mrz" style="width: 70px;"/>
									        </div>
			        				 	</div>
			        				 	
								        <div class="col-md-12" style="padding-top: 10px;">
			        				 		 
				        					<div class="col-md-4">
						        				控件格式:
						        				 <input class="form-control" id="kjgs" title="" style="width: 70px;"/>
				        					</div>
				        					<div class="col-md-4">
						        				 控件水印:
						        				 <input class="form-control" id="kjsy" style="width: 70px;"/>
									        </div>
									        <div class="col-md-4">
						        				 控件顺序:
						        				 <input class="form-control" id="kjsx" style="width: 70px;"/>
									        </div>
			        				 	</div>
			        				</div>
			       				</div>
			       			</div>
						</form>
					</div>
          		</div>
<script type="text/javascript">
	function tr_add(code){
		var trid=createHexRandom();
		if($("#tjmc").val()==""){
			toastr.info("条件名称不能为空！");
			return;
		}
		//修改
		if(u_trid!=""){
			$("#cxtj_bc").attr({"disabled":"disabled"});
		}
		var kjlx=$("#kjlx").val();
		var table_tr="";
			table_tr+="<tr id=\""+trid+"\">";
			table_tr+="		<td  style=\"text-align: right;\">"+$("#tjmc").val()+"</td>";
			table_tr+="		<td>";
			if(kjlx=="1"){
				table_tr+="			<input class=\"form-control\" style=\"width:150px;\"/>";
			}else if(kjlx=="3"){
				table_tr+="			<select class=\"form-control\" style=\"width:150px;\">";
				table_tr+="			</select>";
			}else if(kjlx=="5"){
				table_tr+="			<input class=\"form-control input-sm\" style=\"width:150px;\"/>";
			}
			table_tr+="		</td>";
			table_tr+="		<input type=\"hidden\" name=\"tjid\" value=\""+trid+"\"   />";
			table_tr+="		<td style=\"display: none;\" id=\"tjmc"+trid+"\" name=\"tjmc\">"+$("#tjmc").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjmc"+trid+"\" name=\"kjmc\">"+$("#kjmc").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjlx"+trid+"\" name=\"kjlx\">"+$("#kjlx").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjzt"+trid+"\" name=\"kjzt\">"+$("#kjzt").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjz"+trid+"\" name=\"kjz\">"+$("#kjz").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"mrz"+trid+"\" name=\"mrz\">"+$("#mrz").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjgs"+trid+"\" name=\"kjgs\">"+$("#kjgs").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjsy"+trid+"\" name=\"kjsy\">"+$("#kjsy").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjsx"+trid+"\" name=\"kjsx\">"+$("#kjsx").val()+"</td>";
			table_tr+="		<td>";
			table_tr+="			<button class=\"btn btn-default btn-xs\" style=\"color: white;\"  ";
			table_tr+="				onclick=\"tr_edit('"+trid+"')\"> 修改";
			table_tr+="			</button>";
			table_tr+="			<button class=\"btn btn-default btn-xs\" style=\"color: white;\"  ";
			table_tr+="				onclick=\"tr_del('"+trid+"')\">删除";
			table_tr+="			</button>";
			table_tr+="		</td>";
			table_tr+="</tr>";
		//修改
		if(u_trid!="" && code=="1"){
			$("#"+u_trid).after(table_tr);
			$("#"+u_trid).remove();
			u_trid="";
		}else{
			$("#cxtj_table").append(table_tr);
		}
		
	}

	function tr_del(id){
		$("tr[id="+id+"]").remove();
		//var row = $(id).parent().parent().index();
		//$("#cxtj_table tr").eq(row).remove();
	}

	var u_trid="";
	function tr_edit(id){
		u_trid = id;
		$("#cxtj_bc").removeAttr("disabled");
		$("#tjmc").val($("#tjmc"+id).html());
		$("#kjmc").val($("#kjmc"+id).html());
		$("#kjlx").val($("#kjlx"+id).html());
		$("#kjzt").val($("#kjzt"+id).html());
		$("#kjz").val($("#kjz"+id).html());
		$("#mrz").val($("#mrz"+id).html());
		$("#kjgs").val($("#kjgs"+id).html());
		$("#kjsy").val($("#kjsy"+id).html());
		$("#kjsx").val($("#kjsx"+id).html());
	}

</script>		        				
		        				 
		<!-- 显示结果 -->		
		 <div class="box win-search-box" style="margin-top: -10px; ">
				<div class="box-header with-border">
            		  <li class="fa box-search"></li>
       				  <div class="box-title">显示结果</div>
				</div>
				<div class="box-body" >
					<form class="form-inline" onSubmit="return false">
							<div class="row">
		        				<div class="col-md-6" style="border-right: 1px solid #EEEEEE;">
		        					<div class="row" style="min-height: 400px; ">
				        				  <div class="col-md-12">
					        				  <div class="row">
					        				  	<div class="col-md-12" id="xsjgJh">
					        				  		<table id="xsjg_table">
					        				  			 
					        				  		</table>
					        				  	</div>
					        				  </div>
			        					</div>
			        				</div>
		        				</div>
		        				
		        				<div class="col-md-6" style="border-right: 1px solid #EEEEEE; margin-top:-10px;">
		        					<div class="row" style="min-height: 400px; border-top: 1px solid #EEEEEE;">
				        				 <div class="col-md-12" style="padding-left:0px;">
				        				 
											<ul id="myTab" class="nav nav-tabs">
												<li class="active"><a href="#1" data-toggle="tab">列表属性</a></li>
												<li><a href="#2" data-toggle="tab">控件属性</a></li>
											</ul>
											<div id="myTabContent" class="tab-content">
												<div class="tab-pane fade in active" id="1">
													<div class="row" style="padding-top: 10px;">
											      		<div class="col-md-6" style="padding-right: 0px;">
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;列名:
															<input class="form-control" id="s_btmc" style="width: 170px;"/>
											      		</div>
											      		<div class="col-md-6">
															控件名称:
															<input class="form-control" id="s_kjmc" style="width: 170px;"/>
															<input  id="addSjydm" type="hidden" value=""/>
											      		</div>
											      	</div>
											      	<div class="row" style="padding-top: 10px;">
											      		<div class="col-md-6" style="padding-right: 0px;">
															 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;控件类型:
															<select class="form-control" id="s_kjlx" onchange="changeTip(this.id)" style="width: 170px; ">
																 
															</select>
											      		</div>
											      		<div class="col-md-6" >
															 控件状态:
															<select class="form-control" id="s_kjzt" style="width: 170px;">
																<option value='0'>显示</option>
																<option value='1'>隐藏</option>
															</select>
											      		</div>
											      	</div>
											      	<div class="row" style=" padding-top: 10px;">
											      		<div class="col-md-6" style="padding-right: 0px;">
															 取-数据源列:
															<select class="form-control" id="s_qsjyl" style="width: 170px;">
																 
															</select>
											      		</div>
											      		<div class="col-md-6">
															&nbsp;&nbsp;&nbsp;控件值:
															<input class="form-control" id="s_kjz" onchange="validateScript(this.id)"  title="" style="width: 170px;"/>
											      		</div>
											     	</div>
											     	<div class="row" style=" padding-top: 10px;">
											      		<div class="col-md-6"  style="padding-right:0px;">
															 存-数据源列:
															<select class="form-control" id="s_csjyl" style="width: 150px;">
																 
															</select>
															<input type="checkbox" name="iszj" id="s_iszj" value="1" title="是否主键"/>
											      		</div>
											      		<div class="col-md-6">
															&nbsp;&nbsp;&nbsp;默认值:
															<input class="form-control" id="s_mrz" style="width: 170px;"/>
											      		</div>
											        </div>
											        <div class="row" style="padding-top: 10px;">
											      		<div class="col-md-6">
															 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;校验类型:
															<select class="form-control" id="s_jylx" onchange="AddPlaceholder()" style="width: 170px;">
																 
															</select>
											      		</div>
											      		<div class="col-md-6">
															校验代码:
															<input class="form-control" id="s_jydm" placeholder="" style="width: 170px;"/>
											      		</div>
											      	</div>	
											        <div class="row" style=" padding-top: 10px;">
											        	<div class="col-md-6">
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提示信息:
															<input class="form-control" id="s_tsxx" style="width: 170px;"/>
											      		</div>
											      		<div class="col-md-6"  style="padding-right:0px;">
															控件顺序:
															<input class="form-control" id="s_sx" style="width: 170px;"/>
											      		</div>
											        </div>
												</div>
												
												<div class="tab-pane fade" id="2">
													<div class="row" style="padding-top: 10px;">
											      		<div class="col-md-6">
															控件格式:
															<input class="form-control" id="s_kjgs"  title="" style="width: 170px;"/>
											      		</div>
											      		<div class="col-md-6">
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;水印:
															<input class="form-control" id="s_sy" style="width: 170px;"/>
											      		</div>
											      	</div>
											      	<div class="row" style="padding-top: 10px;">
											      		<div class="col-md-6">
															 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;必填:
															<select class="form-control" id="s_bt" style="width: 170px;">
																<option value='0'>否</option>
																<option value='1'>是</option>
															</select>
											      		</div>
											      		<div class="col-md-6">
															 允许编辑:
															<select class="form-control" id="s_yxbj" style="width: 170px;">
																<option value='1'>是</option>
																<option value='0'>否</option>
															</select>
											      		</div>
											     	</div>
											      	<div class="row" style="padding-top: 10px;">
											      		<div class="col-md-6">
															扩展方向:
															<select class="form-control" id="s_kzfx" style="width: 170px;">
																<option value='0'>无</option>
																<option value='1'>纵向</option>
																<option value='2'>横向</option>
															</select>
											      		</div>
											      		<div class="col-md-6">
															显示位置:
															<select class="form-control" id="s_xswz" style="width: 170px;">
																<option value='0'>左</option>
																<option value='1'>中</option>
																<option value='2'>右</option>
															</select>
											      		</div>
											      	</div>
											      	<div class="row" style="padding-top: 10px;">
											      		<div class="col-md-6">
															链接地址:
															<input class="form-control" id="s_ljdz" style="width: 170px;"/>
											      		</div>
											      		<div class="col-md-6">
															展现方式:
															<select class="form-control" id="s_zxfs" style="width: 170px;">
																<option value='0'>自动扩展</option>
																<option value='1'>固定格式</option>
															</select>
											      		</div>
											     	</div>
											     	<div class="row" style="padding-top: 10px;">
											      		<div class="col-md-6">
															汇总类型:
															<select class="form-control" id="s_hzlx" style="width: 170px;">
																<option value='0'>无</option>
																<option value='1'>合计</option>
																<option value='2'>平均</option>
															</select>
											      		</div>
											        </div>
												</div>
											</div>
					        				  
			        					</div>
	        						</div>
		        				</div>
		        			</div>
					</form>
				</div>
            </div>
<script type="text/javascript">
	function show_tr_add(code){
		var trid1=createHexRandom();
		if($("#s_btmc").val()==""){
			toastr.info("列名不能为空！");
			return;
		}
		var s_qsjyl = $("#s_qsjyl").val();
		var s_csjyl = $("#s_csjyl").val();
		if(s_qsjyl ==null || s_qsjyl=='' || s_qsjyl =='null'){
			toastr.info("取数据源列不能为空！");
			return;
		}
		/*
		var bglx=$("#bglx").val();
		if((s_csjyl ==null || s_csjyl=='' || s_csjyl =='null') && bglx=="1"){
			toastr.info("存数据源列不能为空！");
			return;
		}*/
		
		//修改
		if(xsjg_trid!=""){
			$("#xsjg_bc").attr({"disabled":"disabled"});
		}
		var iszj='0';
		$("input[name='iszj']:checked").each(function(){
			iszj='1';
		});
		var kjlx=$("#s_kjlx").val();
		var table_tr="";
			table_tr+="<tr id=\""+trid1+"\">";
			table_tr+="		<td  style=\"text-align: right;\">"+$("#s_btmc").val()+"</td>";
			table_tr+="		<td>";
			if(kjlx=="1"){
				table_tr+="			<input class=\"form-control\" style=\"width:150px;\"/>";
			}else if(kjlx=="3"){
				table_tr+="			<select class=\"form-control\" style=\"width:150px;\">";
				table_tr+="			</select>";
			}else if(kjlx=="5"){
				table_tr+="			<input class=\"form-control input-sm\" style=\"width:150px;\"/>";
			}
			table_tr+="		</td>";
			table_tr+="		<input type=\"hidden\" name=\"kjid\" value=\""+trid1+"\"   />";
			table_tr+="		<td style=\"display: none;\" id=\"s_kjmc"+trid1+"\" name=\"s_kjmc\">"+$("#s_kjmc").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_btmc"+trid1+"\" name=\"s_btmc\">"+$("#s_btmc").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_kjlx"+trid1+"\" name=\"s_kjlx\">"+$("#s_kjlx").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_kjzt"+trid1+"\" name=\"s_kjzt\">"+$("#s_kjzt").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_qsjyl"+trid1+"\" name=\"s_qsjyl\">"+$("#s_qsjyl").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_kjz"+trid1+"\" name=\"s_kjz\">"+$("#s_kjz").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_csjyl"+trid1+"\" name=\"s_csjyl\">"+$("#s_csjyl").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_mrz"+trid1+"\" name=\"s_mrz\">"+$("#s_mrz").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_kjgs"+trid1+"\" name=\"s_kjgs\">"+$("#s_kjgs").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_sy"+trid1+"\" name=\"s_sy\">"+$("#s_sy").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_bt"+trid1+"\" name=\"s_bt\">"+$("#s_bt").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_yxbj"+trid1+"\" name=\"s_yxbj\">"+$("#s_yxbj").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_jylx"+trid1+"\" name=\"s_jylx\">"+$("#s_jylx").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_jydm"+trid1+"\" name=\"s_jydm\">"+$("#s_jydm").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_tsxx"+trid1+"\" name=\"s_tsxx\">"+$("#s_tsxx").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_xswz"+trid1+"\" name=\"s_xswz\">"+$("#s_xswz").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_ljdz"+trid1+"\" name=\"s_ljdz\">"+$("#s_ljdz").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_zxfs"+trid1+"\" name=\"s_zxfs\">"+$("#s_zxfs").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_kzfx"+trid1+"\" name=\"s_kzfx\">"+$("#s_kzfx").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_hzlx"+trid1+"\" name=\"s_hzlx\">"+$("#s_hzlx").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_sjydm"+trid1+"\" name=\"s_sjydm\">"+$("#addSjydm").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_sx"+trid1+"\" name=\"s_sx\">"+$("#s_sx").val()+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_iszj"+trid1+"\" name=\"s_iszj\">"+iszj+"</td>";
			table_tr+="		<td>";
			table_tr+="			<button class=\"btn btn-default btn-xs\" style=\"color: white;\" ";
			table_tr+="				onclick=\"show_tr_edit('"+trid1+"')\"> 详情";
			table_tr+="			</button>";
			table_tr+="		</td>";
			table_tr+="</tr>";
		//修改
		if(xsjg_trid!="" && code=="1"){
			$("#"+xsjg_trid).after(table_tr);
			$("#"+xsjg_trid).remove();
			xsjg_trid="";
		}else{
			$("#xsjg_table").append(table_tr);
		}
		
	}

	function show_tr_del(id){
		$("tr[id="+id+"]").remove();
	}

	var xsjg_trid="";
	function show_tr_edit(id){
		xsjg_trid = id;
		$("#xsjg_bc").removeAttr("disabled");
   		$("#s_btmc").val($("#s_btmc"+id).html());
   		$("#s_kjmc").val($("#s_kjmc"+id).html());
   		$("#s_kjlx").val($("#s_kjlx"+id).html());
   		$("#s_kjzt").val($("#s_kjzt"+id).html());
   		$("#s_qsjyl").val($("#s_qsjyl"+id).html());
   		$("#s_kjz").val($("#s_kjz"+id).html());
   		$("#s_csjyl").val($("#s_csjyl"+id).html());
   		$("#s_mrz").val($("#s_mrz"+id).html());
   		$("#s_kjgs").val($("#s_kjgs"+id).html());
   		$("#s_sy").val($("#s_sy"+id).html());
   		$("#s_bt").val($("#s_bt"+id).html());
   		$("#s_yxbj").val($("#s_yxbj"+id).html());
   		$("#s_jylx").val($("#s_jylx"+id).html());
   		$("#s_jydm").val($("#s_jydm"+id).html());
   		$("#s_tsxx").val($("#s_tsxx"+id).html());
   		$("#s_xswz").val($("#s_xswz"+id).html());
   		$("#s_ljdz").val($("#s_ljdz"+id).html());
   		$("#s_zxfs").val($("#s_zxfs"+id).html());
   		$("#s_kzfx").val($("#s_kzfx"+id).html());
   		$("#s_hzlx").val($("#s_hzlx"+id).html());
   		$("#addSjydm").val($("#s_sjydm"+id).html());
   		$("#s_sx").val($("#s_sx"+id).html());
   		if($("#s_iszj"+id).html()=='1'){
   			$("[name='iszj']").prop("checked",true);
   			$("#s_iszj").val("1");
   		}else{
   			$("[name='iszj']").prop("checked",false);
   			$("#s_iszj").val("0");
   		}
	}

</script>			        				
		        				
       			</div>
      				  
	        </div>
	    </div>
    </div>
</div>
<input type="hidden" id="selectSjyId"/>
<input type="hidden" id="selectSjyName"/>
<input type="hidden" id="selectSjySql"/>
<style>
 
</style>

<script type="text/javascript">

var bbdm_g="";
//表格分类
var bgfl = ${dataMap['bgpz']['FL']};
//按钮
var andm = new Array();
<c:forEach items="${dataMap['an']}" var="item">
	andm.push("${item['ANDM']}");
</c:forEach>

//数据源
var sqlyj = new Array();
var sqlid = new Array();
var sqlmc = new Array();
<c:forEach items="${dataMap['sjy']}" var="sjy">
	sqlyj.push("${sjy['SQLYJ']}");
	sqlid.push("${sjy['SJYDM']}");
	sqlmc.push("${sjy['SJYMC']}");
</c:forEach>
 
//查询条件
var cxtjid = new Array();
var cxtjtjmc = new Array();
var cxtjkjmc = new Array();
var cxtjkjlx = new Array();
var cxtjkjzt = new Array();
var cxtjkjz = new Array();
var cxtjmrz = new Array();
var cxtjkjlxgs = new Array();
var cxtjsy = new Array();
var cxtjsx = new Array();
<c:forEach items="${dataMap['cxtj']}" var="cxtj">
	cxtjid.push("${cxtj['ID']}");
	cxtjtjmc.push("${cxtj['TJMC']}");
	cxtjkjmc.push("${cxtj['KJMC']}");
	cxtjkjlx.push("${cxtj['KJLX']}");
	cxtjkjzt.push("${cxtj['KJZT']}");
	cxtjkjz.push("${cxtj['KJZ']}");
	cxtjmrz.push("${cxtj['MRZ']}");
	cxtjkjlxgs.push("${cxtj['KJLXGS']}");
	cxtjsy.push("${cxtj['SY']}");
	cxtjsx.push("${cxtj['KJSX']}");
</c:forEach>

//显示结果
var xsjgid = new Array();
var xsjgbtmc = new Array();
var xsjgbqsjyl = new Array();
var xsjgbcsjyl = new Array();
var xsjgkjmc = new Array();
var xsjgkjlx = new Array();
var xsjgkjzt = new Array();
var xsjgkjz = new Array();
var xsjgmrz = new Array();
var xsjgkjlxgs = new Array();
var xsjgsy = new Array();
var xsjgbt = new Array();
var xsjgyxbj = new Array();
var xsjgjylx = new Array();
var xsjgjydm = new Array();
var xsjgtsxx = new Array();
var xsjgxswz = new Array();
var xsjgljdz = new Array();
var xsjgzxfs = new Array();
var xsjgkzfx = new Array();
var xsjghzlx = new Array();
var xsjgsjydm = new Array();
var xsjgsx = new Array();
var xsjgiszj = new Array();
<c:forEach items="${dataMap['xsjg']}" var="xsjg">
	xsjgid.push("${xsjg['ID']}");
	xsjgbtmc.push("${xsjg['BTMC']}");
	xsjgbqsjyl.push("${xsjg['BQSJYL']}");
	xsjgbcsjyl.push("${xsjg['BCSJYL']}");
	xsjgkjmc.push("${xsjg['KJMC']}");
	xsjgkjlx.push("${xsjg['KJLX']}");
	xsjgkjzt.push("${xsjg['KJZT']}");
	xsjgkjz.push("${xsjg['KJZ']}");
	xsjgmrz.push("${xsjg['MRZ']}");
	xsjgkjlxgs.push("${xsjg['KJLXGS']}");
	xsjgsy.push("${xsjg['SY']}");
	xsjgbt.push("${xsjg['BT']}");
	xsjgyxbj.push("${xsjg['YXBJ']}");
	xsjgjylx.push("${xsjg['JYLX']}");
	xsjgjydm.push("${xsjg['JYDM']}");
	xsjgtsxx.push("${xsjg['TSXX']}");
	xsjgxswz.push("${xsjg['XSWZ']}");
	xsjgljdz.push("${xsjg['LJDZ']}");
	xsjgzxfs.push("${xsjg['ZXFS']}");
	xsjgkzfx.push("${xsjg['KZFX']}");
	xsjghzlx.push("${xsjg['HZLX']}");
	xsjgsjydm.push("${xsjg['SJYDM']}");
	xsjgsx.push("${xsjg['SX']}");
	xsjgiszj.push("${xsjg['ISZJ']}");
</c:forEach>


$('#s_iszj').poshytip({
	className: 'tip-skyblue', bgImageFrameSize: 9,
	offsetX: 0,
	offsetY: 20
});

function changeTip(id){
	if(id=="kjlx"){
		var val=$("#"+id).val();
		if(val=="3"){
			$("#kjz").attr("title","返回结果列必须是code和name");
			$('#kjz').poshytip({
				className: 'tip-skyblue', bgImageFrameSize: 9 
			});
		}else{
			$("#kjz").attr("title","");
			$('#kjz').poshytip('destroy');
		}

		if(val=="5"){
			$("#kjgs").attr("title","年： yyyy, 月：yyyy-mm, 日：yyyy-mm-dd");
			$('#kjgs').poshytip({
				className: 'tip-skyblue', bgImageFrameSize: 9
			});
		}else{
			$("#kjgs").attr("title","");
			$('#kjgs').poshytip('destroy');
		}
		
	}
	if(id=="s_kjlx"){
		var val=$("#"+id).val();
		if(val=="3"){
			$("#s_kjz").attr("title","返回结果列必须是code和name");
			$('#s_kjz').poshytip({
				className: 'tip-skyblue', bgImageFrameSize: 9 
			});
		}else{
			$("#s_kjz").attr("title","");
			$('#s_kjz').poshytip('destroy');
		}

		if(val=="5"){
			$("#s_kjgs").attr("title","年： yyyy, 月：yyyy-mm, 日：yyyy-mm-dd");
			$('#s_kjgs').poshytip({
				className: 'tip-skyblue', bgImageFrameSize: 9
			});
		}else{
			$("#s_kjgs").attr("title","");
			$('#s_kjgs').poshytip('destroy');
		}
		
	}
}

// 初始化 
$(function () {
	
	//初始化按钮
	getButtonTool();
	//初始化数据源
	getSyj();
	//初始化查询条件
	getCxtj();
	//初始化显示结果
	getXsjg();
	
	//初始化存数据源列
	initCsjyl();
	//初始化取数据源列
	initQsjyl();
	
	getKjlx();
	
	$("input").attr("disabled",true);
	$("select").attr("disabled",true);
});


function AddPlaceholder(){
	var val=$("#s_jylx").val();
	if(val=="rangelength_winning" || val=="range_winning" ){
		$("#s_jydm").attr("placeholder","XX,XX");
	}else{
		$("#s_jydm").attr("placeholder","");
	}
}

function initCsjyl(){
	var csjyl;
	for(var i = 0 ; i < xsjgbqsjyl.length; i++){
		if(i==0){
			csjyl = xsjgbcsjyl[i];
		}
	}
	var tabName = $("#tbbmc").val();
	if(tabName == null || tabName == ''){
		return;
	}
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=getCsjyl', 
	    type: 'POST',
	    dataType: 'json',
	    data:{ tabName: tabName  }
	})
	.done(function(jsonObj) {
		if(jsonObj[0]!=null){
			$("#s_csjyl").empty();
			$("#s_csjyl").append("<option value=''>请选择</option>");
			for(var i=0; i<jsonObj.length; i++){
				if(csjyl == undefined){
					csjyl = "";
				}
				if(jsonObj[i]==csjyl){
					$("#s_csjyl").append("<option value='"+jsonObj[i]+"' selected>"+jsonObj[i]+"</option>");
				}else{
					$("#s_csjyl").append("<option value='"+jsonObj[i]+"'>"+jsonObj[i]+"</option>");
				}
			}
			$("#s_csjyl").change();
		}else{
			$("#s_csjyl").empty();
			toastr.error("填报表名不存在!");
			return;
		}
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	}); 
}

function initQsjyl(){
	var sql,qsjyl;
	for(var i = 0 ; i < sqlyj.length; i++){
		if(i==0){
			sql = sqlyj[i];
			qsjyl = xsjgbqsjyl[i];
		}
	}
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=sqlValidation', 
	    type: 'POST',
	    dataType: 'json',
	    data:{ jbdm: sql  }
	})
	.done(function(jsonObj) {
		var array = new Array();
		array=jsonObj[0].col;
		if(array[0]=="0"){
			$("#s_qsjyl").empty();
			$("#s_qsjyl").append("<option value=''>请选择</option>");
			for(var i=1; i<array.length; i++){
				if(qsjyl == undefined){
					qsjyl = "";
				}
				if(array[i]==qsjyl){
					$("#s_qsjyl").append("<option value='"+array[i]+"' selected>"+array[i]+"</option>");
				}else{
					$("#s_qsjyl").append("<option value='"+array[i]+"'>"+array[i]+"</option>");
				}
				
			}
			$("#s_qsjyl").change();
		}
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
}

//初始化查询条件
function getCxtj(){
	for(var i = 0 ; i <cxtjid.length ; i++ ){
		$("#cxtj_bc").attr({"disabled":"disabled"});
		var trid = cxtjid[i];
		var kjlx = cxtjkjlx[i];
		var table_tr="";
			table_tr+="<tr id=\""+trid+"\">";
			table_tr+="		<td style=\"text-align: right;\">"+cxtjtjmc[i]+"</td>";
			table_tr+="		<td>";
			if(kjlx=="1"){
				table_tr+="			<input class=\"form-control\" style=\"width:150px;\"/>";
			}else if(kjlx=="3"){
				table_tr+="			<select class=\"form-control\" style=\"width:150px;\">";
				table_tr+="			</select>";
			}else if(kjlx=="5"){
				table_tr+="			<input class=\"form-control input-sm\" style=\"width:150px;\"/>";
			}
			table_tr+="		</td>";
			table_tr+="		<input type=\"hidden\" name=\"tjid\" value=\""+trid+"\"   />";
			table_tr+="		<td style=\"display: none;\" id=\"tjmc"+trid+"\" name=\"tjmc\">"+cxtjtjmc[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjmc"+trid+"\" name=\"kjmc\">"+cxtjkjmc[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjlx"+trid+"\" name=\"kjlx\">"+cxtjkjlx[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjzt"+trid+"\" name=\"kjzt\">"+cxtjkjzt[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjz"+trid+"\" name=\"kjz\">"+cxtjkjz[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"mrz"+trid+"\" name=\"mrz\">"+cxtjmrz[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjgs"+trid+"\" name=\"kjgs\">"+cxtjkjlxgs[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjsy"+trid+"\" name=\"kjsy\">"+cxtjsy[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"kjsx"+trid+"\" name=\"kjsx\">"+cxtjsx[i]+"</td>";
			table_tr+="		<td>";
			table_tr+="			<button class=\"btn btn-default btn-xs\" style=\"color: white;\" ";
			table_tr+="				onclick=\"tr_edit('"+trid+"')\"> 详情";
			table_tr+="			</button>";
			table_tr+="		</td>";
			table_tr+="</tr>";
		$("#cxtj_table").append(table_tr);
		if(i==0){
			tr_edit(trid);
		} 
	}
}

//初始化显示结果
function getXsjg(){
	for (var i = 0 ; i< xsjgid.length; i++){
		var trid1 = xsjgid[i];
		$("#xsjg_bc").attr({"disabled":"disabled"});
		var kjlx=xsjgkjlx[i];
		var table_tr="";
			table_tr+="<tr id=\""+trid1+"\">";
			table_tr+="		<td id=\"s_btmc"+trid1+"\" style=\"text-align: right;\">"+xsjgbtmc[i]+"</td>";
			table_tr+="		<td>";
			if(kjlx=="1"){
				table_tr+="			<input class=\"form-control\" style=\"width:150px;\"/>";
			}else if(kjlx=="3"){
				table_tr+="			<select class=\"form-control\" style=\"width:150px;\">";
				table_tr+="			</select>";
			}else if(kjlx=="5"){
				table_tr+="			<input class=\"form-control input-sm\" style=\"width:150px;\"/>";
			}
			table_tr+="		</td>";
			table_tr+="		<input type=\"hidden\" name=\"kjid\" value=\""+trid1+"\"   />";
			table_tr+="		<td style=\"display: none;\" id=\"s_kjmc"+trid1+"\" name=\"s_kjmc\">"+xsjgkjmc[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_kjlx"+trid1+"\" name=\"s_kjlx\">"+kjlx+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_kjzt"+trid1+"\" name=\"s_kjzt\">"+xsjgkjzt[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_qsjyl"+trid1+"\" name=\"s_qsjyl\">"+xsjgbqsjyl[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_kjz"+trid1+"\" name=\"s_kjz\">"+xsjgkjz[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_csjyl"+trid1+"\" name=\"s_csjyl\">"+xsjgbcsjyl[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_mrz"+trid1+"\" name=\"s_mrz\">"+xsjgmrz[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_kjgs"+trid1+"\" name=\"s_kjgs\">"+xsjgkjlxgs[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_sy"+trid1+"\" name=\"s_sy\">"+xsjgsy[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_bt"+trid1+"\" name=\"s_bt\">"+xsjgbt[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_yxbj"+trid1+"\" name=\"s_yxbj\">"+xsjgyxbj[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_jylx"+trid1+"\" name=\"s_jylx\">"+xsjgjylx[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_jydm"+trid1+"\" name=\"s_jydm\">"+xsjgjydm[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_tsxx"+trid1+"\" name=\"s_tsxx\">"+xsjgtsxx[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_xswz"+trid1+"\" name=\"s_xswz\">"+xsjgxswz[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_ljdz"+trid1+"\" name=\"s_ljdz\">"+xsjgljdz[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_zxfs"+trid1+"\" name=\"s_zxfs\">"+xsjgzxfs[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_kzfx"+trid1+"\" name=\"s_kzfx\">"+xsjgkzfx[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_hzlx"+trid1+"\" name=\"s_hzlx\">"+xsjghzlx[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_sjydm"+trid1+"\" name=\"s_sjydm\">"+xsjgsjydm[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_sx"+trid1+"\" name=\"s_sx\">"+xsjgsx[i]+"</td>";
			table_tr+="		<td style=\"display: none;\" id=\"s_iszj"+trid1+"\" name=\"s_iszj\">"+xsjgiszj[i]+"</td>";
			table_tr+="		<td>";
			table_tr+="			<button class=\"btn btn-default btn-xs\" style=\"color: white;\" ";
			table_tr+="				onclick=\"show_tr_edit('"+trid1+"')\"> 详情";
			table_tr+="			</button>";
			table_tr+="		</td>";
			table_tr+="</tr>";
			$("#xsjg_table").append(table_tr);
			if(i==0){
				show_tr_edit(trid1);
			} 
	}
}

//初始化数据源
function getSyj(){
	for(var i = 0 ; i < sqlid.length; i++){
		var id = sqlid[i];
		var mc = sqlmc[i];
		var sql = sqlyj[i];
		jQuery.ajax({ 
		    url: 'bt_bgpz.do?action=sqlValidation', 
		    type: 'POST',
		    dataType: 'json',
		    data:{ jbdm: sql,mc:mc,id:id  }
		})
		.done(function(jsonObj) {
			var array = new Array();
			array=jsonObj[0].col;
			if(array[0]=="0"){
				var html="";
				html+="<div class=\"dropdown\" id=\"div"+id+"\">";
				html+="<button name=\"ds_bt\" id=\""+id+"\"  type=\"button\" class=\"btn dropdown-toggle ft text-overflow\" onclick=\"click_change('"+id+"')\" data-toggle=\"dropdown\">"+mc;
				html+="		<span class=\"caret\"></span>";
				html+="		<input type=\"hidden\" name=\"sourceId\" value=\""+id+"\"/>";
				html+="		<span id=\"name"+id+"\" style=\"display:none\">"+mc+"</span>";
				html+="		<span id=\"sql"+id+"\" style=\"display:none\">"+sql+"</span>";
				html+="</button>";
				html+="    <ul class=\"dropdown-menu\" role=\"menu\" aria-labelledby=\""+id+"\">";
				for(var i=1; i<array.length; i++)
				{
				    html+="        <li role=\"presentation\">";
					html+="            <a role=\"menuitem\" tabindex=\"-1\">"+array[i]+"</a>";
					html+="        </li>";
				}
				html+="    </ul>";
				html+="</div>";
				$("#ds_map").append(html);
			}else{
				toastr.error("脚本错误!");
				return ;
			}
		}) 
		.fail(function() { 
			console.log("error"); 
		}) 
		.always(function() { 
			console.log("complete"); 
		});
	}
}

//获取按钮工具
function getButtonTool(){
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=getButtonTool', 
	    type: 'POST',
	    dataType: 'json' 
	})
	.done(function(jsonObj) {
		if(jsonObj.length > 0){
			var option="";
			for(var i=0; i<jsonObj.length; i++){
				var isCheck = false;
				for(var j=0 ; j <andm.length;j++ ){
					if(jsonObj[i].ANDM == andm[j]){
						isCheck = true;
						break;
					}
				}
				if(isCheck){
					option+="<input name=\"an\" onclick=\"return false;\" type=\"checkbox\" checked value=\""+jsonObj[i].ANDM+"\"/>&nbsp;"+jsonObj[i].ANMC+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}else{
					option+="<input name=\"an\" onclick=\"return false;\" type=\"checkbox\" value=\""+jsonObj[i].ANDM+"\"/>&nbsp;"+jsonObj[i].ANMC+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}
			}
			$("#buttonTool").html(option);
		}
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
}

//获取控件类型
function getKjlx(){
	var kjlx;
	for (var i = 0 ; i< xsjgid.length; i++){
		if(i==0){
			 kjlx = xsjgkjlx[i];
		}
	}
	jQuery.ajax({
	    url: 'bt_bgpz.do?action=getKjlx', 
	    type: 'POST', 
	    dataType: 'json',
	    data:{kjlx:kjlx}
	}) 
	.done(function(jsonObj) { 
		if(jsonObj.length > 0){
			/*var option="";
			for(var i=0; i<jsonObj.length-1; i++){
				if(jsonObj[i].code==jsonObj[jsonObj.length-1].kjlx){
					option+="<option value=\""+jsonObj[i].code+"\" selected>"+jsonObj[i].name+"</option>";
				}else{
					option+="<option value=\""+jsonObj[i].code+"\">"+jsonObj[i].name+"</option>";
				}
			}
			$("#kjlx").html(option);
			$("#s_kjlx").html(option); 
*/
			$("#s_jylx").append("<option value='0'>无</option>");
			for(var i=0; i<jsonObj.length-1; i++){
				if(jsonObj[i].WTBH=="100"){
					$("#kjlx").append("<option value='"+jsonObj[i].DABH+"'>"+jsonObj[i].DAXX+"</option>");
					$("#s_kjlx").append("<option value='"+jsonObj[i].DABH+"'>"+jsonObj[i].DAXX+"</option>");
				}else if(jsonObj[i].WTBH=="101"){
					$("#s_jylx").append("<option value='"+jsonObj[i].DABH+"'>"+jsonObj[i].DAXX+"</option>");
				}else{
					$("#fl").append("<option value='"+jsonObj[i].DABH+"'>"+jsonObj[i].DAXX+"</option>");
				}
			}
			$("#fl").val(bgfl);
			$("#kjlx").val(cxtjkjlx[0]);
			$("#s_kjlx").val(xsjgkjlx[0]);
			$("#s_jylx").val(xsjgjylx[0]);
		} 
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
}


//新增
function add(){
	 $('#window').modal('show');
	 $("#bbmc2").val('');
	 $("#ccgc").val('');
	 $("#fwlj").val('');
	 document.getElementById("qy").checked=true;
 	 document.getElementById("ty").checked=false;
}

//修改
function edit(code){
	$('#window').modal('show');
	bbdm_g=code;
	jQuery.ajax({
	    url: 'bt_bgpz.do?action=getZtbbjl', 
	    type: 'POST', 
	    dataType: 'json',
	    data:{ bbdm: code}
	})
	.done(function(jsonObj) {
		if(jsonObj.length>0){
			 $("#bbmc2").val(jsonObj[0].BBMC);
			 $("#ssjg").val(jsonObj[0].YLJGDM);
			 $("#ccgc").val(jsonObj[0].PROCEDURE);
			 $("#fwlj").val(jsonObj[0].PATH);
			 if(jsonObj[0].JLZT == "0"){
				document.getElementById("qy").checked=true;
            	document.getElementById("ty").checked=false;
             }else{
            	document.getElementById("qy").checked=false;
				document.getElementById("ty").checked=true;
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

//删除
function del(code){
	alertConfirm2('确定删除吗?', function(r){
        if (r){
        	jQuery.ajax({ 
        	    url: 'bt_bgpz.do?action=del', 
        	    type: 'POST',
        	    dataType: 'html',
        	    data:{ bbdm: code  }
        	})
        	.done(function(jsonObj) {
        		if(jsonObj==""){
        			 //alertMsg("删除成功！");
        			 toastr.success('删除成功！');
        			 getZtbbzb();
        		}else{
        			 //alertMsg("删除失败！");
        			 toastr.error('删除失败！');
        		}
        	}) 
        	.fail(function() { 
        		console.log("error"); 
        	}) 
        	.always(function() { 
        		console.log("complete"); 
        	});
        }
    });
	
}


function validateScript(id){
	var message="";
	var kjlx="";
	if(id=="kjz"){
		message="查询条件-控件值脚本错误！";
		kjlx=$("#kjlx").val();
	}
	if(id=="s_kjz"){
		message="显示结果-控件值脚本错误！";
		kjlx=$("#s_kjlx").val();
	}
	var sql=$("#"+id).val();
	if(sql=="" || sql==null || kjlx!="3"){
		return;
	}
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=sqlValidation', 
	    type: 'POST',
	    dataType: 'json',
	    data:{ jbdm: sql  }
	})
	.done(function(jsonObj) {
		var array = new Array();
		array=jsonObj[0].col;
		if(array[0]=="1"){
			toastr.error(message);	 
		}
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	}); 
}


function createHexRandom(){  
    var num = '';
	 for (i = 0; i <= 31; i++)
	 {
	    var tmp = Math.ceil(Math.random()*15); 
	    if(tmp > 9){
	           switch(tmp){  
	               case(10):
	                   num+='A';
	                   break; 
	               case(11):
	                   num+='B';
	                   break;
	               case(12):
	                   num+='C';
	                   break;
	               case(13):
	                   num+='D';
	                   break;
	               case(14):
	                   num+='E';
	                   break;
	               case(15):
	                   num+='F';
	                   break;
	           } 
	        }else{
	           num+=tmp;
	        }
	 }
	 return num;
}



</script>
 

<script type="text/javascript">
var g_zt="";
var add_dialog;
function ds_add(){
	g_zt="0";
	var url = 'bt_bgpz.do?action=ds_add';
	add_dialog = new PWindow({
		title: "增加数据源",
        url:encodeURI(url,'utf-8'),
        buttons: [
                  {
                     label: '关闭',
                     cssClass: 'btn-default',
                     action: function(dialogItself){
                         dialogItself.close();
                  		}
               	  },
               	  {
                      label: '保存',
                      cssClass: 'btn-default',
                      action: function(dialogItself){
                    	  ds_save(dialogItself);
                   	  }
                  }
                ]
	});
}

var update_dialog;
function ds_update(){
	if(dsname==""){
		return;
	}
	g_zt="1";
	var dsname=$("#selectSjyName").val();
	var sqlscript=$("#selectSjySql").val();
	var url = 'bt_bgpz.do?action=ds_update&dsname='+dsname+'&sqlscript='+sqlscript;
	update_dialog = new PWindow({
		title: "修改数据源",
        url:encodeURI(url,'utf-8'),
        buttons: [
                  {
                     label: '关闭',
                     cssClass: 'btn-default',
                     action: function(dialogItself){
                    	 update_dialog.close();
                  		}
               	  },
               	  {
                      label: '保存',
                      cssClass: 'btn-default',
                      action: function(dialogItself){
                    	  ds_save(update_dialog);
                   	  }
                  }
                ]
	});
}

function ds_delete(){
	$("#div"+g_id).remove();
}

var dsname="";
var dsaray="";
var g_id="";
function click_change(id){
	 dsname = $("#name"+id).text();
	 dsaray = $("#sql"+id).text();
	 $("#selectSjyName").val(dsname);
	 $("#selectSjyId").val(id);
	 $("#selectSjySql").val(dsaray);
	 g_id=id;
	var yczbs  = document.getElementsByName("ds_bt");
	for(var i = 0 ; i<yczbs.length ;i++ ){
		if(yczbs[i].id == id){
			$("#"+id).removeClass("ft");
			$("#"+id).addClass("ft1");
		}else{
			$("#"+yczbs[i].id).removeClass("ft1");
			$("#"+yczbs[i].id).addClass("ft");
		}
	}
	//将列表字段 添加到列表属性中的 取数据源列 存数据源列
	var sql = $("#sql"+id).html();
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=sqlValidation', 
	    type: 'POST',
	    dataType: 'json',
	    data:{ jbdm: sql  }
	})
	.done(function(jsonObj) {
		var array = new Array();
		array=jsonObj[0].col;
		if(array[0]=="0"){
			$("#s_qsjyl").empty();
			$("#s_qsjyl").append("<option value=''>请选择</option>");
			for(var i=1; i<array.length; i++){
				$("#s_qsjyl").append("<option value='"+array[i]+"'>"+array[i]+"</option>");
			}
			$("#s_qsjyl").change();
		}
		$("#addSjydm").val(id);
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
	
}

function getCsjyl(tabName){
	var bglx=$("#bglx").val();
	if(bglx=="0"){
		return;
	}
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=getCsjyl', 
	    type: 'POST',
	    dataType: 'json',
	    data:{ tabName: tabName  }
	})
	.done(function(jsonObj) {
		if(jsonObj[0]!=null){
			$("#s_csjyl").empty();
			$("#s_csjyl").append("<option value=''>请选择</option>");
			for(var i=0; i<jsonObj.length; i++){
				$("#s_csjyl").append("<option value='"+jsonObj[i]+"'>"+jsonObj[i]+"</option>");
			}
			$("#s_csjyl").change();
		}else{
			$("#s_csjyl").empty();
			toastr.error("填报表名不存在!");
			return;
		}
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	}); 
}

function ds_save(dialogItself){
	if($("#ds_name").val()==""){
		toastr.error("数据源名称不能为空!");
		return;
	}
	
	if($("#sjysql").val()==""){
		toastr.error("数据源脚本不能为空!");
		return;
	}
	
	var sql=$("#sjysql").val();
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=sqlValidation', 
	    type: 'POST',
	    dataType: 'json',
	    data:{ jbdm: sql }
	})
	.done(function(jsonObj) {
		var array = new Array();
		array=jsonObj[0].col;
		if(array[0]=="0"){
			var id=createHexRandom();
			if(g_zt=="1"){
				$("#div"+g_id).remove();
				id=g_id;
			}
			var html="";
			html+="<div class=\"dropdown\" id=\"div"+id+"\">";
			html+="<button name=\"ds_bt\" id=\""+id+"\"  type=\"button\" class=\"btn dropdown-toggle ft text-overflow\" onclick=\"click_change(this.id)\" data-toggle=\"dropdown\">"+$("#ds_name").val();
			html+="		<span class=\"caret\"></span>";
			html+="		<input type=\"hidden\" name=\"sourceId\" value=\""+id+"\"/>";
			html+="		<span id=\"name"+id+"\" style=\"display:none\">"+$("#ds_name").val()+"</span>";
			html+="		<span id=\"sql"+id+"\" style=\"display:none\">"+$("#sjysql").val()+"</span>";
			html+="</button>";
			html+="    <ul class=\"dropdown-menu\" role=\"menu\" aria-labelledby=\""+id+"\">";
			for(var i=1; i<array.length; i++)
			{
			    html+="        <li role=\"presentation\">";
				html+="            <a role=\"menuitem\" tabindex=\"-1\">"+array[i]+"</a>";
				html+="        </li>";
			}
			html+="    </ul>";
			html+="</div>";
			$("#ds_map").append(html);
			click_change(id);
			dialogItself.close();
		}else{
			toastr.error("脚本错误!");
			return ;
		}
		
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
}


function duplicationCheck(a){
	return /(\x0f[^\x0f]+)\x0f[\s\S]*\1/.test("\x0f"+a.join("\x0f\x0f") +"\x0f");
}


function updateBgpz(dialogItself){
	//1、封装表格信息
	var bgid = $("#bgid").val();
	var bgdm = $("#bgdm").val();
	var bgmc = $("#bgmc").val();
	var lb = $("#lb").val();
	var fl = $("#fl").val();
	var cxtj = $("#cxtj").val();
	var jlzt = $("#jlzt").val();
	var bglx = $("#bglx").val();
	var tbbmc = $("#tbbmc").val();
	//2、按钮信息
	var an=new Array();
	$('input[name="an"]:checked').each(function(){ 
		an.push($(this).val()); 
	}); 
	//3、数据源信息
	var sjydm=new Array();
	var sjymc=new Array();
	var sjysql=new Array();
	$('input[name="sourceId"]').each(function(){ 
		sjydm.push($(this).val());
		sjymc.push($("#name"+$(this).val()).text());
		sjysql.push($("#sql"+$(this).val()).text());
	}); 
	//4、查询条件信息
	var tjid = new Array();
	var tjmc = new Array();
	var kjmc = new Array();
	var kjlx = new Array();
	var kjzt = new Array();
	var kjz = new Array();
	var mrz = new Array();
	var kjlxgs = new Array();
	var sy = new Array();
	var kjsx = new Array();
	$('input[name="tjid"]').each(function(){ 
		var id = $(this).val();
		tjid.push(id);
		tjmc.push($("#tjmc"+id).text().replace(/,/g,"!^"));
		kjmc.push($("#kjmc"+id).text().replace(/,/g,"!^"));
		kjlx.push($("#kjlx"+id).text().replace(/,/g,"!^"));
		kjzt.push($("#kjzt"+id).text().replace(/,/g,"!^"));
		kjz.push($("#kjz"+id).text().replace(/,/g,"!^"));
		mrz.push($("#mrz"+id).text().replace(/,/g,"!^"));
		kjlxgs.push($("#kjgs"+id).text().replace(/,/g,"!^"));
		sy.push($("#kjsy"+id).text().replace(/,/g,"!^"));
		kjsx.push($("#kjsx"+id).text().replace(/,/g,"!^"));
	});
	//5、查询结果信息
	var kjid = new Array();
	var s_btmc = new Array();
	var s_kjmc = new Array();
	var s_kjlx = new Array();
	var s_kjzt = new Array();
	var s_qsjyl = new Array();
	var s_kjz = new Array();
	var s_csjyl = new Array();
	var s_mrz = new Array();
	var s_kjgs = new Array();
	var s_sy = new Array();
	var s_bt = new Array();
	var s_yxbj = new Array();
	var s_jylx = new Array();
	var s_jydm = new Array();
	var s_tsxx = new Array();
	var s_xswz = new Array();
	var s_ljdz = new Array();
	var s_zxfs = new Array();
	var s_kzfx = new Array();
	var s_hzlx = new Array();
	var s_sjydm = new Array();
	var s_sx = new Array();
	var s_iszj = new Array();
	
	$('input[name="kjid"]').each(function(){ 
		var id = $(this).val();
		kjid.push(id);
		s_kjmc.push($("#s_kjmc"+id).text().replace(/,/g,"!^"));
		s_btmc.push($("#s_btmc"+id).text().replace(/,/g,"!^"));
		s_kjlx.push($("#s_kjlx"+id).text().replace(/,/g,"!^")); 
		s_kjzt.push($("#s_kjzt"+id).text().replace(/,/g,"!^")); 
		s_qsjyl.push($("#s_qsjyl"+id).text().replace(/,/g,"!^")); 
		s_kjz.push($("#s_kjz"+id).text().replace(/,/g,"!^")); 
		s_csjyl.push($("#s_csjyl"+id).text().replace(/,/g,"!^")); 
		s_mrz.push($("#s_mrz"+id).text().replace(/,/g,"!^")); 
		s_kjgs.push($("#s_kjgs"+id).text().replace(/,/g,"!^")); 
		s_sy.push($("#s_sy"+id).text().replace(/,/g,"!^"));
		s_bt.push($("#s_bt"+id).text().replace(/,/g,"!^"));
		s_yxbj.push($("#s_yxbj"+id).text().replace(/,/g,"!^"));
		s_jylx.push($("#s_jylx"+id).text().replace(/,/g,"!^")); 
		s_jydm.push($("#s_jydm"+id).text().replace(/,/g,"!^")); 
		s_tsxx.push($("#s_tsxx"+id).text().replace(/,/g,"!^")); 
		s_xswz.push($("#s_xswz"+id).text().replace(/,/g,"!^")); 
		s_ljdz.push($("#s_ljdz"+id).text().replace(/,/g,"!^")); 
		s_zxfs.push($("#s_zxfs"+id).text().replace(/,/g,"!^")); 
		s_kzfx.push($("#s_kzfx"+id).text().replace(/,/g,"!^")); 
		s_hzlx.push($("#s_hzlx"+id).text().replace(/,/g,"!^"));
		s_sjydm.push($("#s_sjydm"+id).text().replace(/,/g,"!^"));
		s_sx.push($("#s_sx"+id).text().replace(/,/g,"!^"));
		s_iszj.push($("#s_iszj"+id).text());
	});
	
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=saveOrUpdate', 
	    type: 'POST',
	    dataType: 'html',
	    data:{
	    	//状态位
	    	opt:'update',
	    	//表格信息
	    	bgid:bgid,bgdm:bgdm,bgmc:bgmc,lb:lb,fl:fl,cxtj:cxtj,jlzt:jlzt,bglx:bglx,tbbmc:tbbmc,
	    	//按钮信息
	    	an:JSON.stringify(an),
	    	//数据源信息
	    	sjydm:JSON.stringify(sjydm),sjymc:JSON.stringify(sjymc),sjysql:JSON.stringify(sjysql),
	    	//查询条件
	    	tjid:JSON.stringify(tjid),tjmc:JSON.stringify(tjmc),kjmc:JSON.stringify(kjmc),kjlx:JSON.stringify(kjlx),
	    	kjzt:JSON.stringify(kjzt),kjz:JSON.stringify(kjz),mrz:JSON.stringify(mrz),kjlxgs:JSON.stringify(kjlxgs),
	    	sy:JSON.stringify(sy),kjsx:JSON.stringify(kjsx),
	    	//查询结果
	    	kjid:JSON.stringify(kjid),s_kjmc:JSON.stringify(s_kjmc),s_btmc:JSON.stringify(s_btmc),s_kjlx:JSON.stringify(s_kjlx),s_kjzt:JSON.stringify(s_kjzt),
	    	s_qsjyl:JSON.stringify(s_qsjyl),s_kjz:JSON.stringify(s_kjz),s_csjyl:JSON.stringify(s_csjyl),s_mrz:JSON.stringify(s_mrz),
	    	s_kjgs:JSON.stringify(s_kjgs),s_sy:JSON.stringify(s_sy),s_bt:JSON.stringify(s_bt),s_yxbj:JSON.stringify(s_yxbj),
	    	s_jylx:JSON.stringify(s_jylx),s_jydm:JSON.stringify(s_jydm),s_tsxx:JSON.stringify(s_tsxx),s_xswz:JSON.stringify(s_xswz),
	    	s_ljdz:JSON.stringify(s_ljdz),s_zxfs:JSON.stringify(s_zxfs),s_kzfx:JSON.stringify(s_kzfx),s_hzlx:JSON.stringify(s_hzlx),
	    	s_sjydm:JSON.stringify(s_sjydm),s_sx:JSON.stringify(s_sx),s_iszj:JSON.stringify(s_iszj)
	    }
	})
	.done(function(jsonObj) {
		if(jsonObj=="0"){
			 toastr.success('保存成功！');
			 window.location.reload(); 
		}
		if(jsonObj=="1"){
			 toastr.error('保存失败！');
		}
		if(jsonObj=="2"){
			 toastr.success('更新成功！');
			 dialogItself.close();
			 searchbgpz();
		}
		if(jsonObj=="3"){
			 toastr.error('更新失败！');
		}
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
}


</script>