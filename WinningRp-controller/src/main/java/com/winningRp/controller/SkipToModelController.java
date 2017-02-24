package com.winningRp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.winningRp.common.bean.UrlParamBean;
import com.winningRp.common.util.RegexHtmlUtil;


@Controller
@RequestMapping("/skip.do")
public class SkipToModelController extends BaseController {

    @SuppressWarnings("restriction")
    @Resource
    private JdbcTemplate template;

    @RequestMapping(params = "action=init")
    public ModelAndView modelviewInit(HttpServletRequest request, HttpServletResponse response) {
        setSessionCache2(request, response);
        Map resultMap = new HashMap();
        String tag = null;
        try {
            String html_id = request.getParameter("id");
            String sql = " select HTML t from TAB_HTML where ID=?";
            Map<String, Object> map = template.queryForMap(sql, new Object[]{html_id});
            tag = (String) (map != null ? map.get("t") : "");
            System.out.println("=============================================");
            System.out.println(tag);
            System.out.println("=============================================");
        } catch (Exception e) {
            resultMap.put("html", "未找到模版！确认模版参数！");
            return new ModelAndView("/sjypz/modelView", resultMap);
        }
     //   System.out.println("11111111111111111111111");
        try {
            StringBuffer builder = new StringBuffer(tag);
            if (tag != null) {
                List<String> source = RegexHtmlUtil.getInputSource(tag);
                List<String> column = RegexHtmlUtil.getInputcolumn(tag);
                List<String> values = RegexHtmlUtil.getInputValue(tag);
                int value_index = builder.indexOf("value=");
                if (value_index != -1) {
                    for (int i = 0; i < values.size(); i++) {
                        int value_len = values.get(i).length();
                        if (value_len == 0) {
                            //value=""
                            builder.insert(value_index + 7, request.getSession().getAttribute(source.get(i) + "." + column.get(i)) == null ? "" : request.getSession().getAttribute(source.get(i) + "." + column.get(i)));
                        } else {
                            //value="****"
                            if (request.getSession().getAttribute(source.get(i) + "." + column.get(i)) != null) {
//								builder.insert(value_index+7,request.getAttribute(source.get(i)+"."+column.get(i))); 
                                builder.replace(value_index + 7, value_index + 7 + value_len, (String) request.getSession().getAttribute(source.get(i) + "." + column.get(i)));
                            }
//							builder.insert(value_index+7,"${"+source.get(i)+"."+column.get(i)+"}");   
                        }
                        value_index = builder.indexOf("value=", value_index + 10);
                    }
                }
            }
            resultMap.put("html", builder);
            System.out.println("---------------------------------------------");
            System.out.println(builder);
            System.out.println("---------------------------------------------");
            return new ModelAndView("/sjypz/modelView", resultMap);
        } catch (Exception e) {
            resultMap.put("html", tag);
            return new ModelAndView("/sjypz/modelView", resultMap);
        }
    }


    /**
     * 合同模版名：db_name
     */
    public void setSessionCache(HttpServletRequest request, HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        String db_name = request.getParameter("db_name");
        String sql = "select source_sql sql,source_column col from TAB_DATASOURCE_CONFIG where SOURCE_NAME=?";
        if (db_name != null) {
            Map<String, Object> sqlMap = template.queryForMap(sql, new Object[]{db_name});
            String sqlStr = (String) sqlMap.get("sql");
            String columnStr = (String) sqlMap.get("col");
            //解析sql  将前台入参 替换掉
            String builder = new String(sqlStr);

            Map paraMap = request.getParameterMap();
            if (paraMap != null) {
                Set<String> keys = paraMap.keySet();
                for (String key : keys) {
                    //判断参数有值  非空
                    if (!("".equals(request.getParameter(key)) || request.getParameter(key) == null)) {
                        builder = builder.toUpperCase().replace("${" + key.toUpperCase() + "}", request.getParameter(key));
                    }
                }
            }

            Map<String, Object> resultMap = template.queryForMap(builder);
            if (resultMap != null) {
                String[] columnArr = columnStr.split(",");
                for (String c : columnArr) {
                    request.getSession().setAttribute(db_name + "." + c.toUpperCase(), resultMap.get(c));
                }
            }

        }
    }

