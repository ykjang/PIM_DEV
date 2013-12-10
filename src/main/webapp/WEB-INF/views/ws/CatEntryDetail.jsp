<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="javax.xml.soap.SOAPMessage"%>
<%@page import="javax.xml.transform.stream.StreamResult"%>
<%@page import="javax.xml.transform.Source"%>
<%@page import="javax.xml.transform.Transformer"%>
<%@page import="javax.xml.transform.TransformerFactory"%>
<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	Map catEntMap = (Map)request.getAttribute("dataMap");

	ArrayList catEntDescList = (ArrayList)catEntMap.get("DESCRIPTION");
	
	
	for(int i=0; i<catEntDescList.size(); i++)
	{
	  Map descMap = (Map)catEntDescList.get(i);
	  
	}
	
	
	
	Map attrMap = (Map)catEntMap.get("ATTRIBUTES");
	Map listPriceMap = (Map)catEntMap.get("LISTPRICE");
	Map pCatEntMap = (Map)catEntMap.get("PARENTGRPINFO");
	
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
	    <h1 class="page-title">CatalogEntry Registration</h1>
 	</div>
	 	
 	<!-- location bar -->
  	<ul class="breadcrumb">
      <li><a href="/index.do">Home</a> <span class="divider">/</span></li>
      <li><a href="#">WebService</a><span class="divider">/</span></li>
      <li class="active">CatalogEntry Registration</li>
  	</ul>
	  	
	<div class="container-fluid">
	<div class="row-fluid">
		<form class="form-horizontal">
			<!-- Contents Area S -->
			<div class="row-fluid">
				<div class="span12">
					
					<!--  Button Area S -->
				  	<div class="row-fluid">
						<div class="span12">
						  <button class="btn btn-small pull-right" id="btn_genSKU" type="button">Generate SKU</button>
	   	        <button class="btn btn-small pull-right" id="btn_save" type="button">Save</button>
						</div>
					</div>
				  	<!--  Button Area E -->
					
					<ul class="nav nav-tabs" id="catRegTab">
					  <li><a href="#basic" data-toggle="tab">Basic Info</a></li>
					  <li><a href="#price" data-toggle="tab">Price Info</a></li>
					  <li><a href="#desc-attr" data-toggle="tab">Descriptive Attribute</a></li>
					  <li><a href="#defi-attr" data-toggle="tab">Defining Attributes</a></li>
					</ul>
					
					<!-- Tab S -->
					<div class="tab-content">
					  <div class="tab-pane active" id="basic">
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
								      <input class="span8" type="text" id="ShortDescription" placeholder="Short description(United States English)">
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
						                     //DEXT5.config.Width = "100%";
						                     DEXT5.config.SkinName = "gray";
						                     
						                     DEXT5.config.InitXml = "dext_editor.xml";   // ex)  DEXT5.config.InitXml = "dext_editor_mobile.xml"; //config 폴더 안의 파일 이름만 지정
						                     // var editor1 = new Dext5editor("editor1");
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
						</div><!-- Accordian Area E -->
					  </div>
					  <!-- Basic Info Tab E -->
					  
					  <!-- Price Info Tab S -->
					  <div class="tab-pane" id="price">
					  	<!-- Accordian Area S -->
						<div class="accordion" id="accord_price">
						  <!-- List Price S -->
						  <div class="accordion-group">
						    <div class="accordion-heading">
						      <a class="accordion-toggle" data-toggle="collapse" data-parent="accord_price" href="#price_1">
						        List Price
						      </a>
						    </div>
						    <div id="price_1" class="accordion-body collapse in">
						      <div class="accordion-inner">
						      <%
                     ArrayList altPrcList = (ArrayList)listPriceMap.get("altPriceList");
                     String defPrcCurr = (String)listPriceMap.get("currency");
                     String defPrc = (String)listPriceMap.get("price");
                     
                     String prcUSD = "";
                     String prcCAD = "";
                     String prcEUR = "";
                     String prcJPY = "";
                     String prcKRW = "";
                     for(int i=0; i<altPrcList.size(); i++)
                     {
                       Map altPrcInfo = (Map)altPrcList.get(i);
                       
                       if(((String)altPrcInfo.get("currency")).equals("USD"))
                       {
                        prcUSD = (String)altPrcInfo.get("price"); continue;
                       }
                       
                       if(((String)altPrcInfo.get("currency")).equals("CAD"))
                       {
                        prcCAD = (String)altPrcInfo.get("price"); continue;
                       }
                       
                       if(((String)altPrcInfo.get("currency")).equals("EUR"))
                       {
                    	   prcEUR = (String)altPrcInfo.get("price"); continue;
                       }
                       
                       if(((String)altPrcInfo.get("currency")).equals("JPY"))
                       {
                    	   prcJPY = (String)altPrcInfo.get("price"); continue;
                       }
                       
                       if(((String)altPrcInfo.get("currency")).equals("KRW"))
                       {
                    	   prcKRW = (String)altPrcInfo.get("price"); continue;
                       }
                     }
                     
                   %>
						        <table class="table-bordered">
								       <thead>
					                <tr>
					                  <th style="width: 80px;">USD<%="USD".equals(defPrcCurr)?"*":""%></th>
                            <th style="width: 80px;">CAD<%="CAD".equals(defPrcCurr)?"*":""%></th>
                            <th style="width: 80px;">EUR<%="EUR".equals(defPrcCurr)?"*":""%></th>
                            <th style="width: 80px;">JPY<%="JPY".equals(defPrcCurr)?"*":""%></th>
                            <th style="width: 80px;">KRW<%="KRW".equals(defPrcCurr)?"*":""%></th>
					                </tr>
				              	</thead>
			              		<tbody>
			              			<tr>
                             <td><input class="input-mini" type="text" id="USD" value="<%="USD".equals(defPrcCurr)?defPrc:prcUSD%>"></td>
                             <td><input class="input-mini" type="text" id="CAD" value="<%="CAD".equals(defPrcCurr)?defPrc:prcCAD%>"></td>
                             <td><input class="input-mini" type="text" id="EUR" value="<%="EUR".equals(defPrcCurr)?defPrc:prcEUR%>"></td>
                             <td><input class="input-mini" type="text" id="JPY" value="<%="JPY".equals(defPrcCurr)?defPrc:prcJPY%>"></td>
                             <td><input class="input-mini" type="text" id="KRW" value="<%="KRW".equals(defPrcCurr)?defPrc:prcKRW%>"></td>
                           </tr>
			              			
			              		</tbody>
		              	  </table>
						        </div>
						      </div>
						    </div>
						  <!-- List Price E -->
						  <!-- Offer Price S -->
						  <div class="accordion-group">
						    <div class="accordion-heading">
						      <a class="accordion-toggle" data-toggle="collapse" data-parent="accord_price" href="#price_2">
						        Offer Price
						      </a>
						    </div>
						    <div id="price_2" class="accordion-body collapse">
						      <div class="accordion-inner">
					  		  </div>
					  		</div>
					  	  </div>
					  	  <!-- Offer Price E -->
					  	</div>
					  	<!-- Accordian Area E -->
					  </div>
					  <!-- Prcie Info Tab E -->
					  
					  <!-- Descriptive Attribute Tab S -->
					  <%
              ArrayList descAttrList = (ArrayList)attrMap.get("DESC_ATTRIBUTE");
              System.out.println("[descriptive attribute count]"+descAttrList.size());
            %>
            
					  <div class="tab-pane" id="desc-attr">
					      <table class="table">
							    <thead>
		                <tr>
		                  <th style="width: 80px;">Sequence*</th>
		                  <th style="width: 160px;">*Name(US)</th>
		                  <th style="width: 140px;">*DataType</th>
		                  <th>*Description(US)</th>
		                </tr>
	              	</thead>
              		<tbody>
              		<%
                      for( int i=0; i<descAttrList.size(); i++)
                      {
                        Map descAttrData = (Map)descAttrList.get(i);
                        String dataType = (String)descAttrData.get("AttributeDataType");
                   %>
              			<tr>
              				<td>
              				  <input class="span12" type="text" name="descAttr_seq[]" value="<%=descAttrData.get("displaySequence")%>">
                        <input type="hidden" name="defiAttr_attId[]" value="<%=descAttrData.get("UniqueID")%>">
              				</td>
              				<td>
              				  <input class="span12" type="text" name="descAttr_name[]" value="<%=descAttrData.get("Name")%>">
              				</td>
              				<td>
              				  <%-- <input class="span12" type="hidden" name="descAttr_datatype[]" value="<%=dataType%>"> --%>
	              				<select class="span12" name="descAttr_datatype[]">
                          <option value="">Select Type</option>
                          <option value="String" <%= ("String").equals(dataType)?"selected":"" %> >Text</option>
                          <option value="Integer"<%= ("Integer").equals(dataType)?"selected":"" %> >Whole Number</option>
                          <option value="Float"  <%= ("Float").equals(dataType)?"selected":"" %> >Decimal Number</option>
                        </select>
							        </td>
              				<td><input class="span12" type="text" name="descAttr_value[]" value="<%=descAttrData.get("Value")%>"></td>
              			</tr>
              			<%
                      } // End for ( Descripive Attribute)
              			
                    	if(descAttrList.size() == 0)
                    	{
                    %>		
                    		<tr>
                            <td><input class="span12" type="text" name="descAttr_seq[]" ></td>
                            <td><input class="span12" type="text" name="descAttr_name[]" ></td>
                            <td>
                              <select class="span12" name="descAttr_datatype[]">
                                <option value="">Select Type</option>
				                        <option value="String">Text</option>
				                        <option value="Integer">Whole Number</option>
				                        <option value="Float">Decimal Number</option>
				                      </select>
				                    </td>
                            <td><input class="span12" type="text" name="descAttr_value[]" ></td>
                          </tr>
                    <%
                    	} // End if
              			%>
              		</tbody>
             	  </table>
					  </div>
					  <!-- Descriptive Attribute Tab E -->
					  <!-- Defining Attribute Tab S -->
					  <%
					  	ArrayList defiAttrList = (ArrayList)attrMap.get("DEFI_ATTRIBUTE");
					  	System.out.println("[defiAttrList]"+defiAttrList.size());
					  %>
					  <div class="tab-pane" id="defi-attr">
					  	<div class="row-fluid">
							<div class="span12">
		   						<button class="btn btn-small pull-right" id="btn_defi_attr_save" type="button">Defining Attribute Save</button>
							</div>
						</div>
					  	<table class="table">
							<thead>
				                <tr>
				                  <th style="width: 80px;">Sequence*</th>
				                  <th style="width: 160px;">*Name(US)</th>
				                  <th style="width: 140px;">*DataType</th>
				                  <th>*Description(US)</th>
				                  <th style="width: 200px;">Values(US)</th>
				                </tr>
			              	</thead>
		              		<tbody>
		              		<%
		              			for( int i=0; i<defiAttrList.size(); i++)
		              			{
		              				Map defiAttrData = (Map)defiAttrList.get(i);
		              				String dataType = (String)defiAttrData.get("AttributeDataType");
		              		%>
		              			<tr>
		              				<td>
		              					<input class="span12" type="text" readonly="readonly" name="defiAttr_seq" value="<%=defiAttrData.get("displaySequence")%>">
		              					<input type="hidden" name="defiAttr_attId" value="<%=defiAttrData.get("UniqueID")%>">
		              					
		              				</td>
		              				<td><input class="span12" type="text" readonly="readonly" name="defiAttr_name" value="<%=defiAttrData.get("Name")%>"></td>
		              				<td>
		              					<input class="span12" type="text" readonly="readonly" name="defiAttr_datatype" value="<%=dataType%>">
			              				<%-- <select class="span12" name="defiAttr_datatype">
			              				  <option value="">Select Type</option>
														  <option value="String" <%= ("String").equals(dataType)?"selected":"" %> >Text</option>
														  <option value="Integer"<%= ("Integer").equals(dataType)?"selected":"" %> >Whole Number</option>
														  <option value="Float"  <%= ("Float").equals(dataType)?"selected":"" %> >Decimal Number</option>
														</select> --%>
													</td>
		              				<td><input class="span12" type="text" readonly="readonly" name="defiAttr_description" value="<%=defiAttrData.get("Description")%>"></td>
		              				<td>
		              				<a class="btn btn-small" name="btn_showDefiAttrVals"><i class="icon-arrow-down"></i> Value List</a>
		              				<a class="btn btn-small" name="btn_addDefiAttrVals"><i class="icon-plus-sign"></i> Add Values</a>
		              				</td>
		              			</tr>
		              			<!-- 속성 Value 노드 -->
		              			<tr name="defi_attr_vals_<%=i%>" style="display:none;">
		              			  <td colspan="5">
		              			  <ul name="ul_attr_vals_<%=i%>">
		              		<%
		              				// Attribute Value List
		              				ArrayList values = (ArrayList)defiAttrData.get("values");
		              				
		              				for(int k=0; k<values.size(); k++)
				      						{
				      							Map valMap = (Map)values.get(k);
			      					%>
		      									<li>
		      									<input class="span2" type="hidden" name="defiAttr_val_id" readonly="readonly"  value="<%=valMap.get("identifier") %>">
		      									<input class="input-mini" type="text" readonly="readonly" name="defiAttr_val_seq" value="<%=valMap.get("displaySequence") %>">
		      									Value <input class="span2" type="text" readonly="readonly" name="defiAttr_val_val" value="<%=valMap.get("Value") %>">
		      									<!-- <a class="btn btn-small" name="btn_delVals"><i class="icon-minus-sign"></i> Delete</a> -->
		      									</li>
		      							
	      					    <%
	      					        } // End for Val
		              		%>
		              				</ul>
		              			  	</td>
	      						  </tr>
		              		<%
		              			} // End for Attr
		              			if(defiAttrList.size() == 0)
		              			{		              			
		              		%>
		              		  <tr>
                          <td>
                            <input class="span12" type="text" name="defiAttr_seq" value="">
                            <input type="hidden" name="defiAttr_attId" value="">
                          </td>
                          <td><input class="span12" type="text" name="defiAttr_name" value=""></td>
                          <td>
                            <select class="span12" name="defiAttr_datatype">
                              <option value="">Select Type</option>
                              <option value="String" >Text</option>
                              <option value="Integer">Whole Number</option>
                              <option value="Float"  >Decimal Number</option>
                            </select>
                          </td>
                          <td><input class="span12" type="text" name="defiAttr_description" value=""></td>
                          <td>
                          <a class="btn btn-small" name="btn_showDefiAttrVals"><i class="icon-arrow-down"></i> Value List</a>
                          <a class="btn btn-small" name="btn_addDefiAttrVals"><i class="icon-plus-sign"></i> Add Values</a>
                          </td>
                        </tr>
		              		<%
		              			} // End if
		              		%>
		              		</tbody>
		              	  </table>
					  	
					  	  <div class="row-fluid">
							<div class="span12">
		   						<button class="btn btn-small pull-right" id="btn_defi_attr_save" type="button">Defining Attribute Save</button>
							</div>
						  </div>
					  </div>
					  <!-- Defining Attribute Tab E -->
					</div>
					<!-- Tab Area E -->
					<div class="row-fluid">
						<div class="span12">
						</div>
					</div>
					<div class="row-fluid">
						<div class="span12">
						</div>
					</div>
					<div class="row-fluid">
						<div class="span12">
						</div>
					</div>	
					<div class="row-fluid">
						<div class="span12">
	   						<button class="btn btn-small pull-right" id="btn_save" type="button">Save</button>
						</div>
					</div>
				  
				</div><!-- span12 E -->
	 		</div><!-- row-fluid E -->
			<!-- Contents Area E -->
			
			<!--  -->
			  <input type="hidden" id="storeId" value="10051">
			  <input type="hidden" id="catalogId" value="10051">
			   <input type="hidden" id="pCatEntId" value="19308">
			  <input type="hidden" id="masterCatalog" value="true">
			  
			  <input type="hidden" id="catEntId" value="<%=(String)catEntMap.get("UniqueID") %>">
			  <input type="hidden" id="partNumber" value="<%=(String)catEntMap.get("PartNumber") %>">
			  <input type="hidden" id="ownerID" value="<%= (String)catEntMap.get("ownerID") %>">
			  </form>
	<!--===================== Bottom Menu Area S =====================-->
	<%@ include file="/inc/inc_bottom.html" %>
	<!--===================== Bottom Menu Area E =====================-->
	</div><!--/row-fluid-->    
 	</div><!--/container-fluid-->    
