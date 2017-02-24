package com.winningRp.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.fastjson.JSON;
import com.winningRp.common.util.RegexHtmlUtil;


@Controller
@Scope("prototype")
@RequestMapping("/model.do")
public class ModelController {

    @SuppressWarnings("restriction")
    @Resource
    private JdbcTemplate jdbcTemplate;

    @RequestMapping(params = "action=init")
    public void init(HttpServletRequest request, HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        try {
            String html_id = request.getParameter("id");
            String sql = " select HTML html,id,NAME name from TAB_HTML where ID=?";
//			Map<String, Object> map = jdbcTemplate.queryForMap("select html t from tab_html where id=?");
            Map<String, Object> map = jdbcTemplate.queryForMap(sql, new Object[]{html_id});
            String json = JSON.toJSONString(map);
            System.out.println("----------------------");
            System.out.println(json);
            response.getWriter().print(json);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(params = "action=operHandler")
    public void operHandler(HttpServletRequest request, HttpServletResponse response) {

//		JdbcTemplate jdbcTemplate = SpringJdbcTemplateUtil.JdbcTemplateFactory();
        String oper = request.getParameter("oper");
        String html = request.getParameter("html");
        String modelname = request.getParameter("modelname");
        List<String> source = RegexHtmlUtil.getInputSource(html);
        List<String> column = RegexHtmlUtil.getInputcolumn(html);

        try {
            if ("".equals(oper)) {
                Map<String, Object> idMap = jdbcTemplate.queryForMap("select CONVERT(varchar(64),getdate(),112)+replace(CONVERT(varchar(64),getdate(),114),':','') id");
                String id = (String) idMap.get("id");
                String sql = "insert into TAB_HTML (ID,CREATETIME,HTML,NAME) VALUES(?,GETDATE(),?,?)";
                Object[] para = {id, html, modelname};
                jdbcTemplate.update(sql, para);
                //先删除配置表中关联该合同模版的配置
                String deleteSql = "delete from TAB_DATASOURCE_HTML where HTML_ID=?";
                jdbcTemplate.update(deleteSql, new Object[]{id});

                if (source != null && source.size() > 0) {
                    for (int i = 0; i < source.size(); i++) {
                        String insertSql = "INSERT INTO TAB_DATASOURCE_HTML(ID,HTML_ID,SOURCE_NAME,SOURCE_COLUMN) VALUES(NEWID(),?,?,?)";
                        jdbcTemplate.update(insertSql, new Object[]{id, source.get(i), column.get(i)});
                    }
                }
                response.getWriter().print(id);
            } else {
                String sql = "UPDATE TAB_HTML SET HTML=?,CREATETIME=GETDATE(),NAME=? WHERE ID=?";
                Object[] para = {html, modelname, oper};
                jdbcTemplate.update(sql, para);
                //先删除配置表中关联该合同模版的配置
                String deleteSql = "delete from TAB_DATASOURCE_HTML where HTML_ID=?";
                jdbcTemplate.update(deleteSql, new Object[]{oper});

                if (source != null && source.size() > 0) {
                    for (int i = 0; i < source.size(); i++) {
                        String insertSql = "INSERT INTO TAB_DATASOURCE_HTML(ID,HTML_ID,SOURCE_NAME,SOURCE_COLUMN) VALUES(NEWID(),?,?,?)";
                        jdbcTemplate.update(insertSql, new Object[]{oper, source.get(i), column.get(i)});
                    }
                }
                response.getWriter().print(oper);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

    }


}
