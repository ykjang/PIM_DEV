<%@ WebHandler Language="C#" Class="logout_excute" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Xml;
using System.IO;

public class logout_excute : IHttpHandler, IRequiresSessionState{
    
    public void ProcessRequest (HttpContext context) {
        context.Session.Remove("id");
        context.Response.Redirect("login.aspx");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}