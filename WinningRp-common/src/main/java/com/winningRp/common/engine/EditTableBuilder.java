package com.winningRp.common.engine;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.winningRp.common.Constants;
import com.winningRp.common.bean.RpBaseBean;
import com.winningRp.common.bean.RpDataSource;
import com.winningRp.common.bean.RpTableCol;
import com.winningRp.common.exception.BuilderTableException;
import com.winningRp.common.util.SqlParserUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.*;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/24.
 * TIME: 9:40.
 * WinningRp 可编辑填报表格构造器
 */
public class EditTableBuilder<T extends RpBaseBean> extends BaseBuilder {


    public EditTableBuilder(JdbcTemplate jdbcTemplate) {
        super(jdbcTemplate);
    }

    public EditTableBuilder(JdbcTemplate jdbcTemplate, List<Map<String, Object>> pks) {
        super(jdbcTemplate, pks);
    }

    /**
     * 创建表格
     */
    public String builderTable() {
        StringBuilder sb = new StringBuilder();
        sb.append(" <script type=\"text/javascript\"> $('#reportTable').bootstrapTable({" +
                "                method: 'get'," +
                "                showExport: true,onClickRow:function(row, $element){ selecedRowIndex = $($element)[0].rowIndex; selectTr();$($element).css('background-color','#fcf194');}," +
                "                showFooter:true,editable: true," +
                "                columns: [ %s ]," +
                "                data:    %s  " +
                "   });    </script>");
        return sb.toString();
    }

    /**
     * 创建表格JSON数据
     *
     * @param reportCol
     * @param reportDataSource
     * @param params           外部参数包括查询参数和URL参数
     */
    public String builderDataJson(List<RpTableCol> reportCol, List<RpDataSource> reportDataSource, Map<String, Object> params) throws BuilderTableException {
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
        Map<String, Object> likeMaps = new HashMap<String, Object>();
        String formatSql = SqlParserUtils.formatSql(sqlyj, params, likeMaps);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        SqlParserUtils.formatSql4Query(formatSql, params, resultMap, likeMaps);
        String resultSql = resultMap.get("SQL").toString();
        List<String> pamsList = (List<String>) resultMap.get("PARAMS");
        List<Map<String, Object>> result = null;
        try {
            //  result = jdbcTemplate.queryForList(resultSql, pamsList.toArray());
            result = queryDatasByPaging(resultSql, pamsList, params);
        } catch (Exception e) {
            logger.error("执行数据源语句报错", e);
            //throw new BuilderTableException("执行数据源语句报错", e);
        }
        if (result != null && result.size() > 0) {
            Map<String, String> keyMatchMap = new HashMap<String, String>();
            for (RpTableCol col : reportCol) {
                if (StringUtils.isNotBlank(col.getBqsjyl()) && StringUtils.isNotBlank(col.getBcsjyl())) {
                    keyMatchMap.put(col.getBqsjyl(), col.getBcsjyl());
                }
            }
            for (Map<String, Object> mp : result) {
                for (String key : keyMatchMap.keySet()) {
                    if (mp.get(key) != null) {
                        Object thv = mp.get(key);
                        mp.remove(key);
                        if (StringUtils.isNotBlank(keyMatchMap.get(key)))
                            mp.put(keyMatchMap.get(key), thv);
                        else
                            mp.put(thv.toString(), thv);
                    }
                }
                Map<String, Object> linkageMap = new HashMap<String, Object>();
                linkageMap.putAll(params);
                Map<String, Object> mptmp = new HashMap<String, Object>();
                for (String key : mp.keySet()) {
                    mptmp.put(key + Constants.CLONE_FLG, mp.get(key));
                }
                for (RpTableCol col : reportCol) {//行数据联动控件名称联动
                    Object defaultVV = mp.get(col.getBqsjyl()) == null ? "" : mp.get(col.getBqsjyl());
                    if (StringUtils.isNotBlank(col.getKjmc()))
                        linkageMap.put(col.getKjmc(), mp.get(col.getBcsjyl()) == null ? defaultVV : mp.get(col.getBcsjyl()));
                }
                for (RpTableCol col : reportCol) {
                    if (StringUtils.isNotBlank(col.getKjlx()) && Constants.SELECT.equals(col.getKjlx()) && StringUtils.isNotBlank(col.getKjz())) {
                        try {
                            Map<String, Object> likeMaps_ = new HashMap<String, Object>();
                            String formatSql_ = SqlParserUtils.formatSql_MacthAll(col.getKjz(), linkageMap, likeMaps_);
                            Map<String, Object> resultMap_ = new HashMap<String, Object>();
                            SqlParserUtils.formatSql4Query(formatSql_, linkageMap, resultMap_, likeMaps_);
                            String resultSql_ = resultMap_.get("SQL").toString();
                            List<String> pamsList_ = (List<String>) resultMap_.get("PARAMS");
                            List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
                            maps.addAll(jdbcTemplate.queryForList(resultSql_, pamsList_.toArray()));
                            // List<Map<String, Object>> maps = jdbcTemplate.queryForList(resultSql_, pamsList_.toArray());
                            mp.put(col.getKjmc() + Constants.WINNING_SELECT_JSON, maps);
                        } catch (Exception e) {
                            logger.error("后台异常：", e);
                            List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
                            mp.put(col.getKjmc() + Constants.WINNING_SELECT_JSON, maps);
                        }
                    }
                }
                mp.put(Constants.WINNING_SELECT_JSON_PARAMS, linkageMap);
                mp.putAll(mptmp);//克隆值新增修改用
            }
            // params.put("WINING_HZH", builderCollectCol(reportCol, result));
            // result.add(builderCollectCol(reportCol, result));
            String toJSONString = JSONArray.toJSONString(result, SerializerFeature.WriteDateUseDateFormat);
            // JSONArray.toJSONString()
//            for (RpTableCol col : reportCol) {
//                if (StringUtils.isNotBlank(col.getBqsjyl()) && StringUtils.isNotBlank(col.getBcsjyl())) {
//                    toJSONString = toJSONString.replaceAll("\"" + col.getBqsjyl() + "\"", "\"" + col.getBcsjyl() + "\"");
//                    toJSONString = toJSONString.replaceAll("\"" + col.getBqsjyl() + Constants.CLONE_FLG + "\"", "\"" + col.getBcsjyl() + Constants.CLONE_FLG + "\"");
//                }
//            }
            //设置默认JSON
            setDefaultJson(reportCol, params);
            logger.info("返回的数据集JSON:" + toJSONString);
            return toJSONString;
        }
        //设置默认JSON
        setDefaultJson(reportCol, params);
        return "[]";
    }

