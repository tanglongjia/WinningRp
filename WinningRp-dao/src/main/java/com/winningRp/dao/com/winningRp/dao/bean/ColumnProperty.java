package com.winningRp.dao.com.winningRp.dao.bean;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/19.
 * TIME: 2:28.
 * WinningRp
 */
public class ColumnProperty {
    public Object value;
    public int sqlType;

    public ColumnProperty(Object value, int sqlType) {
        this.value = value;
        this.sqlType = sqlType;
    }

    public Object getValue() {
        return value;
    }

    public int getSqlType() {
        return sqlType;
    }
}
