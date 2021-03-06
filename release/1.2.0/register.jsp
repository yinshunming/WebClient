<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register Page</title>
	<link rel="stylesheet" href="assets/css/common.min.css" />
	
</head>
<body>
	 <%@ include file="navigation.jsp" %>
	 <div class="container" style="padding-top:70px" >
	 		<div class="row">			
	 				<div id ="registerFormDiv" class="col-lg-5 form-horizontal" >
	 					<h4>Please fill in your account info</h4>
				    	<form id="registerForm" name="registerForm" action="/BugTrackingSystem/nonVerify/user" method="post" class="well form-horizontal">
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-3">Username</label> 
					  		   	<div class="col-lg-9">
					  		    <input class="form-control col-lg-9" type="text" name="username" placeholder="Username" style="width:80%" > 
					  		    </div>
				  		    </div>
				  		    
				  		    
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-3">Password</label> 
					  		   	<div class="col-lg-9">
					  		    <input id="password" class="form-control col-lg-9 " type="password" name="password" placeholder="Password" style="width:80%"> 
					  		    </div>
				  		    </div>
				  		    
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-3">Password Again</label> 
					  		   	<div class="col-lg-9">
					  		    <input class="form-control col-lg-9 " type="password" name="password2"   placeholder="ConfirmPassword" style="width:80%"> 
					  		    </div>
				  		    </div>
				  		    
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-3">OneBug FullName</label> 
					  		   	<div class="col-lg-9">
					  		    <input class="form-control col-lg-9" type="text" name="oneBugFullName" placeholder="OneBugFullName" style="width:80%"> 
					  		    </div>
				  		    </div>
				  		    
				  		     <div class="form-group">
					  		    <label class="control-label col-lg-3">Email</label> 
					  		   	<div class="col-lg-9">
					  		    <input class="form-control col-lg-9" type="text" name="email" placeholder="Email" style="width:80%"> 
					  		    </div>
				  		    </div>
				  		    
				  		    <div class="form-group">
						  		<div class="col-lg-offset-3 col-lg-9">
						  
					  		    <button class="col-lg-offset-7 btn btn-primary" type="submit" id="registerFormSb" name="registerFormSb" data-loading-text="Loading...">Add</button>
					  		    
								</div>
				  		    </div>
				  		</form>
				  		
	  				</div>
	  		
			 </div>
	 </div>
 	<script src="assets/js/common.min.js"></script>
 	<script src="assets/js/register.min.js"></script>
 	<!--[if lt IE 9]>
	 	 <script src="assets/js/ltIE9.min.js"></script>
	<![endif]-->



 	 
</body>
</html>