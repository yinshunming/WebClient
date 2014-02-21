<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>

<title>Main Frame</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/bootstrap/css/validation.css"/>
<link rel="stylesheet" href="assets/datatables/css/demo_page.css" />
<link rel="stylesheet" href="assets/datatables/css/demo_table_jui.css" />
<link rel="stylesheet" href="assets/jquery/css/jquery-ui-1.8.4.custom.css" />
<link rel="stylesheet" href="assets/custom/css/placeholder.css" />
<link rel="stylesheet" href="assets/alertify/css/alertify.core.css" />
<link rel="stylesheet" href="assets/alertify/css/alertify.default.css" />
<!--[if lte IE 6]>
<link rel="stylesheet" type="text/css" href="assets/bootstrap/css/bootstrap-ie6.css">
<link rel="stylesheet" type="text/css" href="assets/bootstrap/css/ie.css">
<![endif]-->
</head>

<body>
	<%@ include file="navigation.jsp"%>

	<div class="container" style="padding-top:70px">
		<div class="row">
			<div id="ownerBugDiv" class="col-lg-12">


				<div class="col-lg-4">
					<h3>OwnerBugList</h3>
				</div>

				<div>
					<br />
					<table id="ownerBugTable" class="table display" cellpadding="0"
						cellspacing="0" border="0">

						<thead>
							<tr>
								<th>Detail</th>
								<th>BugId</th>
								<th>Title</th>
								<th>Project</th>
								<th>Component</th>
								<th>Owner</th>
								<th>Status</th>
								<th>Operation</th>
							</tr>
						</thead>
						<tbody id="ownerBugTableBody">

						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>


	<div class="container">
		<div class="row">
			<div id="managedBugDiv" class="col-lg-12">
				<div class="col-lg-4">
					<h3>ManagedBugList</h3>
				</div>
				<div>
					<br />
					<table id="managedBugTable"  class="table display" cellpadding="0"
						cellspacing="0" border="0">
						<thead>
							<tr>
								<th>Detail</th>
								<th>BugId</th>
								<th>Title</th>
								<th>Project</th>
								<th>Component</th>
								<th>Owner</th>
								<th>Status</th>
								<th>Operation</th>
							</tr>
						</thead>
						<tbody id="managedBugTableBody">

						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="col-lg-4">
					<h3>ChangedBugList</h3>
				</div>


				<div id="differentDiv">

					<form id="differentForm" name="differentForm"
								action="/BugTrackingSystem/api/bugs?method=put" method="post">
					</form>
						<br />
						<table id="differentBugTable"  class="table display" cellpadding="0"
						cellspacing="0" border="0">

							<thead>
								<tr>
									<th>Detail</th>
									<th>BugId</th>
									<th>Title</th>
									<th>Project</th>
									<th>Component</th>
									<th>NewOwner</th>
									<th>Status</th>
									<th>Operation</th>
								</tr>
							</thead>							
									<tbody id="differentBugTableBody">		
									</tbody>												
						</table>
						<div id='modifyBtnDiv'></div>
					


					<!--  
	    			<button id="refreshBtn" name="refreshBtn" type="button" value="refresh" class="btn btn-default" data-loading-text="Loading">refresh</button>  
		    		-->
				</div>
			</div>
		</div>
	</div>


  <script src="assets/custom/js/mainFrame.min.js"></script>

</body>
</html>
