<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="config.jsp" %>
<%@ page import="java.sql.*"%>
<%
	String query = "SELECT UE_SEQ, UE_TITLE, UE_VIEW_CNT, UE_CREATE_DT FROM UT_EDITOR ORDER BY UE_SEQ DESC LIMIT 10";
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try
	{
		Class.forName(DV_G_JDBC_DRIVER_NAME);
		conn = DriverManager.getConnection(DV_G_DB_URL, DV_G_DB_USER, DV_G_DB_PWD);
	
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
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

		<div class="block span12">
        	<a href="#tablewidget" class="block-heading" data-toggle="collapse">Contents List<span class="label label-warning">+10</span></a>
        	<div id="tablewidget" class="block-body collapse in">
				</br>
				<div class="row-fluid">
					<div class="span12">
			             <a href="javascript:fnRefresh()"><button class="btn btn-small" type="button">refresh</button></a>
  						 <a href="javascript:fWrite('ko')"><button class="btn btn-small btn-primary pull-right" type="button">write</button></a>
					</div>
				</div>
				<input type="hidden" id="hidCurrPageNum" runat="server" />
				<table class="table">
					<thead>
		                <tr>
		                  <th>No</th>
		                  <th width="*">Title</th>
		                  <th style="width: 82px;">Date</th>
		                  <th style="width: 64px;">Count</th>
		                  <th style="width: 82px;">Oper</th>
		                </tr>
	              	</thead>
	              	<tbody>
					<%
						String vSeq = "";
						String vTitle = "";
						String vName = "";
						String vDate = "";
						String vVwCnt = "";
						
						boolean cheak = false;
					
						while(rs.next())
						{
							cheak = true;
							vSeq = rs.getString("UE_SEQ");
							vTitle = rs.getString("UE_TITLE");
							vDate = rs.getString("UE_CREATE_DT");
							vVwCnt = rs.getString("UE_VIEW_CNT");
					%>
						<tr>
							<td>
								<%=vSeq%>
							</td>
							<td width="*">
								<%=vTitle%>
							</td>
							<td>
								<%=vDate.substring(0,10)%>
							</td>
							<td>
								<%=vVwCnt%>
							</td>
							<td>
								<a href="javascript:fView('<%=vSeq%>');"><i class="icon-search"></i></a>&nbsp;
								<a href="javascript:fModify('<%=vSeq%>');"><i class="icon-edit"></i></a>
							</td>
						</tr>
					<% } %>
					<% if(!cheak) { %>
					<tr>
						<td height="300" colspan="7">
							<img src="/images/img_nodata.gif" width="44" height="38" />
							<br />작성된 글이 없습니다.
						</td>
					</tr>
					<% } %>
					</tbody>
				</table>
			</div>
		</div>
		
		
    
	    <!--===================== Bottom Menu Area S =====================-->
		<%@ include file="/inc/inc_bottom.html" %>
		<!--===================== Bottom Menu Area E =====================-->
	    </div>
	</div><!-- /container-fluid -->
</div><!--/content-->

    <!-- <link rel="stylesheet" href="/dext5_sample.css" type="text/css" /> -->
	<script type="text/javascript" src="/common.js"></script>
    <script type="text/javascript">
		$(document).ready(function() {
	    });
		
		function fnRefresh() {
        	window.self.location.href = "/dext5/index.do";
        }

        function fWrite(lang) {
            if (lang == "ko")
                window.self.location.href = "/dext5/write.do";
            else
                window.self.location.href = "/dext5/write_en.do";
        }

        function fView(pIdx) {
            window.self.location.href = "/dext5/view.do?seq=" + pIdx;
        }
        
        function fModify(pIdx) {
            window.self.location.href = "/dext5/modify.do?seq=" + pIdx;
        }
    </script>
    
</body>    
</html>
