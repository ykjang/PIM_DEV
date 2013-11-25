<%@page import="javax.xml.soap.SOAPMessage"%>
<%@page import="javax.xml.transform.stream.StreamResult"%>
<%@page import="javax.xml.transform.Source"%>
<%@page import="javax.xml.transform.Transformer"%>
<%@page import="javax.xml.transform.TransformerFactory"%>
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    <link rel="stylesheet" type="text/css" href="/lib/bootstrap/font-awesome/css/font-awesome.css">

	<!-- jQuery -->
	<script src="/lib/jquery-1.8.1.min.js"></script>
	<link rel="stylesheet" type="text/css" media="screen" href="/lib/ui/theme/smoothness/jquery-ui-1.9.2.custom.css" />
	<!-- jQuery -->
	
	<script src="/lib/bootstrap/js/bootstrap.js"></script>
	    
   	<!-- jqGrid -->
	<link rel="stylesheet" type="text/css" href="/lib/jqgrid/css/ui.jqgrid.css">
   	<script type="text/javascript" src="/lib/jqgrid/js/i18n/grid.locale-en.js"></script>
	<script type="text/javascript" src="/lib/jqgrid/js/jquery.jqGrid.min.js"></script>
	<!-- jqGrid -->
		
	<!-- Common CSS/JS -->
    <link rel="stylesheet" type="text/css" href="/lib/common.css">
    <script src="/lib/common.js" type="text/javascript"></script>
    
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    
    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="/assets/ico/favicon.ico">
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
	<div class="header">
	    <div class="stats">
		    <p class="stat"><span class="number">93%</span>Deliverate</p>
		    <p class="stat"><span class="number">12,000</span>Send</p>
		    <p class="stat"><span class="number">1,500</span>User</p>
		</div>
	    <h1 class="page-title">Register CatalogEntry</h1>
 	</div>
	 	
 	<!-- location bar -->
  	<ul class="breadcrumb">
      <li><a href="/index.do">Home</a> <span class="divider">/</span></li>
      <li><a href="#">WebService</a><span class="divider">/</span></li>
      <li class="active">CatalogEntry Register</li>
  	</ul>
	  	
	<div class="container-fluid">
	<div class="row-fluid">
	
			<!-- Contents Area S -->
			<div class="row-fluid">
				<div class="span12">
					
					<ul class="nav nav-tabs" id="catRegTab">
					  <li><a href="#basic" data-toggle="tab">Basic Info</a></li>
					  <li><a href="#desc-attr" data-toggle="tab">Descriptive Attribute</a></li>
					  <li><a href="#defi-attr" data-toggle="tab">Defining Attributes</a></li>
					</ul>
					
					<!-- Tab S -->
					<div class="tab-content">
					  <div class="tab-pane active" id="basic">
					  
					  	<div class="row-fluid">
							<div class="span12">
		   						<button class="btn btn-small pull-right" id="btn_register" type="button">Register</button>
							</div>
						</div>
					  
					  	<!-- Accordian Area S -->
						<div class="accordion" id="accord_catReg">
						  <!-- General Information S -->
						  <div class="accordion-group">
						    <div class="accordion-heading">
						      <a class="accordion-toggle" data-toggle="collapse" data-parent="accord_catReg" href="#cateReg_info_1">
						        General Product Information
						      </a>
						    </div>
						    <div id="cateReg_info_1" class="accordion-body collapse in">
						      <div class="accordion-inner">
						        
								<!-- Form Data S -->
								<form class="form-horizontal">
								  <div class="control-group">
								    <label class="control-label" for="">Code</label>
								    <div class="controls">
								      <input class="span6" type="text" id="PartNumber" placeholder="Product Code">
								    </div>
								  </div>
								  <div class="control-group">
								    <label class="control-label" for="">Name</label>
								    <div class="controls">
								      <input class="span6" type="text" id="Name" placeholder="Name(United States English)">
								    </div>
								  </div>
								  <div class="control-group">
								    <label class="control-label" for="">Short description</label>
								    <div class="controls">
								      <input class="span12" type="text" id="ShortDescription" placeholder="Short description(United States English)">
								    </div>
								  </div>
								  
								  <div class="control-group">
								    <label class="control-label" for="">Long description</label>
								    <div class="controls">
								      <input type="hidden" id="LongDescription">
								      <!--에디터 영역-->
									 <script type="text/javascript" src="/dext5/js/dext5editor.js"></script>
						                 <script type="text/javascript">
						                     DEXT5.config.Height = "300px";
						                     DEXT5.config.Width = "100%";
						                     DEXT5.config.SkinName = "gray";
						                     
						                     DEXT5.config.InitXml = "dext_editor.xml";   // ex)  DEXT5.config.InitXml = "dext_editor_mobile.xml"; //config 폴더 안의 파일 이름만 지정
						                     var editor1 = new Dext5editor("editor1");
						                 </script>
						             <!--에디터 영역-->
								    </div>
								  </div>
								  <div class="control-group">
								    <label class="control-label" for="">keywords</label>
								    <div class="controls">
								      <textarea class="span6" id="Keyword" rows="3" placeholder="keywords(United States English)"></textarea>
								    </div>
								  </div>
								  <div class="control-group">
								    <label class="control-label" for="">Manufacturer</label>
								    <div class="controls">
								      <input class="span6" type="text" id="manufact" placeholder="Manufacturer">
								    </div>
								  </div>
								  <div class="control-group">
								    <label class="control-label" for="">Manufacturer part number</label>
								    <div class="controls">
								      <input class="span6" type="text" id="manufactNo" placeholder="Manufacturer part number">
								    </div>
								  </div>
								  
								  <div class="control-group">
								    <label class="control-label" for="">Parent CatalogGroup ID</label>
								    <div class="controls">
								      <input class="span6" type="text" id="pCatGrpId" placeholder="Parent CatalogGroup ID" value="10008">
								    </div>
								  </div>
								  
								  <input type="hidden" id="storeId" value="10001">
								  <input type="hidden" id="catalogId" value="10001">
								  <input type="hidden" id="masterCatalog" value="true">
								  
								  <input type="hidden" id="ownerID" value="7000000000000000002">
								</form>
								<!-- Form Data E -->
	
						      </div>
						    </div>
						  </div>
						  <!-- General Information E -->
						  <!-- Publishing Area S -->
						  <div class="accordion-group">
						    <div class="accordion-heading">
						      <a class="accordion-toggle" data-toggle="collapse" data-parent="accord_catReg" href="#cateReg_info_2">
						        Publishing
						      </a>
						    </div>
						    <div id="cateReg_info_2" class="accordion-body collapse">
						      <div class="accordion-inner">
						        Publishing...
						      </div>
						    </div>
						  </div>
						  <!-- Publishing Area E -->
						  <!-- Display Area S -->
						  <div class="accordion-group">
						    <div class="accordion-heading">
						      <a class="accordion-toggle" data-toggle="collapse" data-parent="accord_catReg" href="#cateReg_info_3">
						        Display Information 
						      </a>
						    </div>
						    <div id="cateReg_info_3" class="accordion-body collapse">
						      <div class="accordion-inner">
						        Display Information...
						      </div>
						    </div>
						  </div>
						  <!-- Display Area E -->
						  <!-- Pricing Area S -->
						  <div class="accordion-group">
						    <div class="accordion-heading">
						      <a class="accordion-toggle" data-toggle="collapse" data-parent="accord_catReg" href="#cateReg_info_4">
						        Pricing Information
						      </a>
						    </div>
						    <div id="cateReg_info_4" class="accordion-body collapse">
						      <div class="accordion-inner">
						        Pricing Information...
						      </div>
						    </div>
						  </div>
						  <!-- Pricing Area E -->
						  <!-- Custom Area S -->
						  <div class="accordion-group">
						    <div class="accordion-heading">
						      <a class="accordion-toggle" data-toggle="collapse" data-parent="accord_catReg" href="#cateReg_info_5">
						        Custom Information
						      </a>
						    </div>
						    <div id="cateReg_info_5" class="accordion-body collapse">
						      <div class="accordion-inner">
						        Custom Information...
						      </div>
						    </div>
						  </div>
						  <!-- Custom Area E -->
						</div><!-- Accordian Area E -->
						
						
						<div class="row-fluid">
							<div class="span12">
		   						<button class="btn btn-small pull-right" id="btn_register" type="button">Register</button>
							</div>
						</div>
						
					  </div><!-- Basic Info Tab E -->
					  <div class="tab-pane" id="desc-attr">descriptive attributes</div>
					  <div class="tab-pane" id="defi-attr">defining attributes</div>
					</div><!-- Tab Area E -->
				</div><!-- span12 E -->
	 		</div><!-- row-fluid E -->
			<div class="row-fluid">
				<div class="span12">
					
				</div>
			</div>
			<!-- Contents Area S -->
	<!--===================== Bottom Menu Area S =====================-->
	<%@ include file="/inc/inc_bottom.html" %>
	<!--===================== Bottom Menu Area E =====================-->
	</div><!--/row-fluid-->    
 	</div><!--/container-fluid-->    
