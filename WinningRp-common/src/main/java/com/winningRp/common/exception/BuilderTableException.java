package com.winningRp.common.exception;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/26.
 * TIME: 0:50.
 * WinningRp
 */
public class BuilderTableException extends RuntimeException {


    public BuilderTableException() {
        super();
    }

    public BuilderTableException(String message) {
        super(message);
    }

    public BuilderTableException(String message, Throwable cause) {
        super(message, cause);
    }

    public BuilderTableException(Throwable cause) {
        super("报表构建错误，请联系管理员!", cause);
    }

}
