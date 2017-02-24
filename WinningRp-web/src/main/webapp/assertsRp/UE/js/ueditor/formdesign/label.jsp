<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String contextPath = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath+"/";
%>
<html>
<head>
    <title>文本框</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" >
    <meta name="generator" content="www.leipi.org" />
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-ie6.css">
    <![endif]-->
    <!--[if lte IE 7]>
    <link rel="stylesheet" type="text/css" href="bootstrap/css/ie.css">
    <![endif]-->
    <link rel="stylesheet" href="leipi.style.css">
    <script type="text/javascript" src="../dialogs/internal.js"></script>
    <script type="text/javascript" src="../../jquery-1.7.2.min.js"></script>
<!--    <script type="text/javascript" charset="utf-8" src="../ueditor.config.js"></script>-->
    <script type="text/javascript">
/* Thank you by  
http://www.alt-tag.com/blog/2006/02/ie-dom-bugs/ */
function createElement(type, name)
{     
    var element = null;     
    try {        
        element = document.createElement('<'+type+' name="'+name+'">');     
    } catch (e) {}   
    if(element==null) {     
        element = document.createElement(type);     
        element.name = name;     
    } 
    return element;     
}
    </script>
</head>
<body>
<div class="content">
    <table class="table table-bordered table-striped table-hover">
     <tr>
        <th><span>控件名称</span><span class="label label-important">*</span></th>
        <th><span>默认值</span> </th>
    </tr>
    <tr>
        <td><input type="text" id="orgname" placeholder="必填项"></td>
        <td><input type="text" id="orgvalue" placeholder="无则不填"></td>
    </tr>
    <tr>
        <th><span>&nbsp;&nbsp;&nbsp;&nbsp;长&nbsp;&nbsp;X&nbsp;&nbsp;宽&nbsp;&nbsp;&nbsp;&&nbsp;&nbsp;&nbsp;字体大小</span></th>
        <th><span>对齐方式</span> </th>
    </tr>
    <tr>
        <td>
            <input id="orgwidth" type="text" value="150" class="input-small span1" placeholder="auto"/>
            X
            <input id="orgheight" type="text" value="" class="input-small span1" placeholder="auto"/>
            &
            <input id="orgfontsize" type="text"  value="" class="input-small span1" placeholder="auto"/> px

        </td>
        <td>
            <select id="orgalign">
                <option value="left" >左对齐</option>
                <option value="center">居中对齐</option>
                <option value="right">右对齐</option>
            </select>
        </td>
    </tr>
    <tr>
        <th><span>数据源</span></th>
        <th><span>字段</span> </th>
    </tr>
	<tr>
        <td>
            <select id="orgdatasource" onchange="initColumn()">
<!--                <option value="ajson">数据源</option>-->
<!--                <option value="bjson">数据源B</option>-->
            </select>
        </td>
        <td>
            <select id="orgdatacolumn">
<!--                <option value="name" >姓名</option>-->
<!--                <option value="addredd">地址</option>-->
<!--                <option value="age">年龄</option>-->
            </select>
        </td>
    </tr>
    </table>
</div>
<script type="text/javascript">
var oNode = null,thePlugins = 'label';


function initDataSource(gDataSource,gDataColumn){
	$("#orgdatasource").html("");
	$.ajax({
        url:  '<%=contextPath%>/initDataSource.do?action=InitDataSource',
        type: 'POST',
        dataType: 'text',
        data: {
          'id': '1'
	      },
	      success:function(result,status,xhr){

	    	//设置编辑器的内容
	 	     var obj = JSON.parse(result);
	 	  	 if(obj.length>0){
	 	  		var selects = document.getElementById("orgdatasource");
	 			for(var i=0;i<obj.length;i++){
	 				var options = document.createElement("option");
	 				selects.appendChild(options);
	 				options.value=obj[i].name;
	 				options.text=obj[i].name;
	 			}
	 	  	 }
	 	  	$("#orgdatasource").val(gDataSource);
	 	  	 initColumn(gDataSource,gDataColumn);

	      }
	}).done(function(data) {
	    
	});
} 

