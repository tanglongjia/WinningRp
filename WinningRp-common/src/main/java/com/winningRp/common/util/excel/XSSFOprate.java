package com.winningRp.common.util.excel;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;

import java.util.Map;

public class XSSFOprate {
	
	public XSSFFont setFont(XSSFFont font, Map<String,Object> map) {
		// TODO Auto-generated method stub
	    font.setFontName((String)map.get("fontname"));  
	    font.setBoldweight(Short.parseShort((String)map.get("boldweight")));  
	    font.setFontHeight(Short.parseShort((String)map.get("fontHeight")));  
	    font.setColor((XSSFColor)map.get("color"));
		return font;
	}

	
	public XSSFCellStyle setCellStyle(XSSFCellStyle style, Map<String,Object> map) {
		// TODO Auto-generated method stub
		style.setAlignment(Short.parseShort(String.valueOf(map.get("alignment"))));  
	    style.setVerticalAlignment(Short.parseShort(String.valueOf(map.get("verticalalignment"))));  
	    style.setFillForegroundColor((XSSFColor)map.get("fillforegroundcolor"));
	    style.setFillPattern(Short.parseShort(String.valueOf(map.get("fillpattern"))));  
	  
	    // 设置边框 
	    style.setBottomBorderColor((XSSFColor)map.get("bottombordercolor"));
	    style.setBorderBottom(Short.parseShort(String.valueOf(map.get("borderbottom"))));  
	    style.setBorderLeft(Short.parseShort(String.valueOf(map.get("borderleft"))));  
	    style.setBorderRight(Short.parseShort(String.valueOf(map.get("borderright"))));  
	    style.setBorderTop((Short.parseShort(String.valueOf(map.get("bordertop"))))); 
	    style.setTopBorderColor((XSSFColor)map.get("topbordercolor"));
	    style.setLeftBorderColor((XSSFColor)map.get("leftbordercolor"));
	    style.setBottomBorderColor((XSSFColor)map.get("bottombordercolor"));
	    style.setRightBorderColor((XSSFColor)map.get("rightbordercolor"));
	   
		return style;
	}

	
	public XSSFCell setCell(XSSFCell cell, XSSFCellStyle style, String cellValue) {
		// TODO Auto-generated method stub
		cell.setCellStyle(style);
	   // cell.setEncoding(XSSFCell.ENCODING_UTF_16);
	    cell.setCellValue(cellValue); 
		return null;
	}
}
