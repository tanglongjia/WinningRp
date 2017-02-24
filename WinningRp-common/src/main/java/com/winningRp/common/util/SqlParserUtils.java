package com.winningRp.common.util;

import com.winningRp.common.Constants;
import com.winningRp.common.exception.BuilderTableException;
import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/21.
 * TIME: 5:15.
 * WinningRp sql解析器
 */
public class SqlParserUtils {
    //匹配{xxx}
    public static final String PATTERN = "\\{+([^\\{]*[^\\}])\\}+";

    /**
     * 匹配=和like
     */
    public static final String SQLPATTERN = "[ ]+[^ ]+[ ]{0,}[=][ ]{0,}[^ )]+|[ ]+[^ ]+[ ]+[Ll][iI][Kk][Ee][ ]{0,}[^ )]+";

    public static final String APPEND_FLG = " 1=1 ";

    public static final String SELECT_PATTERN = "[Ss][Ee][Ll][Ee][Cc][Tt]";

//    /**
//     * sql解析器  使用velocity解析模板
//     *
//     * @param sql
//     * @param paramters
//     * @return
//     * @throws Exception
//     */
//    public static String parseSql(String sql, Map<String, Object> paramters) throws Exception {
//        StringWriter writer = new StringWriter();
//        Velocity.init();
//        VelocityContext context = new VelocityContext();
//        for (Map.Entry<String, Object> kvset : paramters.entrySet()) {
//            context.put(kvset.getKey(), kvset.getValue());
//        }
//        Velocity.evaluate(context, writer, "rp", sql);
//        return writer.toString();
//    }

    /**
     * 格式化sql  select 等用 强匹配
     *
     * @param sql
     * @return
     * @throws Exception
     */
    public static String formatSql_MacthAll(String sql, Map<String, Object> sqlparams, Map<String, Object> likeMap) throws Exception {
        sql = sql.replaceAll("\r|\n|\t", " ");//去除回车换行
        List<String> params = new ArrayList<String>();
        Pattern pattern = Pattern.compile(PATTERN);
        Pattern pattern2 = Pattern.compile(SQLPATTERN);
        Pattern pattern3 = Pattern.compile(SELECT_PATTERN);
        boolean result = false;
        Matcher mt = pattern3.matcher(sql);
        while (mt.find()) {
            result = true;
        }
        if (result) {//是普通的sql语句
            Matcher matcher2 = pattern2.matcher(sql);
            while (matcher2.find()) {
                String equalLikes = matcher2.group(0).trim();
                Matcher matcher1 = pattern.matcher(equalLikes);
                while (matcher1.find()) {
                    String bm = matcher1.group(1).trim();
                    if (sqlparams.get(bm) == null) {
                        throw new BuilderTableException("SQL:" + sql + "无法匹配到参数[" + bm + "]!");
                    } else {
                        if (equalLikes.indexOf("=") == -1)
                            likeMap.put(bm, 1);
                    }
                }
            }
        } else {
            throw new BuilderTableException("查询只支持sql语句!");
        }
        return sql;
    }

    /**
     * 格式化sql 查询栏用
     *
     * @param sql
     * @return
     * @throws Exception
     */
    public static String formatSql(String sql, Map<String, Object> sqlparams, Map<String, Object> likeMap) {
        sql = sql.replaceAll("\r|\n|\t", " ");//去除回车换行
        List<String> params = new ArrayList<String>();
        Pattern pattern = Pattern.compile(PATTERN);
        Pattern pattern2 = Pattern.compile(SQLPATTERN);
        Pattern pattern3 = Pattern.compile(SELECT_PATTERN);
        boolean result = false;
        Matcher mt = pattern3.matcher(sql);
        while (mt.find()) {
            result = true;
        }
        if (result) {//是普通的sql语句
            Matcher matcher2 = pattern2.matcher(sql);
            while (matcher2.find()) {
                String equalLikes = matcher2.group(0).trim();
                Matcher matcher1 = pattern.matcher(equalLikes);
                while (matcher1.find()) {
                    String bm = matcher1.group(1).trim();
                    if (sqlparams.get(bm) == null || StringUtils.isBlank(sqlparams.get(bm).toString())) {
                        int index = sql.indexOf(equalLikes);
                        String headStr = sql.substring(0, index).trim().toLowerCase();
                        if (headStr.endsWith("where") || headStr.endsWith("and"))
                            sql = sql.substring(0, index) + APPEND_FLG + sql.substring(index + equalLikes.length());
                    } else {
                        if (equalLikes.indexOf("=") == -1)
                            likeMap.put(bm, 1);
                    }
                }
            }
        } else {
            sqlparams.remove(Constants.WINNING_PAGING);//存储过程拒绝分页查询
        }
        return sql;
    }

    /**
     * 格式化sql 用户直接查询
     *
     * @param sql
     * @param sqlparams
     */

    public static void formatSql4Query(String sql, Map<String, Object> sqlparams, Map<String, Object> resultMap, Map<String, Object> likeMap) {
        List<String> pas = new ArrayList<String>();
        Pattern pattern = Pattern.compile(PATTERN);
        Matcher matcher1 = pattern.matcher(sql);
        while (matcher1.find()) {
            String bm = matcher1.group(1).trim();
            if (sqlparams.get(bm) == null)
                pas.add("");
            else {
                if (likeMap.get(bm) != null)
                    pas.add("%" + sqlparams.get(bm).toString() + "%");
                else
                    pas.add(sqlparams.get(bm).toString());
            }
            sql = sql.replaceAll("\\{" + bm + "\\}", "?");
        }
        resultMap.put("SQL", sql);
        resultMap.put("PARAMS", pas);
    }


    /**
     * 解析sql 固定前两个字段 为 code , name
     * 此sql 的固定样式 为 select  a , b , c  from (xxxxx)
     *
     * @param sql
     * @return
     * @throws Exception
     */
    public static String parseSqlKeyValue(String sql) throws Exception {
        StringBuilder fullSql = new StringBuilder("");
        Integer fromIndex = sql.indexOf("from");
        String firstSql = sql.substring(0, fromIndex);
        String nextSql = sql.substring(fromIndex);
        fullSql.append(firstSql.substring(0, firstSql.indexOf(",")));
        fullSql.append(" as code ,");
        if (firstSql.substring(firstSql.indexOf(",") + 1).indexOf(",") == -1)
            fullSql.append(firstSql.substring(firstSql.indexOf(",") + 1) + " as name ");
        else
            fullSql.append(firstSql.substring(firstSql.indexOf(",") + 1).replaceFirst(",", "as name,"));
        fullSql.append(nextSql);
        return fullSql.toString();
    }

}