</div><!--/content-->               

<!-- Defining Attr Value Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Modal header</h3>
  </div>
  <div class="modal-body">
    <p>One fine body…</p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    <button class="btn btn-primary">Save changes</button>
  </div>
</div>
<!-- Defining Attr Value Modal -->    
    
    <script type="text/javascript">
		$(document).ready(function() {
	    	
			$('#catRegTab a[href="#basic"]').tab('show'); // Select tab by name
			//$('#myTab a:first').tab('show'); // Select first tab
			//$('#myTab a:last').tab('show'); // Select last tab
			//$('#myTab li:eq(2) a').tab('show'); // Select third tab (0-indexed)
			
			
			// Display/Hidden Defiing Attribute Values
			$('a[name="btn_showDefiAttrVals"]').click(function(){
				
				var idx = $("a[name='btn_showDefiAttrVals']").index($(this));
				console.debug("[index]"+idx);
				console.debug("[attId]"+$('input[name="defiAttr_attId"]').eq(idx).val());
				
				//console.debug("[display]"+$('tr[name="defi_attr_vals"]').css('display'));
				
				// 선택한 어트리뷰트의 하위 속성값 상위노드
				var $trVal = $('tr[name="defi_attr_vals_'+idx+'"]');
				
				// 하위노드 리스트
				//var attrUL = $trVal.find('ul');
				//console.debug("[li list]"+attrUL.children().length);
				
				// 추가 속성값 Row
				//$('[id="new_vals_'+idx+'"]').show();
				
				if( $trVal.css('display') == 'none' ){
					$(this).find('i').attr('class', 'icon-arrow-up');
					//$(this).text('Hide Values');
					$trVal.show();
				}else{
					$(this).find('i').attr('class', 'icon-arrow-down');
					//$(this).text('Show Values');
					$trVal.hide();
				}
				
			});
			
			
			// Add Defiing Attribute Values Tag
			$('a[name="btn_addDefiAttrVals"]').click(function(){
				
				var idx = $("a[name='btn_addDefiAttrVals']").index($(this));
				// 선택한 어트리뷰트의 하위 속성값 상위노드
				var $trVal = $('tr[name="defi_attr_vals_'+idx+'"]');
				
				// 하위노드 리스트
				var attrUL = $trVal.find('ul');
			
				var valStr = '<li name="new_attr_vals_'+idx+'">'
					+'<input class="input-mini" type="text" name="defiAttr_val_seq_new" value="0.0"> '
					+'Value <input class="span2" type="text" name="defiAttr_val_val_new" > '
					+'<a class="btn btn-small" name="btn_delVals"><i class="icon-minus-sign"></i> Delete</a>'
					+'</li>';
				
				$(valStr).appendTo(attrUL);
				
				if( $trVal.css('display') == 'none' ){
					$(this).find('i').attr('class', 'icon-arrow-up');
					$trVal.show();
				}
			});
			
			// Delete Selected Defiing Attribute Values
			$('a[name="btn_delVals"]').click(function(){
				
			});
			
				
			$('button#btn_defi_attr_save').click(function(){
				
				// console.debug($('#defi-attr input[name="defiAttr_attId"]'));
				var attr_len = $('#defi-attr input[name="defiAttr_attId"]').length;
				
				var defining_Attributes = new Array();
				var req_xpath = new Array();
				
				// Deifining Attribute 속성추출
				var xpath_attr_idx = 0;
				for( var i=0; i<attr_len; i++){
					var attr_id = $('#defi-attr input[name="defiAttr_attId"]')[i].value;
					var attr_seq = $('#defi-attr input[name="defiAttr_seq"]')[i].value; 
					var type =  $('#defi-attr input[name="defiAttr_datatype"]')[i].value;
					
					// Deifining Attribute 속성값 추출
					var defi_attr_add_vals = new Array();
					
					var xpath_val_idx = 0;
					//var $attrValList = $('ul[name="ul_attr_vals_'+i+'"]').children();
					var $attrValList = $('li[name="new_attr_vals_'+i+'"]');
					$.each($attrValList, function(idx){
						console.debug($attrValList.find('[name="defiAttr_val_seq_new"]').eq(idx).val());
						console.debug($attrValList.find('[name="defiAttr_val_val_new"]').eq(idx).val());
						
						var allow_new_seq = $attrValList.find('[name="defiAttr_val_seq_new"]').eq(idx).val();
						var allow_new_value = $attrValList.find('[name="defiAttr_val_val_new"]').eq(idx).val();
						
						// /CatalogEntry[1]/CatalogEntryAttributes/Attributes[1]/AllowedValue[1]
						if( allow_new_value != '' )
						{
							xpath_val_idx = xpath_val_idx + 1;
							if( xpath_val_idx == 1) xpath_attr_idx = xpath_attr_idx + 1;
							
							defi_attr_add_vals.push({
		               		 'displaySequence': allow_new_seq, 'Value':allow_new_value, 
		               		 'ExtendedValue':[{'Name':'attrId', 'Value':attr_id},
		               		 				  {'Name':'DisplaySequence', 'Value':allow_new_seq}]
		               	 	});
							
							req_xpath.push("/CatalogEntry[1]/CatalogEntryAttributes/Attributes["+ xpath_attr_idx +"]/AllowedValue["+ xpath_val_idx +"]");
						}	
						
					}); // End Each 
					
					// Add할 속성값이 존재할 경우 Defining Attribute 객체생성
					if(defi_attr_add_vals.length > 0){ 
						
						var defi_attr_obj = {
								'displaySequence':	attr_seq,
			           			'language':	'-1',
			           			'usage':	'Defining',
			           			'AttributeDataType': type,
				    			'AllowedValue':	defi_attr_add_vals,
				    			'ExtendedData': [
				    			                 {'Name':'attrId', 'Value':attr_id}
				    			                ]
						};
						defining_Attributes.push(defi_attr_obj);
					}
					
				}// End for
				
				if(defining_Attributes.length <= 0){
					alert("No Additional Value!");
					return;
				}
				
				
	    		/* defining_Attributes[0] = {
    				'displaySequence':	'0.2',
           			'language':	'-1',
           			'usage':	'Defining',
           			'AttributeDataType':'Integer',
	    			'AllowedValue':	[
	    			               	 {
	    			               		 'displaySequence': '3.0', 'Value':'50', 
	    			               		 'ExtendedValue':[{'Name':'attrId', 'Value':'16654'},
	    			               		 				  {'Name':'DisplaySequence', 'Value':'3'}]
	    			               	 },
	    			               	{
	    			               		 'displaySequence': '2.0', 'Value':'60', 
	    			               		 'ExtendedValue':[{'Name':'attrId', 'Value':'16654'},
	    			               		 				  {'Name':'DisplaySequence', 'Value':'2'}]
	    			               	 },
	    			               	{
	    			               		 'displaySequence': '5.0', 'Value':'70', 
	    			               		 'ExtendedValue':[{'Name':'attrId', 'Value':'16654'},
	    			               		 				  {'Name':'DisplaySequence', 'Value':'5'}]
	    			               	 }
	    							],
	    			'ExtendedData': [
	    			                 {'Name':'attrId', 'Value':'16654'}
	    			                ]
	    		}; */
				
				var catEntryJSON =  {
        			'CatEntId': $('#catEntId').val(),
        			'DefiningAttributes': defining_Attributes
        		};
				
				// BOD Parameter
	    		var paramObj = new Object();
	    		paramObj = {
	    			'ACTION_CODE': "Add",
	    			'REQ_XPATH'  : req_xpath,
	                'ContextData': [
		    			            {'Name':'storeId',   'Value': $('input#storeId').val()},
		    			            {'Name':'catalogId', 'Value': $('input#catalogId').val()}
		    			           ],
	    			
	    			'CATENTRY': catEntryJSON
	    		};
	    		
	    		console.debug(paramObj);
	    		
	    		
	    		$.ajax({
	    			url: '/ws/ChangeCatEnt.jsonp',
	   				type: 'POST',
	   				contentType: 'application/json',
	   			  	data: JSON.stringify(paramObj),
	   			  	
	   				success: function(data) {
   						console.debug("result: "+data);
						
   					},
	    		
	    		}); // End Ajax
	      }); // End Click
	    }); // End Init
	    
	    
	    $('button#btn_genSKU').click(function(){
	    	
	    	
	    	    // BOD Parameter
	          var paramObj = new Object();
	          paramObj = {
	            'ACTION_CODE': "Create",  // Add, Delete, Change...
	            'REQ_XPATH'  : [ "/CatalogEntry[1]"],
	            'ContextData': [
	                            {'Name':'storeId', 'Value': $('input#storeId').val()},
	                            {'Name':'catalogId', 'Value': $('input#catalogId').val()},
	                            {'Name':'masterCatalog', 'Value': $('input#masterCatalog').val()}
	                           ],
	            
	            'CATENTRY': toJsonCatEntry()
	          };
	          
	          $.ajax({
	            url: '/ws/RegisterCatEnt.jsonp',
	            type: 'POST',
	            contentType: 'application/json',
	              data: JSON.stringify(paramObj),
	              
	            success: function(result) {
	              
	              console.debug(result);
	              var resultObj = result.RESULT;
	              
	              if(resultObj.result == '1'){
	                alert('Success: ProductID - '+resultObj.data[0].UniqueID);
	              //location.href = "/ws/getCatEntByPCatGrpId.do";
	              }else{
	                alert('Error: '+resultObj.data.Description);
	                /* $('#errMsgWin').html(resultObj.data.description);
	                $('#errMsgWin').show(); */
	              }
	            },
	          
	          }); // End Ajax
	    	
	    });
	    
	    
	    
	    function toJsonCatEntry(){
	    	//----------------- DESCIRPTION - 언어별 배열
    		var desc_Attributes = new Array();
    		desc_Attributes[0] = { Name: "published", Value: ""+$('#published:checked').length }; // Display to Customers
    		// MC 상품등록에 없는 항목
    		/* 
    		desc_Attributes[1] = { Name: "available", Value: ""+$('#available:checked').length };
    		desc_Attributes[2] = { Name: "availabilityDate", Value: $('input#availabilityDate').val() };
    		desc_Attributes[3] = { Name: "auxDescription1", Value: $('input#auxDescription1').val() };
    		desc_Attributes[4] = { Name: "auxDescription2", Value: $('input#auxDescription2').val() }; 
    		*/
			
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
			for(var i=0; i < $('input[name="descAttr_name[]"]').length; i++){
				
				if($('input[name="descAttr_name[]"]')[i].value == '' ||
						$('select[name="descAttr_datatype[]"]')[i].value == '' ||
							$('input[name="descAttr_value[]"]')[i].value == ''){
					continue;
				}
				
				descriptive_Attributes.push( {
	        			'language':	'-1',
	        			'usage':	'Descriptive',
	        			'displaySequence':	$('input[name="descAttr_seq[]"]')[i].value,
	        			'Name':	$('input[name="descAttr_name[]"]')[i].value,
	        			'AttributeDataType':$('select[name="descAttr_datatype[]"]')[i].value,
	        			'Value':	$('input[name="descAttr_value[]"]')[i].value,
	           			'TypeValue':	$('input[name="descAttr_value[]"]')[i].value,
	           			'Description':	'Description'
           				/* 'ExtendedData': [
            			                 {'Name':'SecondaryDescription', 'Value':'a'},
            			                 {'Name':'DisplayGroupName', 'Value':'b'},
            			                 {'Name':'Field1', 'Value':'c'},
            			                 {'Name':'Footnote', 'Value':'d'}
            			                ] */
				});
			}
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
    		
			for(var i=0; i < $('input[name="defiAttr_name[]"]').length; i++){
				
				if($('input[name="defiAttr_name[]"]')[i].value == '' ||
						$('select[name="defiAttr_datatype[]"]')[i].value == ''){
					continue;
				}
				
				defining_Attributes.push( {
	        			'language':	'-1',
	        			'usage':	'Defining',
	        			'displaySequence':	$('input[name="defiAttr_seq[]"]')[i].value,
	        			'Name':	$('input[name="defiAttr_name[]"]')[i].value,
	        			'AttributeDataType':$('select[name="defiAttr_datatype[]"]')[i].value,
	           			'Description': $('input[name="defiAttr_description[]"]')[i].value
           				/* 'ExtendedData': [
            			                 {'Name':'SecondaryDescription', 'Value':'a'},
            			                 {'Name':'DisplayGroupName', 'Value':'b'},
            			                 {'Name':'Field1', 'Value':'c'},
            			                 {'Name':'Footnote', 'Value':'d'}
            			                ] */
				});
			}
    		
    		//----------------- ListPrice Attributes
    		var listPrice = {
    			'currency':"USD",
    			'price': $('#USD').val()
    		};
    		
    		var altCurrPrice = new Array();
    		if($('#CAD').val() != "") altCurrPrice.push( {'currency':'CAD', 'price':$('#CAD').val()} );
    		if($('#EUR').val() != "") altCurrPrice.push( {'currency':'EUR', 'price':$('#EUR').val()} );
    		if($('#JPY').val() != "") altCurrPrice.push( {'currency':'JPY', 'price':$('#JPY').val()} );
    		if($('#KRW').val() != "") altCurrPrice.push( {'currency':'KRW', 'price':$('#KRW').val()} );
    		
			if(altCurrPrice.length > 0){
				listPrice['AlternativeCurrencyPrice'] = altCurrPrice;
			}    		
    		
	   		/* var Price = {
       			'StandardPrice':{
        			'currency':"USD",
        			'price':"30.00"
        		}
	       	}; */
    		
    		
    		var catEntryJSON =  {
    			'ownerID': $('input#ownerID').val(),
    			'PartNumber': $('input#PartNumber').val(),
    			'pCatGrpId': $('input#pCatGrpId').val(),
    			//'pCatEntId': $('input#pCatEntId').val(),
    			'catEntType':'ProductBean',
    			//'catEntType':'ItemBean',
    			
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