</div><!--/content-->               
    

<div id="loginAlert" class="alert alert-error" style="display:none;">
    <!-- <button type="button" class="close" data-dismiss="alert">x</button> -->
</div>
    
    <script type="text/javascript">
		$(document).ready(function() {
	    	
			$('#catRegTab a[href="#basic"]').tab('show'); // Select tab by name
			//$('#myTab a:first').tab('show'); // Select first tab
			//$('#myTab a:last').tab('show'); // Select last tab
			//$('#myTab li:eq(2) a').tab('show'); // Select third tab (0-indexed)
			
			
			$('button#btn_register').click(function(){
	    		
				var REQ_XPATH = "/CatalogEntry[1]";
				
				// BOD Parameter
				var STORE_ID = $('input#storeId').val();
				var CATALOG_ID = $('input#catalogId').val();
				var MASTER_CATALOG = $('input#masterCatalog').val();
				  
				// Identity			
				var ownerID = $('input#ownerID').val();
				var PartNumber = $('input#PartNumber').val();
				var pCatGrpId = $('input#pCatGrpId').val();
				
				
				$('input#LongDescription').val(DEXT5.getHtmlValueEx());
				
				// DESCIRPTION - 언어별 배열
	    		var desc_Attributes = new Array();
	    		desc_Attributes[0] = { Name: "published", Value: "1" };
	    		desc_Attributes[1] = { Name: "available", Value: "1" };
	    		desc_Attributes[1] = { Name: "availabilityDate", Value: "" };
	    		desc_Attributes[2] = { Name: "auxDescription1", Value: "images/Brake_Pad1-45.jpg" };
	    		desc_Attributes[3] = { Name: "auxDescription2", Value: "images/Brake_Pad1-45.jpg" };
				
				var description = new Array();
				description[0] = {
					language: "-1",
					Name: $('input#Name').val(),
					Thumbnail: "images/Brake_Pad1-50.jpg",
					FullImage: "images/Brake_Pad1-150.jpg",
					ShortDescription: $('input#ShortDescription').val(),
					LongDescription: $('input#LongDescription').val(),
					Keyword: $('#Keyword').val(),
					Attributes: desc_Attributes
				};
	    		
				
				// CatalogEntryAttributes - General Attributes
				var catEnt_Attributes = new Array();
				catEnt_Attributes[0] = { Name: "manufacturerPartNumber", Value: $('input#manufactNo').val() };
				catEnt_Attributes[1] = { Name: "manufacturer", Value: $('input#manufact').val() };

				
	    		// DESCIRPTIVE Attributes
	    		var descriptive_Attributes = new Array();
	    		
	    		// DEFINING Attributes
	    		var defining_Attributes = new Array();
	    		
	    		
	    		var catEnt = new Object();
	    		catEnt = {
	    			'ownerID': ownerID,
	    			'PartNumber': PartNumber,
	    			'pCatGrpId': pCatGrpId,
	    			
	    			'Description': description,
	    			'CatalogEntryAttributes': catEnt_Attributes,
	    			'DescriptiveAttributes': descriptive_Attributes,
	    			'DefiningAttributes': defining_Attributes
	    		};
	    		
	    		
	    		
	    		var paramObj = new Object();
	    		paramObj = {
	    			'REQ_XPATH': REQ_XPATH,
    				'STORE_ID': STORE_ID,
	    			'CATALOG_ID': CATALOG_ID,
	    			'MASTER_CATALOG': MASTER_CATALOG,
	    			
	    			'CATENTRY': catEnt
	    		};
	    		
	    		
	    		console.debug(paramObj);
	    		
	    		$.ajax({
	    			url: '/ws/RegisterCatEnt.jsonp',
	   				type: 'POST',
	   				contentType: 'application/json',
	   			  	data: JSON.stringify(paramObj),
	   			  	
	   				success: function(data) {
   							
						if(data.RESULT == 'R00'){
		   					$('#loginAlert').html("ID does not exist or Password is incorrect.");
				   			$('#loginAlert').show();
						}
   					},
	    		
	    		}); // End Ajax
	    		
			}); // End Click
	    }); // End Init
	    
    </script>
  </body>
</html>


