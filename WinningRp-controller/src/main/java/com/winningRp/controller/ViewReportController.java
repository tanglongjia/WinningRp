package com.winningRp.controller;

import com.alibaba.fastjson.JSONArray;
import com.winningRp.common.bean.JsonResult;
import com.winningRp.common.exception.BuilderTableException;
import com.winningRp.common.util.MapUtil;
import com.winningRp.common.util.MessageStreamResult;
import com.winningRp.common.util.excel.ExcelLogs;
import com.winningRp.common.util.excel.ExcelUtil;
import com.winningRp.service.RpViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/21.
 * TIME: 7:52.
 * WinningRp 报表显示控制器
 */
@Controller
@RequestMapping(value = "/rpView")
public class ViewReportController extends AbstractController {

    public static final String WINNING_URL_PARAMS = "WINNING_URL_PARAMS";

    @Autowired
    private RpViewService rpViewService;

    @RequestMapping(value = {"/{uid}"})
    public ModelAndView preview(@PathVariable String uid, HttpServletRequest request) throws Exception {
        Map<String, Object> urlParams = new HashMap<String, Object>();
        //添加的session的支持的
        HttpSession session = request.getSession();
        Enumeration enumeration = session.getAttributeNames();
        //循环参数
        while (enumeration.hasMoreElements()) {
            String key = enumeration.nextElement().toString();
            Object value = session.getAttribute(key);
            if (value instanceof String && ((String) value).length() <= 100) {//超长字符串不考虑
                urlParams.put(key, value);
            }
        }
        urlParams.putAll(MapUtil.doParameterMap(true, request));
        urlParams.put("rpid", uid);
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("rpid", uid);
        params.putAll(urlParams);
        rpViewService.reportEngine(params, urlParams);
        params.put(WINNING_URL_PARAMS, urlParams);//url传参数
        ModelAndView modelAndView = new ModelAndView("/report/view", params);
        return modelAndView;
    }

