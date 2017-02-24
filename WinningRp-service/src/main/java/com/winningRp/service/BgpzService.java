package com.winningRp.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.winningRp.common.util.PageVariable;

@Service
public class BgpzService extends BaseService {

	/**
	 * 表格信息
	 */
	private static final String SAVE_BGMC = "INSERT INTO dbo.DIM_BBSZ_BGMC  ( ID ,JGDM ,JGMC , BGDM ,BGMC ,LB , FL ,URL ,CXTJXS ,JLZT , BGLX ,TBBMC) "
																		+ " VALUES  ( ?,?,?,?,?,?,?,?,?,?,?,?)";
	/**
	 *按钮信息
	 */
	private static final String SAVE_AN = " INSERT INTO DIM_BGSZ_BGGJL exec('SELECT '''+?+''',ANDM,ANMC,ANFF FROM DIM_BGSZ_GJL WHERE JLZT=''0'' AND ANDM IN ('+?+')')";
	
	/**
	 * 数据源信息
	 */
	private static final String SAVE_SJY = " INSERT INTO dbo.DIM_BGSZ_BGSJY  ( BGDM, SJYDM, SJYMC, SQLYJ ) VALUES  (?,?,?,?)"; 
	
	/**
	 * 查询条件
	 */
	private static final String SAVE_CXTJ = " INSERT INTO dbo.DIM_BBSZ_CXTJ  ( ID ,BGDM ,TJMC ,KJMC ,KJLX , KJZT ,KJZ ,MRZ ,KJLXGS ,SY ,KJSJ ,KJSJYXSX,KJSX) "
																	 + "VALUES  (?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	/**
	 * 显示结果
	 */
	private static final String SAVE_XSJG = " INSERT INTO dbo.DIM_BBSZ_XSJG (ID ,BGDM ,BTMC ,BQSJYL ,BCSJYL ,KJMC ,KJLX ,KJZT ,KJZ ,MRZ , KJLXGS , SY ,BT ,YXBJ , JYLX ,JYDM ,"+
																		"TSXX ,XSWZ , LJDZ ,ZXFS ,KZFX ,HZLX,SJYDM, SX, ISZJ) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	/**
	 * 表格配置信息
	 */
	private final static String DELETE_BGPZ_BYBGDM = "DELETE FROM DIM_BBSZ_BGMC WHERE BGDM=?";
	
	/**
	 * 按钮信息
	 */
	private final static String DELETE_AN_BYBGDM = "DELETE FROM DIM_BGSZ_BGGJL WHERE BGDM= ?";
	
	/**
	 * 数据源信息
	 */
	private final static String DELETE_SJY_BYBGDM = "DELETE FROM DIM_BGSZ_BGSJY WHERE BGDM=?";
	
	/**
	 * 查询条件
	 */
	private final static String DELETE_CXTJ_BYBGDM = "DELETE FROM DIM_BBSZ_CXTJ WHERE BGDM=?";
	
