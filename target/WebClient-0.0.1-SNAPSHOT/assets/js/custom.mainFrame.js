	var ownerBugDataTable;
	var managerBugDataTable;
	var differentBugDataTable;
	var ownerBugTimer;
	var managedBugTimer;
	var differentBugTimer;
	var changedBugIDList=[];
	var modifyTd;
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
				alertify.log( "update succeed! " ,"success");
			},

			error : function(XMLHttpRequest, textStatus, errorThrown) {
				//alert("updating error! Please try again");
				alertify.log( "updating error! Please try again" ,"error");
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
        $(differentBugDataTable).css({ width: $(differentBugDataTable).parent().width() });
        differentBugDataTable.fnAdjustColumnSizing(); 
      }

    /*function updateAllTables(){
    	
    }
    
    function updateManagedTable(managedList){
    	ownerBugDataTable.fnClearTable();
    	ownerBugDataTable.fnDraw();
    	
    }
    
    function updateOwnerTable(ownerList){
    	managerBugDataTable.fnClearTable();
    	managerBugDataTable.fnDraw();
    }
    
    function updateDifferentTable(changedList){
    	differentBugDataTable.fnClearTable();
    	differentBugDataTable.fnDraw();
    }*/
    
    function  loadManagedTable(managedList){
    	var  managedRecordList=[];
		$.each(managedList,
						function(i, buginfo) {
							var record = [];
							record.push("<img src='assets/images/details_open.png' > ");
							record.push("<a data-id="
													+ buginfo.id
													+ " style='text-decoration : none ' onclick='return false'>"
													+ buginfo.bugId
													+ "</a> ");
							record.push("<div class='outer'> <div class='inner'> <a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId="
													+ buginfo.bugId
													+ "&Template=view&TableId=1000' target='view_window' title='"
													+buginfo.title+"'>"
													+ buginfo.title
													+ "</a> </div> </div>");
							record.push(buginfo.project);
							record.push("<div class='outer'> <div class='inner component' >"+buginfo.component+" </div> </div>");
							record.push("<div class='outer'> <div class='inner'>"+buginfo.owner+" </div> </div>");
							record.push("<div class='outer'> <div class='inner'><label id=label_status_" + buginfo.id + ">"
													+ buginfo.status
													+ "</label></div> </div>");
							/*record.push("<button id=status_"
													+ buginfo.id
													+ " onclick= "
													+ "javascript:updateStatus('"
													+ buginfo.id
													+ "','"
													+ buginfo.bugId
													+ "') class='btn btn-default'>update</button>"
													);*/
							 managedRecordList.push(record);
						});
		if(managerBugDataTable != null){
			managerBugDataTable.fnDestroy();
			$('#managedBugTable_wrapper').empty();		
		}
		
		managerBugDataTable = $('#managedBugTable').dataTable( {
			"sDom": 'R<C>H<"clear"><"ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix"lfr>t<"ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix"i<"managedButtonPlaceholder">p>',
			"bProcessing": true,
			/* "bLengthChange":false,
			"bPaginate":false, */
			//"fnRowCallback":  truncatTextReder,
			"aoColumnDefs": [
				{ "bSortable": false, "aTargets": [ 0 ] }
			], 
			"aaSorting": [[1, 'asc']],
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"aaData": managedRecordList,
			"aoColumns": [
	            { sWidth: '5%' ,"bSearchable": false  },
	            { sWidth: '5%' },
	            { sWidth: '44%' ,"sType": 'html'},
	            { sWidth: '1%' ,
	            "bVisible":    false },
	            { sWidth: '15%' },
	            { sWidth: '10%' },
	            { sWidth: '10%' },
	           /* { sWidth: '10%',"bSearchable": false  }*/
	            ]
	       /* "bAutoWidth": false,
            "sScrollY": "35em",
            "sScrollX": "100%",
            "bScrollCollapse": true*/
		});	
		managerBugDataTable.rowGrouping({
			iGroupingColumnIndex:3,
			bExpandableGrouping: true,
		});		
		 managerBugDataTable.makeEditable({
			sUpdateURL: function(value, settings)
			{
     			return(value); //Simulation of server-side response using a callback function
			},
			"aoColumns": 
			[
			  null,
			  null,
			  null,
			  {
			    cssclass:"required",
			  	indicator: 'Saving component...',
			  	tooltip: 'Double click to modify component',
			  	loadtext: 'loading...',
			  	 type: 'select',
			  	 onblur: 'submit',
			  	 data: "{'':'Please select...', 'None':'None','DDC-ADIdentity Service':'DDC-ADIdentity Service','DDC-Broker Service':'DDC-Broker Service','DDC-Configuration Service':'DDC-Configuration Service','DDC-Configuration Logging Service':'DDC-Configuration Logging Service','DDC-Delegated Admin Service':'DDC-Delegated Admin Service','DDC-Event Test Service':'DDC-Event Test Service','DDC-Host Service':'DDC-Host Service','DDC-Machine Creation Service':'DDC-Machine Creation Service','DDC-Scout(Taas)':'DDC-Scout(Taas)','VDA-Broker Agent(VDA)':'VDA-Broker Agent(VDA)','VDA-Machine Identity Service Agent':'VDA-Machine Identity Service Agent','HDX-ICA HostCore':'HDX-ICA HostCore','HDX-ICA Graphics':'HDX-ICA Graphics','HDX-ICA Integration':'HDX-ICA Integration','HDX-ICA IO':'HDX-ICA IO','HDX-ICA Multimedia':'HDX-ICA Multimedia','HDX-ICA Printing':'HDX-ICA Printing','HDX-ICA Packaging':'HDX-ICA Packaging','Director':'Director','Group Policy':'Group Policy','Studio':'Studio','Licensing':'Licensing','Monitoring Service':'Monitoring Service','StoreFront':'StoreFront','MetaInstaller':'MetaInstaller','AppV':'AppV','PVD':'PVD','PVS':'PVS'}",
			  	 sUpdateURL:  function(value, settings)
                        {
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
                        		var bugId=nTr.childNodes[index].childNodes[0].innerText;
                        		modifyTd=$(this);
                        		$.ajax({
									type : "put",
									url : "/BugTrackingSystem/api/bug?id="+id+"&bugId="+bugId+"&component="+value,
									success : function(data) {
										var html ="<div class='outer'> <div class='inner component' title='"+modifyTd.html()+"\nDouble click to modify!' >"+modifyTd.html()+" </div> </div>"
											modifyTd.html(html);
											alertify.log(data,"success");
									    		 //alert(data) ; 
									    		  }
									});
                        		//value ="<div class='outer'> <div class='inner component' >"+value+" </div> </div>"
                                return(value);
                        }
			  },
			  null,
			  null,
			  null
			]
		
		}); 
		$(".managedButtonPlaceholder").html("<button id='updateAllManagedListBtn' name='updateAllManagedListBtn' style='margin-left : 15px' class='btn btn-default btn-nested' data-loading-text='Loading'>Update</button>");
		$(".managedButtonPlaceholder").css("width","10%");
		$(".managedButtonPlaceholder").css("float","right");
    }
    
    
    
    function loadOwnerTable(ownerList){
    	var  ownerRecordList=[];
		$.each(
						ownerList,
						function(i, buginfo) {
							var record = [];
							record.push("<img src='assets/images/details_open.png' >");
							record.push("<a data-id="
													+ buginfo.id
													+ " style='text-decoration : none ' onclick='return false'>"
													+ buginfo.bugId
													+ "</a>");
						    record.push("<div class='outer'> <div class='inner'><a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId="
													+ buginfo.bugId
													+ "&Template=view&TableId=1000'  target='view_window' title='"
													+buginfo.title+"'>"
													+ buginfo.title
													+ "</a></div> </div>");
						    record.push(buginfo.project);
						    record.push("<div class='outer'> <div class='inner component'>"+buginfo.component+" </div> </div>");
						    record.push("<div class='outer'> <div class='inner'>"+buginfo.owner+" </div> </div>");
						    record.push(
												   "<div class='outer'> <div class='inner'><label id=label_status_" + buginfo.id + ">"
													+ buginfo.status
													+ "</label></div> </div>");
							/*record.push("<button id=status_"
													+ buginfo.id
													+ " onclick= "
													+ "javascript:updateStatus('"
													+ buginfo.id
													+ "','"
													+ buginfo.bugId
													+ "') class='btn btn-default btn-sm'>update</button>");*/
						    ownerRecordList.push(record);
																						
						});
						
		if(ownerBugDataTable != null){
			ownerBugDataTable.fnDestroy();
			$('#ownerBugTable_wrapper').empty();		
		}
		

		/*
		 * Initialse DataTables, with no sorting on the 'details' column
		 */
		ownerBugDataTable = $('#ownerBugTable').dataTable( {
			"sDom": 'R<C>H<"clear"><"ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix"lfr>t<"ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix"i<"ownerButtonPlaceholder">p>',
			//"sDom": 'R<C><"ownerButtonPlaceholder">H<"clear">',
			"bProcessing": true,
			/* "bLengthChange":false,
			"bPaginate":false, */
			//"fnRowCallback":  truncatTextReder,
			"aoColumnDefs": [
				{ "bSortable": false, "aTargets": [ 0 ] }
			], 
			"aaSorting": [[1, 'asc']],
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"aaData": ownerRecordList,
			"aoColumns": [
	            { sWidth: '5%' ,"bSearchable": false },
	            { sWidth: '5%' },
	            { sWidth: '44%' },
	            /*null,*/
	            { sWidth: '1%',
	            "bVisible":    false  },
	            { sWidth: '15%' },
	            { sWidth: '10%' },
	            { sWidth: '10%' },
	           /* { sWidth: '10%',"bSearchable": false  }*/
	            ],
	            fnInitComplete: function ( oSettings )
	            {
	  	            	
	                for ( var i=0, iLen=oSettings.aoData.length ; i<iLen ; i++ )
	                {
	                	var bugId = oSettings.aoData[i].nTr.childNodes[1].childNodes[0].textContent;
	                	if ($.inArray(bugId,changedBugIDList) != -1){
	                		oSettings.aoData[i].nTr.className += " gradeX";
	                	}
	                    
	                }
	            }
		});
		
		ownerBugDataTable.rowGrouping({
			iGroupingColumnIndex:3,
			bExpandableGrouping: true,
		});
		
		ownerBugDataTable.makeEditable({
			sUpdateURL: function(value, settings)
			{
     			return(value); //Simulation of server-side response using a callback function
			},
			"aoColumns": 
			[
			  null,
			  null,
			  null,
			  {
			    cssclass:"required",
			  	indicator: 'Saving component...',
			  	tooltip: 'Double click to modify component',
			  	loadtext: 'loading...',
			  	 type: 'select',
			  	 onblur: 'submit',
			  	 data: "{'':'Please select...', 'None':'None','DDC-ADIdentity Service':'DDC-ADIdentity Service','DDC-Broker Service':'DDC-Broker Service','DDC-Configuration Service':'DDC-Configuration Service','DDC-Configuration Logging Service':'DDC-Configuration Logging Service','DDC-Delegated Admin Service':'DDC-Delegated Admin Service','DDC-Event Test Service':'DDC-Event Test Service','DDC-Host Service':'DDC-Host Service','DDC-Machine Creation Service':'DDC-Machine Creation Service','DDC-Scout(Taas)':'DDC-Scout(Taas)','VDA-Broker Agent(VDA)':'VDA-Broker Agent(VDA)','VDA-Machine Identity Service Agent':'VDA-Machine Identity Service Agent','HDX-ICA HostCore':'HDX-ICA HostCore','HDX-ICA Graphics':'HDX-ICA Graphics','HDX-ICA Integration':'HDX-ICA Integration','HDX-ICA IO':'HDX-ICA IO','HDX-ICA Multimedia':'HDX-ICA Multimedia','HDX-ICA Printing':'HDX-ICA Printing','HDX-ICA Packaging':'HDX-ICA Packaging','Director':'Director','Group Policy':'Group Policy','Studio':'Studio','Licensing':'Licensing','Monitoring Service':'Monitoring Service','StoreFront':'StoreFront','MetaInstaller':'MetaInstaller','AppV':'AppV','PVD':'PVD','PVS':'PVS'}",
			  	 sUpdateURL:  function(value, settings)
                        {
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
                        		var bugId=nTr.childNodes[index].childNodes[0].innerText;
                        		modifyTd=$(this);
                        		$.ajax({
									type : "put",
									url : "/BugTrackingSystem/api/bug?id="+id+"&bugId="+bugId+"&component="+value,
									success : function(data) {
										var html ="<div class='outer'> <div class='inner component' title='"+modifyTd.html()+"\nDouble click to modify!' >"+modifyTd.html()+" </div> </div>"
											modifyTd.html(html);
											alertify.log(data,"success");
									    		 //alert(data) ;  
									    		}
									});
                                return(value);
                        }
			  },
			  null,
			  null,
			  null
			]
		}); 
		
		$(".ownerButtonPlaceholder").html("<button id='updateAllOwnerListBtn' name='updateAllOwnerListBtn' style='margin-left : 15px' class='btn btn-default btn-nested' data-loading-text='Loading'>Update</button>");
		$(".ownerButtonPlaceholder").css("width","10%");
		$(".ownerButtonPlaceholder").css("float","right");
    }
    
    
    function loadDifferentTable(changedList){
		var  differentRecordList=[];
		
		$.each(changedList,
						function(i,
								warppedBuginfo) {
							var buginfo = warppedBuginfo.buginfo;
							var record=[];
							var dropDownMenu = '<div class="btn-group"><button class="btn btn-default btn-sm dropdown-toggle btn-action" type="button" data-toggle="dropdown"> Action <span class="caret"></span></button><ul class="dropdown-menu">';
							var endTag = '</ul></div>';
							var seperateLine = '<li class="divider"></li>';
							var radioName = "radio_"+buginfo.id + "_" + warppedBuginfo.managedBugId;
							var radioValueManage = "manage";
							var radioValueIgnore = "ignore";
							
							
							manageBtn = "<li><a href='javascript:void(0)'  name='"+radioName+"' value='"+radioValueManage+"'>Manage</a></li>";
							ignoreBtn = "<li><a href='javascript:void(0)'  name='"+radioName+"' value='"+radioValueIgnore+"'>Ignore</a></li>";
							record.push("<img src='assets/images/details_open.png' >");
							record.push("<a data-id="
													+ buginfo.id																				
													+ " style='text-decoration : none ' onclick='return false'>"
													+ buginfo.bugId
													+ "</a>");
							record.push("<div class='outer'> <div class='inner'><a href='http://onebug.citrite.net/tmtrack/tmtrack.dll?IssuePage&RecordId="
													+ buginfo.bugId
													+ "&Template=view&TableId=1000'  target='view_window' title='"
													+buginfo.title+"'>"
													+ buginfo.title
													+ "</a></div> </div>");
							record.push(buginfo.project);
							record.push("<div class='outer'> <div class='inner component'>"+buginfo.component+" </div> </div>");
							record.push("<div class='outer'> <div class='inner'>"+warppedBuginfo.newOwner+" </div> </div>");
							record.push("<div class='outer'> <div class='inner'>"+buginfo.status+" </div> </div>");
							//record.push("<label class='radio'><input type='radio' form='differentForm' name='radio_" + buginfo.id + "_" + warppedBuginfo.managedBugId + "' value='manage' \/\>manage</label>"
							//						+ "<label class='radio'><input type='radio' form='differentForm'  name='radio_" + buginfo.id + "_" + warppedBuginfo.managedBugId + "' value='ignore' \/\>ignore </label>");
							record.push(dropDownMenu+manageBtn+seperateLine+ignoreBtn+endTag);
							
							changedBugIDList.push(buginfo.bugId);
							differentRecordList.push(record);
							
						});
		
		if(differentBugDataTable != null){
			differentBugDataTable.fnDestroy();
			$('#differentBugTable_wrapper').empty();		
		}
		
		differentBugDataTable = $('#differentBugTable').dataTable( {
			"sDom": 'R<C>H<"clear"><"ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix"lfr>t<"ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix"i<"diffentButtonPlaceholder">p>',
			"bProcessing": true,
			/* "bLengthChange":false,
			"bPaginate":false, */
			//"fnRowCallback":  truncatTextReder,
			"aoColumnDefs": [
				{ "bSortable": false, "aTargets": [ 0 ] }
			], 
			"aaSorting": [[1, 'asc']],
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"aaData": differentRecordList,
			"aoColumns": [
	            { sWidth: '5%' ,"bSearchable": false },
	            { sWidth: '5%' },
	            { sWidth: '39%' },
	            { sWidth: '1%',
	            "bVisible":    false  },
	            { sWidth: '15%' },
	            { sWidth: '15%' },
	            { sWidth: '10%' },
	            { sWidth: '10%' ,"bSearchable": false  }
	            ]
		});
		
		differentBugDataTable.rowGrouping({
			iGroupingColumnIndex:3,
			bExpandableGrouping: true,
		});
		
		differentBugDataTable.makeEditable({
			sUpdateURL: function(value, settings)
			{
     			return(value); //Simulation of server-side response using a callback function
			},
			"aoColumns": 
			[
			  null,
			  null,
			  null,
			  {
			    cssclass:"required",
			  	indicator: 'Saving component...',
			  	tooltip: 'Double click to modify component',
			  	loadtext: 'loading...',
			  	 type: 'select',
			  	 onblur: 'submit',
			  	 data: "{'':'Please select...', 'None':'None','DDC-ADIdentity Service':'DDC-ADIdentity Service','DDC-Broker Service':'DDC-Broker Service','DDC-Configuration Service':'DDC-Configuration Service','DDC-Configuration Logging Service':'DDC-Configuration Logging Service','DDC-Delegated Admin Service':'DDC-Delegated Admin Service','DDC-Event Test Service':'DDC-Event Test Service','DDC-Host Service':'DDC-Host Service','DDC-Machine Creation Service':'DDC-Machine Creation Service','DDC-Scout(Taas)':'DDC-Scout(Taas)','VDA-Broker Agent(VDA)':'VDA-Broker Agent(VDA)','VDA-Machine Identity Service Agent':'VDA-Machine Identity Service Agent','HDX-ICA HostCore':'HDX-ICA HostCore','HDX-ICA Graphics':'HDX-ICA Graphics','HDX-ICA Integration':'HDX-ICA Integration','HDX-ICA IO':'HDX-ICA IO','HDX-ICA Multimedia':'HDX-ICA Multimedia','HDX-ICA Printing':'HDX-ICA Printing','HDX-ICA Packaging':'HDX-ICA Packaging','Director':'Director','Group Policy':'Group Policy','Studio':'Studio','Licensing':'Licensing','Monitoring Service':'Monitoring Service','StoreFront':'StoreFront','MetaInstaller':'MetaInstaller','AppV':'AppV','PVD':'PVD','PVS':'PVS'}",
			  	 sUpdateURL:  function(value, settings)
                        {
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
                        		var bugId=nTr.childNodes[index].childNodes[0].innerText;
                        		modifyTd=$(this);
                        		$.ajax({
									type : "put",
									url : "/BugTrackingSystem/api/bug?id="+id+"&bugId="+bugId+"&component="+value,
									success : function(data) {
										    
											var html ="<div class='outer'> <div class='inner component' title='"+modifyTd.html()+"\nDouble click to modify!' >"+modifyTd.html()+" </div> </div>"
											modifyTd.html(html);
											 alertify.log(data,"success");
									    		// alert(data) ;  
									    		}
									});
                                return(value);
                        }
			  },
			  null,
			  null,
			  null
			]
		
		}); 
		
		//$(".diffentButtonPlaceholder").html("<button id='modifyBtn' name='modifyBtn' class='btn btn-default btn-nested' style='margin-left : 15px' onclick='javascript:modifyBtnClick()' type='button' data-loading-text='Loading'>Modify</button>");
		//$(".diffentButtonPlaceholder").css("width","10%");
		//$(".diffentButtonPlaceholder").css("float","right");
    }
    
    function loadMainFrame(){
		$("#mainFrameJSPNav").addClass("active");

		$.ajax({
					type : "get",
					url : "/BugTrackingSystem/api/mainFrame",
					data : "",
					cache :false,
					success : function(data) {
						var dataObj = data;
						loadManagedTable(dataObj.managedList)
						loadDifferentTable(dataObj.changedList);
						loadOwnerTable(dataObj.ownerList);			
					},
					error : function(XMLHttpRequest,
							textStatus, errorThrown) {
					},

					complete : function(XMLHttpRequest,
							textStatus) {
						 $('.dataTable tbody td div.inner').each(function(index){
							    $this = $(this);
							    var titleVal = $this.text();
							    if (titleVal != '') {
							      $this.attr('title', titleVal);
							    }
							  });
						 $('.dataTable tbody td .component').each(function(index){
							    $this = $(this);
							    var titleVal = $this.text();
							    
							    if (titleVal != '') {
							      $this.attr('title', titleVal+'\n'+'Double click to modify!');
							    }
							  });
						/* $('.compoment').tooltip({
							 placement: 'top',
							  trigger: 'hover',
							  title: 'some title 1'
							}, 'tooltip1');*/
						 /*$('.compoment').tooltip({
							  placement: 'bottom',
							  trigger: 'hover',
							  title: 'some title 2'
							}, 'tooltip2');*/
					}
				});
    }
    
    
    function updateAllOwnerListClick(){
    	var updateAllOwnerListBtn = $("#updateAllOwnerListBtn");
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
								var bugId = anchor.textContent;
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
						$.each(dataObj,function(i,obj) {
											for ( var id in obj) {
												var newStatus = obj[id];
												var btn = $("#status_"
														+ id);
												btn.button('reset');
												$(
														"#label_status_"
																+ id)
														.text(
																newStatus);
											}
										});
						alertify.log("update succeed!","success");

					},

					error : function(
							XMLHttpRequest,
							textStatus, errorThrown) {
						alertify.log("updating error! Please try again","error");
						//alert("updating error! Please try again");
					},

					complete : function(
							XMLHttpRequest,
							textStatus) {
						updateAllOwnerListBtn
								.button('reset');
					}
				});

	
    }
    
    function updateAllManagedListBtn(){
    	var updateAllManagedListBtn = $("#updateAllManagedListBtn");
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
								var bugId = anchor.textContent;
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
						$.each(dataObj,function(i,
												obj) {
											for ( var id in obj) {
												var newStatus = obj[id];
												//alertify.log("update status!");
												var btn = $("#status_"
														+ id);
												btn.button('reset');
												$("#label_status_"+ id).text(newStatus);
											}
										});
						alertify.log("update succeed!","success");
					},

					error : function(
							XMLHttpRequest,
							textStatus, errorThrown) {
						alertify.log("updating error! Please try again","error");
						//alert("updating error! Please try again");
					},

					complete : function(
							XMLHttpRequest,
							textStatus) {
						updateAllManagedListBtn
								.button('reset');
					}
				});

	
    }
    
    function  ownerTableDetail(){

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
	
    function managedTableDetail(){

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
    
    function differentTableDetail(){

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
				this.src = "assets/images/details_open.png";
				differentBugDataTable.fnClose( nTr );
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
						differentBugDataTable.fnOpen( nTr, sOut, 'details' );
						
						}
					});
			}							
		
    }
    
    function ownerTableSearchHighlight(){
		clearInterval(ownerBugTimer);  
        
       if($('#ownerBugTableBody tr').find('td').hasHightlight()){
			  $('#ownerBugTableBody  tr').find('td').removeHighlight();
		}
		
       if ($(this).val() != "") {
          $('#ownerBugTableBody   tr').find('td').highlight($(this).val());
       }else {
    	   $('#ownerBugTableBody  tr').find('td').removeHighlight();
       }
      
       ownerBugTimer = setTimeout(function(){
	   $('#ownerBugTableBody  tr ').find('td').removeHighlight();}, 1000);
      
	
    }
   
    function managedTableSearchHighlight(){
		clearInterval(managedBugTimer);  
		if($('#managedBugTableBody  tr').find('td').hasHightlight()){
			  $('#managedBugTableBody  tr').find('td').removeHighlight();
		 }
		
        if ($(this).val() != "") {
            $('#managedBugTableBody tr').find('td').highlight($(this).val());
        }else {
        	$('#managedBugTableBody  tr').find('td').removeHighlight();
        }
        
        managedBugTimer = setTimeout(function(){
            $('#managedBugTableBody  tr').find('td').removeHighlight();}, 1000);
        
	
    }
    
    function differentTableSearchHighlight(){
		clearInterval(differentBugTimer);  
		if($('#differentBugTableBody  tr ').find('td:not(:last)').hasHightlight()){
			  $('#differentBugTableBody  tr ').find('td:not(:last)').removeHighlight();
		 }
		
        if ($(this).val() != "") {
            $('#differentBugTableBody  tr ').find('td:not(:last)').highlight($(this).val());
        }else {
        	$('#differentBugTableBody  tr').find('td:not(:last)').removeHighlight();
        }
        
        differentBugTimer = setTimeout(function(){
            $('#differentBugTableBody tr ').find('td:not(:last)').removeHighlight();}, 1000);
    }
    
    function windowResize(){
		 clearTimeout(window.refresh_size);
		 window.refresh_size = setTimeout(function() { update_size(); }, 150);
    }
   
	
	
		function  getBugInfoTable(bugInfo){
			var sOut = '<table class="detailTable col-lg-12" cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
			sOut += '<tr><td class="col-lg-1 detailFirstTd">Component:</td><td class="col-lg-11">'+bugInfo.component+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">BugId:</td><td>'+bugInfo.bugId+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">Title:</td><td>'+bugInfo.title+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">Project:</td><td>'+bugInfo.project+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">Type:</td><td>'+bugInfo.type+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">Status:</td><td>'+bugInfo.status+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">Description:</td><td>'+bugInfo.description+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">Owner:</td><td>'+bugInfo.owner+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">Submitter:</td><td>'+bugInfo.submitter+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">SubmitData:</td><td>'+bugInfo.submitData+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">Severity:</td><td>'+bugInfo.severity+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">Tags:</td><td>'+bugInfo.tags+'</td></tr>';
			sOut += '<tr><td class="detailFirstTd">Regression:</td><td>'+bugInfo.regression+'</td></tr>';									
			sOut += '</table>';
			return sOut;
	}

				       
	/*function modifyBtnClick() {
		var modifyBtn = $("#modifyBtn");
		var differentFrame = $("#differentForm");

		modifyBtn.button('loading');
		$.ajax({
			method : differentFrame.attr('method'),
			url : differentFrame.attr('action'),
			data : differentFrame.serialize(),
			cache : false,
			success : function(data) {
			    alertify.log(data,"success");
				//alert(data);
				window.location.reload();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {

			},

			complete : function(XMLHttpRequest, textStatus) {
				modifyBtn.button('reset');
			}
		});
	}*/
	
	function operateDifferntbugs (){
		var radioName=this.children[0].attributes['name'].value;
		var value=this.children[0].attributes['value'].value;
		var differentFrame = $("<form></form>");
		differentFrame.attr('action',"/BugTrackingSystem/api/bugs?method=put");
		differentFrame.attr('method','post');
		differentFrame.attr('name','differentForm');
		differentFrame.attr('id','differentForm');
		var input =  $("<input type='hidden' />");
		input.attr('name',radioName);
		input.attr('value',value);
		differentFrame.append(input);
		if(value=='manage'){
			alertify.log("loading,please wait","success");
		}
		$.ajax({
			method : differentFrame.attr('method'),
			url : differentFrame.attr('action'),
			data : differentFrame.serialize(),
			cache : false,
			success : function(data) {
				loadMainFrame();
			    alertify.log(data,"success");
			    
			    
			    
				//alert(data);
				//window.location.reload();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {

			},

			complete : function(XMLHttpRequest, textStatus) {
				
			}
		});
	}
	
	 $(document)
		.ready(
				function() {
											
					loadMainFrame();
					$(document).delegate('#updateAllOwnerListBtn','click',updateAllOwnerListClick);
					$(document).delegate('#updateAllManagedListBtn','click',updateAllManagedListBtn);
					$(document).delegate('#ownerBugTable tbody td img','click',ownerTableDetail);
					$(document).delegate('#managedBugTable tbody td img','click',managedTableDetail);
					$(document).delegate('#differentBugTable tbody td img','click',differentTableDetail );
					$(document).delegate('#ownerBugTable_filter input','keyup',ownerTableSearchHighlight);
					$(document).delegate('#managedBugTable_filter input','keyup',managedTableSearchHighlight);
					$(document).delegate('#differentBugTable_filter input','keyup',differentTableSearchHighlight );
					$(document).delegate('.dataTable .dropdown-menu li','click',operateDifferntbugs );
					$(window).resize(windowResize);
					
		});
	