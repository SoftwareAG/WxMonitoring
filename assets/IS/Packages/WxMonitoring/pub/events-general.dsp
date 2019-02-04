<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HTML>
<head>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods_extentions.css">
	<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
	<SCRIPT SRC="common-navigation.js"></SCRIPT>
	<script language="JavaScript">
		function handleEventDetailClick(form, eventID, eventIndex){

			form.eventID.value = eventID;
			form.eventIndex.value = eventIndex;
			form.submit();

			return true;
		}
		
		function createPageState(fromDateValue, fromTimeValue, toDateValue, toTimeValue, severity, server, logFile, displayOrder, resultsPerPage, requestedPageNumber) {
			var stateJSONObject = {};
			stateJSONObject.currentPageName = "events-general.dsp";
			stateJSONObject.previousPageName = "";
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
					var stateJSONObject = createPageState('%value /fromDateValue encode(javascript)%','%value /fromTimeValue encode(javascript)%','%value /toDateValue encode(javascript)%','%value /toTimeValue encode(javascript)%', '%value /severity encode(javascript)%', '%value /server encode(javascript)%', '%value /logFile encode(javascript)%', '%value /displayOrder encode(javascript)%', '%value /resultsPerPage encode(javascript)%', '%value /requestedPageNumber encode(javascript)%');
					
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
								<TD colspan=7 class="heading">Events Display Controls</TD>
							</TR>  
							<TR class="oddrow">
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>
											<TD>
												Start date
											</TD>
											<TD>
												<input id="dtFromDate" type="date" name="fromDateValue" value="%value fromDateValue%"/>
											</TD>
										</TR>
										<TR>  
											<TD>
												Start time
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
												End date
											</TD>
											<TD>
												<input id="dtToDate" type="date" name="toDateValue" value="%value toDateValue%"/>
											</TD>
										</TR>
										<TR>  
											<TD>
												End time
											</TD>
											<TD>
												<input id="tmToTime" type="time" name="toTimeValue" pattern="[0-9]{2}:[0-9]{2}" value="%value toTimeValue%"/>
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD nowrap align="left">
									Severity Threshold
									<select id="selSeverity" name="severity" >
										<option value="FATAL" %ifvar severity equals('FATAL')% selected %endifvar%>Fatal</option>
										<option value="ERROR" %ifvar severity equals('ERROR')% selected %endifvar%> >Error</option>
										<option value="WARNING" %ifvar severity equals('WARNING')% selected %endifvar%>>Warning</option>
										<option value="INFO" %ifvar severity equals('INFO')% selected %endifvar%>>Info</option>
										<option value="ALL" %ifvar severity equals('ALL')% selected %endifvar%>All</option>
									</select>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									Server

									<select id="selServer" name="server" >
											%loop serverNames%
										<option value="%value key encode(htmlattr)%" %ifvar ../server vequals(key)% selected %endifvar%>%value name encode(html)%</option>
											%endloop%
										<option value="ALL" %ifvar server equals('ALL')% selected %endifvar%>All</option>
									</select>
											
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									Log File
									<select id="selLogFile" name="logFile" style="width: 100px" >
											%loop logFileNames%
										<option value="%value key encode(htmlattr)%"  title="%value key encode(htmlattr)%" %ifvar ../logFile vequals(key)% selected %endifvar%>%value name encode(html)%</option>
											%endloop%
										<option value="ALL" %ifvar logFile equals('ALL')% selected %endifvar%>All</option>
									</select>

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
								<TD class="oddrow">  <INPUT type="submit" VALUE="Refresh"></TD>
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
									<td class="oddrow">More Info</td>
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
									<td>
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
					
				
</BODY>
</HTML>