<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<SCRIPT language=javascript>    
var printSetup = function(){    
　　// 打印页面设置    
　　	wb.execwb(8,1);    
}    
var printPreView = function(){    
　　// 打印页面预览    　　    
　　	wb.execwb(7,1);    　　    
}    
var printIt = function(){    
　　	if (confirm('确定打印吗？')) {    
　　		//wb.execwb(6,6)   ;
	    window.print();//update by liuguocheng
 
　　}    
}
var windowClose = function(){
	window.opener=null; 
	window.open('','_self'); 
	window.close();
};	
</SCRIPT>
<style type="text/css" media=print>
.Noprint{display : none }
</style>
<center class="Noprint">
<p class="Noprint">
	<OBJECT id="wb" height="0" width="0" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" name="wb"></OBJECT>
	<input type=button value="打印" onclick="printIt()">&nbsp;&nbsp;
	<!-- 
    <input type=button value="预览" onclick="printPreView()">&nbsp;&nbsp;
    <input type=button value="设置" onclick="printSetup()"> &nbsp;&nbsp;
	<input type=button value="关闭" onClick="windowClose()">&nbsp;&nbsp;<br/>
	 -->
</p>
</center>