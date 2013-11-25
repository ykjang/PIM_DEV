<? /**
 	* @File		:	common_function.php
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
	function nullCheck($str) {
		if($str == null || trim($str) == "") {
			return "";
		} else {
			return $str;
		}
	}
?>