<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="config.jsp" %>
<%@ page import="java.sql.*"%>
<%
	int seq = 0;
	if(request.getParameter("seq") != null){
		seq = Integer.parseInt(request.getParameter("seq"));
	}
	
	String sdate = "";
	String stitle = "";
	int ivwcnt = 0;
	String sname = "";
	
	String view_cnt_qry = "UPDATE UT_EDITOR SET UE_VIEW_CNT = UE_VIEW_CNT + 1 WHERE UE_SEQ = ?";
	String qry = "SELECT UE_TITLE, UE_CREATE_DT, UE_VIEW_CNT, UE_USR_NM FROM UT_EDITOR WHERE UE_SEQ = ?";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try
	{
		Class.forName(DV_G_JDBC_DRIVER_NAME);		
		conn = DriverManager.getConnection(DV_G_DB_URL, DV_G_DB_USER, DV_G_DB_PWD);
		
		pstmt = conn.prepareStatement(view_cnt_qry);
		pstmt.clearParameters();
		pstmt.setInt(1, seq);
	
		pstmt.executeUpdate();
		
		pstmt = null;
		
		pstmt = conn.prepareStatement(qry);
		pstmt.clearParameters();
		pstmt.setInt(1, seq);
	
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			sdate = rs.getString("UE_CREATE_DT");
			stitle = rs.getString("UE_TITLE");
			ivwcnt = rs.getInt("UE_VIEW_CNT");
			sname = rs.getString("UE_USR_NM");
		}
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
%>
<!DOCTYPE html>
<html lang="en">
 <head>
    <meta charset="utf-8">
    <title>PIM Test System</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" type="text/css" href="/lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/lib/bootstrap/stylesheets/theme.css">
    <link rel="stylesheet" href="/lib/bootstrap/font-awesome/css/font-awesome.css">

	<style type="text/css">
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .brand { font-family: georgia, serif; }
        .brand .first {
            color: #ccc;
            font-style: italic;
        }
        .brand .second {
            color: #fff;
            font-weight: bold;
        }
    </style>

	<script src="/lib/jquery-1.8.1.min.js"></script>
	<script src="/lib/bootstrap/js/bootstrap.js"></script>
		
	<!-- Common CSS/JS -->
    <link rel="stylesheet" type="text/css" href="/lib/common.css">
    <script src="/lib/common.js" type="text/javascript"></script>
    
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="../assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="/assets/ico/apple-touch-icon-57-precomposed.png">
  </head>
  <!--[if lt IE 7 ]> <body class="ie ie6"> <![endif]-->
  <!--[if IE 7 ]> <body class="ie ie7 "> <![endif]-->
  <!--[if IE 8 ]> <body class="ie ie8 "> <![endif]-->
  <!--[if IE 9 ]> <body class="ie ie9 "> <![endif]-->
  <!--[if (gt IE 9)|!(IE)]><!--> 
  <body class=""> 
  <!--<![endif]-->
  
  <!--===================== Top Menu Bar S =====================-->
  <%@ include file="/inc/inc_top.html" %>
  <!--===================== Top Menu Bar E =====================-->
  
  <!--===================== Side Menu Area S =====================-->
  <%@ include file="/inc/inc_sidemenu.jsp" %>
  <!--===================== Side Menu Area E =====================-->

    
<div class="content">
	<!-- Title Bar -->	
	<div class="header">
	    <!-- <div class="stats">
		    <p class="stat"><span class="number">93%</span>Deliverate</p>
		    <p class="stat"><span class="number">12,000</span>Send</p>
		    <p class="stat"><span class="number">1,500</span>User</p>
		</div> -->
	    <h1 class="page-title">DEXT5 Editor Sample Page</h1>
 	</div>    
    <!-- location bar -->
    <ul class="breadcrumb">
    	<li><a href="/index.do">Home</a> <span class="divider">/</span></li>
    	<li><a href="#">WebEditor Sample</a><span class="divider">/</span></li>
        <li class="active">DEXT5 Editor Sample Page</li>
    </ul>
    
