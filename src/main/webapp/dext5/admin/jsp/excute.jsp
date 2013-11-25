<%	/**
 	* @File		:	excute.jsp
 	* @Function	:	관리자 시스템 dext_editor.xml 생성 페이지
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
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="org.jdom2.Document"%>
<%@ page import="org.jdom2.Element"%>
<%@ page import="org.jdom2.output.Format"%>
<%@ page import="org.jdom2.output.XMLOutputter"%>
<%
	request.setCharacterEncoding("utf-8");

	String mode = nullCheck(request.getParameter("mode"));

	if (!mode.equals("")) {
		try {
			String AppPath = request.getContextPath();
			AppPath += "dext5/config";
			String real_path = application.getRealPath(AppPath);
			
		 	FileInputStream fis = new FileInputStream(real_path + "/dext_editor.xml");
		    FileOutputStream fos = new FileOutputStream(real_path + "/dext_editor_backup.xml");
		    
		    int data = 0;
		    while((data=fis.read())!=-1) {
		    	fos.write(data);
		    }
		    
		    fis.close();
		    fos.close();
		} catch (IOException e) {
			System.err.println(e);
		}
		
		String page_url = "";
		if (mode.equals("1")) {
			page_url = "license_admin.jsp?page_mode=excute";
		} else if (mode.equals("2")) {
			page_url = "topmenu_admin.jsp?page_mode=excute";
		} else if (mode.equals("3")) {
			page_url = "toolbar_admin.jsp?page_mode=excute";
		} else if (mode.equals("4")) {
			page_url = "statusbar_admin.jsp?page_mode=excute";
		} else if (mode.equals("5")) {
			page_url = "removeitem_admin.jsp?page_mode=excute";
		} else if (mode.equals("6")) {
			page_url = "fontsize_admin.jsp?page_mode=excute";
		} else if (mode.equals("7")) {
			page_url = "fontfamily_admin.jsp?page_mode=excute";
		} else if (mode.equals("8")) {
			page_url = "setting.jsp?page_mode=excute";
		} else if (mode.equals("9")) {
			page_url = "uploader_setting.jsp?page_mode=excute";
		}
		
		String product_key = nullCheck(request.getParameter("product_key"));
		String license_key = nullCheck(request.getParameter("license_key"));
		String plugin_use = nullCheck(request.getParameter("plugin_use"));
		String license_plugin = nullCheck(request.getParameter("license_plugin"));
		String plugin_version = nullCheck(request.getParameter("plugin_version"));
		String office_clean = nullCheck(request.getParameter("office_clean"));
		String remove_tags = nullCheck(request.getParameter("remove_tags"));
		String help_url = nullCheck(request.getParameter("help_url"));
		String [] top_menu = request.getParameterValues("top_menu[]");
		String [] tool_bar_1 = request.getParameterValues("tool_bar_1[]");
		String [] tool_bar_2 = request.getParameterValues("tool_bar_2[]");
		String [] status_bar = request.getParameterValues("status_bar[]");
		String [] remove_item = request.getParameterValues("remove_item[]");
		String [] font_size = request.getParameterValues("font_size[]");
		String [] font_family = request.getParameterValues("font_family[]");
		String grid_color = nullCheck(request.getParameter("grid_color"));
		String grid_color_nm = nullCheck(request.getParameter("grid_color_nm"));
		String grid_spans = nullCheck(request.getParameter("grid_spans"));
		String grid_form = nullCheck(request.getParameter("grid_form"));
		String encoding = nullCheck(request.getParameter("encoding"));
		String doctype = nullCheck(request.getParameter("doctype"));
		String xmlnsname = nullCheck(request.getParameter("xmlnsname"));
		String doc_lang = nullCheck(request.getParameter("doc_lang"));
		String lang = nullCheck(request.getParameter("lang"));
		String width = nullCheck(request.getParameter("width"));
		String height = nullCheck(request.getParameter("height"));
		String skinname = nullCheck(request.getParameter("skinname"));
		String setting_font_family = nullCheck(request.getParameter("setting_font_family"));
		String setting_font_size = nullCheck(request.getParameter("setting_font_size"));
		//String enter_tag = nullCheck(request.getParameter("enter_tag"));
		//String shift_enter_tag = nullCheck(request.getParameter("shift_enter_tag"));
		String accessibility = nullCheck(request.getParameter("accessibility"));
		String topmenu = nullCheck(request.getParameter("topmenu"));
		String toolbar = nullCheck(request.getParameter("toolbar"));
		String statusbar = nullCheck(request.getParameter("statusbar"));
		String showdialog_pos = nullCheck(request.getParameter("showdialog_pos"));
		String develop_langage = nullCheck(request.getParameter("develop_langage"));
		String handler_url = nullCheck(request.getParameter("handler_url"));
		String to_save_path_url = nullCheck(request.getParameter("to_save_path_url"));
		String save_foldername_rule = nullCheck(request.getParameter("save_foldername_rule"));
		String save_filename_rule = nullCheck(request.getParameter("save_filename_rule"));
		String image_convert_format = nullCheck(request.getParameter("image_convert_format"));
		String image_convert_width = nullCheck(request.getParameter("image_convert_width"));
		String image_convert_height = nullCheck(request.getParameter("image_convert_height"));
		
		Document doc = new Document();  
		 
		Element e_dext5 = new Element("dext5");
		Element e_license = new Element("license");
		e_dext5.addContent(e_license);
		Element e_product_key = new Element("product_key");
		e_license.addContent(e_product_key);
		e_product_key.setText(product_key);
		Element e_license_key = new Element("license_key");
		e_license.addContent(e_license_key);
		e_license_key.setText(license_key);
		Element e_plugin_use = new Element("plugin_use");
		e_license.addContent(e_plugin_use);
		e_plugin_use.setText(plugin_use);
		Element e_license_plugin = new Element("license_plugin");
		e_license.addContent(e_license_plugin);
		e_license_plugin.setText(license_plugin);
		Element e_plugin_version = new Element("plugin_version");
		e_license.addContent(e_plugin_version);
		e_plugin_version.setText(plugin_version);
		Element e_work_config = new Element("work_config");
		e_dext5.addContent(e_work_config);
		Element e_office_clean = new Element("office_clean");
		e_work_config.addContent(e_office_clean);
		e_office_clean.setText(office_clean);
		Element e_remove_tags = new Element("remove_tags");
		e_work_config.addContent(e_remove_tags);
		e_remove_tags.setText(remove_tags);
		Element e_help_url = new Element("help_url");
		e_work_config.addContent(e_help_url);
		e_help_url.setText(help_url);
		Element e_top_menu = new Element("top_menu");
		e_dext5.addContent(e_top_menu);
		if(top_menu != null) {
			for(int i=0 ; i<top_menu.length ; i++) {
				Element e_menu = new Element("menu");
				e_top_menu.addContent(e_menu);
				e_menu.setText(top_menu[i]);
			}
		}
		Element e_tool_bar_1 = new Element("tool_bar_1");
		e_dext5.addContent(e_tool_bar_1);
		if(tool_bar_1 != null) {
			for(int i=0 ; i<tool_bar_1.length ; i++) {
				Element e_tool = new Element("tool");
				e_tool_bar_1.addContent(e_tool);
				e_tool.setText(tool_bar_1[i]);
			}
		}
		Element e_tool_bar_2 = new Element("tool_bar_2");
		e_dext5.addContent(e_tool_bar_2);
		if(tool_bar_2 != null) {
			for(int i=0 ; i<tool_bar_2.length ; i++) {
				Element e_tool = new Element("tool");
				e_tool_bar_2.addContent(e_tool);
				e_tool.setText(tool_bar_2[i]);
			}
		}
		Element e_status_bar = new Element("status_bar");
		e_dext5.addContent(e_status_bar);
		if(status_bar != null) {
			for(int i=0 ; i<status_bar.length ; i++) {
				Element e_status = new Element("status");
				e_status_bar.addContent(e_status);
				e_status.setText(status_bar[i]);
			}
		}
		Element e_remove_item = new Element("remove_item");
		e_dext5.addContent(e_remove_item);
		if(remove_item != null) {
			for(int i=0 ; i<remove_item.length ; i++) {
				Element e_item = new Element("item");
				e_remove_item.addContent(e_item);
				e_item.setText(remove_item[i]);
			}
		}
		Element e_font_size = new Element("font_size");
		e_dext5.addContent(e_font_size);
		if(font_size != null) {
			for(int i=0 ; i<font_size.length ; i++) {
				Element e_size = new Element("size");
				e_font_size.addContent(e_size);
				e_size.setText(font_size[i]);
			}
		}
		Element e_font_family = new Element("font_family");
		e_dext5.addContent(e_font_family);
		if(font_family != null) {
			for(int i=0 ; i<font_family.length ; i++) {
				Element e_font = new Element("font");
				e_font_family.addContent(e_font);
				e_font.setText(font_family[i]);
			}
		}
		Element e_setting = new Element("setting");
		e_dext5.addContent(e_setting);
		Element e_grid_color = new Element("grid_color");
		e_setting.addContent(e_grid_color);
		e_grid_color.setText(grid_color);
		Element e_grid_color_nm = new Element("grid_color_nm");
		e_setting.addContent(e_grid_color_nm);
		e_grid_color_nm.setText(grid_color_nm);
		Element e_grid_spans = new Element("grid_spans");
		e_setting.addContent(e_grid_spans);
		e_grid_spans.setText(grid_spans);
		Element e_grid_form = new Element("grid_form");
		e_setting.addContent(e_grid_form);
		e_grid_form.setText(grid_form);
		Element e_encoding = new Element("encoding");
		e_setting.addContent(e_encoding);
		e_encoding.setText(encoding);
		Element e_doctype = new Element("doctype");
		e_setting.addContent(e_doctype);
		e_doctype.setText(doctype);
		Element e_xmlnsname = new Element("xmlnsname");
		e_setting.addContent(e_xmlnsname);
		e_xmlnsname.setText(xmlnsname);
		Element e_doc_lang = new Element("doc_lang");
		e_setting.addContent(e_doc_lang);
		e_doc_lang.setText(doc_lang);
		Element e_lang = new Element("lang");
		e_setting.addContent(e_lang);
		e_lang.setText(lang);
		Element e_width = new Element("width");
		e_setting.addContent(e_width);
		e_width.setText(width);
		Element e_height = new Element("height");
		e_setting.addContent(e_height);
		e_height.setText(height);
		Element e_skinname = new Element("skinname");
		e_setting.addContent(e_skinname);
		e_skinname.setText(skinname);
		Element e_setting_font_family = new Element("font_family");
		e_setting.addContent(e_setting_font_family);
		e_setting_font_family.setText(setting_font_family);
		Element e_setting_font_size = new Element("font_size");
		e_setting.addContent(e_setting_font_size);
		e_setting_font_size.setText(setting_font_size);
		//Element e_enter_tag = new Element("enter_tag");
		//e_setting.addContent(e_enter_tag);
		//e_enter_tag.setText(enter_tag);
		//Element e_shift_enter_tag = new Element("shift_enter_tag");
		//e_setting.addContent(e_shift_enter_tag);
		//e_shift_enter_tag.setText(shift_enter_tag);
		Element e_accessibility = new Element("accessibility");
		e_setting.addContent(e_accessibility);
		e_accessibility.setText(accessibility);
		Element e_topmenu = new Element("topmenu");
		e_setting.addContent(e_topmenu);
		e_topmenu.setText(topmenu);
		Element e_toolbar = new Element("toolbar");
		e_setting.addContent(e_toolbar);
		e_toolbar.setText(toolbar);
		Element e_statusbar = new Element("statusbar");
		e_setting.addContent(e_statusbar);
		e_statusbar.setText(statusbar);
		Element e_showdialog_pos = new Element("showdialog_pos");
		e_setting.addContent(e_showdialog_pos);
		e_showdialog_pos.setText(showdialog_pos);
		Element e_uploader_setting = new Element("uploader_setting");
		e_dext5.addContent(e_uploader_setting);
		Element e_develop_langage = new Element("develop_langage");
		e_uploader_setting.addContent(e_develop_langage);
		e_develop_langage.setText(develop_langage);
		Element e_handler_url = new Element("handler_url");
		e_uploader_setting.addContent(e_handler_url);
		e_handler_url.setText(handler_url);
		Element e_to_save_path_url = new Element("to_save_path_url");
		e_uploader_setting.addContent(e_to_save_path_url);
		e_to_save_path_url.setText(to_save_path_url);
		Element e_save_foldername_rule = new Element("save_foldername_rule");
		e_uploader_setting.addContent(e_save_foldername_rule);
		e_save_foldername_rule.setText(save_foldername_rule);
		Element e_save_filename_rule = new Element("save_filename_rule");
		e_uploader_setting.addContent(e_save_filename_rule);
		e_save_filename_rule.setText(save_filename_rule);
		Element e_image_convert_format = new Element("image_convert_format");
		e_uploader_setting.addContent(e_image_convert_format);
		e_image_convert_format.setText(image_convert_format);
		Element e_image_convert_width = new Element("image_convert_width");
		e_uploader_setting.addContent(e_image_convert_width);
		e_image_convert_width.setText(image_convert_width);
		Element e_image_convert_height = new Element("image_convert_height");
		e_uploader_setting.addContent(e_image_convert_height);
		e_image_convert_height.setText(image_convert_height);
		
		doc.setRootElement(e_dext5);
		
		try {                  
			String AppPath = request.getContextPath();
			AppPath += "dext5/config";
			String real_path = application.getRealPath(AppPath);
			
			FileOutputStream out_xml = new FileOutputStream(real_path + "/dext_editor.xml");
			//xml 파일을 떨구기 위한 경로와 파일 이름 지정해 주기
			XMLOutputter serializer = new XMLOutputter();
	
			Format f = serializer.getFormat();
			f.setEncoding("utf-8");
	
			//encoding 타입을 utf-8 로 설정
			f.setIndent(" ");
			f.setLineSeparator("\r\n");
			f.setTextMode(Format.TextMode.TRIM);
			serializer.setFormat(f);
	
			serializer.output(doc, out_xml);
			out_xml.flush();
			out_xml.close();
			
			File del_file = new File(real_path + "/dext_editor_backup.xml");
			del_file.delete();
			
			out.println("<script type='text/javascript'>");
			out.println("self.location.href = '" + page_url + "';");
			out.println("</script>");
		} catch (IOException e) {
			out.println("<script type='text/javascript'>");
			out.println("alert('dext_editor.xml에 대한 액세스가 거부되었습니다. 읽기 전용이라면 읽기 전용을 해제하여 주십시오');");
			out.println("self.location.href='" + page_url + "'");
			out.println("</script>");
			System.err.println(e);
		}
	}
%>