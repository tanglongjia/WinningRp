<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%
	String headPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+headPath+"/";
%>
 

    <div class="row" >
        <div class="col-md-12"  >
        <!-- 表格管理----------------------------------------- -->			
          <div class="box">
          	<div class="box-header with-border" style="color:#036EB7">
				  <span style="color:#036EB7">报表属性</span>
            		   <div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse" >
							<i class="fa fa-minus"></i>
						</button>
						<button type="button" class="btn btn-box-tool"
							data-widget="remove">
							<i class="fa fa-times"></i>
						</button>
					</div>
			</div>
            <div class="box-body"    >
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
						    	<option value='1'  <c:if test="${dataMap['bgpz']['CXTJXS'] == 1 }">selected</c:if>>隐藏</option>
						    </select>
				        </div>
	        			<div class="col-md-3">
	        				 记录状态: 
						    <select class="form-control" id="jlzt" style="min-width: 180px;" onchange="changeCssColor()">
						    	<option value='0' style='color:black' <c:if test="${dataMap['bgpz']['JLZT'] == 0 }">selected</c:if>>启用</option>
						    	<option value='1' style='color:red' <c:if test="${dataMap['bgpz']['JLZT'] == 1 }">selected</c:if>>停用</option>
						    </select>
				        </div>
				        <div class="col-md-3">
	        				 表格类型: 
						    <select class="form-control" id="bglx" style="min-width: 180px;" onchange="setEdit()">
						    	<option value='1' <c:if test="${dataMap['bgpz']['BGLX'] == 1 }">selected</c:if>>填报</option>
						    	<option value='0' <c:if test="${dataMap['bgpz']['BGLX'] == 0 }">selected</c:if>>查询</option>
						    </select>
				        </div>
	        			<div class="col-md-3">
	        				 填报表名称: 
						    <input class="form-control" id="tbbmc" style="min-width: 180px;" value="${dataMap['bgpz']['TBBMC']}" onchange="getCsjyl(this.value)"/>
				        </div>
				    </div>
				 
			</div>
	     </div>
	     
         <!-- 数据源 ----------------------------------------->	
	    <div class="row" style="margin-top:-10px;">
	    	<div class="col-md-2" style="padding-right:0px;">
           	<div class="box">
				<div class="box-header with-border" style="color:#036EB7">
					  <span style="color:#036EB7"  >数据源</span>
	            		   <div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
							<button type="button" class="btn btn-box-tool" data-widget="remove">
								<i class="fa fa-times"></i>
							</button>
						</div>
				</div>
				<div class="box-body" style="min-height:320px;">
					    <button onclick="ds_add()" class="btn btn-success glyphicon glyphicon-plus" style="padding-left: 5px; padding-right: 5px; padding-top: 2px; padding-bottom: 2px;"></button>
					    <button onclick="ds_update()" class="btn btn-warning glyphicon glyphicon-pencil" style="padding-left: 5px; padding-right: 5px; padding-top: 2px; padding-bottom: 2px;"></button>
					    <button onclick="ds_delete()" class="btn btn-danger glyphicon glyphicon-remove" style="padding-left: 5px; padding-right: 5px; padding-top: 2px; padding-bottom: 2px;"></button>
					    <br/>
					    <div class="row">
					    	<div class="col-md-12" id="ds_map">
					    		
					    	</div>
					    </div>
				</div>
           		 
	        </div> 
	        </div>
			
	     <div class="col-md-10" style="border-right: 1px solid #EEEEEE; padding-left:10px;">
	 <!-- 按钮管理----------------------------------------- -->				      
		 <div class="box">
				<div class="box-header with-border" style="color:#036EB7">
					  <span style="color:#036EB7"  >按钮管理</span>
	            		   <div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
							<button type="button" class="btn btn-box-tool"
								data-widget="remove">
								<i class="fa fa-times"></i>
							</button>
						</div>
				</div>
				<div class="box-body" id="buttonTool">
					 
				</div>
	         </div>
	 <!-- 查询条件 ---------------------------------------->
		 <div class="row"> 
			 <div class="col-md-6" style="padding-right:0px;">
		        <div class="box" style="margin-top:-10px;">
					<div class="box-header with-border" style="color:#036EB7">
						  <span style="color:#036EB7"  >查询条件</span>
		            		   <div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool" data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove">
									<i class="fa fa-times"></i>
								</button>
							</div>
					</div>
					<div class="box-body" >
							<div class="row">
			       				<div class="col-md-12" style="border-right: 1px solid #EEEEEE;">
			       					<div class="row"  >
			        					<div class="col-md-12" >
					        				  <button onclick="initModal()" class="btn btn-sm btn-success glyphicon glyphicon-plus" data-toggle="modal" data-target="#myModal" style="  color: white;"></button> <br/>
			        					</div>
			        					<div class="col-md-12" id="cxtjJh" style="margin-top:5px;">
			        						<div style="width:100%;height:148px;overflow:auto">
				        				  		<table id="cxtj_table" style="width:100%">
				        				  			 
				        				  		</table>
			        				  		</div>
			        				  	</div>
			        				</div>
			       				</div>
			       				
			       				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							    <div class="modal-dialog" style="width:700px;">
							        <div class="modal-content">
							            <div class="modal-header" style="background-color:#337AB7">
							                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							                <h4 class="modal-title" id="myModalLabel" style="color:white">查询条件</h4>
							            </div>
							            <div class="modal-body">
							            	
							       				<div class="row" style="min-height: 150px;">
							        				 	<div class="col-md-12">
							        				 		<label class="col-lg-2 col-md-2" style="text-align:right;margin-top:8px;">条件名称:</label>
										        			<div class="col-md-2">
										        				 <input class="form-control" id="tjmc" />
								        					</div>
								        					<label class="col-lg-2 col-md-2" style="text-align:right;margin-top:8px;">控件名称:</label>
								        					<div class="col-md-2">
										        				 <input class="form-control" id="kjmc" />
								        					</div>
								        					<label class="col-lg-2 col-md-2" style="text-align:right;margin-top:8px;">控件类型:</label>
								        					<div class="col-md-2">
															    <select class="form-control" id="kjlx" onchange="changeTip(this.id)"  >
															    </select>
													        </div>
							        				 	</div>
							        					<div class="col-md-12" style="padding-top: 10px;">
							        					
							        						<label class="col-lg-2 col-md-2" style="text-align:right;margin-top:8px;"> 控件状态:</label>
							        				 		<div class="col-md-2">
															    <select class="form-control" id="kjzt"  >
															    	<option value='0'>显示</option>
															    	<option value='1'>隐藏</option>
															    </select>
													        </div>
													        <label class="col-lg-2 col-md-2" style="text-align:right;margin-top:8px;">控件值:</label>
								        					<div class="col-md-2">
										        				 <input class="form-control" id="kjz" title="" onchange="validateScript(this.id)" />
								        					</div>
								        					<label class="col-lg-2 col-md-2" style="text-align:right;margin-top:8px;">默认值:</label>
								        					<div class="col-md-2">
										        				 <input class="form-control" id="mrz"  />
													        </div>
							        				 	</div>
							        				 	
												        <div class="col-md-12" style="padding-top: 10px;">
												        	<label class="col-lg-2 col-md-2" style="text-align:right;margin-top:8px;">控件格式:</label>
								        					<div class="col-md-2">
										        				
										        				 <input class="form-control" id="kjgs"  />
								        					</div>
								        					<label class="col-lg-2 col-md-2" style="text-align:right;margin-top:8px;"> 控件水印:</label>
								        					<div class="col-md-2">
										        				 <input class="form-control" id="kjsy"  />
													        </div>
													        <label class="col-lg-2 col-md-2" style="text-align:right;margin-top:8px;">控件顺序:</label>
													        <div class="col-md-2">
										        				 <input class="form-control" id="kjsx"  />
													        </div>
							        				 	</div>
							        				</div>
							            	
							            </div>
							            <div class="modal-footer">
							                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							                <button type="button" class="btn btn-primary" onclick="tr_add_modal()">保存</button>
							            </div>
							        </div> 
							    </div> 
			       			</div>
			       			</div>
					</div>
          		</div>
          		</div>
         				
		        				 
		<!-- 显示结果 -->		
	<div class="col-md-6" style="padding-left:5px;">
		 <div class="box" style="margin-top: -10px; ">
				<div class="box-header with-border" style="color:#036EB7">
					  <span style="color:#036EB7"  >显示结果</span>
	            		   <div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
							<button type="button" class="btn btn-box-tool" data-widget="remove">
								<i class="fa fa-times"></i>
							</button>
						</div>
				</div>
				<div class="box-body" >
							<div class="row">
		        				<div class="col-md-12" style="border-right: 1px solid #EEEEEE;">
		        					<div class="row"   >
				        				  <div class="col-md-12" style="height:30px;">
					        				  <button onclick="initModal2()"  class="btn btn-sm btn-success glyphicon glyphicon-plus" data-toggle='modal' data-target='#myModal2' style="  color: white;"></button><br/><br/>
			        					</div>
			        					 	<div class="col-md-12" id="xsjgJh" style="margin-top:5px">
			        					 		<div style="width:100%;height:148px;overflow:auto">
				        					 		<table id="xsjg_table" style="width:100%">
					        				  			 
					        				  		</table>
			        					 		</div>
				        				  		
				        				  	</div>
			        				</div>
		        				</div>
		        				
		        				<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							    <div class="modal-dialog" style="width:700px;">
							        <div class="modal-content">
							            <div class="modal-header" style="background-color:#337AB7">
							                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							                <h4 class="modal-title" id="myModalLabel" style="color:white">显示结果</h4>
							            </div>
							            <div class="modal-body">
							            	
							        				<div class="row"  >
									        				 <div class="col-md-12" >
																<ul id="myTab" class="nav nav-tabs">
																	<li class="active"><a href="#1" data-toggle="tab">列表属性</a></li>
																	<li><a href="#2" data-toggle="tab">控件属性</a></li>
																</ul>
																<div id="myTabContent" class="tab-content">
																	<div class="tab-pane fade in active" id="1">
																		<div class="row" style="padding-top: 10px;">
																			<div class="col-md-2" style="margin-top:8px;text-align:right">列名:</div>
																			<div class="col-md-4">
																				<input class="form-control" id="s_btmc"  />
																			</div>
																			<div class="col-md-2" style="margin-top:8px;text-align:right">控件名称:</div>
																			<div class="col-md-4">
																				<input class="form-control" id="s_kjmc"  />
																			<input  id="addSjydm" type="hidden" value=""/>
																			</div>
																      	</div>
																      	<div class="row" style="padding-top: 10px;">
																      			<div class="col-md-2" style="margin-top:8px;text-align:right">控件类型:</div>
																      			<div class="col-md-4">
																      				<select class="form-control" id="s_kjlx" onchange="changeTip(this.id)">
																      				</select>
																      			</div>
																				<div class="col-md-2" style="margin-top:8px;text-align:right">控件状态:</div>
																				<div class="col-md-4">
																					<select class="form-control" id="s_kjzt"  >
																						<option value='0'>显示</option>
																						<option value='1'>隐藏</option>
																					</select>
																				</div>
																      	</div>
																      	<div class="row" style=" padding-top: 10px;">
																			<div class="col-md-2" style="margin-top:8px;text-align:right">取-数据源列:</div>
																			<div class="col-md-4">
																				<select class="form-control" id="s_qsjyl" >
																				</select>
																			</div>
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">控件值:</div>
																      		<div class="col-md-4">
																				<input class="form-control" id="s_kjz" onchange="validateScript(this.id)"  title="" />
																      		</div>
																     	</div>
																     	<div class="row" style=" padding-top: 10px;">
																      		<div class="col-md-2" style="margin-top:8px;text-align:right" >存-数据源列:</div>
																      		<div class="col-md-4">
																				<select class="form-control" id="s_csjyl">
																					 <option value=""></option>
																				</select>
																				<input type="checkbox" name="iszj" id="s_iszj" value="1" title="是否主键"/>
																      		</div>
																			<div class="col-md-2" style="margin-top:8px;text-align:right">默认值:</div>
																			<div class="col-md-4">
																				<input class="form-control" id="s_mrz"  />
																      		</div>
																        </div>
																        <div class="row" style="padding-top: 10px;">
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">校验类型:</div>
																      		<div class="col-md-4">
																				<select class="form-control" id="s_jylx" onchange="AddPlaceholder()"  >
																				</select>
																      		</div>
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">校验代码:</div>
																      		<div class="col-md-4">
																				<input class="form-control" id="s_jydm" placeholder=""  />
																      		</div>
																      	</div>	
																        <div class="row" style=" padding-top: 10px;">
																        	<div class="col-md-2" style="margin-top:8px;text-align:right">提示信息:</div>
																        	<div class="col-md-4">
																				<input class="form-control" id="s_tsxx"  />
																      		</div>
																      		<div class="col-md-2"  style="margin-top:8px;text-align:right">控件顺序:</div>
																	      		<div class="col-md-4">
																					<input class="form-control" id="s_sx"  />
																	      		</div>
																	        </div>
																		</div>
																	
																	<div class="tab-pane fade" id="2">
																		<div class="row" style="padding-top: 10px;">
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">控件格式:</div>
																      		<div class="col-md-4">
																				<input class="form-control" id="s_kjgs"  title=""  />
																      		</div>
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">水印:</div>
																      		<div class="col-md-4">
																				<input class="form-control" id="s_sy"  />
																      		</div>
																      	</div>
																      	<div class="row" style="padding-top: 10px;">
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">必填:</div>
																      		<div class="col-md-4">
																				<select class="form-control" id="s_bt"  >
																					<option value='0'>否</option>
																					<option value='1'>是</option>
																				</select>
																      		</div>
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">允许编辑:</div>
																      		<div class="col-md-4">
																				<select class="form-control" id="s_yxbj"  >
																					<option value='1'>是</option>
																					<option value='0'>否</option>
																				</select>
																      		</div>
																     	</div>
																      	<div class="row" style="padding-top: 10px;">
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">扩展方向:</div>
																      		<div class="col-md-4">
																				<select class="form-control" id="s_kzfx"  >
																					<option value='0'>无</option>
																					<option value='1'>纵向</option>
																					<option value='2'>横向</option>
																				</select>
																      		</div>
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">显示位置:</div>
																      		<div class="col-md-4">
																				<select class="form-control" id="s_xswz" >
																					<option value='0'>左</option>
																					<option value='1'>中</option>
																					<option value='2'>右</option>
																				</select>
																      		</div>
																      	</div>
																      	<div class="row" style="padding-top: 10px;">
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">链接地址:</div>
																      		<div class="col-md-4">
																				<input class="form-control" id="s_ljdz" />
																      		</div>
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">展现方式:</div>
																      		<div class="col-md-4">
																				<select class="form-control" id="s_zxfs"  >
																					<option value='0'>自动扩展</option>
																					<option value='1'>固定格式</option>
																				</select>
																      		</div>
																     	</div>
																     	<div class="row" style="padding-top: 10px;">
																      		<div class="col-md-2" style="margin-top:8px;text-align:right">汇总类型:</div>
																      		<div class="col-md-4">
																				<select class="form-control" id="s_hzlx"  >
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
							            <div class="modal-footer">
							                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							                <button type="button" class="btn btn-primary" onclick="show_tr_add_modal()">保存</button>
							            </div>
							        </div> 
							    </div> 
			      				
			       			</div>
		        			</div>
				</div>
				</div>
            </div>
       			</div>
      				  
	        </div>
	    </div>
    </div>
	<div class="box" style="margin-top:-10px;">
          <div class="box-header with-border" style="color:#036EB7">
		  		<span style="color:#036EB7"  >报表预览</span>
          		<div class="box-tools pull-right">
				<button type="button" class="btn btn-box-tool" data-widget="collapse">
					<i class="fa fa-minus"></i>
				</button>
				<button type="button" class="btn btn-box-tool" data-widget="remove">
					<i class="fa fa-times"></i>
				</button>
			</div>
	  	 </div>
         <div class="box-body" id="viewReport"  style="height:300px">
         	<span style="display:none" id="iframeWarn">
         		该报表尚未设置表格列，请设置！
         	</span>
           	<iframe id="iframeDisplay"   height="100%" width="100%"  frameborder="0" >
           		
           	</iframe>
	  	 </div>
     </div>