    /**
     * 合同模版名：db_name
     */
    public void setSessionCache2(HttpServletRequest request, HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
//        request.getSession().invalidate();
        String sql = "select source_sql sql,source_column col,source_name name from TAB_DATASOURCE_CONFIG where SOURCE_NAME=?";
        Map parasMap = request.getParameterMap();
        String builder = null;
        if (parasMap != null) {
            Set<String> keys = parasMap.keySet();
            //key:  s.falsh=...
            for (String key : keys) {
                if (key.indexOf(".") != -1) {
                    String[] url = key.split("\\.");
                    String db_name = url[0];  //数据源名
                    String keyColumn = url[1];  //字段名
                    String keyValue = ((String[]) parasMap.get(key))[0];
                    System.out.println(db_name + ":" + keyColumn + "====>" + keyValue);
                    if (db_name != null) {
                        Map<String, Object> sqlMap = template.queryForMap(sql, new Object[]{db_name});
                        String sqlStr = (String) sqlMap.get("sql");
                        String columnStr = (String) sqlMap.get("col");
                        String source_name = (String) sqlMap.get("name");
                        //解析sql  将前台入参 替换掉
                        builder = new String(sqlStr);
                        for (String column : keys) {
                            if (column.indexOf(".") != -1) {
                                String[] url1 = column.split("\\.");
                                String keySource = url1[0];//数据源名
                                String keyColumn1 = url1[1];  //字段名
                                String keyValue1 = ((String[]) parasMap.get(column))[0];
                                if (source_name.equals(keySource)) {
                                    builder = builder.toUpperCase().replace("${" + keyColumn1.toUpperCase() + "}", keyValue1);
                                }
                            }
                        }
                        try {
                            Map<String, Object> resultMap = template.queryForMap(builder);
                            if (resultMap != null) {
                                String[] columnArr = columnStr.split(",");
                                for (String c : columnArr) {
                                    request.getSession().setAttribute(db_name + "." + c.toUpperCase(), resultMap.get(c));
                                }
                            }
                        } catch (Exception e) {

                        }


                    }
                }


            }
        }


    }


    @RequestMapping(params = "action=source")
    public ModelAndView sourceInit(HttpServletRequest request, HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        String sql = " select HTML html,id,NAME name from TAB_HTML";
        List<Map<String, Object>> list = template.queryForList(sql);
        Map resultMap = new HashMap();
        resultMap.put("lists", list);
        return new ModelAndView("/sjypz/source", resultMap);
    }

    @RequestMapping(params = "action=hrefConfig")
    public ModelAndView hrefConfig(HttpServletRequest request, HttpServletResponse response) {
        String html_id = request.getParameter("id");
        String htmlname = request.getParameter("htmlname");
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Set<String> all = new HashSet<String>();
        List<UrlParamBean> beanList = new ArrayList<UrlParamBean>();
        Map resultMap = new HashMap();
        if (html_id != null) {
            String sql = "select SOURCE_NAME name,SOURCE_SQL sql from  TAB_DATASOURCE_CONFIG " +
                    " where SOURCE_NAME in(select distinct SOURCE_NAME from TAB_DATASOURCE_HTML where HTML_ID=?) ";
            list = template.queryForList(sql, new Object[]{html_id});
            if (list != null && list.size() > 0) {
                for (Map<String, Object> map : list) {
                    List<String> nameParaList = new ArrayList<String>();
                    UrlParamBean bean = new UrlParamBean();
                    String sqlExe = (String) map.get("sql");
                    String sourceName = (String) map.get("name");
                    bean.setSql(sqlExe);
                    bean.setSourceName(sourceName);
                    List<String> params = RegexHtmlUtil.getSqlParams(sqlExe);
                    if (params != null && params.size() > 0) {
                        for (String string : params) {
                            if (!nameParaList.contains(sourceName + "." + string)) {
                                nameParaList.add(sourceName + "." + string);
                            }
                            all.add(sourceName + "." + string);
                        }
                        bean.setParamsList(nameParaList);
                    }
                    beanList.add(bean);
                }
            }
        }

        resultMap.put("beanList", beanList);
        resultMap.put("allList", all);
        resultMap.put("html_id", html_id);
        resultMap.put("htmlname", htmlname);
        return new ModelAndView("/sjypz/urlConfig", resultMap);
    }


}
