<%@ WebHandler Language="C#" Class="upload_handler" %>

using System;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web;
using System.Net;

public class upload_handler : IHttpHandler
{
	private static char m_PathChar = System.IO.Path.DirectorySeparatorChar;
    private string proxy_url = "";
	private string upload_type;
	private string save_file_name;
	private string save_file_ext;
	private string to_save_path_url = "";
    private string save_foldername_rule = "";
    private string save_filename_rule = "";
    
	private string sub_path = "";
	private string server_domain = ""; // 이미지가 저장되는 웹서버 도메인
	private string save_path = "";

	private string image_convert_format = "";
	private string image_convert_width = "";
	private string image_convert_height = "";
	private int resize_width = 0;
	private int resize_height = 0;


	private string _allowFileExt = "gif, jpg, jpeg, png, bmp, wmv, asf, swf, avi, mpg, mpeg, mp4";
	private bool isSaveFileExt = false;

    public void ProcessRequest (HttpContext context)
	{
        context.Response.ContentType = "text/html";
        string return_url = context.Request.QueryString["return_url"];
		if (null != return_url && return_url.Length > 0)
        {
			context.Response.Write(return_url);
            context.Response.End();
        }
        
		string dext_install = context.Request.QueryString["dext"];
		if (null != dext_install && dext_install.Length > 0)
		{
			context.Response.Write("Hi, DEXT5 Editor !!!! " + dext_install);
			context.Response.End();
		}

        string saveas = context.Request.QueryString["saveas"];
        if (null != saveas && saveas.Length > 0)
        {
            FileSave(context, context.Request["html"].ToString(), context.Request["url"].ToString());
        }
        
        proxy_url = context.Request.Form["proxy_url"];
		upload_type = context.Request.Form["uploadtype"];
		save_file_ext = context.Request.Form["savefileext"];
		server_domain = context.Request.Form["serverdomain"];
        to_save_path_url = context.Request.Form["tosavepathurl"];
        save_foldername_rule = context.Request.Form["savafoldernamerule"];
        save_filename_rule = context.Request.Form["savafilenamerule"];

		image_convert_format = context.Request.Form["image_convert_format"];
		image_convert_width = context.Request.Form["image_convert_width"];
		image_convert_height = context.Request.Form["image_convert_height"];


		if (null == proxy_url) { proxy_url = ""; }
		if (null == image_convert_format || image_convert_format != "jpg") { image_convert_format = ""; }
		if (null == image_convert_width || image_convert_width == "") { image_convert_width = "0"; }
		if (null == image_convert_height || image_convert_height == "") { image_convert_height = "0"; }
		resize_width = int.Parse(image_convert_width);
		resize_height = int.Parse(image_convert_height);

		save_file_name = new Random().Next(99999).ToString();
		save_file_name = save_file_name.PadLeft(5, '0');
		save_file_name = string.Format("{0}{1}", DateTime.Now.ToString("yyyyMMdd_HHmmssfff_"), save_file_name);

		// ==============================================================
		if (upload_type != null && upload_type == "plugin") { upload_type = "image"; }

		if (upload_type != null && upload_type == "pluginkey")
		{
			_allowFileExt = _allowFileExt + ", cab";
			save_file_name = context.Request.Form["savefilename"];
		}
		// ==============================================================
		
		if (null == server_domain) { server_domain = ""; }
        
		if (server_domain.Equals(""))
		{
			server_domain = context.Request.Url.Scheme + "://" + context.Request.Url.Host;
			if (context.Request.Url.Port != 80) { server_domain += (":" + context.Request.Url.Port); }
		}

		string AppPath = context.Request.ApplicationPath;
		AppPath = AppPath.TrimEnd('/');

		if (save_foldername_rule.Length > 2)
		{
			save_foldername_rule = save_foldername_rule.Replace("YYYY", "yyyy").Replace("DD", "dd");
			sub_path = DateTime.Now.ToString(save_foldername_rule).Replace("-", "/");
		}
		else { sub_path = ""; }
		
		to_save_path_url = to_save_path_url + "/" + sub_path;

		if (!to_save_path_url.StartsWith("/") || to_save_path_url.Equals("")) save_path = AppPath + "/" + to_save_path_url;
		else { save_path = to_save_path_url; }
		
		save_path = save_path + "/";
		save_path = save_path.Replace("//", "/");
		
		DEXTFileSave(context);
    }

	
	private void DEXTFileSave(HttpContext ctx)
	{
		string[] checkFileExt;
		checkFileExt = _allowFileExt.Split(new Char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
		
		int checkCount = checkFileExt.Length;

		// 파일 확장자 체크
		if (save_file_ext.Trim().Length > 0)
		{
			foreach (string check_ext in checkFileExt)
			{
				if (save_file_ext.Equals(check_ext.Trim().ToLower())) { isSaveFileExt = true; }
			}
		}

		string rtn_message = "";
		
		// 이미지 파일 저장
		if (isSaveFileExt == true)
		{
			try
			{
				string save_real_path = ctx.Request.MapPath(save_path);
				if (System.IO.Directory.Exists(save_real_path) == false) { System.IO.Directory.CreateDirectory(save_real_path); }
				
				
				string save_real_file = save_real_path + save_file_name + "." + save_file_ext;

				if (ctx.Request.Files.Count < 1)
				{
					byte[] image_bytes = ctx.Request.BinaryRead(ctx.Request.TotalBytes);
					if (image_bytes.Length > 0) { System.IO.File.WriteAllBytes(save_real_file, image_bytes); }
				}
				else
				{
					ctx.Request.Files[0].SaveAs(save_real_file);

					if (save_file_ext.Equals("bmp")) { image_convert_format = "jpg"; }

					if (upload_type == "image" && (image_convert_format == "jpg" || resize_width > 0 || resize_height > 0))
					{
						image_convert_format = "jpg";
						
						if (DEXTImageResize(save_real_path, save_file_name, save_file_ext))
						{
							File.Delete(save_real_path + save_file_name + "." + save_file_ext);					
							save_file_ext = image_convert_format;
							save_file_name = save_file_name + "_r";
						}
					}
				}

				

				rtn_message = server_domain + save_path + save_file_name + "." + save_file_ext;
				
                if (!proxy_url.Equals(""))
                {
					rtn_message = "<script> window.location.href='" + proxy_url + "?return_url=" + rtn_message + "'; </script>";
                }
			}
			catch (Exception ex)
			{
				rtn_message = "File Save Error :: " + ex.ToString();
			}
		}
		else
		{
			rtn_message = "File Save Error :: File extension does not exist";
		}

		ctx.Response.Write(rtn_message);
	}

	private bool DEXTImageResize(string org_path, string org_file_name, string org_file_ext)
	{
		bool is_convert = false;
		
		string resize_file = string.Format("{0}{1}_r.{2}", org_path, org_file_name, image_convert_format);
		
		try
		{
			using (Image img = Image.FromFile(org_path + org_file_name + "." + org_file_ext))
			{
				if (img != null)
				{
					int img_width = img.Size.Width;
					int img_height = img.Size.Height;

					if (resize_width == 0 || resize_width > img_width)
					{
						if (resize_width == 0 && resize_height > 0 && resize_height < img_width)
						{
							resize_width = (int)(img_width * (float)(resize_height / (img_height * 1.0)));
						}
						else { resize_width = img_width; }
					}

					if (resize_height == 0 || resize_height > img_height)
					{
						if (resize_height == 0 && resize_width > 0 && resize_width < img_width)
						{
							resize_height = (int)(img_height * (float)(resize_width / (img_width * 1.0)));
						}
						else { resize_height = img_height; }
					}

					ImageCodecInfo img_codec_info = GetEncoderInfo("image/jpeg");
					EncoderParameters enc_params = new EncoderParameters(1);
					enc_params.Param[0] = new EncoderParameter(Encoder.Quality, 100L);
					Bitmap bmp = new Bitmap(img, resize_width, resize_height);
					bmp.Save(resize_file, img_codec_info, enc_params);
					bmp.Dispose();
				}
			}
			is_convert =  true;
		}
		catch { }

		return is_convert;
	}

	private static ImageCodecInfo GetEncoderInfo(String mimeType)
	{
		int j;
		ImageCodecInfo[] encoders;
		encoders = ImageCodecInfo.GetImageEncoders();
		for (j = 0; j < encoders.Length; ++j)
		{
			if (encoders[j].MimeType == mimeType) { return encoders[j]; }
		}
		return null;
	}

    public void FileSave(HttpContext ctx, string html, string url)
    {
        string physical_path = HttpContext.Current.Request.PhysicalApplicationPath;

        try
        {
            File.WriteAllText(physical_path + @"\dext5\untitled.html", html);

            string download_file_path = url + "untitled.html";

            WebClient client = new WebClient();

            byte[] data = client.DownloadData(download_file_path);

            ctx.Response.Clear();
            ctx.Response.ContentType = "application/octet-stream";
            ctx.Response.AddHeader("Content-Disposition", "attachment;filename=" + "untitled.html");
            ctx.Response.AddHeader("content-length", data.Length.ToString());
            ctx.Response.AddHeader("content-transfer-encoding", "binary");

            ctx.Response.OutputStream.Write(data, 0, data.Length);
            ctx.Response.Flush();
            ctx.Response.End();

            File.Delete(physical_path + @"\dext5\untitled.html");
        }
        catch (Exception e)
        {
            //ctx.Response.Clear();
            //ctx.Response.ContentType = "text/plain";
            //ctx.Response.Write("저장 중 오류가 발생했습니다.");
            //ctx.Response.Write("입력하신 소스는 다음과 같습니다.\n\n");
            //ctx.Response.Write(html);
            //ctx.Response.End();
        }

    }
    
	public bool IsReusable { get { return false; } }

}