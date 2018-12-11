<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
		<title>Dashboard</title>
		<link rel="stylesheet" type="text/css" href="webMethods.css">
		<script src="webMethods.js.txt"></script>
		<script SRC="common-navigation.js"></script>
		<script language="JavaScript">
			
			function populateProcessForm(form, businessDomain, server, processStatus){
				
				var fromTimeStr = document.getElementById('processFromTime').value;
				var toTimeStr  = document.getElementById('processToTime').value;
				//alert(fromTimeStr);
				var fromDateValueStr = extractDateStamp(fromTimeStr);
				var toDateValueStr = extractDateStamp(toTimeStr);
				
				var fromTimeValueStr = extractTimeTillMinutes(fromTimeStr);
				var toTimeValueStr = extractTimeTillMinutes(toTimeStr);
				
				form.fromDateValue.value = fromDateValueStr;
				form.toDateValue.value = toDateValueStr;
				form.fromTimeValue.value = fromTimeValueStr;
				form.toTimeValue.value = toTimeValueStr;
				form.server.value = server;
				form.businessDomain.value = businessDomain;
				form.processStatus.value = processStatus;
				
				//form.processTimeRange.value = document.getElementById('dashboardProcessTimeRange').value;
				//form.eventTimeRange.value = document.getElementById('dashboardeventTimeRange').value;
				//form.processBusinessDomain.value = document.getElementById('dashboardprocessBusinessDomain').value;
				//form.eventServer.value = document.getElementById('dashboardeventServer').value;

				return true;
			}
			
						
			function populateEventForm(form, searchIdentifier, searchID, eventSeverityValue, filterEventsWithNoAction){
			//searchIdentifier = which table (server or date) is clicked i.e. searchID = server name or date.
				form.severity.value = eventSeverityValue;
				form.filterEventsWithNoAction.value = filterEventsWithNoAction;
				if(searchIdentifier == "server" ){
					form.logFile.value = "ALL";
					
					var fromTimeStr = document.getElementById('eventFromTime').value;
					var toTimeStr  = document.getElementById('eventToTime').value;
					
					var fromDateValueStr = extractDateStamp(fromTimeStr);
					var toDateValueStr = extractDateStamp(toTimeStr);
					
					var fromTimeValueStr = extractTimeTillMinutes(fromTimeStr);
					var toTimeValueStr = extractTimeTillMinutes(toTimeStr);
					
					form.fromDateValue.value = fromDateValueStr;
					form.toDateValue.value = toDateValueStr;
					form.fromTimeValue.value = fromTimeValueStr;
					form.toTimeValue.value = toTimeValueStr;
					
					if(searchID == "ALL") {
						form.server.value = "ALL"; //redundant but intuitive.
					}else{
						form.server.value = searchID;
					}
					
				}else if (searchIdentifier == "logFile" ) {
				
					var fromTimeStr = document.getElementById('eventFromTime').value;
					var toTimeStr  = document.getElementById('eventToTime').value;
					
					var fromDateValueStr = extractDateStamp(fromTimeStr);
					var toDateValueStr = extractDateStamp(toTimeStr);
					
					var fromTimeValueStr = extractTimeTillMinutes(fromTimeStr);
					var toTimeValueStr = extractTimeTillMinutes(toTimeStr);
					
					form.fromDateValue.value = fromDateValueStr;
					form.toDateValue.value = toDateValueStr;
					form.fromTimeValue.value = fromTimeValueStr;
					form.toTimeValue.value = toTimeValueStr;
					
					if(searchID == "ALL") {
						form.logFile.value = "ALL"; //redundant but intuitive.
					}else{
						form.logFile.value = searchID;
					}
				} else {
					if(searchID == "ALL") {
						var fromTimeStr = document.getElementById('eventFromTime').value;
						var toTimeStr  = document.getElementById('eventToTime').value;
						
						var fromDateValueStr = extractDateStamp(fromTimeStr);
						var toDateValueStr = extractDateStamp(toTimeStr);
						
						var fromTimeValueStr = extractTimeTillMinutes(fromTimeStr);
						var toTimeValueStr = extractTimeTillMinutes(toTimeStr);
						
						form.fromDateValue.value = fromDateValueStr;
						form.toDateValue.value = toDateValueStr;
						form.fromTimeValue.value = fromTimeValueStr;
						form.toTimeValue.value = toTimeValueStr;
					} else {
					
						var fromTimeStr = document.getElementById('eventFromTime').value;
						var toTimeStr  = document.getElementById('eventToTime').value;
						
						var fromDateValueStr = extractDateStamp(searchID);
						var toDateValueStr = extractDateStamp(searchID);
						
						var fromTimeValueStr = extractTimeTillMinutes(fromTimeStr);
						var toTimeValueStr = extractTimeTillMinutes(toTimeStr);

						if(fromDateValueStr==searchID){
							form.fromDateValue.value = searchID;
							form.fromTimeValue.value = fromTimeValueStr;
							form.toDateValue.value = searchID;
							form.toTimeValue.value = "23:59";
						} else if(toDateValueStr==searchID){
							form.fromDateValue.value = searchID;
							form.fromTimeValue.value = "00:00";
							form.toDateValue.value = searchID;
							form.toTimeValue.value = toTimeValueStr;
						}else {
							form.fromDateValue.value = searchID;
							form.fromTimeValue.value = "00:00";
							form.toDateValue.value = searchID;
							form.toTimeValue.value = "23:59";
						}
					}
				}
				return true;
			}
			
			function manageProcessAndEventRefresh(form, operation, arg1, arg2, refreshSource){

				if(refreshSource == "event") {
					var processTimeRangeValue = arg1;
					var processBusinessDomainValue = arg2;
					
					form.processTimeRange.value = processTimeRangeValue;
					form.processBusinessDomain.value = processBusinessDomainValue;
					form.eventTimeRange.value = document.getElementById('selEventTimeRange').value;
					form.eventServer.value = document.getElementById('selServer').value;
				} else {
					var eventTimeRangeValue = arg1;
					var eventServerValue = arg2;
					
					form.processTimeRange.value = document.getElementById('selProcessTimeRange').value;
					form.processBusinessDomain.value = document.getElementById('selBusinessDomain').value;
					form.eventTimeRange.value = eventTimeRangeValue;
					form.eventServer.value = eventServerValue;
				}
				
				form.submit();
				return true;

			}
			
			function concatDateAndTime(date, time){
				var dateTimeString = date + " " + time + ":00";
				return dateTimeString;
			}
			
			function extractDateStamp(dateTimeString){
				var dateTime = new Date(dateTimeString);
				var day = dateTime.getDate(); //Date of the month: 2 in our example
				if(day < 10){
					day = "0" + day;
				}
				var month = dateTime.getMonth(); //Month of the Year: 0-based index, so 1 in our example
				month = month + 1;
				if(month < 10){
					month = "0" + month;
				}
				var year = dateTime.getFullYear()
				var dateStamp = year + "-" + month + "-" + day;
				
				return dateStamp;
			}
			
			function extractTimeTillMinutes(dateTimeString){
				var dateTime = new Date(dateTimeString);
				var hours = dateTime.getHours(); //Date of the month: 2 in our example
				if(hours < 10){
					hours = "0" + hours;
				}
				var minutes = dateTime.getMinutes(); //Month of the Year: 0-based index, so 1 in our example
				if(minutes < 10){
					minutes = "0" + minutes;
				}
				var year = dateTime.getFullYear()
				var timestamp = hours + ":" + minutes;
				
				return timestamp;
			}
			
			function AddProcesses(total, active, completed, exception, failed, cancelled){
			
			if(total)
			{
			var currentTotalSum = document.getElementById("allTotal").value;
			currentTotalSum = parseInt(currentTotalSum) + parseInt(total);
			document.getElementById("allTotal").value = currentTotalSum;
			}
			
			if(active){
			var currentActiveSum = document.getElementById("allActive").value;
			currentActiveSum = parseInt(currentActiveSum) + parseInt(active);
			document.getElementById("allActive").value = currentActiveSum;
			}
			
			if(completed){
			var currentCompletedSum = document.getElementById("allCompleted").value;
			currentCompletedSum = parseInt(currentCompletedSum) + parseInt(completed);
			document.getElementById("allCompleted").value = currentCompletedSum;
			}
			
			if(exception){
			var currentExceptionSum = document.getElementById("allException").value;
			currentExceptionSum = parseInt(currentExceptionSum) + parseInt(exception);
			document.getElementById("allException").value = currentExceptionSum;
			}
			
			if(failed || exception){
			var currentFailedSum = document.getElementById("allFailed").value;
			if(failed){
			currentFailedSum = parseInt(currentFailedSum) + parseInt(failed);
			}
			if(exception){
				currentFailedSum = parseInt(currentFailedSum) + parseInt(exception) ;
			}
			document.getElementById("allFailed").value = currentFailedSum;
			}
			
			if(cancelled){
			var currentCancelledSum = document.getElementById("allCancelled").value;
			currentCancelledSum = parseInt(currentCancelledSum) + parseInt(cancelled);
			document.getElementById("allCancelled").value = currentCancelledSum;
			}
			}
			
			function writeAttributeValue(myAttributeID){
				var myAttributeValue =  document.getElementById(myAttributeID).value;
				myAttributeValue = myAttributeValue.bold();
				document.write(myAttributeValue);
				document.getElementById(myAttributeID).value = "0";
			}
			
			function writeFailedProcessesCount(exceptionCount, failedCount){
				var myAttributeValue =  0;
			
				if(exceptionCount || failedCount){
				
					if(failedCount){
						myAttributeValue = parseInt(myAttributeValue) + parseInt(failedCount);
					}
					if(exceptionCount){
						myAttributeValue = parseInt(myAttributeValue) + parseInt(exceptionCount) ;
					}
				} else {
					myAttributeValue = "-";
				}
				
				document.write(myAttributeValue);
				
			}
			
			function createPageState(processTimeRange, eventTimeRange, processBusinessDomain, eventServer) {
				var stateJSONObject = {};
				stateJSONObject.currentPageName = "dashboard.dsp";
				stateJSONObject.previousPageName = "";
				stateJSONObject.processTimeRange = processTimeRange;
				stateJSONObject.eventTimeRange = eventTimeRange;
				stateJSONObject.processBusinessDomain = processBusinessDomain;
				stateJSONObject.eventServer = eventServer;
				
				return stateJSONObject;
			}
		</script>
	</head>
	
	<body>
		<table width="99%">
		%invoke wx.monitoring.services.gui.dashboard:getDashboard%
			%ifvar message%
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
			%endif%
			%ifvar onerror%
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
			%endif%
		%endinvoke%
			<script>
					var stateJSONObject = createPageState('%value /processTimeRange encode(javascript)%','%value /eventTimeRange encode(javascript)%','%value /processBusinessDomain encode(javascript)%','%value /eventServer encode(javascript)%');
					
					var startNewNavigationSequence = true;
					savePageState("dashboard.dsp", stateJSONObject, startNewNavigationSequence);				
			</script>
			<form name="htmlform_process_common">
				<input type="hidden" id="allTotal" name="allTotal" value="0">
				<input type="hidden" id="allActive" name="allActive" value="0">
				<input type="hidden" id="allCompleted" name="allCompleted" value="0">
				<input type="hidden" id="allException" name="allException" value="0">
				<input type="hidden" id="allFailed" name="allFailed" value="0">
				<input type="hidden" id="allCancelled" name="allCancelled" value="0">		
			</form>
			<form name="htmlform_processes_specific" action="processes-specific.dsp" method="POST">
				<input type="hidden" name="fromDateValue">
				<input type="hidden" name="toDateValue">
				<input type="hidden" name="fromTimeValue">
				<input type="hidden" name="toTimeValue">
				<input type="hidden" name="server">
				<input type="hidden" name="processStatus">
				<input type="hidden" name="businessDomain">
			</form>
			<form name="htmlform_events_specific" action="events-specific.dsp" method="POST">
				<input type="hidden" name="fromDateValue">
				<input type="hidden" name="toDateValue">
				<input type="hidden" name="fromTimeValue">
				<input type="hidden" name="toTimeValue">
				<input type="hidden" name="server" value="%value eventServer encode(htmlattr)%">
				<input type="hidden" name="severity">
				<input type="hidden" name="logFile">
				<input type="hidden" name="filterEventsWithNoAction">
				<input type="hidden" name="compareSeverityExactly" value="true">
			</form>
			<form name="htmlform_dashboard_Stats_general" action="dashboard.dsp" method="Post">
				<input type="hidden" name="processTimeRange">
				<input type="hidden" name="eventTimeRange">
				<input type="hidden" name="processBusinessDomain">
				<input type="hidden" name="eventServer">
				<input type="hidden" name="refreshSource">
			</form>
			<tr>
				<td class="breadcrumb" colspan="2">Dashboard</td>
			</tr>
			
