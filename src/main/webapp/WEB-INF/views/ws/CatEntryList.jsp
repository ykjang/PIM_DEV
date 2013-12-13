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
	    <h1 class="page-title">CatalogEntry List</h1>
 	</div>
	 	
 	<!-- location bar -->
  	<ul class="breadcrumb">
	      <li><a href="/index.do">Home</a> <span class="divider">/</span></li>
	      <li><a href="#">WebService</a><span class="divider">/</span></li>
	      <li class="active">CateEntry List</li>
	  	</ul>
	  	
  	   <br />
       <div class="container-fluid">
       <div class="row-fluid">
			<!-- Contents Area S -->
			<div class="row-fluid">
				<div class="span12">
					<div class="navbar">
						<form class="navbar-form pull-left" id="actfrm" name="actfrm">
							<input type="hidden" id="store_id" value="10051">
							<input type="hidden" id="catalog_id" value="10051">
							<!-- <input type="hidden" id="store_id" value="10001">
							<input type="hidden" id="catalog_id" value="10001"> -->
							<select class="select-medium" id="prt_catgrp_id" name="prt_catgrp_id" >
				    			<option value="">:::SELECT:::</option>
								<option value="10083">Girls Dresses and Skirts</option>
								<option value="10082">Bottoms</option>
								<option value="10081">Tops</option>
								<option value="10080">Sleepers and Pyjamas</option>
								
								<!-- <option value="10008">Brake Pads</option>
								<option value="10009">Master Cylinders</option>
								<option value="10010">Tires</option> -->
							</select>
							<button type="button"  id="btn_srch" class="btn btn-primary" onclick="doSearch();">Search</button>
					  </form>
					</div>
				</div>
	 		</div>
			<div class="row-fluid">
				<div class="span12">
					<!-- jqGrid -->		
					<table id="catentryListGrid" class="block-body collapse in scroll" ></table>
					<div id="pager2"></div>
					<!-- jqGrid -->     
				</div>
			</div> 
			<div class="row-fluid">
        <div class="span12">
          <!-- jqGrid -->   
          <table id="skuListGrid" class="block-body collapse in scroll" ></table>
          <div id="pager3"></div>
          <!-- jqGrid -->     
        </div>
      </div> 
			<!-- Contents Area S -->
	
	<!--===================== Bottom Menu Area S =====================-->
	<%@ include file="/inc/inc_bottom.html" %>
	<!--===================== Bottom Menu Area E =====================-->
	</div><!--/row-fluid-->    
 	</div><!--/container-fluid-->    
