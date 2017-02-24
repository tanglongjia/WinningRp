package com.winningRp.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

 
@Service
public class VRService extends BaseService {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private RpBaseService rpBaseService;

    public void getCxtjService(Map<String, Object> params) throws Exception {

        rpBaseService.getReportWhereEx(params);

    }


}
