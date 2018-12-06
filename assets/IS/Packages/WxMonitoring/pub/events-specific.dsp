<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HTML>
<head>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods_extentions.css">
	<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
	<script SRC="common-navigation.js"></script>
	<script language="JavaScript">
	
	function handleEventDetailClick(form, eventID, eventIndex){
			form.eventID.value = eventID;
			form.eventIndex.value = eventIndex;
			form.submit();

			return true;
		}
	
	function createPageState(fromDateValue, fromTimeValue, toDateValue, toTimeValue, severity, server, logFile, compareSeverityExactly, filterEventsWithNoAction ,displayOrder, resultsPerPage, requestedPageNumber) {
		var stateJSONObject = {};
		stateJSONObject.currentPageName = "events-specific.dsp";
		stateJSONObject.previousPageName = getLastPageName("events-specific.dsp");
		stateJSONObject.fromDateValue = fromDateValue;
		stateJSONObject.fromTimeValue = fromTimeValue;
		stateJSONObject.toDateValue = toDateValue;
		stateJSONObject.toTimeValue = toTimeValue;
		stateJSONObject.severity = severity;
		stateJSONObject.server = server;
		stateJSONObject.logFile = logFile;
		stateJSONObject.compareSeverityExactly = compareSeverityExactly;
		stateJSONObject.filterEventsWithNoAction = filterEventsWithNoAction;
		stateJSONObject.displayOrder = displayOrder;
		stateJSONObject.resultsPerPage = resultsPerPage;
		stateJSONObject.requestedPageNumber = requestedPageNumber;
	
		return stateJSONObject;
	}

	function onReturnClick() {
		
		var currentPageState = getPageState("events-specific.dsp");
		var previousPageState =  getPageState(currentPageState.previousPageName);
		cleanNavigationSequence();
		
		if(previousPageState.currentPageName=="event-stats-general.dsp"){
			var url = "event-stats-general.dsp?fromDateValue=" + previousPageState.fromDateValue + "&fromTimeValue=" + previousPageState.fromTimeValue + "&toDateValue=" + previousPageState.toDateValue + "&toTimeValue=" + previousPageState.toTimeValue + "&server=" + previousPageState.server + "&criteria=" + previousPageState.criteria;
		}else if(previousPageState.currentPageName=="dashboard.dsp"){
			var url = "dashboard.dsp?processTimeRange=" + previousPageState.processTimeRange + "&eventTimeRange=" + previousPageState.eventTimeRange + "&processBusinessDomain=" + previousPageState.processBusinessDomain + "&eventServer=" + previousPageState.eventServer ;
		}
		var res = encodeURI(url);
		
		location.href = res;	
	}
	
	function populateForm(form, operation){
	if(operation=="refresh_current_display"){
		var displayOrderRadios = document.getElementsByName('displayOrder');
		var displayOrderValue;
		for(var i = 0; i < displayOrderRadios.length; i++){
		    if(displayOrderRadios[i].checked){
		        displayOrderValue = displayOrderRadios[i].value;
				break;
		    }
		}
		if(displayOrderValue)
		{
			form.displayOrder.value=displayOrderValue;
		} else {
			form.displayOrder.value="desc";
		}
		
		form.resultsPerPage.value = document.getElementById('resultsPerPage').value;
		form.requestedPageNumber.value = document.getElementById('requestedPageNumber').value;
		form.submit();
	} else if (operation=="perform_action") {
		var actionStr = document.getElementById('selAction').value;
		if (!confirm ("A common action will be performed for all the events. click 'OK' to proceed.")) {
                return false;
            }
		form.action.value = document.getElementById('selAction').value;
		form.operation.value = operation;
		form.submit();
	}
		
	return true;
}
	</script>
</head>
<BODY>
	<div CLASS="position">
		<table WIDTH="100%">
			<tbody>
				<tr>
