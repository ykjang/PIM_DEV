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
							<select class="select-medium" id="prt_catgrp_id" name="prt_catgrp_id" >
				    			<option value="">:::SELECT:::</option>
								<option value="10083">Girls Dresses and Skirts</option>
								<option value="10082">Bottoms</option>
								<option value="10081">Tops</option>
								<option value="10080">Sleepers and Pyjamas</option>
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
					root: "dataList", 
					records: function(obj){return obj.length;},
					repeatitems: false, 
					id: "UniqueID"
				}, 

		        colNames:['Seq','Thumbnail','Type', 'UniqueID','PartNumber','Parent Catalog','Name','available','published','ownerID','currency','Price'],
		   		colModel:[
					{name:'displaySequence',index:'Type', width:30, align:"center" },
					{name:'Thumbnail', index:'Thumbnail', jsonmap:'DESCRIPTION', align:"center", width:73, 
							formatter: function (cellvalue) {
					        var thumNameTag = "<image src='http://localhost/wcsstore/Madisons/"+ cellvalue[0].Thumbnail +"' alt='"+cellvalue[0].Thumbnail+"'/>";
					        return thumNameTag;
					    }},
					{name:'catalogEntryTypeCode',index:'Type', width:60, align:"center" },
			   		{name:'UniqueID',index:'UniqueID', width:60, align:"center" },
			   		{name:'PartNumber',index:'PartNumber', width:80, align:"center" },
			   		{name:'PARENTGRPINFO.GroupIdentifier',index:'GroupIdentifier', width:100, align:"center" },
			   		{name:'Name', index:'Name', jsonmap:'DESCRIPTION',  width:150, align:"left",
			   			formatter: function (cellvalue) {
			                return cellvalue[0].Name;
			            }},
		            {name:'available', index:'available', jsonmap:'DESCRIPTION',  width:40, align:"center",
			   			formatter: function (cellvalue) {
			                return cellvalue[0].available == '1'?'Yes':'No';
			            }},
		            {name:'published', index:'published', jsonmap:'DESCRIPTION',  width:40, align:"center",
			   			formatter: function (cellvalue) {
			                return cellvalue[0].published == '1'?'Yes':'No';
			            }},
			   		{name:'ownerID',index:'ownerID', width:100},
			   		{name:'LISTPRICE.currency',index:'currency', width:50, align:"center"},
			   		{name:'LISTPRICE.Price',index:'Price', width:80, align:"right", formatter:'currency', formatoptions:{thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ "}}
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
			    ondblClickRow: function(id){
			    	// var id = $("#catentryListGrid").jqGrid('getGridParam','selrow');	// Get Selected Row ID
			    	// var rowObj = jQuery("#catentryListGrid").jqGrid('getRowData',id); // Get Selected Row Object
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
			});
			
			
			// Header Grouping
			$("#catentryListGrid").jqGrid('setGroupHeaders',{
			    "useColSpanStyle":true,
			    "groupHeaders" : [
			        { startColumnName:'LISTPRICE.currency', numberOfColumns:2, titleText:'List Price' }
			    ]
			});
			$("#catentryListGrid").jqGrid('navGrid','#pager2',{del:false,add:false,edit:false,search:false});
			
			
			$('#btn_active_act').click(function(){
	    		
	    		var user_id = $('input[name="act_user_id"]').val();
	    		var act_yn = $('input[name="act_yn"]').val();
	    		
	    		$.ajax({
	     			url: '/json/activate.jsonp',
	     			data: {'id' : user_id, 'activate' : act_yn},
	     			success: function(result) {
	     				
	       				if(result.UPDATE_YN){
	       					// Grid Refresh
	       					$("#catentryListGrid").jqGrid('setGridParam',{url:"/json/user/status.jsonp"}).trigger("reloadGrid");
	       					// Message
	       					var resultMsg = act_yn=="Y"?"activated":"inactivated";
	       					resultMsg = "'"+user_id+"' account is "+ resultMsg;
	       					
	       					$('#modal_contents').html(resultMsg);
     				    	$('#btn_active_act').hide();
       					}
	     				}
	     		}); // End Ajax
	    		
	    	});
				
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
			
			/* 
			console.log("[prt_catgrp_id]"+prt_catgrp_id);
			console.log("[store_id]"+store_id);
			console.log("[catalog_id]"+catalog_id);
			 */
			jQuery("#catentryListGrid").jqGrid('setGridParam',
											{
												url:"/ws/getCatEntByPCatGrpId.jsonp?prt_catgrp_id="+prt_catgrp_id+"&store_id="+store_id+"&catalog_id="+catalog_id, 
												page:1
											}).trigger("reloadGrid");
		}
	    
	    
    </script>
    
  </body>
</html>


