<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HTML>
<head>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods_extentions.css">
	<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
	<SCRIPT SRC="common-navigation.js"></SCRIPT>
	<script language="JavaScript">
		
		function validate(form, totalPages){
			
			if(form.requestedPageNumber.value > totalPages){
				return false;
			}

			return true;
		}
		
		function handleEventDetailClick(form, eventID, eventIndex){

			form.eventID.value = eventID;
			form.eventIndex.value = eventIndex;
			form.submit();

			return true;
		}
		
		function createPageState(eventTimeRange, fromDateValue, fromTimeValue, toDateValue, toTimeValue, severity, server, logFile, displayOrder, resultsPerPage, requestedPageNumber) {
			var stateJSONObject = {};
			stateJSONObject.currentPageName = "events-general.dsp";
			stateJSONObject.previousPageName = "";
			stateJSONObject.eventTimeRange = eventTimeRange;
			stateJSONObject.fromDateValue = fromDateValue;
			stateJSONObject.fromTimeValue = fromTimeValue;
			stateJSONObject.toDateValue = toDateValue;
			stateJSONObject.toTimeValue = toTimeValue;
			stateJSONObject.severity = severity;
			stateJSONObject.server = server;
			stateJSONObject.logFile = logFile;
			stateJSONObject.displayOrder = displayOrder;
			stateJSONObject.resultsPerPage = resultsPerPage;
			stateJSONObject.requestedPageNumber = requestedPageNumber;
			
			return stateJSONObject;
		}

		function toggleCtrl_TimeRange() {
			var selTimeRange = document.getElementById("selEventTimeRange");
			var dtFromDate = document.getElementById("dtFromDate");
			var dtToDate = document.getElementById("dtToDate");
			var tmFromTime = document.getElementById("tmFromTime");
			var tmToTime = document.getElementById("tmToTime");

			if (selTimeRange.value == 'Custom') {
				// enable all custom ctrls 
				dtFromDate.removeAttribute('readonly');
				dtToDate.removeAttribute('readonly');
				tmFromTime.removeAttribute('readonly');
				tmToTime.removeAttribute('readonly');
			} else {
				// set all custom ctrls readonly
				dtFromDate.setAttribute('readonly', 'readonly');
				dtToDate.setAttribute('readonly', 'readonly');
				tmFromTime.setAttribute('readonly', 'readonly');
				tmToTime.setAttribute('readonly', 'readonly');
			}
		}

	</script>
</head>
<BODY>
	<div CLASS="position">
		<table WIDTH="100%">
			<tbody>
				<tr>
<!-- page name (breadcrumb) -->
					<td class="breadcrumb" colspan="2">Events &gt; General</td>
				</tr>
         
				<tr>
					<td colspan="2"><br></td>
				</tr>
