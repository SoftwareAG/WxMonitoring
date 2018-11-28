<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <link rel="stylesheet" TYPE="text/css" href="modal.css">
  <script src="webMethods.js.txt"></script>
  <script src="process-details.js"></script>
  <script SRC="common-navigation.js"></script>
  <script language="JavaScript">
  function validate(thisform)
    {
		if(0 == thisform.processID.value.length)
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
	
	function createPageState(processID) {
			
			var stateJSONObject = {};
			stateJSONObject.currentPageName = "process-detail.dsp";
			stateJSONObject.previousPageName = getLastPageName("process-detail.dsp");
			stateJSONObject.processID = processID;
			
			return stateJSONObject;
		}
		
	function onReturnClick() {
		
		var currentPageState = getPageState("process-detail.dsp");
		
		var previousPageState =  getPageState(currentPageState.previousPageName);
		cleanNavigationSequence();
		
		if(previousPageState.currentPageName=="processes-general.dsp"){
			var url = "processes-general.dsp?fromDateValue=" + previousPageState.fromDateValue + "&fromTimeValue=" + previousPageState.fromTimeValue + "&toDateValue=" + previousPageState.toDateValue + "&toTimeValue=" + previousPageState.toTimeValue + "&processStatus=" + previousPageState.processStatus + "&server=" + previousPageState.server + "&businessDomain=" + previousPageState.businessDomain + "&sortBy=" + previousPageState.sortBy +"&displayOrder=" + previousPageState.displayOrder + "&resultsPerPage=" + previousPageState.resultsPerPage + "&requestedPageNumber=" + previousPageState.requestedPageNumber;
		}else if(previousPageState.currentPageName=="processes-specific.dsp"){
			var url = "processes-specific.dsp?fromDateValue=" + previousPageState.fromDateValue + "&fromTimeValue=" + previousPageState.fromTimeValue + "&toDateValue=" + previousPageState.toDateValue + "&toTimeValue=" + previousPageState.toTimeValue + "&processStatus=" + previousPageState.processStatus + "&server=" + previousPageState.server + "&businessDomain=" + previousPageState.businessDomain + "&sortBy=" + previousPageState.sortBy + "&displayOrder=" + previousPageState.displayOrder + "&resultsPerPage=" + previousPageState.resultsPerPage + "&requestedPageNumber=" + previousPageState.requestedPageNumber + "&criteria=" + previousPageState.criteria;	
		}
		var res = encodeURI(url);
		
		location.href = url;
	}
	
  </script>
  <body>
    <table width="100%">
        <tr>
			<td class="breadcrumb" colspan="2"> 
				Processes &gt; General &gt; More Info
            </td>
        </tr>
			 %ifvar operation equals('goToMWSProcess')%
				%invoke wx.monitoring.gui.processes:getMWSURLForProcess%
			 %endinvoke%
			<script type="text/javascript">	
				var mwsURL = '%value mwsURL%';
				if(!mwsURL){
					var globalVariableKey = '%value processServerID%'+'_MWS_BASE_URL';
					alert("Please set IS Global variable with key: " + globalVariableKey);
				} else {
					var _open = window.open(mwsURL);
					if (_open == null || typeof(_open)=='undefined')
						alert("Turn off your pop-up blocker!");
				}
				
			</script>
			%endifvar%
			
			%ifvar operation equals('processSendEmail')%
				%invoke wx.monitoring.gui.common:performActionSendEmail%
				%endinvoke%
				%ifvar status%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value status encode(html)%</td></tr>
                %endif%
			%endifvar%
			
			%ifvar operation equals('processRaiseJIRA')%
				%invoke wx.monitoring.gui.common:performActionRaiseJIRA%
				%endinvoke%
				%ifvar status%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value status encode(html)%</td></tr>
                %endif%
			%endifvar%
			
            %invoke wx.monitoring.services.gui.processes:getProcessByID%
                %ifvar message%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
                %endif%
                %onerror%
                    <tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
            %endinvoke%
			<script>
				var stateJSONObject = createPageState('%value /processID%');
				var startNewNavigationSequence = false;
				savePageState("process-detail.dsp", stateJSONObject, startNewNavigationSequence);				
			</script>
        <tr>
            <td colspan="2">
                <ul class="listitems">
                    <li class="listitem">
						<a href="#"  onclick="onReturnClick();" id="return">
							<script>  
								var currentPageState = getPageState("process-detail.dsp");
								
								if(currentPageState.previousPageName == "processes-general.dsp") { 
									document.write("Return to general");
									} else if(currentPageState.previousPageName == "processes-specific.dsp"){
									document.write("Return to specific events");
								} else {
									document.write("Return");
								}
							</script>
						</a>
					</li>
                </ul>
            </td>
        </tr>
		<tr><td colspan="2">&nbsp;</td></tr>
        <tr>
            <td>
			
                        <table>
                            <tr>
								<td>
									<table class="tableView" id="head" name="head">
										<tbody>
											<tr>
												<td class="heading" colspan="2">Process Details</td>
											</tr>
											<tr>
												<td class="subheading">Server ID</td>    
												<td class="oddrow-l">
													%value process/serverID%
												</td>
											</tr>
											<tr>
												<td class="subheading">Business Domain</td>    
												<td class="oddrow-l">
													%value process/businessDomainBeautified%
												</td>
											</tr>
											<tr>
												<td class="subheading">Process ID</td>    
												<td class="oddrow-l">
													%value process/processESID%
												</td>
											</tr>
											<tr>
												<td class="subheading">Process Instance</td>    
												<td class="oddrow-l">
													%value process/processInstance%
												</td>
											</tr>
											<tr>
												<td class="subheading">Process Name</td>    
												<td class="oddrow-l">
													%value process/processName%
												</td>
											</tr>
											<tr>
												<td class="subheading">Current Status</td>    
												<td class="oddrow-l">
													%ifvar process/currentStatus equals('started')%Active %else% %ifvar process/currentStatus equals('completed')%Completed %else% %ifvar process/currentStatus equals('exception')%Exception %else% %ifvar process/currentStatus equals('failed')%Failed %else% %ifvar process/currentStatus equals('cancelled')%Cancelled %else% - %endifvar%%endifvar% %endifvar%%endifvar%%endifvar%
												</td>
											</tr>
											<tr>
												<td class="subheading">Started At</td>    
												<td class="oddrow-l">
													%value process/startedTimestamp%
												</td>
											</tr>
											
											<tr>
												<td class="subheading">Process Duration</td>    
												<td class="oddrow-l">
													%ifvar process/duration% %ifvar process/duration/days -notempty% %ifvar process/duration/days equals('0')% %else% %value process/duration/days% days %endifvar% %endifvar% %ifvar dprocess/uration/hours -notempty% %ifvar process/duration/hours equals('0')% %else% %value process/duration/hours% hrs %endifvar% %endifvar% %ifvar process/duration/minutes -notempty% %ifvar process/duration/minutes equals('0')% %else% %value process/duration/minutes% mins %endifvar% %endifvar% %ifvar process/duration/seconds -notempty% %ifvar process/duration/seconds equals('0')% ~0 sec %else% %value process/duration/seconds% sec %endifvar% %endifvar% %else% - %endifvar%
												</td>
											</tr>
											%ifvar process/failedTimestamp%
											<tr>
												<td class="subheading">Failed At</td>    
												<td class="oddrow-l">
													%value process/failedTimestamp%
												</td>
											</tr>
											%endifvar%
											%ifvar process/completedTimestamp%
											<tr>
												<td class="subheading">Completed At</td>    
												<td class="oddrow-l">
													%value process/completedTimestamp%
												</td>
											</tr>
											%endifvar%
											%ifvar process/cancelledTimestamp%
											<tr>
												<td class="subheading">Cancelled At</td>    
												<td class="oddrow-l">
													%value process/cancelledTimestamp%
												</td>
											</tr>
											%endifvar%
										</tbody>
									</table>
								</td>
							</tr>
							%ifvar process/exceptions%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr>
								<td>
									<table width="70%" class="tableView" id="head" name="head">
										<tbody>
											<tr>
												<td class="heading" colspan="7">Exception Details</td>
											</tr>
											<tr class="subheading2">
												<td class="subheading">Exception timestamp</td>
												<td class="subheading">Exception Step ID</td>
												<td class="subheading">Exception Message</td>
											</tr>
												%loop process/exceptions%
											<tr class="field">
												<td>%value exceptionTimestamp%</td>
												<td>%value stepID%</td>
												<td>%value exceptionMessage%</td>
											</tr>
												%endloop%
										</tbody>
									</table>
								</td>
							</tr> 
							%endifvar%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr>
								<td>
									<table width="70%" class="tableView" id="head" name="head">
										<tbody>
											<tr>
												<td class="heading" colspan="7">Log History</td>
											</tr>

												%loop process/logHistoryDesc%
											<tr class="field">
												<td>%value%</td>
											</tr>
												%endloop%
										</tbody>
									</table>
								</td>
							</tr>  
							%ifvar process/isActionTaken equals('true')%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr>
								<td>
									<table width="70%" class="tableView" id="head" name="head">
										<tbody>
											<tr>
												<td class="heading" colspan="7">Actions Taken</td>
											</tr>
											<tr class="subheading2">
												<td class="subheading">Taken On</td>
												<td class="subheading">Action Taken</td>												
												<td class="subheading">Reason</td>
												<td class="subheading">Rule ID</td>
											</tr>
												%loop process/actions%
											<tr class="field">
												<td>%value taken_on%</td>
												<td>%value action%</td>
												<td>%value reason%</td>
												<td>%value rule%</td>
											</tr>
												%endloop%
										</tbody>
									</table>
								</td>
							</tr> 
							%endifvar%
							<tr><td colspan="2">&nbsp;</td></tr>							
                            <tr>
                                <td class="action" colspan=3>
									<table width="70%" class="tableView" id="head" name="head">
										<tbody>
											<tr>
												<td class="heading" colspan="7">Take Action For This Event</td>
											</tr>
											<tr>
												<!--<td class="oddrow-l">
													<form name="htmlform_processDetails" action="monitoring-rules-processes-addedit.dsp" method="GET">
														<input type="hidden" name="operation">
														<input type="hidden" name="processESID" value = %value process/processESID%>
														<input type="submit" name="ruleFromProcess" value="Add rule for this process" onclick="return validate(this.form,'%value operation encode(javascript)%');">		
													</form>
												</td>-->
												<td class="oddrow-l">
													<form name="htmlform_process_mws" action="process-details.dsp" method="POST">
														<input type="hidden" name="operation">
														<input type="hidden" name="processESID" value = "%value process/processESID encode(htmlattr)%">
														<input type="hidden" name="processID" value = "%value process/processID encode(htmlattr)%">
														<input type="hidden" name="processServerID" value = "%value process/serverID encode(htmlattr)%">
														<input disabled type="submit" name="goToProcess" value="Go to Process in MWS" onclick="return populateForm(this.form,'goToMWSProcess');">
													</form>
												</td>
												<td class="oddrow-l">
													<form name="htmlform_process_action_email" action="action_email.dsp" method="POST">
														<input type="hidden" name="operation">
														<input type="hidden" name="emailEntity" value = "process">
														<input type="hidden" name="processESID" value = "%value process/processESID encode(htmlattr)%">
														<input type="hidden" name="processInstance" value = "%value process/processInstance encode(htmlattr)%">
														<input disabled type="submit" name="sendEmail" value="Send Email to Admin" onclick="return populateForm(this.form,'processSendEmail');">
													</form>
													
												</td>
												<td class="oddrow-l">
													<form name="htmlform_process_action_jira" action="action_jira.dsp" method="POST">
														<input type="hidden" name="operation">
														<input type="hidden" name="jiraEntity" value = "process">
														<input type="hidden" name="processESID" value = "%value process/processESID encode(htmlattr)%">
														<input type="hidden" name="processInstance" value = "%value process/processInstance encode(htmlattr)%">
														<input disabled type="submit" name="raiseJIRA" value="Raise JIRA Ticket" onclick="return populateForm(this.form,'processRaiseJIRA');">
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
  </body>   
</head>
