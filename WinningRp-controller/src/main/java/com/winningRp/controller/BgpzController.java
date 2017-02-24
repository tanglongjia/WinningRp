package com.winningRp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.winningRp.common.util.MapUtil;
import com.winningRp.common.util.MessageStreamResult;
import com.winningRp.common.util.PageVariable;
import com.winningRp.service.BgpzService;

@Controller
@RequestMapping(value = "/bt_bgpz")
public class BgpzController extends BaseController  {

	
private static Log log= LogFactory.getLog(BaseController.class);
	
	@SuppressWarnings("restriction")
	@Resource
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private BgpzService bgpzService;
	
	/**
	 * 表格信息
	 */
	private static final String SAVE_BGMC = "INSERT INTO dbo.DIM_BBSZ_BGMC  ( ID ,JGDM ,JGMC , BGDM ,BGMC ,LB , FL ,URL ,CXTJXS ,JLZT , BGLX ,TBBMC) "
																		+ " VALUES  ( ?,?,?,?,?,?,?,?,?,?,?,?)";
	
	
	/**
	 * 查询
	 * */
	@RequestMapping(params = "action=search",method = RequestMethod.GET)  
	public ModelAndView search(HttpServletRequest request, HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		ModelAndView modelAndView = new ModelAndView("/bgpz/bgpzInit", map);
		return modelAndView;
	} 
	