    /**
     * 保存报表
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/save"}, method = RequestMethod.POST)
    public JsonResult saveRp(HttpServletRequest request, HttpServletResponse response) throws Exception {
        JsonResult result = new JsonResult(false, "");
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        try {
            rpViewService.saveRp(params);
            setSuccessResult(result, "");
        } catch (BuilderTableException e) {
            setFailureResult(result, e.getMessage());
            logger.info(e.getMessage());
        } catch (Exception e) {
            setExceptionResult(result, e);
            logger.error("后台异常：", e);
        }
        MessageStreamResult.msgStreamResult(response, JSONArray.toJSONString(result));
        return null;
    }

    /**
     * 查询
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/search"}, method = RequestMethod.POST)
    public String searchRp(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        String jsonStr = "[]";
        try {
            jsonStr = rpViewService.searchReport(params);
        } catch (Exception e) {
            logger.error("后台异常：", e);
            e.printStackTrace();
        }
        params.put("datas", jsonStr);
        MessageStreamResult.msgStreamResult(response, JSONArray.toJSONString(params));
        return null;
    }

    /**
     * 导入文件
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/fileImport"}, method = RequestMethod.POST)
    public String fileImport(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        String pams = params.get("winning_allparams").toString();
        params.putAll(JSONArray.parseObject(pams, Map.class));
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        ExcelLogs logs = new ExcelLogs();
        Collection<Map> importExcel = null;
        try {
            importExcel = ExcelUtil.importExcel(multipartRequest.getFile("filename1").getOriginalFilename(), Map.class, multipartRequest.getFile("filename1").getInputStream(), "yyyy-MM-dd", logs, 0);
            if (importExcel == null || importExcel.size() == 0)
                importExcel = new ArrayList<Map>();
            String resultJson = rpViewService.importDataJson(importExcel, params);
            logger.info(JSONArray.toJSONString(importExcel));
            response.setContentType("text/html;charset=utf-8");
            response.getWriter().print("<script type='text/javascript'>" +
                    "window.parent.toastr.success(\"导入成功！\"); " +
                    "window.parent.hideMessage(); " +
                    "var winnning_import_result_json = " + resultJson + " ; " +
                    "window.parent.$(\"#reportTable\").bootstrapTable('append',winnning_import_result_json); " +
                    "window.parent.$('#reportTable').bootstrapTable('scrollTo', 'bottom');" +
                    "window.parent.$(\"#dialog-form\").dialog(\"close\");" +
                    "</script>");
        } catch (Exception e) {
            logger.error("后台异常：", e);
            response.setContentType("text/html;charset=utf-8");
            response.getWriter().print("<script type='text/javascript'>" +
                    "window.parent.toastr.success(\"导入失败！\"); " +
                    "window.parent.hideMessage(); " +
                    "window.parent.$(\"#dialog-form\").dialog(\"close\");" +
                    "</script>");
        }
        return null;
    }

    /**
     * 导出模板
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/exportTemplate"}, method = RequestMethod.POST)
    public String exportTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        response.setContentType("application/x-download");
        response.setHeader("Content-Disposition", "filename="
                + "excel.xlsx");
        List<Map> result = new ArrayList<Map>();
        String[] headers = rpViewService.ExportReportTemplate(params);
        ExcelUtil.exportExcel(headers, result, response.getOutputStream());
        return null;
    }


    /**
     * 文件导出
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/fileExport"}, method = RequestMethod.POST)
    public String fileExport(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        response.setContentType("application/x-download");
        response.setHeader("Content-Disposition", "filename="
                + "excel.xlsx");
        List<Map> result = new ArrayList<Map>();
        String[] headers = rpViewService.ExportReport(params, result);
        ExcelUtil.exportExcel(headers, result, response.getOutputStream());
        return null;
    }

    /**
     * 全部导出
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/fileExportAll"}, method = RequestMethod.POST)
    public String fileExportAll(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        response.setContentType("application/x-download");
        response.setHeader("Content-Disposition", "filename="
                + "excel.xlsx");
        List<Map> result = new ArrayList<Map>();
        String[] headers = rpViewService.ExportReportAll(params, result);
        ExcelUtil.exportExcel(headers, result, response.getOutputStream());
        return null;
    }

    /**
     * 远程执行SQL
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/remoteSql"}, method = RequestMethod.POST)
    public String remoteSql(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        List<Map<String, Object>> maps = rpViewService.remoteSql(params);
        MessageStreamResult.msgStreamResult(response, JSONArray.toJSONString(maps));
        return null;
    }

    /**
     * 物理删除数据
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/delete"}, method = RequestMethod.POST)
    public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        try {
            rpViewService.deleteObj(params);
        } catch (Exception e) {
            logger.error("后台异常：", e);
            MessageStreamResult.msgStreamResult(response, e.getMessage());
        }
        MessageStreamResult.msgStreamResult(response, "");
    }
    
    /**
     * 修改数据
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/update"})
    public ModelAndView update(HttpServletRequest request, HttpServletResponse response)throws Exception{
    	Map<String, Object> map = MapUtil.doParameterMap(true, request);
		ModelAndView modelAndView = new ModelAndView("/report/test", map);
		return modelAndView;
	}
    
    /**
     * 查询主键
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/queryPk"}, method = RequestMethod.POST)
    public ModelAndView queryPk(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        List<String> pks = null;
		try {
			pks = rpViewService.searchPk(params);
        } catch (Exception e) {
            logger.error("后台异常：", e);
            MessageStreamResult.msgStreamResult(response, e.getMessage());
        }
		MessageStreamResult.msgStreamResult(response, JSONArray.toJSONString(pks));
		return null;
	}
    
    /**
     * 查询表格列
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = {"/queryTable"}, method = RequestMethod.POST)
    public ModelAndView queryTable(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	//ModelAndView modelAndView = new ModelAndView("/report/test", new HashMap<String, Object>());
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        String tc = "";
		try {
			tc = rpViewService.searchForm(params);
        } catch (Exception e) {
            logger.error("后台异常：", e);
        }
		MessageStreamResult.msgStreamResult(response, tc);
		return null;
	}
    /**
     * 保存表单数据
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value={"/saveForm"} , method = RequestMethod.POST)
    public ModelAndView saveForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
    	JsonResult result = new JsonResult(false, "");
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        try {
            rpViewService.saveForm(params);
            setSuccessResult(result, "");
        } catch (BuilderTableException e) {
            setFailureResult(result, e.getMessage());
            logger.info(e.getMessage());
        } catch (Exception e) {
            setExceptionResult(result, e);
            logger.error("后台异常：", e);
        }
        MessageStreamResult.msgStreamResult(response, JSONArray.toJSONString(result));
        return null;
    }

    /**
     * 解析表达式
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = {"/parseScript"}, method = RequestMethod.POST)
    public void parseScript(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> params = MapUtil.doParameterMap(true, request);
        String resultScript = "";
        try {
            resultScript = rpViewService.parseScript(params);
        } catch (Exception e) {
            logger.error("后台异常：", e);
        }
        MessageStreamResult.msgStreamResult(response, resultScript);
    }

}
