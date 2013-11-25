<%	/**
 	* @File		:	fontsize_admin.jsp
 	* @Function	:	관리자 시스템 폰트크기 관리 페이지
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
<title>Dext5 웹에디터 - 관리자페이지 - 폰트크기 관리</title>
<script type="text/javascript">
	function rightExcute() {
		var add_font_size = document.getElementById("add_font_size").value;
		if(add_font_size == "") {
			alert("추가할 폰트크기를 입력해주세요.");
			document.getElementById("add_font_size").focus();
		} else {
			add_font_size += "pt";
			var set_font_size_cnt = document.getElementById("set_font_size").length;
			var set_font_size_check = false;
			for(var i=0 ; i<set_font_size_cnt ; i++) {
				if(document.getElementById("set_font_size").options[i].value == add_font_size) {
					set_font_size_check = true;
				}
			}
			if(!set_font_size_check) {
				var option = document.createElement("option");
				option.setAttribute("value",add_font_size);
				option.innerHTML = add_font_size;
				document.getElementById("set_font_size").appendChild(option);
			}
		}
	}
	
	function deleteExcute() {
		var set_font_size_cnt = document.getElementById("set_font_size").length;
		for(var i=set_font_size_cnt-1 ; i>=0 ; i--) {
			if(document.getElementById("set_font_size").options[i].selected == true) {
				document.getElementById("set_font_size").options[i] = null;
			}
		}
	}
	
	function excuteConfirm(){
		var set_font_size_cnt = document.getElementById("set_font_size").length;
		if(set_font_size_cnt == 0) {
        	alert("한 개 이상의 폰트크기가 있어야합니다.\n폰트크기를 추가해주세요.");
        	return false;
        }
		for(var i=0 ; i<set_font_size_cnt ; i++) {
			var input = document.createElement("input");
			input.setAttribute("type","hidden");
			input.setAttribute("id","font_size");
			input.setAttribute("name","font_size[]");
			input.setAttribute("value",document.getElementById("set_font_size").options[i].value);
			document.getElementById("xml_value").appendChild(input);
		}
		return true;
	}
	
	function editorConfirmMove(){
		self.location = "editor_confirm.jsp";
		return false;
	}
</script>
</head>
<body class="dext5_editor" onload="xmlhttpPostXML('../../config/dext_editor.xml', null, 'xmlAdmin','6');">
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
					<li><a href="fontsize_admin.jsp" class="on">폰트크기 관리</a></li>
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
		<input type="hidden" id="mode" name="mode" value="6"/>
		<div id="xml_value"></div>
			<h2>
				<img src="../../images/admin/dext_img07.gif" width="241" height="16" alt="폰트크기 관리" />
			</h2>
			<p class="dbg"></p>
			<div class="selectbox">
				<div class="fontbox">
					<p class="title"><label for="add_font_size">추가할 폰트크기</label></p>
					<p class="con"><input name="add_font_size" id="add_font_size" type="text" onkeydown="javascript:onlyNumber(event);" maxlength="3"/><span>pt</span></p>
				</div>
				<div class="btn">
					<p class="hm04">
						<a href="javascript:rightExcute();"><span><img src="../../images/admin/dext_arrow02.gif"width="12" height="12" alt="추가할 폰트크기를 현재 적용된 폰트크기로 이동" /></span></a>
					</p>
				</div>
				<div class="select">
					<p class="title"><label for="set_font_size">현재 적용된 폰트크기</label></p>
					<p class="box">
						<select name="set_font_size" id="set_font_size" size="" multiple></select>
					</p>
				</div>
				<div class="btn">
					<p class="hm01">
						<a href="javascript:upExcute(document.getElementById('set_font_size'));" id="top" name="top"><span><img src="../../images/admin/dext_arrow05.gif" width="12" height="12" alt="현재 적용된 상태바메뉴를 위로 이동"/></span></a>
						<a href="javascript:bottomExcute(document.getElementById('set_font_size'));" id="bottom" name="bottom"><span><img src="../../images/admin/dext_arrow06.gif" width="12" height="12" alt="현재 적용된 상태바메뉴를 아래로 이동"/></span></a>
						<a href="javascript:deleteExcute();" class="btt" title="삭제"><span class="text">삭제</span></a>
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