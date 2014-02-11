<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>My JSP 'get.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="jquery/jquery.min.js"></script>
	
	<script type="text/javascript">
	
	$.getJSON("/BugTrackingSystem/student",function(result){
		$.each(result, function(i, field){
		      $("div").append(field + "<br>");
		 });
	});
	
	//首先要引入jquery的js包
	 $.get("http://onebug.citrite.net/tmtrack/tmtrack.dll",function(result){
         
			alert(result);
         });
	
	</script>

	
  </head>
  
  <body>
    This is my JSP page. <br>
    <div id="result">
    </div>
  </body>
</html>