</div><!--/content-->
                    
    <script type="text/javascript">
		$(document).ready(function() {
	    	
					// jQgrid
					$("#catentryListGrid").jqGrid({   
				    	// url:"/ws/getCatEntByPCatGrpId.jsonp",
				    	url:"",
				        datatype: "json",
				        autowidth: true,
				        width: 'auto',
				        height: 'auto',
				        jsonReader : {
							page: "page", 
							total: "total", 
							root: "catEntList", 
							records: function(obj){return obj.length;},
							repeatitems: false, 
							id: "uniqueID"
						}, 

		        colNames:['Seq','Thumbnail','Type', 'UniqueID','PartNumber','Parent Catalog','Name','available','published','ownerID','currency','Price',
		                  'Detail'
		                  ],
			   		colModel:[
							{name:'displaySequence',index:'Type', width:30, align:"center" },
							{name:'thumbnail', index:'Thumbnail', jsonmap:'descList', align:"center", width:73, 
									formatter: function (cellvalue) {
							        var thumNameTag = "<image src='http://localhost/wcsstore/Madisons/"+ cellvalue[0].thumbnail +"' alt='"+cellvalue[0].thumbnail+"'/>";
							        return thumNameTag;
							    }},
							{name:'catalogEntryTypeCode',index:'Type', width:60, align:"center" },
				   		{name:'uniqueID',index:'UniqueID', width:60, align:"center" },
				   		{name:'partNumber',index:'PartNumber', width:80, align:"center" },
				   		{name:'prntCatGrp.groupIdentifier',index:'GroupIdentifier', width:100, align:"center" },
				   		/* {name:'groupIdentifier',index:'GroupIdentifier', jsonmap:'prntCatGrp', width:100, align:"center",
				   			formatter: function (cellvalue) {
	                     return cellvalue.groupIdentifier;
	                 }
				   		}, */
				   		{name:'name', index:'Name', jsonmap:'descList', width:150, align:"left",
				   			formatter: function (cellvalue) {
				                return cellvalue[0].name;
				            }
				   		},
	            {name:'available', index:'available', jsonmap:'descList',  width:40, align:"center",
				   			formatter: function (cellvalue) {
				                return cellvalue[0].available == '1'?'Yes':'No';
				            }
				   		},
	            {name:'published', index:'published', jsonmap:'descList',  width:40, align:"center",
				   			formatter: function (cellvalue) {
				                return cellvalue[0].published == '1'?'Yes':'No';
				            }
				   		},
				   		{name:'ownerID',index:'ownerID', width:100},
				   		{name:'listPrice.currency',index:'currency', width:50, align:"center"},
				   		{name:'listPrice.price',index:'Price', width:60, align:"right", formatter:'currency', formatoptions:{thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "}},
				   		
				   		{name:'uniqueID', align:"center", width:100, 
			                  formatter: function (val) {
			                	  
			                	   var htmlCode = "<a href=\"javascript:viewDetail('"+val+"');\">[Detail]</a>&nbsp;"
			                                    + "<a href=\"javascript:viewSKUList('"+val+"');\">[SKU List]</i></a>";
			                	  
			                      return htmlCode;
			                  }}
				   	],
				 	rowNum: 30,
					rownumbers: true,
				   	rowList:[5,10,30,50],  
				   	pager: '#pager2', 
				   	mtype: 'POST',
				   	pgbuttons: true,
				    viewrecords: true,
				 	sortname: 'UniqueID',
			    // sortable: false,
			    // sortorder: "desc",
			    caption:"Catalog Entry List",
			    
			    // CatEntry 상세조회
			    ondblClickRow: function(id){
			    	var store_id = $('#store_id').val();
		    		var catalog_id = $('#catalog_id').val();
		    		
			    	location.href = "/ws/getCatEntDetail.do?store_id="+store_id+"&catalog_id="+catalog_id+"&catentry_id="+id+"&tab_id=basic";;
			    	//location.href = "/ws/getCatEntDefiAttr.do?param="+JSON.stringify(paramObj);
			    },
			    
			    loadComplete : function (res) {
			    	// to convert the request using JSON.parse to JavaScrip object you do maybe this:
			    	//var myrequest  = JSON.parse(request.responseText);
			    	// console.debug(res);
			    },
			    
			    gridComplete: function(){
			    	
					  var ids = $("#catentryListGrid").jqGrid('getDataIDs');
					  for(var i=0;i < ids.length;i++){
						
						var rowObj = $("#catentryListGrid").jqGrid('getRowData',ids[i]);
						// console.debug("["+i+"]"+rowObj);
						// console.debug("["+i+"]"+rowObj.Thumbnail);
						
						// User Detail Link
						// detail ="<b><a href=\'#' onclick=\"javascript:viewDetail('"+rowObj.UniqueID+"',event);\">"+rowObj.UniqueID+"</a></b>";
						// Activate Button
						/* if(rowObj.activate_yn == 'Y'){
							act = "<input style='width:80px;' class='btn btn-info' type='button' value='inactivate' onclick=\"javascript:procActUser('"+rowObj.id+"','N')\"  />";	
						}else{
							act = "<input style='width:80px;' class='btn btn-success' type='button' value='activate' onclick=\"javascript:procActUser('"+rowObj.id+"','Y')\"  />";
						} */
						
						
					}
				},
				onPaging: function(){
					$('#mask').unbind('ajaxStart');
					$('#loadingBar').unbind('ajaxStart');
				},
	    		loadError : function(xhr,st,err) {
			    	$("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
			  	}
			}); // End jqGrid ( Catentry List)
			
			
			// Header Grouping
			$("#catentryListGrid").jqGrid('setGroupHeaders',{
			    "useColSpanStyle":true,
			    "groupHeaders" : [
			        { startColumnName:'LISTPRICE.currency', numberOfColumns:2, titleText:'List Price' }
			    ]
			});
			$("#catentryListGrid").jqGrid('navGrid','#pager2',{del:false,add:false,edit:false,search:false});
			
			
			
				
	    	// jQgrid ( SKU List)
        $("#skuListGrid").jqGrid({   
	         url:"",
	         datatype: "json",
	         autowidth: true,
	         width: 'auto',
	         height: 'auto',
	         jsonReader : {
	           page: "page", 
	           total: "total", 
	           root: "catEntList", 
	           records: function(obj){return obj.length;},
	           repeatitems: false, 
	           id: "uniqueID"
	         }, 

          colNames:['Seq','Thumbnail','Type', 'UniqueID','PartNumber','Name','available','published','ownerID','currency','Price',
                    'Detail'
                   ],
          colModel:[
              {name:'displaySequence',index:'Type', width:30, align:"center" },
              {name:'thumbnail', index:'Thumbnail', jsonmap:'descList', align:"center", width:73, 
                  formatter: function (cellvalue) {
                      var thumNameTag = "<image src='http://localhost/wcsstore/Madisons/"+ cellvalue[0].thumbnail +"' alt='"+cellvalue[0].thumbnail+"'/>";
                      return thumNameTag;
                  }},
              {name:'catalogEntryTypeCode',index:'Type', width:60, align:"center" },
              {name:'uniqueID',index:'UniqueID', width:60, align:"center" },
              {name:'partNumber',index:'PartNumber', width:80, align:"center" },
              /* {name:'prntCatGrp.groupIdentifier',index:'GroupIdentifier', width:100, align:"center" }, */
              {name:'name', index:'Name', jsonmap:'descList', width:150, align:"left",
                formatter: function (cellvalue) {
                        return cellvalue[0].name;
                    }
              },
              {name:'available', index:'available', jsonmap:'descList',  width:40, align:"center",
                formatter: function (cellvalue) {
                        return cellvalue[0].available == '1'?'Yes':'No';
                    }
              },
              {name:'published', index:'published', jsonmap:'descList',  width:40, align:"center",
                formatter: function (cellvalue) {
                        return cellvalue[0].published == '1'?'Yes':'No';
                    }
              },
              {name:'ownerID',index:'ownerID', width:100},
              {name:'listPrice.currency',index:'currency', width:50, align:"center"},
              {name:'listPrice.price',index:'Price', width:60, align:"right", formatter:'currency', formatoptions:{thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "}},
              
              {name:'uniqueID', align:"center", width:100, 
                 formatter: function (val) {
                   
                    var htmlCode = "<a href=\"javascript:viewDetail('"+val+"');\">[Detail]</a>&nbsp;";
                     return htmlCode;
                 }
              }
          ],
          rowNum: 30,
          rownumbers: true,
          rowList:[5,10,30,50],  
          pager: '#pager3', 
          mtype: 'POST',
          pgbuttons: true,
          viewrecords: true,
          sortname: 'UniqueID',
          // sortable: false,
          // sortorder: "desc",
          caption:"SKU List",
          
          // CatEntry 상세조회
          ondblClickRow: function(id){
            var store_id = $('#store_id').val();
            var catalog_id = $('#catalog_id').val();
            
            location.href = "/ws/getCatEntDetail.do?store_id="+store_id+"&catalog_id="+catalog_id+"&catentry_id="+id+"&tab_id=basic";;
            //location.href = "/ws/getCatEntDefiAttr.do?param="+JSON.stringify(paramObj);
          },
          
          loadComplete : function (res) {
          },
          gridComplete: function(){
          },
	        onPaging: function(){
	          $('#mask').unbind('ajaxStart');
	          $('#loadingBar').unbind('ajaxStart');
	        },
          loadError : function(xhr,st,err) {
            $("#rsperror").html("Type: "+st+"; Response: "+ xhr.status + " "+xhr.statusText);
          }
      }); // End jqGrid (SKU List)
      
      
      // Header Grouping
      $("#skuListGrid").jqGrid('setGroupHeaders',{
          "useColSpanStyle":true,
          "groupHeaders" : [
              { startColumnName:'LISTPRICE.currency', numberOfColumns:2, titleText:'List Price' }
          ]
      });
      $("#skuListGrid").jqGrid('navGrid','#pager3',{del:false,add:false,edit:false,search:false});
      
	    	
			// Search Form Setting
    	$('#btn_srch').keydown(function(e){
    			if(e.keyCode == 13){
    				doSearch();
    				return false;
    			}
    	});
    }); // End Init
	    
	    
    function doSearch(){
	    	
			var prt_catgrp_id = $("#prt_catgrp_id").val();
			var store_id = $('#store_id').val();
   		var catalog_id = $('#catalog_id').val();
   		
   		// IBM_Admin_Details
   		var paramObj = new Object();
   		paramObj = {
   			'ACTION_CODE': "Get",
   			'REQ_XPATH'  : [
		                    "{_wcf.ap=IBM_Admin_Details}/CatalogEntry[ParentCatalogGroupIdentifier[(UniqueID='"+prt_catgrp_id+"')]]"
		                   ],
               'ContextData': [
    			            {'Name':'storeId',   'Value': store_id },
    			            {'Name':'catalogId', 'Value': catalog_id }
    			           ]
   		};
   		
			jQuery("#catentryListGrid").jqGrid('setGridParam',
			{
				url:"/ws/getCatEntByPCatGrpId.jsonp?param="+JSON.stringify(paramObj),
				page:1
			}).trigger("reloadGrid");
		}
	    
	  
		function viewDetail(id){
       var store_id = $('#store_id').val();
       var catalog_id = $('#catalog_id').val();
       
       location.href = "/ws/getCatEntDetail.do?store_id="+store_id+"&catalog_id="+catalog_id+"&catentry_id="+id+"&tab_id=basic";
		 }
	  
		
		function viewSKUList(id){
      var store_id = $('#store_id').val();
      var catalog_id = $('#catalog_id').val();
      
      // IBM_Admin_Details
      var paramObj = new Object();
      paramObj = {
        'ACTION_CODE': "Get",  // Add, Get,  Delete, Change...
        'REQ_XPATH'  : [ "{_wcf.ap=IBM_Admin_Details}/CatalogEntry[ParentCatalogEntryIdentifier[(UniqueID='"+id+"')]]"],
        'ContextData': [
                        {'Name':'storeId',   'Value': store_id },
                        {'Name':'catalogId', 'Value': catalog_id }
                       ]
      };
      
      jQuery("#skuListGrid").jqGrid('setGridParam',
	      {
    	    url:"/ws/getSKUList.jsonp?param="+JSON.stringify(paramObj),
          page:1
	      }).trigger("reloadGrid");
      
      /* $.ajax({
          url: '/ws/getSKUList.jsonp',
          type: 'POST',
          contentType: 'application/json',
          data: JSON.stringify(paramObj),
          success: function(data) {
        	  console.debug(data);
          },
      }); // End Ajax */
      
      
    }
		
	    
    </script>
    
  </body>
</html>