%invoke wx.monitoring.services.gui.common:getAllBusinessDomainsNames%
%endinvoke%

%invoke wx.monitoring.services.gui.common:getAllServerNames%
%endinvoke%
			
%scope dashboard%
	%rename ../businessDomains businessDomains -copy%
	%rename ../serverNames serverNames -copy%
	%rename /processTimeRange processTimeRange -copy%
	%rename /eventTimeRange eventTimeRange -copy%
	%rename /processBusinessDomain processBusinessDomain -copy%
	%rename /eventServer eventServer -copy%
			<tr>
				<td>
					<table class="customTable" width="100%" border="0">
						<tr>
							<td valign="top">
								<table>
									<tr>
										<td valign="top">
											<table width="50%" border="1" class="tableView">
												
												<tr>
													<td nowrap colspan=3 class="heading">
														Processes Dashboard Controls
													</td>
												</tr>
												<tr>
													<td nowrap class="oddrow"> 
														Time Range
														<select id="selProcessTimeRange" name="processTimeRange">
															<option value="today" %ifvar processTimeRange% %ifvar processTimeRange equals('today')%selected %endifvar% %else% selected %endifvar%>Today</option>
															<option value="lastSevenDays" %ifvar processTimeRange equals('lastSevenDays')%selected %endifvar%>Past 7 days</option>
															<option value="lastFifteenDays" %ifvar processTimeRange equals('lastFifteenDays')%selected %endifvar%>Past 15 days</option>
															<option value="lastThirtyDays" %ifvar processTimeRange equals('lastThirtyDays')%selected %endifvar%>Past 30 days</option>
															<option value="ALL" %ifvar processTimeRange equals('ALL')%selected %endifvar%>All</option>
														</select>
													</td>
													<td nowrap class="oddrow"> 
														Business Domain
														<select id="selBusinessDomain" name="processBusinessDomain">	
