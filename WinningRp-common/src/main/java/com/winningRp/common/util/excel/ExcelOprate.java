package com.winningRp.common.util.excel;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;

import java.util.Map;

public interface ExcelOprate {
	
	public HSSFFont setFont(HSSFFont font, Map<String, String> map);
	
	public HSSFCellStyle setCellStyle(HSSFCellStyle style, Map<String, Short> map);
	
	public HSSFCell setCell(HSSFCell cell, HSSFCellStyle style, String cellValue);

}
