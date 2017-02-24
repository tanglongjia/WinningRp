package com.winningRp.common.bean;

import java.io.Serializable;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/25.
 * TIME: 10:09.
 * WinningRp
 */
public class RpBaseBean implements Serializable {

    private String tableName;

    /**
     * 需要保存的表名
     */
    private String tableName_into;


    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getTableName_into() {
        return tableName_into;
    }

    public void setTableName_into(String tableName_into) {
        this.tableName_into = tableName_into;
    }
}
