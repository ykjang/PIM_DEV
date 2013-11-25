<%	/**
 	* @File		:	login.aspx
 	* @Function	:	관리자 시스템 로그인 페이지
 	* @Author	:	Dext5 Editor 개발팀
 	* @Created	:	2013.09.13
	* @UpdateHistory
	* ===================================
	* Revision	1.0	2013.09.13	Dext5 Editor 개발팀	최초작성
	* ===================================
	* Copyright(c) 2013 by DEVPIA Corp. All Rights Reserved.
	*/
%>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="dext5_admin_NET_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="IE=edge" http-equiv="X-UA-Compatible" />
<link href="../../css/dext_admin.css" type="text/css" rel="stylesheet" />
<script src="../../js/dext5_admin.js" type="text/javascript"></script>
<title>Dext5 웹에디터 - 관리자페이지 - 로그인</title>
<script type="text/javascript">
    function loginCheck() {

        if (document.getElementById("id").value == "") {
            alert("ID를 입력해주세요.");
            document.getElementById("id").focus();
        } else if (document.getElementById("password").value == "") {
            alert("비밀번호를 입력해주세요.");
            document.getElementById("password").focus();
        } else {
            if (document.getElementById("id_check").checked) {
                setCookieSave("id", document.getElementById("id").value, 7);
            } else {
                setCookieSave("id", document.getElementById("id").value, -1);
            }
            xmlhttpPostXML('login_excute.ashx?id=' + document.getElementById("id").value + '&password=' + Base64.encode(document.getElementById("password").value), null, 'loginExcute', '3');
        }
    }

    function loginExcute(xml) {
        var login = GetNode(xml, "login");
        var result = GetNodeValue(login, "result");
        var message = GetNodeValue(login, "message");
        var id = GetNodeValue(login, "id");
        var password = GetNodeValue(login, "password");

        if (result == "1") {
            alert(message);
            document.getElementById("id").value = "";
            document.getElementById("password").value = "";
            document.getElementById("id").focus();
        } else if (result == "2") {
            alert(message);
            document.getElementById("id").value = id;
            document.getElementById("password").value = "";
            document.getElementById("password").focus();
        } else if (result == "3") {
        
            location.href = "license_admin.aspx";
        }
    }
</script>
</head>
<body class="dext5_editor" onload="javascript:getLoginCookei();">
	<div class="container_login">
		<div class="header_login">
			<div class="top">
				<h1>
					<img src="../../images/admin/dext5_editor_logo.gif" width="239" height="72" alt="DEXT5 Editor" />
				</h1>
			</div>
		</div>
		<div class="content_login">
			<div class="con">
				<div class="con01">
					<h2>
						<img src="../../images/admin/dext_img12.gif" width="410" height="77" alt="DEXT5 Editro 관리자 시스템 로그인" />
					</h2>
					<span><img src="../../images/admin/dext_img13.gif" width="410" height="27" alt="지급된 관리자 아이디와 비밀번호로 로그인하시길 바랍니다." /></span>
				</div>
				<div class="con02"></div>
			</div>
			<div class="login_box">
				<div>
					<img src="../../images/admin/dext_img15.gif" width="326" height="130" alt="Administrator login" />
				</div>
				<div class="login">
					<p>
						<span>
							<label for="id">
								<img src="../../images/admin/dext_img16.gif" width="88" height="24" alt="아이디" />
							</label>
						</span>
						<input name="id" id="id" class="input" type="text"/>
					</p>
					<p>
						<span>
							<label for="password">
								<img src="../../images/admin/dext_img17.gif" width="88" height="24" alt="비밀번호" />
							</label>
						</span> 
						<input name="password" id="password" class="input" type="password"/>
					</p>
					<p class="text">
						<input name="id_check" id="id_check" type="checkbox"/><span><label for="id_check">아이디 저장</label></span>
					</p>
				</div>
				<div class="login_btn">
					<input title="로그인" src="../../images/admin/dext_login_btn.gif" type="image" width="65" height="53" alt="로그인" onclick="javascript:loginCheck();"/>
				</div>
			</div>
		</div>
		<div class="footer_login">
			<p>
				<img src="../../images/admin/devpia_logo.gif" width="102" height="24" alt="DEVPIA" />
				<span class="copyright">Copyrightⓒ DEVPIA & RAONWiZ TECHNOLOGY INC. All right reserved.</span>
				<img src="../../images/admin/raonwiz_logo.gif" width="102" height="24" alt="RAONWIZ" />
			</p>
		</div>
	</div>
</body>
</html>