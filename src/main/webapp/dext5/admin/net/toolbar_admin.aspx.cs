using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dext5_admin_NET_Default : System.Web.UI.Page
{
    public string page_mode = "";

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
        else
        {
            if (null != Request["page_mode"])
            {
                page_mode = Request["page_mode"].ToString();
            }
        }
    }
}