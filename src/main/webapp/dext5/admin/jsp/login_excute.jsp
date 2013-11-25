<%	/**
 	* @File		:	login_excute.jsp
 	* @Function	:	관리자 시스템 로그인 실행 페이지
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
<%@ page import="org.jdom2.Document"%>
<%@ page import="org.jdom2.Element"%>
<%@ page import="org.jdom2.input.SAXBuilder"%>
<%@ include file="/dext5/admin/jsp/common_function.jsp" %>
<%
	response.setContentType("text/xml");

	/* SAXBuilder sb = new SAXBuilder();
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
	} */

	String id = nullCheck(request.getParameter("id"));
	String password = nullCheck(request.getParameter("password"));
	
	String result = "";
	String message = "";
	
	result = "3";
	session.setAttribute("id",id);
	
	
	/* if(!id.equals("admin")) {
		result = "1";
		message = "아이디가 일치하지 않습니다.";
	} else if(id.equals("admin") && !password.equals(save_password)) {
		result = "2";
		message = "비밀번호가 일치하지 않습니다.";
	} else if(id.equals("admin") && password.equals(save_password)) {
		result = "3";
		session.setAttribute("id",id);
	} */
	
	
	
%>
<?xml version="1.0" encoding="utf-8"?>
<login>
<result><%=result%></result>
<message><![CDATA[<%=message%>]]></message>
<id><%=id%></id>
</login>