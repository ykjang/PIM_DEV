<? 
session_id("dext5editor");
session_start(); 
?>
<? /**
 	* @File		:	topmenu_admin.php
 	* @Function	:	관리자 시스템 로그인 페이지
 	* @Author	:	Dext5 Editor 개발팀
 	* @Created	:	2013.09.13
	* @UpdateHistory
	* ===================================
	* Revision	1.0	2013.09.13	Dext5 Editor 개발팀	최초작성
	* ===================================
	* Copyright(c) 2013 by DEVPIA Corp. All Rights Reserved.
	*/
?>
<?

    $id = $_SESSION['id'];
    if($id == null) {
	    $id = "";
    }
     if($id != "admin") {
        header("Location: login.php"); exit;
     }
    $page_mode = $_REQUEST[page_mode];
    
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="IE=edge" http-equiv="X-UA-Compatible" />
<link href="../../css/dext_admin.css" type="text/css" rel="stylesheet" />
<script src="../../js/dext5_admin.js" type="text/javascript"></script>
<script src="../../js/admin/admin_ko.js" type="text/javascript"></script>
<title>Dext5 웹에디터 - 관리자페이지 - 상단메뉴 관리</title>
<script type="text/javascript">
    function topmenuNoneClick(check) {
        if (check) {
            document.getElementById("all_menu").disabled = true;
            document.getElementById("set_menu").disabled = true;
            document.getElementById("all_right").style.display = "none";
            document.getElementById("right").style.display = "none";
            document.getElementById("all_left").style.display = "none";
            document.getElementById("left").style.display = "none";
            document.getElementById("top").style.display = "none";
            document.getElementById("bottom").style.display = "none";
        } else {
            document.getElementById("all_menu").disabled = false;
            document.getElementById("set_menu").disabled = false;
            document.getElementById("all_right").style.display = "";
            document.getElementById("right").style.display = "";
            document.getElementById("all_left").style.display = "";
            document.getElementById("left").style.display = "";
            document.getElementById("top").style.display = "";
            document.getElementById("bottom").style.display = "";
        }
    }

    function excuteConfirm() {
        if (document.getElementById("topmenu_none").checked) {
            document.getElementById("topmenu").value = 1;
            var top_menu_pre_cnt = document.getElementsByName("top_menu_pre").length;
            for (var i = 0; i < top_menu_pre_cnt; i++) {
                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("id", "top_menu");
                input.setAttribute("name", "top_menu[]");
                input.setAttribute("value", document.getElementsByName("top_menu_pre")[i].value);
                document.getElementById("xml_value").appendChild(input);
            }
        } else {
            document.getElementById("topmenu").value = 0;
            var set_menu_cnt = document.getElementById("set_menu").length;
			if(set_menu_cnt == 0) {
            	alert("한 개 이상의 상단메뉴가 있어야합니다.\n상단메뉴를 추가해주세요.");
            	return false;
            }
            for (var i = 0; i < set_menu_cnt; i++) {
                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("id", "top_menu");
                input.setAttribute("name", "top_menu[]");
                input.setAttribute("value", document.getElementById("set_menu").options[i].value);
                document.getElementById("xml_value").appendChild(input);
            }
        }
        return true;
    }

    function editorConfirmMove() {
        self.location = "editor_confirm.php";
        return false;
    }
