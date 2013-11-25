<%@ WebHandler Language="C#" Class="login_excute" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Xml;
using System.IO;

public class login_excute : IHttpHandler, IRequiresSessionState{
    
    public void ProcessRequest (HttpContext context) {
        string id = "";
        string password = "";
        
        if(null != context.Request["id"]){
            id = context.Request["id"].ToString();
        }

        if (null != context.Request["password"])
        {
            password = context.Request["password"].ToString();
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
        } catch(Exception ex){
            context.Response.Write(ex.Message.ToString());
        }
        
        string save_password = "ZGV4dDVhZG1pbg==";
        try
        {
            TextReader trs = new StreamReader(physical_path + @"\dext5\admin\net\" + product_key + ".txt");
            save_password = trs.ReadLine();
            trs.Close();
        } catch (Exception ex){
            
        }
       
        string result = "";
        string message = "";

        if (!id.Equals("admin"))
        {
            result = "1";
            message = "아이디가 일치하지 않습니다.";
        }
        else if (id.Equals("admin") && !password.Equals(save_password))
        {
            result = "2";
            message = "비밀번호가 일치하지 않습니다.";
        }
        else if (id.Equals("admin") && password.Equals(save_password))
        {
            result = "3";

            context.Session.Add("id", id);
        }
        
        context.Response.ContentType = "text/xml";
        context.Response.Write("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
        context.Response.Write("<login>");
        context.Response.Write("<result>" + result + "</result>");
        context.Response.Write("<message><![CDATA[" + message + "]]></message>");
        context.Response.Write("<id>" + id + "</id>");
        context.Response.Write("</login>");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}