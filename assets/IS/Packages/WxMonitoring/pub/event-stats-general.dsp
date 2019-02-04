<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
		<title>Monitoring &gt; Statistics</title>
		<link rel="stylesheet" type="text/css" href="webMethods.css">
		<script src="webMethods.js.txt"></script>
		<script SRC="common-navigation.js"></script>
		<script language="JavaScript">
    <!--add jscript here-->
			function populateForm(form, operation, searchID, eventSeverityValue){

				if(operation=="displayGeneralStats"){
					var criteriaValue = document.getElementById("selGroupBy").value;
					var serverOption = document.getElementById("selServer");
					/*if(serverOption.value=="ALL")
						{
							criteriaValue = criteriaOption.value;
						}else {
							if(criteriaOption.value=="date"){
								criteriaValue = "dateByServer";
							}else if (criteriaOption.value=="logFile") {
								criteriaValue = "logFileByServer";
							}
						}*/
					//form.criteria.value = criteriaValue;
					form.submit();
				} else if(operation=="displaySpecific"){
				
					form.severity.value = eventSeverityValue;
					var criteriaValue = document.getElementById("selGroupBy").value;
					var fromDateValueControl = document.getElementById("dtFromDate").value;
					var fromTimeValueControl = document.getElementById("tmFromTime").value;
					var toDateValueControl = document.getElementById("dtToDate").value;
					var toTimeValueControl = document.getElementById("tmToTime").value;
					if(criteriaValue=="dateSev"){
						
												
						form.logFile.value = "ALL";
						if(searchID == "ALL") {
							form.fromDateValue.value = fromDateValueControl;
							form.fromTimeValue.value = fromTimeValueControl;
							form.toDateValue.value = toDateValueControl;
							form.toTimeValue.value = toTimeValueControl;
						} else {
							if(fromDateValueControl==searchID){
								form.fromDateValue.value = extractDateStamp(searchID);
								form.fromTimeValue.value = fromTimeValueControl;
								form.toDateValue.value = extractDateStamp(searchID);
								form.toTimeValue.value = "23:59";
								
							} else if(toDateValueControl==searchID){
								form.fromDateValue.value = extractDateStamp(searchID);
								form.fromTimeValue.value = "00:00";
								form.toDateValue.value = extractDateStamp(searchID);
								form.toTimeValue.value = toTimeValueControl;
								
							}else {
								form.fromDateValue.value = extractDateStamp(searchID);
								form.fromTimeValue.value = "00:00";
								form.toDateValue.value = extractDateStamp(searchID);
								form.toTimeValue.value = "23:59";	
							}
						} 
					} else if(criteriaValue=="logfileSev"){
						//alert(fromDateValueControl + fromTimeValueControl+ toDateValueControl+ toTimeValueControl);
						form.logFile.value = searchID;
						form.fromDateValue.value = fromDateValueControl;
						form.fromTimeValue.value = fromTimeValueControl;
						form.toDateValue.value = toDateValueControl;
						form.toTimeValue.value = toTimeValueControl;
					}
				}
				
				return true;
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
    

			function createPageState(fromDateValue, fromTimeValue, toDateValue, toTimeValue, server, criteria) {
			var stateJSONObject = {};
			stateJSONObject.currentPageName = "event-stats-general.dsp";
			stateJSONObject.previousPageName = "";
			stateJSONObject.fromDateValue = fromDateValue;
			stateJSONObject.fromTimeValue = fromTimeValue;
			stateJSONObject.toDateValue = toDateValue;
			stateJSONObject.toTimeValue = toTimeValue;
			stateJSONObject.server = server;
			stateJSONObject.criteria = criteria;
			//alert(criteria);
			return stateJSONObject;
		}
		</script>
	</head>

	<body>
		<table width="100%">
			<form name="htmlform_events_common">
				<input type="hidden" id="allTotal" name="allTotal" value="0">
				<input type="hidden" id="allFatal" name="allFatal" value="0">
				<input type="hidden" id="allError" name="allError" value="0">
				<input type="hidden" id="allWarning" name="allWarning" value="0">
				<input type="hidden" id="allInfo" name="allInfo" value="0">
			</form>	
			<tr>
				<td class="breadcrumb" colspan="3">Events &gt; Statistics</td>
			</tr>
			%invoke wx.monitoring.services.gui.events:getEventsStats%
				%rename /criteria originalCriteria -copy%
				%rename /server originalServer -copy%
				%rename /fromTime originalFromTime -copy%
				%rename /toTime originalToTime -copy%
			%endinvoke%
	
			%invoke wx.monitoring.services.gui.common:getAllServerNames%
				%rename /originalCriteria criteria -copy%
				%rename /originalServer server -copy%
				%rename /originalFromTime fromTime -copy%
				%rename /originalToTime toTime -copy%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
				%endif%
			%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
			%endinvoke% 
			<script>
					//alert('%value /criteria encode(javascript)%');
					var stateJSONObject = createPageState('%value /fromDateValue encode(javascript)%','%value /fromTimeValue encode(javascript)%','%value /toDateValue encode(javascript)%','%value /toTimeValue encode(javascript)%', '%value /server encode(javascript)%', '%value /criteria encode(javascript)%');
					
					var startNewNavigationSequence = true;
					savePageState("event-stats-general.dsp", stateJSONObject, startNewNavigationSequence);				
			</script>
			
			<form name="htmlform_events_specific" action="events-specific.dsp" method="POST">
				<input type="hidden" name="fromDateValue">
				<input type="hidden" name="fromTimeValue">
				<input type="hidden" name="toDateValue">
				<input type="hidden" name="toTimeValue">
				<input type="hidden" name="server" value="%value server encode(htmlattr)%">
				<input type="hidden" name="severity">
				<input type="hidden" name="logFile">
				<input type="hidden" name="filterEventsWithNoAction" value="false">
				<input type="hidden" name="compareSeverityExactly" value="true">
				<input type="hidden" name="criteria" value="%value criteria encode(htmlattr)%"> <!--criteria = dateSev or logfileSev or serverSev-->
			</form>
			<tr>
				<td colspan="3">
					<form name="htmlform_event_Stats_general" action="event-stats-general.dsp" method="GET">
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
													Server
													</TD>
													<TD>
														<select id="selServer" name="server" >	
%loop serverNames%
															<option value="%value key encode(htmlattr)%" %ifvar /server vequals(key)%selected %endifvar%>%value name encode(html)%</option>
%endloop%
															<option value="ALL" %ifvar /server% %ifvar /server equals('ALL')% selected %endifvar% %else% selected %endifvar%>All</option>
														</select>
													</TD>
												</TR>
												<TR>  
												<TD>
													Group By
												</TD>
												<TD>
													<select id="selGroupBy" name="criteria">
														<option value="dateSev" %ifvar criteria% %ifvar criteria equals('dateSev')%  selected %endifvar% %else% selected %endifvar%>Datewise</option>
														<option value="monthSev" %ifvar criteria% %ifvar criteria equals('monthSev')%  selected %endifvar% %else% selected %endifvar%>Monthwise</option>
														<option value="logfileSev" %ifvar criteria equals('logfileSev')%  selected %endifvar%>Log File</option>
														<option value="serverSev" %ifvar criteria equals('serverSev')%  selected %endifvar%>Server</option>
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
							<TD class="oddrow">  <INPUT type="submit" VALUE="Refresh" onClick="return populateForm(htmlform_event_Stats_general, 'displayGeneralStats');"></TD>
						</TR>
					</TABLE>
					</form>
				</td>
			</tr>
			<tr>
				<td width="10">
					<img border="0" src="images/blank.gif" width="10" height="10">
				</td>
			</tr>

			<tr>
				<td valign="top" width="100%">
					<table class="tableView" width="80%">
						<tr>
							<td colspan="6" class="heading">Events Summary- Group by :%ifvar criteria equals('dateSev')% Datewise %else% %ifvar criteria equals('logfileSev')% Source Log File %endifvar% %endifvar%| From : %value fromDateValue encode(html)%  %value fromTimeValue encode(html)%:00 | To : %value toDateValue encode(html)%  %value toTimeValue encode(html)%:59 </td>
						</tr>
						<tr class="subheading2">
							<td nowrap class="oddrow">%ifvar criteria equals('dateSev')% Date %else% %ifvar criteria equals('logfileSev')% Log File %endifvar% %endifvar%</td>
							<td nowrap class="oddcol">Total</td>
							<td nowrap class="oddcol">Fatal</td>
							<td nowrap class="oddcol">Error</td>
							<td nowrap class="oddcol">Warning</td>
							<td nowrap class="oddcol">Info</td>
						</tr>
					%ifvar eventsStats%
						%loop eventsStats%
						<tr>
							<td nowrap class="evenrowdata">%value key%</td>
							<td nowrap class="evenrowdata">
								<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateForm(document.htmlform_events_specific, 'displaySpecific', '%value key encode(javascript)%', 'ALL');">
									%value count encode(html)%
								</a> 
							</td>
							<td nowrap class="evenrowdata">
								
								%ifvar fatalBucket/count -notempty%
								<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateForm(document.htmlform_events_specific,'displaySpecific', '%value key encode(javascript)%', 'FATAL');">
									%value fatalBucket/count encode(html)%
								</a>
								%else%
									-
								%endifvar%
							</td>
							<td nowrap class="evenrowdata">
								
								%ifvar errorBucket/count -notempty%
								<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateForm(document.htmlform_events_specific, 'displaySpecific', '%value key encode(javascript)%', 'ERROR');">
									%value errorBucket/count encode(html)%
								</a>
								%else%
									-
								%endifvar%
							</td>
							<td nowrap class="evenrowdata">
								%ifvar warningBucket/count -notempty%
								<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateForm(document.htmlform_events_specific, 'displaySpecific', '%value key encode(javascript)%', 'WARNING');">
									%value warningBucket/count encode(html)%
								</a>
								%else%
									-
								%endifvar%
							</td>
							<td nowrap class="evenrowdata">
								%ifvar infoBucket/count -notempty%
								<a href="javascript:document.htmlform_events_specific.submit();" onClick="return populateForm(document.htmlform_events_specific, 'displaySpecific', '%value key encode(javascript)%', 'INFO');">
									%value infoBucket/count encode(html)%
								</a>
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
    </table>
  </body>
</html>