    /**
     * 导入数据的json处理
     *
     * @param reportCol
     * @param params
     * @return
     */
    public String importDataJson(List<RpTableCol> reportCol, Map<String, Object> params, Collection<Map> result) {
        if (result != null && result.size() > 0) {
            for (Map<String, Object> mp : result) {
                Map<String, Object> linkageMap = new HashMap<String, Object>();
                linkageMap.putAll(params);
                for (RpTableCol col : reportCol) {//行数据联动控件名称联动
                    if (StringUtils.isNotBlank(col.getKjmc()))
                        linkageMap.put(col.getKjmc(), mp.get(col.getBcsjyl()) == null ? "" : mp.get(col.getBcsjyl()));
                }
                for (RpTableCol col : reportCol) {
                    if (StringUtils.isNotBlank(col.getKjlx()) && Constants.SELECT.equals(col.getKjlx()) && StringUtils.isNotBlank(col.getKjz())) {
                        try {
                            Map<String, Object> likeMaps_ = new HashMap<String, Object>();
                            String formatSql_ = SqlParserUtils.formatSql_MacthAll(col.getKjz(), linkageMap, likeMaps_);
                            Map<String, Object> resultMap_ = new HashMap<String, Object>();
                            SqlParserUtils.formatSql4Query(formatSql_, linkageMap, resultMap_, likeMaps_);
                            String resultSql_ = resultMap_.get("SQL").toString();
                            List<String> pamsList_ = (List<String>) resultMap_.get("PARAMS");
                            List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
                            maps.addAll(jdbcTemplate.queryForList(resultSql_, pamsList_.toArray()));
                            // List<Map<String, Object>> maps = jdbcTemplate.queryForList(resultSql_, pamsList_.toArray());
                            mp.put(col.getKjmc() + Constants.WINNING_SELECT_JSON, maps);
                        } catch (Exception e) {
                            logger.error("后台异常：", e);
                            List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
                            mp.put(col.getKjmc() + Constants.WINNING_SELECT_JSON, maps);
                        }
                    }
                    if ("1".equals(col.getKjzt()) && StringUtils.isNotBlank(col.getBcsjyl()) && StringUtils.isNotBlank(col.getMrz()))
                        mp.put(col.getBcsjyl(), col.getMrz());
                    //if(StringUtils.isNotBlank())
                }
                mp.put(Constants.WINNING_SELECT_JSON_PARAMS, linkageMap);
            }
            String toJSONString = JSONArray.toJSONString(result);
            //设置默认JSON
            logger.info("导入数据返回的数据集JSON:" + toJSONString);
            return toJSONString;
        } else {
            String toJSONString = JSONArray.toJSONString(result);
            return toJSONString;
        }
    }


