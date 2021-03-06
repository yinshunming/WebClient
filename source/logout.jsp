<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Log Out</title>
<!-- @if NODE_ENV == 'DEVELOPMENT' -->
	<link rel="stylesheet" href="assets/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="assets/css/bootstrap.validation.css"/>
	<link rel="stylesheet" href="assets/css/custom.placeholder.css" />
	<link rel="stylesheet" href="assets/css/alertify.core.css" />
	<link rel="stylesheet" href="assets/css/alertify.default.css" />
<!-- @endif -->
<!-- @if NODE_ENV == 'PRODUCTION' -->
	<link rel="stylesheet" href="assets/css/common.min.css" />
<!-- @endif -->
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
<!-- @if NODE_ENV == 'DEVELOPMENT' -->
	<script src="assets/js/jquery-1.10.2.min.js"></script>
	<script src="assets/js/jquery.validate.min.js" ></script>
	<script src="assets/js/jquery.placeholder.js" ></script>
	<script src="assets/js/bootstrap.min.js" ></script>
	<script src="assets/js/alertify.min.js"></script>
	<script src="assets/js/custom.navigation.js"></script>
	<script src="assets/js/custom.logout.js"></script>
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  	<script src="assets/js/custom.html5.js"></script>
	 	<script src="assets/js/custom.respond.min.js"></script>
	<![endif]-->
<!-- @endif -->
<!-- @if NODE_ENV == 'PRODUCTION' -->
	 <script src="assets/js/common.min.js"></script>
	 <script src="assets/js/logout.min.js"></script>
	<!--[if lt IE 9]>
	 	 <script src="assets/js/ltIE9.min.js"></script>
	<![endif]-->
	

<!-- @endif -->

  </body>
  
</html>
