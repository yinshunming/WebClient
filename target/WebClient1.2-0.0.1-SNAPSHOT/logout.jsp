<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Log Out</title>
	<link rel="stylesheet" href="assets/css/common.min.css" />
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
	 <script src="assets/js/common.min.js"></script>
	 <script src="assets/js/logout.min.js"></script>
	<!--[if lt IE 9]>
	 	 <script src="assets/js/ltIE9.min.js"></script>
	<![endif]-->
	

  </body>
  
</html>
