<? 
session_id("dext5editor");
session_start(); 
?>
<? 
/**
 	* @File		:	license_admin.php
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
<title>Dext5 웹에디터 - 관리자페이지 - 라이선스 관리</title>
<script type="text/javascript">
    function excuteConfirm() {
        document.getElementById("product_key").value =
			document.getElementById("product_key_1").value + "-" +
			document.getElementById("product_key_2").value + "-" +
			document.getElementById("product_key_3").value + "-" +
			document.getElementById("product_key_4").value;

        if (document.getElementById("plugin_version1").value == "" && document.getElementById("plugin_version2").value == ""
            && document.getElementById("plugin_version3").value == "" && document.getElementById("plugin_version4").value == "") {
            document.getElementById("plugin_version").value = "";
        } else {
            if (document.getElementById("plugin_use").value == "1") {
                document.getElementById("plugin_version").value =
			            document.getElementById("plugin_version1").value + "." +
			            document.getElementById("plugin_version2").value + "." +
			            document.getElementById("plugin_version3").value + "." +
			            document.getElementById("plugin_version4").value;
            } else {
                document.getElementById("plugin_version").value = "";
            }
        }
        return true;
    }

    function next(obj) {
        var num = parseInt(obj.id.substring(obj.id.length - 1), 10);
        if (obj.value.length >= 4) {
            document.getElementById('product_key_' + (num + 1)).focus();
        }
    }

    function pluginUseChange() {
        if (document.getElementById('plugin_use').value == '1') {
            document.getElementById('tr_plugin_url').style.display = '';
            document.getElementById('tr_plugin_version').style.display = '';
            chkDefaultChange();
        } else {
            document.getElementById('tr_plugin_url').style.display = 'none';
            document.getElementById('tr_plugin_version').style.display = 'none';
        }
    }

    function chkDefaultChange() {
        if (document.getElementById('chk_license_plugin').checked) {
            document.getElementById('license_plugin').value = '';
            document.getElementById('license_plugin').disabled = 'disabled';
            document.getElementById('span_desc').innerHTML = dext5_admin_lang.license_url_desc1;
        } else {
            document.getElementById('license_plugin').value = 'http://';
            document.getElementById('license_plugin').disabled = false;
            document.getElementById('span_desc').innerHTML = dext5_admin_lang.license_url_desc2;
        }
    }

    function clickSubmit() {
        if (!document.getElementById('chk_license_plugin').checked) {
            var url = document.getElementById('license_plugin').value.toLowerCase();
            if (url.search('http://') < 0) {
                alert('http://를 포함한 경로를 입력해야 합니다.');
                return;
            } else {
                document.getElementById('license_plugin').value = url;
            }
        }
        document.dext5.onsubmit();
        document.dext5.submit();
    }
    
    function editorConfirmMove() {
        self.location = "editor_confirm.php";
        return false;
    }
</script>
</head>
<body class="dext5_editor" onload="xmlhttpPostXML('../../config/dext_editor.xml', null, 'xmlAdmin','1');">

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
					<li><a href="license_admin.php" class="on" style="margin-left: 0;">라이선스 관리</a></li>
					<li><a href="topmenu_admin.php">상단메뉴 관리</a></li>
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
		<form name="dext5" method="post" action="excute.php">
		<input type="hidden" id="mode" name="mode" value="1"/>
		<div id="xml_value"></div>
			<h2>
				<img src="../../images/admin/dext_img03.gif" width="241" height="16" alt="라이선스 관리" />
			</h2>
			<p class="dbg"></p>
			<div class="htb">
				<table cellpadding="0" cellspacing="0" border="0" summary="라이선스 관리">
					<tr>
						<th width="22%" class="item"><label for="product_key">제품 키</label></th>
						<td width="78%">
							<input id="product_key_1" name="product_key_1" type="text" class="in" onkeyup="javascript:next(this);"/> -
							<input id="product_key_2" name="product_key_2" type="text" class="in" onkeyup="javascript:next(this);"/> -
							<input id="product_key_3" name="product_key_3" type="text" class="in" onkeyup="javascript:next(this);"/> -
							<input id="product_key_4" name="product_key_4" type="text" class="in"/>
						</td>
					</tr>
					<tr>
						<th class="item" style="height:66px;"><label for="license_key">라이선스 키</label></th>
						<td><textarea id="license_key" name="license_key" style="height:50px; width:642px;"></textarea></td>
					</tr>
                    <tr>
						<th class="item"><label for="plugin_use">plugin 모듈 사용</label></th>
						<td><select name="plugin_use" id="plugin_use" onchange="javascript:pluginUseChange();"></select></td>
					</tr>
                    <tr style="display:none;" id="tr_plugin_url">
						<th class="item"><label for="license_plugin">plugin 모듈 저장 경로</label></th>
						<td style="height:55px;">
                            <label for="chk_license_plugin">기본값 사용</label><input type="checkbox" id="chk_license_plugin" onchange="javascript:chkDefaultChange();" checked="checked" class="check" style="margin-left:5px;"/>
                            <input name="license_plugin" id="license_plugin" type="text" style="margin-bottom:7px;" /><br />
                            <span id="span_desc" style="margin-left:5px; font-size:11px; color:#327cc6;"></span>
                        </td>
					</tr>
                    <tr style="display:none;" id="tr_plugin_version">
						<th width="22%" class="item">plugin 버전</th>
						<td width="78%">
							<input id="plugin_version1" name="plugin_version1" type="text" maxlength="2" class="in" style="width:50px;"/>
                            <span class="sub">．</span>
							<input id="plugin_version2" name="plugin_version2" type="text" maxlength="2" class="in" style="width:50px;"/>
                            <span class="sub">．</span>
							<input id="plugin_version3" name="plugin_version3" type="text" maxlength="2" class="in" style="width:50px;"/>
                            <span class="sub">．</span>
							<input id="plugin_version4" name="plugin_version4" type="text" maxlength="2" class="in" style="width:50px;"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="bottom_btn">
				<ul>
					<li>
						<button type="button" class="button" onclick="javascript:clickSubmit();">적용</button>
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
