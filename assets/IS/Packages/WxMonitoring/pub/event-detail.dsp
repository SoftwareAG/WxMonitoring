<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <link rel="stylesheet" TYPE="text/css" href="modal.css">
  <script src="webMethods.js.txt"></script>
  <script SRC="common-navigation.js"></script>
  <script language="JavaScript">

    function validate(thisform)
    {
		if(0 == thisform.eventID.value.length)
            {
				alert("Invalid event to create rule.")
                return false;
			}
		//thisform.operation.value= 'event_rule_add';
        return true;
    }
    
	function populateForm(form , ruleID ,oper)
    {
        if('view_rule' == oper){
			form.operation.value = "view";
			form.ruleID.value = ruleID;
		}

        return true
    }
	
	function createPageState(eventIndex, eventID) {
			
			var stateJSONObject = {};
			stateJSONObject.currentPageName = "event-detail.dsp";
			stateJSONObject.previousPageName = getLastPageName("event-detail.dsp");
			stateJSONObject.eventIndex = eventIndex;
			stateJSONObject.eventID = eventID;
			
			return stateJSONObject;
		}
		
	function onReturnClick() {
		
		var currentPageState = getPageState("event-detail.dsp");
		
		var previousPageState =  getPageState(currentPageState.previousPageName);
		cleanNavigationSequence();
		if(previousPageState.currentPageName=="events-general.dsp"){
			var url = "events-general.dsp?fromDateValue=" + previousPageState.fromDateValue + "&fromTimeValue=" + previousPageState.fromTimeValue + "&toDateValue=" + previousPageState.toDateValue + "&toTimeValue=" + previousPageState.toTimeValue + "&severity=" + previousPageState.severity + "&server=" + previousPageState.server + "&logFile=" + previousPageState.logFile + "&displayOrder=" + previousPageState.displayOrder + "&resultsPerPage=" + previousPageState.resultsPerPage + "&requestedPageNumber=" + previousPageState.requestedPageNumber;
		} else if(currentPageState.previousPageName == "events-specific.dsp"){
			var url = "events-specific.dsp?fromDateValue=" + previousPageState.fromDateValue + "&fromTimeValue=" + previousPageState.fromTimeValue + "&toDateValue=" + previousPageState.toDateValue + "&toTimeValue=" + previousPageState.toTimeValue + "&severity=" + previousPageState.severity + "&server=" + previousPageState.server + "&logFile=" + previousPageState.logFile + "&compareSeverityExactly=" + previousPageState.compareSeverityExactly  + "&filterEventsWithNoAction=" + previousPageState.filterEventsWithNoAction + "&displayOrder=" + previousPageState.displayOrder + "&resultsPerPage=" + previousPageState.resultsPerPage + "&requestedPageNumber=" + previousPageState.requestedPageNumber;
		
		} else if(currentPageState.previousPageName == "import-data-manage.dsp"){
			var url = "import-data-manage.dsp?entity=" + previousPageState.entity + "&filterCriteria=" + previousPageState.filterCriteria + "&timeRange=" + previousPageState.timeRange + "&filterImportedData=" + previousPageState.filterImportedData;	
		} else{
			var url = "events-specific.dsp?fromDateValue=" + previousPageState.fromDateValue + "&fromTimeValue=" + previousPageState.fromTimeValue + "&toDateValue=" + previousPageState.toDateValue + "&toTimeValue=" + previousPageState.toTimeValue + "&severity=" + previousPageState.severity + "&server=" + previousPageState.server + "&logFile=" + previousPageState.logFile + "&compareSeverityExactly=" + previousPageState.compareSeverityExactly  + "&filterEventsWithNoAction=" + previousPageState.filterEventsWithNoAction + "&displayOrder=" + previousPageState.displayOrder + "&resultsPerPage=" + previousPageState.resultsPerPage + "&requestedPageNumber=" + previousPageState.requestedPageNumber;	
		}
		var res = encodeURI(url);
		
		location.href = url;
	}

  </script>
 
  <body>
    <table width="100%">
        <tr>
			<td class="breadcrumb" colspan="2"> 
				Events &gt; General &gt; More Info
            </td>
        </tr>
		
		
			
		%ifvar operation equals('eventSendEmail')%
			%invoke wx.monitoring.gui.common:performActionSendEmail%
			%endinvoke%
			%ifvar status%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value status encode(html)%</td></tr>
			%endif%
		%endifvar%
			
		%ifvar operation equals('eventRaiseJIRA')%
			%invoke wx.monitoring.gui.common:performActionRaiseJIRA%
			%endinvoke%
			%ifvar status%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value status encode(html)%</td></tr>
			%endif%
		%endifvar%
		
		%ifvar operation equals('eventActionNone')%
			%invoke wx.monitoring.gui.common:performActionNone%
			%endinvoke%
			%ifvar status%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value status encode(html)%</td></tr>
			%endif%
		%endifvar%
		
		%invoke wx.monitoring.services.gui.events:getEventByID%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
			%endif%
			%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
		%endinvoke%
		<script>
			var stateJSONObject = createPageState('%value /eventID%','%value /eventIndex%');
			var startNewNavigationSequence = false;
			savePageState("event-detail.dsp", stateJSONObject, startNewNavigationSequence);				
		</script>
        <tr>
            <td colspan="2">
                <ul class="listitems">
                    <li class="listitem">
						<a href="#"  onclick="onReturnClick();" id="return">
							<script> 
								
								var currentPageState = getPageState("event-detail.dsp");
								if(currentPageState.previousPageName == "events-general.dsp") { 
									document.write("Return to general");
								} else if(currentPageState.previousPageName == "events-specific.dsp"){
									document.write("Return to specific events");
								} else if(currentPageState.previousPageName == "import-data-manage.dsp"){
									document.write("Return to manage imported data");
								}else {
									document.write("Return to general");
								}
							</script>
						</a>
					</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
                        <table>
                            <tr>
								<td>
									<table class="tableView" id="head" name="head">
										<tbody>
											<tr>
												<td class="heading" colspan="2">Event Details</td>
											</tr>
											<tr>
												<td class="oddrow">Event Timestamp</td>    
												<td class="oddrow-l">
													%value event/eventTimestamp%
												</td>
											</tr>
											<tr>
												<td class="oddrow">Server ID</td>    
												<td class="oddrow-l">
													%value event/serverID%
												</td>
											</tr>
											<tr>
												<td class="oddrow">Event Code</td>    
												<td class="oddrow-l">
													%value event/typeID%
												</td>
											</tr>
											<tr>
												<td class="oddrow">Severity</td>    
												<td class="oddrow-l">
													%value event/severity%
												</td>
											</tr>
											<tr>
												<td class="oddrow">Event Information</td>    
												<td class="oddrow-l">
													%value event/eventInformation%
												</td>
											</tr>
											<tr>
												<td class="oddrow">Complete Event Log</td>    
												<td class="oddrow-l">
													%value event/completeEventLog%
												</td>
											</tr>
											<tr>
												<td class="oddrow">Auto Evaluation Status</td>    
												<td class="oddrow-l">
													%ifvar event/lastEvaluated -notempty%  This event has been evaluated against existing active rules on %value event/lastEvaluated %.
													%else% This event is NOT yet evaluated against existing active rules
													%endifvar%
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table class="tableView" id="head" name="head">
										<tbody>
											<tr>
												<td class="heading" colspan="7">Actions Details</td>
											</tr>
											<tr class="subheading2">
												<td class="oddrow">Rule ID</td>
												<td class="oddrow">Action Timestamp</td>
												<td class="oddrow">Action Type</td>
												<td class="oddrow">Service Invoked</td>
												<td class="oddrow">Input Parameter</td>
											</tr>
											%ifvar event/actions%		
											%loop event/actions%
											<tr class="field">
												<td>%value ruleID%</td>
												<td >%value actionTimestamp%</td>
												<td >%value actionType%</td>
												<td >%ifvar serviceToInvoke -notempty%%value serviceToInvoke% %else% - %endifvar%</td>
												<td >%ifvar inputParam -notempty%%value inputParam%%else% - %endifvar%</td>
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
                            <tr style="display:none">
                                <td class="action" colspan=3>
									<table class="tableView" id="head" name="head">
										<tbody>
											<tr>
												<td class="heading" colspan="7">Take Action For This Event</td>
											</tr>
											<tr class="subheading2">
												<td class="oddrow-l">
													<form name="htmlform_eventDetails" action="monitoring-rules-addedit.dsp" method="POST">
														<input type="hidden" name="operation" value="event_rule_add">
														<input type="hidden" name="eventID" value = "%value event/eventESID encode(htmlattr)%">
														<input disabled type="submit" name="submit" value="Add rule for this event" onclick="return validate(this.form);">
													</form>
												</td>
												<td class="oddrow-l">
													<form name="htmlform_event_action_email" action="action_email.dsp" method="POST">
														<input type="hidden" name="operation" value="eventSendEmail">
														<input type="hidden" name="emailEntity" value = "event">
														<input type="hidden" name="eventID" value = "%value event/eventESID encode(htmlattr)%">
														<input type="hidden" name="eventIndex" value = "%value event/ESIndexName encode(htmlattr)%">
														<input disabled type="submit" name="sendEmail" value="Send Email to Admin" onclick="return validate(this.form);">
													</form>
												</td>
												<td class="oddrow-l">
													<form name="htmlform_event_action_jira" action="action_jira.dsp" method="POST">
														<input type="hidden" name="operation" value="eventRaiseJIRA">
														<input type="hidden" name="jiraEntity" value = "event">
														<input type="hidden" name="eventID" value = "%value event/eventESID encode(htmlattr)%">
														<input type="hidden" name="eventIndex" value = "%value event/ESIndexName encode(htmlattr)%">
														<input disabled type="submit" name="raiseJIRA" value="Raise JIRA Ticket" onclick="return validate(this.form);">
													</form>
												</td>
												<td class="oddrow-l">
													<form name="htmlform_event_action_none" action="event-details.dsp" method="POST">
														<input type="hidden" name="operation" value="eventActionNone">
														<input type="hidden" name="actionEntity" value = "event">
														<input type="hidden" name="eventID" value = "%value event/eventESID encode(htmlattr)%">
														<input type="hidden" name="eventIndex" value = "%value event/ESIndexName encode(htmlattr)%">
														<input disabled type="submit" name="actionNone" value="Mark event as processed" onclick="return validate(this.form);">
													</form>
												</td>
											</tr>
										</tbody>
									</table>
									
								</td>
							</tr>
					</table>
            </td>
		</tr>
    </table>
	<form name="htmlform_rule_view" action="monitoring-rule.dsp" method="POST">
        <input type="hidden" name="operation">
        <input type="hidden" name="ruleID">
    </form>
  </body>   
</head>
