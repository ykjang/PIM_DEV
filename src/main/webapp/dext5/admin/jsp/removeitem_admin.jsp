<%	/**
 	* @File		:	removeitem_admin.jsp
 	* @Function	:	관리자 시스템 제거항목 관리 페이지
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
<%@ include file="/dext5/admin/jsp/common_function.jsp" %>
<%
	String page_mode = nullCheck(request.getParameter("page_mode"));

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
<script src="../../js/dext5_admin.js" type="text/javascript"></script>
<script src="../../js/admin/admin_ko.js" type="text/javascript"></script>
<title>Dext5 웹에디터 - 관리자페이지 - 제거항목 관리</title>
<script type="text/javascript">
	function excuteConfirm() {
        var set_menu_cnt = document.getElementById("set_menu").length;
        for (var i = 0; i < set_menu_cnt; i++) {
            var input = document.createElement("input");
            input.setAttribute("type", "hidden");
            input.setAttribute("id", "remove_item");
            input.setAttribute("name", "remove_item[]");
            input.setAttribute("value", document.getElementById("set_menu").options[i].value);
            document.getElementById("xml_value").appendChild(input);
        }
        return true;
    }

    function editorConfirmMove() {
        self.location = "editor_confirm.jsp";
        return false;
    }
</script>
</head>
<body class="dext5_editor" onload="xmlhttpPostXML('../../config/dext_editor.xml', null, 'xmlAdmin','5');">
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
					<li><a href="removeitem_admin.jsp" class="on">제거항목 관리</a></li>
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
		<div class="dh">
		<form name="dext5" method="post" action="excute.jsp" onsubmit="return excuteConfirm();">
		<input type="hidden" id="mode" name="mode" value="5"/>
		<div id="xml_value"></div>
			<h2>
				<img src="../../images/admin/dext_img09.gif" width="241" height="16" alt="제거항목 관리" />
			</h2>
			<p class="dbg"></p>
			<div class="selectbox">
				<div class="select">
					<p class="title"><label for="all_menu">사용가능 제거항목메뉴</label></p>
					<p class="box01">
						<select name="all_menu" id="all_menu" size="" multiple></select>
					</p>
				</div>
				<div class="btn">
					<p class="hm" style="margin-top:115px;">
						<a href="javascript:move_all_option(document.getElementById('all_menu'), document.getElementById('set_menu'));" id="all_right" name="all_right"><span><img src="../../images/admin/dext_arrow01.gif" width="12" height="12" alt="사용가능 제거항목메뉴를 현재 적용된 제거항목메뉴로 모두 이동"/></span></a>
						<a href="javascript:move_option(document.getElementById('all_menu'), document.getElementById('set_menu'));" id="right" name="right"><span><img src="../../images/admin/dext_arrow02.gif" width="12" height="12" alt="사용가능 제거항목메뉴를 현재 적용된 제거항목메뉴로 이동"/></span></a>
					</p>
					<p class="hm" style="margin-top:115px;">
						<a href="javascript:move_all_option(document.getElementById('set_menu'), document.getElementById('all_menu'));" id="all_left" name="all_left"><span><img src="../../images/admin/dext_arrow03.gif" width="12" height="12" alt="현재 적용된 제거항목메뉴를 모두 제거"/></span></a>
						<a href="javascript:move_option(document.getElementById('set_menu'), document.getElementById('all_menu'));" id="left" name="left"><span><img src="../../images/admin/dext_arrow04.gif" width="12" height="12" alt="현재 적용된 제거항목메뉴를 제거"/></span></a>
					</p>
				</div>
				<div class="select">
					<p class="title"><label for="set_menu">현재 적용된 제거항목메뉴</label></p>
					<p class="box01">
						<select name="set_menu" id="set_menu" size="" multiple></select>
					</p>
				</div>
			</div>
			<div class="bottom_btn">
				<ul>
					<li>
						<button type="submit" class="button">적용</button>
					</li>
				<% if(page_mode.equals("excute")) { %>
					<li>
						<button type="button" class="button" onclick="javascript:return editorConfirmMove();">Editor 확인</button>
					</li>
				<% } %>
				</ul>
			</div>
		</form>
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