    /**
     * 设置默认json 数据
     *
     * @param reportCol
     * @param params
     */
    private void setDefaultJson(List<RpTableCol> reportCol, Map<String, Object> params) {
        Map<String, Object> defaultMap = new HashMap<String, Object>();
        Map<String, Object> linkageMap = new HashMap<String, Object>();
        linkageMap.putAll(params);

        for (RpTableCol col : reportCol) {//行数据联动控件名称联动
            if (StringUtils.isNotBlank(col.getKjmc()))
                linkageMap.put(col.getKjmc(), StringUtils.isBlank(col.getMrz()) ? "" : col.getMrz().trim());

            if (StringUtils.isNotBlank(col.getBcsjyl()))
                defaultMap.put(col.getBcsjyl(), StringUtils.isBlank(col.getMrz()) ? "" : col.getMrz().trim());

        }
        for (RpTableCol col : reportCol) {
            if (StringUtils.isNotBlank(col.getKjlx()) && Constants.SELECT.equals(col.getKjlx()) && StringUtils.isNotBlank(col.getKjz())) {
                try {
                    Map<String, Object> likeMaps_ = new HashMap<String, Object>();
                    String formatSql_ = SqlParserUtils.formatSql_MacthAll(col.getKjz(), linkageMap, likeMaps_);
                    Map<String, Object> resultMap_ = new HashMap<String, Object>();
                    SqlParserUtils.formatSql4Query(formatSql_, linkageMap, resultMap_, likeMaps_);
                    String resultSql_ = resultMap_.get("SQL").toString();
                    List<String> pamsList_ = (List<String>) resultMap_.get("PARAMS");
                    List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
                    maps.addAll(jdbcTemplate.queryForList(resultSql_, pamsList_.toArray()));
                    defaultMap.put(col.getKjmc() + Constants.WINNING_SELECT_JSON, maps);
                } catch (Exception e) {
                    logger.error("后台异常：", e);
                    List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
                    defaultMap.put(col.getKjmc() + Constants.WINNING_SELECT_JSON, maps);
                }
            }
        }
        defaultMap.put(Constants.WINNING_SELECT_JSON_PARAMS, linkageMap);
        defaultMap.put("WINNING_NEW_ADD", "1");//表示是新增
        params.put(Constants.WINNING_DEFAULT_JSON, defaultMap);
    }


//    /**
//     * 构造汇总列
//     *
//     * @param reportCol
//     * @param result
//     * @return
//     */
//    public Map<String, Object> builderCollectCol(List<RpTableCol> reportCol, List<Map<String, Object>> result) {
//        Map<String, Object> cmap = new HashMap<String, Object>();
//        String hzlm = "";//汇总列名
//        boolean resuls = false;
//        for (RpTableCol col : reportCol) {
//            if (!"1".equals(col.getKjzt()) && StringUtils.isBlank(hzlm)) {
//                hzlm = col.getBqsjyl();
//            }
//            if (!"1".equals(col.getKjzt()) && StringUtils.isNotBlank(col.getHzlx()) && "12".indexOf(col.getHzlx()) != -1) {
//                cmap.put(col.getBqsjyl(), col.getHzlx());
//                resuls = true;
//            }
//        }
//
//        if (!resuls) {
//            return null;
//        } else {
//            JXPathContext context = JXPathContext.newContext(result);
//            context.setLenient(true);
//            for (String key : cmap.keySet()) {
//                if ("1".equals(cmap.get(key))) {//合计
//                    cmap.put(key, context.getValue("sum(./" + key + " )"));
//                } else if ("2".equals(cmap.get(key))) {//平均
//                    try {
//                        cmap.put(key, AviatorEvaluator.execute(context.getValue("sum(./" + key + " )") + "/" + result.size()));
//                    } catch (Exception e) {
//                        logger.error("后台错误", e);
//                    }
//                }
//            }
//            cmap.put(hzlm, "汇总");
//            cmap.put("WINNING_HZ_COL", "1");
//            return cmap;
//        }
//    }


