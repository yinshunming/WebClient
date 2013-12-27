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
	
	$(document).ready(function(){
		$("#addBugJSPNav").addClass("active");
		var addForm = $("#addForm");
		var addFormButton = $("#addFormSb");
		addFormButton.click(function() {
			addFormButton.button('loading');
			$.ajax({
				type: addForm.attr('method'),
				url: addForm.attr('action'),
				data: addForm.serialize(),
				
				success: function (data, textStatus) {	
					var dataObj = data;
					if (dataObj != null) {
						   $("#bugInfoDiv").css("display","block");
						   $("#component").val(dataObj.component);
						   $("#bugId").val(dataObj.bugId);
						   $("#title").val(dataObj.title);
						   $("#project").val(dataObj.project);
						   $("#type").val(dataObj.type);
						   $("#status").val(dataObj.status);
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
					
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					addFormButton.button('reset');
				}
			});
		});
		
		var buginfoForm  = $("#bugInfoForm");
		var buginfoFormButton = $("#bugInfoFormSb");
		buginfoFormButton.click(function(){
			buginfoFormButton.button('loading');
			$.ajax({
				type: buginfoForm.attr('method'),
				url: buginfoForm.attr('action'),
				data: buginfoForm.serialize(),
				success: function (data) {
					var dataObj = data;
					alert(dataObj);
					window.location.reload();
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					buginfoFormButton.button('reset');
				}
			});		
		});
	});
	</script>
	
  </head>
 	
  <body>

		
  		<%@ include file="navigation.jsp" %>
			
 			<div class="container" style="padding-top:70px" >
 				<div class="row">
	 				<div id ="addFormDiv" class="col-lg-4" >
	 					<h4>Please enter your bugId(such as:0405135)</h4>
				    	<form id="addForm" name="addForm" action="/BugTrackingSystem/api/bugs" method="get" class="well form-horizontal">
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-2">BugId</label> 
					  		   	<div class="col-lg-10">
					  		    <input class="form-control" type="text" name="bugId" placeholder="BugID"> 
					  		    </div>
				  		    </div>
				  		    
				  		    <div class="form-group">
						  		<div class="col-lg-offset-2 col-lg-10">
	
					  		    <button class="btn btn-default" type="button" id="addFormSb" name="addFormSb" data-loading-text="Loading...">Add</button>
					  		    </div>
				  		    </div>
				  		</form>
				  		
	  				</div>

  
			  		<div id="bugInfoDiv" style="display:none" class="col-lg-8">
			  		
			  			<h4>Please verify the info of this bug and input its' component info:</h4>
			  			<form id="bugInfoForm" name="bugInfoForm" action="/BugTrackingSystem/api/bugs" method="post" class="well form-horizontal">
				  		    <fieldset>
				  		    
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-2" for="component">Component</label>
					  		    <div class="col-lg-8">
					  		    	<input class="form-control" id="component" name="component" type="text" value=""/> 
					  		    </div>
					  		</div>
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="bugId">BugId </label>
					  			 <div class="col-lg-8">
					  			 <input class="form-control uneditable-input" readonly="true" id="bugId" name="bugId" type="text" value=""/>
									
					  			</div>
					  		</div>
					  			
					  			
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="title">Title </label>
					  			
					  			<div class="col-lg-8">
					  			<input class="form-control" id="title" readonly="true" name="title" type="text" value=""/>
					  			</div>
					  		</div>
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="project">Project </label>
					  			<div class="col-lg-8">
					  			<input class="form-control" id="project" readonly="true" name="project" type="text" value=""/>
					  			</div>
					  		</div>
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="type">Type </label>
					  			<div class="col-lg-8">
					  			<input class="form-control" id="type" readonly="true" name="type" type="text" value=""/>
					  			</div>
					  		</div>
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="status">Status </label>
					  			
					  			<div class="col-lg-8">
					  			<input class="form-control" id="status" readonly="true" name="status" type="text" value=""/><br>
					  			</div>
					  		</div>
					  		
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="description">Description</label>
					  			
					  			<div class="col-lg-8">
					  			<input class="form-control" id="description" readonly="true" name="description" type="text" value=""/>
					  			</div>
					  		</div>
					  		
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="owner">Owner</label>
					  			<div class="col-lg-8">
					  			<input class="form-control" id="owner" readonly="true" name="owner" type="text" value=""/>
					  			</div>
					  		</div>
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="submitter">Submitter</label>
					  			
					  			<div class="col-lg-8">
					  			<input class="form-control" id="submitter" readonly="true" name="submitter" type="text" value=""/>
					  			</div>
					  		</div>
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="submitData">SumitterData</label>
					  			<div class="col-lg-8">
					  			<input class="form-control" id="submitData"  readonly="true" name="submitData" type="text" value=""/>
					  			</div>
					  		</div>
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="severity">Severity</label>
					  			<div class="col-lg-8">
					  			<input class="form-control" id="severity" readonly="true" name="severity" type="text" value=""/>
					  			</div>
					  		</div>
					  		
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="tags">Tags </label>
					  			<div class="col-lg-8">
					  			<input class="form-control" id="tags" readonly="true" name="tags" type="text" value=""/>
					  			</div>
					  		</div>
					  		
					  		<div class="form-group">
					  			<label class="control-label col-lg-2" for="regression">Rgression </label>
					  			<div class="col-lg-8">
					  			
					  			<input class="form-control" id="regression" class="btn btn-default"  readonly="true" name="regression" type="text" value=""/>
					  			</div>
					  		</div>
					  			
					  		<div class="form-group">
					  			<div class="col-lg-offset-2 col-lg-10">
					  			<button class="btn btn-default" type="button" id="bugInfoFormSb" name="bugInfoFormSb" data-loading-text="Loading...">OK</button>
					  			</div>
					  		</div>
					  		
				  			</fieldset>
						</form>
			        </div>
		        </div>
				</div>

    
  </body>
 	 

	
</html>
