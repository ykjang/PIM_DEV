using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;

public partial class dext5_admin_NET_Default : System.Web.UI.Page
{
    string mode = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if(null != Request["mode"]){
            mode = Request["mode"].ToString();
        }

        if(mode != ""){
            string physical_path = HttpContext.Current.Request.PhysicalApplicationPath;

            try
            {
                File.Delete(physical_path + @"\dext5\config\dext_editor_bakup.xml");

                TextReader trs = new StreamReader(physical_path + @"\dext5\config\dext_editor.xml");
                File.WriteAllText(physical_path + @"\dext5\config\dext_editor_bakup.xml", trs.ReadToEnd(), Encoding.UTF8);
                trs.Close();
            }
            catch (IOException ex)
            {
                Response.Write(ex.Message.ToString());
            }

            string page_url = "";

            if (mode.Equals("1"))
            {
                page_url = "license_admin.aspx";
            }
            else if (mode.Equals("2"))
            {
                page_url = "topmenu_admin.aspx";
            }
            else if (mode.Equals("3"))
            {
                page_url = "toolbar_admin.aspx";
            }
            else if (mode.Equals("4"))
            {
                page_url = "statusbar_admin.aspx";
            }
            else if (mode.Equals("5"))
            {
                page_url = "removeitem_admin.aspx";
            }
            else if (mode.Equals("6"))
            {
                page_url = "fontsize_admin.aspx";
            }
            else if (mode.Equals("7"))
            {
                page_url = "fontfamily_admin.aspx";
            }
            else if (mode.Equals("8"))
            {
                page_url = "setting.aspx";
            }
            else if (mode.Equals("9"))
            {
                page_url = "uploader_setting.aspx";
            }

            string product_key = nullCheck(Request["product_key"]);
            string license_key = nullCheck(Request["license_key"]);
            string plugin_use = nullCheck(Request["plugin_use"]);
            string license_plugin = nullCheck(Request["license_plugin"]);
            string plugin_version = nullCheck(Request["plugin_version"]);
            string office_clean = nullCheck(Request["office_clean"]);
            string remove_tags = nullCheck(Request["remove_tags"]);
            string help_url = nullCheck(Request["help_url"]);
            string[] top_menu = nullCheck(Request["top_menu[]"]) != "" ? Request["top_menu[]"].ToString().Split(',') : null;
            string[] tool_bar_1 = nullCheck(Request["tool_bar_1[]"]) != "" ? Request["tool_bar_1[]"].ToString().Split(',') : null;
            string[] tool_bar_2 = nullCheck(Request["tool_bar_2[]"]) != "" ? Request["tool_bar_2[]"].ToString().Split(',') : null;
            string[] status_bar = nullCheck(Request["status_bar[]"]) != "" ? Request["status_bar[]"].ToString().Split(',') : null;
            string[] remove_item = nullCheck(Request["remove_item[]"]) != "" ? Request["remove_item[]"].ToString().Split(',') : null;
            string[] font_size = nullCheck(Request["font_size[]"]) != "" ? Request["font_size[]"].ToString().Split(',') : null;
            string[] font_family = nullCheck(Request["font_family[]"]) != "" ? Request["font_family[]"].ToString().Split(',') : null;
            string grid_color = nullCheck(Request["grid_color"]);
            string grid_color_nm = nullCheck(Request["grid_color_nm"]);
            string grid_spans = nullCheck(Request["grid_spans"]);
            string grid_form = nullCheck(Request["grid_form"]);
            string encoding = nullCheck(Request["encoding"]);
            string doctype = nullCheck(Request["doctype"]);
            string xmlnsname = nullCheck(Request["xmlnsname"]);
            string doc_lang = nullCheck(Request["doc_lang"]);
            string lang = nullCheck(Request["lang"]);
            string width = nullCheck(Request["width"]);
            string height = nullCheck(Request["height"]);
            string skinname = nullCheck(Request["skinname"]);
            string setting_font_family = nullCheck(Request["setting_font_family"]);
            string setting_font_size = nullCheck(Request["setting_font_size"]);
            //string enter_tag = nullCheck(Request["enter_tag"]);
            //string shift_enter_tag = nullCheck(Request["shift_enter_tag"]);
            string accessibility = nullCheck(Request["accessibility"]);
            string topmenu = nullCheck(Request["topmenu"]);
            string toolbar = nullCheck(Request["toolbar"]);
            string statusbar = nullCheck(Request["statusbar"]);
            string showdialog_pos = nullCheck(Request["showdialog_pos"]);
            string develop_langage = nullCheck(Request["develop_langage"]);
            string handler_url = nullCheck(Request["handler_url"]);
            string to_save_path_url = nullCheck(Request["to_save_path_url"]);
            string save_foldername_rule = nullCheck(Request["save_foldername_rule"]);
            string save_filename_rule = nullCheck(Request["save_filename_rule"]);
            string image_convert_format = nullCheck(Request["image_convert_format"]);
            string image_convert_width = nullCheck(Request["image_convert_width"]);
            string image_convert_height = nullCheck(Request["image_convert_height"]);

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
            sb.AppendLine("<dext5>");
            sb.AppendLine("<license>");
            sb.AppendLine(" <product_key>" + product_key + "</product_key>");
            sb.AppendLine(" <license_key>" + license_key + "</license_key>");
            sb.AppendLine(" <plugin_use>" + plugin_use + "</plugin_use>");
            sb.AppendLine(" <license_plugin>" + license_plugin + "</license_plugin>");
            sb.AppendLine(" <plugin_version>" + plugin_version + "</plugin_version>");
            sb.AppendLine("</license>");
            sb.AppendLine("<work_config>");
            sb.AppendLine(" <office_clean>" + office_clean + "</office_clean>");
            sb.AppendLine(" <remove_tags>" + remove_tags + "</remove_tags>");
            sb.AppendLine(" <help_url>" + help_url + "</help_url>");
            sb.AppendLine("</work_config>");
            sb.AppendLine("<top_menu>");
            if(top_menu != null){
                for (int i = 0; i < top_menu.Length; i++)
                {
                    sb.AppendLine(" <menu>" + top_menu[i].ToString() + "</menu>");
                }
            }
            sb.AppendLine("</top_menu>");
            sb.AppendLine("<tool_bar_1>");
            if (tool_bar_1 != null)
            {
                for (int i = 0; i < tool_bar_1.Length; i++)
                    sb.AppendLine(" <tool>" + tool_bar_1[i].ToString() + "</tool>");
            }
            sb.AppendLine("</tool_bar_1>");
            sb.AppendLine("<tool_bar_2>");
            if (tool_bar_2 != null)
            {
                for (int i = 0; i < tool_bar_2.Length; i++)
                    sb.AppendLine(" <tool>" + tool_bar_2[i].ToString() + "</tool>");
            }
            sb.AppendLine("</tool_bar_2>");
            sb.AppendLine("<status_bar>");
            if (status_bar != null)
            {
                for (int i = 0; i < status_bar.Length; i++)
                    sb.AppendLine(" <status>" + status_bar[i].ToString() + "</status>");
            }
            sb.AppendLine("</status_bar>");
            sb.AppendLine("<remove_item>");
            if (remove_item != null)
            {
                for (int i = 0; i < remove_item.Length; i++)
                    sb.AppendLine(" <item>" + remove_item[i].ToString() + "</item>");
            }
            sb.AppendLine("</remove_item>");
            sb.AppendLine("<font_size>");
            if (font_size != null)
            {
                for (int i = 0; i < font_size.Length; i++)
                    sb.AppendLine(" <size>" + font_size[i].ToString() + "</size>");
            }
            sb.AppendLine("</font_size>");
            sb.AppendLine("<font_family>");
            if (font_family != null)
            {
                for (int i = 0; i < font_family.Length; i++)
                    sb.AppendLine(" <font>" + font_family[i].ToString() + "</font>");
            }
            sb.AppendLine("</font_family>");
            sb.AppendLine("<setting>");
            sb.AppendLine(" <grid_color>" + grid_color + "</grid_color>");
            sb.AppendLine(" <grid_color_nm>" + grid_color_nm + "</grid_color_nm>");
            sb.AppendLine(" <grid_spans>" + grid_spans + "</grid_spans>");
            sb.AppendLine(" <grid_form>" + grid_form + "</grid_form>");
            sb.AppendLine(" <encoding>" + encoding + "</encoding>");
            sb.AppendLine(" <doctype>" + doctype + "</doctype>");
            sb.AppendLine(" <xmlnsname>" + xmlnsname + "</xmlnsname>");
            sb.AppendLine(" <doc_lang>" + doc_lang + "</doc_lang>");
            sb.AppendLine(" <lang>" + lang + "</lang>");
            sb.AppendLine(" <width>" + width + "</width>");
            sb.AppendLine(" <height>" + height + "</height>");
            sb.AppendLine(" <skinname>" + skinname + "</skinname>");
            sb.AppendLine(" <font_family>" + setting_font_family + "</font_family>");
            sb.AppendLine(" <font_size>" + setting_font_size + "</font_size>");
            //sb.AppendLine(" <enter_tag>" + enter_tag + "</enter_tag>");
            //sb.AppendLine(" <shift_enter_tag>" + shift_enter_tag + "</shift_enter_tag>");
            sb.AppendLine(" <accessibility>" + accessibility + "</accessibility>");
            sb.AppendLine(" <topmenu>" + topmenu + "</topmenu>");
            sb.AppendLine(" <toolbar>" + toolbar + "</toolbar>");
            sb.AppendLine(" <statusbar>" + statusbar + "</statusbar>");
            sb.AppendLine(" <showdialog_pos>" + showdialog_pos + "</showdialog_pos>");
            sb.AppendLine("</setting>");
            sb.AppendLine("<uploader_setting>");
            sb.AppendLine(" <develop_langage>" + develop_langage + "</develop_langage>");
            sb.AppendLine(" <handler_url>" + handler_url + "</handler_url>");
            sb.AppendLine(" <to_save_path_url>" + to_save_path_url + "</to_save_path_url>");
            sb.AppendLine(" <save_foldername_rule>" + save_foldername_rule + "</save_foldername_rule>");
            sb.AppendLine(" <save_filename_rule>" + save_filename_rule + "</save_filename_rule>");
            sb.AppendLine(" <image_convert_format>" + image_convert_format + "</image_convert_format>");
            sb.AppendLine(" <image_convert_width>" + image_convert_width + "</image_convert_width>");
            sb.AppendLine(" <image_convert_height>" + image_convert_height + "</image_convert_height>");
            sb.AppendLine("</uploader_setting>");
            sb.AppendLine("</dext5>");

            try
            {
                File.WriteAllText(physical_path + @"\dext5\config\dext_editor.xml", sb.ToString(), Encoding.UTF8);

                //File.Delete(physical_path + @"\dext5\config\dext_editor_bakup.xml");

                Response.Redirect(page_url + "?page_mode=excute");
            }
            catch (Exception ex)
            {
                Response.Write("<script type='text/javascript'>");
                Response.Write("alert('dext_editor.xml에 대한 액세스가 거부되었습니다. 읽기 전용이라면 읽기 전용을 해제하여 주십시오');");
                Response.Write("self.location.href='" + page_url + "'");
                Response.Write("</script>");
            }
        }
    }

    public String nullCheck(string str)
    {
        if (str == null || str.Trim().Equals(""))
        {
            return "";
        }
        else
        {
            return str;
        }
    }
}