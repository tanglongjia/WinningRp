package com.winningRp.common.util;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.Map.Entry;

public class MapUtil {
    public static Map<String, Object> doParameterMap(boolean isChangeArrayCast, HttpServletRequest request) {
        Map parameter = request.getParameterMap();
        Map<String, Object> param = new HashMap<String, Object>();
        if (parameter != null) {
            Set<Entry<String, String[]>> set = parameter.entrySet();
            for (Entry<String, String[]> e : set) {
                String[] obj = e.getValue();
                if (obj instanceof String[]) {
                    String[] str = (String[]) obj;
                    for (int i = 0; i < str.length; i++) {
                        str[i] = str[i].trim();
                        str[i] = str[i].replaceAll("\r\n", "");
                        str[i] = str[i].replaceAll("", "");
                        str[i] = str[i].replaceAll("", "");
                        str[i] = str[i].replaceAll("	", "");
                        str[i] = str[i].replaceAll("	", "");
                        str[i] = str[i].replaceAll("", "");
                    }
                }
                if (obj == null || (obj != null && obj.length <= 0))
                    continue;
                if (isChangeArrayCast) {
                    if (obj.length == 1) {
                        param.put(e.getKey(), obj[0]);
                    } else if (obj.length >= 2) {
                        param.put(e.getKey(), obj);
                    }
                } else {
                    param.put(e.getKey(), obj);
                }
            }
        }
        return param;
    }
}
