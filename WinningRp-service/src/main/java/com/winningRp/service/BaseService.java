package com.winningRp.service;

import com.winningRp.dao.BaseDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/24.
 * TIME: 1:04.
 * WinningRp
 */
public abstract class BaseService {

    /**
     * 日志控制
     */
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    @Qualifier(value = "rpdao")
    public BaseDao dao;


}
