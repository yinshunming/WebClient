<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>BugDetail</title>
    
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
	<!--[if lte IE 6]>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-ie6.css">
	<link rel="stylesheet" type="text/css" href="bootstrap/css/ie.css">
	<![endif]-->
	<script src="jquery/jquery-1.10.2.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js" ></script>
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	  <script src="js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
	  function getUrlParam(name) {
          var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
          var r = window.location.search.substr(1).match(reg);  //匹配目标参数
          if (r != null) return unescape(r[2]); return null; //返回参数值
      }
		$(document).ready(function(){
			//$("#mainFrameJSPNav").addClass("active");
			var id = getUrlParam("id");	
			$.ajax({
				type: "get",
				url: "/BugTrackingSystem/api/bug?id=" + id,
				data: "",
				success: function (data) {
					var dataObj = data;
					if (dataObj != null) {
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
						
				}
			});
		});
	</script>
  </head>
  
  <body>
  	<%@ include file="navigation.jsp" %>
    <div class="container" style="padding-top:70px" >
    	<div id="bugInfoDiv"  class="col-lg-8">
			  		
			  			<h4>Detail buginfo is below:</h4>
			  			<form id="bugInfoForm" name="bugInfoForm" action="/BugTrackingSystem/bugs" method="post" class="well form-horizontal">
				  		    <fieldset>
				  		    
				  		    <div class="form-group">
					  		    <label class="control-label col-lg-2" for="component">Component</label>
					  		    <div class="col-lg-8">
					  		    	<input class="form-control" readonly="true" id="component" name="component" type="text" value=""/> 
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
					  		<!--  
					  		<div class="form-group">
					  			<div class="col-lg-offset-2 col-lg-10">
					  			<input class="btn btn-default" type="submit" value="ok" />
					  			</div>
					  		</div>
					  		-->
				  			</fieldset>
						</form>
			        </div>
    </div>
  </body>
  <!-- jQuery 1.7.2 or higher -->
  <!--[if lte IE 6]>
  <script type="text/javascript" src="js/bootstrap-ie.js"></script>
  <![endif]-->
</html>
