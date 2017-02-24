/**
 * 可编辑表格插件
 * 如果编辑表格中有用到，下拉框和日期，必须先引入
 * bootstrap-select 和 bootstrap-datetimepicker两个控件
 * @author lizx <851697971@qq.com>
 * @version 1.0
 * @date 2015-10-13
 */
(function ($) {
    'use strict';

    $.extend($.fn.bootstrapTable.defaults, {
        editable: false,
        validateType: ['idcardno_winning', 'email_winning', 'url_winning', 'number_winning',
            'digits_winning', 'stringMaxLength_winning', 'rangelength_winning', 'range_winning']
    });

    var BootstrapTable = $.fn.bootstrapTable.Constructor,
        _init = BootstrapTable.prototype.init,
        _initBody = BootstrapTable.prototype.initBody,
        _onSort = BootstrapTable.prototype.onSort,
        _append = BootstrapTable.prototype.append,
        _initHeader = BootstrapTable.prototype.initHeader;
    //添加编辑表格默认属性,如何edit设置为false时，表示该列不可编辑
    $.extend(true, BootstrapTable.COLUMN_DEFAULTS, {
        edit: {
            type: 'text'//目前只支持 文本:text 下拉:select 日期:date
        }
    });
    BootstrapTable.prototype.init = function () {
        _init.apply(this, Array.prototype.slice.apply(arguments));
        var that = this;
        that.prevEditRow = null;//上一次编辑的行
        that.columns = {};//列配置信息
        that.insertRowVal = {};//新插入行的默认值
        that.enableAppend = true;//允许添加新行
        if (that.options.editable) {
            var columnObj = this['getColumns']();
            $.each(columnObj, function (i, obj) {
                $.each(obj, function (z, col) {
                    if (!isNaN(col.fieldIndex) && col.fieldIndex >= 0) {
                        if (col.checkbox)col.edit = false;

                        that.columns['column' + col.fieldIndex] = col;
                        that.insertRowVal[col.field] = '';
                    }
                });
            });
            //this.initEdit();
        }
    };
    /*BootstrapTable.prototype.initHeader = function(){
     _initHeader.apply(this, Array.prototype.slice.apply(arguments));
     this.$container.find('.fixed-table-header').addClass('success');
     };*/
    BootstrapTable.prototype.initBody = function () {
        var that = this;

        _initBody.apply(this, Array.prototype.slice.apply(arguments));
        if (!that.options.editable) return;
        this.initEdit();

        //如果列是下拉框，则转换值为对应的文本
        $.each(that.columns, function (indx, col) {
            if (col.edit && col.edit.type == 'select') {
                col.edit = $.extend({}, $.fn.bootstrapSelect.defaults, col.edit);

                that.$body.find('>tr').each(function () {
                    if (that.getData().length < 1)return true;
                    var rowData = that.data[$(this).data('index')];//当前点击td所在行的数据
                    var $td = $(this).find('td').eq(col.fieldIndex);
                    if (rowData[col.KJMC + 'WINNING_SELECT_JSON'] != undefined) {
                        $.each(rowData[col.KJMC + 'WINNING_SELECT_JSON'], function (i, data) {
                            if (data[col.edit.valueField] == rowData[col.field]) {
                                $td.html(data[col.edit.textField]);
                            }
                        });
                    }
                });

                // ---------------------------以下为改造前---------------------------
                // if (col.edit.data.length > 0) {
                //     that.$body.find('>tr').each(function () {
                //         if (that.getData().length < 1)return true;
                //         var rowData = that.data[$(this).data('index')];//当前点击td所在行的数据
                //         var $td = $(this).find('td').eq(col.fieldIndex);
                //        // var tdIndex = $tr.children().index($td);//当前点击的td下标
                //        // var tdOpt = that.columns['column' + tdIndex];
                //        // rowData[col.KJMC + 'WINNING_SELECT_JSON'];
                //
                //         $.each(rowData[col.KJMC + 'WINNING_SELECT_JSON'], function (i, data) {
                //             if (data[col.edit.valueField] == rowData[col.field]) {
                //                 $td.html(data[col.edit.textField]);
                //             }
                //         });
                //
                //         // $.each(col.edit.data, function (i, data) {
                //         //     if (data[col.edit.valueField] == rowData[col.field]) {
                //         //         $td.html(data[col.edit.textField]);
                //         //     }
                //         // });
                //     });
                // }
                // else if (col.edit.url) {//作废 扩展后不支持
                //     $.ajax({
                //         url: col.edit.url,
                //         type: 'post',
                //         data: col.edit.paramsType == 'json' ? JSON.stringify(col.edit.params) : col.edit.params,
                //         dataType: 'json',
                //         success: function (jsonLst) {
                //             col.edit.onLoadSuccess.call(this, jsonLst);
                //             that.$body.find('>tr').each(function () {
                //                 if (that.getData().length < 1)return true;
                //                 var rowData = that.data[$(this).data('index')];//当前点击td所在行的数据
                //                 var $td = $(this).find('td').eq(col.fieldIndex);
                //                 $.each(jsonLst, function (i, data) {
                //                     if (data[col.edit.valueField] == rowData[col.field]) {
                //                         $td.html(data[col.edit.textField]);
                //                     }
                //                 });
                //             });
                //             col.edit.data = jsonLst;
                //             col.edit.url = null;
                //         },
                //         error: function (xhr, textStatus, errorThrown) {
                //             col.edit.onLoadError.call(this);
                //             col.edit.data = [];
                //             col.edit.url = null;
                //             throw col.field + ' 列下拉框数据加载失败';
                //         }
                //     });
                // }
            }
        });
    };
    //根据行号删除指定行
    BootstrapTable.prototype.removeRow = function (rowNum) {
        var that = this;
        var len = that.options.data.length;
        if (isNaN(rowNum)) {
            return;
        }
        if (that.$body.find('.editable-select').data('index') != rowNum) {
            recover(that);
        }
        //删除数据
        that.options.data.splice(rowNum, 1);
        if (len === that.options.data.length) {
            return;
        }
        var oldClass = {};//保存被标记修改的样式
        that.$body.find('>tr').each(function (indx) {
            if ($(this).hasClass('editable-modify')) {
                if (indx > rowNum) {
                    oldClass[indx - 1] = 'editable-modify';
                }
                else {
                    oldClass[indx] = 'editable-modify';
                }
            }
        });
        //this.prevEditRow = null;
        //this.$body.find('>tr').removeClass('editable-select');
        that.initBody();
        //将标记改变过行的样式从新设置回去
        for (var key in oldClass) {
            that.$body.find('>tr').eq(key).addClass(oldClass[key]);
        }
        //this.initEdit();
        //没有数据时给提示加上样式
        if (that.getData().length < 1) {
            that.$body.find('>tr').addClass('no-records-found');
        }
    };
    BootstrapTable.prototype.append = function () {
        var that = this;
        var thtrlength = that.$body.find('>tr').length - 1;
        if (thtrlength < 0)
            thtrlength = 0;
        //if(!that.enableAppend)return;
        var oldClass = {};//保存被标记修改的样式
        that.$body.find('>tr').each(function (indx) {
            if ($(this).hasClass('editable-modify') || $(this).hasClass('editable-insert')) {
                oldClass[indx] = 'editable-modify';
            }
        });
        //arguments[0] = $.extend({}, that.insertRowVal, arguments[0]);
        _append.apply(this, Array.prototype.slice.apply(arguments));
        if (that.options.editable) {
            // that.initEdit();
            setTimeout(function () {
                //将标记改变过行的样式从新设置回去
                for (var key in oldClass) {
                    that.$body.find('>tr').eq(key).addClass(oldClass[key]);
                }
                that.$body.find('>tr:gt(' + thtrlength + ')').each(function () {
                    $(this).addClass('editable-modify');
                    $(this).addClass('editable-insert');
                })
                if (thtrlength == 0) {
                    that.$body.find('>tr:last').addClass('editable-modify');
                    that.$body.find('>tr:last').addClass('editable-insert');//双重保险，防止在快速点击添加时，为给新增行设置editable-modify属性
                }
                //that.$body.find('>tr:last').click();
            }, 60);
        }
    };

    BootstrapTable.prototype.onSort = function () {
        _onSort.apply(this, Array.prototype.slice.apply(arguments));
        var that = this;
        if (that.options.editable) {
            this.initEdit();
        }
    };
    BootstrapTable.prototype.getData = function () {
        return (this.searchText || this.searchCallback) ? this.data : this.options.data;
    };

    BootstrapTable.prototype.getColumns = function () {
        return this.options.columns;
    };
    /**
     * 获取有被修改过行的值
     */
    BootstrapTable.prototype.getModiDatas = function () {
        var that = this;
        var datas = [];
        that.$body.find('.editable-modify').each(function () {
            if (that.data[$(this).data('index')]) {
                var thdatas_t = that.data[$(this).data('index')];
                var thtmpdatas_t = {};
                //console.log(that.data[$(this).data('index')]);
                for (var Key in thdatas_t){
                    if(typeof (thdatas_t[Key]) != "object" ){
                        thtmpdatas_t[Key] = thdatas_t[Key];
                    }
                    //thtmpdatas_t[Key] = thdatas_t[Key];
                    //Websitelogo =Websitelogo+'&'+''+Key+'='+Statistics_Website_logo[Key]+'';
                }
                datas.push(thtmpdatas_t);
            }
        });
        return datas;
    };

    
    
    /**
     * 数据校验
     */
    BootstrapTable.prototype.dataValidate = function () {
        var that = this;
        var thclum = this.getColumns();
        var thdatas = this.getData();
        var result = true;
        for (var j = 0; j < thdatas.length; j++) {
            for (var i = 0; i < thclum[0].length; i++) {
                var $thtd = $($(that.$body.find('>tr').get(j)).find('>td').get(i));
                var $thfield = thclum[0][i];
                var $title = "必填";
                //alert(thclum[0][i].tttt == undefined);
                //alert($.inArray('range_winning', that.options.validateType));
                if (thclum[0][i].visible) {//必须显示才校验
                    if (thclum[0][i].required && $.trim(thdatas[j][thclum[0][i].field]) == "") {
                        result = false;
                        if ($thtd.find("em").length > 0) {
                            $thtd.find("em").remove();
                            $thtd.append("<em title='" + $title + "' class=\"winning_unchecked\"></em>")
                        } else {
                            $thtd.append("<em title='" + $title + "' class=\"winning_unchecked\"></em>")
                        }
                        $thtd.find("em").poshytip({
                            className: 'tip-skyblue',
                            bgImageFrameSize: 9,
                            offsetX: 0,
                            offsetY: 20,
                            showTimeout: 0
                        });
                    } else if ($.trim(thdatas[j][thclum[0][i].field]) != "" && thclum[0][i].jylx != undefined && $.inArray(thclum[0][i].jylx, that.options.validateType) != -1) {
                        if (thclum[0][i].tsxx == undefined || $.trim(thclum[0][i].tsxx) == "") {
                            $title = "提示信息未定义，请去配置页面配置提示信息！";
                        } else {
                            $title = thclum[0][i].tsxx;
                        }
                        var validateVals = thdatas[j][thclum[0][i].field];
                        var validateParms = thclum[0][i].jydm;
                        var validateStrs = "jQuery.validator.methods." + thclum[0][i].jylx + "(validateVals,validateParms)";
                        if (!eval(validateStrs)) {
                            result = false;
                            if ($thtd.find("em").length > 0) {
                                $thtd.find("em").remove();
                                $thtd.append("<em title='" + $title + "' class=\"winning_unchecked\"></em>")
                            } else {
                                $thtd.append("<em title='" + $title + "' class=\"winning_unchecked\"></em>")
                            }
                            $thtd.find("em").poshytip({
                                className: 'tip-skyblue',
                                bgImageFrameSize: 9,
                                offsetX: 0,
                                offsetY: 20,
                                showTimeout: 0
                            });
                        } else {
                            if ($thtd.find("em").length > 0) {
                                $thtd.find("em").remove();
                            }
                            $thtd.append("<em class=\"winning_checked\"></em>")
                        }
                    } else {
                        if ($thtd.find("em").length > 0) {
                            $thtd.find("em").remove();
                        }
                        $thtd.append("<em class=\"winning_checked\"></em>")
                    }
                }
            }
        }
        that['resetView']();
        return result;
    }

    /**
     * 获取指定列的和，参数为列下标
     */
    BootstrapTable.prototype.getColTotal = function (num) {
        var retVal = 0;
        this.$body.find('>tr').each(function () {
            var colNum = 0;
            if ($(this).hasClass('editable-select')) {
                colNum = $(this).find('td').eq(num).find('input').val();
            }
            else {
                colNum = $(this).find('td').eq(num).html();
            }

            if (!isNaN(colNum)) {//是数字才做想加
                retVal += Number(colNum);
            }
        });
        return retVal;
    };

    /**
     * 创建可编辑表格
     */
    BootstrapTable.prototype.initEdit = function () {
        var that = this,
            data = this.getData();
        //this.$body.find('> tr').unbind('click').on('click'
        //this.$body.delegate('>tr','click'
        this.$body.find('> tr').unbind('click').on('click', function () {
            var $tr = $(this);
            if ($tr.hasClass('editable-select') || data.length < 1 || $tr.hasClass('no-records-found')) {
                return;
            }
            $tr.removeClass('no-records-found');
            recover(that);
            that.prevEditRow = $tr;
            $tr.addClass('editable-select');//给当前编辑行添加样式，目前样式为空只做标识使用
            that.$body.find('> tr').not(this).removeClass('editable-select');
            $tr.find('td').closest('td').siblings().html(function (i, html) {
                initTrClick(that, this);
            });
        });
        //鼠标点击事件
        $(document).bind('mousedown', function (event) {
            var $target = $(event.target);
            if (!($target.parents().andSelf().is(that.$body)) && !($target.parents().andSelf().is($('.WdateDiv')))) {
                setTimeout(function () {
                    recover(that);
                    //that.prevEditRow = null;
                    //that.$body.find('> tr').removeClass('editable-select');
                }, 10);
            }
            ;
        });

    };

    $.fn.bootstrapTable.methods.push('getColumns',
        'getModiDatas', 'removeRow', 'getColTotal', 'dataValidate');

    /**
     * 给tr添加点击事件
     */
    function initTrClick(that, _this) {
        that.enableAppend = true;
        var $td = $(_this);
        var $tr = $td.parent();
        var rowData = that.data[$tr.data('index')];//当前点击td所在行的数据
        var tdIndex = $tr.children().index($td);//当前点击的td下标
        var tdOpt = that.columns['column' + tdIndex];
        if (!tdOpt.edit || typeof tdOpt.edit != 'object') {
            return;
        }
        $td.data('field', tdOpt.field);
        //console.log($.trim(rowData[tdOpt.field]));
        //console.l0g($td.data('oldVal'));
        if (!$td.data('oldVal')) {
            $td.data('oldVal', $.trim(rowData[tdOpt.field]));
        }
        var height = $td.innerHeight() - 3;
        var width = $td.innerWidth() - 2;
        $td.data('style', $td.attr('style'));//保存原来的样式
        $td.attr('style', 'margin:0px;padding:1px!important;');
        var placeholder = '';
        if (tdOpt.edit.required == true) {
            placeholder = '必填项';
        }
        var value = "";
        if (rowData[tdOpt.field] == null || rowData[tdOpt.field] == undefined) {
            value = "";
        }
        else {
            value = rowData[tdOpt.field];
        }

        //  var value = rowData[tdOpt.field] == null || rowData[tdOpt.field] == '' ? '' : rowData[tdOpt.field];

        //  alert(value);
        //  alert(rowData[tdOpt.field] == null);
        $td.html('<div style="margin:0;padding:0;overflow:hidden;border:solid 0px red;height:' + (height) + 'px;width:' + (width) + 'px;">'
            + '<input type="text" placeholder="' + placeholder + '" value="' + value + '" style="margin-left: 0px; margin-right: 0px; padding-top: 1px; padding-bottom: 1px; width:100%;height:100%">'
            + '</div>');
        $td.width(width);
        var $input = $td.find('input');
        if (!tdOpt.edit.type || tdOpt.edit.type == 'text') {
            if (tdOpt.edit['click'] && typeof tdOpt.edit['click'] === 'function') {
                $input.unbind('click').bind('click', function (event) {
                    tdOpt.edit['click'].call(this, event);
                });
            }
            if (tdOpt.edit['focus'] && typeof tdOpt.edit['focus'] === 'function') {
                $input.unbind('focus').bind('focus', function (event) {
                    tdOpt.edit['focus'].call(this, event);
                });
            }
            $input.unbind('blur').on('blur', function (event) {
                if (tdOpt.edit['blur'] && typeof tdOpt.edit['blur'] === 'function') {
                    tdOpt.edit['blur'].call(this, event);
                }
            });

        }
        else if (tdOpt.edit.type == 'select') {
            //追加属性
            //tdOpt.edit.prevEditRow = that.prevEditRow;
            tdOpt.edit.tdIndex = tdIndex;
            tdOpt.edit.data = rowData[tdOpt.KJMC + 'WINNING_SELECT_JSON'];
            tdOpt.edit.btTable = that;
            tdOpt.edit.trIndex = $tr.data('index')
            $input.bootstrapSelect(tdOpt.edit);
        }
        else if (tdOpt.edit.type == 'date') {
            var defaultFormat = "yyyy-mm-dd";
            if (tdOpt.edit.format != undefined) {
                defaultFormat = tdOpt.edit.format;
            }
            defaultFormat = defaultFormat.toLowerCase();
            if (defaultFormat == "yyyy") {
            } else if (defaultFormat == "yyyy-mm" || defaultFormat == "yyyymm") {
                defaultFormat = defaultFormat.replace("mm", "MM");
            }
            else if (defaultFormat == "yyyy-mm-dd" || defaultFormat == "yyyymmdd") {
                defaultFormat = defaultFormat.replace("mm", "MM");
            }
            if (defaultFormat.indexOf("hh") != -1) {
                defaultFormat = defaultFormat.replace("hh", "HH");
            }

            if (defaultFormat.indexOf("yyyymmdd") != -1 || defaultFormat.indexOf("yyyy-mm-dd") != -1) {
                defaultFormat = defaultFormat.replace("mm", "MM");
            }

            //alert(defaultFormat);
            //alert(viewStep);
            $td.html('<div style="margin:0;padding:0;overflow:hidden;border:solid 0px red;height:' + (height) + 'px;width:' + (width) + 'px;">' +
                '<input class="form-control"  style="margin-left: 0px; margin-right: 0px; padding-top: 1px; padding-bottom: 1px; width:100%;height:100%" readonly  type="text" value="' + value + '" onClick="WdatePicker({dateFmt:\'' + defaultFormat + '\'})"></div>');
            // $td.html('<input  readonly    id="form_datetime' + tdIndex + '"  class="form-control  " type="text" value="' + value + '">');
            // $('#form_datetime' + tdIndex).datepicker2({
            //     format: "yyyy-mm-dd",
            //     minViewMode: viewStep
            // });

            // $td.html('<div style="margin:0;padding:0;overflow:hidden;border:solid 0px red;height:' + (height) + 'px;width:' + (width) + 'px;" class="input-group date form_datetime' + tdIndex + '" data-link-field="dtp_editable_input' + tdIndex + '"   data-date-format="' + defaultFormat + '"  data-link-format="' + defaultFormat + '">'
            //     + '<input class="form-control" type="text" value="' + value + '">'
            //     + '<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>'
            //     + '</div>'
            //     + '<input type="hidden" id="dtp_editable_input' + tdIndex + '" value="' + value + '"/>'
            // );
            //
            //
            // $td.find('.form_datetime' + tdIndex).datetimepicker({
            //     language: 'zh-CN',
            //     autoclose: true,
            //     todayBtn: true,
            //     startView: viewStep,
            //     minView: viewStep,
            //     maxView: viewStep,
            //     forceParse: true,
            //     showMeridian: 1,
            //     keyboardNavigation: true
            // });
        }
    }

    /**
     * 恢复tr，使之处于不可编辑状态
     */
    function recover(that) {
        var isModi = false;//判断行值是否变动过
        if (that.prevEditRow != null) {
            that.prevEditRow.find('td').closest('td').siblings().html(function (i, html) {
                $(this).attr('style', $(this).data('style'));
                //$(this).attr('style', "margin:0px;padding:1px!important;");
                //  var height = $(this).innerHeight() - 3;
                //  var width = $(this).innerWidth() - 2;
                var textVal = $(this).find('input[type="text"]').val();
                var hiddenVal = $(this).find('input[type="hidden"]').val();
                if (typeof $(this).find('input[type="text"]').bootstrapSelect('getText') != 'object') {
                    $(this).find('input[type="text"]').bootstrapSelect('destroy');
                }
                // alert(textVal);
                // console.log(($(this).data('oldVal') == hiddenVal));
                if (textVal != undefined) {
                    if ($(this).data('oldVal') != (hiddenVal ? hiddenVal : $.trim(textVal)) && $(this).data('field')) {

                        if ($(this).find(".form_datetime").length > 0) {
                            that.data[that.prevEditRow.data('index')][$(this).data('field')] = $.trim(textVal);
                            isModi = true;
                        } else {
                            //  alert(hiddenVal);
                            that.data[that.prevEditRow.data('index')][$(this).data('field')] = hiddenVal ? hiddenVal : $.trim(textVal);
                            isModi = true;
                        }

                    } else if ($(this).data('oldVal') == (hiddenVal ? hiddenVal : $.trim(textVal)) && $(this).data('field')) {
                        that.data[that.prevEditRow.data('index')][$(this).data('field')] = hiddenVal ? hiddenVal : $.trim(textVal);
                    }

                    if ($(this).data('oldVal') == hiddenVal && (textVal == null || textVal == '') && hiddenVal != undefined && hiddenVal != null && $.trim(hiddenVal) != "") {
                        return hiddenVal;
                    }


                    if (that.columns['column' + i].edit.required == true) {
                        if (textVal == null || textVal == '') {
                            that.enableAppend = false;
                            //  return '<div style="margin:0;padding:0;overflow:hidden;height:' + (height) + 'px;width:' + (width) + 'px;" class="winning_error">&nbsp;</div>';
                            return '';
                        }
                    }
                    return $.trim(textVal) + "<span></span>";
                }
            });
            //新值跟旧值不匹配证明被改过
            if (isModi || that.prevEditRow.hasClass('editable-insert')) {
                that.prevEditRow.addClass('editable-modify');
            }
            else {
                that.prevEditRow.removeClass('editable-modify');
            }
            that.prevEditRow = null;
            that.$body.find('> tr').removeClass('editable-select');

            that['resetView']()
        }
    }

})(jQuery);
