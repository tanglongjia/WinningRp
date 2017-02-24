package com.winningRp.common.util;

import com.alibaba.fastjson.JSONArray;
import com.winningRp.common.Constants;
import com.winningRp.common.bean.RpTableCol;
import com.winningRp.common.exception.BuilderTableException;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;
import java.util.Map;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/26.
 * TIME: 0:59.
 * WinningRp
 */
public class BuilderUtils {

    /**
     * 创建列
     *
     * @param col
     * @return
     */
    public static String builderColJson(RpTableCol col, JdbcTemplate jdbcTemplate, Map<String, Object> params, Integer index, Integer hzflg) throws BuilderTableException {
        Boolean required = "1".equals(col.getBt()) ? true : false; //是否必填
        String jylx = col.getJylx();//校验类型
        String jydm = col.getJydm();//校验代码
        String tsxx = col.getTsxx();//提示信息
        StringBuilder sb = new StringBuilder("{");
        if (StringUtils.isBlank(col.getYxbj()) || col.getYxbj().equals("0")) {
            sb.append(String.format("field:\"%s\",edit:false ,title:\"%s\",align:\"center\",visible :%s ",
                    StringUtils.isBlank(col.getBcsjyl()) ? col.getBqsjyl() : col.getBcsjyl(), col.getBtmc(), "1".equals(col.getKjzt()) ? false : true));
            //不允许编辑的情况下 并且链接地址不为空的情况下
            if (!"1".equals(col.getYxbj()) && StringUtils.isNotBlank(col.getLjdz())) {
                String ljdz = col.getLjdz().replaceAll("\r|\n|\t", " ");//去除回车换行
                // Map<String, String> testMap = new HashMap<String, String>();
                // testMap.put("ljdz", ljdz);
                sb.append(",ljdz:" + JSONArray.toJSONString(ljdz) + "");
                sb.append(",formatter:function(value,row,rowIndex){" +
                        // "       var hrefStr = " + JSONArray.toJSONString(ljdz) + "; " +
                        // "       var hrefStr = " + JSONArray.toJSONString(ljdz) + ";urlMap.put('',hrefStr); " +
                        "       var strHtml = '<a href=\"javascript:void(0);\"  onclick=\"hrefRow('+rowIndex+'," + index + ")\">'+value+'</a>';" +
                        //  "   var strHtml = '<a href=\"javascript:void(0);\"  onclick=\"hrefRow('+rowIndex+',row)\">'+value+'</a>';" +
                        "       return strHtml;" +
                        "   }");
            }
            if (StringUtils.isNotBlank(col.getHzlx()) && "1".equals(col.getHzlx())) {//合计
                if (StringUtils.isNotBlank(col.getBcsjyl())) {
                    sb.append(",footerFormatter:function(datas){ return sumDatas(datas,'" + col.getBcsjyl() + "');}");
                } else {
                    sb.append(",footerFormatter:function(datas){ return sumDatas(datas,'" + col.getBqsjyl() + "');}");
                }
            } else if (StringUtils.isNotBlank(col.getHzlx()) && "2".equals(col.getHzlx())) {
                if (StringUtils.isNotBlank(col.getBcsjyl())) {
                    sb.append(",footerFormatter:function(datas){ return avgDatas(datas,'" + col.getBcsjyl() + "');}");
                } else {
                    sb.append(",footerFormatter:function(datas){ return avgDatas(datas,'" + col.getBqsjyl() + "');}");
                }
            }
            if (hzflg == 1) {
                sb.append(",footerFormatter:function(datas){ return  \"<span style='font-weight: bold'>huiz_winning_huiz</span>\";}");
            }
        } else {
            sb.append(String.format("field:\"%s\",title:\"%s\",align:\"center\",visible :%s ",
                    StringUtils.isBlank(col.getBcsjyl()) ? col.getBqsjyl() : col.getBcsjyl(), col.getBtmc(), "1".equals(col.getKjzt()) ? false : true));
            if (StringUtils.isNotBlank(col.getHzlx()) && "1".equals(col.getHzlx())) {//合计
                if (StringUtils.isNotBlank(col.getBcsjyl())) {
                    sb.append(",footerFormatter:function(datas){ return sumDatas(datas,'" + col.getBcsjyl() + "');}");
                } else {
                    sb.append(",footerFormatter:function(datas){ return sumDatas(datas,'" + col.getBqsjyl() + "');}");
                }
            } else if (StringUtils.isNotBlank(col.getHzlx()) && "2".equals(col.getHzlx())) {
                if (StringUtils.isNotBlank(col.getBcsjyl())) {
                    sb.append(",footerFormatter:function(datas){ return avgDatas(datas,'" + col.getBcsjyl() + "');}");
                } else {
                    sb.append(",footerFormatter:function(datas){ return avgDatas(datas,'" + col.getBqsjyl() + "');}");
                }
            }
            // System.out.println(col.getLjdz());
            if (hzflg == 1) {
                sb.append(",footerFormatter:function(datas){ return  \"<span style='font-weight: bold'>huiz_winning_huiz</span>\";}");
            }
            /**
             * 控制td间距的样式
             */
            sb.append(",cellStyle:function cellStyle(value, row, index, field) {\n" +
                    "  return {\n" +
                    "    css: { \"height\": \"32px\"}\n" +
                    "  };\n" +
                    "}");
            //定义控件名称
            if (StringUtils.isBlank(col.getKjmc()))
                throw new BuilderTableException("该报表列[" + col.getBtmc() + "]的控件名称未定义！");
            else
                sb.append(",KJMC:'" + col.getKjmc() + "'");
            /**
             * 验证控制
             */
            sb.append(",required:" + required + "");

            if (StringUtils.isNotBlank(jydm))
                sb.append(",jydm:[" + jydm + "]");

            if (StringUtils.isNotBlank(jylx))
                sb.append(",jylx:'" + jylx + "'");

            if (StringUtils.isNotBlank(tsxx))
                sb.append(",tsxx:'" + tsxx + "'");

            if (StringUtils.isNotBlank(col.getKjlx())) {
                if (Constants.SELECT.equals(col.getKjlx())) {
                    String kjz = col.getKjz();
                    if (StringUtils.isBlank(kjz)) {
                        throw new BuilderTableException("该报表定义下拉框列，未定义控件值！");
                    }
                    if (kjz.indexOf("code") == -1 || kjz.indexOf("name") == -1) {
                        throw new BuilderTableException("该报表定义下拉框列，控件值sql未定义code或name字段！");
                    }
                    List<Map<String, Object>> maps = null;
                    //联动后此语句不需要执行
//                    try {
//                        //  maps = jdbcTemplate.queryForList(kjz);
//                    } catch (Exception e) {
//                        throw new BuilderTableException("语句:'" + kjz + "'执行报错！");
//                    }
                    String jsons = null;
                    if (maps == null || maps.size() == 0)
                        jsons = "[]";
                    else
                        jsons = JSONArray.toJSONString(maps);
                    kjz = kjz.replaceAll("\r|\n|\t", " ");
                    sb.append(String.format(",selectScript:\"%s\" ", kjz));
                    sb.append(" ,edit: {\n" +
                            "         type: 'select',//下拉框\n" +
                            "         data: " + jsons + ",\n" +
                            // "         multiple:true," +
                            "         valueField: 'code',\n" +
                            "         required: " + required + ",\n" +
                            "         textField: 'name',\n" +
                            "         onSelect: function (val, rec,obj) {\n" +
                            //   "              console.log(obj);    obj.reload();     console.log(val, rec);\n" +
                            "              if( typeof linkageChange == 'function' ) { linkageChange(val, rec,obj)  }    " +
                            "         }\n" +
                            "   }");
                } else if (Constants.DATE.equals(col.getKjlx())) {
                    String kjlxgs = "yyyy-mm-dd";//控件类型格式
                    if (StringUtils.isNotBlank(col.getKjlxgs()))
                        kjlxgs = col.getKjlxgs();
                    sb.append(" ,edit: {\n" +
                            "         type: 'date',//日期\n" +
                            "         format:'" + kjlxgs + "'," +
                            "         required: " + required + ",\n" +
                            "         click: function () {\n" +
                            "         }\n" +
                            "         }");
                } else if (Constants.TEXT.equals(col.getKjlx()))
                    sb.append(",edit: { required: " + required + " }");
//                    sb.append(" ,formatter: function (value, row, rowIndex) {\n" +
//                            "         var strHtml = '<input class=\"form-control\"   href=\"javascript:void(0);\" value=\"'+value+'\" />';\n" +
//                            "         return strHtml;" +
//                            "         },edit:false");

            }
        }
        sb.append("}");
        return sb.toString();
    }

    /**
     * 创建insert 语句
     *
     * @return
     */
    public static String builderInsertSql() {
        return null;
    }

    /**
     * 创建更新语句
     *
     * @return
     */
    public static String builderUpdateSql() {
        return null;
    }


}
