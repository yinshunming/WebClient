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
    <link rel="stylesheet" href="datatables/css/demo_page.css" />
	<link rel="stylesheet" href="datatables/css/demo_table_jui.css" />
	<link rel="stylesheet"
		href="datatables/themes/smoothness/jquery-ui-1.8.4.custom.css" />
	<script src="jquery/jquery-1.10.2.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js" ></script>
	<script src="datatables/js/jquery.dataTables.js"></script>
   	<script type="text/javascript">
   	var ownerBugDataTable;
	var managerBugDataTable;
	
   	function operateManagedBugs(managedBugId, id, operate) {
   		var operateManagedBtn = $("#operateManagedBtn_" + managedBugId);
		var buttonStr=operateManagedBtn.html();
		if(buttonStr=='Ignore'){
			operate=ingoreCmd;
		}
		else if (buttonStr=='Restore'){
			operate=restoreCmd;
		}
   		operateManagedBtn.button('loading');
   		
   		$.ajax({
			type: "post",
			url: "/BugTrackingSystem/api/managed?method=put&operate=" +  operate + "&managedBugId=" + managedBugId + "&id=" + id,
			data: "",
			success: function (data) {
				alert(data);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
				complete: function (XMLHttpRequest, textStatus) {
					 operateManagedBtn.button("reset");
					 if(operate==ingoreCmd){				
						operateManagedBtn.html('Restore');
					 }
					else if(operate==restoreCmd){
						operateManagedBtn.html('Ignore');	
					}
					//operateManagedBtn.enable();
				}
		});
   	} 
   	

	function deleteOwnerBugs(managedBugId, id) {
		
	}
	
	function operateOwnerBugs(managedBugId, id, operate) {
		var operateOwnerBtn = $("#operateOwenerBtn_" + managedBugId);
		var buttonStr=operateOwnerBtn.html();
		if(buttonStr=='Ignore'){
			operate=ingoreCmd;
		}
		else if (buttonStr=='Restore'){
			operate=restoreCmd;
		}
		operateOwnerBtn.button('loading');
		$.ajax({
			type: "post",
			url: "/BugTrackingSystem/api/owner?method=put&operate=" + operate + "&managedBugId=" + managedBugId + "&id=" + id,
			data: "",
			
			success: function (data) {
			
				alert(data);
				//window.location.reload();
			},
			
			error : function(XMLHttpRequest, textStatus, errorThrown) {
					
			},
				
			complete: function (XMLHttpRequest, textStatus) {
				operateOwnerBtn.button('reset');
				 if(operate==ingoreCmd){				
					operateOwnerBtn.html('Restore');
				 }
				else if(operate==restoreCmd){
					operateOwnerBtn.html('Ignore');	
				}
			}
		});
	}
	
	var ingoreCmd = "ingore";
	var restoreCmd = "restore";
	
	var managedText = "managed";
	var notManagedText = "not-managed";
	
	$(document).ready(function(){
		$("#historyBugsJSPNav").addClass("active");
			
		$.ajax({
			type: "get",
			url: "/BugTrackingSystem/api/managed",
			data: "",
			success: function (data) {
				var dataObj = data;
				var  managedRecordList=[];
			
				$.each(dataObj, function(i,warppedBuginfo) {
					
					var buginfo = warppedBuginfo.buginfo;
					var operationBtn = "";
					var managedDisplay = "";
					
					if (warppedBuginfo.status == 0) {
						operationBtn = "<button id = 'operateManagedBtn_" +  warppedBuginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateManagedBugs('"   + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + ingoreCmd +"')>Ingore</button>";
						managedDisplay = managedText;
					} else {
						operationBtn = "<button id = 'operateManagedBtn_" +  warppedBuginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateManagedBugs('"   + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" +  restoreCmd + "')>Restore</button>";
						managedDisplay = notManagedText;
					}
					var record = [];
					record.push("<img src='datatables/images/details_open.png' >");
					record.push("<td><a href=bugDetail.jsp?id=" + buginfo.id + ">" + buginfo.bugId + "</a>");
					record.push("<a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId=" + buginfo.bugId + "&Template=view&TableId=1000'>" + buginfo.title + "</a>");
					record.push(buginfo.project);
					record.push(buginfo.owner);
					record.push(buginfo.status);
					record.push(managedDisplay);
					record.push(operationBtn + "<button class='btn btn-default historyDelete' type='button' id='deleteManagedBtn_" + warppedBuginfo.managedBugId + "' data-bugId='"+buginfo.id+"'data-manageId='"+warppedBuginfo.managedBugId+"' data-loading-text='Loading...' " + ")>Delete</button>");
					managedRecordList.push(record);
					
					
				});
				managerBugDataTable = $('#historyBugsTable').dataTable( {
											"bProcessing": true,
											"aoColumnDefs": [
												{ "bSortable": false, "aTargets": [ 0 ] }
											], 
											"aaSorting": [[1, 'asc']],
											"bJQueryUI": true,
											"sPaginationType": "full_numbers",
											"aaData": managedRecordList,
											"aoColumns": [
									            { sWidth: '5%' },
									            { sWidth: '10%' },
									            { sWidth: '30%' },
									            { sWidth: '10%' },
									            { sWidth: '10%' },
									            { sWidth: '10%' },
									            { sWidth: '10%' },
									            { sWidth: '15%' },
									            ]
										});		
			}	
		});
					
				
		$.ajax({
			type: "get",
			url: "/BugTrackingSystem/api/owner",
			data: "",
			success: function (data) {
				var dataObj = data;
				var ownerRecordList=[];
				$.each(dataObj, function(i,warppedBuginfo) {
					var record=[];
					var buginfo = warppedBuginfo.buginfo;
					var operationBtn = "";
					var managedDisplay = "";
					
					if (warppedBuginfo.status == 0) {
						operationBtn = "<button id = 'operateOwnerBtn_" +  warppedBuginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateOwnerBugs('"  + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + ingoreCmd +"')>Ingore</button>";
						managedDisplay = managedText;
					} else {
						operationBtn = "<button id = 'operateOwenerBtn_" +  warppedBuginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateOwnerBugs('" + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + restoreCmd + "')>Restore</button>";
						managedDisplay = notManagedText;
					} 
					record.push("<img src='datatables/images/details_open.png' >");
					record.push("<td><a href=bugDetail.jsp?id=" + buginfo.id + ">" + buginfo.bugId + "</a>");
					record.push("<a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId=" + buginfo.bugId + "&Template=view&TableId=1000'>" + buginfo.title + "</a>");
					record.push(buginfo.project);
					record.push(buginfo.owner);
					record.push(buginfo.status);
					record.push(managedDisplay);
					//record.push(operationBtn + "<button class='btn btn-default ' type='button' id='deleteManagedBtn_" + warppedBuginfo.managedBugId +  "' data-loading-text='Loading...' onclick= " + "javascript:deleteManagedBugs('" + warppedBuginfo.managedBugId + "','" + buginfo.id + "')>Delete</button>");
					record.push(operationBtn + "<button class='btn btn-default owernerDelete' type='button' id='deleteManagedBtn_" + warppedBuginfo.managedBugId + "' data-bugId='"+buginfo.id+"'data-manageId='"+warppedBuginfo.managedBugId+"' data-loading-text='Loading...' " + ")>Delete</button>");
					ownerRecordList.push(record);
					
				});
				ownerBugDataTable = $('#ownerBugsTable').dataTable( {
											"bProcessing": true,
											"aoColumnDefs": [
												{ "bSortable": false, "aTargets": [ 0 ] }
											], 
											"aaSorting": [[1, 'asc']],
											"bJQueryUI": true,
											"sPaginationType": "full_numbers",
											"aaData": ownerRecordList,
											"aoColumns": [
									            { sWidth: '5%' },
									            { sWidth: '10%' },
									            { sWidth: '30%' },
									            { sWidth: '10%' },
									            { sWidth: '10%' },
									            { sWidth: '10%' },
									            { sWidth: '10%' },
									            { sWidth: '15%' },
									            ]
										});		
			}
		});
		$(document).delegate('#historyBugsTable tbody td img','click',function () {
						var nTr = $(this).parents('tr')[0];
					  	var id = nTr.childNodes[1].childNodes[0].attributes[0].value.split("id=")[1];
						
				       		//alert("hello");
							if ( managerBugDataTable.fnIsOpen(nTr) )
							{
								//This row is already open - close it
								this.src = "datatables/images/details_open.png";
								managerBugDataTable.fnClose( nTr );
							}
							else
							{
								//Open this row
								this.src = "datatables/images/details_close.png";
								$.ajax({
									type: "get",
									url: "/BugTrackingSystem/api/bug?id=" + id,
									data: "",
									success: function (data) {
										bugInfo = data;
									    var sOut= getBugInfoTable(bugInfo);										
										managerBugDataTable.fnOpen( nTr, sOut, 'details' );
										
										}
									});
							}							
		} );
		$(document).delegate('#ownerBugsTable tbody td img','click',function () {
						var nTr = $(this).parents('tr')[0];
					  	var id = nTr.childNodes[1].childNodes[0].attributes[0].value.split("id=")[1];
						
				       		//alert("hello");
							if ( ownerBugDataTable.fnIsOpen(nTr) )
							{
								//This row is already open - close it
								this.src = "datatables/images/details_open.png";
								ownerBugDataTable.fnClose( nTr );
							}
							else
							{
								//Open this row
								this.src = "datatables/images/details_close.png";
								$.ajax({
									type: "get",
									url: "/BugTrackingSystem/api/bug?id=" + id,
									data: "",
									success: function (data) {
										bugInfo = data;
									    var sOut= getBugInfoTable(bugInfo);										
										ownerBugDataTable.fnOpen( nTr, sOut, 'details' );
										
										}
									});
							}							
		} );
		function  getBugInfoTable(bugInfo){
			var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
			sOut += '<tr><td>Component:</td><td>'+bugInfo.component+'</td></tr>';
			sOut += '<tr><td>BugId:</td><td>'+bugInfo.bugId+'</td></tr>';
			sOut += '<tr><td>Title:</td><td>'+bugInfo.title+'</td></tr>';
			sOut += '<tr><td>Project:</td><td>'+bugInfo.project+'</td></tr>';
			sOut += '<tr><td>Type:</td><td>'+bugInfo.type+'</td></tr>';
			sOut += '<tr><td>Status:</td><td>'+bugInfo.status+'</td></tr>';
			sOut += '<tr><td>Description:</td><td>'+bugInfo.description+'</td></tr>';
			sOut += '<tr><td>Owner:</td><td>'+bugInfo.owner+'</td></tr>';
			sOut += '<tr><td>Submitter:</td><td>'+bugInfo.submitter+'</td></tr>';
			sOut += '<tr><td>SubmitData:</td><td>'+bugInfo.submitData+'</td></tr>';
			sOut += '<tr><td>Severity:</td><td>'+bugInfo.severity+'</td></tr>';
			sOut += '<tr><td>Tags:</td><td>'+bugInfo.tags+'</td></tr>';
			sOut += '<tr><td>Regression:</td><td>'+bugInfo.regression+'</td></tr>';									
			sOut += '</table>';
			return sOut;
		}

		$(document).delegate('.historyDelete','click',function () {
						var managedBugId=$(this).attr("data-manageid");
						var id=$(this).attr("data-bugid");
						var row = $(this).closest("tr").get(0);
						var rowId=managerBugDataTable.fnGetPosition(row);
						var deleteBtn = $("#deleteManagedBtn_" + managedBugId);
						deleteBtn.button('loading');
						$.ajax({
							type: "delete",
							url: "/BugTrackingSystem/api/managed?managedBugId=" + managedBugId + "&id=" + id,
							data: "",
							success: function (data) {
								alert(data);
								
								//window.location.reload();
							},
							error : function(XMLHttpRequest, textStatus, errorThrown) {
									
								},
								
								complete: function (XMLHttpRequest, textStatus) {
									deleteBtn.button('reset');
									managerBugDataTable.fnDeleteRow(rowId);
								}
						});
				       				
		} );	
		$(document).delegate('.owernerDelete','click',function () {
						var managedBugId=$(this).attr("data-manageid");
						var id=$(this).attr("data-bugid");
						var row = $(this).closest("tr").get(0);
						var rowId=managerBugDataTable.fnGetPosition(row);
						var deleteBtn = $("#deleteOwnerBtn_" + id);
						deleteBtn.button('loading');
						$.ajax({
							type: "delete",
							url: "/BugTrackingSystem/api/owner?managedBugId=" + managedBugId + "&id=" + id,
							data: "",
							
							success: function (data) {
								alert(data);
								//window.location.reload();
							},
							
							error : function(XMLHttpRequest, textStatus, errorThrown) {
									
							},
								
							complete: function (XMLHttpRequest, textStatus) {
								deleteBtn.button('reset');
								ownerBugDataTable.fnDeleteRow(rowId);
							}
						});
				       				
		} );			
	});
	</script>

  </head>
  
  <body>
    <%@ include file="navigation.jsp" %>
    <div class="container" style="padding-top:70px" >
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
    
    <div class="container">
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
    
  </body>
</html>