%loop businessDomains%
															<option value="%value fullName encode(htmlattr)%" %ifvar /businessDomain vequals(fullName)%selected %endifvar%>%value beautifiedName encode(html)%</option>
%endloop%
															<option value="ALL" %ifvar /businessDomain% %ifvar /businessDomain equals('ALL')% selected %endifvar% %else% selected %endifvar%>All</option>
														</select>
													</td>
													<td nowrap class="oddrow">
														<input type="submit" VALUE="Refresh" onClick="return manageProcessAndEventRefresh(htmlform_dashboard_Stats_general, 'displayGeneral','%value eventTimeRange encode(htmlattr)%','%value eventServer encode(htmlattr)%', 'process');">
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr><td><img border="0" src="images/blank.gif" width="10" height="20"></td></tr>

	%scope processes%
									<tr>
										<td valign="top"> 
											<input type="hidden" id="processFromTime" name="fromTime" value="%value fromTime encode(htmlattr)%">
											<input type="hidden" id="processToTime" name="toTime" value="%value toTime encode(htmlattr)%">
											<table width="100%" border="1" class="tableView">
												<tr>
													<td colspan="6" class="heading">Processes Summary- By Business Domain | From : %value fromTime encode(html)% | To : %value toTime encode(html)% </td>
												</tr>
												<tr class="subheading2">
													<td nowrap class="datacenter">Business Domain</td>
													<td nowrap class="datacenter">Total</td>
													<td nowrap class="datacenter">Active</td>
													<td nowrap class="datacenter">Completed</td>
													<td nowrap class="datacenter">Failed</td>
													<td nowrap class="datacenter">Cancelled</td>
												</tr>
		%ifvar processStatsBusinessDomainStatus%
			%loop processStatsBusinessDomainStatus%
			
												<tr>
													<td class="keyrowdata"> %value key% </td>
													<td class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific, '%value key encode(javascript)%', 'ALL', 'ALL');">
															%value count encode(html)%
														</a> 
													</td>
													<td nowrap class="evenrowdata">
								
				%ifvar startedBucket/count -notempty%
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value key encode(javascript)%', 'ALL','started');">
															%value startedBucket/count encode(html)%
														</a>
				%else%
														-
				%endifvar%
													</td>
													<td nowrap class="evenrowdata">
								
				%ifvar completedBucket/count -notempty%
				
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value key encode(javascript)%', 'ALL','completed');">
															%value completedBucket/count encode(html)%
														</a>
				%else%
														-
				%endifvar%
													</td>
													<td nowrap class="evenrowdata">
				%ifvar exceptionBucket/count -notempty%
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value key encode(javascript)%', 'ALL','failed');">
															<script> writeFailedProcessesCount('%value exceptionBucket/count encode(javascript)%', '%value failedBucket/count encode(javascript)%'); </script>
														</a>
								
				%else%
					%ifvar failedBucket/count -notempty%
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value key encode(javascript)%', 'ALL','failed');">
															<script> writeFailedProcessesCount('%value exceptionBucket/count encode(javascript)%', '%value failedBucket/count encode(javascript)%'); </script>
														</a>
					%else%
														-
					%endifvar%
				%endifvar%
													</td>
													<td nowrap class="evenrowdata">
				%ifvar cancelledBucket/count -notempty%
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value key encode(javascript)%', 'ALL','cancelled');">
															%value cancelledBucket/count encode(html)%
														</a>
				%else%
														-
				%endifvar%
													</td>
					%ifvar ../../processBusinessDomain equals('ALL')%
						<script>
							AddProcesses('%value count encode(javascript)%', '%value startedBucket/count encode(javascript)%', '%value completedBucket/count encode(javascript)%', '%value exceptionBucket/count encode(javascript)%', '%value failedBucket/count encode(javascript)%', '%value cancelledBucket/count encode(javascript)%' );
						</script>
					%endifvar%												</tr>
			%endloop%
					%ifvar ../processBusinessDomain equals('ALL')%
												<tr>
													<td nowrap class="keyrowdata-b">ALL</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'ALL', 'ALL','ALL');">
															<script> writeAttributeValue("allTotal"); </script>
														</a> 
													</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'ALL', 'ALL','started');">
															<script> writeAttributeValue("allActive"); </script>
														</a>
													</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'ALL', 'ALL','completed');">
															<script> writeAttributeValue("allCompleted"); </script>
														</a>
													</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'ALL', 'ALL','failed');">
															<script> writeAttributeValue("allFailed"); </script>
														</a>
													</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'ALL', 'ALL','cancelled');">
															<script> writeAttributeValue("allCancelled"); </script>
														</a>
													</td>
												</tr>
					%endifvar%
		%else%
												<tr class="field" align="left">
													<TD colspan=7 class="oddrowdata-l">---------------------------------- no results ----------------------------------</TD>
												</tr>
		%endifvar%
											</table>
										</td>
									</tr>
									<tr><td><img border="0" src="images/blank.gif" width="10" height="20"></td></tr>		
									<tr>
										<td valign="top">
											<table width="100%" border="1" class="tableView">
												<tr>
													<td colspan="6" class="heading">Processes Summary- By Server | From : %value fromTime encode(html)% | To : %value toTime encode(html)% </td>
												</tr>
												<tr class="subheading2">
													<td nowrap class="datacenter">Server ID</td>
													<td nowrap class="datacenter">Total</td>
													<td nowrap class="datacenter">Active</td>
													<td nowrap class="datacenter">Completed</td>
													<td nowrap class="datacenter">Failed</td>
													<td nowrap class="datacenter">Cancelled</td>
												</tr>
		%ifvar processStatsServerStatus%
			%loop processStatsServerStatus%
												<tr>
													<td class="keyrowdata"> %value key% </td>
													<td class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', '%value key encode(javascript)%','ALL');">
															%value count encode(html)%
														</a> 
													</td>
													<td nowrap class="evenrowdata">
								
				%ifvar startedBucket/count -notempty%
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', '%value key encode(javascript)%','started');">
															%value startedBucket/count encode(html)%
														</a>
				%else%
														-
				%endifvar%
													</td>
													<td nowrap class="evenrowdata">
								
				%ifvar completedBucket/count -notempty%
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', '%value key encode(javascript)%','completed');">
															%value completedBucket/count encode(html)%
														</a>
				%else%
														-
				%endifvar%
													</td>
													<td nowrap class="evenrowdata">
				%ifvar exceptionBucket/count -notempty%
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', '%value key encode(javascript)%','failed');">
															<script> writeFailedProcessesCount('%value exceptionBucket/count encode(javascript)%', '%value failedBucket/count encode(javascript)%'); </script>
														</a>
								
				%else%
					%ifvar failedBucket/count -notempty%
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', '%value key encode(javascript)%','failed');">
															<script> writeFailedProcessesCount('%value exceptionBucket/count encode(javascript)%', '%value failedBucket/count encode(javascript)%'); </script>
														</a>
					%else%
														-
					%endifvar%
				%endifvar%
													</td>
													<td nowrap class="evenrowdata">
				%ifvar cancelledBucket/count -notempty%
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', '%value key encode(javascript)%','cancelled');">
															%value cancelledBucket/count encode(html)%
														</a>
				%else%
														-
				%endifvar%
													</td>
						<script>
							AddProcesses('%value count encode(javascript)%', '%value startedBucket/count encode(javascript)%', '%value completedBucket/count encode(javascript)%', '%value exceptionBucket/count encode(javascript)%', '%value failedBucket/count encode(javascript)%', '%value cancelledBucket/count encode(javascript)%' );
						</script>
												</tr>
			%endloop%
												<tr>
													<td nowrap class="keyrowdata-b">ALL</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', 'ALL','ALL');">
															<script> writeAttributeValue("allTotal"); </script>
														</a> 
													</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', 'ALL','started');">
															<script> writeAttributeValue("allActive"); </script>
														</a>
													</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', 'ALL','completed');">
															<script> writeAttributeValue("allCompleted"); </script>
														</a>
													</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', 'ALL','failed');">
															<script> writeAttributeValue("allFailed"); </script>
														</a>
													</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_processes_specific.submit();" onClick="return populateProcessForm(document.htmlform_processes_specific,'%value /processBusinessDomain encode(javascript)%', 'ALL','cancelled');">
															<script> writeAttributeValue("allCancelled"); </script>
														</a>
													</td>
												</tr>
		%else%
												<tr class="field" align="left">
													<TD colspan=7 class="oddrowdata-l">---------------------------------- no results ----------------------------------</TD>
												</tr>
		%endifvar%
											</table>										
										</td>
									</tr>
	%endscope%								
								</table>
							</td>
							<td valign="top">
								<table>
									<tr>
										<td valign="top">
											<table width="50%" border="1" class="tableView">	
												<tr>
													<td nowrap colspan=3 class="heading">
														Events Dashboard Controls
													</td>
												</tr>
												<tr>
														<input type="hidden" name="processTimeRange" value="%ifvar processTimeRange -notempty% %value processTimeRange encode(htmlattr)% %else% today %endifvar%">
														<input type="hidden" name="processBusinessDomain" value="%ifvar processBusinessDomain -notempty% %value processBusinessDomain encode(htmlattr)% %else% ALL %endifvar%">
														<td nowrap class="oddrow"> 
															Time Range
															<select id="selEventTimeRange" name="eventTimeRange">
																<option value="today" %ifvar eventTimeRange% %ifvar eventTimeRange equals('today')%selected %endifvar% %else% selected %endifvar%>Today</option>
																<option value="lastSevenDays" %ifvar eventTimeRange equals('lastSevenDays')%selected %endifvar%>Past 7 days</option>
																<option value="lastFifteenDays" %ifvar eventTimeRange equals('lastFifteenDays')%selected %endifvar%>Past 15 days</option>
																<option value="lastThirtyDays" %ifvar eventTimeRange equals('lastThirtyDays')%selected %endifvar%>Past 30 days</option>
																<option value="ALL" %ifvar eventTimeRange equals('ALL')%selected %endifvar%>ALL</option>
															</select>
														</td>
														<td nowrap class="oddrow"> 
															Server
															<select id="selServer" name="eventServer" >	