<div class="container-fluid">

	<div class="row-fluid">
		<div class="span12">
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
		    <blockquote>
		    	<p><%=stitle%></p>
		    	<small>작성자:<%=sname%>&nbsp;&nbsp;|&nbsp;&nbsp;작성일:<%=sdate.substring(0,10)%>&nbsp;&nbsp;|&nbsp;&nbsp;조회:&nbsp;<%=ivwcnt%></small>
		    </blockquote>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span10">
			<a href="javascript:fList()"><button class="btn btn-small" type="button">&nbsp;&nbsp;list&nbsp;&nbsp;</button></a>
			<a href="javascript:fDelete(document.getElementById('btnDel2'), event)"><button class="btn btn-small btn-danger pull-right" type="button">delete</button></a>
			<a href="javascript:fModify()"><button class="btn btn-small pull-right" type="button">modify</button></a>
		</div>
	</div>
	<div class="row-fluid">
		<div class="block span10">
    <!-- <div id="div_pwd" style="width: 280px; visibility: hidden; position: absolute; z-index: 2;">
        <table align="left" style="border-right-color: #808080; background-color: #D0CED6" border="0" width="280" cellpadding="3" cellspacing="1">
            <tr>
                <td width="85" style="background-color: #F6F6F6; color:#666666;" class="cyan12" align="center">
                    <strong>비밀번호</strong>
                </td>
                <td width="180" style="background-color: #FFFFFF">
                	<input type="password" id="tbPwd" name="tbPwd" style="width:80px;" class="input2"/>
                    <a href="javascript:fDelTask()">
                        <img src="/images/bt4_ok.gif" hspace="5" border="0" style="vertical-align: middle" alt="확인" />
                    </a> 
                    <a href="javascript:fDelHidden()">
                        <img src="/images/i_delete.gif" border="0" style="vertical-align: middle" alt="닫기"/>
                    </a>
                </td>
            </tr>
        </table>
    </div> -->
    
    <%--
		String scontents = "";
		String qry1 = "SELECT UE_CONTENTS FROM UT_EDITOR WHERE UE_SEQ = ?";
		
		try
		{
			pstmt = null;
			
			pstmt = conn.prepareStatement(qry1);
			pstmt.clearParameters();
			pstmt.setInt(1, seq);
		
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				scontents = rs.getString("UE_CONTENTS");
			}
			
			out.println(scontents);
		}
		catch(Exception e)
		{
			out.println(e.toString());
		}
    --%>
    <iframe id="frmid" name="frmid" src="view_cont.do?seq=<%=seq%>" width="100%" height="500px" frameborder="0" scrolling="auto"></iframe>
    </div>
    <div class="row-fluid">
		<div class="span10">
			<a href="javascript:fList()"><button class="btn btn-small" type="button">&nbsp;&nbsp;list&nbsp;&nbsp;</button></a>
			<a href="javascript:fDelete(document.getElementById('btnDel2'), event)"><button class="btn btn-small btn-danger pull-right" type="button">delete</button></a>
			<a href="javascript:fModify()"><button class="btn btn-small pull-right" type="button">modify</button></a>
		</div>
	</div>
	                        
	<form name="frmData" runat="server">
		<input type="hidden" name="hidSeq" id="hidSeq" value="<%=seq%>" />
		<input type="hidden" id="hidMod" name="hidMod" value="del" />    
	</form>


<!--===================== Bottom Menu Area S =====================-->
		<%@ include file="/inc/inc_bottom.html" %>
		<!--===================== Bottom Menu Area E =====================-->
	    </div>
	</div><!-- /container-fluid -->
</div><!--/content-->
    
    
    <!-- <link rel="stylesheet" href="/dext5_sample.css" type="text/css" /> -->
    <script type="text/javascript" src="/dext5/js/dext5editor.js"></script>
    <script type="text/javascript" src="/common.js"></script>
    <script language="javascript" type="text/javascript">
        function fList() {
            window.self.location.href = "/dext5/index.do";
        }

        function fDelete(obj, event) {
            var clickedRect = getClientRect(obj);

            $("div_pwd").style.top = (clickedRect.top - 4) + document.documentElement.scrollTop + "px";
            $("div_pwd").style.left = (clickedRect.left - 283) + document.documentElement.scrollLeft + "px";
            $("div_pwd").style.visibility = "visible";
        }

        function fModify() {
            window.self.location.href = "/dext5/modify.do?seq=" + $("hidSeq").value;
        }

        function fDelHidden() {
            $("div_pwd").style.visibility = "hidden";
        }

        function fDelTask() {
            if ($("tbPwd").value == "") {
                alert("글 작성 시 입력하셨던 비밀번호를 입력하십시오.");
                $("tbPwd").focus();
                return;
            }
            var str = formData2QueryString(window.document.frmData);
            xmlhttpPost("/dext5/db_task.do", str, "del_result");
        }

        function del_result(p_rtn) {
            if (p_rtn == "") {
                fList();
            } else if (p_rtn == "-1") {
                alert("비밀번호가 틀렸습니다. 다시 입력해주십시오.");
                $("tbPwd").focus();
            } else {
                alert(p_rtn);
            }
        }

        function getClientRect(obj) {
            var rect = obj.getBoundingClientRect();

            //Can modify

            return rect;
        }
    </script>
    
</body>
</html>
