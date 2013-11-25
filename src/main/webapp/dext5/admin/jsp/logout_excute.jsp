<%	/**
 	* @File		:	logout_excute.jsp
 	* @Function	:	관리자 시스템 로그아웃 실행 페이지
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
	session.removeAttribute("id");
%>
<script type="text/javascript">
	self.location.href = "login.jsp";
</script>