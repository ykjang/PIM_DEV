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
						
						<form class="form-horizontal">
						
						  <!-- General Information S -->
						  <div class="accordion-group">
						    <div class="accordion-heading">
						      <a class="accordion-toggle" data-toggle="collapse" data-parent="accord_catReg" href="#cateReg_info_1">
						        General Product Information
						      </a>
						    </div>
						    <div id="cateReg_info_1" class="accordion-body collapse in">
						      <div class="accordion-inner">
						        
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
								    <label class="control-label" for="" data-toggle="tooltip" title="title">Manufacturer</label>
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
								    <label class="control-label" for="">url</label>
								    <div class="controls">
								      <input class="span12" type="text" id="url" placeholder="url">
								    </div>
								  </div>
								  
								  <div class="control-group">
								    <label class="control-label" for="">Parent CatalogGroup ID</label>
								    <div class="controls">
								      <input class="span6" type="text" id="pCatGrpId" placeholder="Parent CatalogGroup ID" value="10083" readonly="readonly">
								    </div>
								  </div>
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
														        
					        	<div class="control-group">
								    <label class="control-label" for="">For purchase(buyable)</label>
								    <div class="controls">
								      <label class="checkbox">
										  <input type="checkbox" id="buyable" value="0">
										</label>
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">On special</label>
								    <div class="controls">
								    	<label class="checkbox">
										  <input type="checkbox" id="onSpecial" value="0">
										</label>
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">On auction</label>
								    <div class="controls">
								    	<label class="checkbox">
										  <input type="checkbox" id="onAuction" value="0">
										</label>
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">Announcement date(start date)</label>
								    <div class="controls">
								      <input class="span6" type="text" id="startDate" placeholder="Announcement date" value="2013-01-01T00:00:00.001Z">
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">Withdrawal date(end date)</label>
								    <div class="controls">
								      <input class="span6" type="text" id="endDate" placeholder="Withdrawal date" value="2013-12-31T00:00:00.001Z">
								    </div>
							  	</div>
						        
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
						        
						        <div class="control-group">
								    <label class="control-label" for="">Display to customers(published)</label>
								    <div class="controls">
								      	<label class="checkbox">
										  <input type="checkbox" id="published" value="0">
										</label>
								    </div>
							  	</div>
							  	<div class="control-group">
								    <label class="control-label" for="">Thumbnail (United States English)</label>
								    <div class="controls">
								      <input class="span6" type="text" id="thumbnail" placeholder="Thumbnail (United States English)">
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">Full image (United States English)</label>
								    <div class="controls">
								      <input class="span6" type="text" id="fullimage" placeholder="Full image (United States English)">
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">available</label>
								    <div class="controls">
								      	<label class="checkbox">
										  <input type="checkbox" id="available" value="0">
										</label>
								    </div>
							  	</div>
							  	<div class="control-group">
								    <label class="control-label" for="">availability Date</label>
								    <div class="controls">
								      <input class="span6" type="text" id="availabilityDate" placeholder="availability Date" value="">
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">auxDescription1</label>
								    <div class="controls">
								      <input class="span6" type="text" id="auxDescription1" placeholder="auxDescription1" value="">
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">auxDescription2</label>
								    <div class="controls">
								      <input class="span6" type="text" id="auxDescription2" placeholder="auxDescription2" value="">
								    </div>
							  	</div>
							  	
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
						        
						        <div class="control-group">
								    <label class="control-label" for="">Field 1 (Integer)</label>
								    <div class="controls">
								      <input class="span6" type="text" id="field1" placeholder="Field 1 (Integer)">
								    </div>
							  	</div>
						        
						        <div class="control-group">
								    <label class="control-label" for="">Field 2 (Integer)</label>
								    <div class="controls">
								      <input class="span6" type="text" id="field2" placeholder="Field 2 (Integer)">
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">Field 3 (Decimal)</label>
								    <div class="controls">
								      <input class="span6" type="text" id="field3" placeholder="Field 3 (Integer)">
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">Field 4 (Text)</label>
								    <div class="controls">
								      <input class="span6" type="text" id="field4" placeholder="Field 4 (Text)">
								    </div>
							  	</div>
							  	
							  	<div class="control-group">
								    <label class="control-label" for="">Field 5 (Text)</label>
								    <div class="controls">
								      <input class="span6" type="text" id="field5" placeholder="Field 5 (Text)">
								    </div>
							  	</div>
						        
						        
						        
						      </div>
						    </div>
						  </div>
						  <!-- Custom Area E -->
						  
						  <!--  -->
						  <input type="hidden" id="storeId" value="10051">
						  <input type="hidden" id="catalogId" value="10051">
						  <input type="hidden" id="masterCatalog" value="true">
						  
						  <input type="hidden" id="ownerID" value="7000000000000000101">
						  </form>
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
				var ACTION_CODE = "Create";
				// BOD Parameter
	    		var paramObj = new Object();
	    		paramObj = {
	    			'ACTION_CODE': ACTION_CODE,
	    			'REQ_XPATH': REQ_XPATH,
	    			
    				'STORE_ID': $('input#storeId').val(),
	    			'CATALOG_ID': $('input#catalogId').val(),
	    			'MASTER_CATALOG': $('input#masterCatalog').val(),
	    			'CATENTRY': toJsonCatEntry()
	    		};
	    		
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
	    
	    
	    function toJsonCatEntry(){
	    	
	    	//----------------- DESCIRPTION - 언어별 배열
    		var desc_Attributes = new Array();
    		desc_Attributes[0] = { Name: "published", Value: ""+$('#published:checked').length }; // Display to Customers
    		// MC 상품등록에 없는 항목
    		desc_Attributes[1] = { Name: "available", Value: ""+$('#available:checked').length };
    		desc_Attributes[2] = { Name: "availabilityDate", Value: $('input#availabilityDate').val() };
    		desc_Attributes[3] = { Name: "auxDescription1", Value: $('input#auxDescription1').val() };
    		desc_Attributes[4] = { Name: "auxDescription2", Value: $('input#auxDescription2').val() };
			
    		// Editor's HTML
			$('input#LongDescription').val(DEXT5.getHtmlValueEx());
    		
			var description = new Array();
			description[0] = {
				language: "-1",
				Name: $('input#Name').val(),
				Thumbnail: $('input#thumbnail').val(), // "images/Brake_Pad1-50.jpg"
				FullImage: $('input#fullimage').val(), // "images/Brake_Pad1-150.jpg"
				ShortDescription: $('input#ShortDescription').val(),
				LongDescription: $('input#LongDescription').val(),
				Keyword: $('#Keyword').val(),
				Attributes: desc_Attributes
			};
    		
			
			//----------------- CatalogEntryAttributes - General Attributes
			var catEnt_Attributes = new Array();
			catEnt_Attributes[0] = { Name: "manufacturerPartNumber", Value: $('input#manufactNo').val() };
			catEnt_Attributes[1] = { Name: "manufacturer", Value: $('input#manufact').val() };
			catEnt_Attributes[2] = { Name: "url",    Value: $('input#url').val() };
			catEnt_Attributes[3] = { Name: "field1", Value: $('input#field1').val() };
			catEnt_Attributes[4] = { Name: "field2", Value: $('input#field2').val() };
			catEnt_Attributes[5] = { Name: "field3", Value: $('input#field3').val() };
			catEnt_Attributes[6] = { Name: "field4", Value: $('input#field4').val() };
			catEnt_Attributes[7] = { Name: "field5", Value: $('input#field5').val() };
			
			catEnt_Attributes[8]  = { Name: "onSpecial", Value: ""+$('#onSpecial:checked').length };	
			catEnt_Attributes[9]  = { Name: "onAuction", Value: ""+$('#onAuction:checked').length };	// MC 상품등록에 없는 항목
			catEnt_Attributes[10] = { Name: "buyable",   Value: ""+$('#buyable:checked').length};    // $('input#buyable').val()
			catEnt_Attributes[11] = { Name: "startDate", Value: $('input#startDate').val() };
			catEnt_Attributes[12] = { Name: "endDate",   Value: $('input#endDate').val() };
			
			//----------------- DESCIRPTIVE Attributes
    		var descriptive_Attributes = new Array();
    		
    		//----------------- DEFINING Attributes
    		/**
             * 	CatalogEntryAttributes/Attributes[0]/ExtendedData/SecondaryDescription	ATTRIBUTE.DESCRIPTION2
				CatalogEntryAttributes/Attributes[0]/ExtendedData/DisplayGroupName	ATTRIBUTE.GROUPNAME
				CatalogEntryAttributes/Attributes[0]/ExtendedData/Field1	ATTRIBUTE.FIELD1
				CatalogEntryAttributes/Attributes[0]/ExtendedData/Footnote	ATTRIBUTE.NOTEINFO
				
	            CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/Image1	ATTRVALUE.IMAGE1
				CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/Image2	ATTRVALUE.IMAGE2
				CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/Field1	ATTRVALUE.FIELD1
				CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/Field2	ATTRVALUE.FIELD2
				CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/Field3	ATTRVALUE.FIELD3
				CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/UnitOfMeasure	ATTRVALUE.QTYUNIT_ID
             */
    		var defining_Attributes = new Array();
    		defining_Attributes[0] = {
    			'displaySequence':	'0.1',
    			'language':	'-1',
    			'usage':	'Defining',
    			'Name':	'Color',
    			'Description':	'Description',
    			'AttributeDataType':'String',
    			'AllowedValue':	[
    			               	 {'displaySequence': '1.0', 'Value':'Blue'},
    			               	 {'displaySequence': '2.0', 'Value':'Red'},
    			               	 {'displaySequence': '3.0', 'Value':'White'},
    			               	 {'displaySequence': '4.0', 'Value':'Yellow'},
    			               	 {'displaySequence': '5.0', 'Value':'Black'}
    							],
    			'ExtendedData': [
    			                 {'Name':'SecondaryDescription', 'Value':'a'},
    			                 {'Name':'DisplayGroupName', 'Value':'b'},
    			                 {'Name':'Field1', 'Value':'c'},
    			                 {'Name':'Footnote', 'Value':'d'}
    			                ]
    		};
    		defining_Attributes[1] = {
       			'displaySequence':	'0.2',
       			'language':	'-1',
       			'usage':	'Defining',
       			'Name':	'Size',
       			'Description':	'Description',
       			'AttributeDataType':'Integer',
       			'Value':	'10',
       			'TypeValue':	'10',
       			'AllowedValue':	[
    			               	 {'displaySequence': '1.0', 'Value':'10'},
    			               	 {'displaySequence': '2.0', 'Value':'20'},
    			               	 {'displaySequence': '3.0', 'Value':'30'},
    			               	 {'displaySequence': '4.0', 'Value':'40'},
    			               	 {'displaySequence': '5.0', 'Value':'50'}
    							],
       			'ExtendedData': [
    			                 {'Name':'SecondaryDescription', 'Value':'a'},
    			                 {'Name':'DisplayGroupName', 'Value':'b'},
    			                 {'Name':'Field1', 'Value':'c'},
    			                 {'Name':'Footnote', 'Value':'d'}
    			                ]
       		};
    		
    		//----------------- ListPrice Attributes
    		var listPrice = {
    			'currency':"USD",
    			'price':"30.00",
    			'quantity': ""
    		};
    		
    		var catEntryJSON =  {
    			'ownerID': $('input#ownerID').val(),
    			'PartNumber': $('input#PartNumber').val(),
    			'pCatGrpId': $('input#pCatGrpId').val(),
    			'catEntType':'ProductBean',
    			
    			'Description': description,
    			'CatalogEntryAttributes': catEnt_Attributes,
    			'DescriptiveAttributes': descriptive_Attributes,
    			'DefiningAttributes': defining_Attributes,
    			'ListPrice': listPrice
    		};
	    	
    		console.debug(catEntryJSON);
    		
	    	return catEntryJSON;
	    	
	    }
	    
    </script>
  </body>
</html>


