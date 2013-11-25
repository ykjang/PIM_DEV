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
	$password = nullCheck($_REQUEST["password"]);
    $new_pw = nullCheck($_REQUEST["new_pw"]);
    
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
    if($password != $save_password) {
		$result = "2";
		$message = "비밀번호가 일치하지 않습니다.";
	} else if($password == $save_password) {
		$result = "3";
        $file_check = "false";
        
        if(is_file($product_key.'.txt')){
            if(is_writable(realpath($product_key.'.txt'))){
                $file_check = "true";
                $file = fopen($product_key.'.txt', "w");
                fwrite($file, $new_pw);
                fclose($file);
            }
        } else {
            $file_check = "true";
            $file = fopen($product_key.'.txt', "w");
            fwrite($file, $new_pw);
            fclose($file);
        }
	}
    
    header("Content-Type: text/xml"); 
    header("Cache-Control: no-cache"); 
    echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
    echo "<change>\n";
    echo "<result>$result</result>\n";
    echo "<check>$file_check</check>\n";
    echo "<message><![CDATA[$message]]></message>\n";
    echo "</change>";
?>

