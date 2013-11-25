<%	/**
 	* @File		:	editor_confirm.aspx
 	* @Function	:	관리자 시스템 에디터 확인 페이지
 	* @Author	:	Dext5 Editor 개발팀
 	* @Created	:	2013.09.13
	* @UpdateHistory
	* ===================================
	* Revision	1.0	2013.09.13	Dext5 Editor 개발팀	최초작성
	* ===================================
	* Copyright(c) 2013 by DEVPIA Corp. All Rights Reserved.
	*/
%>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editor_confirm.aspx.cs" Inherits="dext5_admin_NET_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="IE=edge" http-equiv="X-UA-Compatible" />
<link href="../../css/dext_admin.css" type="text/css" rel="stylesheet" />
<script src="../../js/dext5editor.js" type="text/javascript"></script>
<title>Dext5 웹에디터 - 관리자페이지 - Editor 확인</title>
</head>
<body class="dext5_editor">
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
					<li><a href="fontfamily_admin.aspx">폰트종류 관리</a></li>
					<li><a href="setting.aspx">환경설정</a></li>
					<li><a href="uploader_setting.aspx">업로드 환경설정</a></li>
				</ul>
			</div>
		</div>
		<div class="content">
        <div class="dh">
            <h2>
				<img src="../../images/admin/dext_img08.gif" width="241" height="16" alt="Editor 확인" />
			</h2>
			<p class="dbg"></p>
			<div class="htb">
				<script type="text/javascript">
				    DEXT5.config.Height = "600px";
				    DEXT5.config.Width = "100%";
				    //DEXT5.config.InitXml = "";   // ex)  DEXT5.config.InitXml = "dext_editor_mobile.xml"; //config 폴더 안의 파일 이름만 지정
				    var editor1 = new Dext5editor("editor1");
				
				</script>
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
