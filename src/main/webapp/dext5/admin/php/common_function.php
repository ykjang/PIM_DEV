<? /**
 	* @File		:	common_function.php
 	* @Function	:	������ �ý��� �α��� ������
 	* @Author	:	Dext5 Editor ������
 	* @Created	:	2013.09.13
	* @UpdateHistory
	* ===================================
	* Revision	1.0	2013.09.13	Dext5 Editor ������	�����ۼ�
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