
<script type="text/javascript">	
	 $(document).ready(function(){
		var addForm = $("#addForm");
		var addFormButton = $("#addFormSb");
		addFormButton.click(function() {
		
			$('#myModal').modal('show');
			
			addFormButton.button('loading');
			$("#myModalLabel").html("Please wait for bug info loading");
			$("#bugInfoFormSb").prop('disabled', true);
			$.ajax({
				type: addForm.attr('method'),
				url: addForm.attr('action'),
				data: addForm.serialize(),
				
				success: function (data, textStatus) {	
					var dataObj = data;
					//alert("OK");
					$("#myModalLabel").html("Please verify the info of this bug and input its' component info:");
					$("#bugInfoFormSb").prop('disabled', false);
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
					alert("error");
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					//alert("complete");
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
					//alert(dataObj);
					//$('#myModal').modal('show')
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
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">Bug Tracking System</a>
		</div>
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li id="mainFrameJSPNav"><a href="mainFrame.jsp">DashBoard</a></li>
				<!-- <li id="addBugJSPNav"><a href="addBug.jsp">Add Bug</a></li> -->
				<li id="historyBugsJSPNav"><a href="historyBugs.jsp">Histroy
						Bugs</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li id="logout"><a href="logout.jsp">Logout</a></li>
				<li id="registerJSPNav"><a href="register.jsp">Register</a></li>
			</ul>
			
			<form id="addForm" name="addForm" action="/BugTrackingSystem/api/bugs" method="get" class="navbar-form navbar-left" role="Search" style="margin-left:50px">
			  <div class="form-group">
				<input type="text" class="form-control" name="bugId" placeholder="BugID:0405135">				
			  </div>
			  
			  <button class="btn btn-default" type="button" id="addFormSb" name="addFormSb" data-toggle="modal"  data-loading-text="Loading...">Add</button>
			  <!--data-target="#myModal"-->
			</form>
			
		</div>
	</div>
</nav>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Please verify the info of this bug and input its' component info:</h4>
      </div>
      <div class="modal-body " style="margin-bottom:0px,padding-bottom:0px">
        <form id="bugInfoForm" name="bugInfoForm" action="/BugTrackingSystem/api/bugs" method="post" class="well form-horizontal" style="margin-bottom:0px,padding-bottom:0px">
				  		    <fieldset>
				  		    
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-2" for="component">Component</label>
					  		    <div class="col-lg-8">
					  		    	<!-- 
					  		    	<input class="form-control" id="component" name="component" type="text" value=""/> 
					  		    	-->
					  		    	<select id="component" name="component" class="form-control">
					  		    		<option value="DDC-ADIdentity Service">DDC-ADIdentity Service</option>
					  		    		<option value="DDC-Broker Service">DDC-Broker Service</option>
					  		    		<option value="DDC-Configuration Service">DDC-Configuration Service</option>
					  		    		<option value="DDC-Configuration Logging Service">DDC-Configuration Logging Service</option>
					  		    		<option value="DDC-Delegated Admin Service">DDC-Delegated Admin Service</option>
					  		    		<option value="DDC-Event Test Service">DDC-Event Test Service</option>
					  		    		<option value="DDC-Host Service">DDC-Host Service</option>
					  		    		<option value="DDC-Machine Creation Service">DDC-Machine Creation Service</option>
					  		    		<option value="DDC-Scout(Taas)">DDC-Scout(Taas)</option>
					  		    		<option value="VDA-Broker Agent(VDA)">VDA-Broker Agent(VDA)</option>
					  		    		<option value="VDA-Machine Identity Service Agent">VDA-Machine Identity Service Agent</option>
					  		    		<option value="HDX-ICA HostCore">HDX-ICA HostCore</option>
					  		    		<option value="HDX-ICA Graphics">HDX-ICA Graphics</option>
					  		    		<option value="HDX-ICA Integration">HDX-ICA Integration</option>
					  		    		<option value="HDX-ICA IO">HDX-ICA IO</option>
					  		    		<option value="HDX-ICA Multimedia">HDX-ICA Multimedia</option>
					  		    		<option value="HDX-ICA Printing">HDX-ICA Printing</option>
					  		    		<option value="HDX-ICA Packaging">HDX-ICA Packaging</option>
					  		    		<option value="Director">Director</option>
					  		    		<option value="Group Policy">Group Policy</option>
					  		    		<option value="Studio">Studio</option>
					  		    		<option value="Licensing">Licensing</option>
					  		    		<option value="Monitoring Service">Monitoring Service</option>
					  		    		<option value="StoreFront">StoreFront</option>
					  		    		<option value="MetaInstaller">MetaInstaller</option>
					  		    		<option value="AppV">AppV</option>
					  		    		<option value="PVD">PVD</option>
					  		    		<option value="PVS">PVS</option>
					  		    	</select>
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
					  			<input class="form-control" id="status" readonly="true" name="status" type="text" value=""/>
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
				  			</fieldset>
						</form>
      </div>
	  <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		<button type="button" class="btn btn-primary" id="bugInfoFormSb" data-loading-text="Loading...">OK</button>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->