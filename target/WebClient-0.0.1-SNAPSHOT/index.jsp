<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link type="text/css" rel="stylesheet" href="css/visualize.jQuery.css"/>
	<link type="text/css" rel="stylesheet" href="css/demopage.css"/>
	
	<script type="text/javascript" src="jquery/jquery.min.js"></script>
	
	<script type="text/javascript" src="jquery/visualize.jQuery.js"> </script>
	
	<script type="text/javascript"> 
	  $(function(){
		  $('table').visualize({type: 'pie', pieMargin: 10, title: '2009 Total Sales by Individual' , parseDirection:'y'});	
			$('table').visualize({type: 'line'});
			$('table').visualize({type: 'area'});
			$('table').visualize();
		  
	  });	  
	 </script>
  </head>
  
  <body>
   <table >
	<caption>2009 Employee Sales by Department</caption>
	<thead>
		<tr>
			<td></td>
			<th>food</th>
			<th>auto</th>
			<th>household</th>
			<th>furniture</th>
			<th>kitchen</th>
			<th>bath</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>Mary</th>
			<td>190</td>
			<td>0</td>
			<td>40</td>
			<td>120</td>
			<td>30</td>
			<td>-70</td>
		</tr>
		<tr>
			<th>Tom</th>
			<td>-3</td>
			<td>40</td>
			<td>30</td>
			<td>45</td>
			<td>35</td>
			<td>49</td>
		</tr>
		<tr>
			<th>Brad</th>
			<td>10</td>
			<td>180</td>
			<td>10</td>
			<td>85</td>
			<td>25</td>
			<td>79</td>
		</tr>
		<tr>
			<th>Kate</th>
			<td>40</td>
			<td>80</td>
			<td>90</td>
			<td>25</td>
			<td>15</td>
			<td>119</td>
		</tr>		
	</tbody>
</table>
</body>
</html>
