<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
  <head>
  
    <title>Main Frame</title>
    
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
	<script src="jquery/jquery-1.10.2.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js" ></script>
	<script type="text/javascript">
	
	function updateStatus(id, bugId) {
		var updateBtn = $("#status_" + id);
		updateBtn.button('loading');
		
		$.ajax({
			type: "get",
			url: "/BugTrackingSystem/api/bugStatus?id=" + id + "&bugId=" + bugId,
			data: "",
			
			success: function (data) {
				$("#label_status_" + id).text(data);		
			},
			
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("updating error! Please try again");
			},
			
			complete: function (XMLHttpRequest, textStatus) {
				updateBtn.button('reset');
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
	
	
	$(document).ready(function(){
		$("#mainFrameJSPNav").addClass("active");
		
		$('#search').keyup(function()
		{
			searchTable($(this).val(), "ownerBugTable");
		});
		
		$('#search2').keyup(function(){
			searchTable($(this).val(), "managedBugTable");
		});
		
		$('#search3').keyup(function(){
			searchTable($(this).val(), "differentBugTable");
		});
		
		$.ajax({
			type: "get",
			url: "/BugTrackingSystem/api/mainFrame",
			data: "",
			success: function (data) {

				var dataObj = data;
				$.each(dataObj.managedList, function(i,buginfo) {
					
					$("#managedBugTableBody").append("<tr> <td><a href=bugDetail.jsp?id=" + buginfo.id + ">" + buginfo.bugId + "</a></td><td><a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId=" + buginfo.bugId + "&Template=view&TableId=1000'>" + buginfo.title + "</a></td><td>" 
							+ buginfo.project + "</td><td>" + buginfo.owner + "</td><td>" + "<button id=status_" + buginfo.id + " onclick= " + "javascript:updateStatus('" + buginfo.id + "','" + buginfo.bugId + "') class='btn btn-default'>update</button>" + "<label id=label_status_" + buginfo.id + ">"  + buginfo.status + "</label>" + "</td>" + "</tr>");
				
				});
				
				$.each(dataObj.ownerList, function(i,buginfo) {
					
					$("#ownerBugTableBody").append("<tr> <td><a href=bugDetail.jsp?id=" + buginfo.id + ">" + buginfo.bugId + "</a></td><td><a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId=" + buginfo.bugId + "&Template=view&TableId=1000'>" + buginfo.title + "</a></td><td>" 
							+ buginfo.project + "</td><td>" + buginfo.owner + "</td><td>" + "<button id=status_" + buginfo.id + " onclick= " + "javascript:updateStatus('" + buginfo.id + "','" + buginfo.bugId + "') class='btn btn-default'>update</button>"  +  "<label id=label_status_" + buginfo.id + ">" + buginfo.status + "</label>" + "</td>" + "</tr>");
				
				});
				
				$.each(dataObj.changedList, function(i,warppedBuginfo) {
					var buginfo = warppedBuginfo.buginfo;
					$("#differentBugTableBody").append("<tr> <td><a href=bugDetail.jsp?id=" + buginfo.id + ">" + buginfo.bugId + "</a></td><td><a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId=" + buginfo.bugId + "&Template=view&TableId=1000'>" + buginfo.title + "</a></td><td>" 
							+ buginfo.project + "</td><td>" + buginfo.owner + "</td><td>" + buginfo.status + "</td>" +
							"<td>  <label class='radio'><input type='radio' name='radio_" + buginfo.id + "_" + warppedBuginfo.managedBugId + "' value='manage' \/\>manage</label>"  
							+ "<label class='radio'><input type='radio' name='radio_" + buginfo.id + "_" + warppedBuginfo.managedBugId + "' value='ingore' \/\>ingore </label>  </td> </tr>" );
						
					});
					
					$("#modifyBtnDiv").append("<button id='modifyBtn' name='modifyBtn' class='btn btn-default' onclick='javascript:modifyBtnClick()' type='button' data-loading-text='Loading...'>modify</button>");
			},
			
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				
			},
			
			complete: function (XMLHttpRequest, textStatus) {
				
			}
		});
		
		var updateAllOwnerListBtn = $("#updateAllOwnerListBtn");
		updateAllOwnerListBtn.click(function(){
			updateAllOwnerListBtn.button('loading');
			var table = $("#ownerBugTableBody");
			var _map = new Object();
			
			var i = 0;
			
			table.find('tr').each(function(index, row)
			{
				var allCells = $(row).find('td');
				var anchor = allCells[0].getElementsByTagName("a")[0];
				var bugId = anchor.innerHTML;
				var id = anchor.getAttribute("href").split("id=")[1];
				

				var btn = $("#status_" + id);
				btn.button('loading');

				_map[ id ] = bugId;
				i++;
			
			});
			
			
			$.ajax({
				type: "post",
				url: "/BugTrackingSystem/api/bugStatus",
				data: _map,
				
				success: function (data) {
					var dataObj = data;
					$.each(dataObj, function(i, obj) {
						for (var id in obj) {
							var newStatus = obj[id];
							var btn = $("#status_" + id);
							btn.button('reset');
							$("#label_status_" + id).text(newStatus);
						}
					});
					
						
				},
				
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert("updating error! Please try again");
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					updateAllOwnerListBtn.button('reset');
				}
			});
			
			
		});
		
		
		var updateAllManagedListBtn = $("#updateAllManagedListBtn");
		updateAllManagedListBtn.click(function(){
			updateAllManagedListBtn.button('loading');
			var table = $("#managedBugTableBody");
			var _map = new Object();
			
			var i = 0;
			
			table.find('tr').each(function(index, row)
			{
				var allCells = $(row).find('td');
				var anchor = allCells[0].getElementsByTagName("a")[0];
				var bugId = anchor.innerHTML;
				var id = anchor.getAttribute("href").split("id=")[1];
				

				var btn = $("#status_" + id);
				btn.button('loading');

				_map[ id ] = bugId;
				i++;
			
			});
			
			
			$.ajax({
				type: "post",
				url: "/BugTrackingSystem/api/bugStatus",
				data: _map,
				
				success: function (data) {
					var dataObj = data;
					$.each(dataObj, function(i, obj) {
						for (var id in obj) {
							var newStatus = obj[id];
							var btn = $("#status_" + id);
							btn.button('reset');
							$("#label_status_" + id).text(newStatus);
						}
					});
					
						
				},
				
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert("updating error! Please try again");
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					updateAllManagedListBtn.button('reset');
				}
			});
			
			
		});

		
		
		/*
		var refreshBtn = $("#refreshBtn");
		refreshBtn.click(function(){
			refreshBtn.button('loading');
			$.ajax({
				type: "get",
				url: "/BugTrackingSystem/api/refresh",
				data: "",
				success: function (data) {
					var dataObj = data;
					$("#differentDiv").css("display","block");
					$("#differentBugTableBody").empty();
					$("#modifyBtnDiv").empty();
					
					$.each(dataObj, function(i,buginfo) {
						
						$("#differentBugTableBody").append("<tr> <td><a href=bugDetail.jsp?id=" + buginfo.id + ">" + buginfo.bugId + "</a></td><td><a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId=" + buginfo.bugId + "&Template=view&TableId=1000'>" + buginfo.title + "</a></td><td>" 
							+ buginfo.project + "</td><td>" + buginfo.owner + "</td><td>" + buginfo.status + "</td>" +
							"<td>  <label class='radio'><input type='radio' name='radio_" + buginfo.id + "' value='manage' \/\>manage</label>"  
							+ "<label class='radio'><input type='radio' name='radio_" + buginfo.id + "' value='ingore' \/\>ingore </label>  </td> </tr>" );
						
					});
					
					$("#modifyBtnDiv").append("<button id='modifyBtn' name='modifyBtn' class='btn btn-default' onclick='javascript:modifyBtnClick()' type='button' data-loading-text='Loading...'>modify</button>");
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					refreshBtn.button('reset');
				}
			});
		});
		*/
	
	});
	
	function modifyBtnClick() {
		var modifyBtn = $("#modifyBtn");
		var differentFrame = $("#differentForm");

			modifyBtn.button('loading');
			$.ajax({
				method: differentFrame.attr('method'),
				url: differentFrame.attr('action'),
				data: differentFrame.serialize(),
				success: function (data) {
					alert(data);
					window.location.reload();
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					modifyBtn.button('reset');
				}
			});
	}
	
	</script>

  </head>
  
  <body>
  

		<%@ include file="navigation.jsp" %>


  		<div class="container" style="padding-top:70px" >
	  		<div class="row" >
		    	<div id="ownerBugDiv" class="col-lg-10" >

		    	
		    		  <div class="col-lg-4">
			    		  <h3>OwnerBugList</h3>
			    	  </div>
			    	  
			    	  <div class="col-lg-6" style="padding-top:20px">
	 					<input id="search" type="text" class="input-medium search-query" placeholder="input search info" >
					  </div>
					  
					   <div class="col-lg-2" style="padding-top:20px">
					  		<button id="updateAllOwnerListBtn" name="updateAllOwnerListBtn" class="btn btn-default" data-loading-text="Loading...">update all</button>
					   </div>
					 	
					 <div>
					 <br/>
		    		  <table id="ownerBugTable" class="table">
		    		  
				        <thead>
				          <tr>
				            <th>BugId</th>
				            <th>Title</th>
				            <th>Project</th>
				            <th>Owner</th>
				            <th>Status</th>
				          </tr>
				        </thead>
				        <tbody id="ownerBugTableBody">
				          
				        </tbody>
				      </table>
				      </div>
		    	</div>		    	
	    	</div>
    	</div>
    	
    	<hr/>
    	
    	<div class="container">
    	<div class="row">
    			<div id="managedBugDiv" class="col-lg-10" >
    				<div class="col-lg-4">
		    			<h3>ManagedBugList</h3>
		    		</div>
		    		
		    		<div class="col-lg-6" style="padding-top:20px">
	 					<input id="search2" type="text" class="input-medium search-query" placeholder="input search info" >
					</div>
					
					<div class="col-lg-2" style="padding-top:20px">
					  		<button id="updateAllManagedListBtn" name="updateAllManagedListBtn" class="btn btn-default" data-loading-text="Loading...">update all</button>
					</div>
					 
					<div >
					<br/>
		    		 <table id="managedBugTable" class="table">
				        <thead>
				          <tr>
				            <th>BugId</th>
				            <th>Title</th>
				            <th>Project</th>
				            <th>Owner</th>
				            <th>Status</th>
				          </tr>
				        </thead>
				        <tbody id="managedBugTableBody">
				          
				        </tbody>
				      </table>
				      </div>
		    	</div>
    	</div>
    	</div>
    	
    	<hr/>
    	
    	<div class="container">
    	<div class="row" >
	    	<div class="col-lg-10">
	    		<div class="col-lg-4">
	    			<h3>ChangedBugList</h3>
	    		</div>
	    		
	    		<div class="col-lg-8" style="padding-top:20px">
	 				<input id="search3" type="text" class="input-medium search-query" placeholder="input search info" >
				</div>
	    		 
	    		
		    	<div id="differentDiv">
					
	    			<form id="differentForm" name="differentForm" action="/BugTrackingSystem/api/bugs?method=put" method="post">
	    				<br/>
	    				<table id="differentBugTable" class="table">
				        
				        <thead>
				          <tr>
				            <th>BugId</th>
				            <th>Title</th>
				            <th>Project</th>
				            <th>NewOwner</th>
				            <th>Status</th>
				            <th>Operation</th>
				          </tr>
				        </thead>
				        <tbody id="differentBugTableBody">
				          
				        </tbody>
				      </table>
				      <div id='modifyBtnDiv'>
	    				
	    			  </div>
	    			</form>
	    			
	    			
	    			<!--  
	    			<button id="refreshBtn" name="refreshBtn" type="button" value="refresh" class="btn btn-default" data-loading-text="Loading...">refresh</button>  
		    		-->
		    	</div>
	    	</div>
    	</div>
    	</div>
    
  </body>
</html>