<!-- page name (breadcrumb) -->
					<td class="breadcrumb" colspan="2">Monitoring &gt; Statistics &gt; Specific events</td>
				</tr>
		
		%ifvar operation equals('perform_action')%
			%invoke wx.monitoring.gui.events:performActionOnSelectedEvents%
			%endinvoke%
			%ifvar status%
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan="2">%value status encode(html)%</td></tr>
			%endif%
		%endifvar%
		
		%ifvar operation equals('show_rule_affected_events')%
			%invoke wx.monitoring.gui.events:getEventsaffectedByRuleID%
			%ifvar message%
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
			%endif%
			%ifvar onerror%
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
			%endif%
		%endinvoke%
		%else%
			%invoke wx.monitoring.services.gui.events:getEvents%
			%ifvar message%
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
			%endif%
			%ifvar onerror%
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
			%endif%
		%endinvoke%
		%endifvar%
		
		<script>
			var stateJSONObject = createPageState('%value /fromDateValue encode(javascript)%','%value /fromTimeValue encode(javascript)%','%value /toDateValue encode(javascript)%','%value /toTimeValue encode(javascript)%', '%value /severity encode(javascript)%', '%value /server encode(javascript)%', '%value /logFile encode(javascript)%', '%value /compareSeverityExactly encode(javascript)%', '%value /filterEventsWithNoAction encode(javascript)%', '%value /displayOrder encode(javascript)%', '%value /resultsPerPage encode(javascript)%', '%value /requestedPageNumber encode(javascript)%');
			
			var startNewNavigationSequence = false;
			savePageState("events-specific.dsp", stateJSONObject, startNewNavigationSequence);				
		</script>	
				<tr>
					<td colspan="2">
						<ul class="listitems">
							<li class="listitem">
								<a href="#"  onclick="onReturnClick();" id="return">
									<script> 
										var currentPageState = getPageState("events-specific.dsp");
										if(currentPageState.previousPageName == "dashboard.dsp") { 
											document.write("Return to dashboard");
											} else if(currentPageState.previousPageName == "event-stats-general.dsp"){
											document.write("Return to general");
										} else {
											document.write("Returnnnnn to general");
										}
									</script> 
								</a>
							</li>
						</ul>
					</td>
				</tr>
				<tr>
					<td colspan="2"><br></td>
				</tr>
