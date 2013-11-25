<%	/**
 	* @File		:	setting.jsp
 	* @Function	:	관리자 시스템 환경설정 관리 페이지
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
	
	String dir = request.getContextPath();
	dir += "dext5/js/lang";
	String real_path = application.getRealPath(dir);
	
	String[] file_list = null;
	java.io.File f = new java.io.File(real_path);
	
	if (f.exists()) {
		
		String[] filelist = f.list();
		file_list = new String[filelist.length];
		
		for (int i=0 ; i<filelist.length ; i++) {
			
			java.io.File f2 = new java.io.File(dir + "/" + filelist[i]);
			String[] split_file_list = (f2.getName()).split("\\.");
			if(split_file_list.length == 2) {
				file_list[i] = split_file_list[0];
			} else {
				for (int j=0; j<file_list.length-1 ; j++) {
					file_list[i] += split_file_list[j];
					if(j != file_list.length-2) {
						file_list[i] += ".";
					}
				}
			}
			
		}
		
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
<title>Dext5 웹에디터 - 관리자페이지 - 환경설정</title>
<script type="text/javascript">
	function skinnameClick(){
		if(document.getElementById("skinname_flag").value == "N") {
			document.getElementById("skinname_flag").value = "Y";
			document.getElementById("skinname_list").style.display = "";
		} else if(document.getElementById("skinname_flag").value == "Y") {
			document.getElementById("skinname_flag").value = "N";
			document.getElementById("skinname_list").style.display = "none";
		}
	}
	
	function gridColorClick(){
		if(document.getElementById("grid_color_flag").value == "N") {
			document.getElementById("grid_color_flag").value = "Y";
			document.getElementById("grid_color_list").style.display = "";
		} else if(document.getElementById("grid_color_flag").value == "Y") {
			document.getElementById("grid_color_flag").value = "N";
			document.getElementById("grid_color_list").style.display = "none";
		}
	}
	
	function gridFormClick(value){
		document.getElementById("grid_form").value = value;
	}
	
	function excuteConfirm(){
		document.getElementById("width").value = document.getElementById("width").value + "px";
		document.getElementById("height").value = document.getElementById("height").value + "px";
		return true;
	}
	
	function editorConfirmMove(){
		self.location = "editor_confirm.jsp";
		return false;
	}
</script>
</head>
<body class="dext5_editor" onload="xmlhttpPostXML('../../config/dext_editor.xml', null, 'xmlAdmin','8');">
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
					<li><a href="setting.jsp" class="on">환경설정</a></li>
					<li><a href="uploader_setting.jsp">업로드 환경설정</a></li>
				</ul>
			</div>
		</div>
		<!------------  //Header  ------------->
		<!------------  Content  ------------>
		<div class="content">
		<div class="dh">
		<form name="dext5" method="post" action="excute.jsp" onsubmit="return excuteConfirm();">
		<input type="hidden" id="mode" name="mode" value="8"/>
		<div id="xml_value"></div>
			<h2>
				<img src="../../images/admin/dext_img06.gif" width="241" height="16" alt="환경설정" />
			</h2>
			<p class="dbg"></p>
			<div class="htb">
				<table cellpadding="0" cellspacing="0" border="0" summary="기본설정">
					<caption>
						<em><img src="../../images/admin/dext_arrow.gif" width="13" height="14" alt=""/>기본설정</em>
					</caption>
					<tr>
						<th width="20%" class="item"><label for="skinname_btn">스킨설정</label></th>
						<td width="30%" class="ipr">
							<div style="z-index:20000; position:relative;">
								<input type="hidden" id="skinname_flag" name="skinname_flag" value="N"/>
								<button class="button" title="스킨설정" type="button" id="skinname_btn" onclick="javascript:skinnameClick();">
									<span class="cr" id="skinname_value"></span><span class="crn" id="skinname_text"></span>
								</button>
								<div id="skinname_list" class="grid" style="z-index: 1; position: absolute; left: 0px; top: 20px; display: none;">
								</div>
							</div>
						</td>
						<th width="20%" class="item"><label for="lang">Editor 언어</label></th>
                        <td width="30%">
							<select name="lang" id="lang">
							<% for(int i=0 ; i<file_list.length ; i++) { %>
	                        	<option value="<%=file_list[i]%>"><%=file_list[i]%></option>
	                        <% } %>
							</select>
						</td>
					</tr>
					<tr>
						<th width="20%" class="item"><label for="width">Editor 너비</label></th>
						<td width="30%"><input name="width" id="width" type="text" class="ipw" onkeydown="javascript:onlyNumber(event);"/> <span><b>px</b></span></td>
						<th width="20%" class="item"><label for="height">Editor 높이</label></th>
						<td width="30%"><input name="height" id="height" type="text" class="ipw" onkeydown="javascript:onlyNumber(event);"/> <span><b>px</b></span></td>
					</tr>
					<tr style="display:none;">
						<th class="item"><label for="enter_tag">Enter 태그</label></th>
						<td><select name="enter_tag" id="enter_tag"></select></td>
						<th class="item"><label for="shift_enter_tag">Shift 태그</label></th>
						<td><select name="shift_enter_tag" id="shift_enter_tag"></select></td>
					</tr>
				</table>
			</div>
			<div class="htb mt">
				<table cellpadding="0" cellspacing="0" border="0" summary="기본폰트 설정">
					<caption>
						<em><img src="../../images/admin/dext_arrow.gif" width="13" height="14" alt=""/>기본폰트 설정</em>
					</caption>
					<tr>
						<th width="20%" class="item"><label for="setting_font_family">폰트종류</label></th>
						<td width="30%"><select name="setting_font_family" id="setting_font_family"></select></td>
						<th width="20%" class="item"><label for="setting_font_size">폰트크기</label></th>
						<td width="30%"><select name="setting_font_size" id="setting_font_size"></select></td>
					</tr>
				</table>
			</div>
			<div class="htb mt">
				<table cellpadding="0" cellspacing="0" border="0" summary="그리드 설정">
					<caption>
						<em><img src="../../images/admin/dext_arrow.gif" width="13" height="14" alt=""/>그리드 설정</em>
					</caption>
					<tr>
						<th width="20%" class="item"><label for="grid_color_btn">그리드 색상</label></th>
						<td width="80%" colspan="3" class="ipr">
							<div style="z-index:10000; position:relative;">
								<input type="hidden" id="grid_color_flag" name="grid_color_flag" value="N"/>
								<button class="button" title="그리드 색상 설정" type="button" id="grid_color_btn" onclick="javascript:gridColorClick();">
									<span class="cr" id="grid_color_value"></span><span class="crn" id="grid_color_text"></span>
								</button>
								<div id="grid_color_list" class="grid" style="z-index: 1; position: absolute; left: 0px; top: 20px; display: none;">
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th width="20%" class="item"><label for="grid_spans">그리드 간격</label></th>
						<td width="30%"><select name="grid_spans" id="grid_spans"></select> <span><b>px</b></span></td>
						<th width="20%" class="item"><label for="grid_form_radio">그리드 모양</label></th>
						<td width="30%" class="ipr">
							<input name="grid_form_radio" id="grid_form_line" type="radio" value="line" onclick="javascript:gridFormClick('line');"/><label for="grid_form_line">선</label>
							<input name="grid_form_radio" id="grid_form_dot" type="radio" value="dot" onclick="javascript:gridFormClick('dot');"/><label for="grid_form_dot">점</label>
						</td>
					</tr>
				</table>
			</div>
			<div class="htb mt">
				<table cellpadding="0" cellspacing="0" border="0" summary="페이지 설정">
					<caption>
						<em><img src="../../images/admin/dext_arrow.gif" width="13" height="14" alt=""/>페이지 설정</em>
					</caption>
					<tr>
						<th width="20%" class="item"><label for="encoding">인코딩</label></th>
						<td width="30%"><select name="encoding" id="encoding"></select></td>
						<th width="20%" class="item"><label for="doctype">문서유형</label></th>
						<td width="30%"><select name="doctype" id="doctype"></select></td>
					</tr>
					<tr>
						<th class="item"><label for="doc_lang">언어</label></th>
						<td colspan="3"><select name="doc_lang" id="doc_lang"></select></td>
					</tr>
				</table>
			</div>
			<div class="htb mt">
				<table cellpadding="0" cellspacing="0" border="0" summary="기타설정">
					<caption>
						<em><img src="../../images/admin/dext_arrow.gif" width="13" height="14" alt="" />기타설정</em>
					</caption>
					<tr>
						<th width="20%" class="item"><label for="accessibility">웹접근성 설정</label></th>
						<td width="30%"><select name="accessibility" id="accessibility"></select></td>
						<th width="20%" class="item"><label for="topmenu">상단메뉴 설정</label></th>
						<td width="30%"><select name="topmenu" id="topmenu"></select></td>
					</tr>
					<tr>
						<th class="item"><label for="toolbar">툴바 설정</label></th>
						<td><select name="toolbar" id="toolbar"></select></td>
						<th class="item"><label for="statusbar">상태바 설정</label></th>
						<td><select name="statusbar" id="statusbar"></select></td>
					</tr>
					<tr>
						<th class="item"><label for="showdialog_pos">팝업창 위치 설정</label></th>
						<td colspan="3"><select name="showdialog_pos" id="showdialog_pos"></select></td>
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