<!-- list page actions -->
				
				
				%invoke wx.monitoring.services.gui.events:getEvents%
				%endinvoke% 
				
				%invoke wx.monitoring.services.gui.common:getAllLogFilesNames%
				%endinvoke% 
				
				%invoke wx.monitoring.services.gui.common:getAllServerNames%
					%ifvar message%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
					%endif%
                %onerror%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
				%endinvoke% 
				<script>
					var stateJSONObject = createPageState('%value eventTimeRange encode(javascript)%', '%value /fromDateValue encode(javascript)%','%value /fromTimeValue encode(javascript)%','%value /toDateValue encode(javascript)%','%value /toTimeValue encode(javascript)%', '%value /severity encode(javascript)%', '%value /server encode(javascript)%', '%value /logFile encode(javascript)%', '%value /displayOrder encode(javascript)%', '%value /resultsPerPage encode(javascript)%', '%value /requestedPageNumber encode(javascript)%');
					
					var startNewNavigationSequence = true;
					savePageState("events-general.dsp", stateJSONObject, startNewNavigationSequence);				
				</script>
				<tr>
					<td colspan="6">
						<form name="htmlform_event_details" action="event-detail.dsp" method="POST">
							<input type="hidden" name="eventID">
							<input type="hidden" name="eventIndex">
						</form>
						<form name="htmlform_events_general" action="events-general.dsp" method="GET">
							<input type="hidden" name="navigationSource" value="eventsGeneral">
							<input type="hidden" name="filterEventsWithNoAction" value="false">
							<input type="hidden" name="compareSeverityExactly" value="false">
						<TABLE class="tableView">
							<TR>
								<TD colspan=8 class="heading">Events Display Controls</TD>
							</TR>  
							<TR class="oddrow">
								<td>
									<TABLE class="noborders">
										<TR>
											<TD>
												
													Event Log Contains:
											</TD>
										</TR>
										<TR>
											<TD>
												<textarea id="eventLogText" rows="4" cols="40" title="Search events based on string entered. It does not support field name prefixes, wildcard characters, or other 'advanced' features." placeholder="Supports partial, fuzzy search however, no regex allowed." name="eventLogText">%value eventLogText%</textarea>
											</TD>
										</TR>
									</TABLE>
								</td>
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>
											<TD>
												Time Range
											</TD>
											<TD>
												<select id="selEventTimeRange" name="eventTimeRange" onchange="toggleCtrl_TimeRange()">
													<option value="today" %ifvar eventTimeRange% %ifvar eventTimeRange equals('today')%selected %endifvar% %else% selected %endifvar%>Today</option>
													<option value="lastSevenDays" %ifvar eventTimeRange equals('lastSevenDays')%selected %endifvar%>Past 7 days</option>
													<option value="lastFifteenDays" %ifvar eventTimeRange equals('lastFifteenDays')%selected %endifvar%>Past 15 days</option>
													<option value="lastThirtyDays" %ifvar eventTimeRange equals('lastThirtyDays')%selected %endifvar%>Past 30 days</option>
													<option value="ALL" %ifvar eventTimeRange equals('ALL')%selected %endifvar%>ALL</option>
													<option value="Custom" %ifvar eventTimeRange equals('Custom')%selected %endifvar%>Custom</option>
												</select>
											</TD>
										</TR>
										<TR>
											<TD>
												Start date
											</TD>
											<TD>
												<input id="dtFromDate" type="date" name="fromDateValue" value="%value fromDateValue%"/>
											</TD>
											<TD>
												End date
											</TD>
											<TD>
												<input id="dtToDate" type="date" name="toDateValue" value="%value toDateValue%"/>
											</TD>
										</TR>
										<TR>  
											<TD>
												Start time
											</TD>
											<TD>
												<input id="tmFromTime" type="time" name="fromTimeValue" pattern="[0-9]{2}:[0-9]{2}" value="%value fromTimeValue%"/>
											</TD>
											<TD>
												End time
											</TD>
											<TD>
												<input id="tmToTime" type="time" name="toTimeValue" pattern="[0-9]{2}:[0-9]{2}" value="%value toTimeValue%"/>
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>
											<td>
												Severity Threshold
											</td>
										</TR>
										<TR>  
											<td>
												<select id="selSeverity" name="severity">
													<option value="FATAL" %ifvar severity equals('FATAL')% selected %endifvar%>Fatal</option>
													<option value="ERROR" %ifvar severity equals('ERROR')% selected %endifvar%> >Error</option>
													<option value="WARNING" %ifvar severity equals('WARNING')% selected %endifvar%>>Warning</option>
													<option value="INFO" %ifvar severity equals('INFO')% selected %endifvar%>>Info</option>
													<option value="ALL" %ifvar severity equals('ALL')% selected %endifvar%>All</option>
												</select>
											</td>
										</TR>
									</TABLE>
								</TD>
								<TD nowrap align="left">
									<table class="noborders">
										<tbody>
											<tr>
												<td>
													Server
												</td>
												<td>
													<select id="selServer" name="server" >
															%loop serverNames%
														<option value="%value key encode(htmlattr)%" %ifvar ../server vequals(key)% selected %endifvar%>%value name encode(html)%</option>
															%endloop%
														<option value="ALL" %ifvar server equals('ALL')% selected %endifvar%>All</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													Log File
												</td>
												<td>
													<select id="selLogFile" name="logFile" style="width: 100px" >
															%loop logFileNames%
														<option value="%value key encode(htmlattr)%"  title="%value key encode(htmlattr)%" %ifvar ../logFile vequals(key)% selected %endifvar%>%value name encode(html)%</option>
															%endloop%
														<option value="ALL" %ifvar logFile equals('ALL')% selected %endifvar%>All</option>
													</select>
												</td>
											</tr>
										</tbody>
									</table>
								</TD> 
								<TD class="oddrow" nowrap>
										<TABLE class="noborders">
											<TR>
												<TD class="evenrowdata" colspan=2>
													Sort By
												</TD>
											</TR>
											<TR>
												<TD>
													<INPUT TYPE="radio" NAME="sortBy" VALUE="score" %ifvar sortBy equals('score')%checked %endifvar%>
												</TD>
												<TD>
													Most Relevant
												</TD>
											</TR>
											<TR>
												<TD>
													<INPUT TYPE="radio" NAME="sortBy" VALUE="timestamp" %ifvar sortBy equals('timestamp')%checked %endifvar%>
												</TD>
												<TD>
													Timestamp
												</TD>
											</TR>
										</TABLE>
									</TD>
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>
											<TD class="evenrowdata" colspan=2>
												Display Order
											</TD>
										</TR>
										<TR>
											<TD>
												<INPUT TYPE="radio" NAME="displayOrder" VALUE="asc" %ifvar displayOrder equals('asc')%checked %endifvar%>
											</TD>
											<TD>
												Ascending 
											</TD>
										</TR>
										<TR>  
											<TD>
												<INPUT TYPE="radio" NAME="displayOrder" VALUE="desc" %ifvar displayOrder equals('desc')%checked %endifvar%>
											</TD>
											<TD>
												Descending 
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>                            
											<TD>
												Number of entries per page
											</TD>
											<TD>
												<INPUT type="number" name="resultsPerPage" id="resultsPerPage"  value="%value resultsPerPage%">
											</TD>
										</TR>
										<TR>                              
											<TD>
												Go to page
											</TD>
											<TD>
												<INPUT type="number" name="requestedPageNumber" id="requestedPageNumber" value="%value requestedPageNumber%">
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD class="oddrow">  <INPUT type="submit" VALUE="Refresh" onclick="return validate(this.form, '%value totalPages%');"></TD>
							</TR>
			
			
						</TABLE>
					</td>
				</tr>
				<tr>
					<td id="result" colspan="6" align="right"></td>
				</tr>
				<tr>
					<td>
						<table class="tableView" id="head" name="head" WIDTH="90%">
							<tbody>
								<tr>
									<td class="heading" colspan="8">Monitoring Events</td>
								</tr>
								<tr class="subheading2">
									<td class="oddrow">Event Timestamp</td>
									<td class="oddrow">Server ID</td>
									<td class="oddrow">Event Code</td>
									<td class="oddrow">Severity</td>
									<td class="oddrow">Event Information</td>
									<td class="oddrow">Event ESID (for dev purpose only)</td>
									<td class="oddrow">Log File</td>
									<td class="oddrow" title="highlighted if not evaluated yet">More Info *</td>
								</tr>


									%ifvar events%
										%loop events%
								<tr class="field">
									<td>%value eventTimestamp%</td>
									<td >%value serverID%</td>
									<td >%value typeID%</td>
									<td >%value severity%</td>
									<td >%value eventInformation%</td>
									<td >%value eventESID%</td>
									<td >%value sourceFileFullName%</td>
									
									<td class="oddrowdata"
										%ifvar lastEvaluated -notempty% 
											%ifvar actions -notnull%
												style="background-color: #CDE6F9;" 
											%endifvar%
										%else% 
											style="background-color:#fffaba;" 
										%endifvar%
									>
										<a href="#"  onclick="handleEventDetailClick(document.htmlform_event_details, '%value eventESID%', '%value eventESIndex%');" id="moreInfo">
											<img src="images/ifcdot.gif" border="no">
										</a> 
									</td>
								</tr>
										%endloop%
									%else%
								<tr class="field" align="left">
									<TD colspan=8 class="oddrowdata-l">---------------------------------- no results ----------------------------------</TD>
								</tr>
									%endifvar%
 
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<input type="hidden" id="totalPages" name="totalPages" value="%value totalPages%">
					<td id="pagination" colspan="1" >
						 %scope param(form='htmlform_events_general')%
							%include pagination.dsp%
						%endscope%
					</td>
					<td>  </td>
				</tr>
			</tbody>
		</table>          
         
	</div>
	
	<!-- POST load page -->
	<script language="JavaScript">
		toggleCtrl_TimeRange()
	</script>

</BODY>
</HTML>