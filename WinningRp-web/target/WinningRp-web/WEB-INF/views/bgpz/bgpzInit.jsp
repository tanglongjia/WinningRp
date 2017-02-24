<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String headPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + headPath + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <base href="<%=basePath%>"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link href="<%=basePath%>/assertsRp/bootstrap/dist/css/bootstrap.css" rel="stylesheet">
    <!-- Theme style -->
    <!-- AdminLTE Skins. Choose a skin from the css/skins
    folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="<%=basePath%>assertsRp/css/_all-skins.min.css">
    <link href="<%=basePath%>/assertsRp/bootstrap-table/bootstrap-table.css" rel="stylesheet"/>
    <link href="<%=basePath%>/assertsRp/bootstrap-dialog/bootstrap-dialog.min.css" rel="stylesheet"/>
    <link href="<%=basePath%>/assertsRp/bootstrap-table/bootstrap-table-fixed-columns.css" rel="stylesheet"/>

    <link href="<%=basePath%>assertsRp/css/AdminLTE.min.css" rel="stylesheet">
    <link href="<%=basePath%>assertsRp/css/bootstrap_extra.css" rel="stylesheet"/>
    <link href="<%=basePath%>/assertsRp/easyui/themes/bootstrap/tree.css" rel="stylesheet"/>
    <link href="<%=basePath%>/assertsRp/easyui/themes/bootstrap/tooltip.css" rel="stylesheet"/>
    <!-- combobox所需css -->
    <link href="<%=basePath%>/assertsRp/easyui/themes/bootstrap/textbox.css" rel="stylesheet"/>
    <link href="<%=basePath%>/assertsRp/easyui/themes/bootstrap/combo.css" rel="stylesheet"/>
    <link href="<%=basePath%>/assertsRp/easyui/themes/bootstrap/combobox.css" rel="stylesheet"/>
    <!-- jQuery 1.9 -->
    <script src="<%=basePath%>/assertsRp/jquery/dist/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="<%=basePath%>/assertsRp/easyui/jquery.easyui.min.js"></script>
    <script src="<%=basePath%>/assertsRp/js/jquery.placeholder.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="<%=basePath%>/assertsRp/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>/assertsRp/bootstrap-table/bootstrap-table.js"></script>
    <script src="<%=basePath%>/assertsRp/bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script src="<%=basePath%>/assertsRp/bootstrap-table/bootstrap-fixed-column.js"></script>
    <script src="<%=basePath%>assertsRp/js/bootstrap_extra.js"></script>
    <script src="<%=basePath%>/assertsRp/bootstrap-dialog/bootstrap-dialog.min.js"></script>

    <script type="text/javascript" src="<%=basePath%>assertsRp/js/toastr.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>assertsRp/css/toastr.min.css">

    <!-- tooltip插件-->
    <script src="<%=basePath%>assertsRp/poshytip-1.2/src/jquery.poshytip.js"></script>
    <link href="<%=basePath%>assertsRp/poshytip-1.2/src/tip-skyblue/tip-skyblue.css" rel="stylesheet">
</head>
<body>
<div class="panel-body" style="font-size: 13px; padding-top:0px;">
    <form id="defaultForm2" method="post" class="form-horizontal" onclick="return false;" style="font-size: 13px;">
        <div class="box win-search-box">
            <div class="box-header">
                <li class="fa box-search"></li>
                <div class="box-title"> 查询条件</div>
                <div class="box-tools">
                    <button type="button" id="btn_query" class="btn btn-default btn-sm" style="color: white;"
                            onclick="searchbgpz()">
                        查询
                    </button>
                    <button type="button" id="btn_query" class="btn btn-default btn-sm" style="color: white;"
                            onclick="delbgpz()">
                        删除
                    </button>
                </div>
            </div>
            <div class="box-body">
                <div class="form-group">
                    <label class="col-lg-1 col-md-2 control-label">表格名称:</label>
                    <div class="col-lg-2 col-md-4">
                        <div class="input-group">
                            <input class="form-control" id="bbmc"/>
                        </div>
                    </div>
                    <label class="col-lg-1 col-md-2 control-label">记录状态:</label>
                    <div class="col-lg-2 col-md-4">
                        <select class="form-control" id="selectJlzt">
                            <option value='0'>启用</option>
                            <option value='1'>停用</option>
                            <option value=''>全部</option>
                        </select>
                    </div>
                    <label class="col-lg-1 col-md-2 control-label">表格类型:</label>
                    <div class="col-lg-2 col-md-4">
                        <select class="form-control" id="selectBglx">
                            <option value='1'>填报</option>
                            <option value='0'>查询</option>
                            <option value=''>全部</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div id="bgpzDataDiv" class="table-container  skin-blue">
    </div>
