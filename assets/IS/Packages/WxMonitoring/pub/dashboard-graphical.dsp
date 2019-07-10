<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
		<title>Dashboard</title>
		<link rel="stylesheet" type="text/css" href="webMethods.css">
		<!-- <link rel="stylesheet" type="text/css" href="bar-pie-graph.css">
		<link rel="stylesheet" type="text/css" href="indented-tree.css">
		<link rel="stylesheet" type="text/css" href="nodal-Tree.css"> -->
		<link rel="stylesheet" type="text/css" href="dashboard.css">
		<script src="webMethods.js.txt"></script>
		<script src="common-navigation.js"></script>
        <script src="dashboard.js"></script>
		
		
		<script src="indented-tree-d3_v4_min.js"></script>
		<script>
				d3version4 = d3
				window.d3 = null
			  </script>
		<script src="bar-pie-graph-d3_v3_min.js"></script>
		<script>
				d3version3 = d3
				window.d3 = null
			  </script>
		<script src="bar-pie-graph.js"></script>
		
		<script src="indented-tree.js"></script>
		<script src="nodal-tree.js"></script>
        <script>

			function createPageState(processTimeUIControlsJson, eventTimeUIControlsJson) {
				var stateJSONObject = {};
				stateJSONObject.currentPageName = "dashboard-graphical.dsp";
				stateJSONObject.previousPageName = "dashboard.dsp";
				stateJSONObject.processTimeUIControlsJson = processTimeUIControlsJson;
				stateJSONObject.eventTimeUIControlsJson = eventTimeUIControlsJson;
				
				return stateJSONObject;
			}

			function onSwitchDashboardClick() {
				
				var currentPageState = getPageState("dashboard-graphical.dsp");
				
				var previousPageState =  getPageState(currentPageState.previousPageName);
				cleanNavigationSequence();
				if(previousPageState){
					var url = "dashboard.dsp?processTimeRange=" + previousPageState.processTimeRange + "&eventTimeRange=" + previousPageState.eventTimeRange + "&processBusinessDomain=" + previousPageState.processBusinessDomain + "&eventServer=" + previousPageState.eventServer ;
				} else {
					var url = "dashboard.dsp";
				}
				var res = encodeURI(url);
				
				location.href = url;
			}

			function populateForm(form, clickSource){
				
				var currentPageState = getPageState("dashboard-graphical.dsp");
				var processTimeUIControlsJsonString = currentPageState.processTimeUIControlsJson ;
				var eventTimeUIControlsJsonString = currentPageState.eventTimeUIControlsJson ;
				//alert(processTimeUIControlsJsonString);
				
				if(clickSource=="process"){

					var processTimeUIControlsJson = JSON.parse(processTimeUIControlsJsonString);
					
					processTimeUIControlsJson.timeRange = document.getElementById("processTimeRange").value;
					processTimeUIControlsJsonString = JSON.stringify(processTimeUIControlsJson);
				} else if(clickSource=="event"){
					var eventTimeUIControlsJson = JSON.parse(eventTimeUIControlsJsonString);
					
					eventTimeUIControlsJson.timeRange = document.getElementById("eventTimeRange").value;
					eventTimeUIControlsJsonString = JSON.stringify(eventTimeUIControlsJson);
				}

				form.processTimeUIControlsJson.value = processTimeUIControlsJsonString;
				form.eventTimeUIControlsJson.value = eventTimeUIControlsJsonString;
				
				form.submit();
			}

            function toggleCtrl_TimeRange(toggleSource) {
				var selTimeRange,
					tdFromDate,
					tdToDate,
					tdFromTime,
					tdToTime;

					
				if(toggleSource=="event"){

					selTimeRange = document.getElementById("eventTimeRange");
					tdFromDate = document.getElementById("eventCustomFromDateTD");
					tdToDate = document.getElementById("eventCustomToDateTD");
					tdFromTime = document.getElementById("eventCustomFromTimeTD");
					tdToTime = document.getElementById("eventCustomToTimeTD");					
					
				} else if(toggleSource=="process"){
					selTimeRange = document.getElementById("processTimeRange");
					tdFromDate = document.getElementById("processCustomFromDateTD");
					tdToDate = document.getElementById("processCustomToDateTD");
					tdFromTime = document.getElementById("processCustomFromTimeTD");
					tdToTime = document.getElementById("processCustomToTimeTD");		
				}
				
				if (selTimeRange.value == 'custom') {
					//enable all custom ctrls 
					tdFromDate.removeAttribute('readonly');
					tdToDate.removeAttribute('readonly');
					tdFromTime.removeAttribute('readonly');
					tdToTime.removeAttribute('readonly');
					tdFromDate.style.display = "";
					tdToDate.style.display = "";
					tdFromTime.style.display = "";
					tdToTime.style.display = "";
					
				} else {
					//set all custom ctrls readonly
					tdFromDate.setAttribute('readonly', 'readonly');
					tdToDate.setAttribute('readonly', 'readonly');
					tdFromTime.setAttribute('readonly', 'readonly');
					tdToTime.setAttribute('readonly', 'readonly');
					tdFromDate.style.display = "none";
					tdToDate.style.display = "none";
					tdFromTime.style.display = "none";
					tdToTime.style.display = "none";
				}   
            }
		</script>
		<style>
			
		</style>
    </head>
    <body>
		%invoke wx.monitoring.services.gui.dashboard:getDashboardGraphical%
		%endinvoke%

		<script>

			var stateJSONObject = createPageState('%value dashboard/processes/uiTimeControlsInfoJSON encode(javascript)%','%value dashboard/events/uiTimeControlsInfoJSON encode(javascript)%');
					
			var startNewNavigationSequence = true;
			savePageState("dashboard-graphical.dsp", stateJSONObject, startNewNavigationSequence);
			
		</script>
		<table width=100%>
			<tr>
				<td class="breadcrumb" colspan="2">
					<table width="100%">
						<tr>
							<td>
								<div align="left">
									Dashboard
								</div>
							</td>
							<td>
								<div align="right">
									<img src="images/%value dashboard/common/serverLight/es encode(html)%-ball.gif">Elastic Search</img>
									<img src="images/%value dashboard/common/serverLight/logstash encode(html)%-ball.gif">Logstash</img>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<table border="0">
			<tr>
				<td colspan="2">
					<ul class="listitems">
						<li class="listitem"><a href="#" onclick="onSwitchDashboardClick();">Switch to Non-Graphical View</a></li>
					</ul>
				</td>
			</tr>
		</table>
		%scope dashboard%
			<!-- %rename ../timeRange timeRange -copy%
			%rename ../fromCustomDate fromDate -copy%
			%rename /fromCustomTime fromTime -copy%
			%rename /toCustomDate toDate -copy%
			%rename /toCustomTime toTime -copy% -->

			%scope common%
			<div class="flex-container-content">
				<div width="50%" class="flex-container-column">
					<table border="0"  width="100%" class="tableView">
						<tr>
							<td colspan="1" class="heading">List of Processes - By Server, Business Domain</td>
						</tr>
						%ifvar processServerIndentedTreeJSON -notempty%
						<tr>
							<td style="border: 0px;padding: 0px">
									<div id="processServerStructure_tree" class="flex-container-item"></div>
							</td>
							<script>
								var processServerStructureString = '%value processServerIndentedTreeJSON encode(javascript)%' ;
								//alert(processServerStructureString);
								var processServerStructureJson = JSON.parse(processServerStructureString);
								createTree("#processServerStructure_tree",processServerStructureJson);
							</script>
						</tr>
						%else%
						<tr class="field" align="left">
								<td colspan=7 class="oddrowdata-l">---------------------------------- no results ----------------------------------</td>
						</tr>
						%endifvar%
					</table>
				%endscope%
				%scope processes%
					<table border="0"  width="100%" class="tableView">
						%scope uiTimeControlsInfo%
							<tr>
								<td colspan="4" class="heading">Processes Summary- By Business Domain | From : %value consolidatedFromTime encode(html)% | To : %value consolidatedToTime encode(html)% </td>
							</tr>
							<tr>
								<td style="background: #D3D3D3" rowspan="2">
									<label>Time Range : </label>
									<select id="processTimeRange" name="processTimeRange"
									onchange="toggleCtrl_TimeRange('process')">
										<option value="today" %ifvar timeRange% %ifvar timeRange equals('today')%selected %endifvar% %else% selected %endifvar%>Today
										</option>
										<option value="lastSevenDays" %ifvar timeRange equals('lastSevenDays')%selected %endifvar%>Past 7 days</option>
										<option value="lastFifteenDays" %ifvar timeRange equals('lastFifteenDays')%selected %endifvar%>Past 15 days</option>
										<option value="lastThirtyDays" %ifvar timeRange equals('lastThirtyDays')%selected %endifvar%>Past 30 days</option>
										<option value="ALL" %ifvar timeRange equals('ALL')%selected %endifvar%>ALL</option>
										<option value="custom" %ifvar timeRange equal ('custom') %selected %endifvar%>Custom</option>
									</select>
								</td>
								<td id="processCustomFromDateTD" style="display: none; background: #D3D3D3">
									<label>Start Date : </label>
									<input id="processCustomFromDate" type="date" name="processCustomFromDate"
									value="%value fromDate%" />
								</td>
								<td id="processCustomToDateTD" style="display: none;background: #D3D3D3">
									<label>End Date : </label>
									<input id="processCustomToDate" type="date" name="processCustomToDate"
									value="%value toDate%" />
								</td>
								<td style="background: #D3D3D3" rowspan="2">
									<input type="button" value="Refresh" onclick="populateForm(document.htmlform_dashboardGraphical,'process');">
								</td>
							</tr>
							<tr>
								<td id="processCustomFromTimeTD" style="display: none; background: #D3D3D3">
									<label>Start Time : </label>
									<input id="processCustomFromTime" type="time" name="processCustomToDate"
									value="%value fromTime%" />
								</td>
								<td id="processCustomToTimeTD" style="display: none;background: #D3D3D3">
									<label>End Time : </label>
									<input id="processCustomToDate" type="time" name="processCustomToDate"
									value="%value toTime%" />
								</td>
							</tr>
						%endscope%
						%ifvar barPieGraphJSON -notempty%
						<tr>
							<td colspan="5" style="border: 0px;padding: 0px;">

									<div id="processStats_barPieGraph" class="flex-container-item"></div>
							</td>
							<script>
								var processStatsString = '%value barPieGraphJSON encode(javascript)%' ;
								var processStatsBarPieJson = JSON.parse(processStatsString);
								createGraph("#processStats_barPieGraph", processStatsBarPieJson,"process")
							</script> 
						</tr>
						%else%
							<tr class="field" align="left">
									<td colspan=7 class="oddrowdata-l">---------------------------------- no results ----------------------------------</td>
							</tr>
						%endifvar%
					</table>
				%endscope%	
				</div>
				<div class="flex-container-column">
						%scope events%
						<table border="0"  width="100%" class="tableView">
								%scope uiTimeControlsInfo%
									<tr>
										<td colspan="4" class="heading">Events Summary- By Server | From : %value consolidatedFromTime encode(html)% | To : %value consolidatedToTime encode(html)% </td>
									</tr>
									<tr>
										<td style="background: #D3D3D3" rowspan="2">
											<label>Time Range : </label>
											<select id="eventTimeRange" name="eventTimeRange"
											onchange="toggleCtrl_TimeRange('event')">
												<option value="today" %ifvar timeRange% %ifvar timeRange equals('today')%selected %endifvar% %else% selected %endifvar%>Today
												</option>
												<option value="lastSevenDays" %ifvar timeRange equals('lastSevenDays')%selected %endifvar%>Past 7 days</option>
												<option value="lastFifteenDays" %ifvar timeRange equals('lastFifteenDays')%selected %endifvar%>Past 15 days</option>
												<option value="lastThirtyDays" %ifvar timeRange equals('lastThirtyDays')%selected %endifvar%>Past 30 days</option>
												<option value="ALL" %ifvar timeRange equals('ALL')%selected %endifvar%>ALL</option>
												<option value="custom" %ifvar timeRange equal ('custom') %selected %endifvar%>Custom</option>
											</select>
										</td>
										<td id="eventCustomFromDateTD" style="display: none; background: #D3D3D3">
											<label>Start Date : </label>
											<input id="eventCustomFromDate" type="date" name="eventCustomFromDate"
											value="%value customFromDate%" />
										</td>
										<td id="eventCustomToDateTD" style="display: none;background: #D3D3D3">
											<label>End Date : </label>
											<input id="eventCustomToDate" type="date" name="eventCustomToDate"
											value="%value customToDate%" />
										</td>
										<td style="background: #D3D3D3" rowspan="2">
											<input type="button" value="Refresh" onclick="populateForm(document.htmlform_dashboardGraphical,'event');">
										</td>
									</tr>
									<tr>
										<td id="eventCustomFromTimeTD" style="display: none; background: #D3D3D3">
											<label>Start Time : </label>
											<input id="eventCustomFromTime" type="time" name="eventCustomToDate"
											value="%value customFromDate%" />
										</td>
										<td id="eventCustomToTimeTD" style="display: none;background: #D3D3D3">
											<label>End Time : </label>
											<input id="eventCustomToDate" type="time" name="eventCustomToDate"
											value="%value customFromDate%" />
										</td>
									</tr>
								%endscope%
								%ifvar barPieGraphJSON -notempty%
								<tr>
									<td colspan="4" style="border: 0px;padding: 0px;">
	
											<div id="processStats_barPieGraph1" class="flex-container-item"></div>
									</td>
									<script>
										var processStatsString1 = '%value barPieGraphJSON encode(javascript)%' ;
										
										var processStatsBarPieJson1 = JSON.parse(processStatsString1);
										createGraph("#processStats_barPieGraph1", processStatsBarPieJson1,"event")
									</script> 
								</tr>
								%else%
									<tr class="field" align="left">
										<td colspan=7 class="oddrowdata-l">---------------------------------- no results ----------------------------------</td>
									</tr>
								%endifvar%
							</table>
						%endscope%
						%scope common%
					<div class="flex-container-item">
						%ifvar monitoredLogfileNodalTreeJSON -notempty%
							<div id="processServerStructure_tree1" ></div>	
							<script>
								//var dataString = '{"children":[{"children":[{"children":[{"name":"AgglomerativeCluster","value":3938},{"name":"CommunityStructure","value":3812},{"name":"HierarchicalCluster","value":6714},{"name":"MergeEdge","value":743}],"name":"cluster"},{"children":[{"name":"BetweennessCentrality","value":3534},{"name":"LinkDistance","value":5731},{"name":"MaxFlowMinCut","value":7840},{"name":"ShortestPaths","value":5914},{"name":"SpanningTree","value":3416}],"name":"graph"},{"children":[{"name":"AspectRatioBanker","value":7074}],"name":"optimization"}],"name":"analytics"}],"name":"flare"}';
		
								var dataString = '%value monitoredLogfileNodalTreeJSON encode(javascript)%' ;
								var data = JSON.parse(dataString);
								createNodalTree("#processServerStructure_tree1",data);
							</script>
						%else%
								<div align="left">---------------------------------- no results ----------------------------------</div>
						%endifvar%	
					</div>
						%endscope%
				</div>
			</div> 
		%endscope%
		<form name="htmlform_dashboardGraphical" action="dashboard-graphical.dsp" method="POST">
				<input type="hidden" name="processTimeUIControlsJson">
				<input type="hidden" name="eventTimeUIControlsJson">
		</form>
    </body>
        <!-- POST page load -->
	<script language="JavaScript">
        //toggleCtrl_TimeRange()
    </script>
</html>