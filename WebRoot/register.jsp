<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register Page</title>
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>

	<script src="jquery/jquery-1.10.2.min.js"></script>

	<script src="jquery/jquery.validate.min.js" ></script>
	<script src="jquery/additional-methods.min.js" ></script>
	
	<script src="bootstrap/js/bootstrap.min.js" ></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
		$("#registerJSPNav").addClass("active");
		var registerBtn = $("#registerFormSb");
		
		var registerForm = $("#registerForm");
		
		registerForm.validate({
			rules: {
				username : {
					 required: true
				}, 
				email : {
					required: true,
					email: true
				},
				password: {
					minlength: 4,
					required: true
				},
				password2: {
			
				},
				oneBugFullName: {
					required: true,
				}
			}, 
			 submitHandler: function(form) {
				 registerBtn.button('loading');
					$.ajax({
						type: registerForm.attr('method'),
						url: registerForm.attr('action'),
						data: registerForm.serialize(),
						success: function (data) {
							var dataObj = data;
							alert(dataObj);
							window.location.reload();
						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							
						},
						
						complete: function (XMLHttpRequest, textStatus) {
							registerBtn.button('reset');
						}
					});	
			}
		});
		
	});
	</script>
</head>
<body>
	 <%@ include file="navigation.jsp" %>
	 <div class="container" style="padding-top:70px" >
	 		<div class="row">
	 				<div id ="registerFormDiv" class="col-lg-4 form-horizontal" >
	 					<h4>Please fill in your account info</h4>
				    	<form id="registerForm" name="registerForm" action="/BugTrackingSystem/nonVerify/user" method="post" class="well form-horizontal">
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-3">Username</label> 
					  		   	<div class="col-lg-9">
					  		    <input class="form-control" type="text" name="username" placeholder="Username" > 
					  		    </div>
				  		    </div>
				  		    
				  		    
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-3">Password</label> 
					  		   	<div class="col-lg-9">
					  		    <input id="password" class="form-control" type="password" name="password" placeholder="Password"> 
					  		    </div>
				  		    </div>
				  		    
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-3">Password Again</label> 
					  		   	<div class="col-lg-9">
					  		    <input class="form-control" type="password" name="password2" equalto="#password" placeholder="ConfirmPassword"> 
					  		    </div>
				  		    </div>
				  		    
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-3">OneBug FullName</label> 
					  		   	<div class="col-lg-9">
					  		    <input class="form-control" type="text" name="oneBugFullName" placeholder="OneBugFullName"> 
					  		    </div>
				  		    </div>
				  		    
				  		     <div class="form-group">
					  		    <label class="control-label col-lg-3">Email</label> 
					  		   	<div class="col-lg-9">
					  		    <input class="form-control" type="text" name="email" placeholder="Email"> 
					  		    </div>
				  		    </div>
				  		    
				  		    <div class="form-group">
						  		<div class="col-lg-offset-3 col-lg-9">
						  
					  		    <button class="btn btn-default" type="submit" id="registerFormSb" name="registerFormSb" data-loading-text="Loading...">Add</button>
					  		    </div>
				  		    </div>
				  		</form>
				  		
	  				</div>
	  		</div>
	 </div>
</body>
</html>