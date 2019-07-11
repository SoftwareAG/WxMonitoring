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
		var processName = thisform.processName.value
		if(0 == processName.length)
		{
			alert("You must specify a valid value for the field : 'Process Name'")
			thisform.processName.focus();
			return false;
		} else if (8000 < processName.length) {
			alert("'Process Name' field cannot exceed 8000 characters.")
			thisform.processName.focus();
			return false;
		} else{	
			if(thisform.useRegex.value == "true"){
				
				var isValidRegex = true;
				
				try {
					var e = new RegExp(processName);
				} catch(e) {
					isValidRegex = false;
				}

				if(!isValidRegex) {
					alert("'Process Name' : '" + thisform.processName.value +"' is an invalid regular expression.")
					thisform.processName.focus();
					return false;
				}
			} else {
				//TODO: Allow intentional space characters at the end and beginning of string.
				thisform.processName.value = trimStr(thisform.processName.value);
			}
		}
		
		// Validate email input.
		if(thisform.actionType="email"){
			if(0 < thisform.actionEmailTo.value.length){
				var emailsStr = thisform.actionEmailTo.value;
				var emailList = emailsStr.split(',');
				emailList = cleanArray(emailList);
				for(var i = 0; i < emailList.length; i++) {
						// Trim the excess whitespace.
					var email = trimStr(emailList[i]);
					if(!validateEmail(email)){
						alert("Invalid email: '" + email + "' in 'Send email to' field.");
						thisform.actionEmailTo.focus();
						return false;
					}
				}
			}
		}
		
		if(thisform.actionType="jira"){
			if(0 < thisform.actionJiraAssignTo.value.length){
				thisform.actionJiraAssignTo.value = trimStr(thisform.actionJiraAssignTo.value);
			}
		}

		populateForm(thisform, oper);

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
	
	function populateForm(thisform, oper)
    {
		if(oper=="insert"||oper=="update"){
			//create JSON for action properties
			var actionPropertiesJSONObject = {};
			if(thisform.actionType.value=="email"){
				actionPropertiesJSONObject.sendEmailTo = thisform.actionEmailTo.value;
			}else if(thisform.actionType.value=="jira"){
				actionPropertiesJSONObject.jiraAssigneeUsername = thisform.actionJiraAssignTo.value;
				actionPropertiesJSONObject.jiraProjectKey = thisform.actionJiraProjectKey.value;
				actionPropertiesJSONObject.jiraIssueType = thisform.actionJiraIssueType.value;
				actionPropertiesJSONObject.jiraIssuePriority = thisform.actionJiraIssuePriority.value;

			}else if(thisform.actionType.value=="service"){
				actionPropertiesJSONObject.customServiceToInvoke = thisform.serviceToInvoke.value;
				actionPropertiesJSONObject.customServiceInputParams = thisform.inputParam.value;
			}
			
			var json = JSON.stringify(actionPropertiesJSONObject);
			thisform.actionProperties.value = json;

		} else{
			// thisform.ruleID.value = ruleID;
			// thisform.operation.value = oper; 
			// thisform.submit();
		}
	}
	// Used for validating email input.
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
	
	
    function trimStr(str) {
      return str.replace(/^\s+|\s+$/g, '');
    }
 	
	function createPageState(ruleID, ruleRank) {
		var stateJSONObject = {};
		stateJSONObject.currentPageName = "process-rule-addedit.dsp";
		stateJSONObject.previousPageName = getLastPageName("process-rules.dsp");
		stateJSONObject.ruleID = ruleID;
		stateJSONObject.ruleRank = ruleRank;
	
		return stateJSONObject;
	}
	
	function onReturnClick() {
		
		var currentPageState = getPageState("process-rule-addedit.dsp");
		var previousPageState =  getPageState(currentPageState.previousPageName);
		cleanNavigationSequence();
		
		if(previousPageState.currentPageName=="process-rules.dsp"){
			var url = "process-rules.dsp";
		}
		var res = encodeURI(url);
		
		location.href = res;	
	}
	
	function handleStatusOptionChange(){
		var statusValue = document.getElementById("selStatus").value;
		var maxProcessDurationRow = document.getElementById("maxProcessDuration_row");

		if(statusValue=="active"){

			maxProcessDurationRow.style.display ="";

		}else{

			maxProcessDurationRow.style.display ="none";
		}
	}

	function handleActionControls(jiraProjectPropertiesPipelineJSON, currentRuleJSON) {
		
		var actionTypeValue = document.getElementById("selActionType").value;

		//define controls related to action email
		var actionEmailSendEmailToRow = document.getElementById("action_email_to_row");

		//define controls related to action jira
		var actionJiraAssignTo = document.getElementById("action_jira_assignTo_row");
		var actionJiraProjectKey = document.getElementById("action_jira_projectKey_row");
		var actionJiraIssueType = document.getElementById("action_jira_issueType_row");
		var actionJiraIssuePriority = document.getElementById("action_jira_issuePriority_row");

		//define controls related to action service
		var actionServiceNameRow = document.getElementById("action_service_serviceName_row");
		var actionServiceInputParamRow = document.getElementById("action_service_inputParam_row");

		//define controls common to all action (except ignore action)
		var actionTriggerFrequencyRow = document.getElementById("action_triggerFrequency");

		if(actionTypeValue=="ignore"){

			//hide controls related to action email
			actionEmailSendEmailToRow.style.display ="none";			

			//hide controls related to action jira
			actionJiraAssignTo.style.display ="none";			
			actionJiraProjectKey.style.display ="none";
			actionJiraIssueType.style.display ="none";
			actionJiraIssuePriority.style.display ="none";

			//hide controls related to action service
			actionServiceNameRow.style.display ="none";			
			actionServiceInputParamRow.style.display ="none";

			//hide controls common to all action (except ignore action)
			actionTriggerFrequencyRow.style.display ="none";
		} else if(actionTypeValue=="email"){
			//display controls related to action email
			actionEmailSendEmailToRow.style.display ="";			

			//hide controls related to action jira
			actionJiraAssignTo.style.display ="none";			
			actionJiraProjectKey.style.display ="none";
			actionJiraIssueType.style.display ="none";
			actionJiraIssuePriority.style.display ="none";

			//hide controls related to action service
			actionServiceNameRow.style.display ="none";			
			actionServiceInputParamRow.style.display ="none";

			//display controls common to all action (except ignore action)
			actionTriggerFrequencyRow.style.display ="";
		} else if (actionTypeValue=="jira"){
			
			
			if(jiraProjectPropertiesPipelineJSON){
				createJiraProjectKeySelectOptions(jiraProjectPropertiesPipelineJSON, currentRuleJSON);
			}
			
			//hide controls related to action email
			actionEmailSendEmailToRow.style.display ="none";			

			//display controls related to action jira
			actionJiraAssignTo.style.display ="";			
			actionJiraProjectKey.style.display ="";
			actionJiraIssueType.style.display ="";
			actionJiraIssuePriority.style.display ="";

			//hide controls related to action service
			actionServiceNameRow.style.display ="none";			
			actionServiceInputParamRow.style.display ="none";

			//display controls common to all action (except ignore action)
			actionTriggerFrequencyRow.style.display ="";

		}else if(actionTypeValue=="service"){
			//hide controls related to action email
			actionEmailSendEmailToRow.style.display ="none";			

			//hide controls related to action jira
			actionJiraAssignTo.style.display ="none";			
			actionJiraProjectKey.style.display ="none";
			actionJiraIssueType.style.display ="none";
			actionJiraIssuePriority.style.display ="none";

			//hide controls related to action service
			actionServiceNameRow.style.display ="";			
			actionServiceInputParamRow.style.display ="";

			//display controls common to all action (except ignore action)
			actionTriggerFrequencyRow.style.display ="";
		}
	}

	function createJiraProjectKeySelectOptions(jiraProjectPropertiesPipelineJSON, currentRuleJSON){
		var jiraProjectPropertiesJSON = JSON.parse(jiraProjectPropertiesPipelineJSON);
		var jiraProjectKeySelect = document.getElementById("actionJiraProjectKey");

		//remove all options
		for(var i = jiraProjectKeySelect.options.length - 1 ; i >= 0 ; i--)
			{
				jiraProjectKeySelect.remove(i);
			}
		
		// add options relating to current project.
		for(var i = jiraProjectPropertiesJSON.projects.length - 1 ; i >= 0 ; i--)
			{
				var o = document.createElement("option");
				o.value = jiraProjectPropertiesJSON.projects[i].key;
				o.text = jiraProjectPropertiesJSON.projects[i].name;
				o.title = jiraProjectPropertiesJSON.projects[i].name;
				jiraProjectKeySelect.appendChild(o);
			}
		
		if(currentRuleJSON!=null){
			var ruleJSON = JSON.parse(currentRuleJSON);
			jiraProjectKeySelect.value = ruleJSON.action.properties.jiraProjectKey;
		}
		createJiraIssueSelectOptions(jiraProjectPropertiesPipelineJSON,currentRuleJSON);
	}

	function createJiraIssueSelectOptions(jiraProjectPropertiesPipelineJSON, currentRuleJSON){
		var jiraProjectPropertiesJSON = JSON.parse(jiraProjectPropertiesPipelineJSON);
		var jiraProjectKeySelect = document.getElementById("actionJiraProjectKey");
		var jiraIssueSelect = document.getElementById("actionJiraIssueType");

		//remove all options
		for(var i = jiraIssueSelect.options.length - 1 ; i >= 0 ; i--)
			{
				jiraIssueSelect.remove(i);
			}
		

		// add options relating to current project.
		for(var i = jiraProjectPropertiesJSON.projects.length - 1 ; i >= 0 ; i--)
			{
				if(jiraProjectPropertiesJSON.projects[i].key==jiraProjectKeySelect.value){

					for(var j = jiraProjectPropertiesJSON.projects[i].issuetypes.length - 1 ; j >= 0 ; j--)
						{
							var o = document.createElement("option");
							o.value = jiraProjectPropertiesJSON.projects[i].issuetypes[j].id;
							o.text = jiraProjectPropertiesJSON.projects[i].issuetypes[j].name;
							o.title = jiraProjectPropertiesJSON.projects[i].issuetypes[j].description;
							jiraIssueSelect.appendChild(o);
							
						}
				}
			}
		
		if(currentRuleJSON!=null){
			var ruleJSON = JSON.parse(currentRuleJSON);
			jiraIssueSelect.value = ruleJSON.action.properties.jiraIssueType;
		}
		createJiraIssuePrioritySelectOptions(jiraProjectPropertiesPipelineJSON, currentRuleJSON);
	}

	function createJiraIssuePrioritySelectOptions(jiraProjectPropertiesPipelineJSON, currentRuleJSON){
		var jiraProjectPropertiesJSON = JSON.parse(jiraProjectPropertiesPipelineJSON);
		var jiraProjectKeySelect = document.getElementById("actionJiraProjectKey");
		var jiraIssueSelect = document.getElementById("actionJiraIssueType");
		var jiraPrioritySelect = document.getElementById("actionJiraIssuePriority");

		//remove all options
		for(var i = jiraPrioritySelect.options.length - 1 ; i >= 0 ; i--)
			{
				jiraPrioritySelect.remove(i);
			}

		// add options relating to current project.
		for(var i = jiraProjectPropertiesJSON.projects.length - 1 ; i >= 0 ; i--)
			{
				if(jiraProjectPropertiesJSON.projects[i].key==jiraProjectKeySelect.value){

					for(var j = jiraProjectPropertiesJSON.projects[i].issuetypes.length - 1 ; j >= 0 ; j--){
						if(jiraProjectPropertiesJSON.projects[i].issuetypes[j].id==jiraIssueSelect.value){
							for(var k = jiraProjectPropertiesJSON.projects[i].issuetypes[j].priority.allowedValues.length - 1 ; k >= 0 ; k--)
								{
									var o = document.createElement("option");
									o.value = jiraProjectPropertiesJSON.projects[i].issuetypes[j].priority.allowedValues[k].id;
									o.text = jiraProjectPropertiesJSON.projects[i].issuetypes[j].priority.allowedValues[k].name;
									o.title = jiraProjectPropertiesJSON.projects[i].issuetypes[j].priority.allowedValues[k].name;
									jiraPrioritySelect.appendChild(o);
								}
						}
					}
				}
			}

			if(currentRuleJSON!=null){
			var ruleJSON = JSON.parse(currentRuleJSON);
			jiraPrioritySelect.value = ruleJSON.action.properties.jiraIssuePriority;
		}

	}

  </script>
 
  <body>
    <table width="100%">
        <tr>
			<td class="breadcrumb" colspan="2"> 
				Process &gt; Rules &gt; %value ruleID%
            </td>
        </tr>
         
		 %ifvar action%
			%invoke wx.monitoring.services.gui.processes:handleProcessRuleAddeditDspAction%
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
			%invoke wx.monitoring.services.gui.processes:getProcessRuleByID%
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
		%invoke wx.monitoring.services.gui.processes:getProcessRuleAddeditDspInfoData%
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
		<script>
			var stateJSONObject = createPageState('%value /ruleID encode(javascript)%','%value /ruleRank encode(javascript)%');
			
			var startNewNavigationSequence = false;
			savePageState("process-rule-addedit.dsp", stateJSONObject, startNewNavigationSequence);				
		</script>
        <tr>
            <td colspan="2">
                <ul class="listitems">
					%ifvar operation equals('add')%
						<li class="listitem"><a href="javascript:document.htmlform_process_rules.submit();" onClick="return onReturnClick();">Return to Rules</a></li>
					%else%
						%ifvar operation equals('edit')%
							<li class="listitem"><a href="process-rule-addedit.dsp?operation=display&ruleID=%value ruleID encode(url)%">Cancel</a></li>
							%else%
								<li class="listitem"><a href="javascript:document.htmlform_process_rules.submit();" onClick="return onReturnClick();">Return to Rules</a></li>
								<li class="listitem"><a href="process-rule-addedit.dsp?operation=edit&ruleID=%value ruleID encode(url)%&ruleRank=%value ruleRank encode(url)%">Edit Rule</a></li>
								<!-- <li class="listitem"><a href=# onClick="return populateForm(document.htmlform_rule_affected_processes_display, '%value ruleID encode(javascript)%', 'show_rule_affected_processes');">Show Events Affected By This Rule</a></li> -->
						%endifvar%
					%endifvar%
                </ul>
            </td>
        </tr>
        <tr>
            <td>
            <form name="htmlform_rule_addedit" action="process-rule-addedit.dsp" method="POST">
                <input type="hidden" name="operation">
				<input type="hidden" name="actionProperties">
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
                                <td class="subheading">Business Domain</td>    
                                <td class="oddrow-l">
									%scope infoData%
										%rename ../rule/businessDomain businessDomain -copy%
										%rename ../operation operation -copy%
                                        <select id="selBusinessDomain" name="businessDomain" %ifvar operation equals('display')% disabled %endifvar%>
                                            %loop businessDomains%
                                            <option value="%value key encode(htmlattr)%" %ifvar businessDomain
                                                vequals(key)%selected %endifvar%>%value name encode(html)%</option>
                                            %endloop%
                                            <option value="ALL" %ifvar businessDomain equals('ALL')%selected %endifvar%>Any
                                            </option>
										</select>
										<script>
											var businessDomainValue = '%value businessDomain%';
											if(businessDomainValue){
												document.getElementById("selBusinessDomain").value = businessDomainValue;
											}
										</script>
                                    %endscope%
                                </td>
                            </tr>
                            <tr>
                                <td class="subheading">Process Name</td>    
                                <td class="oddrow-l">
                                    <input type="text" placeholder="Write name of the Process" name="processName" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value rule/processName%'>
                                </td>
                            </tr>
							<tr>
                                <td class="subheading" >Use Regex</td>
                                <td class="oddrow-l" >
									<input type="radio" name="useRegex" value="true" %ifvar rule/useRegex equals('true')%checked="checked" %endifvar% title="Process name is matched using regular expression" %ifvar operation equals('display')% disabled %else% required %endifvar%> Yes &nbsp;&nbsp;&nbsp;&nbsp; <a href="https://regex101.com/" target="_blank">Regex creator (external link)</a>								<br>
									<input type="radio" name="useRegex" value="false" %ifvar rule/useRegex% %ifvar rule/useRegex equals('false')%checked="checked" %endifvar% %else% checked="checked" %endifvar% title="Process name is not matched using regular expression" %ifvar operation equals('display')% disabled %else% required %endifvar%> No<br>
                                </td>
                            </tr>
							<tr>
                                <td class="subheading">Status</td>    
                                <td class="oddrow-l">
									<select id="selStatus" name="status" required onchange="handleStatusOptionChange()">
										<option %ifvar rule/status equals('active')%selected %endifvar% value="active" %ifvar operation equals('display')% disabled %else% required %endifvar%>Active</option> 
										<option %ifvar rule/status% %ifvar rule/status equals('failed')%selected %endifvar% %else% selected %endifvar% value="failed" %ifvar operation equals('display')% disabled %else% required %endifvar%>Failed</option> 
                                        <option %ifvar rule/status equals('cancelled')%selected %endifvar% value="cancelled" %ifvar operation equals('display')% disabled %else% required %endifvar%>Cancelled</option>
                                        <option %ifvar rule/status equals('completed')%selected %endifvar% value="completed" %ifvar operation equals('display')% disabled %else% required %endifvar%>Completed</option>
									</select>                                  
                                </td>
							</tr>
							<tr id="maxProcessDuration_row" %ifvar rule/status% %ifvar rule/status equals('active')% %else%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading">Maximum Process Duration (in minutes)</td>    
                                <td class="oddrow-l">
                                    <input type="number" placeholder="1440"  title="default is 1440 minutes (=24 hours)" name="maxProcessDuration" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value rule/maxProcessDuration%'>
                                </td>
                            </tr>
                            <tr>
                                <td class="subheading" >Perform Action</td>
                                <td class="oddrow-l" >
									<select id="selActionType" name="actionType" title="Action to perform" %ifvar operation equals('display')% disabled %else% required %endifvar% onchange="handleActionControls('%value infoData/jiraInfo/jiraProjectPropertiesJSON encode(javascript)%')">
										%ifvar infoData%
											%loop infoData/actionsConfiguration%
												<option value="%value actionType encode(htmlattr)%" %ifvar ../rule/action/actionType vequals(actionType)%selected %endifvar%>%value actionDisplayName encode(htmlattr)%
												</option>
											%endloop%
										%endifvar%
									</select> 
                                </td>
                            </tr>
							<tr id="action_email_to_row" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('email')% %else%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading" >Send email to</td>
                                <td class="oddrow-l" >
									<input type="text" placeholder="use ',' to separate email addresses" name="actionEmailTo" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value rule/action/properties/sendEmailTo%'>
                                </td>
                            </tr>
							
							<tr id="action_jira_assignTo_row" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('jira')% %else%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading" >Assign jira ticket to</td>
                                <td class="oddrow-l" >
									<input type="text" placeholder="write assignee jira username" name="actionJiraAssignTo" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value rule/action/properties/jiraAssigneeUsername%'>
                                </td>
                            </tr>
							<tr id="action_jira_projectKey_row" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('jira')% %else%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading" >Jira project key</td> 
								%ifvar infoData/jiraInfo/jiraProjectProperties%  
									<td class="oddrow-l">
										<select id="actionJiraProjectKey" name="actionJiraProjectKey" title="select jira Project key to create issue in" %ifvar operation equals('display')% disabled %endifvar% onchange="createJiraIssueSelectOptions('%value infoData/jiraInfo/jiraProjectPropertiesJSON encode(javascript)%')">
										</select> 
									</td> 
								%else%
									<td class="oddrow-l" >
										<input type="text" placeholder="write jira Project key (if available) to create issue in" id="actionJiraProjectKey" name="actionJiraProjectKey" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value rule/action/properties/jiraProjectKey%'>
									</td>
								%endIfvar%    
                            </tr>
							<tr id="action_jira_issueType_row" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('jira')% %else%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
								<td class="subheading" >Jira issue type</td>
							%ifvar infoData/jiraInfo/jiraProjectProperties% 
								<td class="oddrow-l" >
									<select id="actionJiraIssueType" name="actionJiraIssueType" title="select Jira issue type" %ifvar operation equals('display')% disabled %endifvar% onchange="createJiraIssuePrioritySelectOptions('%value infoData/jiraInfo/jiraProjectPropertiesJSON encode(javascript)%')">
									</select> 
                                </td>
							%else%	
								<td class="oddrow-l" >
									<input type="text" placeholder="write Jira issue type (default is 'bug')"  id="actionJiraIssueType" name="actionJiraIssueType" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value rule/action/properties/jiraIssueType%'>
                                </td>
							%endifvar%					 
                            </tr>

							<tr id="action_jira_issuePriority_row" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('jira')% %else%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading" >Jira issue priority</td>
								%ifvar infoData/jiraInfo/jiraProjectProperties% 
									<td class="oddrow-l" >
										<select id="actionJiraIssuePriority" name="actionJiraIssuePriority" title="select Jira issue priority" %ifvar operation equals('display')% disabled %endifvar%>
										</select> 
									</td>
								%else%	
									<td class="oddrow-l" >
										<input type="text" placeholder="write Jira issue priority" id="actionJiraIssuePriority" name="actionJiraIssuePriority" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value rule/action/properties/jiraIssuePriority%'>
									</td>
								%endifvar%
                            </tr>
							<tr id="action_service_serviceName_row" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('service')% %else%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading" >Service Name</td>
                                <td class="oddrow-l" >
									<input type="text" placeholder="for e.g. wx.monitoring.impl.actionHandler:sendEmail" name="serviceToInvoke" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value rule/action/properties/customServiceToInvoke%'>
                                </td>
                            </tr>
							<tr id="action_service_inputParam_row" %ifvar rule/action/actionType% %ifvar rule/action/actionType equals('service')% %else%style="display:none;" %endifvar% %else% style="display:none;"%endifvar%>
                                <td class="subheading" >Input Parameter</td>
                                <td class="oddrow-l" >
									<textarea placeholder="{
  &quot;param1&quot; : &quot;value1&quot;,
  &quot;param2&quot; : &quot;value2&quot;
}" id="inputParam" rows="2" cols="40" name="inputParam" title="If more than one parameter is required, write parameters as JSON and handle it accordingly in the invoked service" %ifvar operation equals('display')% disabled %endifvar%>%value rule/action/properties/customServiceInputParams%</textarea>
                                </td>
                            </tr>
							<script>
								handleActionControls('%value infoData/jiraInfo/jiraProjectPropertiesJSON encode(javascript)%', '%value ruleJSON encode(javascript)%');
							</script>
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
    <form name="htmlform_rule_affected_processes_display" action="process-stats-specific.dsp" method="POST">
        <input type="hidden" name="operation">
        <input type="hidden" name="ruleID">
    </form>
	<form name="htmlform_process_rules" action="process-rules.dsp" method="POST">
    </form>
  </body>   
</head>
