package com.winningRp.common.util;

import org.apache.commons.lang.StringUtils;

/**
 * Created with 基础框架项目
 * USER: 项鸿铭
 * DATE: 2017/2/16.
 * TIME: 5:31.
 * WinningRp
 */
public class RegExp {


    /**
     * 转义正则特殊字符 （$()*+.[]?\^{},|）
     *
     * @param keyword
     * @return
     */
    public static String escapeExprSpecialWord(String keyword) {
        if (StringUtils.isNotBlank(keyword)) {
            String[] fbsArr = {"\\", "$", "(", ")", "*", "+", ".", "[", "]", "?", "^", "{", "}", "|"};
            for (String key : fbsArr) {
                if (keyword.contains(key)) {
                    keyword = keyword.replace(key, "\\" + key);
                }
            }
        }
        return keyword;
    }
}
