<%	/**
 	* @File		:	fontfamily_admin.aspx
 	* @Function	:	관리자 시스템 글꼴 폰트종류 관리 페이지
 	* @Author	:	Dext5 Editor 개발팀
 	* @Created	:	2013.09.13
	* @UpdateHistory
	* ===================================
	* Revision	1.0	2013.09.13	Dext5 Editor 개발팀	최초작성
	* ===================================
	* Copyright(c) 2013 by DEVPIA Corp. All Rights Reserved.
	*/
%>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fontfamily_admin.aspx.cs" Inherits="dext5_admin_NET_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="IE=edge" http-equiv="X-UA-Compatible" />
<link href="../../css/dext_admin.css" type="text/css" rel="stylesheet" />
<script src="../../js/dext5_admin.js" type="text/javascript"></script>
<script src="../../js/admin/admin_ko.js" type="text/javascript"></script>
<title>Dext5 웹에디터 - 관리자페이지 - 폰트종류 관리</title>
<script type="text/javascript">
    function rightExcute() {
        var add_font_name = document.getElementById("add_font_name").value;
        if (add_font_name == "") {
            alert("추가할 폰트를 입력해주세요.");
            document.getElementById("add_font_name").focus();
        } else {
            
            var set_font_name_cnt = document.getElementById("add_font_name").length;
            var set_font_name_check = false;
            for (var i = 0; i < set_font_name_cnt; i++) {
                if (document.getElementById("set_font_family").options[i].value == add_font_name) {
                    set_font_name_check = true;
                }
            }
            if (!set_font_name_check) {
                var option = document.createElement("option");
                option.setAttribute("value", add_font_name);
                option.innerHTML = add_font_name;
                document.getElementById("set_font_family").appendChild(option);
            }
        }
    }

    function excuteConfirm() {
        var set_font_family_cnt = document.getElementById("set_font_family").length;
        if (set_font_family_cnt == 0) {
            alert("한 개 이상의 폰트종류가 있어야합니다.\n폰트종류를 추가해주세요.");
            return false;
        }
        for (var i = 0; i < set_font_family_cnt; i++) {
            var input = document.createElement("input");
            input.setAttribute("type", "hidden");
            input.setAttribute("id", "font_family");
            input.setAttribute("name", "font_family[]");
            input.setAttribute("value", document.getElementById("set_font_family").options[i].value);
            document.getElementById("xml_value").appendChild(input);
        }
        return true;
    }

    function editorConfirmMove() {
        self.location = "editor_confirm.aspx";
        return false;
    }

    function move_left_click() {
        var opt = null;

        for (var i = 0; i < document.getElementById('set_font_family').length; i++) {
            if (document.getElementById('set_font_family').options[i].value == 'design') {
                document.getElementById('set_font_family').options[i].selected = false;
            }
        }
        move_option(document.getElementById('set_font_family'), document.getElementById('all_font_family'));
    }
