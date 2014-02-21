<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>History Bugs</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css"/>
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
    <%@ include file="navigation.jsp" %>
    
   
    
    <div class="container" style="padding-top:70px">
     <div class="row" >
	    	<div class="col-lg-12">
	    	
	    	<div class="col-lg-4">
	    		<h3>OwnerBugsList</h3>
	    	</div>
	    			    	
		    	<div id="ownerBugsDiv">
		    			<br/>
	    				<table id="ownerBugsTable" class="table display" cellpadding="0"
						cellspacing="0" border="0">
				        <thead>
				          <tr>
				          	<th>Detail</th>
				            <th>BugId</th>
				            <th>Title</th>
				            <th>Project</th>
				            <th>Owner</th>
				            <th>Status</th>
				            <th>Managed</th>
				            <th>Operation</th>
				          </tr>
				        </thead>
				        <tbody id="ownerBugsTableBody">
				          	
				        </tbody>
				      </table>
	    
		    	</div>
	    	</div>
	    	</div>
    </div>
     <div class="container"  >
    	   <div class="row" >
	    	<div class="col-lg-12">   	
	    	<div class="col-lg-4">
	    		<h3>HistoryManagedBugsList</h3>
	    	</div>	    	
			
		    	<div id="historyBugsDiv">
		    			<br/>
	    				<table id="historyBugsTable" class="table display" cellpadding="0"
						cellspacing="0" border="0">
				        <thead>
				          <tr>
				          	<th>Detail</th>
				            <th>BugId</th>
				            <th>Title</th>
				            <th>Project</th>
				            <th>Owner</th>
				            <th>Status</th>
				            <th>Managed</th>
				            <th>Operation</th>
				          </tr>
				        </thead>
				        <tbody id="historyBugsTableBody">
				          
				        </tbody>
				      </table>
	    
		    	</div>
	    	</div>
    	</div>
    </div>
    <script src="assets/jquery/js/jquery-1.10.2.min.js"></script>
   	<script src="assets/jquery/js/jquery.validate.min.js" ></script>
	<script src="assets/jquery/js/jquery.placeholder.js" ></script>
	<script src="assets/bootstrap/js/bootstrap.min.js" ></script>
	<script src="assets/datatables/js/jquery.dataTables.js"></script>
	<script src="assets/datatables/js/jquery.dataTables.rowGrouping.js"></script>
	<script src="assets/datatables/js/jquery.dataTables.colReorderWithResize.js"></script>
	<script src="assets/alertify/js/alertify.min.js"></script>
	<script src="assets/custom/js/navigation.js"></script>
	<script src="assets/custom/js/historyBugs.js"></script>
	<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  	<script src="assets/custom/js/html5.js"></script>
	  	<script src="assets/custom/js/respond.min.js"></script>
	<![endif]-->
  	<!--[if lte IE 6]>
  		<script type="text/javascript" src="assets/custom/js/bootstrap-ie.js"></script>
  	<![endif]-->
  </body>

</html>
