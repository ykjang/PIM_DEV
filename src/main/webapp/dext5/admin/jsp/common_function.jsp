<%	/**
 	* @File		:	common_function.jsp
 	* @Function	:	������ �ý��� �����Լ� ������
 	* @Author	:	Dext5 Editor ������
 	* @Created	:	2013.09.13
	* @UpdateHistory
	* ===================================
	* Revision	1.0	2013.09.13	Dext5 Editor ������	�����ۼ�
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