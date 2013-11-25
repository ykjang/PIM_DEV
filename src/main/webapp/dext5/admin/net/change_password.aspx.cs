using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dext5_admin_NET_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = "";
        
        if (null != Session["id"])
        {
            id = Session["id"].ToString();
        }

        if (!id.Equals("admin"))
        {
            Response.Redirect("login.aspx");
        }
    }
}