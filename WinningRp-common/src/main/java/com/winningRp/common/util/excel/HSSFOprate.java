package com.winningRp.common.util.excel;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;

import java.util.Map;

public class HSSFOprate implements ExcelOprate{

	@Override
	public HSSFFont setFont(HSSFFont font, Map<String,String> map) {
		// TODO Auto-generated method stub
	    font.setFontName(map.get("fontname"));  
	    font.setBoldweight(Short.parseShort(map.get("boldweight")));  
	    font.setFontHeight(Short.parseShort(map.get("fontHeight")));  
	    font.setColor(Short.parseShort(map.get("color")));  
		return font;
	}

	@Override
	public HSSFCellStyle setCellStyle(HSSFCellStyle style, Map<String,Short> map) {
		// TODO Auto-generated method stub
		style.setAlignment(map.get("alignment"));  
	    style.setVerticalAlignment(map.get("verticalalignment"));  
	    style.setFillForegroundColor(map.get("fillforegroundcolor"));  
	    style.setFillPattern(map.get("fillpattern"));  
	  
	    // 设置边框 
	    style.setBottomBorderColor(map.get("bottombordercolor"));  
	    style.setBorderBottom(map.get("borderbottom"));  
	    style.setBorderLeft(map.get("borderleft"));  
	    style.setBorderRight(map.get("borderright"));  
	    style.setBorderTop(map.get("bordertop")); 
	    style.setTopBorderColor(map.get("topbordercolor"));
	    style.setLeftBorderColor(map.get("leftbordercolor"));
	    style.setBottomBorderColor(map.get("bottombordercolor"));
	    style.setRightBorderColor(map.get("rightbordercolor"));
	   
		return style;
	}

	@Override
	public HSSFCell setCell(HSSFCell cell, HSSFCellStyle style, String cellValue) {
		// TODO Auto-generated method stub
		cell.setCellStyle(style);
	   // cell.setEncoding(HSSFCell.ENCODING_UTF_16);
	    cell.setCellValue(cellValue); 
		return null;
	}

}
