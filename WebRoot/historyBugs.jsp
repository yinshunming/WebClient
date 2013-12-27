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
    
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
	<script src="jquery/jquery-1.10.2.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js" ></script>
   	<script type="text/javascript">
   	function deleteManagedBugs(managedBugId, id) {
   		var deleteBtn = $("#deleteManagedBtn_" + managedBugId);
   		deleteBtn.button('loading');
   		$.ajax({
			type: "delete",
			url: "/BugTrackingSystem/api/managed?managedBugId=" + managedBugId + "&id=" + id,
			data: "",
			success: function (data) {
				alert(data);
				window.location.reload();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					deleteBtn.button('reset');
				}
		});
	}
   	
   	function operateManagedBugs(managedBugId, id, operate) {
   		var operateManagedBtn = $("#operateManagedBtn_" + managedBugId);
   		operateManagedBtn.button('loading');
   		
   		$.ajax({
			type: "post",
			url: "/BugTrackingSystem/api/managed?method=put&operate=" +  operate + "&managedBugId=" + managedBugId + "&id=" + id,
			data: "",
			success: function (data) {
				alert(data);
				window.location.reload();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					operateManagedBtn.button('reset');
				}
		});
   	} 
   	
	
	function searchTable(inputVal, tableId)
	{
		var table = $('#' + tableId);
		table.find('tr').each(function(index, row)
		{
			var allCells = $(row).find('td');
			if(allCells.length > 0)
			{
				var found = false;
				allCells.each(function(index, td)
				{
					var regExp = new RegExp(inputVal, 'i');
					if(regExp.test($(td).text()))
					{
						found = true;
						return false;
					}
				});
				if(found == true)$(row).show();else $(row).hide();
			}
		});
	}
	
	function deleteOwnerBugs(id) {
		var deleteBtn = $("#deleteOwnerBtn_" + id);
		deleteBtn.button('loading');
		$.ajax({
			type: "delete",
			url: "/BugTrackingSystem/api/owner?id=" + id,
			data: "",
			
			success: function (data) {
				alert(data);
				window.location.reload();
			},
			
			error : function(XMLHttpRequest, textStatus, errorThrown) {
					
			},
				
			complete: function (XMLHttpRequest, textStatus) {
				deleteBtn.button('reset');
			}
		});
	}
	
	function operateOwnerBugs(id, operate) {
		var operateOwnerBtn = $("#operateOwnerBtn_" + id);
		operateOwnerBtn.button('loading');
		
		$.ajax({
			type: "post",
			url: "/BugTrackingSystem/api/owner?method=put&operate=" + operate + "&id=" + id,
			data: "",
			
			success: function (data) {
				alert(data);
				window.location.reload();
			},
			
			error : function(XMLHttpRequest, textStatus, errorThrown) {
					
			},
				
			complete: function (XMLHttpRequest, textStatus) {
				operateOwnerBtn.button('reset');
			}
		});
	}
	
	var ingoreCmd = "ingore";
	var restoreCmd = "restore";
	
	$(document).ready(function(){
		$("#historyBugsJSPNav").addClass("active");
		
		$('#search').keyup(function()
		{
			searchTable($(this).val(), "historyBugsTable");
		});
		
		$('#search2').keyup(function(){
			searchTable($(this).val(), "ownerBugsTable");
		});
		
		$.ajax({
			type: "get",
			url: "/BugTrackingSystem/api/managed",
			data: "",
			success: function (data) {
				var dataObj = data;
			
				$.each(dataObj, function(i,warppedBuginfo) {
					
					var buginfo = warppedBuginfo.buginfo;
					var operationBtn = "";
					
					if (warppedBuginfo.status == 0) {
						operationBtn = "<button id = 'operateManagedBtn_" +  warppedBuginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateManagedBugs('"   + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + ingoreCmd +"')>Ingore</button>";
					} else {
						operationBtn = "<button id = 'operateManagedBtn_" +  warppedBuginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateManagedBugs('"   + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" +  restoreCmd + "')>Restore</button>";
					}
					
					$("#historyBugsTableBody").append("<tr> <td><a href=bugDetail.jsp?id=" + buginfo.id + ">" + buginfo.bugId + "</a></td><td><a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId=" + buginfo.bugId + "&Template=view&TableId=1000'>" + buginfo.title + "</a></td><td>" 
							+ buginfo.project + "</td><td>" + buginfo.owner + "</td><td>" + buginfo.status + "</td>"  + "<td>" + warppedBuginfo.status + "</td><td>" 
							+ operationBtn + "<button class='btn btn-default' type='button' id='deleteManagedBtn_" + warppedBuginfo.managedBugId +  "' data-loading-text='Loading...' onclick= " + "javascript:deleteManagedBugs('" + warppedBuginfo.managedBugId + "','" + buginfo.id + "')>Delete</button>" + "</td>" + "</tr>");

				});
			}
		});
		
				
		$.ajax({
			type: "get",
			url: "/BugTrackingSystem/api/owner",
			data: "",
			success: function (data) {
				var dataObj = data;
			
				$.each(dataObj, function(i,buginfo) {
					
					if (buginfo.managedStatus == 0) {
						operationBtn = "<button id = 'operateOwnerBtn_" +  buginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateOwnerBugs('" + buginfo.id + "','" + ingoreCmd +"')>Ingore</button>";
					} else {
						operationBtn = "<button id = 'operateOwenerBtn_" +  buginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateOwnerBugs('" + buginfo.id + "','" + restoreCmd + "')>Restore</button>";
					} 
					
					$("#ownerBugsTableBody").append("<tr> <td><a href=bugDetail.jsp?id=" + buginfo.id + ">" + buginfo.bugId + "</a></td><td><a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId=" + buginfo.bugId + "&Template=view&TableId=1000'>" + buginfo.title + "</a></td><td>" 
							+ buginfo.project + "</td><td>" + buginfo.owner + "</td><td>" + buginfo.status + "</td>"  +  "<td>" + buginfo.managedStatus + "</td>" +"<td>" 
							+ operationBtn + "<button class='btn btn-default' type='button' id='deleteOwnerBtn_" + buginfo.id +  "' data-loading-text='Loading...' onclick= " + "javascript:deleteOwnerBugs('" + buginfo.id + "')>Delete</button>" + "</td>" + "</tr>");

				});
			}
		});
	});
	</script>

  </head>
  
  <body>
    <%@ include file="navigation.jsp" %>
    <div class="container" style="padding-top:70px" >
    	   <div class="row" >
	    	<div class="col-lg-10">
	    	
	    	<div class="col-lg-4">
	    		<h3>HistoryManagedBugsList</h3>
	    	</div>
	    	
	    	<div class="col-lg-8" style="padding-top:20px">		 
	 				<input id="search" type="text" class="input-medium search-query" placeholder="input search info" >
			</div>
			
		    	<div id="historyBugsDiv">
		    			<br/>
	    				<table id="historyBugsTable" class="table">
				        <thead>
				          <tr>
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
    
    <div class="container">
     <div class="row" >
	    	<div class="col-lg-10">
	    	
	    	<div class="col-lg-4">
	    		<h3>OwnerBugsList</h3>
	    	</div>
	    		
	    		<div class="col-lg-8" style="padding-top:20px">		 
	 					<input id="search2" type="text" class="input-medium search-query" placeholder="input search info" >
				</div>
		    	
		    	<div id="ownerBugsDiv">
		    			<br/>
	    				<table id="ownerBugsTable" class="table">
				        <thead>
				          <tr>
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
    
  </body>
</html>
