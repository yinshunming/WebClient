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
	<link rel="stylesheet" href="assets/css/common.min.css" />
	<link rel="stylesheet" href="assets/css/datatable.min.css" />
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
				          	<th><!-- Detail --></th>
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
				          	<th><!-- Detail --></th>
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
	<script src="assets/js/common.min.js"></script>
	<script src="assets/js/historyBugs.min.js"></script>
	<!--[if lt IE 9]>
	 	 <script src="assets/js/ltIE9.min.js"></script>
	<![endif]-->

	

 	 
  </body>

</html>
