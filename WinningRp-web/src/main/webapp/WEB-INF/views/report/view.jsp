<%--
  User: 项鸿铭
  Date: 2016/10/24
  Time: 0:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>卫宁填报报表</title>
    <!-- js所需 -->
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/js/html5shiv.min.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/plus/table/bootstrap-table.min.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/plus/table/bootstrap-table-zh-CN.min.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/plus/table/bootstrap-table-edit.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/plus/My97DatePicker/WdatePicker.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/plus/bootstrap-select.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/plus/table/bootstrap-table-export.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/plus/table/tableExport.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/js/common.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/js/bootstrap_extra.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/bootstrap-dialog/bootstrap-dialog.min.js"></script>
    <!-- 吐司插件 -->
    <script src="<%=request.getContextPath()%>/assertsRp/js/toastr.min.js"></script>
    <link href="<%=request.getContextPath()%>/assertsRp/css/toastr.min.css" rel="stylesheet">
    <!-- 验证所需-->
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/jquery-validation/jquery.validate.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/jquery-validation/additional-methods.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/editTable/jquery-validation/winning_validate.js"></script>
    <link href="<%=request.getContextPath()%>/assertsRp/editTable/jquery-validation/validate.css" rel="stylesheet">
    <!-- tooltip插件-->
    <script src="<%=request.getContextPath()%>/assertsRp/poshytip-1.2/src/jquery.poshytip.js"></script>
    <link href="<%=request.getContextPath()%>/assertsRp/poshytip-1.2/src/tip-skyblue/tip-skyblue.css" rel="stylesheet">
    <!-- date插件-->
    <script src="<%=request.getContextPath()%>/assertsRp/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <link href="<%=request.getContextPath()%>/assertsRp/bootstrap-datepicker/datepicker.css" rel="stylesheet">
    <!-- jqueryui插件-->
    <script src="<%=request.getContextPath()%>/assertsRp/jquery-ui/jquery-ui.js"></script>
    <link href="<%=request.getContextPath()%>/assertsRp/jquery-ui/jquery-ui.css" rel="stylesheet">
    <!--css所需-->
    <link href="<%=request.getContextPath()%>/assertsRp/editTable/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assertsRp/css/AdminLTE.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assertsRp/editTable/plus/table/bootstrap-table.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assertsRp/editTable/plus/datatime/bootstrap-datetimepicker.min.css"
          rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assertsRp/css/bootstrap_extra.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assertsRp/css/common.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assertsRp/bootstrap-dialog/bootstrap-dialog.min.css" rel="stylesheet"/>
    <!--[if lt IE 9]>
    <script src="<%=request.getContextPath()%>/assertsRp/js/html5shiv.js"></script>
    <script src="<%=request.getContextPath()%>/assertsRp/js/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        .winn_selected_style {
            background-color: #fcf194;
        }

        .fixed-table-container tbody td .th-inner, .fixed-table-container thead th .th-inner {
            padding: 8px;
            line-height: 24px;
            vertical-align: top;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: normal;
        }
    </style>
    <script type="text/javascript">
        function selectTr() {
            $("#reportTable tbody tr").each(function (index, element) {
                $(this).removeAttr("style");
            });
        }
        var selecedRowIndex = "";
        var applicationJson;
        $(function () {
            $("#saveTb").click(function () {
                console.log($("#reportTable").bootstrapTable('getData'));
                if ($("#reportTable").bootstrapTable('dataValidate')) {//先验证后保存
                    if (JSON.stringify($("#reportTable").bootstrapTable('getModiDatas')) != "[]") {
                        loadMessage();
                        $.ajax({
                            url: 'save',
                            type: 'POST',
                            dataType: 'JSON',
                            data: {
                                rpid: $("#rpid").val(),
                                //rpid: '2222',
                                updateData: JSON.stringify($("#reportTable").bootstrapTable('getModiDatas'))
                            },
                        }).done(function (data) {
                            hideMessage();
                            if (data.success) {
                                toastr.success("保存成功！");
                                $("#search").click();
                            } else {
                                toastr.warning(data.msg);
                            }
                            //  console.log("success");
                        }).fail(function () {
                            //  console.log("error");
                        }).always(function () {
                            // console.log("complete");
                        });
                    } else {
                        toastr.info("该表格未更改！");
                    }
                }
            })
        })
        $(function () {
            //查询按钮
            $("#search").click(function () {
                $("#WINNIGN_PAGEING_PAGENUMBER").val(1);
                // console.log(serializeObject($("#reportForm")));
                loadMessage();
                $.ajax({
                    url: 'search',
                    type: 'POST',
                    dataType: 'json',
                    data: serializeObject($("#reportForm")),
                }).done(function (data) {

                    hideMessage();
                    $("#reportTable").bootstrapTable('load', eval(data.datas));
                    data.datas = null;
                    // console.log(data);
                    applicationJson = data;
                    if (data.WINNING_TOTAL_COUNTS != undefined) {
                        $('#reportTable').bootstrapTable('refreshOptions', {
                            pagination: true,
                            onlyInfoPagination: false,
                            sidePagination: 'server',
                            pageNumber: 1,
                            pageSize: data.WINNING_PAGE_SIZE,
                            totalRows: data.WINNING_TOTAL_COUNTS,
                            onPageChange: function (number, size) {
                                $("#WINNIGN_PAGEING_PAGENUMBER").val(number);
                                loadMessage();
                                $.ajax({
                                    url: 'search',
                                    type: 'POST',
                                    dataType: 'json',
                                    data: serializeObject($("#reportForm")),
                                }).done(function (data) {
                                    hideMessage();
                                    $("#reportTable").bootstrapTable('load', eval(data.datas));
                                    data.datas = null;
                                    applicationJson = data;
                                }).fail(function () {
                                    // console.log("error");
                                }).always(function () {
                                    //  console.log("complete");
                                });
                            }
                        });
                    }
                }).fail(function () {
                    //console.log("error");
                }).always(function () {
                    //console.log("complete");
                });
            });
            //重置
            $("#resetForm").click(function () {
                $("#reportForm")[0].reset();
            })
            //数据校验按钮
            $("#dataValidate").click(function () {
                $("#reportTable").bootstrapTable('dataValidate');
            })
            //默认先查询
            loadMessage();
            $.ajax({
                url: 'search',
                type: 'POST',
                dataType: 'json',
                data: serializeObject($("#reportForm")),
            }).done(function (data) {
                //console.log(data);
                //console.log(data.WINNING_TOTAL_COUNTS == undefined);
                hideMessage();
                $("#reportTable").bootstrapTable('load', eval(data.datas));
                data.datas = null;
                applicationJson = data;
                //createFooter();
                //console.log(applicationJson);
                if (data.WINNING_TOTAL_COUNTS != undefined) {
                    $('#reportTable').bootstrapTable('refreshOptions', {
                        pagination: true,
                        onlyInfoPagination: false,
                        sidePagination: 'server',
                        pageNumber: 1,
                        pageSize: data.WINNING_PAGE_SIZE,
                        totalRows: data.WINNING_TOTAL_COUNTS,
                        onPageChange: function (number, size) {
                            $("#WINNIGN_PAGEING_PAGENUMBER").val(number);
                            loadMessage();
                            $.ajax({
                                url: 'search',
                                type: 'POST',
                                dataType: 'json',
                                data: serializeObject($("#reportForm")),
                            }).done(function (data) {
                                hideMessage();
                                $("#reportTable").bootstrapTable('load', eval(data.datas));
                                data.datas = null;
                                applicationJson = data;
                            }).fail(function () {
                                // console.log("error");
                            }).always(function () {
                                // console.log("complete");
                            });
                        }
                    });
                }
            }).fail(function () {
                //console.log("error");
            }).always(function () {
                //console.log("complete");
            });
        });
        var serializeObject = function (form) {
            var o = {};
            $.each(form.serializeArray(), function (index) {
                if (this['value'] != undefined && this['value'].length > 0) {// 如果表单项的值非空，才进行序列化操作
                    if (o[this['name']]) {
                        o[this['name']] = o[this['name']] + "," + this['value'];
                    } else {
                        o[this['name']] = this['value'];
                    }
                }
            });
            return o;
        };
        $(function () {
            //吐司默认设置
            toastr.options = {
                "closeButton": false,
                "debug": false,
                "positionClass": "toast-top-right",
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "2000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }
        })


        function sumDatas(datas, field) {
            var expression = "0";
            for (var i = 0; i < datas.length; i++) {
                if (datas[i][field] == "") {
                    expression += "+0";
                } else {
                    if (!isNaN(datas[i][field])) {
                        expression += "+" + datas[i][field];
                    } else {
                        expression += "+0";
                    }
                }
            }
            return eval(expression);
        }
        function avgDatas(datas, field) {
            return eval(sumDatas(datas, field) + "/" + datas.length).toFixed(2);
        }

        function colFormatter(value, row, index) {
            return '<a href="javascript:void(0)"  onclick="hrefRow(' + index + ')" ><font style="color: red;">' + value + '</font></a>';
        }

        function hrefRow(rowIndex, colIndex) {
            var columns = $("#reportTable").bootstrapTable('getColumns');
            var datas = $("#reportTable").bootstrapTable('getData');
            var hturl = columns[0][colIndex - 1].ljdz;
            var rowdata = datas[rowIndex].WINNING_SELECT_JSON_PARAMS;
            // window.open(recursion(hturl, rowdata), "_blank")
            recursion(hturl, rowdata);
        }


        function recursion(url, rowdata) {
            $.ajax({
                url: 'parseScript',
                type: 'POST',
                dataType: 'html',
                data: {scriptStr: url, params: JSON.stringify(rowdata)},
            }).done(function (resultData) {
                window.open(resultData, "_blank")
                //alert(resultData);
                //console.log("success");
            }).fail(function () {
                //console.log("error");
            }).always(function () {
                // console.log("complete");
            });
//            var patten = "\{+([^\{]*[^\}])\}+";
//            var group = url.match(patten);
//            if (group != null || group != undefined) {
//                var matchStr = group[1];
//                var matchStrAll = group[0];
//                var thIndex = group.index;
//                url = url.replace(matchStrAll, rowdata[matchStr]);
//                // alert(url);
//                return recursion(url, rowdata);
//            }
//            return url;
        }


    </script>
</head>
<body class="skin-blue">

<div class="panel-body" style="font-size: 13px;padding: 10px;">
    <iframe name='hidden_frame' id="hidden_frame" style='display:none;'></iframe>
    <form id="reportForm" method="post" class="form-horizontal" onclick="return false;" style="font-size: 13px;">

        <div class="box win-search-box">
            <div class="box-header">
                <li class="fa box-search"></li>
                <div class="box-title"> 查询条件</div>
                <div class="box-tools">
              <%--      <button type="button" class="btn btn-default btn-sm" id="excelAllExport">Excel导出全部</button>
                    <button type="button" class="btn btn-default btn-sm" id="excelExport">Excel导出页面数据</button>
                    <button type="button" class="btn btn-default btn-sm" id="excelImport">Excel导入页面</button>
                    <button type="button" class="btn btn-default btn-sm" id="exportTemplate">导出模板</button>
                    <button type="button" class="btn btn-default btn-sm" id="addRowbtn">添加行</button>
                    <button type="button" class="btn btn-default btn-sm" id="delRowbtn">删除行</button>
                    <button type="button" class="btn btn-default btn-sm" id="dataValidate">数据校验</button>
                    <button type="button" class="btn btn-default btn-sm" id="saveTb">保存</button>
                    <button type="button" class="btn btn-default btn-sm" id="search">查询</button>
                    <button type="button" class="btn btn-default btn-sm" id="resetForm">重置</button>--%>
                      ${tools}
                </div>
            </div>
            <div class="box-body ">
                ${whereEx}
                <!-- url参数集合-->
                <c:forEach items="${WINNING_URL_PARAMS}" var="item">
                    <input type="hidden" name="${item.key}" value="${item.value}"/>
                </c:forEach>

                <input type="hidden" name="pageNumber" id="WINNIGN_PAGEING_PAGENUMBER" value="1"/>
            </div>
        </div>
    </form>
    <div class="row col-sm-12" style="text-align: center">
        <span style="font-weight: bold;font-size: 15px;">${WINNING_BGMC}</span>
    </div>
    <div id="result" class="table-container">
        <table class="table table-striped table-hover" id="reportTable">
        </table>
    </div>
</div>

<input type="hidden" id="rpid" value="${rpid}"/>
${demo}
<!-- 导入附件到页面-->
<div id="dialog-form" title="导入文件">
    <form action="fileImport" id="win_file_import" name="win_file_import" enctype="multipart/form-data"
          method="post" target="hidden_frame">
        <fieldset>
            <input type="hidden" id="uploadfilename"/>
            <label class="control-label">请选择文件</label>
            <input type="file" class="btn btn-default btn-sm" name="filename1">
        </fieldset>
        <input type="hidden" name="winning_allparams" id="winning_allparams" value=""/>
    </form>
</div>
<!-- 页面级导出-->
<form action="fileExport" id="win_file_export" name="win_file_export" target="_blank" method="post">
    <input type="hidden" name="rpid" value="${rpid}"/>
    <input type="hidden" name="WINNING_EXPORT_JSON" id="WINNING_EXPORT_JSON" value=""/>
</form>
<!-- 全部导出-->
<form action="fileExportAll" id="win_file_export_all" name="win_file_export_all" target="_blank" method="post">
    <input type="hidden" name="WINNING_EXPORT_JSON_PARAMS" id="WINNING_EXPORT_JSON_PARAMS" value=""/>
</form>

<!--导出模板-->
<form action="exportTemplate" id="win_file_export_template" name="win_file_export_template" target="_blank"
      method="post">
    <input type="hidden" name="rpid" value="${rpid}"/>
</form>
<div style="display: none;">
    <div id="dialog-confirm" title="提示信息">
        <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>确认删除吗(物理删除)?</p>
    </div>
</div>
<script type="text/javascript">
    var nodes = document.getElementsByTagName("input");
    for (var i = 0; i < nodes.length; i++) {
        if ("file" == nodes[i].type) {
            nodes[i].onchange = function () {
                var textObj = this.parentNode.parentNode.getElementsByTagName("input")[0];
                var textvalue = this.value;
                textvalue = textvalue.substring(textvalue.lastIndexOf("\\") + 1, textvalue.length);
                textObj.value = textvalue;
            };
        }
    }
    $("#dialog-form").dialog({
        autoOpen: false,
        height: 200,
        width: 350,
        modal: true,
        buttons: {
            "导入": function () {
                if ($("#uploadfilename").val() == "") {
                    toastr.info("请先选择需要上传导入的文件!");
                    return;
                }
                loadMessage();
                $("#winning_allparams").val(JSON.stringify(applicationJson));
                $("#win_file_import").submit();
            },
            "关闭": function () {
                $(this).dialog("close");
            }
        },
        close: function () {
            $(this).dialog("close");
        }
    });


    $("#excelImport").click(function () {
        $("#dialog-form").dialog("open");
    })


    function randomData() {
        var tempDefaultJson = JSON.parse(JSON.stringify(applicationJson.WINNING_DEFAULT_JSON));
        var rows = [];
        rows.push(tempDefaultJson);
        return rows;
    }


    $('#addRowbtn').click(function () {
        $('#reportTable').bootstrapTable('append', randomData());
        $('#reportTable').bootstrapTable('scrollTo', 'bottom');
    })


    $("#delRowbtn").click(function () {
        if (selecedRowIndex != "") {
            var rowIndex = selecedRowIndex - 1;
            commonDel(rowIndex);
//            BootstrapDialog.confirm({
//                title: '提示信息',
//                message: '你确认删除吗?',
//                type: BootstrapDialog.TYPE_WARNING,
//                closable: true,
//                draggable: true,
//                btnCancelLabel: '否',
//                btnOKLabel: '是',
//                btnOKClass: 'btn-warning',
//                callback: function (result) {
//                    if (result) {
//                        var datas = $("#reportTable").bootstrapTable('getData');
//                        var rowdata = datas[selecedRowIndex - 1];
//                        if (rowdata.WINNING_NEW_ADD != undefined && rowdata.WINNING_NEW_ADD != null) {
//                            removeRow(selecedRowIndex - 1);
//                            selecedRowIndex = "";
//                        } else {
//
//                        }
//                        //  console.log(rowdata);
//                    }
//                }
//            });
        }
    })
 

    var add_dialog;
    $('#newAdd').click(function () {
    	pk_params = {};
    	add_dialog = new PWindow({
    		title: "新增数据",
    		width: 700,
            url:encodeURI('update','utf-8'),
            buttons: [
                      {
                         label: '关闭',
                         cssClass: 'btn-default',
                         action: function(dialogItself){
                    	  add_dialog.close();
                      	 }
                   	  },
                   	  {
                          label: '保存',
                          cssClass: 'btn-default',
                          action: function(dialogItself){
                        	  saveForm();
                       	  }
                      }
                    ]
    	});
    })
    
    
    var pk_params={};
	var update_dialog;
	function updateRow(indexRowId) {
		pk_params = {};
		pk_params.update =  1;   //用于标识是修改
		var url = 'update';
		//选择当前数据的主键及其主键数据
		$.ajax({
            url: 'queryPk',
            type: 'POST',
            dataType: 'json',
			data: {rpid: $("#rpid").val()}
        }).done(function (jsonObj) {
        	if(jsonObj.length>0){
        		var datas = $("#reportTable").bootstrapTable('getData');
                var rowdata = datas[indexRowId];
                for(var i=0; i<jsonObj.length; i++){	
	                    if (rowdata.hasOwnProperty(jsonObj[i].pk)) {
		                    	pk_params[jsonObj[i].pk]=rowdata[jsonObj[i].pk];
	                    }
                }
                update_dialog = new PWindow({
            		title: "修改数据",
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
                                	  saveForm();
                               	  }
                              }
                            ]
            	});
            } else {
                toastr.info("未设置主键！");
            }
        }).fail(function () {
            //console.log("error");
        }).always(function () {
            //console.log("complete");
        });
    }

    function commonDel(indexRowId) {
        $("#dialog-confirm").dialog({
            resizable: false,
            height: 140,
            modal: true,
            buttons: {
                "是": function () {
                    var datas = $("#reportTable").bootstrapTable('getData');
                    var rowdata = datas[indexRowId];
                    if (rowdata.WINNING_NEW_ADD != undefined && rowdata.WINNING_NEW_ADD != null) {
                        $('#reportTable').bootstrapTable('removeRow', indexRowId);
                        selecedRowIndex = "";
                    } else {
                        $.ajax({
                            url: 'delete',
                            type: 'POST',
                            dataType: 'HTML',
                            data: {rpid: $("#rpid").val(), deleteParams: JSON.stringify(rowdata)}
                        }).done(function (resultData) {
                            if (resultData == "") {
                                toastr.success("删除成功！");
                                $('#reportTable').bootstrapTable('removeRow', indexRowId);
                                selecedRowIndex = "";
                            } else {
                                toastr.warning(resultData);
                            }
                        }).fail(function () {
                            //console.log("error");
                        }).always(function () {
                            //console.log("complete");
                        });
                    }
                    $(this).dialog("close");
                },
                "否": function () {
                    $(this).dialog("close");
                }
            }
        });
    }


    $("#excelExport").click(function () {
        $("#WINNING_EXPORT_JSON").val(JSON.stringify($("#reportTable").bootstrapTable('getData')));
        $("#win_file_export").submit();
    })

    $("#excelAllExport").click(function () {
        $("#WINNING_EXPORT_JSON_PARAMS").val(JSON.stringify(serializeObject($("#reportForm"))));
        $("#win_file_export_all").submit();
    })

    $("#exportTemplate").click(function () {
        $("#win_file_export_template").submit();
    })

    $(window).resize(function () {
        $('#reportTable').bootstrapTable('resetWidth');
    });

    $("#szfy").click(function () {
        $('#reportTable').bootstrapTable('refreshOptions', {
            pagination: true,
            onlyInfoPagination: false,
            sidePagination: 'server',
            pageNumber: 1,
            pageSize: 10,
            totalRows: 20,
            pageList: [10]
        });
    })

    //联动方法
    function linkageChange(val, rec, obj) {
        var that = obj.options.btTable;
        var tdIndex = obj.options.tdIndex;
        var trIndex = obj.options.trIndex;
        var tdOpt = that.columns['column' + tdIndex];
        var currtkjmc = tdOpt.KJMC;
        var rowData = that.data[trIndex];
        var sqlParamsJson = rowData.WINNING_SELECT_JSON_PARAMS;
        sqlParamsJson[currtkjmc] = val;
        that.prevEditRow.find('td').closest('td').siblings().each(function (index) {
            if (tdIndex != index) {
                var curretThis = $(this);
                var currentTdOpt = that.columns['column' + index];
                if (currentTdOpt.selectScript != undefined && currentTdOpt.selectScript.indexOf("{" + currtkjmc + "}") != -1) {
                    sqlParamsJson.remoteSql = currentTdOpt.selectScript;
                    $.ajax({
                        url: 'remoteSql',
                        type: 'POST',
                        dataType: 'JSON',
                        data: sqlParamsJson,
                    }).done(function (resultData) {
                        rowData[currentTdOpt.KJMC + "WINNING_SELECT_JSON"] = resultData;
                        rowData[currentTdOpt.field] = "";
                        currentTdOpt.edit.data = resultData;
                        curretThis.find('input[type="text"]').bootstrapSelect("destroy");
                        // console.log(curretThis.find('input[type="text"]'));

                        curretThis.data('oldVal', $.trim(rowData[currentTdOpt.field]));

                        var height = curretThis.innerHeight() - 3;
                        var width = curretThis.innerWidth() - 2;
                        var placeholder = '';
                        if (currentTdOpt.edit.required == true) {
                            placeholder = '必填项';
                        }
                        curretThis.html('<div style="margin:0;padding:0;overflow:hidden;border:solid 0px red;height:' + (height) + 'px;width:' + (width) + 'px;">'
                                + '<input type="text" placeholder="' + placeholder + '" value="" style="margin-left: 0px; margin-right: 0px; padding-top: 1px; padding-bottom: 1px; width:100%;height:100%">'
                                + '</div>');
                        curretThis.width(width);
                        var $input = curretThis.find('input');
                        if (!currentTdOpt.edit.type || currentTdOpt.edit.type == 'text') {
                            if (currentTdOpt.edit['click'] && typeof currentTdOpt.edit['click'] === 'function') {
                                $input.unbind('click').bind('click', function (event) {
                                    currentTdOpt.edit['click'].call(this, event);
                                });
                            }
                            if (currentTdOpt.edit['focus'] && typeof currentTdOpt.edit['focus'] === 'function') {
                                $input.unbind('focus').bind('focus', function (event) {
                                    currentTdOpt.edit['focus'].call(this, event);
                                });
                            }
                            $input.unbind('blur').on('blur', function (event) {
                                if (currentTdOpt.edit['blur'] && typeof currentTdOpt.edit['blur'] === 'function') {
                                    currentTdOpt.edit['blur'].call(this, event);
                                }
                            });
                        }
                        currentTdOpt.edit.tdIndex = index;
                        currentTdOpt.edit.data = resultData;
                        currentTdOpt.edit.btTable = that;
                        currentTdOpt.edit.trIndex = trIndex;
                        $input.bootstrapSelect(currentTdOpt.edit);
                    }).fail(function () {
                        //console.log("error");
                    }).always(function () {
                        //console.log("complete");
                    });
                    //alert(currentTdOpt.selectScript);
                }
            }
        })

    }
    // console.log($("#reportTable").bootstrapTable('getData'));
    // console.log($("#reportTable").bootstrapTable('getModiDatas'));
    //  console.log($("#reportTable").bootstrapTable('getColumns'));

    function removeRow(rowIndex) {
        commonDel(rowIndex);
        //  $('#reportTable').bootstrapTable('removeRow', rowIndex);
    }

    //
    //    var testSql = "baodu.com?test=1321&test2=112312{6565666}{TTTT}";
    //
    //    var patten = "\{+([^\{]*[^\}])\}+";
    //    var group = testSql.match(patten);
    //    console.log(group);

</script>
</body>
</html>
