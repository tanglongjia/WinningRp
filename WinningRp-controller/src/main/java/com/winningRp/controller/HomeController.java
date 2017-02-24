package com.winningRp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Reporting控制器
 */
@Controller
@RequestMapping(value = "/")
public class HomeController extends AbstractController {

    @RequestMapping(value = {"/rpHome"})
    public String home() {
        return "home";
    }


    @RequestMapping(value = {"/htHome"})
    public String ht() {
        return "source";
    }


    @RequestMapping(value = {"/sy"})
    public String index() {
        return "index";
    }
}