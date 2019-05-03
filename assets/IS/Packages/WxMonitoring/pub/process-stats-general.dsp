<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
		<title>Processes &gt; Statistics</title>
		<link rel="stylesheet" type="text/css" href="webMethods.css">
		<script src="webMethods.js.txt"></script>
		<script SRC="common-navigation.js"></script>
		<script language="JavaScript">
    <!--add jscript here-->
			
		function populateForm(form, operation, searchID, processStatusValue){
				
				if(operation=="displayGeneralStats"){
					form.submit();
				} else if(operation=="displaySpecific"){


					form.processStatus.value = processStatusValue;
					var criteriaValue = form.criteria.value;
					
					if(criteriaValue=="serverStatus"){

						form.server.value = searchID;
						
					} else if (criteriaValue=="dateStatus"){
						
						form.server.value = "ALL";
						
						if(searchID!="ALL"){
							
							if(form.fromDateValue.value==searchID){
								form.fromDateValue.value = extractDateStamp(searchID);
								//form.fromTimeValue.value = form.fromTimeValueControl.value;
								form.toDateValue.value = extractDateStamp(searchID);
								form.toTimeValue.value = "23:59";
							} else if(form.toDateValue.value==searchID){
								form.fromDateValue.value = extractDateStamp(searchID);
								form.fromTimeValue.value = "00:00";
								form.toDateValue.value = extractDateStamp(searchID);
								//form.toTimeValue.value = form.toTimeValueControl.value;
							}else {
								form.fromDateValue.value = extractDateStamp(searchID);
								form.fromTimeValue.value = "00:00";
								form.toDateValue.value = extractDateStamp(searchID);
								form.toTimeValue.value = "23:59";
								
							}
						}
					} else if(criteriaValue=="hourStatus"){
						form.server.value = "ALL";
						
						if(searchID!="ALL"){
							form.fromDateValue.value = extractDateStamp(searchID);
							form.fromTimeValue.value = extractTimeTillMinutes(searchID);
							form.toDateValue.value = extractDateStamp(searchID);

							var fromDateTimeStr = searchID;
							var dateTime = new Date(searchID);
							var hours = dateTime.getHours(); 
							if(hours < 10){
								hours = "0" + hours;
							}
							var toTimeValueStr = hours + ":59";
						}
						form.toTimeValue.value = toTimeValueStr;
					}
				}
				
				
				return true;
			}
			
			function concatDateAndTime(date, time){
				var dateTimeString = date + " " + time + ":00";
				return dateTimeString;
			}

			function manageDateFieldVisibility(){
				var select = document.getElementById("selCriteria");
				var divv = document.getElementById("dateFields");
				var value = select.value;
				if (value == "date" || value == "server") {
					toAppend = "&nbsp;&nbsp;<label for='dtFromDate'>From Date</label>&nbsp;<input id='dtFromDate' type='date' name='fromDate'/>&nbsp;&nbsp;<label for='dtToDate'>To Date</label>&nbsp;<input id='dtToDate' type='date' name='toDate'/>&nbsp;&nbsp;"; 
					divv.innerHTML=toAppend; 
					return;
				} else {
					toAppend = ""; 
					divv.innerHTML=toAppend; 
				}
			}
	
			function refresh(){	
		
				var url_string = window.location.href;		
				var url = new URL(url_string);
				var lastCriteria = url.searchParams.get("criteria");
		
				if(!lastCriteria){
				} else{
					var divv = document.getElementById("dateFields");
					if (lastCriteria == "date" || lastCriteria == "server") {

						toAppend = "&nbsp;&nbsp;<label for='dtFromDate'>From Date</label>&nbsp;<input id='dtFromDate' type='date' name='fromDate'/>&nbsp;&nbsp;<label for='dtToDate'>To Date</label>&nbsp;<input id='dtToDate' type='date' name='toDate'/>&nbsp;&nbsp;"; 
						divv.innerHTML=toAppend; 
						return;
					} else {
						toAppend = ""; 
						divv.innerHTML=toAppend; 
					} 
				}
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
			
			function setDefaultDisplayControl(fromTime, toTime){
				
				document.getElementById("dtFromDate").value = extractDateStamp(fromTime);
				document.getElementById("dtToDate").value = extractDateStamp(toTime);
				document.getElementById("tmFromTime").value = extractTimeTillMinutes(fromTime);
				document.getElementById("tmToTime").value = extractTimeTillMinutes(toTime);
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
				document.write(myAttributeValue);
			}
			
			function createPageState(fromDateValue, fromTimeValue, toDateValue, toTimeValue, businessDomain, criteria) {
				var stateJSONObject = {};
				stateJSONObject.currentPageName = "process-stats-general.dsp";
				stateJSONObject.previousPageName = "";
				stateJSONObject.fromDateValue = fromDateValue;
				stateJSONObject.fromTimeValue = fromTimeValue;
				stateJSONObject.toDateValue = toDateValue;
				stateJSONObject.toTimeValue = toTimeValue;
				stateJSONObject.businessDomain = businessDomain;
				stateJSONObject.criteria = criteria;
				
				return stateJSONObject;
			}
		</script>
	</head>

	<body>
		<table width="100%">
			<form name="htmlform_process_common">
				<input type="hidden" id="allTotal" name="allTotal" value="0">
				<input type="hidden" id="allActive" name="allActive" value="0">
				<input type="hidden" id="allCompleted" name="allCompleted" value="0">
				<input type="hidden" id="allException" name="allException" value="0">
				<input type="hidden" id="allFailed" name="allFailed" value="0">
				<input type="hidden" id="allCancelled" name="allCancelled" value="0">
			</form>		
			<tr>
				<td class="breadcrumb" colspan="3">Processes &gt; Statistics</td>
			</tr>
			%invoke wx.monitoring.services.gui.processes:getProcessesStats%
				%rename /criteria originalCriteria -copy%
				%rename /businessDomain originalBusinessDomain -copy%
				%rename /fromTime originalFromTime -copy%
				%rename /toTime originalToTime -copy%
				%ifvar message%
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
				%endif%
				%ifvar onerror%
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
				%endif%
			%endinvoke%
			%invoke wx.monitoring.services.gui.common:getAllBusinessDomainsNames%
				%rename /originalCriteria criteria -copy%
				%rename /originalBusinessDomain businessDomain -copy%
				%rename /originalFromTime fromTime -copy%
				%rename /originalToTime toTime -copy%
			%endinvoke%
			<script>
					var stateJSONObject = createPageState('%value /fromDateValue encode(javascript)%','%value /fromTimeValue encode(javascript)%','%value /toDateValue encode(javascript)%','%value /toTimeValue encode(javascript)%', '%value /businessDomain encode(javascript)%', '%value /criteria encode(javascript)%');
					
					var startNewNavigationSequence = true;
					savePageState("process-stats-general.dsp", stateJSONObject, startNewNavigationSequence);				
			</script>
			<form name="htmlform_process_Stats_specific" action="processes-specific.dsp" method="POST">
				<input type="hidden" name="fromDateValue" value="%value fromDateValue encode(htmlattr)%">
				<input type="hidden" name="fromTimeValue" value="%value fromTimeValue encode(htmlattr)%">
				<input type="hidden" name="toDateValue" value="%value toDateValue encode(htmlattr)%">
				<input type="hidden" name="toTimeValue" value="%value toTimeValue encode(htmlattr)%">
				<input type="hidden" name="server">
				<input type="hidden" name="processStatus">
				<input type="hidden" name="businessDomain" value="%value businessDomain encode(htmlattr)%">
				<input type="hidden" name="criteria" value="%value criteria encode(htmlattr)%">
			</form>
			<tr>
				<td colspan="3">
					<form name="htmlform_process_Stats_general" action="process-stats-general.dsp" method="GET">
						<TABLE class="tableView">
							<TR>
								<TD colspan=3 class="heading">Statistics Display Controls</TD>
							</TR>  
							<TR class="oddrow">
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>
											<TD>
												<TABLE class="noborders">
												<TR>
													<TD>
													Business Domain
													</TD>
													<TD>
														<select id="selBusinessDomain" name="businessDomain" >	
%loop businessDomains%
															<option value="%value key encode(htmlattr)%" %ifvar /businessDomain vequals(key)%selected %endifvar%>%value name encode(html)%</option>
%endloop%
															<option value="ALL" %ifvar /businessDomain% %ifvar /businessDomain equals('ALL')% selected %endifvar% %else% selected %endifvar%>All</option>
														</select>
													</TD>
												</TR>
												<TR>  
												<TD>
													Group By
												</TD>
												<TD>
													<select id="selGroupBy" name="criteria">
														<option value="dateStatus" %ifvar criteria% %ifvar criteria equals('dateStatus')%  selected %endifvar% %else% selected %endifvar%>Datewise</option>
														<option value="hourStatus" %ifvar criteria equals('hourStatus')%  selected %endifvar%>Hourwise</option>
														<option value="monthStatus" %ifvar criteria equals('monthStatus')%  selected %endifvar%>Monthwise</option>
														<option value="serverStatus" %ifvar criteria equals('serverStatus')%  selected %endifvar%>Server</option>
														<option value="businessDomainStatus" %ifvar criteria equals('businessDomainStatus')%  selected %endifvar%>Business Domain</option>
													</select>
												</TD>
											</TR>
												</TABLE> 
											</TD>
											<TD class="oddrow" nowrap>
												<TABLE class="noborders">
												<TR>
												<TD>
													From date
												</TD>
												<TD>
													<input id="dtFromDate" type="date" name="fromDateValue" value="%value fromDateValue%"/>
												</TD>
											</TR>
											<TR>  
												<TD>
													From time
												</TD>
												<TD>
													<input id="tmFromTime" type="time" name="fromTimeValue" pattern="[0-9]{2}:[0-9]{2}" value="%value fromTimeValue%"/>
												</TD>
											</TR>
										</TABLE>
									</TD>
									<TD class="oddrow" nowrap>
										<TABLE class="noborders">
											<TR>
												<TD>
													To date
												</TD>
												<TD>
													<input id="dtToDate" type="date" name="toDateValue" value="%value toDateValue%" />
												</TD>
											</TR>
											<TR>  
												<TD>
													To time
												</TD>
												<TD>
													<input id="tmToTime" type="time" name="toTimeValue" pattern="[0-9]{2}:[0-9]{2}" value="%value toTimeValue%"/>
												</TD>
											</TR>
										</TABLE>
									</TD>
											<TD>
												<div id="dateFields"></div>
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD class="oddrow">  <INPUT type="submit" VALUE="Refresh" onClick="return populateForm(htmlform_process_Stats_general, 'displayGeneralStats');"></TD>
							</TR>
						</TABLE>
					</form>
				</td>
			</tr>
			<script type="text/javascript">
				//setDefaultDisplayControl('%value fromTime%', '%value toTime%');
				//alert('%value /criteria%');
			</script>
			<tr>
				<td width="10">
					<img border="0" src="images/blank.gif" width="10" height="10">
				</td>
			</tr>

			<tr>
				<td valign="top" width="100%">
					<table class="tableView" width="80%">
						<tr>
							<td colspan="6" class="heading">Processes Summary- Group by : %ifvar criteria equals('dateStatus')% Datewise %else% %ifvar criteria equals('hourStatus')% Hourwise %else% %ifvar criteria equals('businessDomainStatus')% Business Domain %else% %ifvar criteria equals('serverStatus')% Server %else% %ifvar criteria equals('monthStatus')% Month %else% - %endifvar% %endif% %endifvar% %endifvar% %endifvar% | From : %value fromDateValue encode(html)%  %value fromTimeValue encode(html)%:00 | To : %value toDateValue encode(html)%  %value toTimeValue encode(html)%:59 </td>
						</tr>
						<tr class="subheading2">
							<td nowrap class="datacenter">%ifvar criteria equals('dateStatus')% Date %else% %ifvar criteria equals('hourStatus')% Hour %else% %ifvar criteria equals('businessDomainStatus')% Business Domain %else% %ifvar criteria equals('serverStatus')% Server %else% %ifvar criteria equals('monthStatus')% Month %else% - %endifvar% %endif% %endifvar% %endifvar% %endifvar% </td>
							<td nowrap class="datacenter">Total</td>
							<td nowrap class="datacenter">Active</td>
							<td nowrap class="datacenter">Completed</td>
							<td nowrap class="datacenter">Failed</td>
							<td nowrap class="datacenter">Cancelled</td>
						</tr>
					%ifvar processesStats%
						%loop processesStats%
						<tr>
							<td nowrap class="evenrowdata"> %ifvar ../criteria equals('businessDomainStatus')% %value key% %else% %value key% %endifvar% </td>
							<td nowrap class="evenrowdata">
								%ifvar count equals('0')%
								-
								%else%
								<a href="javascript:document.htmlform_process_Stats_specific.submit();" onClick="return populateForm(document.htmlform_process_Stats_specific, 'displaySpecific', '%value key encode(javascript)%', 'ALL');">
									%value count encode(html)%
								</a> 
								%endifvar%
							</td>
							<td nowrap class="evenrowdata">
								
								%ifvar startedBucket/count -notempty%
								%ifvar startedBucket/count equals('0')%
								-
								%else%
								<a href="javascript:document.htmlform_process_Stats_specific.submit();" onClick="return populateForm(document.htmlform_process_Stats_specific, 'displaySpecific', '%value key encode(javascript)%', 'started');">
									%value startedBucket/count encode(html)%
								</a>
								%endifvar%
								%else%
									-
								%endifvar%
							</td>
							<td nowrap class="evenrowdata">
								
								%ifvar completedBucket/count -notempty%
								%ifvar completedBucket/count equals('0')%
								-
								%else%
								<a href="javascript:document.htmlform_process_Stats_specific.submit();" onClick="return populateForm(document.htmlform_process_Stats_specific, 'displaySpecific', '%value key encode(javascript)%', 'completed');">
									%value completedBucket/count encode(html)%
								</a>
								%endifvar%
								%else%
									-
								%endifvar%
							</td>
							<td nowrap class="evenrowdata">
								%ifvar failedAndExceptionBucket/count -notempty%
								%ifvar failedAndExceptionBucket/count equals('0')%
								-
								%else%
								<a href="javascript:document.htmlform_process_Stats_specific.submit();" onClick="return populateForm(document.htmlform_process_Stats_specific,'displaySpecific', '%value key encode(javascript)%', 'failed');">
									%value failedAndExceptionBucket/count encode(html)%
								</a>
								%endifvar%
								%else%
									-
								%endifvar%
							</td>
							<td nowrap class="evenrowdata">
								%ifvar cancelledBucket/count -notempty%
								%ifvar cancelledBucket/count equals('0')%
								-
								%else%
								<a href="javascript:document.htmlform_process_Stats_specific.submit();" onClick="return populateForm(document.htmlform_process_Stats_specific,'displaySpecific', '%value key encode(javascript)%', 'cancelled');">
									%value cancelledBucket/count encode(html)%
								</a>
								%endifvar%
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
							<td nowrap class="evenrowdata">ALL</td>
							<td nowrap class="evenrowdata">
								<a id="allTotalView" href="javascript:document.htmlform_process_Stats_specific.submit();" onClick="return populateForm(document.htmlform_process_Stats_specific, 'displaySpecific', 'ALL', 'ALL');">
									<script> writeAttributeValue("allTotal"); </script>
								</a> 
							</td>
							<td nowrap class="evenrowdata">
								

								<a id="allActiveView" href="javascript:document.htmlform_process_Stats_specific.submit();" onClick="return populateForm(document.htmlform_process_Stats_specific, 'displaySpecific', 'ALL', 'started');">
									<script> writeAttributeValue("allActive"); </script>
								</a>

							</td>
							<td nowrap class="evenrowdata">
								<a href="javascript:document.htmlform_process_Stats_specific.submit();" onClick="return populateForm(document.htmlform_process_Stats_specific, 'displaySpecific', 'ALL', 'completed');">
									<script> writeAttributeValue("allCompleted"); </script>
								</a>
							</td>
							<td nowrap class="evenrowdata">
								<a href="javascript:document.htmlform_process_Stats_specific.submit();" onClick="return populateForm(document.htmlform_process_Stats_specific,'displaySpecific',  'ALL', 'failed');">
									<script> writeAttributeValue("allFailed"); </script>
								</a>
							</td>
							<td nowrap class="evenrowdata">
								<a href="javascript:document.htmlform_process_Stats_specific.submit();" onClick="return populateForm(document.htmlform_process_Stats_specific,'displaySpecific',  'ALL', 'cancelled');">
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
			<tr><td width="10"><IMG src="images/blank.gif" width="10" height="10"></td></tr>
			<tr>
				<td colspan=1>
					By default processes summary is shown for the past 10 days.
				</td>
			</tr>
    </table>

  </body>
</html>
