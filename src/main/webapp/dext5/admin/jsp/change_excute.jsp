<%	/**
 	* @File		:	change_excute.jsp
 	* @Function	:	관리자 시스템 비밀번호 변경 실행 페이지
 	* @Author	:	Dext5 Editor 개발팀
 	* @Created	:	2013.09.13
	* @UpdateHistory
	* ===================================
	* Revision	1.0	2013.09.13	Dext5 Editor 개발팀	최초작성
	* ===================================
	* Copyright(c) 2013 by DEVPIA Corp. All Rights Reserved.
	*/
%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="org.jdom2.Document"%>
<%@ page import="org.jdom2.Element"%>
<%@ page import="org.jdom2.input.SAXBuilder"%>
<%@ include file="/dext5/admin/jsp/common_function.jsp" %>
<%
	response.setContentType("text/xml");

	SAXBuilder sb = new SAXBuilder();
	Document doc = null;
	try {
		String AppPath_xml = request.getContextPath();
		AppPath_xml += "dext5/config";
		String real_path_xml = application.getRealPath(AppPath_xml);
	 	doc = sb.build(real_path_xml + "/dext_editor.xml");
	} catch (Exception e) {
		System.err.println(e);
	}
	
	Element root = doc.getRootElement();
	String product_key = root.getChild("license").getChild("product_key").getValue();
	
	FileReader readFile = null;
	try {
		String AppPath_txt = request.getContextPath();
		AppPath_txt += "dext5/admin/jsp";
		String real_path_txt = application.getRealPath(AppPath_txt);
		readFile = new FileReader(real_path_txt + "/" + product_key + ".txt");
	} catch (Exception e) {
		System.err.println(e);
	}
	
	String save_password = "ZGV4dDVhZG1pbg==";
	if(readFile != null) {
		save_password = "";
		int index = 0;
		do {
			int tempChar = readFile.read();
			if (tempChar == -1) {
				break;
			}
			save_password = save_password + (char) tempChar;
		} while (true);
	}

	String password = nullCheck(request.getParameter("password"));
	String new_pw = nullCheck(request.getParameter("new_pw"));
	
	String result = "2";
	String message = "비밀번호 변경 중 오류가 발생했습니다. 다시 시도해 주세요.";
	FileWriter writeFile = null;
	if(!save_password.equals(password)) {
		result = "1";
		message = "현재 비밀번호가 맞지 않습니다.";
	} else {
		result = "3";
		try {
			String AppPath_txt = request.getContextPath();
			AppPath_txt += "dext5/admin/jsp";
			String real_path_txt = application.getRealPath(AppPath_txt);
			writeFile = new FileWriter(real_path_txt + "/" + product_key + ".txt");
			writeFile.flush();
			writeFile.write(new_pw);
			writeFile.close();
		} catch (Exception e) {
			System.err.println(e);
		}
	}
%>
<?xml version="1.0" encoding="utf-8"?>
<change>
<result><%=result%></result>
<message><![CDATA[<%=message%>]]></message>
</change>