</div>
<script type="text/javascript">
    function searchbgpz(pageid) {
        //loadMessage();
        if (pageid == undefined) {
            pageid = 1;
        }
        var request = new HttpRequest("bt_bgpz.do?action=getData", "post", {
            onRequestSuccess: function (responseText) {
                $("#bgpzDataDiv").html(responseText);
                $("#bgpz_table").bootstrapTable({
                    totalRows: $("#bgpzListId").val(),
                    pagination: true, //启动分页
                    pageSize: 20, //每页显示的记录数
                    pageNumber: pageid, //当前第几页
                    pageList: [20], //记录数可选列表
                    search: false, //是否启用查询
                    onlyInfoPagination: false,
                    sidePagination: "server", //表示服务端请求
                    onPageChange: function (number, size) {
                        searchbgpz(number);
                    },
                    onClickRow: function (row, $element) {
                        var bbdm = $element.find("td :first").find("input[name='delbgdm']").val();
                        $("#selfbgdm").val(bbdm);
                    }
                });
                //hideMessage();
            }
        });
        request.addParameter("bbmc", $("#bbmc").val());
        request.addParameter("jlzt", $("#selectJlzt").val());
        request.addParameter("bglx", $("#selectBglx").val());
        request.addParameter("pageid", pageid);
        request.sendRequest();
    }

    function delbgpz() {
        var selfbgdm = $("#selfbgdm").val();
        if (selfbgdm == null || selfbgdm == '') {
            toastr.info("请选择要删除的记录!");
            return;
        }

        alertConfirm("确定要删除吗？", function () {
            jQuery.ajax({
                url: 'bt_bgpz.do?action=delBgpz',
                type: 'POST',
                dataType: 'json',
                data: {
                    bgdm: selfbgdm
                }
            }).done(function (responseText) {
                if (responseText == '1') {
                    toastr.success("删除成功！");
                    searchbgpz();
                } else {
                    toastr.error("删除失败！");
                }

            }).fail(function () {
                console.log("error");
            }).always(function () {
                console.log("complete");
            });
        });
    }

    $(function () {
        searchbgpz();
    });

    var updateBg_dialog;
    function updateBg(bgdm) {
        var url = "bt_bgpz.do?action=updateBg&BGDM=" + bgdm;
        updateBg_dialog = new PWindow({
            title: "配置修改",
            url: encodeURI(url, 'utf-8'),
            buttons: [
                {
                    label: '关闭',
                    cssClass: 'btn-default btn-sm',
                    action: function (dialogItself) {
                        dialogItself.close();
                    }
                },
                {
                    label: '保存',
                    cssClass: 'btn-default btn-sm',
                    action: function (dialogItself) {
                        updateBgpz(dialogItself);
                    }
                }
            ]
        });
    }

    var showBg_dialog;
    function showBg(bgdm) {
        var url = "bt_bgpz.do?action=showBg&BGDM=" + bgdm;
        showBg_dialog = new PWindow({
            title: "配置详情页面",
            url: encodeURI(url, 'utf-8'),
            buttons: [
                {
                    label: '关闭',
                    cssClass: 'btn-default btn-sm',
                    action: function (dialogItself) {
                        dialogItself.close();
                        $("input").attr("disabled", false);
                        $("select").attr("disabled", false);
                    }
                }]
        });
    }


    /**
     * 预览
     */
    function preview(url) {
        window.open('<%=request.getContextPath()%>' + url, "_blank");
    }

</script>

</body>
