<?
	$the_request = null;

	

	switch($_SERVER['REQUEST_METHOD'])
	{
		case 'GET': $the_request = &$_GET; break;
		case 'POST': $the_request = &$_POST; break;
	}

	DEXTImageSave();

	function GetOnlyPathFromURL($sURL) {

		$sRet = "";
		$path_parts = pathinfo($sURL);
		$last_index_of_seperator = strrpos($sURL, '/');
		$last_index_of_dot = strrpos($sURL, '.');

		if ($last_index_of_dot == false) {
			$sRet = $sURL;
		}
		else {
			if ($last_index_of_dot > $last_index_of_seperator) {
				if (strrpos($sURL, '/') > -1) { $sRet = $path_parts['dirname']; }
			}
		}
		return $sRet;
	}

	function DEXTImageSave() {

		global $the_request;

		$dext_install = $the_request["dext"];

		if (null != $dext_install && strlen($dext_install) > 0)
		{
			echo "Hi, DEXT5 Editor !!!! ".$dext_install;
			exit;
		}


        $return_url = $the_request["return_url"];
		if (null != $return_url && strlen($return_url) > 0)
        {
            echo $return_url;
			exit;
        }

		$upload_type = $the_request["uploadtype"];
		$proxy_url = $the_request["proxy_url"];
		$save_file_ext = $the_request["savefileext"];
		$server_domain = $the_request["serverdomain"];
		$to_save_path_url = $the_request["tosavepathurl"];
		$save_foldername_rule = $the_request["savafoldernamerule"];
		$save_filename_rule = $the_request["savafilenamerule"];

		$image_convert_format = $the_request["image_convert_format"];
		$image_convert_width = $the_request["image_convert_width"];
		$image_convert_height = $the_request["image_convert_height"];

		if (null == $proxy_url) { $proxy_url = ""; }
		if (null == $image_convert_format || $image_convert_format != "jpg") { $image_convert_format = ""; }
		if (null == $image_convert_width || $image_convert_width == "") { $image_convert_width = "0"; }
		if (null == $image_convert_height || $image_convert_height == "") { $image_convert_height = "0"; }
		if(strcasecmp($save_file_ext, "bmp") == 0) { $image_convert_format  = "jpg"; }
		$resize_width = intval($image_convert_width);
		$resize_height = intval($image_convert_height);
		$save_file_name = rand(10000, 99999);
		$save_file_name = date("Ymd_ihms_").$save_file_name;

		if ($upload_type != null && $upload_type == "plugin") { $upload_type = "image"; }

		if ($upload_type != null && $upload_type == "pluginkey")
		{
			$g_allowFileExt = $g_allowFileExt.", cab";
			$save_file_name = $the_request["savefilename"];
		}

		if(checkFileExt($save_file_ext) != true) 
		{
			echo "Does not allow the file extension.";
			exit;
		}


		$sToSavePath = $to_save_path_url;
		$pos = strpos($sToSavePath, '/');

		if ($pos !== false) {
			if ($pos == 0) {
				// 첫번째에 '/' 가 존재하는 경우
				$to_save_path_url = $_SERVER['DOCUMENT_ROOT'].$to_save_path_url;
			}
			else {
				$tmp_path = str_replace('\\', '/', realpath("../../."));
				$to_save_path_url = $tmp_path.'/'.$to_save_path_url;
			}
		}
		else if (strlen($sToSavePath) == 0) {
			// 빈값이 들어온 경우
			$to_save_path_url = str_replace('\\', '/', realpath("../../."));
		}
		else {
			// 그 이외의 경우
			$tmp_path = str_replace('\\', '/', realpath("../../."));
			$to_save_path_url = $tmp_path.'/'.$to_save_path_url;
		}

		if (strlen($save_foldername_rule) > 2)
		{
			$save_foldername_rule = GetFormatDate($save_foldername_rule);
			$sub_path = date($save_foldername_rule);
		}
		else { $sub_path = ""; }

		$to_save_path_url = $to_save_path_url.'/'.$sub_path;

		// 폴더가 존재하지 않다면..
		if (is_dir($to_save_path_url) == false) {
			// 폴더 권한설정
			//mkdir($sToSavePath, 0777, true);
			// 폴더 생성
			uf_mkdir($to_save_path_url);
		}

		
		$save_file = $to_save_path_url."/".$save_file_name.".".$save_file_ext;

		move_uploaded_file($_FILES["Filedata"]['tmp_name'], $save_file);

		// ==================
		if (strcasecmp($upload_type, "image") == 0 && (strcasecmp($image_convert_format, "jpg") == 0 || $resize_width > 0 || $resize_height > 0)) {
			$image_convert_format = "jpg";

			if(file_exists($save_file)) {
				$imginfo = getImageSize($save_file);
				$img_width  = $imginfo[0];
				$img_height  = $imginfo[1];

				if ($resize_width == 0 || $resize_width > $img_width) {
					if ($resize_width == 0 && $resize_height > 0 && $resize_height < $img_height) {
						$resize_width = ceil($img_width * $resize_height / ($img_height * 1.0));
					}
					else { $resize_width = $img_width; }
				}

				if ($resize_height == 0 || $resize_height > $img_height) {
					if ($resize_height == 0 && $resize_width > 0 && $resize_width < $img_width) {
						$resize_height = ceil($img_height * $resize_width / ($img_width * 1.0));
					}
					else { $resize_height = $img_height; }
				}

				$resize_file = $to_save_path_url."/".$save_file_name."_r.".$image_convert_format;

				$convert = make_gdimage($save_file, $resize_width, $resize_height, $resize_file, $image_convert_format);
				if($convert == 1)
				{
					$save_file_name = $save_file_name."_r";
					$save_file_ext = "jpg"; //$image_convert_format;

					unlink($save_file);
				}
				else { echo $convert; }

				$save_file = $to_save_path_url."/".$save_file_name.".".$save_file_ext;
			}
		}

		// =====================

		$retFullurlPath=  get_url_from_filepath($save_file);

		if (null != $proxy_url && strlen($proxy_url) > 0) {
			echo "<script> window.location.href='" . $proxy_url . "?return_url=" . $retFullurlPath . "'; </script>";
        }
        else{
			echo $retFullurlPath;
		}
	}

	function make_gdimage($imgfull_name, $width, $height, $savefull_name, $sExtension)
	{

		$gd = gd_info();
		$gdver = substr(preg_replace("/[^0-9]/", "", $gd['GD Version']), 0, 1);

		if(!$gdver) return "GD 버젼체크 실패거나 GD 버젼이 1 미만입니다.";

		$srcname = $imgfull_name;
		$timg = getimagesize($srcname);

		switch ($timg[2]) {
			case IMAGETYPE_JPEG: $cfile = imagecreatefromjpeg($srcname); break;
			case IMAGETYPE_PNG:	$cfile = imagecreatefrompng($srcname); break;
			case IMAGETYPE_GIF:	$cfile = imagecreatefromgif($srcname); break;
			case IMAGETYPE_BMP: $cfile = imagecreatefrombmp($srcname); break;
			default: return "지원하지 않는 이미지 파일입니다."; break;
		}

		if($gdver == 2) {
			$dest = imagecreatetruecolor($width, $height);
			imagecopyresampled($dest, $cfile, 0, 0, 0, 0, $width, $height, $timg[0], $timg[1]);
		}
		else {
			$dest = imagecreate($width, $height);
			imagecopyresized($dest, $cfile, 0, 0, 0, 0, $width, $height, $timg[0], $timg[1]);
		}

		imagejpeg($dest, $savefull_name, 100);
		imagedestroy($dest);
		return 1;
	}

	function rstrtrim($str, $remove=null)
	{
		$str    = (string)$str;
		$remove = (string)$remove;

		if(empty($remove)) { return rtrim($str); }

		$len = strlen($remove);
		$offset = strlen($str)-$len;
		while($offset > 0 && $offset == strpos($str, $remove, $offset)) {
			$str = substr($str, 0, $offset);
			$offset = strlen($str)-$len;
		}
		return rtrim($str);
	}

	function checkFileExt($post_file_ext)
	{
		$g_allowFileExt = "gif, jpg, jpeg, png, bmp, wmv, asf, swf";
		
		$rtn_value = false;

		$sFileList = explode(",", $g_allowFileExt);

		foreach ($sFileList as $key => $value)
		{
			$allow_file_ext = $value;
			$allow_file_ext = trim($allow_file_ext);

			if ($post_file_ext == $allow_file_ext)
			{
				$rtn_value = true;
			}
		}

		return $rtn_value;
	}


	function uf_mkdir($mk_path)
	{
		$mkdir_array = array();
		$path_array = split ( "/" , $mk_path );
		$path_count = count($path_array);

		for($step = $path_count; $step >= 0; $step--) {
			if(is_dir($mk_path) == false) {
				$path_name = $path_array[$step - 1];

				if(strlen($path_name) > 0) { array_push ($mkdir_array, $path_name); }

				$mk_path = rstrtrim($mk_path, strrchr($mk_path, "/"));
			}
			else { $step = 0; }
		}

		$path_count = count($mkdir_array);

		for($step = $path_count; $step > 0; $step--) {
			$mk_path = $mk_path."/".$mkdir_array[$step - 1];
			mkdir($mk_path);
		}
	}

	function get_httpschema()
	{
		$s = empty($_SERVER["HTTPS"]) ? '' : ($_SERVER["HTTPS"] == "on") ? "s" : "";
		$protocol = substr(strtolower($_SERVER["SERVER_PROTOCOL"]), 0, strpos(strtolower($_SERVER["SERVER_PROTOCOL"]), "/")) . $s;
		$port = ($_SERVER["SERVER_PORT"] == "80") ? "" : (":".$_SERVER["SERVER_PORT"]);
		return $protocol . "://";// . $_SERVER['SERVER_NAME'] . $port; //.$_SERVER['REQUEST_URI'];
	}

	function get_url_from_filepath($file)
	{
		$httpschma = get_httpschema();
		$host = $_SERVER['HTTP_HOST'];
		$docroot = $_SERVER['DOCUMENT_ROOT'];

		if (is_file($file)) {
			$len = strlen($docroot);
			$dir = substr(dirname($file), $len);
		}

		$basename = pathinfo($file);

		return $httpschma. $host . $dir."/".$basename['basename'];
	}

	function GetFormatDate($rule, $div = '/')
	{
		$return = "";
		$aDatePath=explode("/", $rule);

		foreach($aDatePath as $key => $date) {
			switch (strtolower($date)) {
				case "yyyy": $date = "Y"; break;
				case "mm": $date = "m"; break;
				case "dd": $date = "d"; break;
			}
			if ($return == "") { $return = $date; } else { $return = $return.$div.$date; }
		}
		return $return;
	}


	function imagecreatefrombmp($path) {
	     $filename = $path;

   		if (! $f1 = fopen($filename,"rb")) return FALSE;
 
		$FILE = unpack("vfile_type/Vfile_size/Vreserved/Vbitmap_offset", fread($f1,14));
		if ($FILE['file_type'] != 19778) return FALSE;

		$BMP = unpack('Vheader_size/Vwidth/Vheight/vplanes/vbits_per_pixel/Vcompression/Vsize_bitmap/Vhoriz_resolution/Vvert_resolution/Vcolors_used/Vcolors_important', fread($f1,40));
		$BMP['colors'] = pow(2,$BMP['bits_per_pixel']);
		
		if ($BMP['size_bitmap'] == 0) $BMP['size_bitmap'] = $FILE['file_size'] - $FILE['bitmap_offset'];
		
		$BMP['bytes_per_pixel'] = $BMP['bits_per_pixel']/8;
		$BMP['bytes_per_pixel2'] = ceil($BMP['bytes_per_pixel']);
		$BMP['decal'] = ($BMP['width']*$BMP['bytes_per_pixel']/4);
		$BMP['decal'] -= floor($BMP['width']*$BMP['bytes_per_pixel']/4);
		$BMP['decal'] = 4-(4*$BMP['decal']);
		
		if ($BMP['decal'] == 4) $BMP['decal'] = 0;

		$PALETTE = array();
		if ($BMP['colors'] < 16777216) { $PALETTE = unpack('V'.$BMP['colors'], fread($f1,$BMP['colors']*4)); }
		
		$IMG = fread($f1,$BMP['size_bitmap']);
		$VIDE = chr(0);
		
		$res = imagecreatetruecolor($BMP['width'],$BMP['height']);
		$P = 0;
		$Y = $BMP['height']-1;

		while ($Y >= 0) {
			$X=0;
			while ($X < $BMP['width']) {
				if ($BMP['bits_per_pixel'] == 24)
					$COLOR = unpack("V",substr($IMG,$P,3).$VIDE);
				elseif ($BMP['bits_per_pixel'] == 16) {
					$COLOR = unpack("v",substr($IMG,$P,2));
					$blue  = (($COLOR[1] & 0x001f) << 3) + 7;
					$green = (($COLOR[1] & 0x03e0) >> 2) + 7;
					$red   = (($COLOR[1] & 0xfc00) >> 7) + 7;
					$COLOR[1] = $red * 65536 + $green * 256 + $blue;
				}
				elseif ($BMP['bits_per_pixel'] == 8) {
					$COLOR = unpack("n",$VIDE.substr($IMG,$P,1));
					$COLOR[1] = $PALETTE[$COLOR[1]+1];
				}
				elseif ($BMP['bits_per_pixel'] == 4) {
					$COLOR = unpack("n",$VIDE.substr($IMG,floor($P),1));
					if (($P*2)%2 == 0) { $COLOR[1] = ($COLOR[1] >> 4); } else { $COLOR[1] = ($COLOR[1] & 0x0F); }
					$COLOR[1] = $PALETTE[$COLOR[1]+1];
				}
				elseif ($BMP['bits_per_pixel'] == 1) {
					$COLOR = unpack("n",$VIDE.substr($IMG,floor($P),1));
					if     (($P*8)%8 == 0) $COLOR[1] =  $COLOR[1]        >>7;
					elseif (($P*8)%8 == 1) $COLOR[1] = ($COLOR[1] & 0x40)>>6;
					elseif (($P*8)%8 == 2) $COLOR[1] = ($COLOR[1] & 0x20)>>5;
					elseif (($P*8)%8 == 3) $COLOR[1] = ($COLOR[1] & 0x10)>>4;
					elseif (($P*8)%8 == 4) $COLOR[1] = ($COLOR[1] & 0x8)>>3;
					elseif (($P*8)%8 == 5) $COLOR[1] = ($COLOR[1] & 0x4)>>2;
					elseif (($P*8)%8 == 6) $COLOR[1] = ($COLOR[1] & 0x2)>>1;
					elseif (($P*8)%8 == 7) $COLOR[1] = ($COLOR[1] & 0x1);
					$COLOR[1] = $PALETTE[$COLOR[1]+1];
				}
				else { return FALSE; }
				
				imagesetpixel($res,$X,$Y,$COLOR[1]);
				$X++;
				$P += $BMP['bytes_per_pixel'];
			}
			$Y--;
			$P+=$BMP['decal'];
		}
		
		fclose($f1);
		
		return $res;
	}


?>
