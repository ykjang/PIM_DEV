<%	/**
 	* @File		:	uploader_setting.jsp
 	* @Function	:	관리자 시스템 업로드 환경설정 관리 페이지
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
<title>Dext5 웹에디터 - 관리자페이지 - 업로드 환경설정</title>
<script type="text/javascript">
	function excuteConfirm(){
		return true;
	}
	
	function chkDefaultChangeHandler() {
        if (document.getElementById('chk_handler_url').checked) {
            document.getElementById('handler_url').value = '';
            document.getElementById('handler_url').disabled = 'disabled';
            document.getElementById('span_desc').innerHTML = dext5_admin_lang.upload_url_desc1;
        } else {
            document.getElementById('handler_url').disabled = false;
            document.getElementById('span_desc').innerHTML = dext5_admin_lang.upload_url_desc2;
        }
    }

    function chkDefaultChangeSave() {
        if (document.getElementById('chk_to_save_path_url').checked) {
            document.getElementById('to_save_path_url').value = '';
            document.getElementById('to_save_path_url').disabled = 'disabled';
            document.getElementById('span_desc2').innerHTML = dext5_admin_lang.save_path_desc1;
        } else {
            document.getElementById('to_save_path_url').disabled = false;
            document.getElementById('span_desc2').innerHTML = dext5_admin_lang.save_path_desc2;
        }
    }

	function editorConfirmMove(){
		self.location = "editor_confirm.jsp";
		return false;
	}
</script>
</head>
<body class="dext5_editor" onload="xmlhttpPostXML('../../config/dext_editor.xml', null, 'xmlAdmin','9');">
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
					<li><a href="uploader_setting.jsp" class="on">업로드 환경설정</a></li>
				</ul>
			</div>
		</div>
		<!------------  //Header  ------------->
		<!------------  Content  ------------>
		<div class="content">
		<div class="dh">
		<form name="dext5" method="post" action="excute.jsp" onsubmit="return excuteConfirm();">
		<input type="hidden" id="mode" name="mode" value="9"/>
		<div id="xml_value"></div>
			<h2>
				<img src="../../images/admin/dext_img11.gif" width="241" height="16" alt="업로드 환경설정" />
			</h2>
			<p class="dbg"></p>
			<div class="htb">
				<table cellpadding="0" cellspacing="0" border="0" summary="업로드 환경설정">
					<tr>
						<th width="20%" class="item"><label for="develop_langage">개발 언어 설정</label></th>
						<td width="80%" colspan="3"><select name="develop_langage" id="develop_langage"></select></td>
					</tr>
					<tr>
						<th class="item"><label for="develop_langage">File hendler url 설정</label></th>
						<td colspan="3" style="height:55px;">
                            <label for="chk_handler_url">기본값 사용</label><input type="checkbox" id="chk_handler_url" onchange="javascript:chkDefaultChangeHandler();" checked="checked" class="check" style="margin-left:5px;"/>
                            <input name="handler_url" id="handler_url" type="text" style="margin-bottom:7px;"/><br />
                            <span id="span_desc" style="margin-left:5px; font-size:11px; color:#327cc6;"></span>
                        </td>
					</tr>
					<tr>
						<th class="item"><label for="to_save_path_url">저장 경로 설정</label></th>
						<td colspan="3" style="height:55px;">
                            <label for="chk_to_save_path_url">기본값 사용</label><input type="checkbox" id="chk_to_save_path_url" onchange="javascript:chkDefaultChangeSave();" checked="checked" class="check" style="margin-left:5px;"/>
                            <input name="to_save_path_url" id="to_save_path_url" type="text" style="margin-bottom:7px;"/><br />
                            <span id="span_desc2" style="margin-left:5px; font-size:11px; color:#327cc6;"></span>
                        </td>
					</tr>
					<tr>
						<th class="item"><label for="save_foldername_rule">저장 폴더이름 규칙 설정</label></th>
						<td colspan="3"><select name="save_foldername_rule" id="save_foldername_rule"></select><select name="save_filename_rule" id="save_filename_rule" style="display:none;"></select></td>
					</tr>
					<tr>
						<th class="item"><label for="image_convert_format">이미지 변환 확장자 설정</label></th>
						<td colspan="3"><select name="image_convert_format" id="image_convert_format"></select></td>
					</tr>
					<tr>
						<th class="item"><label for="image_convert_width">이미지 최대 너비 설정</label></th>
						<td><input name="image_convert_width" id="image_convert_width" type="text" class="ipw" onkeydown="javascript:onlyNumber(event);"/> <span><b>px</b></span></td>
						<th class="item"><label for="image_convert_height">이미지 최대 높이 설정</label></th>
						<td><input name="image_convert_height" id="image_convert_height" type="text" class="ipw" onkeydown="javascript:onlyNumber(event);"/> <span><b>px</b></span></td>
					</tr>
				</table>
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