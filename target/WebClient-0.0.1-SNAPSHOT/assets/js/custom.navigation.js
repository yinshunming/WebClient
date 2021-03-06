	$.validator.addMethod(
        "regex",
        function(value, element, regexp) {
            var re = new RegExp(regexp);
            return this.optional(element) || re.test(value);
        },
        "Please check your input."
	);
		
	function feedBackClick(){
		alert("click");
		var loginForm = $("<form></form>");
		loginForm.attr('action',"http://localhost:8050/feedback/");
		loginForm.attr('method','post');
		
		var csrfInput =  $("<input type='hidden' />");
		csrfInput.attr('name',"csrfmiddlewaretoken");
		csrfInput.attr('value',"0hZt8uSSGUd1jD6Ma9Qf1vom9O2Ki2bF");
		
		var userNameInput =  $("<input type='hidden' />");
		userNameInput.attr('name',"username");
		userNameInput.attr('value',"gsnj_dev");
		
		var passwordInput =  $("<input type='hidden' />");
		passwordInput.attr('name',"password");
		passwordInput.attr('value',"citrix");
		
		var makeSureInput =  $("<input type='hidden' />");
		makeSureInput.attr('name',"this_is_the_login_form");
		makeSureInput.attr('value',"1");
		
		var nextInput =  $("<input type='hidden' />");
		nextInput.attr('name',"next");
		nextInput.attr('value',"http://localhost:8050/feedback/");
		
		loginForm.append(csrfInput);
		loginForm.append(userNameInput);
		loginForm.append(passwordInput);
		loginForm.append(nextInput);
		
		$.ajax({
			method : loginForm.attr('method'),
			url : loginForm.attr('action'),
			data : loginForm.serialize(),
			cache : false,
			success : function(data) {
			    alertify.log("login ok","success");
			    
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
			},

			complete : function(XMLHttpRequest, textStatus) {
			}
		});
	}
	
	 $(document).ready(function(){
	    // Invoke the placeholder plugin
		$('input, textarea').placeholder();	 
		
		var addForm = $("#addForm");
		var addFormButton = $("#addFormSb");
		
		function  addButtonClick() {
		    if($("#addBugInput").val()==""){
			return;
			}
			$("#component").val("");
				   $("#bugId").val("");
				   $("#title").val("");
				   $("#project").val("");
				   $("#type").val("");
				   $("#status").val("");
				   $("#description").val("");
				   $("#owner").val("");
				   $("#submitter").val("");
				   $("#submitData").val("");
				   $("#severity").val("");
				   $("#tags").val("");
				   $("#regression").val("");
			$('#myModal').modal('show');
			
			addFormButton.button('loading');
			$("#myModalLabel").html("Please wait for bug info loading");
			$("#bugInfoFormSb").prop('disabled', true);
			$.ajax({
				type: addForm.attr('method'),
				url: addForm.attr('action'),
				data: addForm.serialize().replace(/^bugId=(bug|BUG)?/,"bugId="),
				cache : false,
				success: function (data, textStatus) {	
					var dataObj = data;
					alertify.log("Get bug info success!","success");
					//alert("OK");
					$("#myModalLabel").html("Please verify the info of this bug and input its' component info:");
					$("#bugInfoFormSb").prop('disabled', false);
					if (dataObj != null) {
						   $("#bugInfoDiv").css("display","block");
						   if(dataObj.component){
						  	 $("#component").val(dataObj.component);
						   }
						   
						   $("#bugId").val(dataObj.bugId);
						   $("#title").val(dataObj.title);
						   $("#project").val(dataObj.project);
						   $("#type").val(dataObj.type);
						   $("#status").val(dataObj.status);
						   dataObj.description=dataObj.description.replace(/<br ?\/?>/g, "\n");
						   $("#description").val(dataObj.description);
						   $("#owner").val(dataObj.owner);
						   $("#submitter").val(dataObj.submitter);
						   $("#submitData").val(dataObj.submitData);
						   $("#severity").val(dataObj.severity);
						   $("#tags").val(dataObj.tags);
						   $("#regression").val(dataObj.regression);
						} 
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alertify.log("Get bug info failed!","error");
					//alert("error");
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					//alert("complete");
					addFormButton.button('reset');
					$("#addBugInput").val("");
				}
			});
		}
		
		//addFormButton.click(addButtonClick);
		
		addForm.validate({
			rules: {
				bugId : {
					 regex: '^(bug|BUG)?[0-9]{6,7}$',
					 required :true
				}
			} , 
			submitHandler: function(form) {
			    
				 addButtonClick();
			}
			,
			highlight: function(element) {
				$(element).closest('.form-group').removeClass('has-success').addClass('has-error');
			},
			success: function(element) {
				element
				.addClass('valid') 
				.addClass('background_none')
				.closest('.form-group').removeClass('has-error').addClass('has-success');
			} 
		});
		
		var buginfoForm  = $("#bugInfoForm");
		var buginfoFormButton = $("#bugInfoFormSb");
		buginfoFormButton.click(function(){
			buginfoFormButton.button('loading');
			$.ajax({
				type: buginfoForm.attr('method'),
				url: buginfoForm.attr('action'),
				data: buginfoForm.serialize(),
				cache : false,
				success: function (data) {
					var dataObj = data;
					//alert(dataObj);
					//$('#myModal').modal('show')
					
					window.location.reload(true);
				  
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					buginfoFormButton.button('reset');
				   $("#component").val("");
				   $("#bugId").val("");
				   $("#title").val("");
				   $("#project").val("");
				   $("#type").val("");
				   $("#status").val("");
				   $("#description").val("");
				   $("#owner").val("");
				   $("#submitter").val("");
				   $("#submitData").val("");
				   $("#severity").val("");
				   $("#tags").val("");
				   $("#regression").val("");
				}
			});		
		});  
		
		
		//$(document).delegate("#feedbackNav",'click',feedBackClick);
		
	});