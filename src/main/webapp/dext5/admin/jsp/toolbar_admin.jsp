<%	/**
 	* @File		:	toolbar_admin.jsp
 	* @Function	:	관리자 시스템 툴바 관리 페이지
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
<title>Dext5 웹에디터 - 관리자페이지 - 툴바 관리</title>
<script type="text/javascript">
	function toolbar1NoneClick(check) {
        if (check) {
            if (document.getElementById("toolbar2_none").checked) {
                document.getElementById("all_menu").disabled = true;
            }
            document.getElementById("set_menu1").disabled = true;
            document.getElementById("all_right1").style.display = "none";
            document.getElementById("right1").style.display = "none";
            document.getElementById("all_left1").style.display = "none";
            document.getElementById("left1").style.display = "none";
            document.getElementById("top1").style.display = "none";
            document.getElementById("bottom1").style.display = "none";
        } else {
            document.getElementById("all_menu").disabled = false;
            document.getElementById("set_menu1").disabled = false;
            document.getElementById("all_right1").style.display = "";
            document.getElementById("right1").style.display = "";
            document.getElementById("all_left1").style.display = "";
            document.getElementById("left1").style.display = "";
            document.getElementById("top1").style.display = "";
            document.getElementById("bottom1").style.display = "";
        }
    }

    function toolbar2NoneClick(check) {
        if (check) {
            if (document.getElementById("toolbar1_none").checked) {
                document.getElementById("all_menu").disabled = true;
            }
            document.getElementById("set_menu2").disabled = true;
            document.getElementById("all_right2").style.display = "none";
            document.getElementById("right2").style.display = "none";
            document.getElementById("all_left2").style.display = "none";
            document.getElementById("left2").style.display = "none";
            document.getElementById("top2").style.display = "none";
            document.getElementById("bottom2").style.display = "none";
        } else {
            document.getElementById("all_menu").disabled = false;
            document.getElementById("set_menu2").disabled = false;
            document.getElementById("all_right2").style.display = "";
            document.getElementById("right2").style.display = "";
            document.getElementById("all_left2").style.display = "";
            document.getElementById("left2").style.display = "";
            document.getElementById("top2").style.display = "";
            document.getElementById("bottom2").style.display = "";
        }
    }

    function move_left(firstObj, secondObj) {
        var opt_arr = [];
        for (var i = 0; i < firstObj.length; i++) {
            if (firstObj.options[i].selected == true && firstObj.options[i].value == 'separator') {
                opt_arr.push(firstObj.options[i]);
            }
            if (i == (firstObj.length - 1)) {
                for (var j = 0; j < opt_arr.length; j++) {
                    firstObj.removeChild(opt_arr[j]);
                }
            }
        }
        move_option(firstObj, secondObj);
    }

    function move_all_left(firstObj, secondObj) {
        var opt_arr = [];
        for (var i = 0; i < firstObj.length; i++) {
            if (firstObj.options[i].value == 'separator') {
                opt_arr.push(firstObj.options[i]);
            }
            if (i == (firstObj.length-1)) {
                for (var j = 0; j < opt_arr.length; j++) {
                    firstObj.removeChild(opt_arr[j]);
                }
            }
        }
        move_all_option(firstObj, secondObj);
    }

    function excuteConfirm() {
        if (!document.getElementById("toolbar1_none").checked && !document.getElementById("toolbar2_none").checked) {
            document.getElementById("toolbar").value = 0;
            var set_menu_cnt = document.getElementById("set_menu1").length;
			if(set_menu_cnt == 0) {
            	alert("한 개 이상의 1번 툴바메뉴가 있어야합니다.\n1번 툴바메뉴를 추가해주세요.");
            	return false;
            }
            for (var i = 0; i < set_menu_cnt; i++) {
                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("id", "tool_bar_1");
                input.setAttribute("name", "tool_bar_1[]");
                input.setAttribute("value", document.getElementById("set_menu1").options[i].value);
                document.getElementById("xml_value").appendChild(input);
            }
            set_menu_cnt = document.getElementById("set_menu2").length;
			if(set_menu_cnt == 0) {
            	alert("한 개 이상의 2번 툴바메뉴가 있어야합니다.\n2번 툴바메뉴를 추가해주세요.");
            	return false;
            }
            for (var i = 0; i < set_menu_cnt; i++) {
                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("id", "tool_bar_2");
                input.setAttribute("name", "tool_bar_2[]");
                input.setAttribute("value", document.getElementById("set_menu2").options[i].value);
                document.getElementById("xml_value").appendChild(input);
            }
        } else if (!document.getElementById("toolbar1_none").checked && document.getElementById("toolbar2_none").checked) {
            document.getElementById("toolbar").value = 2;
            var set_menu_cnt = document.getElementById("set_menu1").length;
			if(set_menu_cnt == 0) {
            	alert("한 개 이상의 1번 툴바메뉴가 있어야합니다.\n1번 툴바메뉴를 추가해주세요.");
            	return false;
            }
            for (var i = 0; i < set_menu_cnt; i++) {
                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("id", "tool_bar_1");
                input.setAttribute("name", "tool_bar_1[]");
                input.setAttribute("value", document.getElementById("set_menu1").options[i].value);
                document.getElementById("xml_value").appendChild(input);
            }
            var tool_bar_pre_cnt = document.getElementsByName("tool_bar_2_pre").length;
            for (var i = 0; i < tool_bar_pre_cnt; i++) {
                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("id", "tool_bar_2");
                input.setAttribute("name", "tool_bar_2[]");
                input.setAttribute("value", document.getElementsByName("tool_bar_2_pre")[i].value);
                document.getElementById("xml_value").appendChild(input);
            }
        } else if (document.getElementById("toolbar1_none").checked && !document.getElementById("toolbar2_none").checked) {
            document.getElementById("toolbar").value = 1;
            var tool_bar_pre_cnt = document.getElementsByName("tool_bar_1_pre").length;
            for (var i = 0; i < tool_bar_pre_cnt; i++) {
                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("id", "tool_bar_1");
                input.setAttribute("name", "tool_bar_1[]");
                input.setAttribute("value", document.getElementsByName("tool_bar_1_pre")[i].value);
                document.getElementById("xml_value").appendChild(input);
            }
            var set_menu_cnt = document.getElementById("set_menu2").length;
			if(set_menu_cnt == 0) {
            	alert("한 개 이상의 2번 툴바메뉴가 있어야합니다.\n2번 툴바메뉴를 추가해주세요.");
            	return false;
            }
            for (var i = 0; i < set_menu_cnt; i++) {
                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("id", "tool_bar_2");
                input.setAttribute("name", "tool_bar_2[]");
                input.setAttribute("value", document.getElementById("set_menu2").options[i].value);
                document.getElementById("xml_value").appendChild(input);
            }
        } else {
            document.getElementById("toolbar").value = 3;
            var tool_bar_pre_cnt = document.getElementsByName("tool_bar_1_pre").length;
            for (var i = 0; i < tool_bar_pre_cnt; i++) {
                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("id", "tool_bar_1");
                input.setAttribute("name", "tool_bar_1[]");
                input.setAttribute("value", document.getElementsByName("tool_bar_1_pre")[i].value);
                document.getElementById("xml_value").appendChild(input);
            }
            tool_bar_pre_cnt = document.getElementsByName("tool_bar_2_pre").length;
            for (var i = 0; i < tool_bar_pre_cnt; i++) {
                var input = document.createElement("input");
                input.setAttribute("type", "hidden");
                input.setAttribute("id", "tool_bar_2");
                input.setAttribute("name", "tool_bar_2[]");
                input.setAttribute("value", document.getElementsByName("tool_bar_2_pre")[i].value);
                document.getElementById("xml_value").appendChild(input);
            }
        }
        return true;
    }

    function editorConfirmMove() {
        self.location = "editor_confirm.jsp";
        return false;
    }
</script>
</head>
<body class="dext5_editor" onload="xmlhttpPostXML('../../config/dext_editor.xml', null, 'xmlAdmin','3');">
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
					<li><a href="toolbar_admin.jsp" class="on">툴바 관리</a></li>
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
		<div class="dh">
		<form name="dext5" method="post" action="excute.jsp" onsubmit="return excuteConfirm();">
		<input type="hidden" id="mode" name="mode" value="3"/>
		<div id="xml_value"></div>
			<h2>
				<img src="../../images/admin/dext_img04.gif" width="241" height="16" alt="툴바 관리" />
			</h2>
			<p class="dbg"></p>
			<p class="check_box">
				<input id="toolbar1_none" name="toolbar1_none" type="checkbox" onclick="javascript:toolbar1NoneClick(this.checked);"/>
				<span><label for="toolbar1_none">1번 툴바 사용하지 않기</label></span>
				<input id="toolbar2_none" name="toolbar2_none" type="checkbox" onclick="javascript:toolbar2NoneClick(this.checked);"/>
				<span><label for="toolbar2_none">2번 툴바 사용하지 않기</label></span>
			</p>
			<div class="selectbox">
				<div class="select">
					<p class="title">
						<label for="all_menu">사용가능 툴바메뉴</label>
					</p>
					<p class="box01">
						<select name="all_menu" id="all_menu" multiple>
						</select>
					</p>
				</div>
				<!------------  1번 툴바 적용 항목  ------------>
				<div class="sbox01">
					<div class="btn">
						<p class="hm02">
							<a href="javascript:move_all_option(document.getElementById('all_menu'), document.getElementById('set_menu1'), 'separator');" id="all_right1" name="all_right1">
								<span><img src="../../images/admin/dext_arrow01.gif" width="12" height="12" alt="사용가능 툴바메뉴를 현재 적용된 1번 툴바메뉴로 모두 이동" /></span>
							</a>
							<a href="javascript:move_option(document.getElementById('all_menu'), document.getElementById('set_menu1'), 'separator');" id="right1" name="right1">
								<span><img src="../../images/admin/dext_arrow02.gif" width="12" height="12" alt="사용가능 툴바메뉴를 현재 적용된 1번 툴바메뉴로 이동" /></span>
							</a>
						</p>
						<p class="hm02">
							<a href="javascript:move_all_left(document.getElementById('set_menu1'), document.getElementById('all_menu'));" id="all_left1" name="all_left1">
								<span><img src="../../images/admin/dext_arrow03.gif" width="12" height="12" alt="현재 적용된 1번 툴바메뉴를 모두 제거" /></span>
							</a>
							<a href="javascript:move_left(document.getElementById('set_menu1'), document.getElementById('all_menu'));" id="left1" name="left1">
								<span><img src="../../images/admin/dext_arrow04.gif" width="12" height="12" alt="현재 적용된 1번 툴바메뉴를 제거" /></span>
							</a>
						</p>
					</div>
					<div class="select">
						<p class="title">
							<label for="set_menu1">현재 적용된 1번 툴바메뉴</label>
						</p>
						<p class="box02">
							<select name="set_menu1" id="set_menu1" size="" multiple class="se">
							</select>
						</p>
					</div>
					<div class="btn">
						<p class="hm03">
							<a href="javascript:upExcute(document.getElementById('set_menu1'));" id="top1" name="top1">
								<span><img src="../../images/admin/dext_arrow05.gif" width="12" height="12" alt="현재 적용된 1번 툴바메뉴를 위로 이동" /></span>
							</a>
							<a href="javascript:bottomExcute(document.getElementById('set_menu1'));" id="bottom1" name="bottom1">
								<span><img src="../../images/admin/dext_arrow06.gif" width="12" height="12" alt="현재 적용된 1번 툴바메뉴를 아래로 이동" /></span>
							</a>
						</p>
					</div>
				</div>

				<!------------  2번 툴바 적용 항목  ------------>
				<div class="sbox02">
					<div class="btn">
						<p class="hm02">
							<a href="javascript:move_all_option(document.getElementById('all_menu'), document.getElementById('set_menu2'), 'separator');" id="all_right2" name="all_right2">
								<span><img src="../../images/admin/dext_arrow01.gif" width="12" height="12" alt="사용가능 툴바메뉴를 현재 적용된 2번 툴바메뉴로 모두 이동" /></span>
							</a>
							<a href="javascript:move_option(document.getElementById('all_menu'), document.getElementById('set_menu2'), 'separator');" id="right2" name="right2">
								<span><img src="../../images/admin/dext_arrow02.gif" width="12" height="12" alt="사용가능 툴바메뉴를 현재 적용된 2번 툴바메뉴로 이동" /></span>
							</a>
						</p>
						<p class="hm02">
							<a href="javascript:move_all_left(document.getElementById('set_menu2'), document.getElementById('all_menu'));" id="all_left2" name="all_left2">
								<span><img src="../../images/admin/dext_arrow03.gif" width="12" height="12" alt="현재 적용된 2번 툴바메뉴를 모두 제거" /></span>
							</a>
							<a href="javascript:move_left(document.getElementById('set_menu2'), document.getElementById('all_menu'));" id="left2" name="left2">
								<span><img src="../../images/admin/dext_arrow04.gif" width="12" height="12" alt="현재 적용된 2번 툴바메뉴를 제거" /></span></a>
						</p>
					</div>
					<div class="select">
						<p class="title">
							<label for="set_menu2">현재 적용된 2번 툴바메뉴</label>
						</p>
						<p class="box02">
							<select name="set_menu2" id="set_menu2" size="" multiple></select>
						</p>
					</div>
					<div class="btn">
						<p class="hm03">
							<a href="javascript:upExcute(document.getElementById('set_menu2'));" id="top2" name="top2">
								<span><img src="../../images/admin/dext_arrow05.gif" width="12" height="12" alt="현재 적용된 2번 툴바메뉴를 위로 이동" /></span>
							</a>
							<a href="javascript:bottomExcute(document.getElementById('set_menu2'));" id="bottom2" name="bottom2">
								<span><img src="../../images/admin/dext_arrow06.gif" width="12" height="12" alt="현재 적용된 2번 툴바메뉴를 아래로 이동" /></span>
							</a>
						</p>
					</div>
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