<%	/**
 	* @File		:	common_function.jsp
 	* @Function	:	관리자 시스템 공통함수 페이지
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
<%!
	public String nullCheck(String str) {
		if(str == null || str.trim().equals("")) {
			return "";
		} else {
			return str;
		}
	}
%>