</script>
</head>
<body class="dext5_editor" onload="xmlhttpPostXML('../../config/dext_editor.xml', null, 'xmlAdmin','7');">
	<div class="container">
		<div class="header">
			<div class="top">
				<h1>
					<img src="../../images/admin/dext_img.png" class="img" width="223" height="28" alt="DEXT5 Editor 관리자 시스템" />
				</h1>
                <span class="top_btn"><a href="change_password.aspx">비밀번호 변경</a><img src="../../images/admin/dext_img01.gif" width="1" height="10" alt=""/><a href="logout_excute.ashx" class="bri">로그아웃</a></span>
			</div>
			<div class="top_menu">
				<ul>
					<li><a href="license_admin.aspx" style="margin-left: 0;">라이선스 관리</a></li>
					<li><a href="topmenu_admin.aspx">상단메뉴 관리</a></li>
					<li><a href="toolbar_admin.aspx">툴바 관리</a></li>
					<li><a href="statusbar_admin.aspx">상태바 관리</a></li>
					<li><a href="removeitem_admin.aspx">제거항목 관리</a></li>
					<li><a href="fontsize_admin.aspx">폰트크기 관리</a></li>
					<li><a href="fontfamily_admin.aspx" class="on">폰트종류 관리</a></li>
					<li><a href="setting.aspx">환경설정</a></li>
					<li><a href="uploader_setting.aspx">업로드 환경설정</a></li>
				</ul>
			</div>
		</div>
		<div class="content">
        <div class="dh">
		<form name="dext5" method="post" action="excute.aspx" onsubmit="return excuteConfirm();">
		<input type="hidden" id="mode" name="mode" value="7"/>
		<div id="xml_value"></div>
			<h2>
				<img src="../../images/admin/dext_img10.gif" width="241" height="16" alt="폰트종류 관리" />
			</h2>
			<p class="dbg"></p>
            <div class="selectbox">
				<div style="width:350px;">
				<div class="select">
					<p class="title"><label for="all_font_family">사용가능 폰트종류</label></p>
					<p class="box02">
						<select name="all_font_family" id="all_font_family" size="" multiple></select>
					</p>
				</div>
				<div class="fontbox">
					<p class="title"><label for="add_font_name">추가할 폰트종류</label></p>
					<p class="con"><input name="add_font_name" id="add_font_name" type="text"/></p>
				</div>
				</div>
				<div class="sbox02"> 
				<div class="btn">
					<p class="hm02">
						<a href="javascript:move_all_option(document.getElementById('all_font_family'), document.getElementById('set_font_family'));" id="all_right" name="all_right"><span><img src="../../images/admin/dext_arrow01.gif" width="12" height="12" alt="사용가능 폰트종류를 현재 적용된 폰트종류로 모두 이동"/></span></a>
						<a href="javascript:move_option(document.getElementById('all_font_family'), document.getElementById('set_font_family'));" id="right" name="right"><span><img src="../../images/admin/dext_arrow02.gif" width="12" height="12" alt="사용가능 폰트종류를 현재 적용된 폰트종류로 이동"/></span></a>
					</p>
					<p class="hm02">
						<a href="javascript:move_all_option(document.getElementById('set_font_family'), document.getElementById('all_font_family'));" id="all_left" name="all_left"><span><img src="../../images/admin/dext_arrow03.gif" width="12" height="12" alt="현재 적용된 폰트종류를 모두 제거"/></span></a>
						<a href="javascript:move_left_click();" id="left" name="left"><span><img src="../../images/admin/dext_arrow04.gif" width="12" height="12" alt="현재 적용된 폰트종류를 제거"/></span></a>
					</p>
					<p class="hm05">
						<a href="javascript:rightExcute();"><span><img src="../../images/admin/dext_arrow02.gif"width="12" height="12" alt="추가할 폰트종류를 현재 적용된 폰트종류로 이동" /></span></a>
					</p>
				</div>
				<div class="select">
					<p class="title"><label for="set_font_family">현재 적용된 폰트종류</label></p>
					<p class="box01">
						<select name="set_font_family" id="set_font_family" size="" multiple></select>
					</p>
				</div>
				<div class="btn">
					<p class="hm06">
						<a href="javascript:upExcute(document.getElementById('set_font_family'));" id="top" name="top"><span><img src="../../images/admin/dext_arrow05.gif" width="12" height="12" alt="현재 적용된 상태바메뉴를 위로 이동"/></span></a>
						<a href="javascript:bottomExcute(document.getElementById('set_font_family'));" id="bottom" name="bottom"><span><img src="../../images/admin/dext_arrow06.gif" width="12" height="12" alt="현재 적용된 상태바메뉴를 아래로 이동"/></span></a>
					</p>
				</div>
				</div>
			</div>
			<div class="bottom_btn">
				<ul>
					<li>
						<button type="submit" class="button">적용</button>
					</li>
				<% if (page_mode.Equals("excute")) { %>
					<li>
						<button type="button" class="button" onclick="javascript:return editorConfirmMove();">Editor 확인</button>
					</li>
				<% } %>
				</ul>
			</div>
		</form>
        </div>
		</div>
		<div class="footer">
			<p>
				<img src="../../images/admin/devpia_logo.gif" width="102" height="24" alt="DEVPIA" />
				<span class="copyright">Copyrightⓒ DEVPIA & RAONWiZ TECHNOLOGY INC. All right reserved.</span>
				<img src="../../images/admin/raonwiz_logo.gif" width="102" height="24" alt="RAONWIZ" />
			</p>
		</div>
	</div>
</body>
</html>