<!-- list page actions -->
				<tr>
					<td colspan="6">
					%ifvar operation equals('show_rule_affected_events')%
						<form name="htmlform_rule_affected_events_display" action="events-specific.dsp" method="GET">
							<input type="hidden" name="ruleID" value="%value ruleID encode(htmlattr)%">
							<input type="hidden" name="totalPages" value="%value totalPages encode(htmlattr)%">
							<input type="hidden" name="displayOrder" value="%value displayOrder encode(htmlattr)%">
							<input type="hidden" name="resultsPerPage" value="%value resultsPerPage encode(htmlattr)%">
							<input type="hidden" name="requestedPageNumber" value="%value requestedPageNumber encode(htmlattr)%">
							<input type="hidden" name="operation" value="show_rule_affected_events">
						</form>
						<!--<form name="htmlform_event_details" action="event-details.dsp" method="GET">
							<input type="hidden" name="navigationSource" value="eventsSpecific">
							<input type="hidden" name="navigationSequence">
							<input type="hidden" name="eventID">
							<input type="hidden" name="fromDateValue" value="%value fromDateValue encode(htmlattr)%">
							<input type="hidden" name="fromTimeValue" value="%value fromTimeValue encode(htmlattr)%">
							<input type="hidden" name="toDateValue" value="%value toDateValue encode(htmlattr)%">
							<input type="hidden" name="toTimeValue" value="%value toTimeValue encode(htmlattr)%">
							<input type="hidden" name="server" value="%value server encode(htmlattr)%">
							<input type="hidden" name="severity" value="%value severity encode(htmlattr)%">
							<input type="hidden" name="displayOrder" value="%value displayOrder encode(htmlattr)%">
							<input type="hidden" name="resultsPerPage" value="%value resultsPerPage encode(htmlattr)%">
							<input type="hidden" name="requestedPageNumber" value="%value requestedPageNumber encode(htmlattr)%">
						</form>-->
					%else%
						<form name="htmlform_event_details" action="event-detail.dsp" method="POST">
							<input type="hidden" name="eventID">
							<input type="hidden" name="eventIndex">
						</form>
						<form name="htmlform_events_specific_display" action="events-specific.dsp" method="GET">
							<input type="hidden" name="fromDateValue" value="%value fromDateValue encode(htmlattr)%">
							<input type="hidden" name="fromTimeValue" value="%value fromTimeValue encode(htmlattr)%">
							<input type="hidden" name="toDateValue" value="%value toDateValue encode(htmlattr)%">
							<input type="hidden" name="toTimeValue" value="%value toTimeValue encode(htmlattr)%">
							<input type="hidden" name="server" value="%value server encode(htmlattr)%">
							<input type="hidden" name="severity" value="%value severity encode(htmlattr)%">
							<input type="hidden" name="logFile" value="%value logFile encode(htmlattr)%">
							<input type="hidden" name="filterEventsWithNoAction" value="%value filterEventsWithNoAction encode(htmlattr)%">
							<input type="hidden" name="compareSeverityExactly" value="%value compareSeverityExactly encode(htmlattr)%">
							<input type="hidden" name="totalPages" value="%value totalPages encode(htmlattr)%">
							<input type="hidden" name="displayOrder" value="%value displayOrder encode(htmlattr)%">
							<input type="hidden" name="resultsPerPage" value="%value resultsPerPage encode(htmlattr)%">
							<input type="hidden" name="requestedPageNumber" value="%value requestedPageNumber encode(htmlattr)%">
							<input type="hidden" name="operation">
						</form>
					%endifvar%
						%ifvar filterByNoActionTaken equals('true')%
						<form name="htmlform_events_specific_action" action="events-specific.dsp" method="GET">
							<input type="hidden" name="fromDateValue" value="%value fromDateValue encode(htmlattr)%">
							<input type="hidden" name="fromTimeValue" value="%value fromTimeValue encode(htmlattr)%">
							<input type="hidden" name="toDateValue" value="%value toDateValue encode(htmlattr)%">
							<input type="hidden" name="toTimeValue" value="%value toTimeValue encode(htmlattr)%">
							<input type="hidden" name="server" value="%value server encode(htmlattr)%">
							<input type="hidden" name="severity" value="%value severity encode(htmlattr)%">
							<input type="hidden" name="logFile" value="%value logFile encode(htmlattr)%">
							<input type="hidden" name="filterByNoActionTaken" value="%value filterByNoActionTaken encode(htmlattr)%">
							<input type="hidden" name="action">
							<input type="hidden" name="operation">
						</form>
						<TABLE style="border-collapse: separate; border-spacing: 10px;"> 
							<tr> 
								<td>
						%endifvar%
						<TABLE class="tableView">
							<TR>
								<TD colspan=7 class="heading">Events Display Controls</TD>
							</TR>  
							<TR class="oddrow">
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
								<TD class="oddrow"> 
									%ifvar operation equals('show_rule_affected_events')%
										<INPUT type="submit" VALUE="Refresh" onClick="return populateForm(document.htmlform_rule_affected_events_display, 'refresh_current_display');">
									%else%
										<INPUT type="submit" VALUE="Refresh" onClick="return populateForm(document.htmlform_events_specific_display, 'refresh_current_display');">
									%endifvar%
								</TD>
							</TR>
						</TABLE>
					%ifvar filterByNoActionTaken equals('true')%
					</td>
					<td>
					<TABLE class="tableView">
							<TR>
								<TD colspan=7 class="heading">Action Controls</TD>
							</TR>  
							<TR class="oddrow">
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>
											<TD class="evenrowdata" colspan=2>
												&nbsp;
											</TD>
										</TR>
										<TR>
											<TD>
												Select action  
											</TD>
											<TD>
												<select id="selAction" name="action" required>
													<option selected value="NONE">Mark events as processed </option>
													<option disabled value="EMAIL">send email to default admin </option>
													<option disabled value="JIRA">Raise jira ticket assigned to default admin </option>
												</select> 
											</TD>
										</TR>
										<TR>  
											<TD colspan=2>
												*action will be performed for all events listed below.
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>                            
											<TD>
												&nbsp; 
											</TD>
											<TD>
												&nbsp; 
											</TD>
										</TR>
										<TR>                              
											<TD>
												 <INPUT type="submit" VALUE="Perform Action" onClick="return populateForm(document.htmlform_events_specific_action, 'perform_action');">
											</TD>
											<TD>
												&nbsp; 
											</TD>
										</TR>
										<TR>                              
											<TD>
												&nbsp;
											</TD>
											<TD>
												&nbsp; 
											</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
						</td>
					</tr></TABLE>
					%endifvar%
					</td>
				</tr>
				<tr>
					<td id="result" colspan="6" align="right"></td>
				</tr>
				<tr>
					<td>
						<table class="tableView" id="head" name="head">
							<tbody>
								<tr>
									<td class="heading" colspan="7">Monitoring Events</td>
								</tr>
								<tr class="subheading2">
									<td class="oddrow">Event Timestamp</td>
									<td class="oddrow">Server ID</td>
									<td class="oddrow">Event Code</td>
									<td class="oddrow">Severity</td>
									<td class="oddrow">Event Information</td>
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
									<td >%value sourceFileName%</td>
									<td>
										<a href="#"  onclick="handleEventDetailClick(document.htmlform_event_details, '%value eventESID%', '%value eventESIndex%');" id="moreInfo">
											<img src="images/ifcdot.gif" border="no">
										</a> 
									</td>
								</tr>
										%endloop%
									%else%
								<tr class="field" align="left">
									<TD colspan=7 class="oddrowdata-l">---------------------------------- no results ----------------------------------</TD>
								</tr>
									%endifvar%
 
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<input type="hidden" id="totalPages" name="totalPages" value="%value totalPages%">
					<td id="pagination" colspan="1" >
						%scope param(form='htmlform_events_specific_display')%
							%include pagination.dsp%
						%endscope%
					</td>
				</tr>
			</tbody>
		</table>          
         
	</div>
							
</BODY>
</HTML>