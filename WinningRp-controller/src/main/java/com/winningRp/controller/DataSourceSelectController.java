package com.winningRp.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.fastjson.JSON;


@Controller
@RequestMapping("/initDataSource.do")
public class DataSourceSelectController extends BaseController {
    @SuppressWarnings("restriction")
    @Resource
    private JdbcTemplate template;

    @RequestMapping(params = "action=InitDataSource")
    public String InitDataSource(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("utf-8");
//		template = SpringJdbcTemplateUtil.JdbcTemplateFactory();
        String sql = "select SOURCE_NAME name from TAB_DATASOURCE_CONFIG";
        List<Map<String, Object>> lists = template.queryForList(sql);
        String json = JSON.toJSONString(lists);
        System.out.println(json);
        response.getWriter().print(json);
        return null;
    }

    @RequestMapping(params = "action=initColumn")
    public String initColumn(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("utf-8");
//		template = SpringJdbcTemplateUtil.JdbcTemplateFactory();
        String sql = "select SOURCE_COLUMN clm from TAB_DATASOURCE_CONFIG where SOURCE_NAME=?";
        Object[] para = {request.getParameter("source")};
        Map<String, Object> map = template.queryForMap(sql, para);
        if (map != null) {
            System.out.println(map.get("clm"));
            response.getWriter().print(map.get("clm"));
        }
        return null;
    }

}