function  initColumn(gDataSource,gDataColumn){
	$("#orgdatacolumn").html("");
	$.ajax({
        url:  '<%=contextPath%>/initDataSource.do?action=initColumn',
        type: 'POST',
        dataType: 'text',
        data: {
          'source': document.getElementById("orgdatasource").value
	    },
	    success:function(result,status,xhr){
	    	//设置编辑器的内容
		     //alert(data);
		     var arr = result.split(",");
		     var selects = document.getElementById("orgdatacolumn");
		     for( i in arr){
		    	var options = document.createElement("option");
				selects.appendChild(options);
				options.value=arr[i];
				options.text=arr[i];
		     }
	    	 $("#orgdatacolumn").val(gDataColumn);
		    
		}
	}).done(function(data) {
	     
	     
	    
	});
}
window.onload = function() {
	//console.log(UE.plugins[thePlugins].editdom);
    if( UE.plugins[thePlugins].editdom ){
        oNode = UE.plugins[thePlugins].editdom;
		var gValue = '';
		if(oNode.getAttribute('value'))
			gValue = oNode.getAttribute('value').replace(/&quot;/g,"\"");
		var gTitle=oNode.getAttribute('title').replace(/&quot;/g,"\""),
		//gHidden=oNode.getAttribute('orghide'),
		gFontSize=oNode.getAttribute('orgfontsize'),
		gAlign=oNode.getAttribute('orgalign'),
		gWidth=oNode.getAttribute('orgwidth'),
		gHeight=oNode.getAttribute('orgheight'),
		gDataSource=oNode.getAttribute('orgdatasource'),
		gDataColumn=oNode.getAttribute('orgdatacolumn');
		//gType=oNode.getAttribute('orgtype');
		gValue = gValue==null ? '' : gValue;
        gTitle = gTitle==null ? '' : gTitle;
		$G('orgvalue').value = gValue;
        $G('orgname').value = gTitle;
        /*if (gHidden == '1')
        {
            $G('orghide').checked = true;
        }*/
        $G('orgfontsize').value = gFontSize;
        $G('orgwidth').value = gWidth;
        $G('orgheight').value = gHeight;
        $G('orgalign').value = gAlign;
        //$G('orgdatasource').value = gDataSource;
        //$G('orgdatacolumn').value = gDataColumn;
        initDataSource(gDataSource,gDataColumn);
        //$G('orgtype').value = gType;
    }else{
    	initDataSource("","");
    }
}
dialog.oncancel = function () {
    if( UE.plugins[thePlugins].editdom ) {
        delete UE.plugins[thePlugins].editdom;
    }
};
dialog.onok = function (){
    if($G('orgname').value==''){
        alert('请输入控件名称');
        return false;
    }
    if((!$G('orgdatasource').value) || (!$G('orgdatacolumn').value)){
    	alert('请配置数据源');
        return false;
    }
    var gValue=$G('orgvalue').value.replace(/\"/g,"&quot;"),
    gTitle=$G('orgname').value.replace(/\"/g,"&quot;"),
    gFontSize=$G('orgfontsize').value,
    gAlign=$G('orgalign').value,
    gWidth=$G('orgwidth').value,
    gHeight=$G('orgheight').value,
    gDataSource=$G('orgdatasource').value,
    gDataColumn=$G('orgdatacolumn').value;
    //gType=$G('orgtype').value;
    //console.log(!oNode);
    if( !oNode ) {
        try {
            //insert 标签
            oNode = createElement('input','leipiNewField');
            if(!gValue){
            	oNode.setAttribute('value',"");
            }else{
            	oNode.setAttribute('value',gValue);
            }
            oNode.setAttribute('type','text');
            oNode.setAttribute('title',gTitle);
            oNode.setAttribute('name','leipiNewField');
            oNode.setAttribute('leipiPlugins',thePlugins);
            /*if ( $G('orghide').checked ) {
                oNode.setAttribute('orghide',1);
            } else {
                oNode.setAttribute('orghide',0);
            }*/
            if( gFontSize != '' ) {
                oNode.style.fontSize = gFontSize + 'px';
                //style += 'font-size:' + gFontSize + 'px;';
                oNode.setAttribute('orgfontsize',gFontSize );
            }  
            if( gAlign != '' ) {
                //style += 'text-align:' + gAlign + ';';
                oNode.style.textAlign = gAlign;
                oNode.setAttribute('orgalign',gAlign );
            }
            if( gWidth != '' ) {
                oNode.style.width = gWidth+ 'px';
                //style += 'width:' + gWidth + 'px;';
                oNode.setAttribute('orgwidth',gWidth );
            }
            if( gHeight != '' ) {
                oNode.style.height = gHeight+ 'px';
                //style += 'height:' + gHeight + 'px;';
                oNode.setAttribute('orgheight',gHeight );
            }
            if( gDataSource != '' ) {
                oNode.setAttribute('orgdatasource',gDataSource );
            }
            if( gDataColumn != '' ) {
                oNode.setAttribute('orgdatacolumn',gDataColumn );
            }
            /*if( gType != '' ) {
                oNode.setAttribute('orgtype',gType );
            }*/
            //oNode.setAttribute('style',style );
            //oNode.style.cssText=style;//ie7
            editor.execCommand('insertHtml',oNode.outerHTML);
        } catch (e) {
            try {
                editor.execCommand('error');
            } catch ( e ) {
                alert('控件异常，请到 [雷劈网] 反馈或寻求帮助！');
            }
            return false;
        }
    } else {
    	//update 标签
    	if(!$G('orgvalue').value){
        	oNode.setAttribute('value', "");
        }else{
        	oNode.setAttribute('value', $G('orgvalue').value);
        }
        
       /* if( $G('orghide').checked ) {
            oNode.setAttribute('orghide', 1);
        } else {
            oNode.setAttribute('orghide', 0);
        }*/
        if( gFontSize != '' ) {
            oNode.style.fontSize = gFontSize+ 'px';
            oNode.setAttribute('orgfontsize',gFontSize );
        }else{
            oNode.style.fontSize = '';
            oNode.setAttribute('orgfontsize', '');
        }
        if( gAlign != '' ) {
            oNode.style.textAlign = gAlign;
            oNode.setAttribute('orgalign',gAlign );
        }else{
            oNode.setAttribute('orgalign', '');
        }
        if( gWidth != '' ) {
            oNode.style.width = gWidth+ 'px';
            oNode.setAttribute('orgwidth',gWidth );
        }else{
            oNode.style.width = '';
            oNode.setAttribute('orgwidth', '');
        }
        if( gHeight != '' ) {
            oNode.style.height = gHeight+ 'px';
            oNode.setAttribute('orgheight',gHeight );
        }else{
            oNode.style.height = '';
            oNode.setAttribute('orgheight', '');
        }
        if( gDataSource != '' ) {
                oNode.setAttribute('orgdatasource',gDataSource );
        }
        if( gDataColumn != '' ) {
            oNode.setAttribute('orgdatacolumn',gDataColumn );
        }
        oNode.setAttribute('title', gTitle);
        /*if( gType != '' ) {
            oNode.setAttribute('orgtype',gType );
        }else{
            oNode.setAttribute('orgtype', '');
        }*/
        delete UE.plugins[thePlugins].editdom;
    }
};
</script>
</body>
</html>