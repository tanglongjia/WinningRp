package com.winningRp.service;

import com.winningRp.common.bean.RpBgmc;
import com.winningRp.common.bean.RpDataSource;
import com.winningRp.common.bean.RpTableCol;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/24.
 * TIME: 1:16.
 * WinningRp
 */
@Service
public class RpBaseService extends BaseService {

    /**
     * 获取报表行
     *
     * @throws Exception
     */
    public List<RpTableCol> getReportCol(Map<String, Object> params) throws Exception {
        String rpid = params.get("rpid").toString();
        List<RpTableCol> list = dao.queryForList(" select ID , BGDM , BTMC as btmc, BQSJYL as bqsjyl, BCSJYL as bcsjyl, KJMC as kjmc, KJLX as kjlx, KJZT as kjzt, KJZ as kjz, MRZ as mrz, KJLXGS as kjlxgs, SY as sy, BT as bt, YXBJ as yxbj, JYLX as jylx," +
                "    JYDM as jydm, TSXX as tsxx, XSWZ as xswz, LJDZ as ljdz, ZXFS as zxfs, KZFX as kzfx, HZLX as hzlx, SJYDM as sjydm, SX as sx,ISZJ as iszj " +
                "    from DIM_BBSZ_XSJG where BGDM = ? order by  SX  ", new String[]{rpid}, RpTableCol.class);
        return list;
    }


    /**
     * 获取查询条件
     *
     * @param params
     * @throws Exception
     */
    public List<Map<String, Object>> getReportWhereEx(Map<String, Object> params) throws Exception {
        String rpid = params.get("rpid").toString();
        List<Map<String, Object>> list =
                dao.queryForList("select * from DIM_BBSZ_CXTJ where 1=1 and bgdm = ?  ORDER BY KJSX ", new String[]{rpid});
        return list;
    }

    /**
     * 获取联动控件
     *
     * @param params
     * @throws Exception
     */
    public List getQueryConditionLinkage(Map<String, Object> params) throws Exception {
        List<Map<String, Object>> list =
                dao.queryForList("select KJMC, KJZ, KJLX from DIM_BBSZ_CXTJ " +
                        " where KJLX='3' and BGDM ='" + params.get("rpid") + "' and  charindex('{" + params.get("id") + "}', KJZ)>0   ");
        return list;
    }

    /**
     * 获取联动其他控件值
     *
     * @param params
     * @throws Exception
     */
    public List getLinkageControlValue(Map<String, Object> params) throws Exception {
        List<Map<String, Object>> list =
                dao.queryForList((String) params.get("kjz"));
        return list;
    }

    /**
     * 测试1
     *
     * @throws Exception
     */
    public List getStudent(String rpid) throws Exception {
        List<Map<String, Object>> list =
                dao.queryForList("select * from student   ");
        return list;
    }

    /**
     * 测试2
     *
     * @throws Exception
     */
    public List getResultColumnEx(String rpid) throws Exception {
        List<Map<String, Object>> list =
                dao.queryForList("select BQSJYL, BTMC, KJZT from DIM_BBSZ_XSJG where 1=1 and bgdm ='" + rpid + "'  ");
        return list;
    }

    /**
     * 获取报表数据源
     *
     * @param params
     * @throws Exception
     */
    public List<RpDataSource> getReportDataSource(Map<String, Object> params) throws Exception {
        String rpid = params.get("rpid").toString();
        List<RpDataSource> list = dao.queryForList(" select SJYDM, BGDM, SJYMC, SQLYJ " +
                "   from DIM_BGSZ_BGSJY where BGDM = ?", new String[]{rpid}, RpDataSource.class);
        return list;
    }

    /**
     * 获取工具栏
     *
     * @param params
     * @throws Exception
     */
    public List getReportToolBars(Map<String, Object> params) throws Exception {
        String rpid = params.get("rpid").toString();
        List<Map<String, Object>> list = dao.queryForList("select * from DIM_BGSZ_BGGJL where 1=1 and bgdm =  ? ", new String[]{rpid});
        return list;
    }

    /**
     * 获取报表明细
     *
     * @param params
     * @throws Exception
     */
    public List<RpBgmc> getReportDetail(Map<String, Object> params) throws Exception {
        String rpid = params.get("rpid").toString();
        List<RpBgmc> list = dao.queryForList("select * from DIM_BBSZ_BGMC where BGDM = ? and JLZT = '0' ", new String[]{rpid}, RpBgmc.class);
        return list;
    }

    /**
     * 获取目标表的主键
     *
     * @return
     * @throws Exception
     */
    public List<String> getTargetTablePks(String targetTable) throws Exception {
        List<String> list = dao.getJdbcTemplate().queryForList("SELECT COLUMN_NAME as pkCol FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE  " +
                "WHERE TABLE_NAME= ? ", String.class, new String[]{targetTable});
        return list;
    }
    
    /**
     * 获取目标表的主键
     *
     * @throws Exception
     */
    public List getTablePk(Map<String, Object> params) throws Exception {
        String rpid = params.get("rpid").toString();
        List list = dao.queryForList(" if exists(select 1 from DIM_BBSZ_XSJG  where BGDM=? and ISZJ=1) select BCSJYL as pk from DIM_BBSZ_XSJG  where BGDM=? and ISZJ=1 else SELECT COLUMN_NAME as pk FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME=?  ", new String[]{rpid, rpid, rpid});
        return list;
    }
    
    /**
     * 获取表格列
     *
     * @throws Exception
     */
    public List getTableColumn(Map<String, Object> params) throws Exception {
        String rpid = params.get("rpid").toString();
        List list = dao.queryForList(" select BTMC as TJMC, BCSJYL AS KJMC, KJLX, KJZT, KJZ, MRZ, KJLXGS, SY   , BT, YXBJ, JYLX, JYDM, TSXX, SX from DIM_BBSZ_XSJG  where BGDM=? order by SX ", new String[]{rpid});
        return list;
    }

}