</script>
</head>
<body class="dext5_editor" onload="xmlhttpPostXML('../../config/dext_editor.xml', null, 'xmlAdmin','2');">
	<div class="container">
		<div class="header">
			<div class="top">
				<h1>
					<img src="../../images/admin/dext_img.png" class="img" width="223" height="28" alt="DEXT5 Editor 관리자 시스템" />
				</h1>
                <span class="top_btn"><a href="change_password.php">비밀번호 변경</a><img src="../../images/admin/dext_img01.gif" width="1" height="10" alt=""/><a href="logout_excute.php" class="bri">로그아웃</a></span>
			</div>
			<div class="top_menu">
				<ul>
                    <li><a href="license_admin.php" style="margin-left: 0;">라이선스 관리</a></li>
					<li><a href="topmenu_admin.php" class="on">상단메뉴 관리</a></li>
					<li><a href="toolbar_admin.php">툴바 관리</a></li>
					<li><a href="statusbar_admin.php">상태바 관리</a></li>
					<li><a href="removeitem_admin.php">제거항목 관리</a></li>
					<li><a href="fontsize_admin.php">폰트크기 관리</a></li>
					<li><a href="fontfamily_admin.php">폰트종류 관리</a></li>
					<li><a href="setting.php">환경설정</a></li>
					<li><a href="uploader_setting.php">업로드 환경설정</a></li>
				</ul>
			</div>
		</div>
		<!------------  Content  ------------>
		<div class="content">
        <div class="dh">
		<form name="dext5" method="post" action="excute.php" onsubmit="return excuteConfirm();">
		<input type="hidden" id="mode" name="mode" value="2"/>
		<div id="xml_value"></div>
			<h2>
				<img src="../../images/admin/dext_img02.gif" width="241" height="16" alt="상단메뉴 관리" />
			</h2>
			<p class="dbg"></p>
			<p class="check_box">
				<input id="topmenu_none" name="topmenu_none" type="checkbox" onclick="javascript:topmenuNoneClick(this.checked);"/><span><label for="topmenu_none">상단메뉴 사용하지 않기</label></span>
			</p>
			<div class="selectbox">
				<div class="select">
					<p class="title"><label for="all_menu">사용가능 상단메뉴</label></p>
					<p class="box">
						<select name="all_menu" id="all_menu" size="" multiple></select>
					</p>
				</div>
				<div class="btn">
					<p class="hm">
						<a href="javascript:move_all_option(document.getElementById('all_menu'), document.getElementById('set_menu'));" id="all_right" name="all_right"><span><img src="../../images/admin/dext_arrow01.gif" width="12" height="12" alt="사용가능 상단메뉴를 현재 적용된 상단메뉴로 모두 이동"/></span></a>
						<a href="javascript:move_option(document.getElementById('all_menu'), document.getElementById('set_menu'));" id="right" name="right"><span><img src="../../images/admin/dext_arrow02.gif" width="12" height="12" alt="사용가능 상단메뉴를 현재 적용된 상단메뉴로 이동"/></span></a>
					</p>
					<p class="hm">
						<a href="javascript:move_all_option(document.getElementById('set_menu'), document.getElementById('all_menu'));" id="all_left" name="all_left"><span><img src="../../images/admin/dext_arrow03.gif" width="12" height="12" alt="현재 적용된 상단메뉴를 모두 제거"/></span></a>
						<a href="javascript:move_option(document.getElementById('set_menu'), document.getElementById('all_menu'));" id="left" name="left"><span><img src="../../images/admin/dext_arrow04.gif" width="12" height="12" alt="현재 적용된 상단메뉴를 제거"/></span></a>
					</p>
				</div>
				<div class="select">
					<p class="title"><label for="set_menu">현재 적용된 상단메뉴</label></p>
					<p class="box">
						<select name="set_menu" id="set_menu" size="" multiple></select>
					</p>
				</div>
				<div class="btn">
					<p class="hm01">
						<a href="javascript:upExcute(document.getElementById('set_menu'));" id="top" name="top"><span><img src="../../images/admin/dext_arrow05.gif" width="12" height="12" alt="현재 적용된 상단메뉴를 위로 이동"/></span></a>
						<a href="javascript:bottomExcute(document.getElementById('set_menu'));" id="bottom" name="bottom"><span><img src="../../images/admin/dext_arrow06.gif" width="12" height="12" alt="현재 적용된 상단메뉴를 아래로 이동"/></span></a>
					</p>
				</div>
			</div>
			<div class="bottom_btn">
				<ul>
					<li>
						<button type="submit" class="button">적용</button>
					</li>
				<? if($page_mode == "excute") { ?>
					<li>
						<button type="button" class="button" onclick="javascript:return editorConfirmMove();">Editor 확인</button>
					</li>
				<? } ?>
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
