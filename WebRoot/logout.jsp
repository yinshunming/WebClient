<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Add New Bug</title>
<!--     <meta http-equiv="cache-control" content="max-age=0" >
	<meta http-equiv="cache-control" content="no-cache" >
	<meta http-equiv="expires" content="0" >
	<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" >
	<meta http-equiv="pragma" content="no-cache" > -->
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="bootstrap/css/validation.css"/>
	<link rel="stylesheet" href="css/placeholder.css" />
	<link rel="stylesheet" href="alertify/css/alertify.core.css" />
	<link rel="stylesheet" href="alertify/css/alertify.default.css" />
	<!--[if lte IE 6]>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-ie6.css">
	<link rel="stylesheet" type="text/css" href="bootstrap/css/ie.css">
	<![endif]-->
	<script src="jquery/jquery-1.10.2.min.js"></script>
	
	<script src="bootstrap/js/bootstrap.min.js" ></script>
<!-- 	<script src="js/placeholders.min.js"></script> -->
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	  <script src="js/respond.min.js"></script>
	  
	<![endif]-->
	<script src="alertify/js/alertify.min.js"></script>
	<script type="text/javascript">
		function createXMLObject() {
	    try {
	        if (window.XMLHttpRequest) {
	            xmlhttp = new XMLHttpRequest();
	        }
	        // code for IE
	        else if (window.ActiveXObject) {
	            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	        }
	    } catch (e) {
	        xmlhttp=false;
	    }
    return xmlhttp;
}
	
	$(document).ready(function(){
		$("#logout").addClass("active");
		
		var logoutForm = $("#logoutForm");
		var logoutFormButton = $("#logoutFormSb");
		
		$.ajax({
				type: 'get',
				url: logoutForm.attr('action'),
				data: "",
				cache : false,
				success: function (data, textStatus) {	
					 $("#username").val(data);
				},
				
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
				complete: function (XMLHttpRequest, textStatus) {
				
				}
			});
		
		logoutFormButton.click(function() {
			
			
			logoutFormButton.button('loading');
			
			//document.execCommand("ClearAuthenticationCache");
      		//window.location.href='http://localhost:8080/WebCliet/logout.jsp';
            
      		/*
      		var username = $("#username").val();

      		if (!$.support.leadingWhitespace) {
         		document.execCommand("ClearAuthenticationCache");
          		$("#username").val("logging out success!");
    			logoutFormButton.button('reset');	
      		} 
      		else {
				$.ajax({
					type: 'post',
					url: "/BugTrackingSystem/api/logout?username=" + username,
					data: "",
					cache : false,
					success: function (data, textStatus) {	
						
					},
					
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						
					},
					
					complete: function (XMLHttpRequest, textStatus) {
						 $("#username").val("logging out success!");
						 logoutFormButton.button('reset');	 
					}
				});
      		}
 			*/
      		
			window.location.href = "http://logout@" + location.hostname + ":" + location.port + "/WebClient/logout.jsp";

			/*
			try{
			  var agt=navigator.userAgent.toLowerCase();
			  if (agt.indexOf("msie") != -1) {
			    // IE clear HTTP Authentication
			    document.execCommand("ClearAuthenticationCache");
			  }
			  else {
			    // Let's create an xmlhttp object
			    var xmlhttp = createXMLObject();
			    // Let's get the force page to logout for mozilla
			    xmlhttp.open(logoutForm.attr('method'),logoutForm.attr('action'),true,"logout","logout");
			    // Let's send the request to the server
			    xmlhttp.send("");
			    // Let's abort the request
			   // var t=setTimeout("alert('5 seconds!')",5000);
			    xmlhttp.abort();
			  }
			  // Let's redirect the user to the main webpage
			} catch(e) {
				// There was an error
				alert("there was an error");
			}
			*/
			/*
			var xhr =  $.ajax({
				type: logoutForm.attr('method'),
				url: logoutForm.attr('action'),
				data: "",
				
				beforeSend: function (xhr) {
    				xhr.setRequestHeader ("Authorization", "Basic XXXXXX");
				},
				
				success: function (data, textStatus) {	
					
				},
				
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					logoutFormButton.button('reset');
				}
			});
			
			
			xhr.send(null);
			xhr.abort();
			window.location.reload();
			*/
		});
		

	});
	
	</script>
	
  </head>
 	
  <body>

		
  		<%@ include file="navigation.jsp" %>
			
 			<div class="container" style="padding-top:70px" >
 				<div class="row">
 						
						<div id="userNameDiv" class="col-lg-4" >
							<h4>Current Logged User:</h4>
							<form id="logoutForm" name="logoutForm" method="post" action="/BugTrackingSystem/api/logout" class="well form-horizontal">
								<div class="form-group">
						  		    <label class="control-label col-lg-4">Username</label> 
						  		   	<div class="col-lg-8">
						  		    <input class="form-control" type="text" id="username" name="username" placeholder="UserName" readonly="true"> 
						  		    </div>
					  		    </div>
				  		    
					  		    <div class="form-group">
							  		<div class="col-lg-offset-4 col-lg-8">
		
						  		    <button class="btn btn-default" type="button" id="logoutFormSb" name="logoutFormSb" data-loading-text="Loading...">Logout</button>
						  		    </div>
					  		    </div>
							</form>
						</div>
		        </div>
			</div>

  </body>
 <!-- jQuery 1.7.2 or higher -->
  <!--[if lte IE 6]>
  <script type="text/javascript" src="js/bootstrap-ie.js"></script>
  <![endif]-->
</html>
