<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String headPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+headPath+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script type="text/javascript">
    	var baseURL = "<%=basePath%>";
    </script>
    <base href="<%=basePath%>"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link href="<%=basePath%>assertsRp/bootstrap/dist/css/bootstrap.css" rel="stylesheet">
    <!-- Theme style -->
    <!-- AdminLTE Skins. Choose a skin from the css/skins
    folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="<%=basePath%>assertsRp/css/_all-skins.min.css">
    <link href="<%=basePath%>assertsRp/bootstrap-table/bootstrap-table.css" rel="stylesheet"/>
    <link href="<%=basePath%>assertsRp/bootstrap-dialog/bootstrap-dialog.min.css" rel="stylesheet"/>
    <link href="<%=basePath%>assertsRp/bootstrap-table/bootstrap-table-fixed-columns.css" rel="stylesheet"/>

    <link href="<%=basePath%>assertsRp/css/AdminLTE.min.css" rel="stylesheet">
    <link href="<%=basePath%>assertsRp/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>assertsRp/css/_all-skins.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>assertsRp/css/bootstrap_extra.css" rel="stylesheet"/>
    <link href="<%=basePath%>assertsRp/easyui/themes/bootstrap/tree.css" rel="stylesheet"/>
    <link href="<%=basePath%>assertsRp/easyui/themes/bootstrap/tooltip.css" rel="stylesheet"/>
    <!-- combobox所需css -->
    <link href="<%=basePath%>assertsRp/easyui/themes/bootstrap/textbox.css" rel="stylesheet"/>
    <link href="<%=basePath%>assertsRp/easyui/themes/bootstrap/combo.css" rel="stylesheet"/>
    <link href="<%=basePath%>assertsRp/easyui/themes/bootstrap/combobox.css" rel="stylesheet"/>
    <!-- jQuery 1.9 -->
    <script src="<%=basePath%>assertsRp/jquery/dist/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="<%=basePath%>assertsRp/easyui/jquery.easyui.min.js"></script>
    <script src="<%=basePath%>assertsRp/js/jquery.placeholder.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="<%=basePath%>assertsRp/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>assertsRp/bootstrap-table/bootstrap-table.js"></script>
    <script src="<%=basePath%>assertsRp/bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script src="<%=basePath%>assertsRp/bootstrap-table/bootstrap-fixed-column.js"></script>
    <script src="<%=basePath%>assertsRp/js/bootstrap_extra.js"></script>
    <script src="<%=basePath%>assertsRp/bootstrap-dialog/bootstrap-dialog.min.js"></script>
	<script src="<%=basePath%>assertsRp/js/app.js?v=2.2"></script>
	<script src="<%=basePath%>assertsRp/js/demo.js"></script>
	<script src="<%=basePath%>assertsRp/js/html5shiv.js"></script>
    <script type="text/javascript" src="<%=basePath%>assertsRp/js/toastr.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>assertsRp/css/toastr.min.css">

    <!-- tooltip插件-->
    <script src="<%=basePath%>assertsRp/poshytip-1.2/src/jquery.poshytip.js"></script>
    <link href="<%=basePath%>assertsRp/poshytip-1.2/src/tip-skyblue/tip-skyblue.css" rel="stylesheet">
	<style>
		.ft{  background-color: white;  }
		.ft1{ background-color: #CCCCCC;  }
	
		.text-overflow{
			width:100%;
			overflow:hidden;
			text-overflow:ellipsis;
			white-space:nowrap;
			text-align: left;
		}
	</style>
</head>
 
	<div class="panel-body" style="background-color:#ECF0F5">
		<div class="box win-search-box">
			<div class="box-header">
	            <li class="fa box-search"></li>
	            <div class="box-title">功能配置</div>
	            <div class="box-tools">
	                <button type="button" class="btn btn-default btn-sm" style="float: right; color: white;"  onclick="queryAllReports()" >查看全部</button>
	                <button type="button" id="preSaveBtn" class="btn btn-default btn-sm" style="float: right; color: white;"  onclick="updateBgpz()" >保存</button>
	            </div>
	        </div>
		</div>
		<div class="box-body" style="margin-top:-20px;">	
			<div class="row" style="margin-left:-25px;"> 
				<div class="col-lg-3 col-md-3"  >
						<div style="width:100%;height:30px;background-color:#75ABD3;">
							<div style=" text-align:center;width:100%;height:30px;color:white;font-size:14px;line-height:25px;font-weight:bold;margin:0 auto; ">
								<span>报表名称</span>
								<div  style=" display:inline;float:right;margin-right:5px;">
									<img src="assertsRp/css/images/icon_新增.png;" onclick="insertNewRow()" style="cursor:pointer"  />
								</div>
							</div>
						</div>
					 	
					     <div style="width:100%;height:30px;background-color:#c8dded;">
					     	    <div style="float:left;;height:30px;background-color:#EAF2FD;padding-top:6px;">&nbsp;类型：</div>
					     		<select onchange="initTableNew()" id="bglx" style="float:left;border:none;height:30px;background-color:#EAF2FD;outline:none">
					     			<option value='1'>填报</option>
					     			<option value='0'>查询</option>
					     			<option value=''>全部</option>
					     		 </select>
					     		 <div style="height:30px;width:59.8%; float:left; ">
							     	<input type="text" id="bbmcNew" oninput="initTableNew()" style="border:0px;background-color:#c8dded; width:100%;height:30px;outline:none" placeholder="输入搜索内容" >
							     </div>
					     </div>
					     <div id="leftDiv">
					     
					     </div>
				</div>
				<div class="col-lg-9 col-md-9" id="rightDivNew" style="padding:0px;padding-right:4px;" >
				</div>			  
	       </div>
	   </div>
	</div>
 
<script type="text/javascript">

function tr_add(code){
	operateType = "1";
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
		table_tr+="		<td style=\"text-align: center;\">"+$("#tjmc").val()+"</td>";
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
		table_tr+="			<button class=\"btn btn-sm btn-warning glyphicon glyphicon-pencil\" data-toggle='modal' data-target='#myModal' style=\"color: white;\" ";
		table_tr+="			onclick=\"tr_edit('"+trid+"')\" >";
		table_tr+="			</button>";
		table_tr+="			<button class=\"btn btn-sm btn-danger glyphicon glyphicon-remove\" style=\"color: white;\"  ";
		table_tr+="				onclick=\"tr_del('"+trid+"')\">";
		table_tr+="			</button>";
		table_tr+="		</td>";
		table_tr+="</tr>";
	//修改
	if(code=="2"){
		$("#"+u_trid).after(table_tr);
		$("#"+u_trid).remove();
		u_trid="";
	}else{
		$("#cxtj_table").append(table_tr);
	}
	
}

//新增按钮将modal置空
function initModal(){
	operateType = '1';
	$("#tjmc").val("");
	$("#kjmc").val("");
	$("#kjz").val("");
	$("#mrz").val("");
	$("#kjgs").val("");
	$("#kjsy").val("");
	$("#kjsx").val("");
}

function tr_add_modal(){
	if(operateType=='2'){
		tr_add('2');
	}else{
		tr_add('1');
	}
		
	$("#myModal").modal('hide');
}

function tr_del(id){
	$("tr[id="+id+"]").remove();
	//var row = $(id).parent().parent().index();
	//$("#cxtj_table tr").eq(row).remove();
}

var u_trid="";
function tr_edit(id){
	operateType = '2';
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

	        		
function show_tr_add(code){
	operateType = '1';
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
		alert("存数据源列不能为空！");
		return;
	}
	*/
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
		table_tr+="		<td  style=\"text-align: center;\">"+$("#s_btmc").val()+"</td>";
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
		table_tr+="			<button class=\"btn btn-sm btn-warning glyphicon glyphicon-pencil\" data-toggle='modal' data-target='#myModal2' style=\"color: white;\" ";
		table_tr+="				onclick=\"show_tr_edit('"+trid1+"')\" >";
		table_tr+="			</button>";
		table_tr+="			<button class=\"btn btn-sm btn-danger glyphicon glyphicon-remove\"  style=\"color: white;\" ";
		table_tr+="				onclick=\"show_tr_del('"+trid1+"')\">";
		table_tr+="			</button>";
		table_tr+="		</td>";
		table_tr+="</tr>";
	//修改
	if(code=="2"){
		$("#"+xsjg_trid).after(table_tr);
		$("#"+xsjg_trid).remove();
		xsjg_trid="";
	}else{
		$("#xsjg_table").append(table_tr);
	}
	
}


function initModal2(){
		operateType = '1';
		$("#s_btmc").val("");
		$("#s_kjmc").val("");
		$("#s_kjz").val("");
		$("#s_mrz").val("");
		$("#s_kjgs").val("");
		$("#s_sy").val("");
		$("#s_jydm").val("");
		$("#s_tsxx").val("");
		$("#s_ljdz").val("");
		$("#s_sx").val("");
		$("#s_iszj").val("0");
}



function show_tr_del(id){
	$("tr[id="+id+"]").remove();
}

function show_tr_add_modal(t){
	if(operateType=='2'){
		show_tr_add('2');
	}else{
		show_tr_add('1');
	}
	$("#myModal2").modal('hide');
}

var xsjg_trid="";
function show_tr_edit(id){
	operateType = '2';
	xsjg_trid = id;
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


var bbdm_g="";

$('#s_iszj').poshytip({
	className: 'tip-skyblue', bgImageFrameSize: 9,
	offsetX: 0,
	offsetY: 20
});

//配置日期、控件值等格式提醒
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
		var val2=$("#"+id).val();
		if(val2=="3"){
			$("#s_kjz").attr("title","返回结果列必须是code和name");
			$('#s_kjz').poshytip({
				className: 'tip-skyblue', bgImageFrameSize: 9 
			});
		}else{
			$("#s_kjz").attr("title","");
			$('#s_kjz').poshytip('destroy');
		}

		if(val2=="5"){
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
	$('#bgdm').val(createHexRandom());
	getButtonTool();
	getKjlx();

	operateType = '1';
	//
	initTableNew();

});

var queryAllReport_dialog;
function queryAllReports(){
	var url = 'bt_bgpz.do?action=queryAllReports';
	queryAllReport_dialog = new PWindow({
        title: "查看全部",
        url: encodeURI(url, 'utf-8'),
    });
}





function initTableNew(){
	//先置空table
	$('#leftTable').bootstrapTable('destroy');
	//从后台加载数据
	loadMessage();
	$.ajax({
        type: 'POST',
        url : 'bt_bgpz.do?action=bgpzTableInitNew&bglx='+$("#bglx").val()+"&bbmc="+$("#bbmcNew").val(),
        success : function(data){
           $("#leftDiv").html(data);
           setSelectItem($("#firstBGDM").val());
           $("#leftTable").bootstrapTable({
	           	showHeader : true,
	       		striped : true, //表格显示条纹  
	       		onClickRow:function(row,ele){
        	   		setSelectItem($(ele).attr("data-BGDM"));
          		}
           });
           
        },
        complete:function(XHR, TS){
        	hideMessage();
        }
		 
    });

    //rpView/TB_YXJZ_JCXX
}
function insertNewRow(){
	 $("#preSaveBtn").attr({"disabled":"disabled"});
	 var leftTable = $("#leftTable");  
	 var tr = $("<tr>"+
				"<td><div style='width:100%;height:100%; '>"+
				"<div style='width:80%;height:100%; float:left;text-align:left'>"+
				"<input type='text'   style='width:100%;height:100%' onchange='changeBbmcText(this)'></div>"+
				"<div style='width:20%;height:100%; float:right'>"+
				"<button onclick='insertBgpz()' style='background: url(\"assertsRp/css/images/button_bc.png;\") no-repeat;border: none;margin-top:5px; '>"+
				"<span style='color:white; '>保存</span></button>"+
				"</div> </div></td><tr>"
			 );
	 leftTable.prepend(tr);
}

function changeBbmcText(obj){
	$("#bgmc").val(obj.value);
}

function saveBgpzNew(){
	saveBgpz();
	$('#leftTable').bootstrapTable('refresh');
}

function setSelectItem(bgdm){
	loadMessage();
	var url = "bt_bgpz.do?action=updateBgNew&BGDM=" + bgdm;
	$.ajax({
        type: 'GET',
        url : url,
        success : function(data){
        
           $("#rightDivNew").html(data);
           //停用显示红色
        },
        complete:function(XHR, TS){
        	hideMessage();
        }
    });
}

var updateBg_dialog;
function previewNew(bgdm,e) {
    //防止内部button的事件影响外部div的事件
   	if(e.stopPropagation){ //非IE
   		e.stopPropagation();
   	}else{
   		e.cancelBubble = true;//ie
   	}
    var url = 'bt_bgpz.do?action=initPreViewNew&bgdm=' + bgdm;
    updateBg_dialog = new PWindow({
        title: "报表修改",
        url: encodeURI(url, 'utf-8'),
    });
}


function insertBgpz(){
	//1、封装表格信息
	var bgid = $("#bgid").val();
	var bgdm = createHexRandom();
	var bgmc = $("#bgmc").val();
	var lb = $("#lb").val();
	var fl = $("#fl").val();
	var cxtj = $("#cxtj").val();
	var jlzt = $("#jlzt").val();
	var bglx = $("#bglx").val();
	var tbbmc = $("#tbbmc").val();
	if(bgmc==""){
		toastr.info("表格名称不能为空!");
		return;
	}
	 
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=insertBgmcNew', 
	    type: 'POST',
	    dataType: 'html',
	    data:{
	    	//状态位
	    	opt:'add',
	    	//表格信息
	    	bgid:bgid,bgdm:bgdm,bgmc:bgmc,lb:lb,fl:fl,cxtj:cxtj,jlzt:jlzt,bglx:bglx,tbbmc:tbbmc,
	    	//按钮信息
	    }
	})
	.done(function(jsonObj) {
		hideMessage();
		if(jsonObj=="0"){
			toastr.success('保存成功！');
			 initTableNew();
			 $("#preSaveBtn").removeAttr('disabled');
		}
		if(jsonObj=="1"){
			toastr.error('保存失败！');
		}
		if(jsonObj=="2"){
			toastr.success('保存成功！');
			 
		}
		if(jsonObj=="3"){
			toastr.success('保存失败！');
		}
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
}


function updateBgpz(){
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
	if(bgmc==""){
		toastr.info("表格名称不能为空!");
		return;
	}
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
	loadMessage();
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
		hideMessage();
		if(jsonObj=="0"){
			toastr.success('保存成功！');
		}
		if(jsonObj=="1"){
			toastr.error('保存失败！');
		}
		if(jsonObj=="2"){
			toastr.success('更新成功！');
			 //initTableNew();
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
				if(jsonObj[i].ANDM=="1"){
					option+="<input name=\"an\" type=\"checkbox\" value=\""+jsonObj[i].ANDM+"\"/>&nbsp;"+jsonObj[i].ANMC+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}else{
					option+="<input name=\"an\" type=\"checkbox\" checked=\"checked\" value=\""+jsonObj[i].ANDM+"\"/>&nbsp;"+jsonObj[i].ANMC+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}
				//option+="<div class=\"col-sm-2\">";
				//option+="  <input type=\"checkbox\" class=\"hidden\"><div is=\"0\" class=\"btn-group m-b\" tabindex=\"0\"><a is=\"0\" class=\"btn btn-default\">No</a><a is=\"1\" class=\"btn active btn-success\">Yes</a></div>";
				//option+="</div>";
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
	jQuery.ajax({
	    url: 'bt_bgpz.do?action=getKjlx', 
	    type: 'POST', 
	    dataType: 'json'
	}) 
	.done(function(jsonObj) { 
		if(jsonObj.length > 0){
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
		} 
	}) 
	.fail(function() { 
		console.log("error"); 
	}) 
	.always(function() { 
		console.log("complete"); 
	});
}

function AddPlaceholder(){
	var val=$("#s_jylx").val();
	if(val=="rangelength_winning" || val=="range_winning" ){
		$("#s_jydm").attr("placeholder","XX,XX");
	}else{
		$("#s_jydm").attr("placeholder","");
	}
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
        			 alert('删除成功！');
        			 getZtbbzb();
        		}else{
        			 //alertMsg("删除失败！");
        			 alert('删除失败！');
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

//控件值脚本验证
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
			alert(message);	 
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
 
 

<input type="hidden" id="selectSjyId"/>
<input type="hidden" id="selectSjyName"/>
<input type="hidden" id="selectSjySql"/>
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
	alert(sqlscript);
	var url = 'bt_bgpz.do?action=ds_update&dsname='+dsname+'&sqlscript='+sqlscript;
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
				alert("填报表名不存在!");
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
	
	var param = '&';
	$("#tbody input").each(function(){
		param = param + this.name+"="+this.value+"&";
	});
	param = param.substring(0,param.length-1);
	loadMessage();
	var sql=$("#sjysql").val();
	jQuery.ajax({ 
	    url: 'bt_bgpz.do?action=sqlValidation'+param, 
	    type: 'POST',
	    dataType: 'json',
	    data:{ jbdm: sql  }
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


function saveBgpz(){
	//1、封装表格信息
	var bgdm = $("#bgdm").val();
	var bgmc = $("#bgmc").val();
	var lb = $("#lb").val();
	var fl = $("#fl").val();
	var cxtj = $("#cxtj").val();
	var jlzt = $("#jlzt").val();
	var bglx = $("#bglx").val();
	var tbbmc = $("#tbbmc").val();
	if(bgmc==""){
		toastr.info("表格名称不能为空!");
		return;
	}
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
	//alert("sjydm:"+sjydm+",sjymc:"+sjymc+",sjysql:"+sjysql);
	//4、查询条件信息
	var tjid = new Array();
	var tjmc = new Array();
	var kjmc = new Array();
	var kjlx = new Array();
	var kjzt = new Array();
	var kjz = new Array();
	var mrz = new Array();
	var kjlxgs = new Array();
	var kjsx = new Array();
	var sy = new Array();
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
	var s_kjmc = new Array();
	var s_btmc = new Array();
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
	    	opt:'add',
	    	//表格信息
	    	bgdm:bgdm,bgmc:bgmc,lb:lb,fl:fl,cxtj:cxtj,jlzt:jlzt,bglx:bglx,tbbmc:tbbmc,
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
			 window.location.reload(); 
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