	/**
	 * 显示结果
	 */
	private final static String DELETE_XSJG_BYBGDM = "DELETE FROM DIM_BBSZ_XSJG WHERE BGDM=?";
	@Transactional
	public void saveBgpz(Map map) throws Exception {
		//1、表格基本信息
		Map bgmcMap = new HashMap();
		if("add".equals(map.get("opt"))){
			bgmcMap.put("ID", UUID.randomUUID().toString());
		}else{
			bgmcMap.put("ID", map.get("bgid"));
		}
		bgmcMap.put("JGDM", map.get("jgdm"));
		bgmcMap.put("JGMC", map.get("jgjc"));
		bgmcMap.put("BGDM", map.get("bgdm"));
		bgmcMap.put("BGMC", map.get("bgmc"));
		bgmcMap.put("LB", map.get("lb"));
		bgmcMap.put("FL", map.get("fl"));
		String url = "/rpView/"+bgmcMap.get("BGDM");
		bgmcMap.put("URL", url);
		bgmcMap.put("CXTJXS", map.get("cxtj"));
		bgmcMap.put("JLZT", map.get("jlzt"));
		bgmcMap.put("BGLX", map.get("bglx"));
		bgmcMap.put("TBBMC", map.get("tbbmc"));
		dao.getJdbcTemplate().update(SAVE_BGMC,new Object[]{bgmcMap.get("ID"),bgmcMap.get("JGDM"),bgmcMap.get("JGMC"),bgmcMap.get("BGDM"),
				bgmcMap.get("BGMC"),bgmcMap.get("LB"),bgmcMap.get("FL"),bgmcMap.get("URL"),bgmcMap.get("CXTJXS"),bgmcMap.get("JLZT"),bgmcMap.get("BGLX"),
				bgmcMap.get("TBBMC")});
		//2、按钮
		Map anMap = new HashMap();
		anMap.put("BGDM", map.get("bgdm"));
		String an = (String) map.get("an");
		an = an.replaceAll("\"", "'");
		an=StringUtils.substringBetween(an,"[", "]");
		if(!"".equals(an) && an!=null){
			anMap.put("ANDM", an);
			String aa=(String) anMap.get("BGDM");
			String bb=(String) anMap.get("ANDM");
			dao.getJdbcTemplate().update(SAVE_AN,new Object[]{anMap.get("BGDM"),anMap.get("ANDM")});
		}
		//3、数据源
		String sjydm = (String) map.get("sjydm");
		String sjymc = (String) map.get("sjymc");
		String sjysql = (String) map.get("sjysql");
		sjysql = sjysql.replace("\\n", " ");
		sjysql = sjysql.replace("\\t", " ");
		sjydm = sjydm.replaceAll("\"", "");
		sjymc = sjymc.replaceAll("\"", "");
		
		sjydm = StringUtils.substringBetween(sjydm, "[", "]");
		sjymc = StringUtils.substringBetween(sjymc, "[", "]");
		sjysql = StringUtils.substringBetween(sjysql, "[", "]");
		if(!"".equals(sjydm) && sjydm!=null){
			String[] sjydms = sjydm.split(",");
			String[] sjymcs = sjymc.split(",");
			String[] sjysqls = StringUtils.substringsBetween(sjysql, "\"", "\"");
			final List<Map> sjyList = new ArrayList<Map>();
			Map sjyMap = null;
			for (int i=0 ;i < sjydms.length;i++) {
				sjyMap = new HashMap();
				sjyMap.put("BGDM", map.get("bgdm"));
				sjyMap.put("SJYDM", sjydms[i]);
				sjyMap.put("SJYMC", sjymcs[i]);
				sjyMap.put("SQLYJ", sjysqls[i].replaceAll("\"", ""));
				sjyList.add(sjyMap);
			}
			dao.getJdbcTemplate().batchUpdate(SAVE_SJY,new BatchPreparedStatementSetter() {
				public void setValues(PreparedStatement ps, int i) throws SQLException {
					Map<String,String> dataMap = sjyList.get(i);
					ps.setString(1, dataMap.get("BGDM"));
					ps.setString(2, dataMap.get("SJYDM"));
					ps.setString(3, dataMap.get("SJYMC"));
					ps.setString(4, dataMap.get("SQLYJ"));
				}
				public int getBatchSize() {
					return sjyList.size();
				}
			});
		}
		//4、查询条件
		String tjid = (String) map.get("tjid");
		String tjmc = (String) map.get("tjmc");
		String kjmc = (String) map.get("kjmc");
		String kjlx = (String) map.get("kjlx");
		String kjzt = (String) map.get("kjzt");
		String kjz = (String) map.get("kjz");
		kjz = kjz.replace("\\n", " ");
		kjz = kjz.replace("\\t", " ");
		String mrz = (String) map.get("mrz");
		String kjlxgs = (String) map.get("kjlxgs");
		String sy = (String) map.get("sy");
		String kjsx = (String) map.get("kjsx");
		//除去 []
		tjid = StringUtils.substringBetween(tjid, "[", "]");
		tjmc = StringUtils.substringBetween(tjmc, "[", "]");
		kjmc = StringUtils.substringBetween(kjmc, "[", "]");
		kjlx = StringUtils.substringBetween(kjlx, "[", "]");
		kjzt = StringUtils.substringBetween(kjzt, "[", "]");
		kjz = StringUtils.substringBetween(kjz, "[", "]");
		mrz = StringUtils.substringBetween(mrz, "[", "]");
		kjlxgs = StringUtils.substringBetween(kjlxgs, "[", "]");
		sy = StringUtils.substringBetween(sy, "[", "]");
		kjsx = StringUtils.substringBetween(kjsx, "[", "]");
		if(!"".equals(tjid) && tjid!=null){
			String[] tjids = tjid.split(",");
			String[] tjmcs = tjmc.split(",");
			String[] kjmcs = kjmc.split(",");
			String[] kjlxs = kjlx.split(",");
			String[] kjzts = kjzt.split(",");
			String[] kjzs = kjz.split(",");
			String[] mrzs = mrz.split(",");
			String[] kjlxgss = kjlxgs.split(",");
			String[] sys = sy.split(",");
			String[] kjsxs = kjsx.split(",");
			
			final List<Map> cxtjList = new ArrayList<Map>();
			Map cxtjMap = null;
			for(int i=0 ;i < tjids.length ; i++){
				cxtjMap = new HashMap();
				cxtjMap.put("ID", StringUtils.replace(tjids[i], "\"", ""));
				cxtjMap.put("BGDM", map.get("bgdm"));
				cxtjMap.put("TJMC", StringUtils.replace(tjmcs[i], "\"", "").replace("!^", ","));
				cxtjMap.put("KJMC", StringUtils.replace(kjmcs[i], "\"", "").replace("!^", ","));
				cxtjMap.put("KJLX", StringUtils.replace(kjlxs[i], "\"", "").replace("!^", ","));
				cxtjMap.put("KJZT", StringUtils.replace(kjzts[i], "\"", "").replace("!^", ","));
				cxtjMap.put("KJZ", StringUtils.replace(kjzs[i], "\"", "").replace("!^", ","));
				cxtjMap.put("MRZ", StringUtils.replace(mrzs[i], "\"", "").replace("!^", ","));
				cxtjMap.put("KJLXGS", StringUtils.replace(kjlxgss[i], "\"", "").replace("!^", ","));
				cxtjMap.put("SY", StringUtils.replace(sys[i], "\"", "").replace("!^", ","));
				cxtjMap.put("KJSJ", "");
				cxtjMap.put("KJSJYXSX", "");
				cxtjMap.put("KJSX", StringUtils.replace(kjsxs[i], "\"", "").replace("!^", ","));
				cxtjList.add(cxtjMap);
			}
			dao.getJdbcTemplate().batchUpdate(SAVE_CXTJ,new BatchPreparedStatementSetter() {
				public void setValues(PreparedStatement ps, int i) throws SQLException {
					Map<String,String> dataMap = cxtjList.get(i);
					ps.setString(1, dataMap.get("ID"));
					ps.setString(2, dataMap.get("BGDM"));
					ps.setString(3, dataMap.get("TJMC"));
					ps.setString(4, dataMap.get("KJMC"));
					ps.setString(5, dataMap.get("KJLX"));
					ps.setString(6, dataMap.get("KJZT"));
					ps.setString(7, dataMap.get("KJZ"));
					ps.setString(8, dataMap.get("MRZ"));
					ps.setString(9, dataMap.get("KJLXGS"));
					ps.setString(10, dataMap.get("SY"));
					ps.setString(11, dataMap.get("KJSJ"));
					ps.setString(12, dataMap.get("KJSJYXSX"));
					ps.setString(13, dataMap.get("KJSX"));
				}
				public int getBatchSize() {
					return cxtjList.size();
				}
			});
		}
		//5、显示结果
		String kjid = (String) map.get("kjid");
		String s_kjmc = (String) map.get("s_kjmc");
		String s_btmc = (String) map.get("s_btmc");
		String s_kjlx = (String) map.get("s_kjlx");
		String s_kjzt = (String) map.get("s_kjzt");
		String s_qsjyl = (String) map.get("s_qsjyl");
		String s_kjz = (String) map.get("s_kjz");
		s_kjz = s_kjz.replace("\\n", " ");
		s_kjz = s_kjz.replace("\\t", " ");
		String s_csjyl = (String) map.get("s_csjyl");
		String s_mrz = (String) map.get("s_mrz");
		String s_kjgs = (String) map.get("s_kjgs");
		String s_sy = (String) map.get("s_sy");
		String s_bt = (String) map.get("s_bt");
		String s_yxbj = (String) map.get("s_yxbj");
		String s_jylx = (String) map.get("s_jylx");
		String s_jydm = (String) map.get("s_jydm");
		String s_tsxx = (String) map.get("s_tsxx");
		String s_xswz = (String) map.get("s_xswz");
		String s_ljdz = (String) map.get("s_ljdz");
		String s_zxfs = (String) map.get("s_zxfs");
		String s_kzfx = (String) map.get("s_kzfx");
		String s_hzlx = (String) map.get("s_hzlx");
		String s_sjydm = (String) map.get("s_sjydm");
		String s_sx = (String) map.get("s_sx");
		String s_iszj = (String) map.get("s_iszj");
		
		//除去[]
		kjid = StringUtils.substringBetween(kjid, "[", "]");
		s_kjmc = StringUtils.substringBetween(s_kjmc, "[", "]");
		s_btmc = StringUtils.substringBetween(s_btmc, "[", "]");
		s_kjlx = StringUtils.substringBetween(s_kjlx, "[", "]");
		s_kjzt = StringUtils.substringBetween(s_kjzt, "[", "]");
		s_qsjyl = StringUtils.substringBetween(s_qsjyl, "[", "]");
		s_kjz = StringUtils.substringBetween(s_kjz, "[", "]");
		s_csjyl = StringUtils.substringBetween(s_csjyl, "[", "]");
		s_mrz = StringUtils.substringBetween(s_mrz, "[", "]");
		s_kjgs = StringUtils.substringBetween(s_kjgs, "[", "]");
		s_sy = StringUtils.substringBetween(s_sy, "[", "]");
		s_bt = StringUtils.substringBetween(s_bt, "[", "]");
		s_yxbj = StringUtils.substringBetween(s_yxbj, "[", "]");
		s_jylx = StringUtils.substringBetween(s_jylx, "[", "]");
		s_jydm = StringUtils.substringBetween(s_jydm, "[", "]");
		s_tsxx = StringUtils.substringBetween(s_tsxx, "[", "]");
		s_xswz = StringUtils.substringBetween(s_xswz, "[", "]");
		s_ljdz = StringUtils.substringBetween(s_ljdz, "[", "]");
		s_zxfs = StringUtils.substringBetween(s_zxfs, "[", "]");
		s_kzfx = StringUtils.substringBetween(s_kzfx, "[", "]");
		s_hzlx = StringUtils.substringBetween(s_hzlx, "[", "]");
		s_sjydm = StringUtils.substringBetween(s_sjydm, "[", "]");
		s_sx = StringUtils.substringBetween(s_sx, "[", "]");
		s_iszj = StringUtils.substringBetween(s_iszj, "[", "]");
		
		if(!"".equals(kjid) && kjid != null){
			String[] kjids = kjid.split(",");
			String[] s_kjmcs = s_kjmc.split(",");
			String[] s_kjlxs = s_kjlx.split(",");
			String[] s_kjzts = s_kjzt.split(",");
			String[] s_qsjyls = s_qsjyl.split(",");
			String[] s_kjzs = s_kjz.split(",");
			String[] s_csjyls = s_csjyl.split(",");
			String[] s_mrzs = s_mrz.split(",");
			String[] s_kjgss = s_kjgs.split(",");
			String[] s_sys = s_sy.split(",");
			String[] s_bts = s_bt.split(",");
			String[] s_yxbjs = s_yxbj.split(",");
			String[] s_jylxs = s_jylx.split(",");
			String[] s_jydms = s_jydm.split(",");
			String[] s_tsxxs = s_tsxx.split(",");
			String[] s_xswzs = s_xswz.split(",");
			String[] s_ljdzs = s_ljdz.split(",");
			String[] s_zxfss = s_zxfs.split(",");
			String[] s_kzfxs = s_kzfx.split(",");
			String[] s_hzlxs = s_hzlx.split(",");
			String[] s_sjydms = s_sjydm.split(",");
			String[] s_sxs = s_sx.split(",");
			String[] s_iszjs = s_iszj.split(",");
			String[] s_btmcs = s_btmc.split(",");
			 
			final List<Map> xsjgList = new ArrayList<Map>();
			Map xsjgMap = null;
			for(int i=0 ;i < kjids.length ; i++){
				xsjgMap = new HashMap();
				xsjgMap.put("ID", StringUtils.replace(kjids[i], "\"", ""));
				xsjgMap.put("BGDM", map.get("bgdm"));
				xsjgMap.put("BTMC", StringUtils.replace(s_btmcs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("BQSJYL", StringUtils.replace(s_qsjyls[i], "\"", "").replace("!^", ","));
				xsjgMap.put("BCSJYL", StringUtils.replace(s_csjyls[i], "\"", "").replace("!^", ","));
				xsjgMap.put("KJMC", StringUtils.replace(s_kjmcs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("KJLX", StringUtils.replace(s_kjlxs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("KJZT", StringUtils.replace(s_kjzts[i], "\"", "").replace("!^", ","));
				xsjgMap.put("KJZ", StringUtils.replace(s_kjzs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("MRZ", StringUtils.replace(s_mrzs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("KJLXGS", StringUtils.replace(s_kjgss[i], "\"", "").replace("!^", ","));
				xsjgMap.put("SY", StringUtils.replace(s_sys[i], "\"", "").replace("!^", ","));
				xsjgMap.put("BT", StringUtils.replace(s_bts[i], "\"", "").replace("!^", ","));
				xsjgMap.put("YXBJ", StringUtils.replace(s_yxbjs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("JYLX", StringUtils.replace(s_jylxs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("JYDM", StringUtils.replace(s_jydms[i], "\"", "").replace("!^", ","));
				xsjgMap.put("TSXX", StringUtils.replace(s_tsxxs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("XSWZ", StringUtils.replace(s_xswzs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("LJDZ", StringUtils.replace(s_ljdzs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("ZXFS", StringUtils.replace(s_zxfss[i], "\"", "").replace("!^", ","));
				xsjgMap.put("KZFX", StringUtils.replace(s_kzfxs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("HZLX", StringUtils.replace(s_hzlxs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("SJYDM", StringUtils.replace(s_sjydms[i], "\"", "").replace("!^", ","));
				xsjgMap.put("SX", StringUtils.replace(s_sxs[i], "\"", "").replace("!^", ","));
				xsjgMap.put("ISZJ",StringUtils.replace(s_iszjs[i], "\"", ""));
				xsjgList.add(xsjgMap);
			}
			dao.getJdbcTemplate().batchUpdate(SAVE_XSJG,new BatchPreparedStatementSetter() {
				public void setValues(PreparedStatement ps, int i) throws SQLException {
					Map<String,String> dataMap = xsjgList.get(i);
					ps.setString(1, dataMap.get("ID"));
					ps.setString(2, dataMap.get("BGDM"));
					ps.setString(3, dataMap.get("BTMC"));
					ps.setString(4, dataMap.get("BQSJYL"));
					ps.setString(5, dataMap.get("BCSJYL"));
					ps.setString(6, dataMap.get("KJMC"));
					ps.setString(7, dataMap.get("KJLX"));
					ps.setString(8, dataMap.get("KJZT"));
					ps.setString(9, dataMap.get("KJZ"));
					ps.setString(10, dataMap.get("MRZ"));
					ps.setString(11, dataMap.get("KJLXGS"));
					ps.setString(12, dataMap.get("SY"));
					ps.setString(13, dataMap.get("BT"));
					ps.setString(14, dataMap.get("YXBJ"));
					ps.setString(15, dataMap.get("JYLX"));
					ps.setString(16, dataMap.get("JYDM"));
					ps.setString(17, dataMap.get("TSXX"));
					ps.setString(18, dataMap.get("XSWZ"));
					ps.setString(19, dataMap.get("LJDZ"));
					ps.setString(20, dataMap.get("ZXFS"));
					ps.setString(21, dataMap.get("KZFX"));
					ps.setString(22, dataMap.get("HZLX"));
					ps.setString(23, dataMap.get("SJYDM"));
					ps.setString(24, dataMap.get("SX"));
					ps.setString(25, dataMap.get("ISZJ"));
				}
				public int getBatchSize() {
					return xsjgList.size();
				}
			});
		}
	}
	
	@Transactional
	public void updateBgpz(Map map) throws Exception {
		//使用先删除 再保存 id和表格代码与之前的数据保持一致
		dao.getJdbcTemplate().update(DELETE_BGPZ_BYBGDM, new Object[]{map.get("bgdm")});
		dao.getJdbcTemplate().update(DELETE_AN_BYBGDM, new Object[]{map.get("bgdm")});
		dao.getJdbcTemplate().update(DELETE_SJY_BYBGDM, new Object[]{map.get("bgdm")});
		dao.getJdbcTemplate().update(DELETE_CXTJ_BYBGDM, new Object[]{map.get("bgdm")});
		dao.getJdbcTemplate().update(DELETE_XSJG_BYBGDM, new Object[]{map.get("bgdm")});
		//保存
		if("update".equals(map.get("opt"))){
			saveBgpz(map);
		}
	}
	@Transactional
	public List selectBgpzPage(Map map) throws Exception {
		String sqlCount= "select Count(1) AS CNT from DIM_BBSZ_BGMC WHERE 1 = 1 ";
		String bbmc = (String) map.get("bbmc");
		String jlzt = (String) map.get("jlzt");
		String bglx = (String) map.get("bglx");
		
		if(!"".equals(bbmc) && bbmc !=null){
			sqlCount = sqlCount +   " AND BGMC LIKE '%"+bbmc+"%'";
		}
		
		if(!"".equals(jlzt) && jlzt !=null){
			sqlCount  = sqlCount + " AND JLZT ="+jlzt;
		}
		
		if(!"".equals(bglx) && bglx !=null){
			sqlCount  = sqlCount + " AND BGLX ="+bglx;
		}
		
		PageVariable page = (PageVariable) map.get("page");
		if (page == null) {
			page = new PageVariable();
		}
		// 得到符合条件的记录总数
		int recordCount = (Integer) dao.getJdbcTemplate().queryForObject(sqlCount, Integer.class);
		int first = (page.getCurrentPage() - 1) * page.getRecordPerPage();
		if (first < 0 || recordCount - first < 0) {
			first = 0;
		}
		map.put("startNum", first);
		map.put("endNum", first + page.getRecordPerPage());
		
		String sqlData = " SELECT  * FROM   ( SELECT TOP "+map.get("endNum")+" ROW_NUMBER() OVER ( ORDER BY H.ID ) AS RN ,H.*  FROM (  "+
				"SELECT   ID ,JGDM , JGMC , BGDM ,BGMC , LB , FL ,URL ,  CXTJXS , JLZT ,BGLX ,TBBMC  "+
  				"FROM  DIM_BBSZ_BGMC  WHERE 1 = 1";
		if(!"".equals(bbmc) && bbmc !=null){
			sqlData  = sqlData + " AND BGMC LIKE '%"+bbmc+"%'";
		}
		
		if(!"".equals(jlzt) && jlzt !=null){
			sqlData  = sqlData + " AND JLZT ="+jlzt;
		}
		
		if(!"".equals(bglx) && bglx !=null){
			sqlData  = sqlData + " AND BGLX ="+bglx;
		}
		sqlData = sqlData + " ) AS H ) AS HH WHERE   RN > ? ";
		
		// 1 设置记录总数。
		page.setRecordCount(recordCount);
		// 2 设置当前页的记录数目
		page.setRecordCountCurrentPage(page.getRecordPerPage());
		if (first + page.getRecordPerPage() > recordCount) {
			page.setRecordCountCurrentPage(recordCount - first);
		}
		// 3 计算总页数
		int pages = recordCount / page.getRecordPerPage();
		if (recordCount % page.getRecordPerPage() != 0) {
			pages++;
		}
		page.setPageCount(pages);
		return dao.getJdbcTemplate().queryForList(sqlData, new Object[]{map.get("startNum")});
	}

	private static final String SELECT_BGPZ_BYBGDM = "SELECT  ID ,JGDM ,JGMC ,BGDM ,BGMC ,LB ,FL ,URL , CXTJXS ,JLZT ,BGLX ,TBBMC FROM  DIM_BBSZ_BGMC WHERE BGDM=";

	private static final String SELECT_AN_BYBGDM = "SELECT BGDM,ANDM,ANMC,ANFF FROM DIM_BGSZ_BGGJL WHERE BGDM=?";

	private static final String SELECT_SJY_BYBGDM = "SELECT BGDM, SJYDM, SJYMC,  REPLACE(REPLACE(SQLYJ,CHAR(13),' '),CHAR(10),' ') AS SQLYJ FROM DIM_BGSZ_BGSJY WHERE BGDM = ?";

	private static final String SELECT_CXTJ_BYBGDM = "SELECT ID ,BGDM ,TJMC ,KJMC ,KJLX ,KJZT ,REPLACE(REPLACE(KJZ,CHAR(13),' '),CHAR(10),' ') AS KJZ ,MRZ ,KJLXGS ,SY ,KJSJ ,KJSJYXSX,KJSX FROM DIM_BBSZ_CXTJ WHERE BGDM = ? ORDER BY KJSX";

	private static final String SELECT_XSJG_BYBGDM = "SELECT ID ,BGDM ,BTMC ,BQSJYL ,BCSJYL ,KJMC ,KJLX ,KJZT , REPLACE(REPLACE(KJZ,CHAR(13),' '),CHAR(10),' ') AS KJZ , MRZ , KJLXGS ,SY ,BT ,YXBJ ,JYLX , JYDM ,TSXX , XSWZ ,LJDZ ,ZXFS ,KZFX , HZLX,SJYDM,SX,ISZJ FROM DIM_BBSZ_XSJG WHERE BGDM = ? ORDER BY SX";

	@Transactional
	public Map selectAllBgpz(Map map) throws Exception {
		Map dataMap = new HashMap();
		//1、表格基本信息
		Map bgpz = dao.queryForObject(SELECT_BGPZ_BYBGDM+"'"+map.get("BGDM")+"'");
		dataMap.put("bgpz", bgpz);
		//2、按钮信息
		List<Map> anList =dao.queryForList(SELECT_AN_BYBGDM, new Object[]{map.get("BGDM")});
		dataMap.put("an", anList);
		//3、数据源信息
		List<Map> sjyList =dao.queryForList(SELECT_SJY_BYBGDM, new Object[]{map.get("BGDM")});
		dataMap.put("sjy", sjyList);
		//4、查询条件信息
		List<Map> cxtjList = dao.queryForList(SELECT_CXTJ_BYBGDM, new Object[]{map.get("BGDM")});
		dataMap.put("cxtj", cxtjList);
		//5、显示结果信息
		List<Map> xsjgList = dao.queryForList(SELECT_XSJG_BYBGDM, new Object[]{map.get("BGDM")});
		dataMap.put("xsjg", xsjgList);
		return dataMap;
	}

}
