package com.winningRp.common.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.script.Compilable;
import javax.script.CompiledScript;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/11/22.
 * TIME: 5:56.
 * WinningRp
 */
public class ScriptEngineUtils {

    protected final static Logger logger = LoggerFactory.getLogger(ScriptEngineUtils.class);

    //匹配{xxx}
    public static final String PATTERN = "\\{+([^\\{\\}]*[^\\{\\}])\\}+";

    /**
     * 获取编译引擎 解析脚本
     *
     * @return
     */
    public static String scriptEngine(String scriptStr) {
        ScriptEngineManager manager = new ScriptEngineManager();
        ScriptEngine engine = manager.getEngineByName("javascript");
        Compilable compEngine = null;
        String resultValue = "";

        if (scriptStr.indexOf(";") == -1) {
            resultValue = scriptStr;
        } else {
            if (engine instanceof Compilable) {
                compEngine = (Compilable) engine;
                try {
                    // 进行编译
                    CompiledScript script = compEngine.compile(scriptStr);
                    resultValue = script.eval().toString();
                } catch (Exception e) {
                    logger.info("无法解析");
                    return scriptStr;
                }
            } else {
                logger.error("这个脚本引擎不支持编译!");
                return scriptStr;
            }
        }

        return resultValue;
    }

    /**
     * 解析脚本
     *
     * @param script
     * @return
     */
    public static String parseScript(String script, Map<String, Object> params) {
        String scriptTmp = script.replaceAll("\r|\n|\t", " ");
        Pattern pattern = Pattern.compile(PATTERN);
        Matcher matcher1 = pattern.matcher(scriptTmp);
        while (matcher1.find()) {
            String bm = matcher1.group(1).trim();
            if (params.get(bm) == null) {
                scriptTmp = scriptTmp.replaceAll("\\{" + bm + "\\}", "");
            } else {
                scriptTmp = scriptTmp.replaceAll("\\{" + bm + "\\}", params.get(bm).toString());
            }
        }
        return scriptTmp;
    }


}
