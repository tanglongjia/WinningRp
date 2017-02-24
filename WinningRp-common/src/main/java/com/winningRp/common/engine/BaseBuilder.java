package com.winningRp.common.engine;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.winningRp.common.bean.RpDataSource;
import com.winningRp.common.bean.RpTableCol;
import com.winningRp.common.exception.BuilderTableException;
import com.winningRp.common.util.BuilderUtils;
import com.winningRp.common.util.ScriptEngineUtils;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.*;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/24.
 * TIME: 8:34.
 * WinningRp
 */
public abstract class BaseBuilder {
    /**
     * 日志控制
     */
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    protected JdbcTemplate jdbcTemplate;

    /**
     * 目标表主键
     */
    protected List<Map<String, Object>> pks;


    public BaseBuilder(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public BaseBuilder(JdbcTemplate jdbcTemplate, List<Map<String, Object>> pks) {
        this.jdbcTemplate = jdbcTemplate;
        this.pks = pks;
    }

    /**
     * 创建查询条件
     * 参数： map 为外部参数(须包含rpid(表格代码))
     */
    public String builderWhereEx(List list, Map<String, Object> map) throws BuilderTableException {
        StringBuffer sb = new StringBuffer();
        //sb.append("<form class=\"form-inline\">");
        if (list.size() > 0) {
            int nameLong = 0;
            //所有下拉框数据集合
            Map<String, Object> ckAll = new HashMap<String, Object>();
            //剩余有参数的下拉框
            List<Map<String, Object>> ckRemain = new ArrayList<Map<String, Object>>();
            for (int k = 0; list.size() > k; k++) {
                Map<String, String> map2 = new HashMap<String, String>();
                map2.putAll((Map) list.get(k));
                //获取最长的条件名称
                String name = map2.get("TJMC");
                if (name.length() > nameLong) {
                    nameLong = name.length();
                }
                //
                String KJLX = map2.get("KJLX");
                String KJZ = map2.get("KJZ");
                String MRZ = map2.get("MRZ");
                if (KJZ == null) {
                    KJZ = "";
                }
                if (MRZ == null) {
                    MRZ = "";
                }
                List<Map<String, Object>> xlkMap = null;
                if (KJLX.equals("3")) {
                    //获取参数个数
                    char[] chars = KJZ.toCharArray();
                    int num = 0;
                    for (int j = 0; j < chars.length; j++) {
                        if ('{' == chars[j]) {
                            num++;
                        }
                    }
                    //没有参数的先执行
                    if (num < 1) {
                        try {
                            xlkMap = jdbcTemplate.queryForList(KJZ);
                            ckAll.put(map2.get("KJMC"), xlkMap);
                            //获取每一个下拉框默认值放入map集合（map包括外部参数）， 没有取数据第一条
                            if (StringUtils.isEmpty(MRZ)) {
                            	if(xlkMap.size()>0){
                                	map.put(map2.get("KJMC"), xlkMap.get(0).get("code").toString());
                                }
                            } else {
                                map.put(map2.get("KJMC"), MRZ);
                            }
                        } catch (Exception e) {
                            throw new BuilderTableException("获取" + map2.get("TJMC") + "控件值 执行sql语句报错!", e);
                        }
                    } else {
                        //将有参数的 等无参数的先执行完。 放入下一次循环
                        Map<String, Object> ckRemain1 = new HashMap<String, Object>();
                        ckRemain1.putAll((Map) list.get(k));
                        ckRemain1.put("signCount", String.valueOf(num));
                        ckRemain.add((Map<String, Object>) ckRemain1);
                    }
                }
            }
            //循环执行有参数的脚本
            String frontControlName = "";
            List<Map<String, Object>> xlkMap1 = null;
            for (int x = 0; x < ckRemain.size(); x++) {
                Map<String, Object> map3 = new HashMap<String, Object>();
                map3.putAll((Map) ckRemain.get(x));
                String KJZ = (String) map3.get("KJZ");
                String MRZ = (String) map3.get("MRZ");
                String backControlName = (String) map3.get("KJMC");
                //根据参数个数循环
                int signCount = Integer.parseInt((String) map3.get("signCount"));
                for (int i = 0; i < signCount; i++) {
                    int a = KJZ.indexOf("{");
                    int b = KJZ.indexOf("}");
                    String nextVal = KJZ.substring(a + 1, b);
                    String replaceVal = (String) map.get(nextVal);
                    if (replaceVal != null) {
                        replaceVal = replaceVal.replace("'", "");
                    }
                    if (!StringUtils.isEmpty(replaceVal)) {
                        KJZ = KJZ.replace("{" + nextVal + "}", "'" + replaceVal + "'");
                    }
                    if (backControlName.equals(nextVal)) {
                        KJZ = KJZ.replace("{" + nextVal + "}", "'" + replaceVal + "'");
                    }
                }
                //参数匹配不上的情况处理
                if (backControlName.equals(frontControlName)) {
                    //获取剩余参数个数
                    char[] chars1 = KJZ.toCharArray();
                    int Pnum = 0;
                    for (int j = 0; j < chars1.length; j++) {
                        if ('{' == chars1[j]) {
                            Pnum++;
                        }
                    }
                    for (int i = 0; i < Pnum; i++) {
                        int a1 = KJZ.indexOf("{");
                        int b1 = KJZ.indexOf("}");
                        String nextVal1 = KJZ.substring(a1 + 1, b1);
                        KJZ = KJZ.replace("{" + nextVal1 + "}", "''");
                    }
                }
                //参数替换完 开始执行
                if (KJZ.indexOf("{") < 1) {
                    try {
                        xlkMap1 = jdbcTemplate.queryForList(KJZ);
                        ckAll.put((String) map3.get("KJMC"), xlkMap1);
                        //获取每一个下拉框默认值放入map集合（map包括外部参数）， 没有取数据第一条
                        if (StringUtils.isEmpty(MRZ)) {
                        	if(xlkMap1.size()>0){
                            	map.put((String) map3.get("KJMC"), xlkMap1.get(0).get("code").toString());
                            }
                        } else {
                            map.put((String) map3.get("KJMC"), MRZ);
                        }
                    } catch (Exception e) {
                        throw new BuilderTableException("获取" + map3.get("TJMC") + "控件值 执行sql语句报错!", e);
                    }
                } else {
                    //没替换完 放入集合， 等参数控件值 执行完  ， 重新执行  依次循环
                    ckRemain.add(map3);
                    frontControlName = (String) map3.get("KJMC");
                }

            }
            //生成查询条件控件
            for (int i = 0; list.size() > i; i++) {
                if (i == 0 || i % 4 == 0) {
                    sb.append("	<div class=\"form-group\" >");
                }
                Map<String, Object> map1 = new HashMap<String, Object>();
                map1.putAll((Map) list.get(i));
                String MRZ = (String) map1.get("MRZ");
                if (MRZ == null) {
                    MRZ = "";
                }

                //------------------------默认值javascript脚本支持 update by xhm 1122------------------------------------
                if (StringUtils.isNotBlank(MRZ)) {
                    MRZ = ScriptEngineUtils.scriptEngine(MRZ);
                }

                //------------------------默认值javascript脚本支持 update by xhm 1122-------------------------------------
                //添加空格对齐
                String tjmc = (String) map1.get("TJMC");
                String kg = "";
                if (tjmc.length() < nameLong) {
                    for (int l = 0; l < nameLong - tjmc.length(); l++) {
                        kg += "&nbsp;&nbsp;&nbsp;";
                    }
                    kg += "&nbsp;";
                }

                if (map1.get("KJLX").equals("1")) { //文本框
                    String placeholder = "";
                    if (StringUtils.isNotBlank((String) map1.get("SY")))
                        placeholder = (String) map1.get("SY");

                    if (map1.get("KJZT").equals("0")) {
                        sb.append("		<div >");
                    } else {
                        sb.append("		<div style=\"display:none;\">");
                    }
                    sb.append("			<label class=\"col-md-1 col-sm-2 control-label\" >" + kg + map1.get("TJMC") + "</label>");
                    sb.append("			<div class=\"col-md-2 col-sm-2\"><input type=\"text\" class=\"form-control\" style=\"width:180px;\" placeholder=\"" + placeholder + "\"   value=\"" + MRZ + "\"  name=\"" + map1.get("KJMC") + "\" id=\"" + map1.get("KJMC") + "\"></div>");
                    sb.append("		</div>");
                } else if (map1.get("KJLX").equals("3")) {//下拉框
                    //获取下拉框数据
                    if (map1.get("KJZT").equals("0")) {
                        sb.append("		<div >");
                    } else {
                        sb.append("		<div  style=\"display:none;\">");
                    }
                    sb.append("			<label  class=\"col-md-1 col-sm-2 control-label\" >" + kg + map1.get("TJMC") + "</label>");
                    sb.append("			<div class=\"col-md-2 col-sm-2\"><select class=\"form-control\" style=\"width:180px;\" onchange=\"eventListen(this.id)\" name=\"" + map1.get("KJMC") + "\" id=\"" + map1.get("KJMC") + "\"> ");

                    if (ckAll.size() > 0) {
                        List<Map<String, Object>> xlk = (List<Map<String, Object>>) ckAll.get(map1.get("KJMC"));

//                        for (int j = 0; j < xlk.size(); j++) {
//                            Map<String, Object> map0 = new HashMap<String, Object>();
//                            map0.putAll((Map) xlk.get(j));
//                            String code = map0.get("code").toString();
//                            String name = map0.get("name").toString();
//                            if (code.equals(MRZ) || name.equals(MRZ)) {
//                                sb.append("			<option selected=\"selected\" value=\"" + map0.get("code") + "\">" + map0.get("name") + "</option>");
//                            } else {
//                                sb.append("			<option value=\"" + map0.get("code") + "\">" + map0.get("name") + "</option>");
//                            }
//                        }
                        /*
                        if ("".equals(MRZ)) {
                            sb.append("			<option selected=\"selected\" value=\"\">全部</option>");
                        } else {
                            sb.append("			<option  value=\"\">全部</option>");
                        }*/
                        for (int j = 0; j < xlk.size(); j++) {
                            Map<String, Object> map0 = new HashMap<String, Object>();
                            map0.putAll((Map) xlk.get(j));
                            String code = map0.get("code").toString();
                            String name = map0.get("name").toString();
                            if (code.equals(MRZ) || name.equals(MRZ)) {
                                sb.append("			<option selected=\"selected\" value=\"" + map0.get("code") + "\">" + map0.get("name") + "</option>");
                            } else {
                                sb.append("			<option value=\"" + map0.get("code") + "\">" + map0.get("name") + "</option>");
                            }
                        }
                    }

                    sb.append("				</select></div>");
                    sb.append("		</div>");
                } else if (map1.get("KJLX").equals("5")) {//日期
                    if (map1.get("KJZT").equals("0")) {
                        sb.append("		<div >");
                    } else {
                        sb.append("		<div  style=\"display:none;\">");
                    }
                    sb.append("			<label   class=\"col-md-1 col-sm-2 control-label\" >" + kg + map1.get("TJMC") + "</label>");
                    sb.append("		<div class=\"col-md-2 col-sm-2\">	<input type=\"text\" class=\"form-control\" style=\"width:180px;\" value=\"" + MRZ + "\" name=\"" + map1.get("KJMC") + "\" id=\"" + map1.get("KJMC") + "\"></div>");
                    sb.append("		</div>");
                    sb.append("<script type=\"text/javascript\">");
                    if (map1.get("KJLXGS").equals("yyyy")) {
                        sb.append("	$('#" + map1.get("KJMC") + "').datepicker({ format: 'yyyy',  minViewMode:2 }); ");
                    } else if (map1.get("KJLXGS").equals("yyyy-mm")) {
                        sb.append("	$('#" + map1.get("KJMC") + "').datepicker({ format: 'yyyy-mm',  minViewMode:1 }); ");
                    } else if (map1.get("KJLXGS").equals("yyyy-mm-dd")) {
                        sb.append("	$('#" + map1.get("KJMC") + "').datepicker({ format: 'yyyy-mm-dd',  minViewMode:0 }); ");
                    }
                    sb.append("</script>");
                }
                if (list.size() == i + 1 || (i + 1) % 4 == 0) {
                    sb.append("	</div>");
                }
            }
        }
        // sb.append("</form>");
        sb.append("<script type=\"text/javascript\">");
        sb.append(" function eventListen(id){ ");
        sb.append("		jQuery.ajax({ ");
        sb.append("	    	url: '../vr/linkage', ");
        sb.append("	    	type: 'POST', ");
        sb.append("	    	dataType: 'json',");
        sb.append("	    	data:{id: id, rpid: '" + map.get("rpid") + "'}");
        sb.append("		}) ");
        sb.append("		.done(function(jsonObj) { ");
        sb.append("			if(jsonObj.length > 0){");
        sb.append("				for ( var i = 0; i < jsonObj.length; i++) {");
        sb.append("					triggerEvent(jsonObj[i].KJMC, jsonObj[i].KJZ);");
        sb.append("				}");
        sb.append(" 		}");
        sb.append("		}) ");
        sb.append("		.fail(function() { ");
        sb.append("			console.log(\"error\"); ");
        sb.append("		}) ");
        sb.append("		.always(function() { ");
        sb.append("			console.log(\"complete\"); ");
        sb.append("		});");
        sb.append(" }");

        sb.append(" function triggerEvent(kjmc, kjz){");
        sb.append("		var signsCount=kjz.split(\"{\").length-1; ");
        sb.append("		for ( var k = 0; k < signsCount; k++) { ");
        sb.append("			var before=kjz.indexOf('{'); ");
        sb.append("			var after=kjz.indexOf('}'); ");
        sb.append("			var kjmc_t=kjz.substring(before+1, after); ");
        sb.append("			if($(\"#\"+kjmc_t).length>0){ ");
        sb.append("				kjz=kjz.replace(\"{\"+kjmc_t+\"}\",  \"'\"+$(\"#\"+kjmc_t).val().replace(/'/gm,\"\")+\"'\" );");
        sb.append("			}else{");
        sb.append("				if($(\"input[name='\"+kjmc_t+\"']\").length>0){ ");
        sb.append("					kjz=kjz.replace(\"{\"+kjmc_t+\"}\",  \"'\"+$(\"input[name='\"+kjmc_t+\"']\").val().replace(/'/gm,\"\")+\"'\" ); ");
        sb.append("				}");
        sb.append("			} ");
        sb.append("		} ");
        sb.append("		var signsCount1=kjz.split(\"{\").length-1;");
        sb.append("		for ( var x = 0; x < signsCount1; x++) {");
        sb.append("			var before1=kjz.indexOf('{');");
        sb.append("			var after1=kjz.indexOf('}');");
        sb.append("			var kjmc_t1=kjz.substring(before1+1, after1);");
        sb.append("			kjz=kjz.replace(\"{\"+kjmc_t1+\"}\",  \"''\" );");
        sb.append("		}");
        sb.append("		jQuery.ajax({ ");
        sb.append("	    	url: '../vr/linkageControl', ");
        sb.append("	    	type: 'POST', ");
        sb.append("	    	dataType: 'json',");
        sb.append("	    	data:{kjz: kjz}");
        sb.append("		}) ");
        sb.append("		.done(function(jsonObj) { ");
        sb.append("			$(\"#\"+kjmc).val(\"\");");
        sb.append("			var option=\"\";	");
        sb.append("			if(jsonObj.length > 0){");
        sb.append("				for ( var i = 0; i < jsonObj.length; i++) {");
        sb.append("					option+=\"<option value=\"+jsonObj[i].code+\">\"+jsonObj[i].name+\"</option>\";");
        sb.append("				}");
        sb.append(" 		}");
        sb.append("			$(\"#\"+kjmc).html(option); ");
        sb.append("			eventListen(kjmc); ");
        sb.append("		}) ");
        sb.append("		.fail(function() { ");
        sb.append("			console.log(\"error\"); ");
        sb.append("		}) ");
        sb.append("		.always(function() { ");
        sb.append("			console.log(\"complete\"); ");
        sb.append("		});");
        sb.append(" }");
        sb.append("</script>");
        //System.out.println(sb);
        return sb.toString();
    }

    
    /**
     * 创建表单
     * 参数： map 为外部参数(须包含rpid(表格代码) 以及其他主键参数)
     */
    public String builderForm(List list, List<RpTableCol> reportCol,List<RpDataSource> reportDataSource,Map<String, Object> map) throws BuilderTableException {
        //多rpid中确认数据源
    	if (reportCol == null || reportCol.size() == 0)
            throw new BuilderTableException("该报表尚未设置表格列，请设置！");
        if (reportDataSource == null || reportDataSource.size() == 0)
            throw new BuilderTableException("该报表尚未设置数据源，请设置！");
        //默认选择一个数据源
        //TODO 后续扩展
        String sjydm = reportCol.get(0).getSjydm();
        if (StringUtils.isBlank(sjydm))
            throw new BuilderTableException("该报表存在未绑定数据源的列，请设置！");
        String sqlyj = null;
        for (RpDataSource rpDataSource : reportDataSource) {
            if (rpDataSource.getSjydm().equals(sjydm)) {
                sqlyj = rpDataSource.getSqlyj();
                break;
            }
        }
        if (StringUtils.isBlank(sqlyj))
            throw new BuilderTableException("该报表存在未设置数据源语句，请设置！");

    	StringBuffer sb = new StringBuffer();
    	StringBuffer sb1 = new StringBuffer();   //参数组装
    	Map<String,Object> dataMap = new HashMap<String,Object>();
    	//根据主键查询需要修改的数据
    	if(map.containsKey("update")){
    		map.remove("update");
    		//得到数据源的sql 组装sql
	        Iterator<Map.Entry<String, Object>> it = map.entrySet().iterator();
	        while (it.hasNext()) {
	             Map.Entry<String, Object> entry = it.next();
	    			if(entry.getKey().equals("rpid") || entry.getKey().equals("upSql")){
	    				continue;
	    			}
	    			sb1.append(" AND "+entry.getKey()+" = '"+entry.getValue().toString()+"' ");
	    			it.remove();
	        }
    		String str = sb1.toString();
    		String upSql = sqlyj.toUpperCase();  //转换成大写
    		int index = upSql.indexOf("WHERE");
    		if(index < 0 ){
    			upSql +=" WHERE 1=1 "+str;
    		}else{
    			upSql = upSql.substring(0,index-1)+" WHERE 1=1 "+str;
    		}
    		dataMap = jdbcTemplate.queryForMap(upSql);
    		//如果是更新form 需要将数据备份一遍
    		Map<String ,Object> cloneMap = new HashMap<String ,Object>();
    		for(Map.Entry<String ,Object> entry : dataMap.entrySet()){
    			cloneMap.put(entry.getKey()+"_WINNING_CLONE", entry.getValue());
    		}
    		sb.append("<input type=\"hidden\" id=\"cloneMap\" name=\"cloneMap\" value='"+JSON.toJSONString(cloneMap)+"'/>");
    	}
        if (list.size() > 0) {
            int nameLong = 0;
            //所有下拉框数据集合
            Map<String, Object> ckAll = new HashMap<String, Object>();
            //剩余有参数的下拉框
            List<Map<String, Object>> ckRemain = new ArrayList<Map<String, Object>>();
            for (int k = 0; list.size() > k; k++) {
                Map<String, String> map2 = new HashMap<String, String>();
                map2.putAll((Map) list.get(k));
                //获取最长的条件名称
                String name = map2.get("TJMC");
                if (name.length() > nameLong) {
                    nameLong = name.length();
                }
                //
                String KJLX = map2.get("KJLX");
                String KJZ = map2.get("KJZ");
                String MRZ = map2.get("MRZ");
                if (KJZ == null) {
                    KJZ = "";
                }
                if (MRZ == null) {
                    MRZ = "";
                }
                List<Map<String, Object>> xlkMap = null;
                if (KJLX.equals("3")) {
                    //获取参数个数
                    char[] chars = KJZ.toCharArray();
                    int num = 0;
                    for (int j = 0; j < chars.length; j++) {
                        if ('{' == chars[j]) {
                            num++;
                        }
                    }
                    //没有参数的先执行
                    if (num < 1) {
                        try {
                            xlkMap = jdbcTemplate.queryForList(KJZ);
                            ckAll.put(map2.get("KJMC"), xlkMap);
                            //获取每一个下拉框默认值放入map集合（map包括外部参数）， 没有取数据第一条
                            if (StringUtils.isEmpty(MRZ)) {
                            	if(xlkMap.size()>0){
                                	map.put(map2.get("KJMC"), xlkMap.get(0).get("code").toString());
                                }
                            } else {
                                map.put(map2.get("KJMC"), MRZ);
                            }
                        } catch (Exception e) {
                            throw new BuilderTableException("获取" + map2.get("TJMC") + "控件值 执行sql语句报错!", e);
                        }
                    } else {
                        //将有参数的 等无参数的先执行完。 放入下一次循环
                        Map<String, Object> ckRemain1 = new HashMap<String, Object>();
                        ckRemain1.putAll((Map) list.get(k));
                        ckRemain1.put("signCount", String.valueOf(num));
                        ckRemain.add((Map<String, Object>) ckRemain1);
                    }
                }
            }
            //循环执行有参数的脚本
            String frontControlName = "";
            List<Map<String, Object>> xlkMap1 = null;
            for (int x = 0; x < ckRemain.size(); x++) {
                Map<String, Object> map3 = new HashMap<String, Object>();
                map3.putAll((Map) ckRemain.get(x));
                String KJZ = (String) map3.get("KJZ");
                String MRZ = (String) map3.get("MRZ");
                String backControlName = (String) map3.get("KJMC");
                //根据参数个数循环
                int signCount = Integer.parseInt((String) map3.get("signCount"));
                for (int i = 0; i < signCount; i++) {
                    int a = KJZ.indexOf("{");
                    int b = KJZ.indexOf("}");
                    String nextVal = KJZ.substring(a + 1, b);
                    String replaceVal = (String) map.get(nextVal);
                    if (replaceVal != null) {
                        replaceVal = replaceVal.replace("'", "");
                    }
                    if (!StringUtils.isEmpty(replaceVal)) {
                        KJZ = KJZ.replace("{" + nextVal + "}", "'" + replaceVal + "'");
                    }
                    if (backControlName.equals(nextVal)) {
                        KJZ = KJZ.replace("{" + nextVal + "}", "'" + replaceVal + "'");
                    }
                }
                //参数匹配不上的情况处理
                if (backControlName.equals(frontControlName)) {
                    //获取剩余参数个数
                    char[] chars1 = KJZ.toCharArray();
                    int Pnum = 0;
                    for (int j = 0; j < chars1.length; j++) {
                        if ('{' == chars1[j]) {
                            Pnum++;
                        }
                    }
                    for (int i = 0; i < Pnum; i++) {
                        int a1 = KJZ.indexOf("{");
                        int b1 = KJZ.indexOf("}");
                        String nextVal1 = KJZ.substring(a1 + 1, b1);
                        KJZ = KJZ.replace("{" + nextVal1 + "}", "''");
                    }
                }
                //参数替换完 开始执行
                if (KJZ.indexOf("{") < 1) {
                    try {
                        xlkMap1 = jdbcTemplate.queryForList(KJZ);
                        ckAll.put((String) map3.get("KJMC"), xlkMap1);
                        //获取每一个下拉框默认值放入map集合（map包括外部参数）， 没有取数据第一条
                        if (StringUtils.isEmpty(MRZ)) {
                        	if(xlkMap1.size()>0){
                            	map.put((String) map3.get("KJMC"), xlkMap1.get(0).get("code").toString());
                            }
                        } else {
                            map.put((String) map3.get("KJMC"), MRZ);
                        }
                    } catch (Exception e) {
                        throw new BuilderTableException("获取" + map3.get("TJMC") + "控件值 执行sql语句报错!", e);
                    }
                } else {
                    //没替换完 放入集合， 等参数控件值 执行完  ， 重新执行  依次循环
                    ckRemain.add(map3);
                    frontControlName = (String) map3.get("KJMC");
                }

            }
            //生成查询条件控件
            for (int i = 0; list.size() > i; i++) {
                if (i == 0 || i % 3 == 0) {
                    sb.append("	<div class=\"form-group\" >");
                }
                Map<String, Object> map1 = new HashMap<String, Object>();
                map1.putAll((Map) list.get(i));
                String MRZ = (String) map1.get("MRZ");
                if (MRZ == null) {
                    MRZ = "";
                }

                //------------------------默认值javascript脚本支持 update by xhm 1122------------------------------------
                if (StringUtils.isNotBlank(MRZ)) {
                    MRZ = ScriptEngineUtils.scriptEngine(MRZ);
                }

                //------------------------默认值javascript脚本支持 update by xhm 1122-------------------------------------
                //添加空格对齐
                String tjmc = (String) map1.get("TJMC");
                String kg = "";
                //是否必填
                String btString = "";
                if(map1.get("BT").equals("1")){
                	btString = "<span style=\"color:red\">*</span>";
                }
                if(dataMap.containsKey(map1.get("KJMC"))){
                	MRZ = dataMap.get(map1.get("KJMC")).toString();
                }
                //渲染数据
                if (map1.get("KJLX").equals("1")) { //文本框
                    String placeholder = "";
                    if (StringUtils.isNotBlank((String) map1.get("SY")))
                        placeholder = (String) map1.get("SY");

                    if (map1.get("KJZT").equals("0")) {
                        sb.append("		<div >");
                    } else {
                        sb.append("		<div style=\"display:none;\">");
                    }
                    sb.append("			<label title =\"" + map1.get("TJMC") + "\" style=\" max-width: 250px; overflow: hidden; text-overflow: ellipsis;  white-space: nowrap; \" class=\"col-md-2 col-sm-2 control-label\" >" + kg +btString+map1.get("TJMC") + "</label>");
                    sb.append("			<div class=\"col-md-2 col-sm-2\"><input type=\"text\" class=\"form-control input-sm \"  placeholder=\"" + placeholder + "\"   value=\"" + MRZ + "\"  name=\"" + map1.get("KJMC") + "\" id=\"" + map1.get("KJMC") + "\"></div>");
                    sb.append("		</div>");
                } else if (map1.get("KJLX").equals("3")) {//下拉框
                    //获取下拉框数据
                    if (map1.get("KJZT").equals("0")) {
                        sb.append("		<div >");
                    } else {
                        sb.append("		<div  style=\"display:none;\">");
                    }
                    sb.append("			<label title =\"" + map1.get("TJMC") + "\" style=\" max-width: 250px; overflow: hidden; text-overflow: ellipsis;  white-space: nowrap; \" class=\"col-md-2 col-sm-2 control-label\" >" + kg +btString+ map1.get("TJMC") + "</label>");
                    sb.append("			<div class=\"col-md-2 col-sm-2\"><select class=\"form-control input-sm\" onchange=\"eventListen(this.id)\" name=\"" + map1.get("KJMC") + "\" id=\"" + map1.get("KJMC") + "\"> ");

                    if (ckAll.size() > 0) {
                        List<Map<String, Object>> xlk = (List<Map<String, Object>>) ckAll.get(map1.get("KJMC"));

//                        for (int j = 0; j < xlk.size(); j++) {
//                            Map<String, Object> map0 = new HashMap<String, Object>();
//                            map0.putAll((Map) xlk.get(j));
//                            String code = map0.get("code").toString();
//                            String name = map0.get("name").toString();
//                            if (code.equals(MRZ) || name.equals(MRZ)) {
//                                sb.append("			<option selected=\"selected\" value=\"" + map0.get("code") + "\">" + map0.get("name") + "</option>");
//                            } else {
//                                sb.append("			<option value=\"" + map0.get("code") + "\">" + map0.get("name") + "</option>");
//                            }
//                        }
                        /*
                        if ("".equals(MRZ)) {
                            sb.append("			<option selected=\"selected\" value=\"\">全部</option>");
                        } else {
                            sb.append("			<option  value=\"\">全部</option>");
                        }*/
                        for (int j = 0; j < xlk.size(); j++) {
                            Map<String, Object> map0 = new HashMap<String, Object>();
                            map0.putAll((Map) xlk.get(j));
                            String code = map0.get("code").toString();
                            String name = map0.get("name").toString();
                            if (code.equals(MRZ) || name.equals(MRZ)) {
                                sb.append("			<option selected=\"selected\" value=\"" + map0.get("code") + "\">" + map0.get("name") + "</option>");
                            } else {
                                sb.append("			<option value=\"" + map0.get("code") + "\">" + map0.get("name") + "</option>");
                            }
                        }
                    }

                    sb.append("				</select></div>");
                    sb.append("		</div>");
                } else if (map1.get("KJLX").equals("5")) {//日期
                    if (map1.get("KJZT").equals("0")) {
                        sb.append("		<div >");
                    } else {
                        sb.append("		<div  style=\"display:none;\">");
                    }
                    sb.append("			<label title =\"" + map1.get("TJMC") + "\" style=\" max-width: 250px; overflow: hidden; text-overflow: ellipsis;  white-space: nowrap; \" class=\"col-md-2 col-sm-2 control-label\" >" + kg +btString+ map1.get("TJMC") + "</label>");
                    sb.append("		<div class=\"col-md-2 col-sm-2\">	<input type=\"text\" class=\"form-control input-sm \"  value=\"" + MRZ + "\" name=\"" + map1.get("KJMC") + "\" id=\"" + map1.get("KJMC") + "\"></div>");
                    sb.append("		</div>");
                    sb.append("<script type=\"text/javascript\">");
                    if (map1.get("KJLXGS").equals("yyyy")) {
                        sb.append("	$('#" + map1.get("KJMC") + "').datepicker({ format: 'yyyy',  minViewMode:2 }); ");
                    } else if (map1.get("KJLXGS").equals("yyyy-mm")) {
                        sb.append("	$('#" + map1.get("KJMC") + "').datepicker({ format: 'yyyy-mm',  minViewMode:1 }); ");
                    } else if (map1.get("KJLXGS").equals("yyyy-mm-dd")) {
                        sb.append("	$('#" + map1.get("KJMC") + "').datepicker({ format: 'yyyy-mm-dd',  minViewMode:0 }); ");
                    }
                    sb.append("</script>");
                }
                if (list.size() == i + 1 || (i + 1) % 3 == 0) {
                    sb.append("	</div>");
                }
            }
        }
        // sb.append("</form>");
        sb.append("<script type=\"text/javascript\">");
        sb.append(" function eventListen(id){ ");
        sb.append("		jQuery.ajax({ ");
        sb.append("	    	url: '../vr/linkage', ");
        sb.append("	    	type: 'POST', ");
        sb.append("	    	dataType: 'json',");
        sb.append("	    	data:{id: id, rpid: '" + map.get("rpid") + "'}");
        sb.append("		}) ");
        sb.append("		.done(function(jsonObj) { ");
        sb.append("			if(jsonObj.length > 0){");
        sb.append("				for ( var i = 0; i < jsonObj.length; i++) {");
        sb.append("					triggerEvent(jsonObj[i].KJMC, jsonObj[i].KJZ);");
        sb.append("				}");
        sb.append(" 		}");
        sb.append("		}) ");
        sb.append("		.fail(function() { ");
        sb.append("			console.log(\"error\"); ");
        sb.append("		}) ");
        sb.append("		.always(function() { ");
        sb.append("			console.log(\"complete\"); ");
        sb.append("		});");
        sb.append(" }");

        sb.append(" function triggerEvent(kjmc, kjz){");
        sb.append("		var signsCount=kjz.split(\"{\").length-1; ");
        sb.append("		for ( var k = 0; k < signsCount; k++) { ");
        sb.append("			var before=kjz.indexOf('{'); ");
        sb.append("			var after=kjz.indexOf('}'); ");
        sb.append("			var kjmc_t=kjz.substring(before+1, after); ");
        sb.append("			if($(\"#\"+kjmc_t).length>0){ ");
        sb.append("				kjz=kjz.replace(\"{\"+kjmc_t+\"}\",  \"'\"+$(\"#\"+kjmc_t).val().replace(/'/gm,\"\")+\"'\" );");
        sb.append("			}else{");
        sb.append("				if($(\"input[name='\"+kjmc_t+\"']\").length>0){ ");
        sb.append("					kjz=kjz.replace(\"{\"+kjmc_t+\"}\",  \"'\"+$(\"input[name='\"+kjmc_t+\"']\").val().replace(/'/gm,\"\")+\"'\" ); ");
        sb.append("				}");
        sb.append("			} ");
        sb.append("		} ");
        sb.append("		var signsCount1=kjz.split(\"{\").length-1;");
        sb.append("		for ( var x = 0; x < signsCount1; x++) {");
        sb.append("			var before1=kjz.indexOf('{');");
        sb.append("			var after1=kjz.indexOf('}');");
        sb.append("			var kjmc_t1=kjz.substring(before1+1, after1);");
        sb.append("			kjz=kjz.replace(\"{\"+kjmc_t1+\"}\",  \"''\" );");
        sb.append("		}");
        sb.append("		jQuery.ajax({ ");
        sb.append("	    	url: '../vr/linkageControl', ");
        sb.append("	    	type: 'POST', ");
        sb.append("	    	dataType: 'json',");
        sb.append("	    	data:{kjz: kjz}");
        sb.append("		}) ");
        sb.append("		.done(function(jsonObj) { ");
        sb.append("			$(\"#\"+kjmc).val(\"\");");
        sb.append("			var option=\"\";	");
        sb.append("			if(jsonObj.length > 0){");
        sb.append("				for ( var i = 0; i < jsonObj.length; i++) {");
        sb.append("					option+=\"<option value=\"+jsonObj[i].code+\">\"+jsonObj[i].name+\"</option>\";");
        sb.append("				}");
        sb.append(" 		}");
        sb.append("			$(\"#\"+kjmc).html(option); ");
        sb.append("			eventListen(kjmc); ");
        sb.append("		}) ");
        sb.append("		.fail(function() { ");
        sb.append("			console.log(\"error\"); ");
        sb.append("		}) ");
        sb.append("		.always(function() { ");
        sb.append("			console.log(\"complete\"); ");
        sb.append("		});");
        sb.append(" }");
        sb.append("</script>");
        //System.out.println(sb);
        return sb.toString();
    }
    
    /**
     * 创建工具栏
     */
    public String builerToolBar(List list) {
        StringBuffer sb = new StringBuffer();
        StringBuffer sb1 = new StringBuffer();
        StringBuffer sb2 = new StringBuffer();
        for (int i = 0; i < list.size(); i++) {
            Map map = new HashMap();
            map.putAll((Map) list.get(i));
            if ("3".equals(map.get("ANDM")) || "31".equals(map.get("ANDM"))) {
                sb1.append("<li id=\"" + map.get("ANFF") + "\">");
                sb1.append("	<a>" + map.get("ANMC") + "</a>");
                sb1.append("</li>");
            } else {
                sb.append("<button  type=\"button\" class=\"btn btn-default btn-sm\" id=\"" + map.get("ANFF") + "\" >" + map.get("ANMC") + "</button>");
            }
        }
        if (sb1.length() > 0) {
            sb2.append("<div class=\"btn-group\" style=\"float: left;\" >");
            sb2.append("<button type=\"button\" class=\"btn btn-default dropdown-toggle btn-sm\" data-toggle=\"dropdown\">导出 <span class=\"caret\"></span></button>");
            sb2.append("<ul class=\"dropdown-menu\" role=\"menu\" >");
            sb2.append(sb1);
            sb2.append("</ul>");
            sb2.append("</div>");
        }
        sb2.append(sb);
        //sb.append(sb2);
        return sb2.toString();
    }

    /**
     * 创建表格列
     */
    public String builerTableColumns(List<RpTableCol> reportCol, Map<String, Object> params) throws BuilderTableException {
        Object candel = params.get("candel");
        Object canupdate = params.get("canupdate");
        if (reportCol == null || reportCol.size() == 0)
            throw new BuilderTableException("该报表尚未设置表格列，请设置！");
        StringBuilder sb = new StringBuilder();
        sb.append(" [");
        Integer i = 0;
        Integer flg = 0;
        boolean hashz = false;
        for (RpTableCol col : reportCol) {
            i++;
            if (!"1".equals(col.getKjzt()))//非隐藏
                flg++;
            sb.append(BuilderUtils.builderColJson(col, jdbcTemplate, params, i, flg));
            if (i != reportCol.size())
                sb.append(",");

            if (StringUtils.isNotBlank(col.getHzlx()) && ("1".equals(col.getHzlx()) || "2".equals(col.getHzlx())) && !"1".equals(col.getKjzt()))
                hashz = true;
        }
        if (candel != null || canupdate != null) {
            sb.append(" , {field:\"\", title:\"操作\",align:\"center\",formatter:function(value,row,rowIndex){" );
            sb.append("       var strHtml =' " );
            if(candel != null){
            	sb.append("  <a href=\"javascript:void(0);\" onclick=\"removeRow('+rowIndex+')\">删除</a> " );
            }
            if(canupdate != null){
            	sb.append("  <a href=\"javascript:void(0);\" onclick=\"updateRow('+rowIndex+')\">修改</a> " );
            }
            sb.append("      '; " );
            sb.append("       return strHtml;");
            sb.append("     },edit:false} ");
        }
        
        sb.append("]");
        String resultStr = sb.toString();
        if (hashz) {
            resultStr = resultStr.replace("huiz_winning_huiz", "汇总");
            return resultStr;
        } else {
            resultStr = resultStr.replace("huiz_winning_huiz", "");
            return resultStr;
        }
    }

    /**
     * 构造导出表格的表头
     *
     * @return
     * @throws BuilderTableException
     */
    public String[] builderExportTableHeaders(List<RpTableCol> reportCol) throws BuilderTableException {
        List<String> heads = new ArrayList<String>();
        for (RpTableCol col : reportCol) {
            if (!"1".equals(col.getKjzt()) && StringUtils.isNotBlank(col.getBtmc())) //显示的列
                heads.add(col.getBtmc());
        }
        int size = heads.size();
        String[] arr = (String[]) heads.toArray(new String[size]);
        return arr;
    }

    /**
     * 构造导出表格的数据内容 map类型构造
     *
     * @throws BuilderTableException
     */
    public List<Map> builderExportTableMaps(List<RpTableCol> reportCol, String jsonStr) throws BuilderTableException {
        for (RpTableCol col : reportCol) {
            if (!"1".equals(col.getKjzt()) && StringUtils.isNotBlank(col.getBtmc())) {
                if (StringUtils.isNotBlank(col.getBcsjyl())) {
                    jsonStr = jsonStr.replaceAll("\"" + col.getBcsjyl() + "\"", "\"" + col.getBtmc() + "\"");
                } else if (StringUtils.isNotBlank(col.getBqsjyl())) {
                    jsonStr = jsonStr.replaceAll("\"" + col.getBqsjyl() + "\"", "\"" + col.getBtmc() + "\"");
                }
            }
        }
        List<Map> rsult = JSONArray.parseArray(jsonStr, Map.class);
        return rsult;
    }


    /**
     * 创建表格
     */

    abstract String builderTable();

    /**
     * 构建表格json数据
     */
    abstract String builderDataJson(List<RpTableCol> reportCol, List<RpDataSource> reportDataSource) throws BuilderTableException;


}