	@RequestMapping(params = "action=bgpzTableInitNew")  
	public ModelAndView bgpzTableInitNew(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> map = MapUtil.doParameterMap(true, request);
		String bgmc = (String)map.get("bbmc")==null?"":(String)map.get("bbmc");
		String bglx = (String)map.get("bglx")==null?"":(String)map.get("bglx");
		String sql = " SELECT ID , JGDM , JGMC , BGDM , BGMC , LB , FL , URL , CXTJXS , JLZT , BGLX , TBBMC FROM  DIM_BBSZ_BGMC " +
				" WHERE  bgmc like '%"+bgmc+"%' ";
		try{
			List<Map<String, Object>> bgpzList = new ArrayList<Map<String,Object>>();
			if(!"".equals(bglx)){
				sql = sql + " and bglx=?";
				bgpzList = jdbcTemplate.queryForList(sql,new Object[]{bglx});
			}else{
				bgpzList = jdbcTemplate.queryForList(sql,new Object[]{});
			}
			 
			map.put("tables", bgpzList);
			if(bgpzList!=null && bgpzList.size()>0){
				map.put("firstBGDM",bgpzList.get(0).get("BGDM"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return new ModelAndView("/bgpz/bgpzDataNew",map);
	}
	
	/**
	 * 合并后初始化
	 * */
	@RequestMapping(params = "action=initNew",method = RequestMethod.GET)  
	public ModelAndView initNew(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map<String, Object> map = MapUtil.doParameterMap(true, request);
		return new ModelAndView("/bgpz/bgpzInitNew",map);
	} 
	
	/**
	 *  预览报表弹出
	 * */
	@RequestMapping(params = "action=initPreViewNew",method = RequestMethod.GET)  
	public ModelAndView initPreViewNew(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map<String, Object> map = MapUtil.doParameterMap(true, request);
		return new ModelAndView("bgpz/reportViewNew",map);
	} 
	
	/**
	 * 查看全部
	 * */
	@RequestMapping(params = "action=queryAllReports",method = RequestMethod.GET)  
	public ModelAndView queryAllReports(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map<String, Object> map = MapUtil.doParameterMap(true, request);
		map.put("flag", "1");
		return new ModelAndView("bgpz/bgpzInit",map);
	} 
	
	
	@RequestMapping(params = "action=updateBgNew")  
	public ModelAndView updateBgNew(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map<String, Object> map = MapUtil.doParameterMap(true, request);
		System.out.println("------------");
		Map dataMap=bgpzService.selectAllBgpz(map);
		map.put("dataMap", dataMap);
		return new ModelAndView("bgpz/updateBgNew",map);
	} 
	
	@RequestMapping(params = "action=insertBgmcNew")  
	public void insertBgmcNew(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map<String, Object> map = MapUtil.doParameterMap(true, request);
		map.put("jgdm", "42482523300");
		map.put("jgjc", "凉城");
//		map.put("jgdm", loginInfo.getJgbm());
//		map.put("jgjc", loginInfo.getJgjc());
		// 0保存成功 1保存失败 2更新成功 3更新失败
		String flag = "0";
		try {
			//1、表格基本信息
			Map bgmcMap = new HashMap();
			bgmcMap.put("ID", UUID.randomUUID().toString());
			bgmcMap.put("JGDM", map.get("jgdm"));
			bgmcMap.put("JGMC", map.get("jgjc"));
			bgmcMap.put("BGDM", map.get("bgdm"));
			bgmcMap.put("BGMC", map.get("bgmc"));
			bgmcMap.put("LB", map.get("lb"));
			bgmcMap.put("FL", map.get("fl"));
			String url = "/rpView/"+bgmcMap.get("ID");
			bgmcMap.put("URL", url);
			bgmcMap.put("CXTJXS", map.get("cxtj"));
			bgmcMap.put("JLZT", map.get("jlzt"));
			bgmcMap.put("BGLX", map.get("bglx"));
			bgmcMap.put("TBBMC", map.get("tbbmc"));
			jdbcTemplate.update(SAVE_BGMC,new Object[]{bgmcMap.get("ID"),bgmcMap.get("JGDM"),bgmcMap.get("JGMC"),bgmcMap.get("BGDM"),
					bgmcMap.get("BGMC"),bgmcMap.get("LB"),bgmcMap.get("FL"),bgmcMap.get("URL"),bgmcMap.get("CXTJXS"),bgmcMap.get("JLZT"),bgmcMap.get("BGLX"),
					bgmcMap.get("TBBMC")});
		} catch (Exception e) {
			flag = "1";
		}
		try {
			MessageStreamResult.msgStreamResult(response, flag);
		} catch (Exception e) {
			
		}
	} 
	
	/**
	 * 数据源新增跳转
	 * */
	@RequestMapping(params = "action=ds_add",method = RequestMethod.GET)  
	public ModelAndView dsAdd(HttpServletRequest request, HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		ModelAndView modelAndView = new ModelAndView("/bgpz/sjy", map);
		return modelAndView;
	} 
	
	/**
	 * 数据源更新跳转
	 * */
	@RequestMapping(params = "action=ds_update",method = RequestMethod.GET)  
	public ModelAndView dsUpdate(HttpServletRequest request, HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		map.put("dsname", request.getParameter("dsname"));
		map.put("sqlscript", request.getParameter("sqlscript"));
		ModelAndView modelAndView = new ModelAndView("/bgpz/sjy", map);
		return modelAndView;
	} 
	
	/**
	 * 获取数据
	 * */
	@RequestMapping(params = "action=getData")  
	public ModelAndView getData(HttpServletRequest request, HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		Map<String, Object> pageMap = new HashMap<String, Object>();
		PageVariable page = new PageVariable();
 		String pageId = request.getParameter("pageid");
 		if (StringUtils.isNotEmpty(pageId)) {
 			page.setCurrentPage(Integer.parseInt(pageId));
 		}
 		map.put("page",page);
 		List<Map> bgpzList = new ArrayList();
 		bgpzList = bgpzService.selectBgpzPage(map);
 		pageMap.put("bgpzList", bgpzList);
 		pageMap.put("page", map.get("page"));
		return new ModelAndView("bgpz/bgpzData",pageMap);
	} 
	
	/**
	 * 初始化
	 * */
	@RequestMapping(params = "action=init",method = RequestMethod.GET)  
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		return new ModelAndView("/bgpz/bgpzJmsz",map);
	} 
	
	/**
	 * 获取按钮工具组
	 * */
	@RequestMapping(params = "action=getButtonTool")
	public ModelAndView getTree(HttpServletRequest request,HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		 //(List)dao.queryForList("BGPZ.getButtonTool", map);
		String sql = "select * from DIM_BGSZ_GJL WHERE JLZT='0'";
		List list=jdbcTemplate.queryForList(sql);
		MessageStreamResult.msgStreamResult(response, JSONArray.fromObject(list).toString());
		return null;
	}

	/**
	 * 脚本验证
	 * */
	@RequestMapping(params = "action=sqlValidation")
	public ModelAndView sqlValidation(HttpServletRequest request,HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		String sql=(String)map.get("jbdm");
		request.setCharacterEncoding("UTF-8");
		String sqlscript = (String) map.get("jbdm");
		String[] rows = StringUtils.substringsBetween(sqlscript, "{", "}");
		if(rows!=null){
			for (String row : rows) {
				sqlscript = StringUtils.replace(sqlscript, "{"+row+"}", "''");
			}
		}
		String[] list1 ={};
		List list =null;
		String zt="0";
		if(sqlscript.indexOf("exec")==-1 && sqlscript.indexOf("if")==-1){
			sqlscript="select top 1 * from ("+sqlscript+") a";
		}
		try {
			 //jdbcTemplate.query(sqlscript);
			list1=dao.getJdbcTemplate().queryForRowSet(sqlscript).getMetaData().getColumnNames();
		} catch (Exception e) {
			zt="1";
		}
//		if(zt.equals("0")){
//			list1=dao.getJdbcTemplate().queryForRowSet(sqlscript).getMetaData().getColumnNames();
//		}
		for (int i = 0; i < list1.length; i++) {
			zt+=","+list1[i];
		}
		String[] col=zt.split(",");
		Map dataMap = new HashMap();
		dataMap.put("sqlid", map.get("id"));
		dataMap.put("sqlmc", map.get("mc"));
		dataMap.put("sql", sql);
		dataMap.put("col", col);
		
		//list.add(dataMap);
		
		MessageStreamResult.msgStreamResult(response, JSONArray.fromObject(dataMap).toString());
		return null;
	}
	
	@RequestMapping(params = "action=getCsjyl")
	public ModelAndView getCsjyl(HttpServletRequest request,HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		String tabName=(String)map.get("tabName");
		tabName = tabName.replace("'", "");
		String tabName1=tabName;
		tabName = "if exists (select 1 from  sysobjects  where  id = object_id('"+tabName+"')  and   type = 'U') begin select '1' as zt end else begin select '2' as zt end" ;
		List list = jdbcTemplate.queryForList(tabName);
		Map<String, String> map= new HashMap<String, String>();
		map.putAll((Map) list.get(0));
		String zt=map.get("zt");
		String[] list1 =null;
		if(zt.equals("1")){
			tabName1="select * from "+tabName1+" ";
			list1=dao.getJdbcTemplate().queryForRowSet(tabName1).getMetaData().getColumnNames();
		}
		MessageStreamResult.msgStreamResult(response, JSONArray.fromObject(list1).toString());
		return null;
	}
	
	
	
	/**
	 * 获取控件类型
	 * */
	@RequestMapping(params = "action=getKjlx")
	public ModelAndView getZbmc(HttpServletRequest request,HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		String sql = "select WTBH, DABH, DAXX from sys_dazb_bg where DAZX='01' and WTBH in('100','101','102')";
		List list = jdbcTemplate.queryForList(sql);
		Map dataMap = new HashMap();
		String kjlx = request.getParameter("kjlx");
		dataMap.put("kjlx", kjlx);
		list.add(dataMap);
		MessageStreamResult.msgStreamResult(response, JSONArray.fromObject(list).toString());
		return null;
	}
	
	@RequestMapping(params = "action=delBgpz")
	public ModelAndView delBgpz(HttpServletRequest request,HttpServletResponse response){
		map=MapUtil.doParameterMap(true, request);
		try {
			map.put("opt", "del");
			bgpzService.updateBgpz(map);
			MessageStreamResult.msgStreamResult(response, "1");
		} catch (Exception e) {
			try {
				MessageStreamResult.msgStreamResult(response, "0");
			} catch (Exception e1) {
				
			}
		}
		return null;
	}
	
	@RequestMapping(params = "action=getRow")
	public ModelAndView getRow(HttpServletRequest request,HttpServletResponse response){
		map=MapUtil.doParameterMap(true, request);
		try {
			String sqlscript = (String) map.get("sqlscript");
			String[] rows = StringUtils.substringsBetween(sqlscript, "{", "}");
			if(rows!=null){
				MessageStreamResult.msgStreamResult(response, JSONArray.fromObject(rows).toString());
			}else{
				MessageStreamResult.msgStreamResult(response, "");
			}
		} catch (Exception e) {
			try {
				MessageStreamResult.msgStreamResult(response, "");
			} catch (Exception e1) {
				
			}
		}
		return null;
	}
	
	@RequestMapping(params = "action=getSqlData")
	public ModelAndView getSqlData(HttpServletRequest request,HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		request.setCharacterEncoding("UTF-8");
		String sqlscript = request.getParameter("sqlscript");
		String[] rows = StringUtils.substringsBetween(sqlscript, "{", "}");
		if(rows !=null){
			for (String row : rows) {
				sqlscript = StringUtils.replace(sqlscript, "{"+row+"}", (String)map.get(row));
			}
		}
		List list = jdbcTemplate.queryForList(sqlscript);
		List theadList = new ArrayList();
		if(list.size() > 0 ){
			Map keyMap = (Map) list.get(0);
			Set set = keyMap.keySet();
			for (Object object : set) {
				theadList.add(object);
			}
		}
		map.put("theadList", theadList);
		map.put("dataList", list);
		return new ModelAndView("bgpz/getSqlData",map);
	}
	
	
	
	/** 
	* saveOrUpdate(数据保存和更新) 
	* @Title: saveOrUpdate 
	* @Description: TODO 
	* @param @param request
	* @param @param response
	* @param @return
	* @param @throws Exception 设定文件
	* @return ModelAndView 返回类型 
	* @throws 
	*/
	@RequestMapping(params = "action=saveOrUpdate")
	public ModelAndView saveOrUpdate(HttpServletRequest request,HttpServletResponse response){
		map=MapUtil.doParameterMap(true, request);
		String opt =request.getParameter("opt");
		//LoginInfo loginInfo = (LoginInfo) ThreadLocalObj.getObj();
		map.put("jgdm", "42482523300");
		map.put("jgjc", "凉城");
		// 0保存成功 1保存失败 2更新成功 3更新失败
		String flag = "0";
		if("add".equals(opt)){
			try {
				bgpzService.saveBgpz(map);
			} catch (Exception e) {
				flag = "1";
			}
		}
		if("update".equals(opt)){
			try {
				bgpzService.updateBgpz(map);
				flag = "2";
			} catch (Exception e) {
				flag = "3";
			}
		}
		try {
			MessageStreamResult.msgStreamResult(response, flag);
		} catch (Exception e) {
			
		}
		return null;
	}
	
	@RequestMapping(params = "action=updateBg")  
	public ModelAndView updateBg(HttpServletRequest request, HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		Map dataMap=bgpzService.selectAllBgpz(map);
		map.put("dataMap", dataMap);
		return new ModelAndView("bgpz/updateBg",map);
	} 
	
	@RequestMapping(params = "action=showBg")  
	public ModelAndView showBg(HttpServletRequest request, HttpServletResponse response)throws Exception{
		map=MapUtil.doParameterMap(true, request);
		Map dataMap=bgpzService.selectAllBgpz(map);
		map.put("dataMap", dataMap);
		return new ModelAndView("bgpz/showBg",map);
	} 

	public BgpzService getBgpzService() {
		return bgpzService;
	}

	public void setBgpzService(BgpzService bgpzService) {
		this.bgpzService = bgpzService;
	}
}
