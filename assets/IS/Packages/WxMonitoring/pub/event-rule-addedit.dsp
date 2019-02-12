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
		if(oper=="insert_rule"){
			thisform.action.value= 'insertRule';
			thisform.operation.value= 'display';
		} else if(oper=="update_rule") {
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
		
		var actionTypeValue = actionTypeRadio.value;
		var actionServiceNameRow = document.getElementById("action_serviceNameRow");
		//var actionServiceNameCol1 = document.getElementById("action_serviceNameColumn1");
		var actionServiceNameCol2 = document.getElementById("action_serviceNameColumn2");
		var actionInputParamRow = document.getElementById("action_inputParam");
		if(actionTypeValue=="none"){
			actionServiceNameRow.style.display ="none";
			//actionServiceNameCol1.style.display ="none";
			//actionServiceNameCol2.style.display ="none";
			
			actionInputParamRow.style.display ="none";
		} else{
			actionServiceNameRow.style.display ="";
			//actionServiceNameCol1.style.display ="";
			//actionServiceNameCol2.style.display ="";
			
			actionInputParamRow.style.display ="";
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
			%ifvar message%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
			%endif%
			%onerror%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
			%endinvoke%
			%ifvar status%
					<tr><td colspan="2">&nbsp;</td></tr>
					<tr><td class="message" colspan="2">%value status encode(html)%</td></tr>
			%endif%						
		%endifvar%
		
		%ifvar operation equals('add')%
		%else%
			%invoke wx.monitoring.services.gui.events:getEventRuleByID%
					%ifvar message%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
					%endif%
					%onerror%
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
			%endinvoke%
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
								<li class="listitem"><a href="event-rule-addedit.dsp?operation=edit&ruleID=%value ruleID encode(url)%">Edit Rule</a></li>
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
					<input type="hidden" name="ruleRank" value = "%value ruleRank encode(htmlattr)%">
					<input type="hidden" name="action">
					%else%
					<input type="hidden" name="ruleID" value = "%value ruleID encode(htmlattr)%">
					<input type="hidden" name="ruleRank" value = "%value ruleRank encode(htmlattr)%">
					<input type="hidden" name="action">
				%endifvar%
                        <table class="tableView" width="25">
                            <tr>
                                <td class="heading" colspan="2">Monitoring Rule</td>
                            </tr>
                            <tr>
                                <td class="subheading">Event Pattern</td>    
                                <td class="oddrow-l">
									<textarea id="eventPattern" rows="4" cols="40" name="eventPattern" %ifvar operation equals('display')% disabled %else% required %endifvar% >%value rule/eventPattern% </textarea>
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
									<select id="selSeverityOperator" name="severityThresholdOperator" required>
										<option %ifvar rule/severityThresholdOperator equals('gte')%selected %endifvar% value="gte" %ifvar operation equals('display')% disabled %else% required %endifvar%> >= </option> 
										<option %ifvar rule/severityThresholdOperator% %ifvar rule/severityThresholdOperator equals('eq')%selected %endifvar% %else% selected %endifvar% value="eq" %ifvar operation equals('display')% disabled %else% required %endifvar%> = </option> 
										<option %ifvar rule/severityThresholdOperator equals('lte')%selected %endifvar% value="lte" %ifvar operation equals('display')% disabled %else% required %endifvar%> <= </option> 
									</select>  
									
									<select id="selSeverity" name="severity" required>
										<option %ifvar rule/severityThreshold equals('FATAL')%selected %endifvar% value="FATAL" %ifvar operation equals('display')% disabled %else% required %endifvar% >Fatal </option>
										<option %ifvar rule/severityThreshold equals('ERROR')%selected %endifvar% value="ERROR" %ifvar operation equals('display')% disabled %else% required %endifvar%>Error</option>
										<option %ifvar rule/severityThreshold equals('WARNING')%selected %endifvar% value="WARNING" %ifvar operation equals('display')% disabled %else% required %endifvar%>Warning</option>
										<option %ifvar rule/severityThresholdOperator% %ifvar rule/severityThreshold equals('INFO')%selected %endifvar% %else% selected %endifvar% value="INFO" %ifvar operation equals('display')% disabled %else% required %endifvar%>Info</option>
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
									<input type="text" name="serviceName" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value rule/action/serviceToInvoke%'>
                                </td>
                            </tr>
							<tr id="action_inputParam" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('none')%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading" >Input Parameter</td>
                                <td class="oddrow-l" >
									<textarea id="inputParam" rows="2" cols="40" name="inputParam" title="If more than one parameter is required, write parameters as JSON and handle it accordingly in the invoked service" %ifvar operation equals('display')% disabled %endifvar% >%value rule/action/inputParam% </textarea>
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
									<input type="submit" name="submit" value="Save Changes" %ifvar operation equals('add')% onclick="return validate(this.form,'insert_rule');" %else% onclick="return validate(this.form,'update_rule');" %endifvar%>
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
