package com.winningRp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created with 填报报表项目
 * USER: 项鸿铭
 * DATE: 2016/10/19.
 * TIME: 2:59.
 * WinningRp
 */
@Controller
@RequestMapping(value = "/error")
public class ErrorController extends AbstractController {

    @RequestMapping(value = {"/404"})
    public String error404() {
        return "/error/404";
    }

    @RequestMapping(value = "/405")
    public String error405() {
        return "/error/405";
    }

    @RequestMapping(value = "/500")
    public String error500() {
        return "/error/500";
    }

}
