package com.winningRp.common.bean;

import java.util.List;

/**
 * 跳转页面的参数类
 * */
public class UrlParamBean {
	
	private String sourceName;
	
	private String sql;
	
	private List<String> paramsList;

	public String getSourceName() {
		return sourceName;
	}

	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public List<String> getParamsList() {
		return paramsList;
	}

	public void setParamsList(List<String> paramsList) {
		this.paramsList = paramsList;
	}
	
	
	

}
