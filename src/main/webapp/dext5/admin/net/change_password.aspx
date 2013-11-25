<%	/**
 	* @File		:	license_admin.aspx
 	* @Function	:	관리자 시스템 로그인 실행 페이지
 	* @Author	:	Dext5 Editor 개발팀
 	* @Created	:	2013.09.13
	* @UpdateHistory
	* ===================================
	* Revision	1.0	2013.09.13	Dext5 Editor 개발팀	최초작성
	* ===================================
	* Copyright(c) 2013 by DEVPIA Corp. All Rights Reserved.
	*/
%>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="change_password.aspx.cs" Inherits="dext5_admin_NET_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="IE=edge" http-equiv="X-UA-Compatible" />
<link href="../../css/dext_admin.css" type="text/css" rel="stylesheet" />
<script src="../../js/dext5_admin.js" type="text/javascript"></script>
<title>Dext5 웹에디터 - 관리자페이지 - 비밀번호 변경</title>
<script type="text/javascript">
    function loginCheck() {
        if (document.getElementById("password").value == "") {
            alert("현재 비밀번호를 입력해주세요.");
            document.getElementById("password").focus();
        } else if (document.getElementById("new_pw").value == "") {
            alert("새 비밀번호를 입력해주세요.");
            document.getElementById("new_pw").focus();
        } else if (document.getElementById("confirm_pw").value == "") {
            alert("비밀번호 확인을 입력해주세요.");
            document.getElementById("confirm_pw").focus();
        } else if (document.getElementById("new_pw").value != document.getElementById("confirm_pw").value) {
            alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            document.getElementById("confirm_pw").focus();
        } else {
            xmlhttpPostXML('change_excute.ashx?password=' + Base64.encode(document.getElementById("password").value) + '&new_pw=' + Base64.encode(document.getElementById("new_pw").value), null, 'changeExcute', '3');
        }
    }

    function changeExcute(xml) {
        var change = GetNode(xml, "change");
        var result = GetNodeValue(change, "result");
        var message = GetNodeValue(change, "message");
        if (result == '1') {
            alert(message);
            document.getElementById("password").value = '';
            document.getElementById("password").focus();
        } else if (result == '2') {
            alert(message);
            document.getElementById("password").value = '';
            document.getElementById("new_pw").value = '';
            document.getElementById("confirm_pw").value = '';
            document.getElementById("password").focus();
        } else if(result == '3'){
            self.location.href = "login.aspx";
        }
    }
</script>
</head>
<body class="dext5_editor">
	<div class="container">
		<div class="header">
			<div class="top">
				<h1>
					<img src="../../images/admin/dext_img.png" class="img" width="223" height="28" alt="DEXT5 Editor 관리자 시스템" />
				</h1>
			</div>
			<div class="top_menu">
				<ul>
					<li><a href="license_admin.aspx" style="margin-left: 0;">라이선스 관리</a></li>
					<li><a href="topmenu_admin.aspx">상단메뉴 관리</a></li>
					<li><a href="toolbar_admin.aspx">툴바 관리</a></li>
					<li><a href="statusbar_admin.aspx">상태바 관리</a></li>
					<li><a href="removeitem_admin.aspx">제거항목 관리</a></li>
					<li><a href="fontsize_admin.aspx">폰트크기 관리</a></li>
					<li><a href="fontfamily_admin.aspx">폰트종류 관리</a></li>
					<li><a href="setting.aspx">환경설정</a></li>
					<li><a href="uploader_setting.aspx">업로드 환경설정</a></li>
				</ul>
			</div>
		</div>
		<div class="content">
        <div class="dh">
			<h2>
				<img src="../../images/admin/dext_img18.gif" width="241" height="16" alt="비밀번호 변경" />
			</h2>
			<p class="dbg"></p>
			<div class="htb">
				<table cellpadding="0" cellspacing="0" border="0" summary="비밀번호 변경">
					<tr>
						<th width="22%" class="item"><label for="product_key">ID</label></th>
						<td width="78%">
							<input name="id" id="id" type="text" value="admin" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th class="item"><label for="license_key">현재 비밀번호</label></th>
						<td><input name="password" id="password" type="password"/></td>
					</tr>
                    <tr>
						<th class="item"><label for="license_key">새 비밀번호</label></th>
						<td><input name="new_pw" id="new_pw" type="password"/></td>
					</tr>
                    <tr>
						<th class="item"><label for="license_key">비밀번호 확인</label></th>
						<td><input name="confirm_pw" id="confirm_pw" type="password"/></td>
					</tr>
				</table>
			</div>
			<div class="bottom_btn">
				<ul>
					<li>
						<input type="button" title="변경" class="button" value="변경" onclick="javascript:loginCheck();"/>
					</li>
				</ul>
			</div>
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
