var wn = wn || {};
wn.data = wn.data || {};

/**
 * 将form表单元素的值序列化成对象
 */
wn.serializeObject = function(form) {
	var o = {};
	$.each(form.serializeArray(), function(index) {
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


/**
 * JSON对象转换成String
 */
wn.jsonToString = function(o) {
	var r = [];
	if (typeof o == "string")
		return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
	if (typeof o == "object") {
		if (!o.sort) {
			for ( var i in o)
				r.push(i + ":" + wn.jsonToString(o[i]));
			if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
				r.push("toString:" + o.toString.toString());
			}
			r = "{" + r.join() + "}";
		} else {
			for (var i = 0; i < o.length; i++)
				r.push(wn.jsonToString(o[i]));
			r = "[" + r.join() + "]";
		}
		return r;
	}
	return o.toString();
};


/**
 * 去字符串空格
 * 
 * @author 孙宇
 */
wn.trim = function(str) {
	return str.replace(/(^\s*)|(\s*$)/g, '');
};
wn.ltrim = function(str) {
	return str.replace(/(^\s*)/g, '');
};
wn.rtrim = function(str) {
	return str.replace(/(\s*$)/g, '');
};
/**
 * 详情信息回填
 */
wn.detailShow = function(divObj, row){
	var	boxes = divObj.find("div[id^='show_']");
	if(boxes && boxes.length>=1){
		for(var i=0; i< boxes.length; i++) {
			var nameTemp = boxes[i].id.substring(5);
			$('#show_'+nameTemp).html(eval('row.'+nameTemp));
		}
	}
}


/**
 * 通过ajax请求填充对应的select内容
 * @param selObject select对象
 * @param reqUrl 请求url
 * @param selVal select选中内容值
 * @param optionOne option选项是否填充空，true是，false否
 */
 wn.initSelectOption = function(selObject, reqUrl, selVal, optionOne){
	 
	 $.ajax({
	        type: "GET",
	        dataType: "json",
	        url: reqUrl,
	        success: function (data) {
	        	var selectBody = "";
	        	if(optionOne){
	        		selectBody = "<option value=''></option>";
	        	}
	            $.each(data, function (i, n) {
	            	if(selVal!="" && n.parakey==selVal){
	            		 selectBody += "<option value='" + n.parakey + "' selected='selected'>" + n.paraval + "</option>";
	            	}else{
	            		 selectBody += "<option value='" + n.parakey + "'>" + n.paraval + "</option>";
	            	}
	            });
	            selObject.html(selectBody);
	        },
	        error: function (json) {
	           
	        }
	    });
	 
 }
 
 /**
  * 列表转option
  * @param array
  * @returns {String}
  */
 wn.createSelectByArray = function(selObject,array){
	     var selectBody = "<option value=''>--请选择--</option>";
		 $.each(array, function () {
			selectBody += "<option value=" + this.id + ">" + this.name + "</option>";
		 });
		 selObject.html(selectBody);
 }
 
 /**
  * 字典codes拼接 
  * 例  &codes=xxx&codes=xxxx&codes=xxxxx
  */
 wn.distCodes = function(array){
	 var resultCodes = "";
	 $.each(array, function (index) {
		 resultCodes += "&codes=" +array[index];
	 });
	 return resultCodes;
 }
 
 /**
  * 处理表单form
  */
 wn.handleForm = function(formElement){
	 	var parameters = [];
	    var formObj;
		if ((typeof formElement) == 'string') {
			formObj = document.getElementById(formElement);
		} else {
			formObj = formElement;
		}
		var es = formObj.elements;
		for (var i = 0; i < es.length; i++) {
			if (es[i].name == null || es[i].name == "")
				continue;
			var tagName = es[i].tagName.toLowerCase();
			var type = es[i].type ? es[i].type.toLowerCase() : tagName;
			if (type == "submit" || type == "button") {
				continue;
			} else if (tagName == "input"
					&& (type == "checkbox" || type == "radio")) {
				if (es[i].checked) {
					parameters.push([es[i].name,  es[i].value]);
				}
			} else if (tagName == "select") {
				for (var j = 0; j < es[i].options.length; j++) {
					if (es[i].options[j].selected) {
						parameters.push([es[i].name,  es[i].options[j].value]);
					}
				}
			} else {
				parameters.push([es[i].name,  es[i].value]);
			}
		}
		return parameters;
 }
 
 /**
  * 获取参数拼接字符串  &a=xxx&b=xxxx&c=xxxxx
  */
 wn.getParameterString = function(parameters){
	    var url = '';
		for (var i = 0; i < parameters.length; i++) {
			url += parameters[i][0] + '='
					+ encodeURIComponent(parameters[i][1]);
			if (i < parameters.length - 1) {
				url += '&';
			}
		}
		return url;
 }
 
 /**
  * 获取表单form 拼接字符串
  */
 wn.fillWithForm = function(formElement){
	 return wn.getParameterString(wn.handleForm(formElement));
 }

 /**
  * js ajax parameters对象
  */
 function parameters(){
	 var params = [];
	 this.addParameter = function(key, value){
		 params.push([key, value]);
	 }
	 this.getParams = function(){ 
		 return params;
	 }
 }
 
 /**
  * js hashMap
  * @returns {HashMap}
  */
 function HashMap(){ 
		/**Map大小**/ 
		var size=0; 
		/**对象**/ 
		var entry=new Object(); 
		/**Map的存put方法**/ 
		this.put=function(key,value){ 
		if(!this.containsKey(key)){ 
		size++; 
		entry[key]=value; 
		} 
		} 
		/**Map取get方法**/ 
		this.get=function(key){ 
		return this.containsKey(key) ? entry[key] : null; 
		} 
		/**Map删除remove方法**/ 
		this.remove=function(key){ 
		if(this.containsKey(key) && ( delete entry[key] )){ 
		size--; 
		} 
		} 
		/**是否包含Key**/ 
		this.containsKey= function (key){ 
		return (key in entry); 
		} 
		/**是否包含Value**/ 
		this.containsValue=function(value){ 
		for(var prop in entry) 
		{ 
		if(entry[prop]==value){ 
		return true; 
		} 
		} 
		return false; 
		} 
		/**所有的Value**/ 
		this.values=function(){ 
		var values=new Array(); 
		for(var prop in entry) 
		{ 
		values.push(entry[prop]); 
		} 
		return values; 
		} 
		/**所有的 Key**/ 
		this.keys=function(){ 
		var keys=new Array(); 
		for(var prop in entry) 
		{ 
		keys.push(prop); 
		} 
		return keys; 
		} 
		/**Map size**/ 
		this.size=function(){ 
		return size; 
		} 
		/**清空Map**/ 
		this.clear=function(){ 
		size=0; 
		entry=new Object(); 
		} 

}
 
 
 
/**
 * 屏蔽右键
 * @requires jQuery
 */
$(document).bind('contextmenu', function() {
	 return true;
});

/**
 * ajax报错默认提示通用设置
 */
$.ajaxSetup({
	type : 'POST',
	error : function(XMLHttpRequest, textStatus, errorThrown) {
		try {
			//parent.$.messager.progress('close');
			//parent.$.messager.alert('错误', XMLHttpRequest.responseText);
		} catch (e) {
			alert(XMLHttpRequest.responseText);
		}
	}
});


/**
 * ajax报错默认提示通用设置
 */
$.ajaxSetup({
	type : 'GET',
	error : function(XMLHttpRequest, textStatus, errorThrown) {
		try {
			//parent.$.messager.progress('close');
			//parent.$.messager.alert('错误', XMLHttpRequest.responseText);
		} catch (e) {
			alert(XMLHttpRequest.responseText);
		}
	}
});


//加载信息
function loading(name, overlay) {
	$('body').append('<div id="overlay"></div><div id="preloader">' + name + '</div>');
	$("#overlay").show();
	if (overlay == 1) {
		$('#overlay').css('opacity', 0.1).fadeIn(function() {
			$('#preloader').fadeIn();
		});
		return false;
	}
	$('#preloader').fadeIn();
}
//隐藏加载信息
function unloading() {
	$("#overlay").hide();	
	$('#preloader').fadeOut('fast', function() {
		$('#overlay').fadeOut();
	});
}

//加载信息
function loadMessage(msg) {
	  if(msg == undefined){
		  loading('加载中...', 1);
	  }else{
		  loading(msg, 1);
	  }
}
//隐藏加载信息
function hideMessage() {
	  unloading();  
}


function checkNum(obj){
	var v= obj.value;	
	if(!/^[1-9][0-9]*$/.test(v) && !/^[1-9][0-9]*[.][0-9]{1}[0-9]?$/.test(v) && !/^[0][.][0-9]{1}[0-9]?$/.test(v) && !/^[0]$/.test(v) && obj.value.trim() != ""){		
		try{
			obj.value = "";
			obj.focus();
		}catch(e){
		}
	}

	if(obj.value.trim() == ""){
		obj.value = "";
		obj.focus();
	}
}


function checkNumz(obj){
	var v= obj.value;		
	if(!/^[1-9][0-9]*$/.test(v)  && !/^[0]$/.test(v) && obj.value.trim() != ""){
		try{
			obj.value = "";
			obj.focus();
		}catch(e){
		}
	}

	if(obj.value.trim() == ""){
		obj.value = "";
		obj.focus();
	}
}

/**----------------------------------------httpRequest老方法开始-------------------------------------------------------**/

/**
 * 老的ajax方法调用
 * @param action
 * @param method
 * @param callback
 * @param synchronous
 * @returns {HttpRequest}
 */

function HttpRequest(action, method, callback, synchronous) {
	this.action = action;
	this.method = method ? method.toUpperCase() : "GET";
	this.callback = callback || {
		onBeforeRequest : function() {
		
		},
		onAfterRequest : function() {
		},
		onRequestSuccess : function() {
			
		},
		onRequestError : function() {
		}
	};
	this.synchronous = synchronous;
	this.parameters = [];
}
/**
 * 为请求添加一个参数对
 */
HttpRequest.prototype.addParameter = function(key, value) {
	this.parameters.push([key, value]);
}
/**
 * 删除参数
 */
HttpRequest.prototype.clearParameter = function(key, value) {
	this.parameters=[];
}
/**
 * 获得所有的参数对，其中参数的值已用encodeURIComponent进行了编码
 * 
 * @return 参数字符串
 */
HttpRequest.prototype.getParameterString = function() {
	var url = '';
	for (var i = 0; i < this.parameters.length; i++) {
		url += this.parameters[i][0] + '='
				+ encodeURIComponent(this.parameters[i][1]);
		if (i < this.parameters.length - 1) {
			url += '&';
		}
	}
	return url;
}
/**
 * 提供一个表单来填充请求参数，表单中的所有控件（包括input,textarea,select,button）都将被添加到请求中。 <br>
 * ！！对input type=file，只能获得文件名信息，不能上传文件。！！
 * 
 * @param formObj
 *            form的id或HTML FORM对象
 */
HttpRequest.prototype.fillWithForm = function(formElement) {
	var formObj;
	if ((typeof formElement) == 'string') {
		formObj = document.getElementById(formElement);
	} else {
		formObj = formElement;
	}
	var es = formObj.elements;
	for (var i = 0; i < es.length; i++) {
		if (es[i].name == null || es[i].name == "")
			continue;
		var tagName = es[i].tagName.toLowerCase();
		var type = es[i].type ? es[i].type.toLowerCase() : tagName;
		if (type == "submit" || type == "button") {
			continue;
		} else if (tagName == "input"
				&& (type == "checkbox" || type == "radio")) {
			if (es[i].checked) {
				this.addParameter(es[i].name, es[i].value);
			}
		} else if (tagName == "select") {
			for (var j = 0; j < es[i].options.length; j++) {
				if (es[i].options[j].selected) {
					this.addParameter(es[i].name, es[i].options[j].value);
				}
			}
		} else {
			this.addParameter(es[i].name, es[i].value);
		}
	}
}

/**
 * 发送请求
 * 
 * @param evalScript
 *            boolean,为true时csi后执行response中的javascript
 */
HttpRequest.prototype.sendRequest = function(evalScript) {
	var defaultSynamic = true;
	if(evalScript != undefined){
		defaultSynamic = evalScript;
	}
	var thisObject = this;
		 $.ajax({ 
		    url: this.action, 
		    type: this.method, 
		   // dataType: 'html', 
		    async: defaultSynamic,
		   	timeout : 500000,
		    data: this.getParameterString()   //自定义参数提交
		}) 
		.done(function(datas) { 
		//console.log("success");
			thisObject.callback.onRequestSuccess(datas);
			listTableHover();
			$("div .modal-content table[data-toggle='table']").each(function(){
	   		     $(this).bootstrapTable();
	   		});
		}) 
		.fail(function(datas) { 
		//console.log("error"); 
			thisObject.callback.onRequestSuccess("后台异常");
			//thisObject.callback.onRequestError(datas);
		}) 
		.always(function() { 
		//console.log("complete"); 
		});
}

function listTableHover(){

	var dtSelector = ".list_table";
	var tbList = jQuery(dtSelector);

	tbList.each(function() {
		var self = this;



		jQuery("tr:even", jQuery(self)).addClass("normalEvenTD"); // 从标头行下一行开始的奇数行，行数：（1，3，5...）
		jQuery("tr:odd", jQuery(self)).addClass("normalOddTD"); // 从标头行下一行开始的偶数行，行数：（2，4，6...）

		// 鼠标经过的行变色
		jQuery("tr:not(:first)", jQuery(self)).hover(
			function () { jQuery(this).addClass('hoverTD');jQuery(this).removeClass('table-td-content'); },
			function () { jQuery(this).removeClass('hoverTD');jQuery(this).addClass('table-td-content'); }
		);

		jQuery("tr", jQuery(self)).each(function() {

			var trThis = this;
			jQuery("td", trThis).click(function (){
				var tdThis = this;

				if (jQuery(tdThis).get(0) == jQuery("td:first", jQuery(trThis)).get(0)){
					//alert(jQuery(trThis).children().first().children()[0].type);
				} else{
					if(jQuery(trThis).children().first().children()[0] != undefined){
						if(jQuery(trThis).children().first().children()[0].type == 'checkbox' ){
							if(jQuery(trThis).children().first().children().attr("disabled") != "disabled"){
								if(jQuery(trThis).children().first().children()[0].checked){
									jQuery(trThis).children().first().children().attr("checked", false);
								}else{
									jQuery(trThis).children().first().children().attr("checked", true);
								}
							}
						}
						if(jQuery(trThis).children().first().children()[0].type == 'radio' ){
							jQuery(trThis).children().first().children().attr("checked", true);
						}
					}
				}
			});
		});



		// 选择行变色
		jQuery("tr", jQuery(self)).click(function (){
			var trThis = this;
			jQuery(self).find(".trSelected").removeClass('trSelected');
			//if (jQuery(trThis).get(0) == jQuery("tr:first", jQuery(self)).get(0)){
			//return;
			//}
			jQuery(trThis).addClass('trSelected');

		});
	});
}

function ajaxFunction(url,abc,params,paramValues,formName){
	var message = new Message({
		status : "progress",
		close : 0
	});
	message.show("");
	message.setProgress(40);
	var request = new HttpRequest(url,"post",{
	onRequestSuccess : function(responseText){
		 hideMessage();
		 abc(responseText);
	  }
   });
	if(params != null){
		for(var i = 0 ;i<params.length;i++){
			request.addParameter(params[i],paramValues[i]);
		}
	}
	if(formName != null){
		request.fillWithForm(formName);
	}
    request.sendRequest();
}

function abs(value){
	return Math.abs(eval(value));
}

//************************Message begin*********************************

function Message() { 
  
 } 
Message.prototype = {

	setProgress : function(per) {
		loadMessage();
	},

	show : function(message) {

	}

}
function alertMessage(options, width) {
	loading('加载中...', 1);
}

//************************Message begin*********************************

/**----------------------------------------httpRequest老方法结束-------------------------------------------------------**/


/**----------------------------------------弹出框老方法开始----------------------------------------------------------------------**/
function alertMsg2(msg,fn){
	 BootstrapDialog.show({
		   title: "提示信息",
		   message: msg,
		   closable : false,
		   buttons: [{
	       label: '确定',
	       action: function(dialogRef){
	           dialogRef.close();
	           fn();
	       }
	  }]
	});
	 return false;
}

function alertMsgBfFunc(msg,typeStr,fn){
		BootstrapDialog.show({
			   title: "提示信息",
			   message: msg,
			   closable : false,
			   buttons: [{
			    label: '确定',
			    action: function(dialogRef){
			        dialogRef.close();
			        fn();
			    }
			   }]
		});
		return false;
}


function alertMsg(msg){
	BootstrapDialog.show({
		   title: "提示信息",
		   message: msg,
		   buttons: [{
	       label: '确定',
	       action: function(dialogRef){
	           dialogRef.close();
	       }
	  }]
	});
	 return false;
}

function alertMsgError(msg){
		BootstrapDialog.show({
			   title: "错误信息",
			   message: msg,
			   buttons: [{
		       label: '确定',
		       action: function(dialogRef){
		           dialogRef.close();
		       }
		  }]
		});
		 return false;
}

function alertMsgInfo(msg){
	 BootstrapDialog.show({
		   title: "提示信息",
		   message: msg,
		   buttons: [{
              label: '确定',
              action: function(dialogRef){
                  dialogRef.close();
              }
         }]
	  });
	 return false;
}

function alertMsgQuestion(msg){
		  BootstrapDialog.show({
			   title: "询　　问",
			   message: msg,
			   buttons: [{
	                label: '确定',
	                action: function(dialogRef){
	                    dialogRef.close();
	                }
	           }]
		  });
		  
		  return false;
}


function alertConfirm(msg,fn){
	BootstrapDialog.confirm({
		title: '提示信息',
		message: msg,
		closable: true, // <-- Default value is false
		draggable: true, // <-- Default value is false
		btnCancelLabel: '取消', // <-- Default value is 'Cancel',
		btnOKLabel: '确定', // <-- Default value is 'OK',
		btnOKClass: 'btn-default', // <-- If you didn't specify it, dialog type will be used,
		callback: function(result) {
			if(result) {
				if(typeof fn == 'function'){
					fn();
				}

			}
		}
	});
	return false;
}



function alertConfirm2(msg,fn){
	BootstrapDialog.confirm({
		title: '提示信息',
		message: msg,
		closable: true, // <-- Default value is false
		draggable: true, // <-- Default value is false
		btnCancelLabel: '取消', // <-- Default value is 'Cancel',
		btnOKLabel: '确定', // <-- Default value is 'OK',
		btnOKClass: 'btn-default', // <-- If you didn't specify it, dialog type will be used,
		callback: function(result) {
			fn(result);
		}
	});
	return false;
}

function alertConfirm3(title,msg,fnTrue,fnFalse){
	BootstrapDialog.confirm({
		title: title || '提示信息',
		message: msg,
		closable: true, // <-- Default value is false
		draggable: true, // <-- Default value is false
		btnCancelLabel: '取消', // <-- Default value is 'Cancel',
		btnOKLabel: '确定', // <-- Default value is 'OK',
		btnOKClass: 'btn-default', // <-- If you didn't specify it, dialog type will be used,
		callback: function(result) {
			if(result) {
				if(typeof fnTrue == 'function'){
					fnTrue();
				}
			}else{
				if(typeof fnFalse == 'function'){
					fnFalse();
				}
			}
		}
	});
	return false;
}


function jm_confirm(tl,msg,fn){
	  BootstrapDialog.confirm({
          title: tl,
          message: msg,
          closable: true, // <-- Default value is false
          draggable: true, // <-- Default value is false
          btnCancelLabel: '取消', // <-- Default value is 'Cancel',
          btnOKLabel: '确定', // <-- Default value is 'OK',
          btnOKClass: 'btn-default', // <-- If you didn't specify it, dialog type will be used,
          callback: function(result) {
              if(result) {
            	  if(typeof fn == 'function'){
            		 fn();
            	  }
              }
          }
      });
	return false;
}

function jm_alert(tl,msg,diaType,fn){
	 BootstrapDialog.show({
		   title: tl,
		   message: msg,
		   closable : false,
		   buttons: [{
	       label: '确定',
	       action: function(dialogRef){
	           dialogRef.close();
	        	if(typeof fn == 'function'){
            		fn();
            	}
	       }
	  }]
	});
	 return false;
}
/**---------------------------------------------弹出框老方法结束-------------------------------------------------------------------------**/

//************************BootstrapDialog转换  begin  测试中*********************************
function sleep(numberMillis) { 
	var now = new Date(); 
	var exitTime = now.getTime() + numberMillis; 
	while (true) { 
		now = new Date(); 
		if (now.getTime() > exitTime) 
		return; 
	} 
}

function getCurrentWinidowHeight(){
	return $(window).height()-150;
}

function setNewIframe(title,ifid,url){
	 BootstrapDialog.show({
		   title: title,
		   size:BootstrapDialog.SIZE_WIDE,
		   message: $('<div style="height: '+getCurrentWinidowHeight()+'px;overflow-y: auto;overflow-x:hidden;"></div>').load(url),
          onshow: function(dialogRef){
       	 //alert('Dialog is popping up, its message is ' + dialogRef.getMessage());
         },
         onshown: function(dialogRef){
	         
         },
         onhide: function(dialogRef){
        	 $(dialogRef).removeData("bs.modal");
         },
         onhidden: function(dialogRef){
        	 $(dialogRef).removeData("bs.modal");
         }
   });
}

function PWindow(options){
//	this.title = options.title;
//	this.width = options.width;
//	this.height = options.height;
//	this.url = options.url;
	//默认大小
	var thsize = "size-wide";
	//默认是否有按钮 
	var buttons = [];
	var defaultHeight = getCurrentWinidowHeight();
	var currentWindow = null;
	var closable = true;
	var closeByBackdrop = true;
	var closeByKeyboard = true;
	if(options.size){
		thsize =  options.size;
	}
	if(options.buttons){
		buttons = options.buttons;
	}
	if(options.height){
		defaultHeight = options.height;
	}
	if(options.closable!= undefined){
		closable = options.closable;
	}
	if(options.closeByBackdrop != undefined){
		closeByBackdrop = options.closeByBackdrop;
	}
	if(options.closeByKeyboard!= undefined){
		closeByKeyboard = options.closeByKeyboard;
	}
	
	if(options.url){
		   currentWindow = BootstrapDialog.show({
			   title: options.title,
			   size: thsize,
			   closable: closable,
	           closeByBackdrop: closeByBackdrop,
	           closeByKeyboard: closeByKeyboard,
			   message: $('<div id="dialog_div"  style="height: '+defaultHeight+'px;overflow-y: auto;overflow-x:hidden;"></div>').load(options.url),
			   buttons:buttons,
	      onshow: function(dialogRef){
	    	 //alert('Dialog is popping up, its message is ' + dialogRef.getMessage());
	      },
	      onshown: function(dialogRef){
	   	   //$("div .modal-content table#L_table")
	   	    $("div .modal-content table#L_table").each(function(){
	   		     $(this).bootstrapTable();
	   		});
		   /*	$("div .modal-content table[data-toggle='table']").each(function(){
	  		     $(this).bootstrapTable();
	  		});*/
	      },
	      onhide: function(dialogRef){
	        
	      },
	      onhidden: function(dialogRef){
	    	  if(options.ondestroy){
	    		   options.ondestroy(dialogRef);
	    	  }
	      }
		});
	}else if(options.message){
		  currentWindow = BootstrapDialog.show({
			   title: options.title,
			   size: thsize,
			   closable: closable,
	           closeByBackdrop: closeByBackdrop,
	           closeByKeyboard: closeByKeyboard,
			   message: $('<div  style="height: '+defaultHeight+'px;overflow-y: auto;overflow-x:hidden;"></div>').html(options.message),
			   buttons:buttons,
	      onshow: function(dialogRef){
	    	 //alert('Dialog is popping up, its message is ' + dialogRef.getMessage());
	      },
	      onshown: function(dialogRef){
	   	   //$("div .modal-content table#L_table")
	   	    $("div .modal-content table#L_table").each(function(){
	   		     $(this).bootstrapTable();
	   		});
		   /*	$("div .modal-content table[data-toggle='table']").each(function(){
	  		     $(this).bootstrapTable();
	  		});*/
	      },
	      onhide: function(dialogRef){
	    	  $(dialogRef).removeData("bs.modal");
	      },
	      onhidden: function(dialogRef){
	    	  if(options.ondestroy){
	    		   options.ondestroy(dialogRef);
	    	  }
	    	  $(dialogRef).removeData("bs.modal");
	      }
		});
	}
	return currentWindow;
}
//************************BootstrapDialog转换  end 测试中*********************************

function getParamsWithForm(formElement) {
	var parameters = {};
    var formObj;
	if ((typeof formElement) == 'string') {
		formObj = document.getElementById(formElement);
	} else {
		formObj = formElement;
	}
	var es = formObj.elements;
	for (var i = 0; i < es.length; i++) {
		if (es[i].name == null || es[i].name == "")
			continue;
		var tagName = es[i].tagName.toLowerCase();
		var type = es[i].type ? es[i].type.toLowerCase() : tagName;
		if (type == "submit" || type == "button") {
			continue;
		} else if (tagName == "input"
				&& (type == "checkbox" || type == "radio")) {
			if (es[i].checked) {
				//parameters.push([es[i].name,  es[i].value]);
				parameters[es[i].name]=es[i].value;
			}
		} else if (tagName == "select") {
			for (var j = 0; j < es[i].options.length; j++) {
				if (es[i].options[j].selected) {
					//parameters.push([es[i].name,  es[i].options[j].value]);
					parameters[es[i].name] = es[i].options[j].value;
				}
			}
		} else {
			//parameters.push([es[i].name,  es[i].value]);
			parameters[es[i].name] = es[i].value;
		}
	}
	return parameters;
}

// 解决ie9绑定大量数据会出现单元格错位
function repChars(htmlStr){
	//alert(htmlStr);
	var expr = new RegExp('>[ \t\r\n\v\f]*<', 'g');
	//alert(htmlStr.replace(expr, '><'));
	return htmlStr.replace(expr, '><');
}

function switchTab(ProTag, ProBox) {
	$('#'+ProTag).tab('show');
    for (i = 1; i < 10; i++) {
        if ("con" + i == ProBox) {
            document.getElementById(ProBox).style.display = "block";
			//$("#"+ProBox).css('display','block');
		} else {
        	if( document.getElementById("con" + i) != null){
        		document.getElementById("con" + i).style.display = "none";
				//$("#"+"con" + i).css('display','none');
        	}
        }
    }
}

/**
 * 弹出框内容为iframe 
 * @param options
 * @returns
 */
function PWindow2(options){
	  var thsize = "size-wide";
	  if(options.size){
		  thsize =  options.size;
	  }
	  var buttons = [];
		
		if(options.buttons){
			buttons = options.buttons;
		}
		
	  loadMessage();
	  var dialogInstance = BootstrapDialog.show({
		   title: options.title,
		   size:  thsize,
		   message: '<iframe width="100%"  height="'+getCurrentWinidowHeight()+'px"  src="'+options.url+'" frameborder="0"></iframe>',
		   buttons:buttons,
      onshow: function(dialogRef){
		  
      },
      onshown: function(dialogRef){
    	  hideMessage();
    	  dialogRef.getModal().find('iframe').get(0).contentWindow.currentDialogInstance = dialogRef;
    	  dialogRef.options_tmp = options;
      },
      onhide: function(dialogRef){
    	  $(dialogRef).removeData("bs.modal");
      },
      onhidden: function(dialogRef){
    	  $(dialogRef).removeData("bs.modal");
      }
	});
	return dialogInstance;
}
/**
 * 当前弹出框实例 iframe 弹出框适用
 */
var currentDialogInstance;

/**
 * 关闭当前页面调用options.ondestroy的函数
 */
function closeOwnerWindow(backValue){
	if(currentDialogInstance.options_tmp && 	currentDialogInstance.options_tmp.ondestroy){
		currentDialogInstance.options_tmp.ondestroy(backValue);
	}
	currentDialogInstance.close();
}



function setNewIframe2(title,ifid,url){
	var thsize = "size-wide";
	loadMessage();
	var dialogInstance = BootstrapDialog.show({
		title: title,
		size:  thsize,
		message: '<iframe width="100%"  height="'+getCurrentWinidowHeight()+'px"  src="'+url+'" frameborder="0"></iframe>',
		onshow: function(dialogRef){

		},
		onshown: function(dialogRef){
			hideMessage();
			dialogRef.getModal().find('iframe').get(0).contentWindow.currentDialogInstance = dialogRef;
		},
		onhide: function(dialogRef){
		},
		onhidden: function(dialogRef){
			
		}
	});
	return dialogInstance;
}

/**
 * replaceall函数
 */
String.prototype.replaceAll = function(s1,s2) { 
    return this.replace(new RegExp(s1,"gm"),s2); 
}

/**
 *  关闭弹出的bootstrap-dialog
 * @param {Object} dialName
 */
function closeCurrentDialog(dialName){
	if(typeof(dialName) == "undefined" || dialName == ""){
		return;
	}
	
	 $("div .bootstrap-dialog-close-button button.close").each(function(){
 		//alert($(this).parent("div .bootstrap-dialog-close-button").siblings("div.bootstrap-dialog-title").eq(0).text());
		if($(this).parent("div .bootstrap-dialog-close-button").siblings("div.bootstrap-dialog-title").eq(0).text() == dialName){
			$(this).click();
			return false; 
		}
	});
}


String.prototype.trim  = function (){
	if(this!=null){
		rex=/^ +/;
		rex2=/ +$/;
		return this.replace(rex,"").replace(rex2,"");
	}
	return "";
}

String.prototype.len = function() {
	var totalLength = 0;
	var charCode;
	for ( var i = 0; i < this.length; i++) {
		charCode = this.charCodeAt(i);
		if (charCode < 0x007f) {
			totalLength = totalLength + 1;
		} else if ((0x0080 <= charCode) && (charCode <= 0x07ff)) {
			totalLength += 2;
		} else if ((0x0800 <= charCode) && (charCode <= 0xffff)) {
			totalLength += 2;
		}
	}
	return totalLength;
}

// 获取自动计算高度
function getAutoSetHeight(){
	return $(window).height()-200;
}