<input type="hidden" id="selectSjyId"/>
<input type="hidden" id="selectSjyName"/>
<input type="hidden" id="selectSjySql"/>
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

	dataId = '';
	dataMc = '';
	dataYj = '';
	operateType = '1';
	
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

	var iframeUrl = "<%=basePath%>rpView/${dataMap['bgpz']['BGDM']}";
	
	iframeSrcJudge(iframeUrl);

	changeCssColor();
});


function iframeSrcJudge(reportUrl){
	// 前提：根据后台取到的路径值为reportUrl,下面就来判断路径是否存在，这段代码来源于网络，我试了可以判断成功。
	var reportUrl = reportUrl.replace(/\\/g,"/");
	var obj = document.getElementById("iframeDisplay");
	var xmlhttp =new XMLHttpRequest();
	if(xmlhttp.overrideMimeType)
	{
	    xmlhttp.overrideMimeType('text/xml');
	}
	else if(window.ActiveXObject)
	{
	    try
	    {
	        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	    }catch(e)
	    {
	        try
	        {
	            xmlhttp =  new ActiveXObject("Microsoft.XMLHTTP");
	        }catch(e2)
	        {
	        }
	   }  
	}   
	xmlhttp.open("POST",reportUrl,false);  
	xmlhttp.send(null);
	//console.log(xmlhttp.responseText.length);
	if(xmlhttp.responseText.indexOf('exception')!=-1){
		$("#iframeWarn").css("display","");
		obj.src = "";
	}else{
		$("#iframeWarn").css("display","none");
		obj.src = reportUrl;
	}
	/*if(xmlhttp.readyState == 4 && xmlhttp.Status == 200)
	{
	    obj.src = reportUrl;
	}
	else
	{
	    obj.src = "";
	}*/
}