%loop serverNames%
	%rename serverName currentServerName -copy%
	%rename ../eventServer eventServer -copy%
																<option value="%value currentServerName encode(htmlattr)%" %ifvar eventServer vequals(currentServerName)% selected %endifvar%>%value currentServerName encode(html)%</option>
																
		<script> 
			//var eventServer = '%value eventServer encode(htmlattr)%'
			//var currentServerName = '%value currentServerName encode(htmlattr)%'
			//if(eventServer == currentServerName){
				//document.getElementById('selServer').value=eventServer;
			//}
			
		</script>

%endloop%
																<option value="ALL" %ifvar eventServer% %ifvar eventServer equals('ALL')%selected %endifvar% %else% selected %endifvar%>All</option>
															</select>
														</td>
														<td nowrap class="oddrow">
															<input type="submit" VALUE="Refresh" onClick="return manageProcessAndEventRefresh(htmlform_dashboard_Stats_general, 'displayGeneral','%value processTimeRange encode(htmlattr)%','%value processBusinessDomain encode(htmlattr)%', 'event');">
														</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr><td><img border="0" src="images/blank.gif" width="10" height="20"></td></tr>
	%scope events%
									<tr>
										<td valign="top">
											<input type="hidden" id="eventFromTime" name="fromTime" value="%value fromTime encode(htmlattr)%">
											<input type="hidden" id="eventToTime" name="toTime" value="%value toTime encode(htmlattr)%">
											<table width="100%" class="tableView">
												<tr>
													<td nowrap colspan="6" class="heading">Events Summary- By Server | From : %value fromTime encode(html)% | To : %value toTime encode(html)%</td>
												</tr>
												<tr class="subheading2">
													<td nowrap class="datacenter">Server ID</td>
													<td nowrap class="datacenter">Total</td>
													<td nowrap class="datacenter">Fatal</td>
													<td nowrap class="datacenter">Error</td>
													<td nowrap class="datacenter">Warning</td>
													<td nowrap class="datacenter">Info</td>
												</tr>
		%ifvar eventStatsServerSev%
			%loop eventStatsServerSev%
												 <tr> 
													<td nowrap class="keyrowdata">%value key%</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'server', '%value key encode(javascript)%', 'ALL', 'false');">
															%value count encode(html)%
														</a> &nbsp;(
														%ifvar countNoActionTaken -notempty%
															%ifvar countNoActionTaken equals('0')%
															0
															%else%
																<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'server', '%value key encode(javascript)%', 'ALL', 'true');">
																	%value countNoActionTaken encode(html)%
																</a> 
															%endifvar%
														%else% 0 %endifvar% )
													</td>
													<td nowrap class="evenrowdata">
		%ifvar fatalBucket/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'server', '%value key encode(javascript)%', 'FATAL', 'false');">
															%value fatalBucket/count encode(html)%
														</a> &nbsp;(
														%ifvar fatalBucket/noActionTaken/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'server', '%value key encode(javascript)%', 'FATAL', 'true');">
															%value fatalBucket/noActionTaken/count encode(html)%
														</a> %else% 0 %endifvar% )
		%else%
															-
		%endifvar%
													</td>
													<td nowrap class="evenrowdata">
		%ifvar errorBucket/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'server', '%value key encode(javascript)%', 'ERROR', 'false');">
															%value errorBucket/count encode(html)%
														</a>&nbsp;(
														%ifvar errorBucket/noActionTaken/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'server', '%value key encode(javascript)%', 'ERROR', 'true');">
															%value errorBucket/noActionTaken/count encode(html)%
														</a> %else% 0 %endifvar% ) 
		%else%
															-
		%endifvar%
													</td>
													<td nowrap class="evenrowdata">
		%ifvar warningBucket/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'server', '%value key encode(javascript)%', 'WARNING', 'false');">
															%value warningBucket/count encode(html)%
														</a>&nbsp;(
														%ifvar warningBucket/noActionTaken/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'server', '%value key encode(javascript)%', 'WARNING', 'true');">
															%value warningBucket/noActionTaken/count encode(html)%
														</a> %else% 0 %endifvar% )
		%else%
															-
		%endifvar%
													</td>
													<td nowrap class="evenrowdata">
		%ifvar infoBucket/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'server', '%value key encode(javascript)%', 'INFO', 'false');">
															%value infoBucket/count encode(html)%
														</a>&nbsp;(
														%ifvar infoBucket/noActionTaken/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'server', '%value key encode(javascript)%', 'INFO', 'true');">
															%value infoBucket/noActionTaken/count encode(html)%
														</a> %else% 0 %endifvar% )
		%else%
															-
		%endifvar%
													</td>
												</tr>
			%endloop%
		%else%
												<tr class="field" align="left">
													<TD colspan=6 class="oddrowdata-l">---------------------------------- no results ----------------------------------</TD>
												</tr>
		%endifvar%				
											</table>
										</td>
									</tr>
									<tr><td><img border="0" src="images/blank.gif" width="10" height="20"></td></tr>
									<tr>
										<td valign="top">
											<table width="100%" class="tableView">
												<tr>
													<td colspan="6" class="heading">Events Summary- By Log File | From : %value fromTime encode(html)% | To : %value toTime encode(html)%</td>
												</tr>
												<tr class="subheading2">
													<td nowrap class="datacenter">Log File</td>
													<td nowrap class="datacenter">Total</td>
													<td nowrap class="datacenter">Fatal</td>
													<td nowrap class="datacenter">Error</td>
													<td nowrap class="datacenter">Warning</td>
													<td nowrap class="datacenter">Info</td>
												</tr>
		%ifvar eventStatslogFileSev%
			%loop eventStatslogFileSev%
												<tr> 
													<td nowrap class="keyrowdata">%value key%</td>
													<td nowrap class="evenrowdata">
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'logFile', '%value key encode(javascript)%', 'ALL', 'false');">
															%value count encode(html)%
														</a> &nbsp;(
														%ifvar countNoActionTaken -notempty%
															%ifvar countNoActionTaken equals('0')%
															0
															%else%
																<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'logFile', '%value key encode(javascript)%', 'ALL', 'true');">
																	%value countNoActionTaken encode(html)%
																</a>
															%endifvar%
														%else% 0 %endifvar%
														)
													</td>
													<td nowrap class="evenrowdata">
		%ifvar fatalBucket/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'logFile', '%value key encode(javascript)%', 'FATAL', 'false');">
															%value fatalBucket/count encode(html)%
														</a> &nbsp;(
														%ifvar fatalBucket/noActionTaken/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'logFile', '%value key encode(javascript)%', 'FATAL', 'true');">
															%value fatalBucket/noActionTaken/count encode(html)%
														</a>
														%else% 0 %endifvar%
														)
		%else%
															-
		%endifvar%
													</td>
													<td nowrap class="evenrowdata">
		%ifvar errorBucket/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'logFile', '%value key encode(javascript)%', 'ERROR', 'false');">
															%value errorBucket/count encode(html)%
														</a> &nbsp;(
														%ifvar errorBucket/noActionTaken/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'logFile', '%value key encode(javascript)%', 'ERROR', 'true');">
															%value errorBucket/noActionTaken/count encode(html)%
														</a>
														%else% 0 %endifvar%
														)
		%else%
															-
		%endifvar%
													</td>
													<td nowrap class="evenrowdata">
		%ifvar warningBucket/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'logFile', '%value key encode(javascript)%', 'WARNING', 'false');">
															%value warningBucket/count encode(html)%
														</a>  &nbsp;(
														%ifvar warningBucket/noActionTaken/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'logFile', '%value key encode(javascript)%', 'WARNING', 'true');">
															%value warningBucket/noActionTaken/count encode(html)%
														</a>%else% 0 %endifvar% )
		%else%
															-
		%endifvar%
													</td>
													<td nowrap class="evenrowdata">
		%ifvar infoBucket/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'logFile', '%value key encode(javascript)%', 'INFO', 'false');">
															%value infoBucket/count encode(html)%
														</a> &nbsp;(
														%ifvar infoBucket/noActionTaken/count -notempty%
														<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateEventForm(document.htmlform_events_specific, 'logFile', '%value key encode(javascript)%', 'INFO', 'true');">
															%value infoBucket/noActionTaken/count encode(html)%
														</a>%else% 0 %endifvar% )
		%else%
															-
		%endifvar%
													</td>
												</tr>
			%endloop%
		%else%
												<tr class="field" align="left">
													<TD colspan=6 class="oddrowdata-l">---------------------------------- no results ----------------------------------</TD>
												</tr>
		%endifvar%				
											</table>
										</td>
									</tr>
	%endscope%
									<tr><td><img border="0" src="images/blank.gif" width="10" height="20"></td></tr>
%endscope%
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
%endscope%
		</table>
	</body>
</html>