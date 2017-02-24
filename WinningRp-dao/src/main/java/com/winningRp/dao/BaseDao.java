package com.winningRp.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;

import com.winningRp.common.util.PageVariable;
import com.winningRp.dao.com.winningRp.dao.bean.ColumnProperty;

/**
 * Created with 填报报表项目 USER: 项鸿铭 DATE: 2016/10/19. TIME: 1:15. WinningRp
 */
@Repository(value = "rpdao")
public class BaseDao<T> extends JdbcDaoSupport implements IBaseDao<T> {
    protected final Logger logger = Logger.getLogger(this.getClass());

    @Resource
    public void setJDBCTemplate(JdbcTemplate jdbcTemplate) {
        this.setJdbcTemplate(jdbcTemplate);
    }

    public int update(String sql) throws DataAccessException {
        return getJdbcTemplate().update(sql);
    }

    public int update(String sql, Object[] args) throws DataAccessException {
        return getJdbcTemplate().update(sql, args);
    }


    public int update(String sql, List<ColumnProperty> properties) throws DataAccessException {
        List<Object> objs = new ArrayList<Object>();
        for (ColumnProperty property : properties) {
            objs.add(property.getValue());
        }
        return getJdbcTemplate().update(sql, objs.toArray());
    }


    public int update(String sql, Object[] args, int[] argTypes)
            throws DataAccessException {
        return getJdbcTemplate().update(sql, args, argTypes);
    }

    public String queryForString(String sql) throws DataAccessException {
        return getJdbcTemplate().queryForObject(sql, String.class);
    }

    public int queryForInt(String sql) throws DataAccessException {
        return getJdbcTemplate().queryForObject(sql, Integer.class);
    }

    public long queryForLong(String sql) throws DataAccessException {
        return getJdbcTemplate().queryForObject(sql, Long.class);
    }

    public <T> Object queryForObject(String sql, Class<T> objectClass)
            throws DataAccessException {
        return getJdbcTemplate().queryForObject(sql,
                new BeanPropertyRowMapper<T>(objectClass));
    }

    public <T> List<T> queryForList(String sql, Object[] args, Class<T> poClass)
            throws DataAccessException {
        List<T> list = getJdbcTemplate().query(sql, args,
                new BeanPropertyRowMapper<T>(poClass));
        return list;
    }

    public <T> List<T> queryForList(String sql, Object[] args, int[] argTypes,
                                    Class<T> poClass) throws DataAccessException {
        List<T> list = getJdbcTemplate().query(sql, args, argTypes,
                new BeanPropertyRowMapper<T>(poClass));
        return list;
    }

    public <T> List<T> queryForList(String sql, Class<T> poClass)
            throws DataAccessException {
        List<T> list = getJdbcTemplate().query(sql,
                new BeanPropertyRowMapper<T>(poClass));
        return list;
    }

    public <T> T queryForObject(String sql, Object[] args, int[] argTypes,
                                Class<T> poClass) throws DataAccessException {
        return getJdbcTemplate().queryForObject(sql, args, argTypes,
                new BeanPropertyRowMapper<T>(poClass));
    }

    public List<Map<String, Object>> queryForList(String sql, Object[] args)
            throws DataAccessException {
        return getJdbcTemplate().queryForList(sql, args);
    }

    public List<Map<String, Object>> queryForList(String sql)
            throws DataAccessException {
        return getJdbcTemplate().queryForList(sql);
    }

    public int batchUpdate(final String sql,
                           final List<List<ColumnProperty>> list) throws DataAccessException {
        int[] rowsAffecteds = this.getJdbcTemplate().batchUpdate(sql,
                new BatchPreparedStatementSetter() {
                    public void setValues(final PreparedStatement pstat,
                                          final int i) throws SQLException {
                        List<ColumnProperty> columnProperties = list.get(i);
                        for (int index = 0; index < columnProperties.size(); index++) {
                            ColumnProperty columnProperty = columnProperties
                                    .get(index);
                            pstat.setObject(index + 1,
                                    columnProperty.getValue());
                        }
                    }

                    public int getBatchSize() {
                        return list.size();
                    }
                });

        int rowsAffected = 0;
        for (int element : rowsAffecteds) {
            rowsAffected += element;
        }
        return rowsAffected;
    }

    public void insertObj(final String sql, Map anMap) {
        getJdbcTemplate().update(sql, anMap);
    }

    public void insertObjectsByList(final String sql, List<Object[]> args) {
        getJdbcTemplate().batchUpdate(sql, args);
    }

    public void deleteObj(final String sql, Object args) {
        getJdbcTemplate().update(sql, args);
    }

    public List queryForListByPage(String sqlName, String countSqlName,
                                   Map<String, Object> paramsMap) throws Exception {
        PageVariable page = (PageVariable) paramsMap.get("page");
        if (page == null) {
            page = new PageVariable();
        }
        // 得到符合条件的记录总数
        int recordCount = (Integer) getJdbcTemplate().queryForObject(countSqlName, Integer.class);
        int first = (page.getCurrentPage() - 1) * page.getRecordPerPage();
        if (first < 0 || recordCount - first < 0) {
            first = 0;
        }
        paramsMap.put("startNum", first);
        paramsMap.put("endNum", first + page.getRecordPerPage());
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
        return this.getJdbcTemplate().queryForList(sqlName, paramsMap);
    }

    public <T> Map queryForObject(String sql) {
        return getJdbcTemplate().queryForMap(sql);
    }

    public <T> List queryForList(String sql, Object args) {
        return getJdbcTemplate().queryForList(sql, args);
    }

}
