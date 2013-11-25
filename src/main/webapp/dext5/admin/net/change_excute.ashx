<%@ WebHandler Language="C#" Class="change_excute" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Xml;
using System.IO;
using System.Text;

public class change_excute : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        string password = "";
        string new_pw = "";

        if (null != context.Request["password"])
        {
            password = context.Request["password"].ToString();
        }

        if (null != context.Request["new_pw"])
        {
            new_pw = context.Request["new_pw"].ToString();
        }

        string physical_path = HttpContext.Current.Request.PhysicalApplicationPath;
        string product_key = "";

        try
        {
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.Load(physical_path + @"\dext5\config\dext_editor.xml");
            XmlElement root = xmldoc.DocumentElement;
            XmlNodeList nodes = root.ChildNodes;

            foreach (XmlNode node in nodes)
            {
                if (node.Name == "license")
                {
                    foreach (XmlNode license_node in node)
                    {
                        if (license_node.Name == "product_key")
                        {
                            product_key = license_node.InnerText;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            context.Response.Write(ex.Message.ToString());
        }

        string save_password = "ZGV4dDVhZG1pbg==";
        string sPath = physical_path + @"dext5\admin\net\" + product_key + ".txt";
        if (File.Exists(sPath))
        {
            TextReader trs = new StreamReader(sPath);
            save_password = trs.ReadLine();
            trs.Close();
        }
        
        string result = "2";
        string message = "비밀번호 변경 중 오류가 발생했습니다.";

        if (!password.Equals(save_password))
        {
            result = "1";
            message = "현재 비밀번호가 맞지 않습니다.";
        }
        else
        {
            try
            {
                File.WriteAllText(sPath, new_pw, Encoding.UTF8);
                result = "3";
            }
            catch (Exception ex)
            {
            }
        }
        context.Response.ContentType = "text/xml";
        context.Response.Write("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
        context.Response.Write("<change>");
        context.Response.Write("<result>" + result + "</result>");
        context.Response.Write("<message><![CDATA[" + message + "]]></message>");
        context.Response.Write("</change>");
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}
