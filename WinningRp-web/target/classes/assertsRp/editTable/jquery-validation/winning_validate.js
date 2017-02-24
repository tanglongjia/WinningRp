/**
 * Created by 项鸿铭 on 2016/11/3.
 */
function isIdCardNo(num) {

    var factorArr = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
    var parityBit = new Array("1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2");
    var varArray = new Array();
    var intValue;
    var lngProduct = 0;
    var intCheckDigit;
    var intStrLen = num.length;
    var idNumber = num;
    if ((intStrLen != 15) && (intStrLen != 18)) {
        return false;
    }
    for (i = 0; i < intStrLen; i++) {
        varArray[i] = idNumber.charAt(i);
        if ((varArray[i] < 0 || varArray[i] > 9 ) && (i != 17)) {
            return false;
        } else if (i < 17) {
            varArray[i] = varArray[i] * factorArr[i];
        }
    }

    if (intStrLen == 18) {
        //check date
        var date8 = idNumber.substring(6, 14);
        if (isDate8(date8) == false) {
            return false;
        }
        for (i = 0; i < 17; i++) {
            lngProduct = lngProduct + varArray[i];
        }
        intCheckDigit = parityBit[lngProduct % 11];
        if (varArray[17] != intCheckDigit) {
            return false;
        }
    }
    else { //length is 15
        var date6 = idNumber.substring(6, 12);
        if (isDate6(date6) == false) {

            return false;
        }
    }
    return true;
}

function isDate6(sDate) {
    if (!/^[0-9]{6}$/.test(sDate)) {
        return false;
    }
    var year, month, day;
    year = sDate.substring(0, 4);
    month = sDate.substring(4, 6);
    if (year < 1700 || year > 2500) return false
    if (month < 1 || month > 12) return false
    return true
}

function isDate8(sDate) {
    if (!/^[0-9]{8}$/.test(sDate)) {
        return false;
    }
    var year, month, day;
    year = sDate.substring(0, 4);
    month = sDate.substring(4, 6);
    day = sDate.substring(6, 8);
    var iaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    if (year < 1700 || year > 2500) return false
    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1] = 29;
    if (month < 1 || month > 12) return false
    if (day < 1 || day > iaMonthDays[month - 1]) return false
    return true
}


//字母数字
jQuery.validator.addMethod("alnum", function (value) {
    return /^[a-zA-Z0-9]+$/.test(value);
}, "只能包括英文字母和数字");

// 邮政编码验证
jQuery.validator.addMethod("zipcode", function (value) {
    var tel = /^[0-9]{6}$/;
    return (tel.test(value));
}, "请正确填写邮政编码");

// 汉字
jQuery.validator.addMethod("chcharacter", function (value) {
    var tel = /^[u4e00-u9fa5]+$/;
    return (tel.test(value));
}, "请输入汉字");

// 字符最小长度验证（一个中文字符长度为2）
jQuery.validator.addMethod("stringMinLength", function (value, param) {
    var length = value.length;
    for (var i = 0; i < value.length; i++) {
        if (value.charCodeAt(i) > 127) {
            length++;
        }
    }
    return (length >= param);
}, $.validator.format("长度不能小于{0}!"));


// 字符验证
jQuery.validator.addMethod("string", function (value) {
    return /^[u0391-uFFE5w]+$/.test(value);
}, "不允许包含特殊符号!");

// 手机号码验证
jQuery.validator.addMethod("mobile", function (value) {
    var length = value.length;
    return (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/.test(value));
}, "手机号码格式错误!");

// 电话号码验证
jQuery.validator.addMethod("phone", function (value) {
    var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
    return (tel.test(value));
}, "电话号码格式错误!");

// 邮政编码验证
jQuery.validator.addMethod("zipCode", function (value) {
    var tel = /^[0-9]{6}$/;
    return (tel.test(value));
}, "邮政编码格式错误!");

// 必须以特定字符串开头验证
jQuery.validator.addMethod("begin", function (value, param) {
    var begin = new RegExp("^" + param);
    return (begin.test(value));
}, $.validator.format("必须以 {0} 开头!"));

// 验证两次输入值是否不相同
jQuery.validator.addMethod("notEqualTo", function (value, param) {
    return value != $(param).val();
}, $.validator.format("两次输入不能相同!"));

// 验证值不允许与特定值等于
jQuery.validator.addMethod("notEqual", function (value, param) {
    return value != param;
}, $.validator.format("输入值不允许为{0}!"));

// 验证值必须大于特定值(不能等于)
jQuery.validator.addMethod("gt", function (value, param) {
    return value > param;
}, $.validator.format("输入值必须大于{0}!"));
//------------------------------暂时用到的验证---------------------------------------

// 身份证号码验证
jQuery.validator.addMethod("idcardno_winning", function (value) {
    console.log(value);
    return /^(\w{8}|\w{15}|\w{18})$/.test(value);
}, "请正确输入身份证号码");
// 邮箱验证
jQuery.validator.addMethod("email_winning", function (value) {
    return /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/.test(value);
}, "");

// 网址验证
jQuery.validator.addMethod("url_winning", function (value) {
    return /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})).?)(?::\d{2,5})?(?:[/?#]\S*)?$/i.test(value);
}, "");

//合法数字（负数，小数）
jQuery.validator.addMethod("number_winning", function (value) {
    return /^(?:-?\d+|-?\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test(value);
}, "");

//整数
jQuery.validator.addMethod("digits_winning", function (value) {
    return /^\d+$/.test(value);
}, "");

// 字符最大长度验证（一个中文字符长度为2）
jQuery.validator.addMethod("stringMaxLength_winning", function (value, param) {
    var length = value.length;
    for (var i = 0; i < value.length; i++) {
        if (value.charCodeAt(i) > 127) {
            length++;
        }
    }
    return (length <= param);
}, $.validator.format("长度不能大于{0}!"));

//长度范围
jQuery.validator.addMethod("rangelength_winning", function (value, param) {
    var length = value.length;
    for (var i = 0; i < value.length; i++) {
        if (value.charCodeAt(i) > 127) {
            length++;
        }
    }
    return length >= param[0] && length <= param[1];
}, "");

//数字范围
jQuery.validator.addMethod("range_winning", function (value, param) {
    return value >= param[0] && value <= param[1];
}, "");