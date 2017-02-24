package com.winningRp.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.jdbc.support.rowset.SqlRowSetMetaData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
@Scope("prototype")
@RequestMapping("/sjy.do")
public class SjyController extends BaseController {
    @SuppressWarnings("restriction")
    @Resource
    private JdbcTemplate template;

    @RequestMapping(params = "action=init")
    public ModelAndView init(HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("/sjypz/sjypzInit", null);
    }

    @RequestMapping(params = "action=sjyInit")
    public ModelAndView sjyInit(HttpServletRequest request, HttpServletResponse response) {
//		template = SpringJdbcTemplateUtil.JdbcTemplateFactory();
        String sql = " select id,SOURCE_NAME name,SOURCE_SQL sql,SOURCE_COLUMN clm " +
                " from TAB_DATASOURCE_CONFIG";

        List<Map<String, Object>> list = template.queryForList(sql);
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("list", list);
        if (list != null && list.size() > 0) {
            param.put("firstId", list.get(0).get("id"));
            param.put("firstName", list.get(0).get("name"));
            param.put("firstClm", list.get(0).get("clm"));
            param.put("firstSql", list.get(0).get("sql"));
        }

        return new ModelAndView("/sjypz/sjypzData", param);
    }

    @RequestMapping(params = "action=operHandler")
    public String operHandler(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        String clm = "";
        String sqlp = request.getParameter("sql");
        String exeSql = null;

        //select ztbm from qmys_yszt where id='${yszt}' id是int类型会报错
        if (sqlp != null) {
            exeSql = sqlp.replace("'${", "@&@").replace("${", "@&@").replace("}'", "&@&").replace("}", "&@&");
            exeSql = exeSql.replaceAll("@&@([\\s\\S]*?)&@&", "(select null)");
        }


        String id = request.getParameter("id");
        try {
//			template = SpringJdbcTemplateUtil.JdbcTemplateFactory();
            SqlRowSet rows = template.queryForRowSet(exeSql);
            SqlRowSetMetaData metaData = rows.getMetaData();
            int columnCount = metaData.getColumnCount();
            for (int i = 1; i <= columnCount; i++) {
                clm = clm + metaData.getColumnName(i).toUpperCase() + ",";
            }
            System.out.println(clm);
            clm = clm.substring(0, clm.length() - 1);

            if ("insert".equals(request.getParameter("oper"))) {
                //数据源名称不能重复

                int r = template.queryForInt("select count(1) n from TAB_DATASOURCE_CONFIG where SOURCE_NAME=?", new Object[]{name});

                if (r > 0) {
                    response.getWriter().print("2");
                    return null;
                }

                String sql = "insert into TAB_DATASOURCE_CONFIG(ID,SOURCE_NAME,SOURCE_SQL,SOURCE_COLUMN) VALUES(NEWID(),?,?,?)";
                Object[] para = {name, sqlp, clm};
                template.update(sql, para);


            } else {
                int r = template.queryForInt("select count(1) n from TAB_DATASOURCE_CONFIG where SOURCE_NAME=?", new Object[]{name});

                if (r > 1) {
                    response.getWriter().print("2");
                    return null;
                }
                String sql = "update TAB_DATASOURCE_CONFIG set SOURCE_NAME=?,SOURCE_SQL=?,SOURCE_COLUMN=? where ID=?";
                Object[] para = {name, sqlp, clm, id};
                template.update(sql, para);
            }

            response.getWriter().print("1");

        } catch (Exception e) {
            try {
                response.getWriter().print("0");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

        return null;
    }

    @RequestMapping(params = "action=deleteHandler")
    public String deleteHandler(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String sql = " DELETE from TAB_DATASOURCE_CONFIG where ID=? AND " +
                " not exists(select a.id from TAB_DATASOURCE_CONFIG a inner join TAB_DATASOURCE_HTML b on a.id=? and a.source_name=b.source_name)";
        Object[] para = {id, id};
        try {
            int result = template.update(sql, para);
            if (result != 1) {
                response.getWriter().print("0");
            } else {
                response.getWriter().print("1");
            }
        } catch (Exception e) {
            try {
                response.getWriter().print("2");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
        return null;
    }


}
