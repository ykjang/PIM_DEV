<%@ page contentType="text/html;charset=utf-8"%>
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
		   <a href="javascript:fList()"><button class="btn btn-small" type="button">&nbsp;&nbsp;list&nbsp;&nbsp;</button></a>
		   <a href="javascript:fSubmit()"><button class="btn btn-small pull-right" type="button">regist</button></a>
		</div>
	</div>
    <div class="row-fluid">
		<div class="span12">
			<form class="" name="frmData">
			<input type="hidden" id="hidContents" name="hidContents" value="" />
    		<input type="hidden" id="hidMod" name="hidMod" value="reg" />
			    <div class="controls ">
			      <input type="text" id="tbTitle" name="tbTitle" placeholder="Title" class="span8">
			    </div>
			  
			    <div class="controls controls-row">
			      <input type="text" id="tbName" name="tbName" placeholder="Name" class="span4">
			      <input type="password" id="tbPwd" name="tbPwd" placeholder="Password">
			    </div>
			</form>
    	</div>
    </div>
	<div class="row-fluid">
		<div class="span12">
			 <!--에디터 영역-->
			 <script type="text/javascript" src="/dext5/js/dext5editor.js"></script>
                 <script type="text/javascript">
                     //DEXT5.config.Height = "";
                     DEXT5.config.Width = "100%";
                     //DEXT5.config.SkinName = "";
                     
                     DEXT5.config.InitXml = "dext_editor.xml";   // ex)  DEXT5.config.InitXml = "dext_editor_mobile.xml"; //config 폴더 안의 파일 이름만 지정
                     var editor1 = new Dext5editor("editor1");
                 </script>
             <!--에디터 영역-->
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
    <script language="javascript" type="text/javascript">
        function fSubmit() {
            if (!chkInputData('tbTitle', "제목을 입력하십시오.")) { return; }
            if (!chkInputData('tbPwd', "비밀번호를 입력하십시오.삭제나 수정 시 필요합니다.")) { return; }

            var sBodyValue = DEXT5.getHtmlValueEx();
            if (DEXT5.isEmpty() == true) {
                alert("내용 없음.");
                return;
            }
            
            document.frmData.hidContents.value = sBodyValue;
            
            var str = formData2QueryString(window.document.frmData);
            xmlhttpPost("/dext5/db_task.do", str, "result");
        }

        function result(p_rtn) {
            if (p_rtn == "") {
                fList();
            } else {
                alert(p_rtn);
            }
        }

        function fList() {
            window.self.location.href = "/dext5/index.do";
        }

    </script>
</body>
</html>
