package com.winningRp.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFHeader;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.winningRp.common.engine.EditTableBuilder;
import com.winningRp.dao.BaseDao;
import com.winningRp.service.RpBaseService;
import com.winningRp.common.util.MapUtil;
import com.winningRp.common.util.MessageStreamResult;


@Controller 
@RequestMapping("/vr")
public class VRController extends BaseController {
	
	@Autowired
    @Qualifier("rpdao")
	private BaseDao dao;
	
	@Autowired
	private RpBaseService rpBaseService; 
	
	@RequestMapping("rpqc_module")
	public ModelAndView RpQueryConditionModule(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView modelAndView = new ModelAndView("/report/viewCxtj", new HashMap<String, Object>());
		map=MapUtil.doParameterMap(true, request);
		List list = rpBaseService.getReportWhereEx(map);
		List list1 = rpBaseService.getReportToolBars(map);

		EditTableBuilder etb = new EditTableBuilder(dao.getJdbcTemplate());
		String qc=etb.builderWhereEx(list, map);
		String qc1=etb.builerToolBar(list1);
		
		modelAndView.addObject("html", qc);
		modelAndView.addObject("toobal", qc1);
		return modelAndView;
	}
	
	@RequestMapping("linkage")
	public ModelAndView RpQueryLinkage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		map=MapUtil.doParameterMap(true, request);
		List list = rpBaseService.getQueryConditionLinkage(map);
		MessageStreamResult.msgStreamResult(response, JSONArray.fromObject(list).toString());		
		return null;
	}
	
	@RequestMapping("linkageControl")
	public ModelAndView RpQueryLinkageControl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		map=MapUtil.doParameterMap(true, request);
		List list = rpBaseService.getLinkageControlValue(map);
		MessageStreamResult.msgStreamResult(response, JSONArray.fromObject(list).toString());		
		return null;
	}

	 /** 
	* 导出数据到excel 
	* @return 
	* @throws Exception   
	*/ 
	@RequestMapping(value = "export")
	public String export(HttpServletRequest request,HttpServletResponse response)throws Exception 
	{   
		String bgdm=request.getParameter("bgdm");
		List studentList=rpBaseService.getStudent(bgdm);
		List list=rpBaseService.getResultColumnEx(bgdm);
		Map map =  new LinkedHashMap();
		for (int i = 0; i < list.size(); i++) {
			Map map1 = new HashMap();
			map1.putAll((Map) list.get(i));
			
			map.put(map1.get("BQSJYL"), map1.get("BTMC"));
			
		}
		
		studentList.add(0, map);
//		for(int i=0;i<10;i++) 
//		{   Student student=new Student();//
//		student.setStudentId("201610110"+i); 
//		student.setStudentName("chauncey"+i); 
//		student.setStudentSex("男"); 
//		student.setStudentDormitory("14-20"+i); 
//		student.setStudentSept("无"); 
//		studentList.add(student); 
//		} 
		
		//设置表头：对Excel每列取名  (必须根据你取的数据编写) 
		Map<String, String>  map2 = new LinkedHashMap<String, String> ();
		map2.putAll((Map<String,String>) studentList.get(0));
		String aa="";
		String[] tableHeader={}; 
		for (String key : map2.keySet()) {
			aa = aa+(String) map2.get(key)+",";
		}
		tableHeader= aa.split(",");
		
		short cellNumber=(short)tableHeader.length;//表的列数 
		HSSFWorkbook workbook = new HSSFWorkbook();	//创建一个excel 
		HSSFCell cell = null;	//Excel的列 
		HSSFRow row = null;	//Excel的行 
		HSSFCellStyle style = workbook.createCellStyle();	//设置表头的类型 
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		HSSFCellStyle style1 = workbook.createCellStyle();	//设置数据类型 
		style1.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		HSSFFont font = workbook.createFont();	//设置字体 
		HSSFSheet sheet = workbook.createSheet("sheet1");	//创建一个sheet 
		HSSFHeader header = sheet.getHeader();//设置sheet的头 
		try {              /** 
		                     *根据是否取出数据，设置header信息 
		                     * 
		                     */
		if(studentList.size() < 1 ){ 
			header.setCenter("查无资料"); 
		}else{ 
			//header.setCenter("测试表"); 
			row = sheet.createRow(0); 
			row.setHeight((short)400); 
			for(int k = 0;k < cellNumber;k++){	
				cell = row.createCell(k);//创建第0行第k列 
				cell.setCellValue(tableHeader[k]);//设置第0行第k列的值 
				sheet.setColumnWidth(k,8000);//设置列的宽度 
				font.setColor(HSSFFont.COLOR_NORMAL); // 设置单元格字体的颜色. 
				font.setFontHeight((short)350); //设置单元字体高度 
				style1.setFont(font);//设置字体风格 
				cell.setCellStyle(style1); 
			} 
		                         
		                          // 给excel填充数据这里需要编写 
		                              
		studentList.remove(0);
		for(int i = 0 ;i < studentList.size() ;i++){	   
			//Student student1 = (Student)studentList.get(i);//获取student对象 
			Map<String, String>  map3 = new LinkedHashMap<String, String> ();
			map3.putAll((Map<String,String>) studentList.get(i));
			
		    row = sheet.createRow((short) (i + 1));//创建第i+1行 
		    row.setHeight((short)400);//设置行高 
		    
		    int x=0;
		    for (String key : map3.keySet()) {
				cell = row.createCell(x++);//创建第i+1行第0列 
		    	cell.setCellValue(map3.get(key).toString());//设置第i+1行第0列的值 
		    	cell.setCellStyle(style);//设置风格
			}
//		    if(student1.getStudentId() != null){ 
//		    	cell = row.createCell(0);//创建第i+1行第0列 
//		    	cell.setCellValue(student1.getStudentId());//设置第i+1行第0列的值 
//		    	cell.setCellStyle(style);//设置风格 
//		    } 
//		    if(student1.getStudentName() != null){ 
//			    cell = row.createCell(1); //创建第i+1行第1列 
//		
//			    cell.setCellValue(student1.getStudentName());//设置第i+1行第1列的值 
//		
//			    cell.setCellStyle(style); //设置风格 
//		    } 
//		//由于下面的和上面的基本相同，就不加注释了 
//		    if(student1.getStudentSex() != null){ 
//			    cell = row.createCell(2); 
//			    cell.setCellValue(student1.getStudentSex()); 
//			    cell.setCellStyle(style); 
//		    } 
//		    if(student1.getStudentDormitory()!= null){ 
//			    cell = row.createCell(3); 
//			    cell.setCellValue(student1.getStudentDormitory()); 
//			    cell.setCellStyle(style); 
//		    } 
//		    if(student1.getStudentSept() != null){ 
//			    cell = row.createCell(4); 
//			    cell.setCellValue(student1.getStudentSept()); 
//			    cell.setCellStyle(style); 
//		    } 
		    
		} 
	
		} 
	
		} catch (Exception e) { 
			e.printStackTrace(); 
		} 
	
		OutputStream out = null;//创建一个输出流对象 
		try { 
			/*path="E:\\aa.xlsx";
			File file = new File(path);  
           // 取得文件名。  
           String filename = file.getName(); 
			InputStream fis = new BufferedInputStream(new FileInputStream(path));  
	        byte[] buffer = new byte[fis.available()];  
	        fis.read(buffer);  
	        fis.close();*/
		//response = ServletActionContext.getResponse();//初始化HttpServletResponse对象 
		out = response.getOutputStream();// 
		        response.setHeader("Content-disposition","attachment; filename="+"execl.xls");//filename是下载的xls的名，建议最好用英文
		        response.setContentType("application/vnd.ms-excel;charset=UTF-8");//设置类型 
		        response.setHeader("Pragma","No-cache");//设置头 
		        response.setHeader("Cache-Control","no-cache");//设置头 
		        response.setDateHeader("Expires", 0);//设置日期头 
		        workbook.write(out); 
		        out.flush(); 
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{ 
			try{ 
				if(out!=null){ 
					out.close(); 
				} 
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		} 

	return null; 
	} 
	
	 
/**
* ***************************************************************************************************	
*/
//	private File excelFile;//File对象，目的是获取页面上传的文件 
//	private  List<Student> stuList=new ArrayList<Student>(); 
//	//定义的方法： 
//	public File getExcelFile() { 
//		return excelFile; 
//	} 
//	public void setExcelFile(File excelFile) { 
//		this.excelFile = excelFile; 
//	} 
//	public List<Student> getStuList() { 
//		return stuList; 
//	} 
//	public void setStuList(List<Student> stuList) { 
//		this.stuList = stuList; 
//	} 

	//主要编写的是importExcel方法，如下： 
	/********* 
	* 
	* 导入Excel数据 
	* @return 
	* @throws Exception 
	*/ 
	@RequestMapping(value = "import")
	public ModelAndView importExcel(@RequestParam("excelFile")MultipartFile excelFile1, HttpServletRequest request, HttpServletResponse response)throws Exception 
	{   
			ModelAndView modelAndView = new ModelAndView("/report/viewCxtj", new HashMap<String, Object>());
			String bgdm = request.getParameter("bgdm");
            InputStream inputStream = excelFile1.getInputStream();  
            POIFSFileSystem fs = new POIFSFileSystem(inputStream);  
            HSSFWorkbook workbook = new HSSFWorkbook(fs);  
            //XSSFWorkbook workbook = new XSSFWorkbook(fs);  
            List list = rpBaseService.getResultColumnEx(bgdm);
            Map rc= new HashMap();
            
            HSSFSheet sheet = workbook.getSheetAt(0);  
            int rowNum = sheet.getLastRowNum();// 行  
            int cellNum;  

            HSSFRow row;  
            HSSFCell cell = null;  
            String value = "";
            List dataList= new ArrayList();
            
          for (int i = 1; i <= rowNum; i++) {
              row = sheet.getRow(i);   
              cellNum = row.getLastCellNum();// 列  
              //StringBuffer recStrb = new StringBuffer("");  
              Map<String, Object> map= new LinkedHashMap<String, Object>();
              for (int j = 0; j < cellNum; j++) {//对一行的每个列进行解析  
            	  rc.putAll((Map) list.get(j));
                  cell = row.getCell((short) j);  
                  value = cell.getStringCellValue();//字符型的值  
                if (StringUtils.isEmpty(value)) {  
                      //recStrb.append("null, ");  
                } else {  
                    //recStrb.append("'" + value + "', ");//对取得的值进行处理  
                    map.put(rc.get("BQSJYL").toString(), value);
                }  

              }  

              //数据的自定义处置   
              if (i > 0) {  
                  //String strTemp = recStrb.toString();  
                  //strTemp = strTemp.substring(0,strTemp.lastIndexOf(","));  
                  dataList.add(map);
              }  
          }  
          System.out.println(dataList);
	     /* 
	      *为了方便，定义从Excel中获取数据的相应的变量 
	      * 
	      */ 
//	String id=null; 
//	String name=null; 
//	String  sex=null; 
//	String  Dormitory=null; 
//	String Sept=null; 
//	     /* 
//	      *2007版的读取方法 
//	*以下可以直接拷贝，不用修改 
//	      */ 
//	Workbook workbook = null; 
////	try {
////		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
////		String filename=multipartRequest.getFile("filename1").getOriginalFilename();
////	} catch (Exception e) {
////		e.printStackTrace();
////	}
//	String fileURL = request.getParameter("excelFile");
//	String input = request.getParameter("val"); 
//	String filepath = request.getParameter("filepath"); 
//
//System.out.println("12345"); 
//	File workfile = (File)request.getAttribute("excelFile");
//	int k=0; 
//	int flag = 0;   //指示指针所访问的位置 
//	if(excelFile!=null) 
//	{ 
//	String path=excelFile.getAbsolutePath();//获取文件的路径 
//	try { 
//	        workbook = new XSSFWorkbook(path);//初始化workbook对象 
//	        for (int numSheets = 0; numSheets < workbook.getNumberOfSheets(); numSheets++) {  //读取每一个sheet  
//	        System.out.println("2007版进入读取sheet的循环"); 
//	            if (null != workbook.getSheetAt(numSheets)) {    
//	                XSSFSheet aSheet = (XSSFSheet)workbook.getSheetAt(numSheets);//定义Sheet对象 
//	                for (int rowNumOfSheet = 0; rowNumOfSheet <= aSheet.getLastRowNum(); rowNumOfSheet++) {  
//	                   //进入当前sheet的行的循环   
//	                    if (null != aSheet.getRow(rowNumOfSheet)) { 
//	                        XSSFRow  aRow = aSheet.getRow(rowNumOfSheet); //定义行，并赋值 
//	                        for (int cellNumOfRow = 0; cellNumOfRow <= aRow.getLastCellNum(); cellNumOfRow++) 
//	                        { //读取rowNumOfSheet值所对应行的数据  
//	                        XSSFCell  xCell = aRow.getCell(cellNumOfRow); //获得行的列数	//获得列值   
//	                    //System.out.println("type="+xCell.getCellType()); 
//	                        if (null != aRow.getCell(cellNumOfRow)) 
//	                        { 
//	                        
//	                            if(rowNumOfSheet == 0) 
//	                            {	// 如果rowNumOfSheet的值为0，则读取表头，判断excel的格式和预定格式是否相符              
//	                               if(xCell.getCellType() == XSSFCell .CELL_TYPE_NUMERIC) 
//	                               { 
//	                            
//	                                 }else if(xCell.getCellType() == XSSFCell .CELL_TYPE_BOOLEAN) 
//	                                 { 
//	                                
//	                                 }else if(xCell.getCellType() == XSSFCell .CELL_TYPE_STRING) 
//	                                 { 
//	                                if(cellNumOfRow == 0) 
//	                                {	
//	/* 
//	*一下根据从Excel的各列命名是否符合要求：如下面匹配：学号，姓名，性别，寝室号，所*在系 
//	* 
//	*/ 
//	                                if(xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim().equals("学号")) 
//	                                { 
//	           flag++; 
//	                                }else{ 
//	                                  System.out.println("错误：第一行的学号不符合约定格式"); 
//	                                } 
//	                                }else if(cellNumOfRow == 1) 
//	                                { 
//	                                if(xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim().equals("姓名")) 
//	                                { 
//	                                flag++; 
//	                                }else{ 
//	                                System.out.println("错误：第一行的姓名不符合约定格式"); 
//	                                }         
//	           }else if(cellNumOfRow == 2) 
//	           { 
//	           if(xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim().equals("性别")){ 
//	           flag++; 
//	           
//	           }else{ 
//	           System.out.println("第一行的性别不符合约定格式"); 
//	} 
//	           
//	           }else if (cellNumOfRow == 3) { 
//	           if(xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim().equals("寝室号")) 
//	           { 
//	           flag++; 
//	           System.out.println("=========flag:" + flag); 
//	           }else{ 
//	           System.out.println("第一行的寝室号不符合约定格式"); 
//	} 
//	           
//	           }else if (cellNumOfRow == 4) 
//	{ 
//	           if(xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim().equals("所在系")){ 
//	           flag++; 
//	           System.out.println("=========flag:" + flag); 
//	           }else{ 
//	           System.out.println("第一行的所在系不符合约定格式"); 
//	} 
//	} 
//	  } 
//	} 
//	else {	
//	                            
//	//rowNumOfSheet != 0 即开始打印内容 
//	/************************************************************** 
//	  获取excel中每列的值，并赋予相应的变量，如下的赋值的ID，name,sex, Dormitory,sept; 
//
//	******************************************************************/ 
//	if(xCell.getCellType() == XSSFCell .CELL_TYPE_NUMERIC){	//为数值型	  
//	if(cellNumOfRow == 0){ 
//	id = String.valueOf(xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim()); 
//	if(id == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的学号不能为空"); 
//	} 
//	}else if(cellNumOfRow == 1){	
//	name = String.valueOf(xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim()); 
//	if(name == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的姓名不能为空"); 
//	} 
//	}else if(cellNumOfRow == 2){	
//	sex = String.valueOf(xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim()); 
//	if(sex == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的性别不能为空"); 
//	}	                            
//	}else if (cellNumOfRow == 3){	Dormitory = String.valueOf(xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim()); 
//	                            if(Dormitory == null){ 
//	                                System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的寝室号不能为空"); 
//	                                } 
//	                            }else if (cellNumOfRow == 4){	//备案时间 
//	                            Sept = String.valueOf(xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim()); 
//	                            if(Sept == null){	                     
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的所在系不能为空"); 
//	                                } 
//	                            
//	                            }	                    
//	                            }else if(xCell.getCellType() == XSSFCell .CELL_TYPE_STRING){  //为字符串型  
//	                            System.out.println("===============进入XSSFCell .CELL_TYPE_STRING模块============"); 
//	                            if(cellNumOfRow == 0){ 
//	                            id = xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim(); 
//	                            if(id == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的学号不能为空"); 
//	                            } 
//	                            }else if(cellNumOfRow == 1){	
//	                            name = xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim(); 
//	                            if(name == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的姓名不能为空"); 
//	                            } 
//	                            }else if(cellNumOfRow == 2){	
//	                            sex = xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim(); 
//	                            if(sex == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的性别不能为空"); 
//	                            }	                            
//	                            }else if (cellNumOfRow == 3){	//备案单位 
//	                            Dormitory =xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim(); 
//	                            if(Dormitory == null){ 
//	                                System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的寝室号不能为空"); 
//	                                } 
//	                            }else if (cellNumOfRow == 4){	//备案时间 
//	                            Sept =xCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim(); 
//	                            if(Sept == null){	                     
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的所在系不能为空"); 
//	                                } 
//	                            }      
//	                                }else if (xCell.getCellType() == XSSFCell .CELL_TYPE_BLANK) { 
//	                                System.out.println("提示：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的值为空，请查看核对是否符合约定要求"); 
//	                                } 
//	                              } 
//	                           }	
//	                          
//	                          
//	                        } 
//	                        if (flag!=5){ 
//	                        System.out.println("请核对后重试"); 
//	                            
//	                        
//	                      } 
//	                    }	
//	   /************************************************************* 
//	   判断各个元素被赋值是否为空，如果不为空就放入到stuList，如果放入数据库，就直接使用数据的插入的函数就可以了。 
//	   
//	   *************************************************************/ 
//	                    if(id != null && name != null && sex != null && Dormitory != null && Sept != null ){ 
//	                    Student stu=new Student(); 
//	                    stu.setStudentId(id); 
//	                    stu.setStudentName(name); 
//	                    stu.setStudentSept(Sept); 
//	                    stu.setStudentSex(sex); 
//	                    stu.setStudentDormitory(Dormitory); 
//	                    stuList.add(stu); 
//	                        k++; 
//	                    } 
//	        } //获得一行，即读取每一行   
//	        }   
//	            //读取每一个sheet 
//	        
//	     } 
//	       }catch (Exception e) { 
//	                    /********************************************                         下面使用的是2003除了workbook的赋值不同其它与2007基本相同，就不作介绍了 
//	                     *********************************************/
//	        InputStream is = new FileInputStream(path);       
//	        workbook = new HSSFWorkbook(is); 
//	        try { 
//	        for (int numSheets = 0; numSheets < workbook.getNumberOfSheets(); numSheets++) {  //读取每一个sheet  
//	            System.out.println("2003版进入读取sheet的循环"); 
//	                if (null != workbook.getSheetAt(numSheets)) {    
//	                    HSSFSheet aSheet = (HSSFSheet)workbook.getSheetAt(numSheets); 
//	                    for (int rowNumOfSheet = 0; rowNumOfSheet <= aSheet.getLastRowNum(); rowNumOfSheet++) { //获得一行   
//	                    
//	                        if (null != aSheet.getRow(rowNumOfSheet)) { 
//	                            HSSFRow  aRow = aSheet.getRow(rowNumOfSheet); 
//	                            for (int cellNumOfRow = 0; cellNumOfRow <= aRow.getLastCellNum(); cellNumOfRow++) { //读取rowNumOfSheet值所对应行的数据  
//	                            HSSFCell  aCell = aRow.getCell(cellNumOfRow); //获得列值   
//	                        
//	                            if (null != aRow.getCell(cellNumOfRow)){ 
//	                                if(rowNumOfSheet == 0){	// 如果rowNumOfSheet的值为0，则读取表头，判断excel的格式和预定格式是否相符              
//	                                if(aCell.getCellType() == HSSFCell .CELL_TYPE_NUMERIC){ 
//	                                    }else if(aCell.getCellType() == HSSFCell .CELL_TYPE_BOOLEAN){ 
//	                                    }else if(aCell.getCellType() == HSSFCell .CELL_TYPE_STRING){ 
//	                                    if(cellNumOfRow == 0){	
//	                                if(aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim().equals("学号")){ 
//	           flag++; 
//	           System.out.println("=========flag:" + flag); 
//	                                }else{ 
//	                                  System.out.println("错误：第一行的学号不符合约定格式"); 
//	                                } 
//	                                }else if(cellNumOfRow == 1){ 
//	                                if(aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim().equals("姓名")){ 
//	                                flag++; 
//	                                System.out.println("=========flag:" + flag); 
//	                                }else{ 
//	                                System.out.println("错误：第一行的姓名不符合约定格式"); 
//	                                }         
//	           }else if(cellNumOfRow == 2){ 
//	           if(aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim().equals("性别")){ 
//	           flag++; 
//	           System.out.println("=========flag:" + flag); 
//	           }else{ 
//	           System.out.println("第一行的性别不符合约定格式"); 
//	                                } 
//	           
//	           }else if (cellNumOfRow == 3){ 
//	           if(aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim().equals("寝室号")){ 
//	           flag++; 
//	           System.out.println("=========flag:" + flag); 
//	           }else{ 
//	           System.out.println("第一行的寝室号不符合约定格式"); 
//	                                } 
//	           
//	           }else if (cellNumOfRow == 4){ 
//	           if(aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim().equals("所在系")){ 
//	           flag++; 
//	           System.out.println("=========flag:" + flag); 
//	           }else{ 
//	           System.out.println("第一行的所在系不符合约定格式"); 
//	                                } 
//	           } 
//	                                    } 
//	                            } 
//	                                else {	
//	                                if(aCell.getCellType() == HSSFCell .CELL_TYPE_NUMERIC){	//为数值型	
//	                                System.out.println("======进入XSSFCell .CELL_TYPE_NUMERIC模块=========="); 
//	                                if(cellNumOfRow == 0){ 
//	                            id = String.valueOf(aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim()); 
//	                            if(id == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的学号不能为空"); 
//	                            } 
//	                            }else if(cellNumOfRow == 1){	
//	                            name = String.valueOf(aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim()); 
//	                            if(name == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的姓名不能为空"); 
//	                            } 
//	                            }else if(cellNumOfRow == 2){	
//	                            sex = String.valueOf(aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim()); 
//	                            if(sex == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的性别不能为空"); 
//	                            }	                            
//	                            }else if (cellNumOfRow == 3){	                            Dormitory = String.valueOf(aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim()); 
//	                            if(Dormitory == null){ 
//	                                System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的寝室号不能为空"); 
//	                                } 
//	                            }else if (cellNumOfRow == 4){	                            Sept = String.valueOf(aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim()); 
//	                            if(Sept == null){	                     
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的所在系不能为空"); 
//	                                } 
//	                            
//	                            }	                                        
//	                                }else if(aCell.getCellType() == HSSFCell .CELL_TYPE_STRING){  //为字符串型  
//	                                System.out.print("===============进入XSSFCell .CELL_TYPE_STRING模块============"); 
//	                                if(cellNumOfRow == 0){ 
//	                            id = aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim(); 
//	                            if(id == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的学号不能为空"); 
//	                            } 
//	                            }else if(cellNumOfRow == 1){	
//	                            name = aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim(); 
//	                            if(name == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的姓名不能为空"); 
//	                            } 
//	                            }else if(cellNumOfRow == 2){	
//	                            sex = aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim(); 
//	                            if(sex == null){ 
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的性别不能为空"); 
//	                            }	                            
//	                            }else if (cellNumOfRow == 3){	
//	                            Dormitory =aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim(); 
//	                            if(Dormitory == null){ 
//	                                System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的寝室号不能为空"); 
//	                                } 
//	                            }else if (cellNumOfRow == 4){	                            Sept =aCell.getStringCellValue().replace('\t', ' ').replace('\n', ' ').replace('\r', ' ').trim(); 
//	                            if(Sept == null){	                     
//	                            System.out.println("错误：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的所在系不能为空"); 
//	                                } 
//	                            }      
//	                                
//	                                    }else if (aCell.getCellType() == HSSFCell .CELL_TYPE_BLANK) { 
//	                                    System.out.println("提示：在Sheet"+(numSheets+1)+"中的第"+(rowNumOfSheet+1)+"行的第"+(cellNumOfRow+1)+"列的值为空，请查看核对是否符合约定要求".toString()); 
//	                                    } 
//	                                }                                                                
//	                               }	                            
//	                            } 
//	                            
//	                            if (flag!=5){ 
//	                            System.out.println("请核对后重试"); 
//	                                
//	                            } 
//	                        } 
//	            
//	                        if(id != null && name != null && sex != null && Dormitory != null && Sept != null ){ 
//	                    Student stu=new Student(); 
//	                    stu.setStudentId(id); 
//	                    stu.setStudentName(name); 
//	                    stu.setStudentSept(Sept); 
//	                    stu.setStudentSex(sex); 
//	                    stu.setStudentDormitory(Dormitory); 
//	                    stuList.add(stu); 
//	                        k++; 
//	                    } 
//	                        
//	                    } 
//	                    if(k!=0){ 
//	                    System.out.println("提示：您导入的数据已存在于数据库，请核对！k 为：" + k); 
//	                }else{ 
//	                System.out.println("提示：成功导入了"+k+"条数据"); 
//	                } 
//	                }    
//	            }  
//	        
//
//	} catch (Exception ex) { 
//		ex.printStackTrace(); 
//	}finally{ 
//		try { 
//			if(is!=null) 
//				is.close(); 
//			}catch (Exception e1) { 
//				e1.printStackTrace(); 
//			} 
//		} 
//	 } 
//	} 
        modelAndView.addObject("btmc", list);
        modelAndView.addObject("dataList", dataList);
		return modelAndView; 
	}
}
