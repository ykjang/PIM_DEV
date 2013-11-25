<%	/**
 	* @File		:	index.jsp
 	* @Function	:	관리자 시스템 초기 페이지
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
<%
String id = (String)session.getAttribute("id");
if(id == null) {
	id = "";
}
String url = "";
if(id.equals("admin")) {
	url = "license_admin.jsp";
} else {
	url = "login.jsp";
}
%>
<script type="text/javascript">
	self.location.href = "<%=url%>";
</script>