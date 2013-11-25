<%	/**
 	* @File		:	editor_confirm.jsp
 	* @Function	:	관리자 시스템 적용된 Dext5 Editor 확인 페이지
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
%>
<% if(!id.equals("admin")) { %>
<script type="text/javascript">
	self.location.href = "login.jsp";
</script>
<% } else { %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<link href="../../css/dext_admin.css" type="text/css" rel="stylesheet" />
<script src="../../js/dext5editor.js" type="text/javascript"></script>
<title>Dext5 웹에디터 - 관리자페이지 - Editor 확인</title>
</head>
<body class="dext5_editor">
	<div class="container">
		<!------------  Header  ------------->
		<div class="header">
			<div class="top">
				<h1>
					<img src="../../images/admin/dext_img.png" class="img" width="223" height="28" alt="DEXT5 Editor 관리자 시스템" />
				</h1>
				<span class="top_btn">
					<a href="change_password.jsp">비밀번호 변경</a>
					<img src="../../images/admin/dext_img01.gif" width="1" height="10" alt=""/><a href="logout_excute.jsp" class="bri">로그아웃</a>
				</span>
			</div>
			<div class="top_menu">
				<ul>
					<li><a href="license_admin.jsp" style="margin-left: 0;">라이선스 관리</a></li>
					<li><a href="topmenu_admin.jsp">상단메뉴 관리</a></li>
					<li><a href="toolbar_admin.jsp">툴바 관리</a></li>
					<li><a href="statusbar_admin.jsp">상태바 관리</a></li>
					<li><a href="removeitem_admin.jsp">제거항목 관리</a></li>
					<li><a href="fontsize_admin.jsp">폰트크기 관리</a></li>
					<li><a href="fontfamily_admin.jsp">폰트종류 관리</a></li>
					<li><a href="setting.jsp">환경설정</a></li>
					<li><a href="uploader_setting.jsp">업로드 환경설정</a></li>
				</ul>
			</div>
		</div>
		<!------------  //Header  ------------->
		<!------------  Content  ------------>
		<div class="content">
			<h2>
				<img src="../../images/admin/dext_img08.gif" width="241" height="16" alt="Editor 확인" />
			</h2>
			<p class="dbg"></p>
			<div class="htb">
				<script type="text/javascript">
				    DEXT5.config.Height = "600px";
				    DEXT5.config.Width = "100%";
				    //DEXT5.config.SkinName = "";
				    //DEXT5.config.InitXml = "";   // ex)  DEXT5.config.InitXml = "dext_editor_mobile.xml"; //config 폴더 안의 파일 이름만 지정
				
				    var editor1 = new Dext5editor("editor1");
				
				</script>
			</div>
		</div>
		<!------------  //Content  ------------>
		<!------------  Footer  ------------>
		<div class="footer">
			<p>
				<img src="../../images/admin/devpia_logo.gif" width="102" height="24" alt="DEVPIA" />
				<span class="copyright">Copyrightⓒ DEVPIA & RAONWiZ TECHNOLOGY INC. All right reserved.</span>
				<img src="../../images/admin/raonwiz_logo.gif" width="102" height="24" alt="RAONWIZ" />
			</p>
		</div>
		<!------------  //Footer  ------------>
	</div>
</body>
</html>
<% } %>