<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>

<title>Main Frame</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- <meta http-equiv="cache-control" content="max-age=0" >
<meta http-equiv="cache-control" content="no-cache" >
<meta http-equiv="expires" content="0" >
<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" >
<meta http-equiv="pragma" content="no-cache" > -->

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
<!--[if lte IE 6]>
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-ie6.css">
<link rel="stylesheet" type="text/css" href="bootstrap/css/ie.css">
<![endif]-->

<link rel="stylesheet" href="datatables/css/demo_page.css" />
<link rel="stylesheet" href="datatables/css/demo_table_jui.css" />
<link rel="stylesheet"
	href="datatables/themes/smoothness/jquery-ui-1.8.4.custom.css" />
<link rel="stylesheet" href="bootstrap/css/validation.css"/>
<link rel="stylesheet" href="css/placeholder.css" />
<script src="jquery/jquery-1.10.2.min.js"></script>

<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="datatables/js/jquery.dataTables.js"></script>
<script src="datatables/js/jquery.dataTables.rowGrouping.js"></script>
<script src="datatables/js/ColReorderWithResize.js"></script>
<!-- <script src="js/placeholders.min.js"></script> -->
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <script src="js/respond.min.js"></script>

<![endif]-->
<script type="text/javascript">
	var ownerBugDataTable;
	var managerBugDataTable;
	var differentBugDataTable;
	
   
    
	function updateStatus(id, bugId) {
		var updateBtn = $("#status_" + id);
		updateBtn.button('loading');

		$.ajax({
			type : "get",
			url : "/BugTrackingSystem/api/bugStatus?id=" + id + "&bugId="
					+ bugId,
			data : "",
			cache : false,
			success : function(data) {
				$("#label_status_" + id).text(data);
			},

			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("updating error! Please try again");
			},

			complete : function(XMLHttpRequest, textStatus) {
				updateBtn.button('reset');
			}
		});

	}
	 function ellipsis(text, n) {
	    if(text.length>n)
	        return text.substring(0,n)+"...";
	    else
	        return text;
    }

    function truncatTextReder( nRow, aData, iDisplayIndex) 
    {
        var $cell=$('td:eq(2)', nRow);
        var text=ellipsis($cell.text(),100);
        var srcText =$cell.text().replace(/&/g, '&amp;')
           .replace(/"/g, '&quot;')
           .replace(/'/g, '&#39;')
           .replace(/</g, '&lt;')
           .replace(/>/g, '&gt;');
       	var slices=$cell.html().split(srcText);      
        var html;
        if(slices.length>2)
        {
          html=slices[0]+$cell.text()+slices[1]+text+slices[2];
        }else {
          html = $cell.html().replace($cell.text(),text);
        }
        $cell.html(html);
        return nRow;
    }
    
	$(document)
			.ready(
					function() {
												
					
						$("#mainFrameJSPNav").addClass("active");

						$.ajax({
									type : "get",
									url : "/BugTrackingSystem/api/mainFrame",
									data : "",
									cache :false,
									success : function(data) {
										var dataObj = data;
										var  managedRecordList=[];
										$.each(dataObj.managedList,
														function(i, buginfo) {
															var record = [];
															record.push("<img src='datatables/images/details_open.png' >");
															record.push("<a data-id="
																					+ buginfo.id
																					+ " style='text-decoration : none ' onclick='return false'>"
																					+ buginfo.bugId
																					+ "</a>");
															record.push("<a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId="
																					+ buginfo.bugId
																					+ "&Template=view&TableId=1000' target='view_window' title='"
																					+buginfo.title+"'>"
																					+ buginfo.title
																					+ "</a>");
															record.push(buginfo.project);
															record.push(buginfo.owner);
															record.push("<label id=label_status_" + buginfo.id + ">"
																					+ buginfo.status
																					+ "</label>");
															record.push("<button id=status_"
																					+ buginfo.id
																					+ " onclick= "
																					+ "javascript:updateStatus('"
																					+ buginfo.id
																					+ "','"
																					+ buginfo.bugId
																					+ "') class='btn btn-default'>update</button>"
																					);
															 managedRecordList.push(record);
														});
													
										managerBugDataTable = $('#managedBugTable').dataTable( {
											"sDom": 'R<C>H<"clear"><"ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix"lfr>t<"ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix"i<"managedButtonPlaceholder">p>',
											"bProcessing": true,
											/* "bLengthChange":false,
											"bPaginate":false, */
											"fnRowCallback":  truncatTextReder,
											"aoColumnDefs": [
												{ "bSortable": false, "aTargets": [ 0 ] }
											], 
											"aaSorting": [[1, 'asc']],
											"bJQueryUI": true,
											"sPaginationType": "full_numbers",
											"aaData": managedRecordList,
											"aoColumns": [
									            { sWidth: '5%'  },
									            { sWidth: '10%' },
									            { sWidth: '39%' },
									            { sWidth: '1%' ,
									            "bVisible":    false },
									            { sWidth: '15%' },
									            { sWidth: '15%' },
									            { sWidth: '15%' }
									            ]
										});	
										managerBugDataTable.rowGrouping({
											iGroupingColumnIndex:3,
											bExpandableGrouping: true,
										});					
										$(".managedButtonPlaceholder").html("<button id='updateAllManagedListBtn' name='updateAllManagedListBtn' style='margin-left : 15px' class='btn btn-default' data-loading-text='Loading'>updateall</button>");
										$(".managedButtonPlaceholder").css("width","15%");
										$(".managedButtonPlaceholder").css("float","right");
										//if ($.isFunction($.bootstrapIE6)) $.bootstrapIE6("#managedBugTable");
										
										
										var  ownerRecordList=[];
										$.each(
														dataObj.ownerList,
														function(i, buginfo) {
															var record = [];
															record.push("<img src='datatables/images/details_open.png' >");
															record.push("<a data-id="
																					+ buginfo.id
																					+ " style='text-decoration : none ' onclick='return false'>"
																					+ buginfo.bugId
																					+ "</a>");
														    record.push("<a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId="
																					+ buginfo.bugId
																					+ "&Template=view&TableId=1000'  target='view_window' title='"
																					+buginfo.title+"'>"
																					+ buginfo.title
																					+ "</a>");
														    record.push(buginfo.project);
														    record.push( buginfo.owner);
														    record.push(
																				   "<label id=label_status_" + buginfo.id + ">"
																					+ buginfo.status
																					+ "</label>");
															record.push("<button id=status_"
																					+ buginfo.id
																					+ " onclick= "
																					+ "javascript:updateStatus('"
																					+ buginfo.id
																					+ "','"
																					+ buginfo.bugId
																					+ "') class='btn btn-default'>update</button>");
														    ownerRecordList.push(record);
																														
														});
														
										
										

										/*
										 * Initialse DataTables, with no sorting on the 'details' column
										 */
										ownerBugDataTable = $('#ownerBugTable').dataTable( {
											"sDom": 'R<C>H<"clear"><"ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix"lfr>t<"ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix"i<"ownerButtonPlaceholder">p>',
											//"sDom": 'R<C><"ownerButtonPlaceholder">H<"clear">',
											"bProcessing": true,
											/* "bLengthChange":false,
											"bPaginate":false, */
											"fnRowCallback":  truncatTextReder,
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
									            { sWidth: '39%' },
									            { sWidth: '1%',
									            "bVisible":    false  },
									            { sWidth: '15%' },
									            { sWidth: '15%' },
									            { sWidth: '15%' }
									            ]
										});
										
										ownerBugDataTable.rowGrouping({
											iGroupingColumnIndex:3,
											bExpandableGrouping: true,
										});
											
										$(".ownerButtonPlaceholder").html("<button id='updateAllOwnerListBtn' name='updateAllOwnerListBtn' style='margin-left : 15px' class='btn btn-default' data-loading-text='Loading'>updateall</button>");
										$(".ownerButtonPlaceholder").css("width","15%");
										$(".ownerButtonPlaceholder").css("float","right");
										//if ($.isFunction($.bootstrapIE6)) $.bootstrapIE6("#ownerBugTable");
										var  differentRecordList=[];				
										$.each(
														dataObj.changedList,
														function(i,
																warppedBuginfo) {
															var buginfo = warppedBuginfo.buginfo;
															var record=[];
															record.push("<img src='datatables/images/details_open.png' >");
															record.push("<a data-id="
																					+ buginfo.id																				
																					+ " style='text-decoration : none ' onclick='return false'>"
																					+ buginfo.bugId
																					+ "</a>");
															record.push("<a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId="
																					+ buginfo.bugId
																					+ "&Template=view&TableId=1000'  target='view_window' title='"
																					+buginfo.title+"'>"
																					+ buginfo.title
																					+ "</a>");
															record.push(buginfo.project);
															record.push(buginfo.owner);
															record.push(buginfo.status);
															record.push("<label class='radio'><input type='radio' form='differentForm' name='radio_" + buginfo.id + "_" + warppedBuginfo.managedBugId + "' value='manage' \/\>manage</label>"
																					+ "<label class='radio'><input type='radio' form='differentForm'  name='radio_" + buginfo.id + "_" + warppedBuginfo.managedBugId + "' value='ingore' \/\>ingore </label>");
															
															differentRecordList.push(record);
															
														});
										differentBugDataTable = $('#differentBugTable').dataTable( {
											"sDom": 'R<C>H<"clear"><"ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix"lfr>t<"ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix"i<"diffentButtonPlaceholder">p>',
											"bProcessing": true,
											/* "bLengthChange":false,
											"bPaginate":false, */
											"fnRowCallback":  truncatTextReder,
											"aoColumnDefs": [
												{ "bSortable": false, "aTargets": [ 0 ] }
											], 
											"aaSorting": [[1, 'asc']],
											"bJQueryUI": true,
											"sPaginationType": "full_numbers",
											"aaData": differentRecordList,
											"aoColumns": [
									            { sWidth: '5%' },
									            { sWidth: '10%' },
									            { sWidth: '39%' },
									            { sWidth: '1%',
									            "bVisible":    false  },
									            { sWidth: '15%' },
									            { sWidth: '15%' },
									            { sWidth: '15%' }
									            ]
										});
										
										differentBugDataTable.rowGrouping({
											iGroupingColumnIndex:3,
											bExpandableGrouping: true,
										});
										
										$(".diffentButtonPlaceholder").html("<button id='modifyBtn' name='modifyBtn' class='btn btn-default' style='margin-left : 15px' onclick='javascript:modifyBtnClick()' type='button' data-loading-text='Loading'>modify</button>");
										$(".diffentButtonPlaceholder").css("width","15%");
										$(".diffentButtonPlaceholder").css("float","right");
										//if ($.isFunction($.bootstrapIE6)) $.bootstrapIE6("#differentBugTable");

									},

									error : function(XMLHttpRequest,
											textStatus, errorThrown) {

									},

									complete : function(XMLHttpRequest,
											textStatus) {

									}
								});

						var updateAllOwnerListBtn = $("#updateAllOwnerListBtn");
						$(document).delegate('#updateAllOwnerListBtn','click',function () {
									updateAllOwnerListBtn.button('loading');
									var table = $("#ownerBugTableBody");
									var _map = new Object();

									var i = 0;

									table.find('tr').each(
													function(index, row) {
														var allCells = $(row)
																.find('td');
													    // ignore the group row which only has one row data
														if(allCells.length>1){
															var anchor = allCells[1]
																.getElementsByTagName("a")[0];
															var bugId = anchor.innerHTML;
															var id = anchor
																	.getAttribute(
																			"data-id");

	
															var btn = $("#status_"
																	+ id);
															btn.button('loading');
	
															_map[id] = bugId;
															i++;

														}
														
													});

									$.ajax({
												type : "post",
												url : "/BugTrackingSystem/api/bugStatus",
												data : _map,
												cache : false,
												success : function(data) {
													var dataObj = data;
													$.each(
																	dataObj,
																	function(i,
																			obj) {
																		for ( var id in obj) {
																			var newStatus = obj[id];
																			var btn = $("#status_"
																					+ id);
																			btn
																					.button('reset');
																			$(
																					"#label_status_"
																							+ id)
																					.text(
																							newStatus);
																		}
																	});

												},

												error : function(
														XMLHttpRequest,
														textStatus, errorThrown) {
													alert("updating error! Please try again");
												},

												complete : function(
														XMLHttpRequest,
														textStatus) {
													updateAllOwnerListBtn
															.button('reset');
												}
											});

								});

						var updateAllManagedListBtn = $("#updateAllManagedListBtn");
						$(document).delegate('#updateAllManagedListBtn','click',function () {
									updateAllManagedListBtn.button('loading');
									var table = $("#managedBugTableBody");
									var _map = new Object();

									var i = 0;

									table
											.find('tr')
											.each(
													function(index, row) {
														var allCells = $(row)
																.find('td');
														if(allCells.length>1){
															var anchor = allCells[1]
																.getElementsByTagName("a")[0];
															var bugId = anchor.innerHTML;
															var id = anchor
																	.getAttribute(
																			"data-id");
	
															var btn = $("#status_"
																	+ id);
															btn.button('loading');
	
															_map[id] = bugId;
															i++;
															
														
														}
														
													});

									$.ajax({
												type : "post",
												url : "/BugTrackingSystem/api/bugStatus",
												data : _map,
												cache : false,
												success : function(data) {
													var dataObj = data;
													$
															.each(
																	dataObj,
																	function(i,
																			obj) {
																		for ( var id in obj) {
																			var newStatus = obj[id];
																			var btn = $("#status_"
																					+ id);
																			btn
																					.button('reset');
																			$(
																					"#label_status_"
																							+ id)
																					.text(
																							newStatus);
																		}
																	});

												},

												error : function(
														XMLHttpRequest,
														textStatus, errorThrown) {
													alert("updating error! Please try again");
												},

												complete : function(
														XMLHttpRequest,
														textStatus) {
													updateAllManagedListBtn
															.button('reset');
												}
											});

								});


					$(document).delegate('#ownerBugTable tbody td img','click',function () {
					    var heads=$("#ownerBugTable th");
					    var index;
					    $.each(heads,function(n,value){
					      
					      if(value.childNodes[0].childNodes[0].data=="BugId"){
					        index=n;
					        return false;
					      }
					      else 
					         return true;
					    
					    });
					   
						var nTr = $(this).parents('tr')[0];
					  	var id = nTr.childNodes[index].childNodes[0].attributes['data-id'].value;
						
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
									cache: false,
									success: function (data) {
										bugInfo = data;
									    var sOut= getBugInfoTable(bugInfo);										
										ownerBugDataTable.fnOpen( nTr, sOut, 'details' );
										
										}
									});
							}							
						} );
						
					
	
					$(document).delegate('#managedBugTable tbody td img','click',function () {
					 var heads=$("#managedBugTable th");
					    var index;
					    $.each(heads,function(n,value){
					      
					      if(value.childNodes[0].childNodes[0].data=="BugId"){
					        index=n;
					        return false;
					      }
					      else 
					         return true;
					    
					    });
						var nTr = $(this).parents('tr')[0];
					  	var id = nTr.childNodes[index].childNodes[0].attributes['data-id'].value;
						
				       		
							if ( managerBugDataTable.fnIsOpen(nTr) )
							{
								//alert("hello");
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
									cache : false,
									success: function (data) {
										bugInfo = data;
									    var sOut= getBugInfoTable(bugInfo);										
										managerBugDataTable.fnOpen( nTr, sOut, 'details' );
										
										}
									});
							}							
						} );
						
						
						$(document).delegate('#differentBugTable tbody td img','click',function () {
						var heads=$("#differentBugTable th");
					    var index;
					    $.each(heads,function(n,value){
					      
					      if(value.childNodes[0].childNodes[0].data=="BugId"){
					        index=n;
					        return false;
					      }
					      else 
					         return true;
					    
					    });
						var nTr = $(this).parents('tr')[0];
					  	var id = nTr.childNodes[index].childNodes[0].attributes['data-id'].value;
						
				       		//alert("hello");
							if ( differentBugDataTable.fnIsOpen(nTr) )
							{
								//This row is already open - close it
								this.src = "datatables/images/details_open.png";
								differentBugDataTable.fnClose( nTr );
							}
							else
							{
								//Open this row
								this.src = "datatables/images/details_close.png";
								$.ajax({
									type: "get",
									url: "/BugTrackingSystem/api/bug?id=" + id,
									data: "",
									cache : false,
									success: function (data) {
										bugInfo = data;
									    var sOut= getBugInfoTable(bugInfo);										
										differentBugDataTable.fnOpen( nTr, sOut, 'details' );
										
										}
									});
							}							
						} );
						
			});
	
	
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

				       
	function modifyBtnClick() {
		var modifyBtn = $("#modifyBtn");
		var differentFrame = $("#differentForm");

		modifyBtn.button('loading');
		$.ajax({
			method : differentFrame.attr('method'),
			url : differentFrame.attr('action'),
			data : differentFrame.serialize(),
			cache : false,
			success : function(data) {
				alert(data);
				window.location.reload();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {

			},

			complete : function(XMLHttpRequest, textStatus) {
				modifyBtn.button('reset');
			}
		});
	}
	
	
	
</script>

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

<!-- 	<hr /> -->

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

<!-- 	<hr /> -->

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="col-lg-4">
					<h3>ChangedBugList</h3>
				</div>

<!-- 				<div class="col-lg-8" style="padding-top:20px">
					<input id="search3" type="text" class="input-medium search-query"
						placeholder="input search info">
				</div> -->


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

	
</body>
 <!-- jQuery 1.7.2 or higher -->
  <!--[if lte IE 6]>
  <script type="text/javascript" src="js/bootstrap-ie.js"></script>
  <![endif]-->
</html>
