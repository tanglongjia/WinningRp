package com.winningRp.common.bean;

import java.io.Serializable;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/11/4.
 * TIME: 2:41.
 * WinningRp
 */
public class JsonResult implements Serializable {

    private boolean isSuccess;
    private String msg;

    public JsonResult(boolean isSuccess, String msg) {
        this.isSuccess = isSuccess;
        this.msg = msg;
    }

    public boolean isSuccess() {
        return this.isSuccess;
    }

    public void setSuccess(boolean isSuccess) {
        this.isSuccess = isSuccess;
    }

    public String getMsg() {
        return this.msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

}
