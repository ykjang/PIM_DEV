<%@page import="com.isec.pim.ws.domain.AttrValue"%>
<%@page import="com.isec.pim.ws.domain.ListPrice"%>
<%@page import="org.w3c.dom.ls.LSInput"%>
<%@page import="com.isec.pim.ws.domain.Attribute"%>
<%@page import="java.util.List"%>
<%@page import="com.isec.pim.ws.domain.CatEntry"%>
<%@page import="com.isec.pim.ws.domain.CatEntDesc"%>
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
	CatEntry catEnt = (CatEntry)request.getAttribute("catEnt");
	ArrayList<CatEntDesc> catEntDescList = catEnt.getDescList();
	
	String tabId = (String)request.getAttribute("tabId");
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
	    <h1 class="page-title">CatalogEntry Detail Info.</h1>
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
					  
					  <!--  Button Area S -->
            <div class="row-fluid">
              <div class="span12">
                <button class="btn btn-small pull-right" id="btn_gen_save" type="button">Save</button>
              </div>
            </div>
            <!--  Button Area E -->
					  
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
								      <input class="span6" type="text" id="PartNumber" placeholder="Product Code" value="<%=catEnt.getPartNumber()%>">
								    </div>
								  </div>
								  <!-- ================ Multi Language Area S ================ -->
								  <div class="control-group">
								    <label class="control-label" for="">Name</label>
								    <div class="controls">
								      <input class="span6" type="text" id="Name" placeholder="Name(United States English)" value="<%=catEnt.getDescList().get(0).getName()%>">
								    </div>
								  </div>
								  <div class="control-group">
								    <label class="control-label" for="">Short description</label>
								    <div class="controls">
								      <input class="span8" type="text" id="ShortDescription" placeholder="Short description(United States English)" value="<%=catEnt.getDescList().get(0).getShortDescription()%>">
								    </div>
								  </div>
								  
								  <div class="control-group">
								    <label class="control-label" for="">Long description</label>
								    <div class="controls">
								      <%
								         String logDesc = catEnt.getDescList().get(0).getLongDescription();
								         logDesc = logDesc.replace( "\"", "&quot;");
								         logDesc = logDesc.replace( "\\\n", " ");
								         logDesc = logDesc.replace( "<", "&lt;");
								         logDesc = logDesc.replace( ">", "&gt;");
								      %>
								      <input type="hidden" id="LongDescription" value='<%=logDesc%>'>
								      <!--에디터 영역-->
									    <script type="text/javascript" src="/dext5/js/dext5editor.js"></script>
			                 <script type="text/javascript">
			                     DEXT5.config.Height = "300px";
			                     //DEXT5.config.Width = "100%";
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
								      <textarea class="span6" id="Keyword" rows="3" placeholder="keywords(United States English)"><%=catEnt.getDescList().get(0).getKeyword()%></textarea>
								    </div>
								  </div>
								  <!-- ================ Multi Language Area E ================ -->
								  
								  <!-- ================ Parent CatalogGroup Area S ================ -->
								  <%
								    if("ProductBean".equals(catEnt.getCatalogEntryTypeCode()))
								    {
								  %>
                  <div class="control-group">
                    <label class="control-label" for="">Parent CatalogGroup ID</label>
                    <div class="controls">
                      <input class="span2" type="text" id="pCatGrpId" value="<%=catEnt.getPrntCatGrp().getUniqueID()%>" readonly="readonly">
                      <input class="span4" type="text" id="pCatGrpName" value="<%=catEnt.getPrntCatGrp().getGroupIdentifier()%>" readonly="readonly">
                    </div>
                  </div>
                  <%
								    }
                  %>
                  <!-- ================ Parent CatalogGroup Area S ================ -->
								  
								  <!-- ================ Classical Attribute Area S ================ -->
								  <%
								    ArrayList<Attribute> clssAttrList = (ArrayList<Attribute>)catEnt.getClssAttrList();
								    		
								    for( int i=0; i<clssAttrList.size(); i++)
								    {
								    	String clssAttrName = clssAttrList.get(i).getName();
								    	String clssAttrType = clssAttrList.get(i).getAttributeDataType();
								    	String cassAttrValue = clssAttrList.get(i).getValue();
								    	
								  %> 
								  <div class="control-group">
								    <label class="control-label" for="" data-toggle="tooltip" title="title"><%=clssAttrName%></label>
								    <div class="controls">
								      <input class="span6" type="text" name="clssAttr" id="<%=clssAttrName%>" placeholder="Manufacturer" value="<%=cassAttrValue%>">
								    </div>
								  </div>
								  <%
								    }
								  %>
								  <!-- ================ Classical Attribute Area S ================ -->
								  
						      </div>
						    </div>
						  </div>
						  <!-- General Information E -->
						  
						  
						  <!-- ===================== Display Area S ===================== -->
						  <div class="accordion-group">
						    <div class="accordion-heading">
						      <a class="accordion-toggle" data-toggle="collapse" data-parent="accord_catReg" href="#cateReg_info_3">
						        Display Information 
						      </a>
						    </div>
						    <div id="cateReg_info_3" class="accordion-body collapse">
						      <div class="accordion-inner">
						        <input type="hidden" id="Language" value="<%=catEnt.getDescList().get(0).getLanguage()%>">
						        <div class="control-group">
									    <label class="control-label" for="">Display to customers(published)</label>
									    <div class="controls">
								      	<label class="checkbox">
												  <input type="checkbox" id="published" value="<%=catEnt.getDescList().get(0).getPublished()%>" checked="<%=catEnt.getDescList().get(0).getPublished().equals("1")?"checked":""%>">
												</label>
								      </div>
							  	  </div>
								  	<div class="control-group">
									    <label class="control-label" for="">Thumbnail (United States English)</label>
									    <div class="controls">
									      <input class="span6" type="text" id="thumbnail" placeholder="Thumbnail (United States English)" value="<%=catEnt.getDescList().get(0).getThumbnail()%>">
									    </div>
								  	</div>
								  	<div class="control-group">
									    <label class="control-label" for="">Full image (United States English)</label>
									    <div class="controls">
									      <input class="span6" type="text" id="fullimage" placeholder="Full image (United States English)" value="<%=catEnt.getDescList().get(0).getFullImage()%>">
									    </div>
								  	</div>
								  	<div class="control-group">
									    <label class="control-label" for="">available</label>
									    <div class="controls">
								      	<label class="checkbox">
												  <input type="checkbox" id="available" value="<%=catEnt.getDescList().get(0).getPublished()%>" checked="<%=catEnt.getDescList().get(0).getPublished().equals("1")?"checked":""%>">
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
									      <input class="span6" type="text" id="auxDescription1" placeholder="auxDescription1" value="<%=catEnt.getDescList().get(0).getAuxDescription1()%>">
									    </div>
								  	</div>
								  	<div class="control-group">
									    <label class="control-label" for="">auxDescription2</label>
									    <div class="controls">
									      <input class="span6" type="text" id="auxDescription2" placeholder="auxDescription2" value="<%=catEnt.getDescList().get(0).getAuxDescription2()%>">
									    </div>
								  	</div>
						      </div>
						    </div>
						  </div>
						  <!-- ===================== Display Area E ===================== -->
						  
						  <!-- Custom Area S -->
						  <!-- <div class="accordion-group">
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
						  </div> -->
						  <!-- Custom Area E -->
						</div><!-- Accordian Area E -->
					  </div>
					  <!-- Basic Info Tab E -->
					  
					  <!-- Price Info Tab S -->
					  <div class="tab-pane" id="price">
					  	<!-- Accordian Area S -->
						<div class="accordion" id="accord_price">
						
						  <!--  Button Area S -->
	            <div class="row-fluid">
	              <div class="span12">
	                <button class="btn btn-small pull-right" id="btn_listprice_save" type="button">Save</button>
	              </div>
	            </div>
	            <!--  Button Area E -->
            
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
                     ListPrice listPrice = catEnt.getListPrice();
                     String defPrcCurr = listPrice.getCurrency();
                     String defPrc = listPrice.getPrice();
                     
                     String prcUSD = "";
                     String prcCAD = "";
                     String prcEUR = "";
                     String prcJPY = "";
                     String prcKRW = "";
                     for(int i=0; i<listPrice.getAltPriceList().size(); i++)
                     {
                    	 ListPrice altPrcInfo = listPrice.getAltPriceList().get(i);
                       
                       if(altPrcInfo.getCurrency().equals("USD"))
                       {
                         prcUSD = altPrcInfo.getPrice(); continue;
                       }
                       if(altPrcInfo.getCurrency().equals("CAD"))
                       {
                    	   prcCAD = altPrcInfo.getPrice(); continue;
                       }
                       if(altPrcInfo.getCurrency().equals("EUR"))
                       {
                    	   prcEUR = altPrcInfo.getPrice(); continue;
                       }
                       if(altPrcInfo.getCurrency().equals("JPY"))
                       {
                    	   prcJPY = altPrcInfo.getPrice(); continue;
                       }
                       if(altPrcInfo.getCurrency().equals("KRW"))
                       {
                    	   prcKRW = altPrcInfo.getPrice(); continue;
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
                             <td><input class="input-mini" type="text" name="listPrcCurr" id="USD" value="<%="USD".equals(defPrcCurr)?defPrc:prcUSD%>"></td>
                             <td><input class="input-mini" type="text" name="listPrcCurr" id="CAD" value="<%="CAD".equals(defPrcCurr)?defPrc:prcCAD%>"></td>
                             <td><input class="input-mini" type="text" name="listPrcCurr" id="EUR" value="<%="EUR".equals(defPrcCurr)?defPrc:prcEUR%>"></td>
                             <td><input class="input-mini" type="text" name="listPrcCurr" id="JPY" value="<%="JPY".equals(defPrcCurr)?defPrc:prcJPY%>"></td>
                             <td><input class="input-mini" type="text" name="listPrcCurr" id="KRW" value="<%="KRW".equals(defPrcCurr)?defPrc:prcKRW%>"></td>
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
              List<Attribute> descAttrList = catEnt.getDescAttrList();
              //System.out.println("[descriptive attribute count]"+descAttrList.size());
            %>
            
					  <div class="tab-pane" id="desc-attr">
						  <!--  Button Area S -->
		          <div class="row-fluid">
		            <div class="span12">
		              <button class="btn btn-small pull-right" id="btn_descattr_save" type="button">Save</button>
		            </div>
		          </div>
		          <!--  Button Area E -->
		          
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
                        Attribute descAttrData = descAttrList.get(i);
                        String dataType = descAttrData.getAttributeDataType();
                   %>
              			<tr>
              				<td>
              				  <input class="span12" type="text" name="descAttr_seq[]" value="<%=descAttrData.getDisplaySequence()%>">
                        <input type="hidden" name="defiAttr_attId[]" value="<%=descAttrData.getUniqueID()%>">
              				</td>
              				<td>
              				  <input class="span12" type="text" name="descAttr_name[]" value="<%=descAttrData.getName()%>">
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
              				<td><input class="span12" type="text" name="descAttr_value[]" value="<%=descAttrData.getValue()%>"></td>
              			</tr>
              			<% } // End for %>
                     <!-- New Values -->
                     <tr>
                       <td><input class="span12" type="text" name="new_descAttr_seq[]" ></td>
                       <td><input class="span12" type="text" name="new_descAttr_name[]" ></td>
                       <td>
                         <select class="span12" name="new_descAttr_datatype[]">
                           <option value="">Select Type</option>
                           <option value="String">Text</option>
                           <option value="Integer">Whole Number</option>
                           <option value="Float">Decimal Number</option>
                          </select>
                       </td>
                       <td><input class="span12" type="text" name="new_descAttr_value[]" ></td>
                     </tr>
                     <tr>
                       <td><input class="span12" type="text" name="new_descAttr_seq[]" ></td>
                       <td><input class="span12" type="text" name="new_descAttr_name[]" ></td>
                       <td>
                         <select class="span12" name="new_descAttr_datatype[]">
                           <option value="">Select Type</option>
                           <option value="String">Text</option>
                           <option value="Integer">Whole Number</option>
                           <option value="Float">Decimal Number</option>
                          </select>
                       </td>
                       <td><input class="span12" type="text" name="new_descAttr_value[]" ></td>
                     </tr>
                     <tr>
                       <td><input class="span12" type="text" name="new_descAttr_seq[]" ></td>
                       <td><input class="span12" type="text" name="new_descAttr_name[]" ></td>
                       <td>
                         <select class="span12" name="new_descAttr_datatype[]">
                           <option value="">Select Type</option>
                           <option value="String">Text</option>
                           <option value="Integer">Whole Number</option>
                           <option value="Float">Decimal Number</option>
                          </select>
                       </td>
                       <td><input class="span12" type="text" name="new_descAttr_value[]" ></td>
                     </tr>
                     <!-- New Values -->
              		</tbody>
             	  </table>
					  </div>
					  <!-- Descriptive Attribute Tab E --> 
					  <!-- Defining Attribute Tab S --> 
					  <%
					  	List<Attribute> defiAttrList = catEnt.getDefiAttrList();
					  	//System.out.println("[defiAttrList]"+defiAttrList.size());
					  %>
					  <div class="tab-pane" id="defi-attr">
					   <div class="row-fluid">
                <div class="span12">
                    <button class="btn btn-small pull-right" id="btn_defiattr_save" type="button">Save</button>
                </div>
              </div>
					  	<table class="table">
							<thead>
				                <tr>
				                  <th style="width: 80px;">Sequence*</th>
				                  <th style="width: 160px;">*Name(US)</th>
				                  <th style="width: 120px;">*DataType</th>
				                  <th>*Description(US)</th>
				                  <th style="width: 250px;">&nbsp;</th>
				                </tr>
			              	</thead>
		              		<tbody>
		              		<%
		              			for( int i=0; i<defiAttrList.size(); i++)
		              			{
		              				Attribute defiAttrData = defiAttrList.get(i);
		              				String dataType = (String)defiAttrData.getAttributeDataType();
		              		%>
		              			<tr>
		              				<td>
		              					<input class="span12" type="text" readonly="readonly" name="defiAttr_seq" value="<%=defiAttrData.getDisplaySequence()%>">
		              					<input type="hidden" name="defiAttr_attId" value="<%=defiAttrData.getUniqueID()%>">
		              					
		              				</td>
		              				<td><input class="span12" type="text" readonly="readonly" name="defiAttr_name" value="<%=defiAttrData.getName()%>"></td>
		              				<td>
		              					<input class="span12" type="text" readonly="readonly" name="defiAttr_datatype" value="<%=dataType%>">
			              				<%-- <select class="span12" name="defiAttr_datatype">
			              				  <option value="">Select Type</option>
														  <option value="String" <%= ("String").equals(dataType)?"selected":"" %> >Text</option>
														  <option value="Integer"<%= ("Integer").equals(dataType)?"selected":"" %> >Whole Number</option>
														  <option value="Float"  <%= ("Float").equals(dataType)?"selected":"" %> >Decimal Number</option>
														</select> --%>
													</td>
		              				<td><input class="span12" type="text" readonly="readonly" name="defiAttr_description" value="<%=defiAttrData.getDescription()%>"></td>
		              				<td>
		              				<a class="btn btn-small" name="btn_showDefiAttrVals"><i class="icon-arrow-down"></i> Value List</a>
		              				<a class="btn btn-small" name="btn_addDefiAttrVals"><i class="icon-plus-sign"></i> Add Values</a>
		              				<a class="btn btn-small" name="btn_defi_attr_val_save"><i class="icon-plus-sign"></i> Save</a>
		              				</td>
		              			</tr>
		              			<!-- 속성 Value 노드 -->
		              			<tr name="defi_attr_vals_<%=i%>" style="display:none;">
		              			  <td colspan="5">
		              			  <ul name="ul_attr_vals_<%=i%>">
		              		<%
		              				// Attribute Value List
		              				List<AttrValue> values = defiAttrData.getValueList();
		              				
		              				for(int k=0; k<values.size(); k++)
				      						{
		              					AttrValue valMap = values.get(k);
			      					%>
		      									<li>
		      									<input class="span2" type="hidden" name="defiAttr_val_id" readonly="readonly"  value="<%=valMap.getIdentifier()%>">
		      									<input class="input-mini" type="text" readonly="readonly" name="defiAttr_val_seq" value="<%=valMap.getDisplaySequence() %>">
		      									Value <input class="span2" type="text" readonly="readonly" name="defiAttr_val_val" value="<%=valMap.getValue() %>">
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
		              		%>
		              		<!-- New Defining Attribute Values -->
		              		  <tr>
                          <td>
                            <input class="span12" type="text" name="new_defiAttr_seq[]">
                            <input type="hidden" name="new_defiAttr_attId[]">
                          </td>
                          <td><input class="span12" type="text" name="new_defiAttr_name[]"></td>
                          <td>
                            <select class="span12" name="new_defiAttr_datatype[]">
                              <option value="">Select Type</option>
                              <option value="String" >Text</option>
                              <option value="Integer">Whole Number</option>
                              <option value="Float"  >Decimal Number</option>
                            </select>
                          </td>
                          <td><input class="span12" type="text" name="new_defiAttr_description[]"></td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td>
                            <input class="span12" type="text" name="new_defiAttr_seq[]">
                            <input type="hidden" name="new_defiAttr_attId[]">
                          </td>
                          <td><input class="span12" type="text" name="new_defiAttr_name[]"></td>
                          <td>
                            <select class="span12" name="new_defiAttr_datatype[]">
                              <option value="">Select Type</option>
                              <option value="String" >Text</option>
                              <option value="Integer">Whole Number</option>
                              <option value="Float"  >Decimal Number</option>
                            </select>
                          </td>
                          <td><input class="span12" type="text" name="new_defiAttr_description[]"></td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td>
                            <input class="span12" type="text" name="new_defiAttr_seq[]">
                            <input type="hidden" name="new_defiAttr_attId[]">
                          </td>
                          <td><input class="span12" type="text" name="new_defiAttr_name[]"></td>
                          <td>
                            <select class="span12" name="new_defiAttr_datatype[]">
                              <option value="">Select Type</option>
                              <option value="String" >Text</option>
                              <option value="Integer">Whole Number</option>
                              <option value="Float"  >Decimal Number</option>
                            </select>
                          </td>
                          <td><input class="span12" type="text" name="new_defiAttr_description[]"></td>
                          <td>&nbsp;</td>
                        </tr>
                        <!-- New Defining Attribute Values -->
		              		</tbody>
		              	  </table>
					  </div>
					  <!-- Defining Attribute Tab E -->
					</div>
					<!-- Tab Area E -->
					
				</div><!-- span12 E -->
	 		</div><!-- row-fluid E -->
			<!-- Contents Area E -->
			
			<!--  -->
			  <input type="hidden" id="storeId" value="10051">
			  <input type="hidden" id="catalogId" value="10051">
			  <input type="hidden" id="pCatEntId" value="<%=catEnt.getUniqueID() %>">
			  <input type="hidden" id="masterCatalog" value="true">
			  
			  <input type="hidden" id="catEntId" value="<%=catEnt.getUniqueID() %>">
			  <input type="hidden" id="partNumber" value="<%=catEnt.getPartNumber() %>">
			  <input type="hidden" id="ownerID" value="<%=catEnt.getOwnerID() %>">
			  <input type="hidden" id="catalogEntryTypeCode" value="<%=catEnt.getCatalogEntryTypeCode() %>">
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
    
	  function dext_editor_loaded_event(_dext) {
	      DEXT5.setHtmlValueEx($('#LongDescription').val());
	  }
    
		$(document).ready(function() {
			
			$('#catRegTab a[href="#<%=tabId%>"]').tab('show'); // Select tab by name
			//$('#myTab a:first').tab('show'); // Select first tab
			//$('#myTab a:last').tab('show'); // Select last tab
			//$('#myTab li:eq(2) a').tab('show'); // Select third tab (0-indexed)
			
			// Catentry Object 생성
			var catentryObj =  function(){
				
				this.CatEntId = $('#catEntId').val();
			  this.ownerID = $('input#ownerID').val();
			  this.PartNumber = $('input#PartNumber').val();
			  this.pCatGrpId = $('input#pCatGrpId').val();
			  this.catEntType = $('input#catalogEntryTypeCode').val();
			  // this.pCatEntId = $('input#pCatEntId').val();
			  
			  this.Description = new Array();
			  this.CatalogEntryAttributes = new Array();
			  this.DescriptiveAttributes = new Array();
			  this.DefiningAttributes = new Array();
			  
			  //this.ListPrice = new Object();
      };
			
      
      // SKU 생성
      $('button#btn_genSKU').click(function(){
        
         var catEtnObj = new catentryObj();
         catEtnObj = toJsonCatEntry(catEtnObj, "DESC");
         catEtnObj = toJsonCatEntry(catEtnObj, "LISTPRICE");
         catEtnObj = toJsonCatEntry(catEtnObj, "DESC-ATTR");
         catEtnObj = toJsonCatEntry(catEtnObj, "DEFI_SKU_ATTR");
         catEtnObj.catEntType = "ItemBean";
         catEtnObj.pCatEntId = $('input#pCatEntId').val();
         
         var reqXPath = new Array();
         reqXPath.push("/CatalogEntry[1]");
         
         // BOD Parameter
         var paramObj = new Object();
         paramObj = {
           'ACTION_CODE': "Create",  // Add, Delete, Change...
           'REQ_XPATH'  : reqXPath,
           'ContextData': [
                           {'Name':'storeId', 'Value': $('input#storeId').val()},
                           {'Name':'catalogId', 'Value': $('input#catalogId').val()},
                           {'Name':'masterCatalog', 'Value': $('input#masterCatalog').val()}
                          ],
           'CATENTRY': catEtnObj
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
               //alert('Success: ProductID - '+resultObj.data[0].UniqueID);
             //location.href = "/ws/getCatEntByPCatGrpId.do";
            	 alert('Success: ProductID: '+resultObj.data[0].uniqueID + 'PartNumber: '+resultObj.data[0].partNumber);
             }else{
               alert('Error: '+resultObj.data.Description);
               /* $('#errMsgWin').html(resultObj.data.description);
               $('#errMsgWin').show(); */
             }
           },
         
         }); // End Ajax
      });
      
      
			
      // 기본정보 수정
			$('button#btn_gen_save').click(function(){
        
				 var catEtnObj = new catentryObj();
				 catEtnObj = toJsonCatEntry(catEtnObj, "DESC");
				 
         // BOD Parameter
         var paramObj = new Object();
         paramObj = {
           'ACTION_CODE': "Change",  // Add, Delete, Change...
           'REQ_XPATH'  : [ "/CatalogEntry[1]/Description[1]"],
           'ContextData': [
                           {'Name':'storeId', 'Value': $('input#storeId').val()},
                           {'Name':'catalogId', 'Value': $('input#catalogId').val()}
                          ],
           'CATENTRY': catEtnObj
         };
         
         $.ajax({
             url: '/ws/ChangeCatEnt.jsonp',
             type: 'POST',
             contentType: 'application/json',
             data: JSON.stringify(paramObj),
             success: function(data) {
               if(data.RESULT == null){
            	   alert('Saved Successfully');
            	   //refresh("basic");
               }else{
            	   alert(data.RESULT);
               }
             },
         }); // End Ajax
      });
			
			// ListPrice 수정 및 추가(Default Price는 제외)
      $('button#btn_listprice_save').click(function(){
        
         var catEtnObj = new catentryObj();
         catEtnObj = toJsonCatEntry(catEtnObj, "LISTPRICE");
         
         // BOD Parameter
         var req_xpath = new Array();
         if( catEtnObj.ListPrice.AlternativeCurrencyPrice.length > 0 ){
           for(var i=0; i<catEtnObj.ListPrice.AlternativeCurrencyPrice.length; i++){
        	   req_xpath[i] = "/CatalogEntry[1]/ListPrice/AlternativeCurrencyPrice["+(i+1)+"]"; 
           }
         }else{
           return;
         }
         
         var paramObj = new Object();
         paramObj = {
           'ACTION_CODE': "Change",  // Add, Delete, Change...
           'REQ_XPATH'  : req_xpath,
           'ContextData': [
                           {'Name':'storeId', 'Value': $('input#storeId').val()},
                           {'Name':'catalogId', 'Value': $('input#catalogId').val()},
                           {'Name':'masterCatalog', 'Value': $('input#masterCatalog').val()}
                          ],
           'CATENTRY': catEtnObj
         };
         
         $.ajax({
             url: '/ws/ChangeCatEnt.jsonp',
             type: 'POST',
             contentType: 'application/json',
             data: JSON.stringify(paramObj),
             success: function(data) {
               if(data.RESULT == null){
                 alert('Saved Successfully');
                 
                 refresh("price");
               }else{
                 alert(data.RESULT);
               }
             },
         }); // End Ajax
      });
			
      // Descriptive Attribute 추가
      $('button#btn_descattr_save').click(function(){
        
         var catEtnObj = new catentryObj();
         catEtnObj = toJsonCatEntry(catEtnObj, "DESC_ATTR");
         
         // BOD Parameter
         var req_xpath = new Array();
         if( catEtnObj.DescriptiveAttributes.length > 0 ){
           for(var i=0; i<catEtnObj.DescriptiveAttributes.length; i++){
             req_xpath[i] = "/CatalogEntry[1]/CatalogEntryAttributes/Attributes["+(i+1)+"]";  
           }
         }else{
           return;
         }
         
         var paramObj = new Object();
         paramObj = {
           'ACTION_CODE': "Add",  // Add, Delete, Change...
           'REQ_XPATH'  : req_xpath,
           'ContextData': [
                           {'Name':'storeId', 'Value': $('input#storeId').val()},
                           {'Name':'catalogId', 'Value': $('input#catalogId').val()}
                           /*  {'Name':'masterCatalog', 'Value': $('input#masterCatalog').val()} */
                          ],
           'CATENTRY': catEtnObj
         };
         
         $.ajax({
             url: '/ws/ChangeCatEnt.jsonp',
             type: 'POST',
             contentType: 'application/json',
             data: JSON.stringify(paramObj),
             success: function(data) {
               if(data.RESULT == null){
                 alert('Saved Successfully');
                 
                 refresh("desc-attr");
               }else{
                 alert(data.RESULT);
               }
             },
         }); // End Ajax
      });
      
      
      // Defining Attribute 추가
      $('button#btn_defiattr_save').click(function(){
        
         var catEtnObj = new catentryObj();
         catEtnObj = toJsonCatEntry(catEtnObj, "DEFI_ATTR");
         
         // BOD Parameter
         var req_xpath = new Array();
         if( catEtnObj.DefiningAttributes.length > 0 ){
           for(var i=0; i<catEtnObj.DefiningAttributes.length; i++){
             req_xpath[i] = "/CatalogEntry[1]/CatalogEntryAttributes/Attributes["+(i+1)+"]";  
           }
         }else{
           return;
         }
         
         var paramObj = new Object();
         paramObj = {
           'ACTION_CODE': "Add",  // Add, Delete, Change...
           'REQ_XPATH'  : req_xpath,
           'ContextData': [
                           {'Name':'storeId', 'Value': $('input#storeId').val()},
                           {'Name':'catalogId', 'Value': $('input#catalogId').val()}
                           /*  {'Name':'masterCatalog', 'Value': $('input#masterCatalog').val()} */
                          ],
           'CATENTRY': catEtnObj
         };
         
         console.debug(paramObj);
         
         $.ajax({
             url: '/ws/ChangeCatEnt.jsonp',
             type: 'POST',
             contentType: 'application/json',
             data: JSON.stringify(paramObj),
             success: function(data) {
               if(data.RESULT == null){
                 alert('Saved Successfully');
                 
                 refresh("defi-attr");
               }else{
                 alert(data.RESULT);
               }
             },
         }); // End Ajax
      });
      
      
      // Defining Attribute 속성값 추가
      $('a[name="btn_defi_attr_val_save"]').click(function(){
        
    	  var defining_Attributes = new Array();
    	  
    	  var idx = $('a[name="btn_defi_attr_val_save"]').index($(this));
    	  
    	  // 속성정보
    	  var attr_id = $('#defi-attr input[name="defiAttr_attId"]')[idx].value;
        var attr_seq = $('#defi-attr input[name="defiAttr_seq"]')[idx].value; 
        var type =  $('#defi-attr input[name="defiAttr_datatype"]')[idx].value;
        
        // 신규 속성값 배열
        var $attrValList = $('li[name="new_attr_vals_'+idx+'"]');
        var defi_attr_add_vals = new Array();
        
        // Request XPath배열을 생성하기 위한 index;
        var xpath_val_idx = 0;
        var req_xpath = new Array();
        
        $.each($attrValList, function(idx){
          
        	//console.debug($attrValList.find('[name="defiAttr_val_seq_new"]').eq(idx).val());
          //console.debug($attrValList.find('[name="defiAttr_val_val_new"]').eq(idx).val());
          
          var allow_new_seq = $attrValList.find('[name="defiAttr_val_seq_new"]').eq(idx).val();
          var allow_new_value = $attrValList.find('[name="defiAttr_val_val_new"]').eq(idx).val();
          
          if( allow_new_value != '' ){
            xpath_val_idx = xpath_val_idx + 1;
            defi_attr_add_vals.push({
                     'displaySequence': allow_new_seq, 'Value':allow_new_value, 
                     'ExtendedValue':[{'Name':'attrId', 'Value':attr_id},
                              {'Name':'DisplaySequence', 'Value':allow_new_seq}]
                    });
            
            req_xpath.push("/CatalogEntry[1]/CatalogEntryAttributes/Attributes[1]/AllowedValue["+ xpath_val_idx +"]");
          } 
        }); // End Each
        
        if( defi_attr_add_vals.length == 0 ){
        	alert("No Additional Value!");
          return;
        }
        
        // Defining Attribute 객체생성
        var defi_attr_obj = {
          'displaySequence':  attr_seq,
          'language': '-1',
          'usage':  'Defining',
          'AttributeDataType': type,
          'AllowedValue': defi_attr_add_vals,
          'ExtendedData': [
                            {'Name':'attrId', 'Value':attr_id}
                          ]
        };
        defining_Attributes.push(defi_attr_obj);
        
        var catEtnObj = new catentryObj();
        catEtnObj['DefiningAttributes'] = defining_Attributes;
        
        // BOD Parameter
        var paramObj = new Object();
        paramObj = {
          'ACTION_CODE': "Add",
          'REQ_XPATH'  : req_xpath,
                'ContextData': [
                        {'Name':'storeId',   'Value': $('input#storeId').val()},
                        {'Name':'catalogId', 'Value': $('input#catalogId').val()}
                       ],
          
          'CATENTRY': catEtnObj
        };
          
        console.debug(paramObj);
        
        $.ajax({
          url: '/ws/ChangeCatEnt.jsonp',
          type: 'POST',
          contentType: 'application/json',
            data: JSON.stringify(paramObj),
            
          success: function(data) {
            console.debug("result: "+data);
            refresh("defi-attr");
          },
          
        }); // End Ajax
      }); // End Click
			
      
      
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
      
      
    }); // End Init
	    
	    
     
     
	   function toJsonCatEntry(catEntObj, type){
    	 
     	 if( type == 'DESC'){
    		 
 	       /**
             Description[0]/Attributes/auxDescription1
             Description[0]/Attributes/auxDescription2
             Description[0]/Attributes/available
             Description[0]/Attributes/published
             Description[0]/Attributes/availabilityDate
         */
    	   var desc_Attributes = new Array();
    		 desc_Attributes[0] = { Name: "published", Value: ""+$('#available:checked').length };
    		 desc_Attributes[1] = { Name: "available", Value: ""+$('#available:checked').length };
         desc_Attributes[2] = { Name: "availabilityDate", Value: $('input#availabilityDate').val() };
         desc_Attributes[3] = { Name: "auxDescription1", Value: $('input#auxDescription1').val() };
         desc_Attributes[4] = { Name: "auxDescription2", Value: $('input#auxDescription2').val() }; 
         desc_Attributes[5] = { Name: "field1", Value: "field1" }; 
         desc_Attributes[6] = { Name: "field2", Value: "field2" }; 
         desc_Attributes[7] = { Name: "field3", Value: "field3" }; 
         
         var description = new Array();
         // Editor's HTML
         $('input#LongDescription').val(DEXT5.getHtmlValueEx());
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
         catEntObj.Description = description;
         
         
         //----------------- CatalogEntryAttributes - General Attributes
         var catEnt_Attributes = new Array();
         $.each( $('[name="clssAttr"]'), function(idx){
                  
           var $clssObj = $('[name="clssAttr"]').eq(idx);
           // console.debug("[name]" + $clssObj.attr('id'));
           // console.debug("[value]"+ $clssObj.val());
           
           catEnt_Attributes.push( { Name: $clssObj.attr('id'), Value: $clssObj.val() } );
         });
         catEntObj.CatalogEntryAttributes = catEnt_Attributes;
    	}
			
			
    	if( type == 'LISTPRICE'){
    	        
        //----------------- ListPrice Attributes
        var listPriceObj = new Object();
        var altCurrPrice = new Array();
        
        $.each($('[name="listPrcCurr"]'), function(idx){
        	var $prcObj = $('[name="listPrcCurr"]').eq(idx);
        	
        	if($prcObj.attr("id") == 'USD'){
        		listPriceObj.currency = $prcObj.attr("id");
        		listPriceObj.price = $prcObj.val();
        		listPriceObj.quantity = "1";
        	}else{
        		if($.trim($prcObj.val()) != ''){
        			  altCurrPrice.push( {'currency':$prcObj.attr("id"), 'price':$prcObj.val()} );
        		}
        	}
                   	
        });
        
        if(altCurrPrice.length > 0){
        	listPriceObj.AlternativeCurrencyPrice = altCurrPrice;	
        }
        
        catEntObj.ListPrice = listPriceObj;
      }
			
    	
    	if( type == 'DESC_ATTR'){
            
   		  //----------------- DESCIRPTIVE Attributes
         var descriptive_Attributes = new Array();
         for(var i=0; i < $('input[name="new_descAttr_name[]"]').length; i++){
           
           if($('input[name="new_descAttr_name[]"]')[i].value == '' ||
               $('select[name="new_descAttr_datatype[]"]')[i].value == '' ||
                 $('input[name="new_descAttr_value[]"]')[i].value == ''){
             continue;
           }
           
           descriptive_Attributes.push( {
             'language': '-1',
             'usage':  'Descriptive',
             'displaySequence':  $('input[name="new_descAttr_seq[]"]')[i].value,
             'Name': $('input[name="new_descAttr_name[]"]')[i].value,
             'AttributeDataType':$('select[name="new_descAttr_datatype[]"]')[i].value,
             'Value':  $('input[name="new_descAttr_value[]"]')[i].value,
             'TypeValue':  $('input[name="new_descAttr_value[]"]')[i].value
              /* 'Description':  'Description' */
              /* 'ExtendedData': [
                               {'Name':'SecondaryDescription', 'Value':'a'},
                               {'Name':'DisplayGroupName', 'Value':'b'},
                               {'Name':'Field1', 'Value':'c'},
                               {'Name':'Footnote', 'Value':'d'}
                              ] */
           });
         }
         
         catEntObj.DescriptiveAttributes = descriptive_Attributes;
    	 } // End if
    	 
    	 
	   if( type == 'DEFI_ATTR'){
	     var defining_Attributes = new Array();
	     for(var i=0; i < $('input[name="new_defiAttr_name[]"]').length; i++){
	          
	       if($('input[name="new_defiAttr_name[]"]')[i].value == '' ||
	    		   $('select[name="new_defiAttr_datatype[]"]')[i].value == ''){
	         continue;
	       }
		          
	       defining_Attributes.push( {
	                 'language': '-1',
	                 'usage':  'Defining',
	                 'displaySequence':  $('input[name="new_defiAttr_seq[]"]')[i].value,
	                 'Name': $('input[name="new_defiAttr_name[]"]')[i].value,
	                 'AttributeDataType':$('select[name="new_defiAttr_datatype[]"]')[i].value,
	                 'Description': $('input[name="new_defiAttr_description[]"]')[i].value
                   /* 'ExtendedData': [
                                    {'Name':'SecondaryDescription', 'Value':'a'},
                                    {'Name':'DisplayGroupName', 'Value':'b'},
                                    {'Name':'Field1', 'Value':'c'},
                                    {'Name':'Footnote', 'Value':'d'}
                                   ] */
	        });
	      }
	     
	      catEntObj.DefiningAttributes = defining_Attributes;
	   }
    	 
	   if( type == 'DEFI_SKU_ATTR'){
	     
	       var defining_Attributes = new Array();
	       
	       var idx = 0;
	       var $attrSeqList = $('input[name="defiAttr_seq"]');
	       // $.each($attrSeqList, function(idx){
	    	   
	    	   var seq = $('input[name="defiAttr_seq"]').eq(idx).val();
	    	   var attrId = $('input[name="defiAttr_attId"]').eq(idx).val();
	    	   var attrName = $('input[name="defiAttr_name"]').eq(idx).val();
	    	   var description = $('input[name="defiAttr_description"]').eq(idx).val();
	    	   var datatype = $('input[name="defiAttr_datatype"]').eq(idx).val();
	    	   
	    	   var $attrValList = $('ul[name="ul_attr_vals_'+idx+'"]').children();
          
	    	   
	    	   /* defi_attr_add_vals.push({
                   'displaySequence': allow_new_seq, 'Value':allow_new_value, 
                   'ExtendedValue':[{'Name':'attrId', 'Value':attr_id},
                            {'Name':'DisplaySequence', 'Value':allow_new_seq}]
                  }); */
	    	   
	    	   defining_Attributes.push( {
                   'language': '-1',
                   'usage':  'Defining',
                   'displaySequence': seq,
                   'Name': attrName,
                   'AttributeDataType': datatype,
                   'Description': description,
                   'Value':  'L',
                   'TypeValue':  'L',
                   'ExtendedValue': [
                                    {'Name':'attrId', 'Value':attrId},
                                    {'Name':'DisplaySequence', 'Value':'0.0'}
                                   ]
           });
	       //});
	       
	        catEntObj.DefiningAttributes = defining_Attributes;
	      }
	    
      console.debug(catEntObj);
    	return catEntObj;
	    	
	  }
    
    function refresh(tabId){
    	var store_id = $('#storeId').val();
      var catalog_id = $('#catalogId').val();
      var catentry_id = $('#catEntId').val();
        
      location.href = "/ws/getCatEntDetail.do?store_id="+store_id+"&catalog_id="+catalog_id+"&catentry_id="+catentry_id+"&tab_id="+tabId;
    }
     
	    
      
      
	    
    </script>
  </body>
</html>


