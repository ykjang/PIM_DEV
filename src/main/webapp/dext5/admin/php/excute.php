<? /**
 	* @File		:	excute.php
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
    switch($_SERVER['REQUEST_METHOD'])
     {
         case 'GET': $_req = &$_GET; break;
         case 'POST': $_req= &$_POST; break;
         default : $_req= &$_req; break;
    }

	$mode = nullCheck($_req[mode]);
	if (mode != "") {
		try {
            
            $oldfile = realpath('../../config/dext_editor.xml');
            $newfile = realpath('../../config/').'\dext_editor_backup.xml';
    
            if(file_exists($oldfile)){
                if(!copy($oldfile, $newfile)){
                    echo "'백업파일 생성에 실패하였습니다.";
                }
            }
		} catch (Exception $e) {
			echo $e;
		}
		
		$page_url = "";
		if ($mode == "1") {
			$page_url = "license_admin.php";
		} else if ($mode == "2") {
			$page_url = "topmenu_admin.php";
		} else if ($mode == "3") {
			$page_url = "toolbar_admin.php";
		} else if ($mode == "4") {
			$page_url = "statusbar_admin.php";
		} else if ($mode == "5") {
			$page_url = "removeitem_admin.php";
		} else if ($mode == "6") {
			$page_url = "fontsize_admin.php";
		} else if ($mode == "7") {
			$page_url = "fontfamily_admin.php";
		} else if ($mode == "8") {
			$page_url = "setting.php";
		} else if ($mode == "9") {
			$page_url = "uploader_setting.php";
		}
		
		$product_key = nullCheck($_req[product_key]);
		$license_key = nullCheck($_req[license_key]);
        $plugin_use = nullCheck($_req[plugin_use]);
        $license_plugin = nullCheck($_req[license_plugin]);
        $plugin_version = nullCheck($_req[plugin_version]);
		$office_clean = nullCheck($_req[office_clean]);
		$remove_tags = nullCheck($_req[remove_tags]);
		$help_url = nullCheck($_req[help_url]);
		
        $top_menu = $_req[top_menu];
		$tool_bar_1 = $_req[tool_bar_1];
		$tool_bar_2 = $_req[tool_bar_2];
		$status_bar = $_req[status_bar];
		$remove_item = $_req[remove_item];
		$font_size = $_req[font_size];
		$font_family = $_req[font_family];
        
		$grid_color = nullCheck($_req[grid_color]);
		$grid_color_nm = nullCheck($_req[grid_color_nm]);
		$grid_spans = nullCheck($_req[grid_spans]);
		$grid_form = nullCheck($_req[grid_form]);
		$encoding = nullCheck($_req[encoding]);
		$doctype = nullCheck($_req[doctype]);
		$xmlnsname = nullCheck($_req[xmlnsname]);
		$lang = nullCheck($_req[lang]);
        $doc_lang = nullCheck($_req[doc_lang]);
		$width = nullCheck($_req[width]);
		$height = nullCheck($_req[height]);
		$skinname = nullCheck($_req[skinname]);
		$setting_font_family = nullCheck($_req[setting_font_family]);
		$setting_font_size = nullCheck($_req[setting_font_size]);
		//$enter_tag = nullCheck($_req[enter_tag]);
		//$shift_enter_tag = nullCheck($_req[shift_enter_tag]);
		$accessibility = nullCheck($_req[accessibility]);
		$topmenu = nullCheck($_req[topmenu]);
		$toolbar = nullCheck($_req[toolbar]);
		$statusbar = nullCheck($_req[statusbar]);
		$showdialog_pos = nullCheck($_req[showdialog_pos]);
		$develop_langage = nullCheck($_req[develop_langage]);
		$handler_url = nullCheck($_req[handler_url]);
		$to_save_path_url = nullCheck($_req[to_save_path_url]);
		$save_foldername_rule = nullCheck($_req[save_foldername_rule]);
		$save_filename_rule = nullCheck($_req[save_filename_rule]);
		$image_convert_format = nullCheck($_req[image_convert_format]);
		$image_convert_width = nullCheck($_req[image_convert_width]);
		$image_convert_height = nullCheck($_req[image_convert_height]);
		
        $xml_code .= "\n";
        $xml_code = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n";
        $xml_code .= "<dext5>\n";
        
        $xml_code .= "<license>\n";
        $xml_code .= "<product_key>".$product_key."</product_key>\n";
        $xml_code .= "<license_key>".$license_key."</license_key>\n";
        $xml_code .= "<plugin_use>".$plugin_use."</plugin_use>\n";
        $xml_code .= "<license_plugin>".$license_plugin."</license_plugin>\n";
        $xml_code .= "<plugin_version>".$plugin_version."</plugin_version>\n";
        $xml_code .= "</license>\n";
        
        $xml_code .= "<work_config>\n";
        $xml_code .= "<office_clean>".$office_clean."</office_clean>\n";
        $xml_code .= "<remove_tags>".$remove_tags."</remove_tags>\n";
        $xml_code .= "<help_url>".$help_url."</help_url>\n";
        $xml_code .= "</work_config>\n";
        
        $xml_code .= "<top_menu>\n";
        if($top_menu != null){
            foreach ($top_menu as $value) {
                $xml_code .= "<menu>".$value."</menu>\n";
            }
        }
        $xml_code .= "</top_menu>\n";
        
        $xml_code .= "<tool_bar_1>\n";
        if($tool_bar_1 != null){
            foreach ($tool_bar_1 as $value) {
                $xml_code .= "<tool>".$value."</tool>\n";
            }
        }
        $xml_code .= "</tool_bar_1>\n";
        
        $xml_code .= "<tool_bar_2>\n";
        if($tool_bar_2 != null){
            foreach ($tool_bar_2 as $value) {
                $xml_code .= "<tool>".$value."</tool>\n";
            }
        }
        $xml_code .= "</tool_bar_2>\n";
        
        $xml_code .= "<status_bar>\n";
        if($status_bar != null){
            foreach ($status_bar as $value) {
                $xml_code .= "<status>".$value."</status>\n";
            }
        }
        $xml_code .= "</status_bar>\n";
        
        $xml_code .= "<remove_item>\n";
        if($remove_item != null){
            foreach ($remove_item as $value) {
                $xml_code .= "<item>".$value."</item>\n";
            }
        }
        $xml_code .= "</remove_item>\n";
        
        $xml_code .= "<font_size>\n";
        if($font_size != null){
            foreach ($font_size as $value) {
                $xml_code .= "<size>".$value."</size>\n";
            }
        }
        $xml_code .= "</font_size>\n";
        
        $xml_code .= "<font_family>\n";
        if($font_family != null){
            foreach ($font_family as $value) {
                $xml_code .= "<font>".$value."</font>\n";
            }
        }
        $xml_code .= "</font_family>\n";
        
        $xml_code .= "<setting>\n";
		$xml_code .= "<grid_color>".$grid_color."</grid_color>\n";
		$xml_code .= "<grid_color_nm>".$grid_color_nm."</grid_color_nm>\n";
		$xml_code .= "<grid_spans>".$grid_spans."</grid_spans>\n";
		$xml_code .= "<grid_form>".$grid_form."</grid_form>\n";
		$xml_code .= "<encoding>".$encoding."</encoding>\n";
		$xml_code .= "<doctype>".$doctype."</doctype>\n";
		$xml_code .= "<xmlnsname>".$xmlnsname."</xmlnsname>\n";
        $xml_code .= "<doc_lang>".$doc_lang."</doc_lang>\n";
		$xml_code .= "<lang>".$lang."</lang>\n";
		$xml_code .= "<width>".$width."</width>\n";
		$xml_code .= "<height>".$height."</height>\n";
		$xml_code .= "<skinname>".$skinname."</skinname>\n";
		$xml_code .= "<font_family>".$font_family."</font_family>\n";
		$xml_code .= "<font_size>".$font_size."</font_size>\n";
		//$xml_code .= "<enter_tag>".$enter_tag."</enter_tag>\n";
		//$xml_code .= "<shift_enter_tag>".$shift_enter_tag."</shift_enter_tag>\n";
		$xml_code .= "<accessibility>".$accessibility."</accessibility>\n";
		$xml_code .= "<topmenu>".$topmenu."</topmenu>\n";
		$xml_code .= "<toolbar>".$toolbar."</toolbar>\n";
		$xml_code .= "<statusbar>".$statusbar."</statusbar>\n";
		$xml_code .= "<showdialog_pos>".$showdialog_pos."</showdialog_pos>\n";
	    $xml_code .= "</setting>\n";
        
        $xml_code .= "<uploader_setting>\n";
		$xml_code .= "<develop_langage>".$develop_langage."</develop_langage>\n";
		$xml_code .= "<handler_url>".$handler_url."</handler_url>\n";
		$xml_code .= "<to_save_path_url>".$to_save_path_url."</to_save_path_url>\n";
		$xml_code .= "<save_foldername_rule>".$save_foldername_rule."</save_foldername_rule>\n";
		$xml_code .= "<save_filename_rule>".$save_filename_rule."</save_filename_rule>\n";
		$xml_code .= "<image_convert_format>".$image_convert_format."</image_convert_format>\n";
		$xml_code .= "<image_convert_width>".$image_convert_width."</image_convert_width>\n";	
		$xml_code .= "<image_convert_height>".$image_convert_height."</image_convert_height>\n";
	    $xml_code .= "</uploader_setting>\n";
        
        $xml_code .= "</dext5>";
        
		try {
            $writeCheck = false;
            $dir_name = $oldfile;
            if(is_writable($dir_name)){
                $writeCheck = true;
                file_put_contents("../../config/dext_editor.xml", $xml_code);
                header("Location: $page_url?page_mode=excute"); exit;
            }
		} catch (Exception $e) {
			//echo $e->getmessage();
		}
	}
?>
<script language="javascript" type="text/javascript">
    var check = '<?=$writeCheck?>';
    if(!check){
        alert('dext_editor.xml에 대한 액세스가 거부되었습니다. 읽기 전용이라면 읽기 전용을 해제하여 주십시오');
        location.href = '<?=$page_url?>';
    }
</script>