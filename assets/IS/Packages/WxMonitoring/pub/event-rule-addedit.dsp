<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <script src="webMethods.js.txt"></script>
  <script SRC="common-navigation.js"></script>
  <script language="JavaScript">

    function validate(thisform,oper)
    {	
		//alert(thisform.ruleRank.value);
		var rulePattern = thisform.eventPattern.value
		if(0 == rulePattern.length)
		{
			alert("You must specify a valid value for the field : 'Event Pattern'")
			thisform.eventPattern.focus();
			return false;
		} else if (8000 < rulePattern.length) {
			alert("'Event Pattern' field cannot exceed 8000 characters.")
			thisform.eventPattern.focus();
			return false;
		} else{	
			if(thisform.useRegex.value == "true"){
				
				var isValidRegex = true;
				
				try {
					var e = new RegExp(rulePattern);
				} catch(e) {
					isValidRegex = false;
				}

				if(!isValidRegex) {
					alert("'Event Pattern' : '" + thisform.eventPattern.value +"' is an invalid regular expression.")
					thisform.eventPattern.focus();
					return false;
				}
			} else {
				thisform.eventPattern.value = trimStr(thisform.eventPattern.value);
			}
		}
		
		/* Validate email input.
		if(0 < thisform.adminEmail.value.length){
			var emailsStr = thisform.adminEmail.value;
			var emailList = emailsStr.split(',');
			emailList = cleanArray(emailList);
			for(var i = 0; i < emailList.length; i++) {
					// Trim the excess whitespace.
				var email = trimStr(emailList[i]);
				if(!validateEmail(email)){
					alert("Invalid email: '" + email + "' in 'Admin Email' field.");
					thisform.adminEmail.focus();
					return false;
				}
			}
		}
		
		if(0 < thisform.adminJIRAUsername.value.length){
			thisform.adminJIRAUsername.value = trimStr(thisform.adminJIRAUsername.value);
		}*/
		if(oper=="insert"){
			thisform.action.value= 'insertRule';
			thisform.operation.value= 'display';
		} else if(oper=="update") {
			//alert(thisform.ruleRank.value);
			thisform.action.value= 'updateRule';
			thisform.operation.value= 'display';
		}
		
        return true;
    }
	
	function populateForm(thisform,ruleID, oper)
    {
		thisform.ruleID.value = ruleID;
		thisform.operation.value = oper; 
		thisform.submit();
	}
	/* Used for validating email input.
    function cleanArray(actual) {
		var newArray = new Array();
		for (var i = 0; i < actual.length; i++) {
			if (actual[i]) {
				newArray.push(actual[i]);
			}
		}
		return newArray;
	}
	
	function validateEmail(email) {
		var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(String(email).toLowerCase());
	}
	*/
	
    function trimStr(str) {
      return str.replace(/^\s+|\s+$/g, '');
    }
 	
	function createPageState(ruleID, ruleRank) {
		var stateJSONObject = {};
		stateJSONObject.currentPageName = "events-rule-addedit.dsp";
		stateJSONObject.previousPageName = getLastPageName("event-rules.dsp");
		stateJSONObject.ruleID = ruleID;
		stateJSONObject.ruleRank = ruleRank;
	
		return stateJSONObject;
	}
	
	function onReturnClick() {
		
		var currentPageState = getPageState("events-rule-addedit.dsp");
		var previousPageState =  getPageState(currentPageState.previousPageName);
		cleanNavigationSequence();
		
		if(previousPageState.currentPageName=="event-rules.dsp"){
			var url = "event-rules.dsp";
		}
		var res = encodeURI(url);
		
		location.href = res;	
	}
	
	function handleActionTypeClick(actionTypeRadio) {
		action_triggerFrequency
		var actionTypeValue = actionTypeRadio.value;
		var actionServiceNameRow = document.getElementById("action_serviceNameRow");
		var actionInputParamRow = document.getElementById("action_inputParam");
		var actionTriggerFrequencyRow = document.getElementById("action_triggerFrequency");
		if(actionTypeValue=="none"){
			actionServiceNameRow.style.display ="none";			
			actionInputParamRow.style.display ="none";
			actionTriggerFrequencyRow.style.display ="none";
		} else{
			actionServiceNameRow.style.display ="";
			actionInputParamRow.style.display ="";
			actionTriggerFrequencyRow.style.display ="";
		}
	}

  </script>
 
  <body>
    <table width="100%">
        <tr>
			<td class="breadcrumb" colspan="2"> 
				Events &gt; Rules &gt; %value ruleID%
            </td>
        </tr>
         
		 %ifvar action%
			%invoke wx.monitoring.services.gui.events:handleEventRuleAddeditDspAction%
			%endinvoke%
			%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
					<td class="message" colspan="2">%value message encode(html)%
			%ifvar errorMessage%
						: <i>%value errorMessage encode(html)%</i>
			%endif%
			%ifvar status%
						: <i>%value status encode(html)%</i>
			%endif%
					</td>
				</tr>
			%endif%						
		%endifvar%
		
		%ifvar operation equals('add')%
		%else%
			%invoke wx.monitoring.services.gui.events:getEventRuleByID%
			%endinvoke%
				%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr>
						<td class="message" colspan="2">%value message encode(html)%
				%ifvar errorMessage%
							: <i>%value errorMessage encode(html)%</i>
				%endif%
				%ifvar status%
							: <i>%value status encode(html)%</i>
				%endif%
						</td>
					</tr>
				%endif%	
		%endifvar%
		<script>
			var stateJSONObject = createPageState('%value /ruleID encode(javascript)%','%value /ruleRank encode(javascript)%');
			
			var startNewNavigationSequence = false;
			savePageState("event-rule-addedit.dsp", stateJSONObject, startNewNavigationSequence);				
		</script>
        <tr>
            <td colspan="2">
                <ul class="listitems">
					%ifvar operation equals('add')%
						<li class="listitem"><a href="javascript:document.htmlform_event_rules.submit();" onClick="return onReturnClick();">Return to Rules</a></li>
					%else%
						%ifvar operation equals('edit')%
							<li class="listitem"><a href="event-rule-addedit.dsp?operation=display&ruleID=%value ruleID encode(url)%">Cancel</a></li>
							%else%
								<li class="listitem"><a href="javascript:document.htmlform_event_rules.submit();" onClick="return onReturnClick();">Return to Rules</a></li>
								<li class="listitem"><a href="event-rule-addedit.dsp?operation=edit&ruleID=%value ruleID encode(url)%&ruleRank=%value ruleRank encode(url)%">Edit Rule</a></li>
								<li class="listitem"><a href=# onClick="return populateForm(document.htmlform_rule_affected_events_display, '%value ruleID encode(javascript)%', 'show_rule_affected_events');">Show Events Affected By This Rule</a></li>
						%endifvar%
					%endifvar%
                </ul>
            </td>
        </tr>
        <tr>
            <td>
            <form name="htmlform_rule_addedit" action="event-rule-addedit.dsp" method="POST">
                <input type="hidden" name="operation">
				%ifvar operation equals('add')%
					<input type="hidden" name="ruleRank" value = "%value /ruleRank encode(htmlattr)%">
					<input type="hidden" name="action">
					%else%
					<input type="hidden" name="ruleID" value = "%value ruleID encode(htmlattr)%">
					<input type="hidden" name="ruleRank" value = "%value /ruleRank encode(htmlattr)%">
					<input type="hidden" name="action">
					<input type="hidden" name="createdOn" value = "%value rule/createdOn encode(htmlattr)%">
				%endifvar%
                        <table class="tableView">
                            <tr>
                                <td class="heading" colspan="2">Monitoring Rule</td>
                            </tr>
                            <tr>
                                <td class="subheading">Event Pattern</td>    
                                <td class="oddrow-l">
									<textarea id="eventPattern" rows="4" cols="40" name="eventPattern" %ifvar operation equals('display')% disabled %else% required %endifvar% >%value rule/eventPattern%</textarea>
                                </td>
                            </tr>
							<tr>
                                <td class="subheading" >Use Regex</td>
                                <td class="oddrow-l" >
									<input type="radio" name="useRegex" value="true" %ifvar rule/useRegex equals('true')%checked="checked" %endifvar% title="Event pattern is matched using regular expression" %ifvar operation equals('display')% disabled %else% required %endifvar%> Yes &nbsp;&nbsp;&nbsp;&nbsp; <a href="https://regex101.com/" target="_blank">Regex creator (external link)</a>								<br>
									<input type="radio" name="useRegex" value="false" %ifvar rule/useRegex% %ifvar rule/useRegex equals('false')%checked="checked" %endifvar% %else% checked="checked" %endifvar% title="Event pattern is not matched using regular expression" %ifvar operation equals('display')% disabled %else% required %endifvar%> No<br>
                                </td>
                            </tr>
							<tr>
                                <td class="subheading">Severity Threshold</td>    
                                <td class="oddrow-l">
									<select id="selSeverityOperator" name="severityThresholdOperator" title="Trigger rule if event severity matches severity threshold limit" required>
										<option %ifvar rule/severity/severityThresholdOperator equals('gte')%selected %endifvar% value="gte" %ifvar operation equals('display')% disabled %else% required %endifvar%> >= </option> 
										<option %ifvar rule/severity/severityThresholdOperator% %ifvar rule/severity/severityThresholdOperator equals('eq')%selected %endifvar% %else% selected %endifvar% value="eq" %ifvar operation equals('display')% disabled %else% required %endifvar%> = </option> 
										<option %ifvar rule/severity/severityThresholdOperator equals('lte')%selected %endifvar% value="lte" %ifvar operation equals('display')% disabled %else% required %endifvar%> <= </option> 
									</select>  
									
									<select id="selSeverity" name="severityThreshold" required>
										<option %ifvar rule/severity/severityThreshold equals('FATAL')%selected %endifvar% value="FATAL" %ifvar operation equals('display')% disabled %else% required %endifvar% >FATAL </option>
										<option %ifvar rule/severity/severityThreshold equals('ERROR')%selected %endifvar% value="ERROR" %ifvar operation equals('display')% disabled %else% required %endifvar%>ERROR</option>
										<option %ifvar rule/severity/severityThreshold equals('WARNING')%selected %endifvar% value="WARNING" %ifvar operation equals('display')% disabled %else% required %endifvar%>WARNING</option>
										<option %ifvar rule/severity/severityThreshold% %ifvar rule/severity/severityThreshold equals('INFO')%selected %endifvar% %else% selected %endifvar% value="INFO" %ifvar operation equals('display')% disabled %else% required %endifvar%>INFO</option>
									</select>                                 
                                </td>
                            </tr>
                            <tr>
                                <td class="subheading" >Perform Action</td>
                                <td class="oddrow-l" >
									<input type="radio" name="actionType" value="none" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('none')% checked="checked"  %endifvar%  %else% checked="checked" %endifvar% %ifvar operation equals('display')% disabled %else% onclick="handleActionTypeClick(this);" required %endifvar%> Ignore event<br>
									<input type="radio" name="actionType" value="invokeService" %ifvar rule/action/actionType equals('invokeService')% checked="checked"  %endifvar% %ifvar operation equals('display')% disabled %else% onclick="handleActionTypeClick(this);" required %endifvar%> Invoke action handler service
                                </td>
                            </tr>
							
							<tr id="action_serviceNameRow" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('none')%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading" >Service Name</td>
                                <td class="oddrow-l" >
									<input type="text" placeholder="for e.g. wx.monitoring.impl.actionHandler:sendEmail" name="serviceToInvoke" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value rule/action/serviceToInvoke%'>
                                </td>
                            </tr>
							<tr id="action_inputParam" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('none')%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading" >Input Parameter</td>
                                <td class="oddrow-l" >
									<textarea placeholder="{
  &quot;param1&quot; : &quot;value1&quot;,
  &quot;param2&quot; : &quot;value2&quot;
}" id="inputParam" rows="2" cols="40" name="inputParam" title="If more than one parameter is required, write parameters as JSON and handle it accordingly in the invoked service" %ifvar operation equals('display')% disabled %endifvar%>%value rule/action/inputParam%</textarea>
                                </td>
                            </tr>
							
							<tr id="action_triggerFrequency" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('none')%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading" >Action Trigger Frequency</td>
                                <td class="oddrow-l" >
									<input type="radio" name="triggerActionForEachMatchingEvent" value="true" %ifvar rule/triggerActionForEachMatchingEvent equals('true')% checked="checked"  %endifvar% %ifvar operation equals('display')% disabled %else%  required %endifvar%> Trigger individual action for each matching event<br>
									<input type="radio" name="triggerActionForEachMatchingEvent" value="false" %ifvar rule/triggerActionForEachMatchingEvent% %ifvar rule/triggerActionForEachMatchingEvent equals('false')% checked="checked"  %endifvar%  %else% checked="checked" %endifvar% %ifvar operation equals('display')% disabled %else% required %endifvar%> Trigger common action for all matching events
                                </td>
                            </tr>
							
							<tr>
                                <td class="subheading" >Enable Rule</td>
                                <td class="oddrow-l" >
									<input type="radio" name="isActive" value="true" %ifvar rule/isActive% %ifvar rule/isActive equals('true')%checked="checked" %endifvar% %else% checked="checked" %endifvar% title="Activate this rule" %ifvar operation equals('display')% disabled %else% required %endifvar%> Yes<br>
									<input type="radio" name="isActive" value="false" %ifvar rule/isActive equals('false')%checked="checked" %endifvar% title="Deactivate this rule" %ifvar operation equals('display')% disabled %else% required %endifvar%> No
                                </td>
                            </tr>
							%ifvar operation equals('display')%
							%else%
                            <tr>
                                <td class="action" colspan=3>
									<input type="submit" name="submit" value="Save Changes" %ifvar operation equals('add')% onclick="return validate(this.form,'insert');" %else% onclick="return validate(this.form,'update');" %endifvar%>
                                </td>
							</tr>
							%endifvar%
					</form>
				</table>
            </td>
        </tr> 
    </table>
    <form name="htmlform_rule_affected_events_display" action="event-stats-specific.dsp" method="POST">
        <input type="hidden" name="operation">
        <input type="hidden" name="ruleID">
    </form>
	<form name="htmlform_event_rules" action="event-rules.dsp" method="POST">
    </form>
  </body>   
</head>