//记录状态下拉框显示颜色更改
function changeCssColor(){
	if($("#jlzt").val()=='1'){
		$("#jlzt").css("color",'red');
	}else{
		$("#jlzt").css("color",'black');
	}
}
 

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
			toastr.info("填报表名不存在!");
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
			table_tr+="		<td style=\"text-align: center;\">"+cxtjtjmc[i]+"</td>";
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
			table_tr+="			<button class=\"btn btn-sm btn-warning glyphicon glyphicon-pencil\"  data-toggle='modal' data-target='#myModal' style=\"color: white;\" ";
			table_tr+="			onclick=\"tr_edit('"+trid+"')\"	 >";
			table_tr+="			</button>";
			table_tr+="			<button class=\"btn btn-sm btn-danger glyphicon glyphicon-remove\" style=\"color: white;\" ";
			table_tr+="				onclick=\"tr_del('"+trid+"')\">";
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
			table_tr+="		<td id=\"s_btmc"+trid1+"\" style=\"text-align: center;\">"+xsjgbtmc[i]+"</td>";
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
			table_tr+="			<button class=\"btn btn-sm btn-warning glyphicon glyphicon-pencil\" data-toggle='modal' data-target='#myModal2'  style=\"color: white;\" ";
			table_tr+="			onclick=\"show_tr_edit('"+trid1+"')\"  >";
			table_tr+="			</button>";
			table_tr+="			<button class=\"btn btn-sm btn-danger glyphicon glyphicon-remove\" style=\"color: white;\" ";
			table_tr+="				onclick=\"show_tr_del('"+trid1+"')\">";
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
		    async: false,
		    data:{ jbdm: sql,mc:mc,id:id  }
		}).done(function(jsonObj) {
			var array = new Array();
			array=jsonObj[0].col;
			id = jsonObj[0].sqlid;
			mc = jsonObj[0].sqlmc;
			sql = jsonObj[0].sql;
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
				for(var j=1; j<array.length; j++)
				{
				    html+="        <li role=\"presentation\">";
					html+="            <a role=\"menuitem\" tabindex=\"-1\">"+array[j]+"</a>";
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
					option+="<input name=\"an\" type=\"checkbox\" checked value=\""+jsonObj[i].ANDM+"\"/>&nbsp;"+jsonObj[i].ANMC+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}else{
					option+="<input name=\"an\" type=\"checkbox\" value=\""+jsonObj[i].ANDM+"\"/>&nbsp;"+jsonObj[i].ANMC+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
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
			toastr.info(message);	 
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
	var url = 'bt_bgpz.do?action=ds_update&dsname='+dsname+'&sqlscript='+ sqlscript;
	update_dialog = new PWindow({
		title: "修改数据源",
        url:encodeURI(url,'utf-8').replace(/\+/g,'%2B'),
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
			if($("#bglx").val()=="1"){
				toastr.error("填报表名不存在!");
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

function setEdit(){
	var bglx=$("#bglx").val();
	if(bglx=="1"){
		$("#s_yxbj").val("1")
	}else{
		$("#s_yxbj").val("0")
	}
}

function ds_save(dialogItself){
	if($("#ds_name").val()==""){
		toastr.info("数据源名称不能为空!");
		return;
	}
	
	if($("#sjysql").val()==""){
		toastr.info("数据源脚本不能为空!");
		return;
	}
	loadMessage();
	var sql=$("#sjysql").val();
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=sqlValidation', 
	    type: 'POST',
	    dataType: 'json',
	    data:{ jbdm: sql }
	})
	.done(function(jsonObj) {
		hideMessage();
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


 


</script>