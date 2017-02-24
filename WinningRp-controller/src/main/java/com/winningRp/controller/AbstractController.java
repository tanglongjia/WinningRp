package com.winningRp.controller;

import com.winningRp.common.bean.JsonResult;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/19.
 * TIME: 2:56.
 * WinningRp
 */
public abstract class AbstractController {

    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    protected void logException(Exception ex) {
        this.logException("系统异常", ex);
    }

    protected void logException(String msg, Exception ex) {
        logger.error(msg, ex);
    }

    protected void setSuccessResult(JsonResult result, String msg) {
        result.setSuccess(true);
        result.setMsg(StringUtils.isBlank(msg) ? "操作成功！" : msg);
    }

    protected void setFailureResult(JsonResult result, String msg) {
        result.setSuccess(false);
        result.setMsg(StringUtils.isBlank(msg) ? "操作失败！" : msg);
    }

    protected void setExceptionResult(JsonResult result, Exception ex) {
        result.setSuccess(false);
        result.setMsg(String.format("系统异常, 原因:%s", ex.getMessage()));
        this.logException(ex);
    }


}
