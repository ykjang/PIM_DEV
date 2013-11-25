<? 
session_id("dext5editor");
session_start(); 
?>
<? /**
 	* @File		:	login_excute.php
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
<? include "common_function.php" ?>
<?
	$id = nullCheck($_REQUEST["id"]);
	$password = nullCheck($_REQUEST["password"]);
	
    $xml_path  = realpath('../../config/dext_editor.xml');
    $xml_string = file_get_contents($xml_path);
    $xml = simplexml_load_string($xml_string);
    $product_key =  $xml->license->product_key;
	
    $save_password = "ZGV4dDVhZG1pbg==";
    
    $txt_path  = realpath($product_key.'.txt');
    if(is_file($txt_path)){
        $txt_string = file_get_contents($txt_path);
        $save_password = $txt_string;
    }
    
	$result = "";
	$message = "";
	if($id != "admin") {
		$result = "1";
		$message = "아이디가 일치하지 않습니다.";
	} else if($id == "admin" && $password != $save_password) {
		$result = "2";
		$message = "비밀번호가 일치하지 않습니다.";
	} else if($id == "admin" && $password == $save_password) {
		$result = "3";
        
        $_SESSION["id"] = "admin";
        session_write_close();
	}
    
    header("Content-Type: text/xml"); 
    header("Cache-Control: no-cache"); 
    echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
    echo "<login>\n";
    echo "<result>$result</result>\n";
    echo "<message><![CDATA[$message]]></message>\n";
    echo "<id>$id</id>\n";
    echo "</login>";
?>
