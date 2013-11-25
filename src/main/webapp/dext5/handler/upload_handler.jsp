<%@ page import="java.io.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page import="java.awt.*" %>
<%@ page import="java.awt.image.*" %>

<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%

	String _allowFileExt = "gif, jpg, jpeg, png, bmp, wmv, asf, swf";
	int upload_max_size = 2147483647;
	String _systemSeparator = File.separator;
	boolean isSaveFileExt = false;
	String[] checkFileExt = _allowFileExt.split(",");
	int checkCount = checkFileExt.length;

	String upload_type = "";
	String proxy_url = "";
	String save_file_name = "";
	String save_file_ext = "";
	String server_domain = "";
	String to_save_path_url = "";
    String save_foldername_rule = "";
    String save_filename_rule = "";
	String sub_path = "";
	String save_path = "";
	String temp_path = "";
	String image_convert_format = "";
	String image_convert_width = "";
	String image_convert_height = ""; 


	String dext_install = request.getParameter("dext");
	if (null != dext_install && dext_install.length() > 0)
	{
		out.println("Hi, DEXT5 Editor !!!! " + dext_install);
		return;
	}

	// Proxy Server Return Value.
	String return_url = request.getParameter("return_url");
	if (null != return_url && return_url.length() > 0)
    {
		out.println(return_url);
		return;
	}

	String AppPath = request.getContextPath();
	temp_path = AppPath + "/tempdir/";
	
	temp_path = temp_path.replace("//", "/");

	String temp_real_path = application.getRealPath(temp_path);
	
	File temp_real_file_path = new File( temp_real_path );
	if(temp_real_file_path.exists() == false) { 
		temp_real_file_path.mkdirs();
	}
	
	System.out.println("temp_real_file_path"+temp_real_file_path.getPath());

	MultipartRequest multi = null;

	if(request.getContentType().indexOf("multipart/form-data") > -1)
	{
		multi = new MultipartRequest(request, temp_real_path, upload_max_size, "UTF-8");
	}
	else
	{
		System.out.println("DEXT File Save Error :: Upload File Not Found");
		response.sendError(500, "File Save Error :: Upload File Not Found");
	}



	upload_type = multi.getParameter("uploadtype");
	proxy_url = multi.getParameter("proxy_url");
	save_file_ext = multi.getParameter("savefileext");
	server_domain = multi.getParameter("serverdomain");
	to_save_path_url = multi.getParameter("tosavepathurl");
    save_foldername_rule = multi.getParameter("savafoldernamerule");
    save_filename_rule = multi.getParameter("savafilenamerule");

	image_convert_format = multi.getParameter("image_convert_format");
	image_convert_width = multi.getParameter("image_convert_width");
	image_convert_height = multi.getParameter("image_convert_height");

	if (null == proxy_url) { proxy_url = ""; }
	if (null == image_convert_format || image_convert_format != "jpg") { image_convert_format = ""; }
	if (null == image_convert_width || image_convert_width == "") { image_convert_width = "0"; }
	if (null == image_convert_height || image_convert_height == "") { image_convert_height = "0"; }
	int resize_width = Integer.parseInt(image_convert_width);
	int resize_height = Integer.parseInt(image_convert_height);
	if(save_file_ext.equals("bmp")) { image_convert_format = "jpg"; }

	Random rand = new Random();
    save_file_name = String.format("%05d", rand.nextInt(99999) + 1);

	Date dt2 = new Date();
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
	String save_file_name_prefix = sdf2.format(dt2);

	save_file_name = save_file_name_prefix + save_file_name;


	if (upload_type != null && upload_type.equals("plugin")) { upload_type = "image"; }

	if (upload_type != null && upload_type.equals("pluginkey"))
	{
		_allowFileExt = _allowFileExt + ", cab";
		save_file_name = multi.getParameter("savefilename");
	}

	if(null == server_domain || server_domain.equals(""))
	{
		server_domain = request.getScheme() + "://" + request.getServerName();
		if(request.getServerPort() != 80) { server_domain += (":" + request.getServerPort()); }
	}

	if (save_foldername_rule.length() > 2)
	{
		save_foldername_rule = save_foldername_rule.replace("YYYY", "yyyy").replace("DD", "dd");
		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat(save_foldername_rule);
		sub_path = sdf.format(dt);
	}
	else { sub_path = ""; }

	to_save_path_url = to_save_path_url + "/" + sub_path;

	if (!to_save_path_url.startsWith("/") || to_save_path_url.equals("")) { save_path = AppPath + "/" + to_save_path_url; }
	else { save_path = to_save_path_url; }

	save_path = save_path + "/";
	save_path = save_path.replace("//", "/");

	String save_real_path = application.getRealPath(save_path);
	File save_real_file_path = new File( save_real_path );
	if(save_real_file_path.exists() == false) { save_real_file_path.mkdirs(); }


	// 파일 확장자 체크
	if(save_file_ext.trim().length() > 0)
	{
		for(int i = 0; i < checkCount; i++) { if(save_file_ext.equals(checkFileExt[i].trim())) { isSaveFileExt = true; } }
	}

	try
	{
		String post_file_name = multi.getFilesystemName("Filedata");

		File post_save_file = new File(temp_real_path + _systemSeparator + post_file_name);

		// 파일 저장
		if(isSaveFileExt == true)
		{
			File save_file = new File(save_real_path + _systemSeparator + save_file_name + "." + save_file_ext);
			post_save_file.renameTo(save_file);

			// ===========================================

			try
			{
				if (upload_type.equals("image") && (image_convert_format.equalsIgnoreCase("jpg") || resize_width > 0 || resize_height > 0))
				{
					image_convert_format = "jpg";

					Image img = ImageIO.read(save_file);

					if (img != null)
					{
						int img_width = img.getWidth(null);
						int img_height = img.getHeight(null);

						if (resize_width == 0 || resize_width > img_width)
						{
							if (resize_width == 0 && resize_height > 0 && resize_height < img_height)
							{
								resize_width = (int)(img_width * (float)(resize_height / (img_height * 1.0)));
							}
							else { resize_width = img.getWidth(null); }
						}

						if (resize_height == 0 || resize_height > img_height)
						{
							if (resize_height == 0 && resize_width > 0 && resize_width < img_width)
							{
								resize_height = (int)(img_height * (float)(resize_width / (img_width * 1.0)));
							}
							else { resize_height = img_height; }
						}

						String resize_file_path = save_real_path + _systemSeparator + save_file_name + "_r." + image_convert_format;
						File resize_file = new File(resize_file_path);

						BufferedImage bimg = new BufferedImage(resize_width, resize_height, BufferedImage.TYPE_INT_RGB);
						Graphics2D g2d = bimg.createGraphics();
						g2d.drawImage(img, 0, 0, resize_width, resize_height, null);
						ImageIO.write(bimg, image_convert_format, resize_file);
						g2d.dispose();

						if(save_file.exists() == true) { save_file.delete(); }

						save_file_name = save_file_name + "_r";
						save_file_ext =  image_convert_format;
					}
				}
			}
			catch (Exception ex)
			{
				System.out.println("DextImageConvert Exception - " + ex.getMessage());
			}

			// ===========================================
			
			String rtn_message = "";

			rtn_message = server_domain + save_path + save_file_name + "." + save_file_ext;

            if (!proxy_url.equals(""))
            {
				rtn_message = "<script> window.location.href='" + proxy_url + "?return_url=" + rtn_message + "'; </script>";
            }


			out.print(rtn_message);
		}
		else
		{
			post_save_file.delete();
			System.out.println("Not Support Extension :: " + save_file_ext);
		}
	}
	catch (Exception ex)
	{
		System.out.println("DEXT File Save Error :: " + ex.toString());
		response.sendError(500, "File Save Error :: " + ex.toString());
	}
	finally {}

%>