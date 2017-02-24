<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>你好首页</title>
</head>
<body style="margin: 0px; overflow: hidden">
<div id="bgdiv" >
    <img id="img1" width="100%" height="100%" src="<%=request.getContextPath()%>/assertsRp/images/img_1.png"/>
    <img id="img2" width="55%" height="55%" src="<%=request.getContextPath()%>/assertsRp/images/img_2.png" style="position:absolute;left:42%;top:54%;"/>
    <div id="frame" style="background-color:#00148c; opacity:0.05; width:500px;height:265px;position:absolute;left:8%;top:8%;">
    </div>
    <div id="content" style="position:absolute;left:10%;top:10%; font-size: 14px; color: #737373">
        欢迎使用填报系统<br/><br/>
        本系统支持表格类填报、合同协议类填报和表单类填报。<br/>
        1、提供了数据校验、灵活分页、execl模板导入导出、数据源配置、<br/>&nbsp;多种控件等功能；<br/>
        2、支持手机端、pad端、电脑端页面展示；<br/>
        3、纯JAVA构造，轻松部署，支持灵活地与其他系统集成与调用，并提供<br/>&nbsp;灵活的性能，运维无压力；
    </div>
</div>
</body>
<script type="text/javascript">
    window.onresize = function() {
        var con = document.getElementById('content');
        var frame = document.getElementById('frame');
        var hCont = con.offsetHeight;
        frame.style.height = (hCont + 30) + 'px';

    }
</script>
</html>