    /**
     * 创建表格JSON数据
     *
     * @param reportCol
     * @param reportDataSource
     */
    public String builderDataJson(List<RpTableCol> reportCol, List<RpDataSource> reportDataSource) throws BuilderTableException {
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
        List<Map<String, Object>> result = null;
        try {
            result = jdbcTemplate.queryForList(sqlyj);
        } catch (Exception e) {
            throw new BuilderTableException("执行数据源语句报错", e);
        }
        if (result != null && result.size() > 0) {
            for (Map<String, Object> mp : result) {
                Map<String, Object> mptmp = new HashMap<String, Object>();
                for (String key : mp.keySet()) {
                    mptmp.put(key + Constants.CLONE_FLG, mp.get(key));
                }
                mp.putAll(mptmp);
            }
            String toJSONString = JSONArray.toJSONString(result);
            for (RpTableCol col : reportCol) {
                if (StringUtils.isNotBlank(col.getBqsjyl()) && StringUtils.isNotBlank(col.getBcsjyl()))
                    toJSONString = toJSONString.replaceAll("\"" + col.getBqsjyl() + "\"", "\"" + col.getBcsjyl() + "\"");
            }
            logger.info("返回的数据集JSON:" + toJSONString);
            return toJSONString;
        }
        return null;
    }

    /**
     * 分页查询
     *
     * @param resultSql
     * @param pamsList  sql参数
     * @param params    页面参数
     * @return
     */
    private List<Map<String, Object>> queryDatasByPaging(String resultSql, List<String> pamsList, Map<String, Object> params) {
        List<Map<String, Object>> result = null;
        if (params.get(Constants.WINNING_PAGING) == null) //不用分页
            result = jdbcTemplate.queryForList(resultSql, pamsList.toArray());
        else {//需要分页
            Integer totalCount = jdbcTemplate.queryForObject(getQueryByCountSql(resultSql), pamsList.toArray(), Integer.class);
            params.put(Constants.WINNING_TOTAL_COUNTS, totalCount.toString());
            params.put(Constants.WINNING_PAGE_SIZE_FLG, Constants.WINNING_PAGE_SIZE);
            Integer pageNumber = params.get(Constants.WINNING_PAGE_NUMBER) == null ? 1 : Integer.parseInt(params.get(Constants.WINNING_PAGE_NUMBER).toString());
            Integer first = (pageNumber - 1) * Constants.WINNING_PAGE_SIZE;
            if (first < 0 || totalCount - first < 0) {
                first = 0;
            }
            Integer end = first + Constants.WINNING_PAGE_SIZE;
            result = jdbcTemplate.queryForList(getQueryByPageSql(resultSql, first, end), pamsList.toArray());
        }
        return result;
    }


    private String getQueryByCountSql(String sql) {
        StringBuffer countSql = new StringBuffer(sql.length());
        countSql.append(" SELECT COUNT(*) FROM (").append(sql).append(") Z");
        String sqlCmd = countSql.toString();
        return sqlCmd;
    }


    private String getQueryByPageSql(String sql, Integer startNum, Integer endNum) {
        sql = sql.replaceFirst("[Ss][Ee][Ll][Ee][Cc][Tt]", "select 1 as WINNING_SQL_ID, ");
        StringBuffer countSql = new StringBuffer(sql.length());
        countSql.append("select * from (select top  " + endNum + " row_number() over(order by " +
                " TT.WINNING_SQL_ID ) as RN,* from( ").append(sql).append(" ) as TT )as H where RN >  " + startNum + " ");
        return countSql.toString();
    }

}
