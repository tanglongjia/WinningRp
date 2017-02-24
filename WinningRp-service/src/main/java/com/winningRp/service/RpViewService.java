package com.winningRp.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Predicate;
import com.google.common.collect.Sets;
import com.winningRp.common.Constants;
import com.winningRp.common.bean.RpBgmc;
import com.winningRp.common.bean.RpDataSource;
import com.winningRp.common.bean.RpTableCol;
import com.winningRp.common.engine.EditTableBuilder;
import com.winningRp.common.exception.BuilderTableException;
import com.winningRp.common.util.RegExp;
import com.winningRp.common.util.ScriptEngineUtils;
import com.winningRp.common.util.SqlParserUtils;
import com.winningRp.dao.com.winningRp.dao.bean.ColumnProperty;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/24.
 * TIME: 1:03.
 * WinningRp  报表显示引擎
 */
@Service
public class RpViewService extends BaseService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    private RpBaseService rpBaseService;

    /**
     * 显示报表
     *
     * @param params
     * @throws Exception
     */
    public void reportEngine(Map<String, Object> params, Map<String, Object> urlParams) throws Exception {
        List<RpTableCol> reportCol = rpBaseService.getReportCol(params);
        // List<RpDataSource> reportDataSource = rpBaseService.getReportDataSource(params);
        List<RpBgmc> rpBgmcs = rpBaseService.getReportDetail(params);
        List<Map<String, Object>> reportWhereEx = rpBaseService.getReportWhereEx(params);
        //过滤重复传参
        for (Map<String, Object> whereEx : reportWhereEx) {
            if (whereEx.get("KJMC") != null && StringUtils.isNotBlank(whereEx.get("KJMC").toString()) && urlParams.get(whereEx.get("KJMC").toString()) != null) {
                whereEx.put("MRZ", urlParams.get(whereEx.get("KJMC").toString()));
                urlParams.remove(whereEx.get("KJMC").toString());
            }
        }
        List list1 = rpBaseService.getReportToolBars(params);
        //查询条件
        //Map<String, Object> stringObjectMap = builderWhereExMap(reportWhereEx);
        EditTableBuilder editTableBuilder = new EditTableBuilder(dao.getJdbcTemplate());
        String s = editTableBuilder.builerTableColumns(reportCol, params);
        String s2 = editTableBuilder.builderTable();
        params.put("demo", String.format(s2, s, "[]"));
        params.put("whereEx", editTableBuilder.builderWhereEx(reportWhereEx, params));
        params.put("tools", editTableBuilder.builerToolBar(list1));
        if (rpBgmcs != null && rpBgmcs.size() > 0) {
            params.put("WINNING_BGMC", rpBgmcs.get(0).getBGMC());
        }
    }

    /**
     * 查询条件封装Map
     *
     * @param reportWhereEx
     * @return
     * @throws Exception
     */
    private Map<String, Object> builderWhereExMap(List<Map<String, Object>> reportWhereEx) throws Exception {
        Map<String, Object> params = new HashMap<String, Object>();
        for (Map<String, Object> map : reportWhereEx) {
            if (map.get("KJMC") != null && StringUtils.isNotBlank(map.get("KJMC").toString()))
                params.put(map.get("KJMC").toString(), map.get("MRZ"));
        }
        return params;
    }

    /**
     * 查询报表json
     *
     * @param params
     * @throws Exception
     */
    public String searchReport(Map<String, Object> params) throws Exception {
        List<RpTableCol> reportCol = rpBaseService.getReportCol(params);
        List<RpDataSource> reportDataSource = rpBaseService.getReportDataSource(params);
        EditTableBuilder editTableBuilder = new EditTableBuilder(dao.getJdbcTemplate());
        String s1 = editTableBuilder.builderDataJson(reportCol, reportDataSource, params);
        return s1;
    }
    
    /**
     * 查询存储表主键
     *
     * @param params
     * @throws Exception
     */
    public List searchPk(Map<String, Object> params) throws Exception {
        List list = rpBaseService.getTablePk(params);
        return list;
    }
    
    /**
     * 查询表单
     *
     * @param params
     * @throws Exception
     */
    public String searchForm(Map<String, Object> params) throws Exception {
    	List<RpTableCol> reportCol = rpBaseService.getReportCol(params);
        List list = rpBaseService.getTableColumn(params);
        List<RpDataSource> dsList = rpBaseService.getReportDataSource(params);
        EditTableBuilder editTableBuilder = new EditTableBuilder(dao.getJdbcTemplate());
        return editTableBuilder.builderForm(list, reportCol,dsList,params);
    }

    /**
     * 导出表头
     *
     * @param params
     * @return
     * @throws Exception
     */
    public String[] ExportReportTemplate(Map<String, Object> params) throws Exception {
        List<RpTableCol> reportCol = rpBaseService.getReportCol(params);
        List<String> heads = new ArrayList<String>();
        for (RpTableCol col : reportCol) {
            if (!"1".equals(col.getKjzt())) //显示的列
                heads.add(col.getBtmc());
        }
        int size = heads.size();
        String[] arr = (String[]) heads.toArray(new String[size]);
        return arr;
    }

    /**
     * 导入数据返回json
     *
     * @param importExcel
     * @param params
     * @return
     * @throws Exception
     */
    public String importDataJson(Collection<Map> importExcel, Map<String, Object> params) throws Exception {
        List<RpTableCol> reportCol = rpBaseService.getReportCol(params);
        String s = JSONArray.toJSONString(importExcel);
        for (RpTableCol col : reportCol) {
            if (StringUtils.isNotBlank(col.getBcsjyl())) {
                s = s.replaceAll("\"" + RegExp.escapeExprSpecialWord(col.getBtmc()) + "\"", "\"" + col.getBcsjyl() + "\"");
            } else {
                s = s.replaceAll("\"" + RegExp.escapeExprSpecialWord(col.getBtmc()) + "\"", "\"" + col.getBqsjyl() + "\"");
            }
        }
        importExcel = JSONArray.parseArray(s, Map.class);
        EditTableBuilder editTableBuilder = new EditTableBuilder(dao.getJdbcTemplate());
        return editTableBuilder.importDataJson(reportCol, params, importExcel);
    }


    /**
     * 封装导出报表
     *
     * @param params
     * @param result
     * @throws Exception
     */
    public String[] ExportReport(Map<String, Object> params, List<Map> result) throws Exception {
        List<RpTableCol> reportCol = rpBaseService.getReportCol(params);
        String exportJson = params.get(Constants.WINNING_EXPORT_JSON).toString();
        EditTableBuilder editTableBuilder = new EditTableBuilder(dao.getJdbcTemplate());
        String[] headers = editTableBuilder.builderExportTableHeaders(reportCol);
        result.addAll(editTableBuilder.builderExportTableMaps(reportCol, exportJson));
        return headers;
    }

    /**
     * 报表全部导出
     *
     * @param params
     * @param result
     * @return
     * @throws Exception
     */
    public String[] ExportReportAll(Map<String, Object> params, List<Map> result) throws Exception {
        String allParams = params.get(Constants.WINNING_EXPORT_JSON_PARAMS).toString();
        Map<String, Object> castParams = JSONArray.parseObject(allParams, Map.class);
        castParams.remove(Constants.WINNING_PAGING);//拒绝分页查询
        //模拟查询
        List<RpTableCol> reportCol = rpBaseService.getReportCol(castParams);
        List<RpDataSource> reportDataSource = rpBaseService.getReportDataSource(castParams);
        EditTableBuilder editTableBuilder = new EditTableBuilder(dao.getJdbcTemplate());
        String s1 = editTableBuilder.builderDataJson(reportCol, reportDataSource, castParams);
        String exportJson = s1;
        String[] headers = editTableBuilder.builderExportTableHeaders(reportCol);
        result.addAll(editTableBuilder.builderExportTableMaps(reportCol, exportJson));
        return headers;
    }


    /**
     * 保存报表
     *
     * @throws Exception
     */
    @Transactional
    public void saveRp(Map<String, Object> params) throws Exception {
        String rpid = params.get("rpid").toString();
        String json = params.get("updateData").toString();
        // System.out.println("更新的JSON数据：" + json);
        List<Map> rsult = JSONArray.parseArray(json, Map.class);
        List<RpTableCol> reportCol = rpBaseService.getReportCol(params);
        List<RpBgmc> rpBgmcs = rpBaseService.getReportDetail(params);
        String targetTable = null;//目标表名称
        List<String> pks = null;
        if (rpBgmcs != null && rpBgmcs.size() > 0)
            targetTable = rpBgmcs.get(0).getTBBMC();
        if (StringUtils.isNotBlank(targetTable))
            pks = rpBaseService.getTargetTablePks(targetTable);
        // logger.info(json);
        builderSaveSql(targetTable, reportCol, rsult, pks);
    }

    /**
     * 远程执行sql
     *
     * @param linkageMap
     * @throws Exception
     */
    public List<Map<String, Object>> remoteSql(Map<String, Object> linkageMap) throws Exception {
        List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
        if (linkageMap.get("remoteSql") != null && StringUtils.isNotBlank(linkageMap.get("remoteSql").toString())) {
            String sql = linkageMap.get("remoteSql").toString();
            Map<String, Object> likeMaps_ = new HashMap<String, Object>();
            String formatSql_ = SqlParserUtils.formatSql_MacthAll(sql, linkageMap, likeMaps_);
            Map<String, Object> resultMap_ = new HashMap<String, Object>();
            SqlParserUtils.formatSql4Query(formatSql_, linkageMap, resultMap_, likeMaps_);
            String resultSql_ = resultMap_.get("SQL").toString();
            List<String> pamsList_ = (List<String>) resultMap_.get("PARAMS");
            maps.addAll(dao.getJdbcTemplate().queryForList(resultSql_, pamsList_.toArray()));
        }
        return maps;
    }


    /**
     * 构建保存语句 包括插入语句和更新语句
     *
     * @return
     * @throws Exception
     */
    private String builderSaveSql(String targetTableName, List<RpTableCol> reportCol, List<Map> jsonPageResult, List<String> pks) throws Exception {
        //step1
        StringBuilder sb = new StringBuilder("insert into " + targetTableName);
        StringBuilder sb2 = new StringBuilder(" update " + targetTableName + "  set  ");
        List<String> colLists = new ArrayList<String>();//出入的数据源集合
        List<String> definedpks = new ArrayList<String>();//自定义的主键
        for (RpTableCol col : reportCol) {
            if (StringUtils.isNotBlank(col.getBcsjyl()))
                colLists.add(col.getBcsjyl());
            if (StringUtils.isNotBlank(col.getBcsjyl()) && "1".equals(col.getIszj()))
                definedpks.add(col.getBcsjyl());
        }
        List<String> excessPks = new ArrayList<String>();//多余主键 用uuid定义
        if (pks == null || pks.size() == 0) {
            excessPks = (List<String>) CollectionUtils.subtract(pks, colLists);//集合相减
        }
        //definedpks.addAll(excessPks);//加上表的格外主键
        List<String> listAllCols = new ArrayList<String>();
        listAllCols.addAll(colLists);
        listAllCols.addAll(excessPks);
        //---------------------------insert语句拼接-----------------------------------------
        sb.append("(" + StringUtils.join(listAllCols, ",") + ")   values(  ");
        int i = 0;
        for (String cols : listAllCols) {
            i++;
            sb.append("  ?  ");
            if (listAllCols.size() > i)
                sb.append(" ,");
        }
        sb.append(" ) ");
        String insert = sb.toString();
        //---------------------------insert语句拼接-----------------------------------------

        //---------------------------update语句拼接-----------------------------------------
        int j = 0;
        for (String cols : colLists) {
            j++;
            sb2.append(cols + "=?");
            if (colLists.size() > j)
                sb2.append(",");
        }
        sb2.append(" where ");

        if (definedpks != null && definedpks.size() > 0) {//如果前台以及定义了主键的情况
            int k = 0;
            for (String pk : definedpks) {
                k++;
                sb2.append(pk + " = ? ");
                if (definedpks.size() > k)
                    sb2.append(" and  ");
            }
        }
        //其他情况step2处考虑
        //---------------------------update语句拼接-----------------------------------------
        //System.out.println(insert);
        //step2
        List<List<ColumnProperty>> insertlist = new ArrayList<List<ColumnProperty>>();//新增属性集合
        List<List<ColumnProperty>> updateList = new ArrayList<List<ColumnProperty>>();//更新属性集合
        int flg = 0;
        for (Map map : jsonPageResult) {
            Set<String> set = map.keySet();
            Set<String> cloneSet = filterSet(set);
            if (cloneSet.size() == 0) { //insert
                List<ColumnProperty> cps = new ArrayList<ColumnProperty>();
                for (int k = 0; k < colLists.size(); k++) {
                    ColumnProperty property = new ColumnProperty(map.get(colLists.get(k)), 1);
                    cps.add(property);
                }
                for (int k = 0; k < excessPks.size(); k++) {//未在前端页面定义的主键 默认以uuid生成
                    ColumnProperty property = new ColumnProperty(UUID.randomUUID(), 1);
                    cps.add(property);
                }
                insertlist.add(cps);
            } else {//update
                List<ColumnProperty> cps = new ArrayList<ColumnProperty>();
                for (String cols : colLists) {
                    ColumnProperty property = new ColumnProperty(map.get(cols), 1);
                    cps.add(property);
                }
                if (definedpks != null && definedpks.size() > 0) {
                    for (String pk : definedpks) {
                        ColumnProperty property = new ColumnProperty(map.get(pk + Constants.CLONE_FLG), 1);
                        cps.add(property);
                    }
                } else {
                    List<String> jjlist = (List<String>) CollectionUtils.intersection(pks, set);
                    if (flg == 0) {
                        if (jjlist.size() == 0) //交集
                            throw new BuilderTableException("该报表的入库表未设置主键，若设置了主键，请在数据源中查出相应的字段即可!");
                        else {
                            int k = 0;
                            for (String pk : jjlist) {
                                k++;
                                sb2.append(pk + "= ?");
                                if (jjlist.size() > k)
                                    sb2.append(" and ");
                            }
                        }
                    }

                    for (String pk : jjlist) {
                        ColumnProperty property = new ColumnProperty(map.get(pk + Constants.CLONE_FLG), 1);
                        cps.add(property);
                    }
                }
                updateList.add(cps);
                flg++;
            }
        }
        logger.info(insert);
        logger.info(sb2.toString());
        Integer exceptionFLg = 0;
        if (insertlist != null && insertlist.size() > 0) {
            dao.batchUpdate(insert, insertlist);
//            for (List<ColumnProperty> columnProperties : insertlist) {
//                try {
//                    dao.update(insert, columnProperties);
//                } catch (Exception e) {
//                    logger.error("后台异常：", e);
//                    Integer proSize = columnProperties.size();
//                    //异常后更新--------------------------------------------------------------
//                    if (excessPks.size() > 0) {
//                        for (int k = 0; k < excessPks.size(); k++) {//未在前端页面定义的主键 默认以uuid生成
//                            columnProperties.remove(proSize - 1 - k);
//                        }
//                    }
//                    if ((definedpks == null || definedpks.size() == 0) && flg == 0 && exceptionFLg == 0) {
//                        int k = 0;
//                        for (String pk : pks) {
//                            k++;
//                            sb2.append(pk + "= ?");
//                            if (pks.size() > k)
//                                sb2.append(" and ");
//                        }
//                        exceptionFLg++;
//                    }
//                    if (definedpks == null || definedpks.size() == 0) {
//                        for (String pk : pks) {
//                            for (int l = 0; l < colLists.size(); l++) {
//                                if (colLists.get(l).equals(pk)) {
//                                    ColumnProperty property = new ColumnProperty(columnProperties.get(l).getValue(), 1);
//                                    columnProperties.add(property);
//                                    break;
//                                }
//                            }
//                        }
//                    } else {
//                        for (String pk : definedpks) {
//                            for (int l = 0; l < colLists.size(); l++) {
//                                if (colLists.get(l).equals(pk)) {
//                                    ColumnProperty property = new ColumnProperty(columnProperties.get(l).getValue(), 1);
//                                    columnProperties.add(property);
//                                    break;
//                                }
//                            }
//                        }
//                    }
//                    dao.update(sb2.toString(), columnProperties);
//                    //异常后更新--------------------------------------------------------------
//                }
//            }
        }

        if (updateList != null && updateList.size() > 0) {

            dao.batchUpdate(sb2.toString(), updateList);
//            for (List<ColumnProperty> columnProperties : updateList) {
//                int updateflg = 0;
//                try {
//                    updateflg = dao.update(sb2.toString(), columnProperties);
//                    // System.out.println(update + "///////////////");
//                } catch (Exception e) {
//                    logger.error("后台异常：", e);
//                }
//                //---------------------------更新异常后插入--------------------------
//                if (updateflg == 0) {//标识更新失败 那么进行插入操作
//
//                    List<ColumnProperty> tmpColumns = new ArrayList<ColumnProperty>();
//                    for (int k = 0; k < colLists.size(); k++) {
//                        tmpColumns.add(columnProperties.get(k));
//                    }
//
//                    for (int k = 0; k < excessPks.size(); k++) {//未在前端页面定义的主键 默认以uuid生成
//                        ColumnProperty property = new ColumnProperty(UUID.randomUUID(), 1);
//                        tmpColumns.add(property);
//                    }
//                    dao.update(insert, tmpColumns);
//                }
//                //---------------------------更新异常后插入--------------------------
//            }
        }

        return null;
    }


    /**
     * 过滤集合 包含字符串CLONE_FLG
     *
     * @return
     */
    private Set<String> filterSet(Set<String> targetSet) {

        Set<String> filterCollection = Sets.filter(targetSet,
                new Predicate<String>() {
                    public boolean apply(String s) {
                        return s.indexOf(Constants.CLONE_FLG) != -1;
                    }
                });
        return filterCollection;
    }


    /**
     * 过滤集合2 不包含字符串CLONE_FLG
     *
     * @param targetSet
     * @return
     */
    private Set<String> filterSet2(Set<String> targetSet) {
        Set<String> filterCollection = Sets.filter(targetSet,
                new Predicate<String>() {
                    public boolean apply(String s) {
                        return s.indexOf(Constants.CLONE_FLG) == -1;
                    }
                });
        return filterCollection;
    }


    /**
     * 删除对象
     *
     * @param params
     * @throws Exception
     */
    @Transactional
    public void deleteObj(Map<String, Object> params) throws Exception {
        if (params.get("deleteParams") != null && params.get("rpid") != null) {
            List<RpTableCol> reportCol = rpBaseService.getReportCol(params);
            List<RpBgmc> rpBgmcs = rpBaseService.getReportDetail(params);
            String targetTable = null;//目标表名称
            List<String> pks = null;
            if (rpBgmcs != null && rpBgmcs.size() > 0)
                targetTable = rpBgmcs.get(0).getTBBMC();
            if (StringUtils.isNotBlank(targetTable))
                pks = rpBaseService.getTargetTablePks(targetTable);

            if (StringUtils.isNotBlank(targetTable)) {
                StringBuilder sb2 = new StringBuilder(" delete from  " + targetTable + "   where   ");
                List<String> definedpks = new ArrayList<String>();//自定义的主键
                for (RpTableCol col : reportCol) {
                    if (StringUtils.isNotBlank(col.getBcsjyl()) && "1".equals(col.getIszj()))
                        definedpks.add(col.getBcsjyl());
                }
                if (definedpks != null && definedpks.size() > 0) {//如果前台以及定义了主键的情况
                    int k = 0;
                    for (String pk : definedpks) {
                        k++;
                        sb2.append(pk + " = ? ");
                        if (definedpks.size() > k)
                            sb2.append(" and ");
                    }
                }

                Map map = JSONArray.parseObject(params.get("deleteParams").toString(), Map.class);
                Set<String> set = map.keySet();
                List<List<ColumnProperty>> delList = new ArrayList<List<ColumnProperty>>();//删除属性集合
                List<ColumnProperty> cps = new ArrayList<ColumnProperty>();
                if (definedpks != null && definedpks.size() > 0) {
                    for (String pk : definedpks) {
                        ColumnProperty property = new ColumnProperty(map.get(pk + Constants.CLONE_FLG), 1);
                        cps.add(property);
                    }
                } else {
                    List<String> jjlist = (List<String>) CollectionUtils.intersection(pks, set);
                    if (jjlist.size() == 0) //交集
                        throw new BuilderTableException("该报表的入库表未设置主键，若设置了主键，请在数据源中查出相应的字段即可!");
                    else {
                        int k = 0;
                        for (String pk : jjlist) {
                            k++;
                            sb2.append(pk + " = ? ");
                            if (jjlist.size() > k)
                                sb2.append(" and ");
                        }
                    }
                    for (String pk : jjlist) {
                        ColumnProperty property = new ColumnProperty(map.get(pk + Constants.CLONE_FLG), 1);
                        cps.add(property);
                    }
                }
                delList.add(cps);
                dao.batchUpdate(sb2.toString(), delList);
                //  dao.update(sb2.toString(), cps.toArray());
            }


        }
    }
    
    /**
     * 保存Form表单
     *
     * @throws Exception
     */
    @Transactional
    public void saveForm(Map<String, Object> params) throws Exception {
        String rpid = params.get("rpid").toString();
        //将提交的数据和克隆的数据合并在一起
        if(params.containsKey("cloneMap")){
        	Map<String ,Object> cloneMap = JSON.parseObject(params.get("cloneMap").toString(), Map.class);
        	for(Map.Entry<String ,Object> entry : cloneMap.entrySet()){
        		params.put(entry.getKey(), entry.getValue());
    		}
        }
        List<RpTableCol> reportCol = rpBaseService.getReportCol(params);
        List<RpBgmc> rpBgmcs = rpBaseService.getReportDetail(params);
        List<Map> rsult = new ArrayList<Map>();
        rsult.add((Map) params);
        String targetTable = null;//目标表名称
        List<String> pks = null;
        if (rpBgmcs != null && rpBgmcs.size() > 0)
            targetTable = rpBgmcs.get(0).getTBBMC();
        if (StringUtils.isNotBlank(targetTable))
            pks = rpBaseService.getTargetTablePks(targetTable);
        // logger.info(json);
        builderSaveSql(targetTable, reportCol, rsult, pks);
    }

    /**
     * 解析表达式
     *
     * @param params
     * @return
     * @throws Exception
     */
    public String parseScript(Map<String, Object> params) throws Exception {
        if (params.get("scriptStr") != null && params.get("params") != null) {
            String scriptStr = params.get("scriptStr").toString();
            String pams = params.get("params").toString();
            Map<String, Object> pMap = JSONObject.parseObject(pams, Map.class);
            String parsedScript = ScriptEngineUtils.parseScript(scriptStr, pMap);
            return ScriptEngineUtils.scriptEngine(parsedScript);
        }
        return "";
    }

}
