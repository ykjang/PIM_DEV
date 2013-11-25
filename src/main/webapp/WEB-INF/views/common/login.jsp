<%@ page language="java" contentType="text/html;charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>mailPlants</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link rel="stylesheet" type="text/css" href="/lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/lib/bootstrap/stylesheets/theme.css">
    <link rel="stylesheet" href="/lib/bootstrap/font-awesome/css/font-awesome.css">
    
    <style type="text/css">

      .form-signin {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 50px auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

    </style>

		<script src="/lib/jquery-1.8.1.min.js"></script>
		<script src="/lib/jquery.cookie.js"></script>
		
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
  
   <div class="navbar">
     <div class="navbar-inner">
       <ul class="nav pull-right">
       </ul>
      <a class="brand" href="index.html"><span class="first">mailPlants</span> <span class="second">Admin System</span></a>
     </div>
    </div>
    
  
    <div class="container">
    <!--===================== Main Content Area S =====================-->
      <form:form id="loginFrm" class="form-signin">
        <h2 class="form-signin-heading">Please sign in</h2>
        <div id="loginAlert" class="alert alert-error" style="display:none;">
		        <!-- <button type="button" class="close" data-dismiss="alert">x</button> -->
		    </div>
        <input type="text" class="input-block-level" placeholder="User Id" id="id" name="id">
        <input type="password" class="input-block-level" placeholder="Password" id="pwd" name="pwd" value="qwer1234">
        <label class="checkbox">
          <input type="checkbox" value="remember-me" id="saveId"> Remember me
        </label>
        <button class="btn btn-large btn-primary" type="button" id="btn_signin">Sign in</button>
      </form:form>
    </div>
    
    
    <script type="text/javascript">
        
    		function setCookie(user_id){
    			
    			if( $('input:checkbox[id="saveId"]').is(":checked") ){
    				
    				if($.cookie('mp_user_id') != null){
    					if($.cookie('mp_user_id') == user_id) return;
    					else $.removeCookie('mp_user_id');
    				}    				
    				$.cookie('mp_user_id', user_id, { expires: 7 });
    				
    			}else{
    				if($.cookie('mp_user_id') != null) $.removeCookie('mp_user_id');
    			}
    		}
    		
        $(document).ready(function(){
        	
        	if($.cookie('mp_user_id') != null){
        		$('input#id').val($.cookie('mp_user_id'));
        		$('input:checkbox[id="saveId"]').attr('checked', true);
        	}
        	
		    	$('input#pwd').keydown(function(e){
			    		if(e.keyCode == 13){
			    			var $btnSignin = $('#btn_signin');
			    			$btnSignin.click();
			    		}
			    	});
		   		
	   			$('#btn_signin').click(function(e){
		           
		        	var user_id =  $.trim($('input#id').val());
				   		var user_pwd =  $.trim($('input#pwd').val());
				   		
				   		// form object value check.
				   		if(user_id == "" || user_id == null){
				   			$('#loginAlert').html("Please enter the your id");
				   			$('#loginAlert').show();
				   			
				   			$('input#id').focus();
				   			return;
				   		}else if(user_pwd == "" || user_pwd == null){
				   			$('#loginAlert').html("Please enter the your password");
				   			$('#loginAlert').show();
				   			
				   			$('input#pwd').focus();
				   			return;
				   		}else{
				   			
				   			
			   			$.ajax({
			   				url: '/json/loginProc.jsonp',
			   				type: 'POST',
			   				contentType: 'application/json',
			   			  data: JSON.stringify({'id':user_id, 'pwd':user_pwd}),
			   				success: function(data) {
		   						
			   					setCookie(user_id);
		   						setTimeout(function(){
		   							
		   							if(data.RESULT == 'R00'){
		   								document.location.href = '/index.do';
		   							}else if(data.RESULT == 'R01' || data.RESULT == 'R02'){
	  			   					$('#loginAlert').html("ID does not exist or Password is incorrect.");
	  					   			$('#loginAlert').show();
		   							}else if(data.RESULT == 'R99'){
	  			   					$('#loginAlert').html("Log in failed. Please try again.");
	  					   			$('#loginAlert').show();
		   							}
									}, 300);
		   					},
			   			}); // End Ajax
				   			
				   			
				   		/* ------------------------------------------------------ 	
				   		  var jsonStr = {'id':user_id, 'pwd':user_pwd};
				   			var param = {
				   				type: 'POST',
				   				url: '/json/loginProc.jsonp',
				   				dataType: 'json',
				   				contentType: 'application/json',
				   				data: JSON.stringify(jsonStr),
				   				cache: false,
				   				beforeSend: function(data){
				   					maskWindow(e);
				   				},
				   				success: function(data) {
				   					
				   					setCookie(user_id);
			   						setTimeout(function(){
			   							
			   							  // R00 - Success
			   							  // R01 - Not User 
				   						  // R02 - Not Match Password 
				   						  // R99 - Server Error
			   							if(data.RESULT == 'R00'){
			   								document.location.href = '/index.do';

			   							}else if(data.RESULT == 'R01' || data.RESULT == 'R02'){
					   						unmaskWindow(e);
		  			   					$('#loginAlert').html("ID does not exist or Password is incorrect.");
		  					   			$('#loginAlert').show();
			   							}else if(data.RESULT == 'R99'){
					   						unmaskWindow(e);
		  			   					$('#loginAlert').html("Log in failed. Please try again.");
		  					   			$('#loginAlert').show();
			   							}
										}, 300);
				   				},
				   				error: function(xhr, ajaxOptions, thrownError) {
				   					unmaskWindow(e);
				   					$('#loginAlert').html("["+xhr.status+"] "+thrownError);
				   				}
				   			};
				   			$.ajax(param); 
				   			------------------------------ */
				   		}
		        });
		     });
        
    </script>
  </body>
</html>


