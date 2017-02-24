<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%
	String headPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+headPath+"/";
%>
<!DOCTYPE>
<html >
<head>
	<title></title>
	<script type="text/javascript" >

	$(function(){
		var iframeUrl = "<%=basePath%>${bgdm}";
		iframeSrcJudge(iframeUrl);
	});
	
	function iframeSrcJudge(reportUrl){
		// 前提：根据后台取到的路径值为reportUrl,下面就来判断路径是否存在，这段代码来源于网络，我试了可以判断成功。
		var reportUrl = reportUrl.replace(/\\/g,"/");
		var obj = document.getElementById("viewIframe");
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
			$("#viewIframeWarn").css("display","");
			obj.src = "";
		}else{
			$("#viewIframeWarn").css("display","none");
			obj.src = reportUrl;
		}
	}
	</script>
</head>
<body>
	<span style="display:none" id="viewIframeWarn">
  		该报表尚未设置表格列，请设置！
  	</span>
 	<iframe id="viewIframe"  height="100%" width="100%"  frameborder="0" >
         	
    </iframe>
    
    
</body>
</html>