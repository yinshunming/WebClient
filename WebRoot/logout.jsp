<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Add New Bug</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
	<script src="jquery/jquery-1.10.2.min.js"></script>
	
	<script src="bootstrap/js/bootstrap.min.js" ></script>

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
		
			window.location.href="http://logout@" + location.hostname + ":" + location.port + "/WebClient/logout.jsp";
			
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
 		
</html>
