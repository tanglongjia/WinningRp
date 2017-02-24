package com.winningRp.dao;

import com.winningRp.dao.com.winningRp.dao.bean.ColumnProperty;
import org.springframework.dao.DataAccessException;

import java.util.List;
import java.util.Map;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/19.
 * TIME: 1:14.
 * WinningRp
 */
public interface IBaseDao<T> {

    /**
     * 执行更新SQL语句
     *
     * @param sql sql语句
     * @return 返回成功更新的记录数
     * @throws DataAccessException
     */
    int update(String sql) throws DataAccessException;

    /**
     *
     * @param sql sql语句
     * @param args 参数值
     * @return
     * @throws DataAccessException
     */
    int update(String sql, Object[] args) throws DataAccessException;

    /**
     *
     * @param sql sql语句
     * @param args 参数值
     * @param argTypes 参数类型
     * @return
     * @throws DataAccessException
     */
    int update(String sql, Object[] args, int[] argTypes) throws DataAccessException;




    /**
     * 执行查询SQL语句，返回String值
     *
     * @param sql
     * @return
     * @throws DataAccessException
     */
    String queryForString(String sql) throws DataAccessException;

    /**
     * 执行查询SQL语句，返回int值
     *
     * @param sql
     * @return
     * @throws DataAccessException
     */
    int queryForInt(String sql) throws DataAccessException;

    /**
     * 执行查询SQL语句，返回long值
     *
     * @param sql
     * @return
     * @throws DataAccessException
     */
    long queryForLong(String sql) throws DataAccessException;

    /**
     * 执行查询SQL语句
     *
     * @param sql
     * @param objectClass
     * @return 返回Class的对象
     * @throws DataAccessException
     */
    <T> Object queryForObject(String sql, Class<T> objectClass) throws DataAccessException;



    /**
     * 执行查询SQL语句
     *
     * @param sql
     * @param args
     * @param poClass
     * @return 返回结果列表
     * @throws DataAccessException
     */
    <T> List<T> queryForList(String sql, Object[] args, Class<T> poClass) throws DataAccessException;

    /**
     * 执行查询SQL语句
     *
     * @param sql
     * @return 返回结果列表
     * @throws DataAccessException
     */
    <T> List<T> queryForList(String sql, Object[] args, int[] argTypes, Class<T> poClass) throws DataAccessException;

    /**
     * 执行查询SQL语句
     *
     * @param sql
     * @return 返回结果列表
     * @throws DataAccessException
     */
    <T> List<T> queryForList(String sql, Class<T> poClass) throws DataAccessException;

    /**
     * 执行查询SQL语句
     *
     * @param sql
     * @return Object
     * @throws DataAccessException
     */
    <T> T queryForObject(String sql, Object[] args, int[] argTypes, Class<T> poClass) throws DataAccessException;


    /**
     * 返回Map集合
     * @param sql
     * @param args
     * @return
     * @throws DataAccessException
     */
    List<Map<String,Object>> queryForList(String sql , Object[] args)throws DataAccessException;

    /**
     * 返回Map集合
     * @param sql
     * @return
     * @throws DataAccessException
     */
    List<Map<String,Object>> queryForList(String sql) throws DataAccessException;

    /**
     * 批量向表中增加或更新记录
     *
     * @param sql sql语句
     * @param list 等处理记录的列属性集合
     */
    int batchUpdate(String sql, List<List<ColumnProperty>> list) throws DataAccessException;

}
