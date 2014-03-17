	var ownerBugDataTable;
	var managerBugDataTable;
	var ownerBugTimer;
	var historyBugTimer;
	var ignoreCmd = "ignore";
	var restoreCmd = "restore";
	var managedText = "managed";
	var notManagedText = "not-managed";
	var modifyTd;
	var ownerRestoreList=[];
	var managedRestoreList=[];
	function ellipsis(text, n) {
	    if(text.length>n)
	        return text.substring(0,n)+"...";
	    else
	        return text;
    }

    function truncatTextReder( nRow, aData, iDisplayIndex) 
    {
        var $cell=$('td:eq(2)', nRow);
        // truncated text
        var text=ellipsis($cell.text(),1000);
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
	
    var update_size = function() {
        $(ownerBugDataTable).css({ width: $(ownerBugDataTable).parent().width() });
        ownerBugDataTable.fnAdjustColumnSizing();  
        $(managerBugDataTable).css({ width: $(managerBugDataTable).parent().width() });
        managerBugDataTable.fnAdjustColumnSizing();  
      }

    
    
   	function operateManagedBugs(managedBugId, id, operate) {
   		var operateManagedBtn = $("#operateManagedBtn_" + managedBugId);
		var buttonStr=operateManagedBtn.html();
		if(buttonStr=='Ignore'){
			operate=ignoreCmd;
		}
		else if (buttonStr=='Restore'){
			operate=restoreCmd;
		}
   		operateManagedBtn.button('loading');
   		var nTr = $('#operateManagedBtn_'+managedBugId).parents('tr')[0];
   		$.ajax({
			type: "put",
			url: "/BugTrackingSystem/api/managed?operate=" +  operate + "&managedBugId=" + managedBugId + "&id=" + id,
			data: "",
			cache : false,
			success: function (data) {
			    alertify.log(data,"success");
				//alert(data);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
			complete: function (XMLHttpRequest, textStatus) {
					 operateManagedBtn.button("reset");
					 if(operate==ignoreCmd){				
						operateManagedBtn.html('Restore');
						nTr.className +=' gradeU'
					 }
					else if(operate==restoreCmd){
						operateManagedBtn.html('Ignore');	
						nTr.className=nTr.className.replace('gradeU',"")
					}
					//operateManagedBtn.enable();
				}
		});
   	} 
   	

	function deleteOwnerBugs(managedBugId, id) {
		
	}
	
	function operateOwnerBugs(managedBugId, id, operate) {
		var operateOwnerBtn = $("#operateOwnerBtn_" + managedBugId);
		var buttonStr=operateOwnerBtn.html();
		if(buttonStr=='Ignore'){
			operate=ignoreCmd;
		}
		else if (buttonStr=='Restore'){
			operate=restoreCmd;
		}
		operateOwnerBtn.button('loading');
		var nTr = $('#operateOwnerBtn_'+managedBugId).parents('tr')[0];
		$.ajax({
			type: "put",
			url: "/BugTrackingSystem/api/owner?operate=" + operate + "&managedBugId=" + managedBugId + "&id=" + id,
			data: "",
			cache : false,
			success: function (data) {
				alertify.log(data,"success");
				//alert(data);
				//window.location.reload();
			},
			
			error : function(XMLHttpRequest, textStatus, errorThrown) {
					
			},
				
			complete: function (XMLHttpRequest, textStatus) {
				operateOwnerBtn.button('reset');
				 if(operate==ignoreCmd){				
					operateOwnerBtn.html('Restore');
					nTr.className +=' gradeU'
				 }
				else if(operate==restoreCmd){
					operateOwnerBtn.html('Ignore');	
					nTr.className=nTr.className.replace('gradeU',"")
				}
			}
		});
	}
	

	function loadOwnerTable(){
		$.ajax({
			type: "get",
			url: "/BugTrackingSystem/api/owner",
			data: "",
			cache : false,
			success: function (data) {
				var dataObj = data;
				var ownerRecordList=[];
				$.each(dataObj, function(i,warppedBuginfo) {
					var record=[];
					var buginfo = warppedBuginfo.buginfo;
					var operationBtn = "";
					var managedDisplay = "";
					
					
					var dropDownMenu = '<div class="btn-group"><button class="btn btn-default btn-sm dropdown-toggle btn-action" type="button" data-toggle="dropdown"> Action <span class="caret"></span></button><ul class="dropdown-menu">';
					var endTag = '</ul></div>';
					var seperateLine = '<li class="divider"></li>';
					if (warppedBuginfo.status == 0) {
						//operationBtn = "<button id = 'operateOwnerBtn_" +  warppedBuginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateOwnerBugs('"  + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + ignoreCmd +"')>Ignore</button>";
						operationBtn = "<li><a href='javascript:void(0)' id = 'operateOwnerBtn_" +  warppedBuginfo.managedBugId + "' onclick= " + "javascript:operateOwnerBugs('"  + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + ignoreCmd +"')>Ignore</a></li>";
						managedDisplay = managedText;
					} else {
						//operationBtn = "<button id = 'operateOwnerBtn_" +  warppedBuginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateOwnerBugs('" + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + restoreCmd + "')>Restore</button>";
						operationBtn = "<li><a href='javascript:void(0)' id = 'operateOwnerBtn_" +  warppedBuginfo.managedBugId + "' onclick= " + "javascript:operateOwnerBugs('"  + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + restoreCmd +"')>Restore</a></li>";
						ownerRestoreList.push(buginfo.bugId);
						managedDisplay = notManagedText;
					} 
					deleteBtn = "<li><a href='javascript:void(0)' class='owernerDelete 'id='deleteManagedBtn_" + warppedBuginfo.managedBugId + "' data-bugId='"+buginfo.id+"'data-manageId='"+warppedBuginfo.managedBugId+"'  " + ")>Delete</a></li>";
					record.push("<img src='assets/images/details_open.png'  >");
					record.push("<td><a data-id=" + buginfo.id + " style='text-decoration : none ' onclick='return false'>" + buginfo.bugId + "</a>");
					record.push("<div class='outer'> <div class='inner'><a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId=" + buginfo.bugId + "&Template=view&TableId=1000' target='view_window' title='"+buginfo.title+"'>" + buginfo.title  + "</a></div> </div>");
					record.push(buginfo.project);
					record.push("<div class='outer'> <div class='inner component' >"+buginfo.owner+" </div> </div>");
					record.push("<div class='outer'> <div class='inner'>"+buginfo.status+" </div> </div>");
					record.push("<div class='outer'> <div class='inner'>"+managedDisplay+" </div> </div>");
					//record.push(operationBtn + "<button class='btn btn-default owernerDelete ' type='button' id='deleteManagedBtn_" + warppedBuginfo.managedBugId + "' data-bugId='"+buginfo.id+"'data-manageId='"+warppedBuginfo.managedBugId+"' data-loading-text='Loading...' " + ")>Delete</button>");
					record.push(dropDownMenu+operationBtn+seperateLine+deleteBtn+endTag);
					
					ownerRecordList.push(record);
					
				});
				ownerBugDataTable = $('#ownerBugsTable').dataTable( {
											"bProcessing": true,
											/* "bLengthChange":false,
											"bPaginate":false, */
											"fnRowCallback":  truncatTextReder,
											"sDom": 'R<C>H<"clear"><"ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix"lfr>t<"ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix"ip>',
											"aoColumnDefs": [
												{ "bSortable": false, "aTargets": [ 0 ] }
											], 
											"aaSorting": [[1, 'asc']],
											"bJQueryUI": true,
											"sPaginationType": "full_numbers",
											"aaData": ownerRecordList,
											"aoColumns": [
									            { sWidth: '5%',"bSearchable": false  },
									            { sWidth: '5%' },
									            { sWidth: '44%' },
									            { sWidth: '1%' ,
									            "bVisible":    false },
									            { sWidth: '13%' },
									            { sWidth: '12%' },
									            { sWidth: '10%' },
									            { sWidth: '10%',"bSearchable": false  }
									            ],
											 fnInitComplete: function ( oSettings )
									            {
									                for ( var i=0, iLen=oSettings.aoData.length ; i<iLen ; i++ )
									                {
									                	var bugId = oSettings.aoData[i].nTr.childNodes[1].childNodes[0].textContent;
									                	if ($.inArray(bugId,ownerRestoreList) != -1){
									                		oSettings.aoData[i].nTr.className += " gradeU";
									                	}
									                    
									                }
												 $('#ownerBugsTable tbody td div.inner').each(function(index){
													    $this = $(this);
													    var titleVal = $this.text();
													    if (titleVal != '') {
													      $this.attr('title', titleVal);
													    }
													  });	
									            }
										});		
				ownerBugDataTable.rowGrouping({
					iGroupingColumnIndex:3,
					bExpandableGrouping: true,
				});
			}
		});
	}
	
	function loadManagedTable(){
		$.ajax({
			type: "get",
			url: "/BugTrackingSystem/api/managed",
			data: "",
			cache : false,
			success: function (data) {
				var dataObj = data;
				var  managedRecordList=[];
			
				$.each(dataObj, function(i,warppedBuginfo) {
					
					var buginfo = warppedBuginfo.buginfo;
					var operationBtn = "";
					var managedDisplay = "";
					var dropDownMenu = '<div class="btn-group"><button class="btn btn-default btn-sm dropdown-toggle btn-action" type="button" data-toggle="dropdown"> Action <span class="caret"></span></button><ul class="dropdown-menu">';
					var endTag = '</ul></div>';
					var seperateLine = '<li class="divider"></li>';
					if (warppedBuginfo.status == 0) {
						//operationBtn = "<button id = 'operateManagedBtn_" +  warppedBuginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateManagedBugs('"   + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + ignoreCmd +"')>Ignore</button>";
						operationBtn = "<li><a href='javascript:void(0)' id = 'operateManagedBtn_" +  warppedBuginfo.managedBugId + "' onclick= " + "javascript:operateManagedBugs('"  + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + ignoreCmd +"')>Ignore</a></li>";
						managedDisplay = managedText;
					} else {
						//operationBtn = "<button id = 'operateManagedBtn_" +  warppedBuginfo.managedBugId + "' class='btn btn-default' type='button' data-loading-text='Loading...' onclick= " + "javascript:operateManagedBugs('"   + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" +  restoreCmd + "')>Restore</button>";
						operationBtn = "<li><a href='javascript:void(0)' id = 'operateManagedBtn_" +  warppedBuginfo.managedBugId + "' onclick= " + "javascript:operateManagedBugs('"  + warppedBuginfo.managedBugId + "','" + buginfo.id + "','" + restoreCmd +"')>Restore</a></li>";
						managedDisplay = notManagedText;
						managedRestoreList.push(buginfo.bugId);
					}
					var record = [];
					deleteBtn = "<li><a href='javascript:void(0)' class='historyDelete 'id='deleteManagedBtn_" + warppedBuginfo.managedBugId + "' data-bugId='"+buginfo.id+"'data-manageId='"+warppedBuginfo.managedBugId+"'  " + ")>Delete</a></li>";
					record.push("<img src='assets/images/details_open.png' >");
					record.push("<td><a data-id=" + buginfo.id + " style='text-decoration : none ' onclick='return false'>" + buginfo.bugId + "</a>");
					record.push("<div class='outer'> <div class='inner'> <a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId=" + buginfo.bugId + "&Template=view&TableId=1000' target='view_window' title='"+buginfo.title+"'>" + buginfo.title + "</a></div> </div>");
					record.push(buginfo.project);
					record.push("<div class='outer'> <div class='inner component' >"+buginfo.owner+" </div> </div>");
					record.push("<div class='outer'> <div class='inner component' >"+buginfo.status+" </div> </div>");
					record.push("<div class='outer'> <div class='inner component' >"+managedDisplay+" </div> </div>");
					//record.push(operationBtn + "<button class='btn btn-default historyDelete ' type='button' id='deleteManagedBtn_" + warppedBuginfo.managedBugId + "' data-bugId='"+buginfo.id+"'data-manageId='"+warppedBuginfo.managedBugId+"' data-loading-text='Loading...' " + ")>Delete</button>");
					record.push(dropDownMenu+operationBtn+seperateLine+deleteBtn+endTag);
					managedRecordList.push(record);
					
					
				});
				managerBugDataTable = $('#historyBugsTable').dataTable( {
											"bProcessing": true,
											/* "bLengthChange":false,
											"bPaginate":false, */
											"fnRowCallback":  truncatTextReder,
											"sDom": 'R<C>H<"clear"><"ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix"lfr>t<"ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix"ip>',
											"aoColumnDefs": [
												{ "bSortable": false, "aTargets": [ 0 ] }
											], 
											"aaSorting": [[1, 'asc']],
											"bJQueryUI": true,
											"sPaginationType": "full_numbers",
											"aaData": managedRecordList,
											"aoColumns": [
									            { sWidth: '5%',"bSearchable": false  },
									            { sWidth: '5%' },
									            { sWidth: '44%' },
									            { sWidth: '1%' ,
									            "bVisible":    false },
									            { sWidth: '13%' },
									            { sWidth: '12%' },
									            { sWidth: '10%' },
									            { sWidth: '10%',"bSearchable": false  }
									            ],
											 fnInitComplete: function ( oSettings )
									            {
									                for ( var i=0, iLen=oSettings.aoData.length ; i<iLen ; i++ )
									                {
									                	var bugId = oSettings.aoData[i].nTr.childNodes[1].childNodes[0].textContent;
									                	if ($.inArray(bugId,managedRestoreList) != -1){
									                		oSettings.aoData[i].nTr.className += " gradeU";
									                	}
									                }
												 
												 $('#historyBugsTable tbody td div.inner').each(function(index){
													    $this = $(this);
													    var titleVal = $this.text();
													    if (titleVal != '') {
													      $this.attr('title', titleVal);
													    }
													  });	
									            }
										});		
				managerBugDataTable.rowGrouping({
					iGroupingColumnIndex:3,
					bExpandableGrouping: true,
				});
			}	
		});
					
	}
	
	function loadTables(){
		$("#historyBugsJSPNav").addClass("active");
		loadOwnerTable();
		loadManagedTable();
	}
	
	function historyBugsTableDetail(){
		var heads=$("#historyBugsTable th");
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
			if ( managerBugDataTable.fnIsOpen(nTr) )
			{
				//This row is already open - close it
				this.src = "assets/images/details_open.png";
				managerBugDataTable.fnClose( nTr );
			}
			else
			{
				//Open this row
				this.src = "assets/images/details_close.png";
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
	}
	
	function ownerBugsTableDetail(){
		var heads=$("#ownerBugsTable th");
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
				this.src = "assets/images/details_open.png";
				ownerBugDataTable.fnClose( nTr );
			}
			else
			{
				//Open this row
				this.src = "assets/images/details_close.png";
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

		
	}
	
	function ownerBugsTableSearchHighlight(){
		clearInterval(ownerBugTimer);  
		if($('#ownerBugsTableBody tr').find('td:not(:last)').hasHightlight()){
			  $('#ownerBugsTableBody  tr').find('td:not(:last)').removeHighlight();
		 }
		
        if ($(this).val() != "") {
            $('#ownerBugsTableBody   tr').find('td:not(:last)').highlight($(this).val());
        }else {
        	$('#ownerBugsTableBody  tr').find('td:not(:last)').removeHighlight();
        }
        
        ownerBugTimer = setTimeout(function(){
            $('#ownerBugsTableBody  tr ').find('td:not(:last)').removeHighlight();}, 1000);
	}
	
	function historyBugsTableSearchHightlight(){
		clearInterval(historyBugTimer);  
		if($('#historyBugsTableBody  tr').find('td:not(:last)').hasHightlight()){
			  $('#historyBugsTableBody  tr').find('td:not(:last)').removeHighlight();
		 }
		
        if ($(this).val() != "") {
            $('#historyBugsTableBody tr').find('td:not(:last)').highlight($(this).val());
        }else {
        	$('#historyBugsTableBody  tr').find('td:not(:last)').removeHighlight();
        }
        
        historyBugTimer = setTimeout(function(){
            $('#historyBugsTableBody  tr').find('td:not(:last)').removeHighlight();}, 1000);
	}
	
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
	
	function historyDeleteClick(){
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
			cache : false,
			success: function (data) {
			    alertify.log(data,"success");
				//alert(data);
				
				//window.location.reload();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
					
				},
				
			complete: function (XMLHttpRequest, textStatus) {
					deleteBtn.button('reset');
					managerBugDataTable.fnDeleteRow(rowId);
				}
		});
	}
	
	function ownerDeleteClick(){
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
			cache : false,
			success: function (data) {
				alertify.log(data,"success");
				//alert(data);
				//window.location.reload();
			},
			
			error : function(XMLHttpRequest, textStatus, errorThrown) {
					
			},
				
			complete: function (XMLHttpRequest, textStatus) {
				deleteBtn.button('reset');
				ownerBugDataTable.fnDeleteRow(rowId);
			}
		});
	}
	
	function windowResize(){
		 clearTimeout(window.refresh_size);
		 window.refresh_size = setTimeout(function() { update_size(); }, 50);
	}
	
	$(document).ready(function(){
		loadTables();
		$(document).delegate('#historyBugsTable tbody td img','click',historyBugsTableDetail);
		$(document).delegate('#ownerBugsTable tbody td img','click',ownerBugsTableDetail);
		$(document).delegate('#ownerBugsTable_filter input','keyup',ownerBugsTableSearchHighlight);
		$(document).delegate('#historyBugsTable_filter input','keyup',historyBugsTableSearchHightlight);
		$(document).delegate('.historyDelete','click',historyDeleteClick);	
		$(document).delegate('.owernerDelete','click',ownerDeleteClick );	
		$(window).resize(windowResize);
	});