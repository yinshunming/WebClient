<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta http-equiv="cache-control" content="max-age=0" >
<meta http-equiv="cache-control" content="no-cache" >
<meta http-equiv="expires" content="0" >
<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" >
<meta http-equiv="pragma" content="no-cache" > -->
<title>Register Page</title>

	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="bootstrap/css/bootstrap-responsive.min.css"/>
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
	<script src="jquery/jquery.validate.min.js" ></script>
	<script src="jquery/additional-methods.min.js" ></script>
	
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	  <script src="js/respond.min.js"></script>
	<![endif]-->
	<script src="alertify/js/alertify.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		
		$("#registerJSPNav").addClass("active");
		var registerBtn = $("#registerFormSb");
		
		var registerForm = $("#registerForm");
		
		registerForm.validate({
			ignore: [],
			rules: {
				username : {
					 required: true
				}, 
				email : {
					required: true,
					email: true
				},
				password: {
					required: true,
					minlength: 4
				},
				password2: {
					required: true,
					equalTo: "#password"
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
						cache : false,
						success: function (data) {
							var dataObj = data;
							alertify.log(dataObj,"success");
							//alert(dataObj);
							window.location.reload();
						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							
						},
						
						complete: function (XMLHttpRequest, textStatus) {
							registerBtn.button('reset');
						}
					});	
			},
			highlight: function(element) {
				$(element).closest('.form-group').removeClass('has-success').addClass('has-error');
			},
			success: function(element) {
				element
				.text('OK!').addClass('valid')
				.closest('.form-group').removeClass('has-error').addClass('has-success');
			}
		});
		
		}); 
	</script>
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
</body>
 <!-- jQuery 1.7.2 or higher -->
  <!--[if lte IE 6]>
  <script type="text/javascript" src="js/bootstrap-ie.js"></script>
  <![endif]-->
</html>