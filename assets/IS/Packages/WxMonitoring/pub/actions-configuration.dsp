<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <link rel="stylesheet" TYPE="text/css" href="webMethods_extentions.css">
  <script src="webMethods.js.txt"></script>
  <SCRIPT SRC="common-navigation.js"></SCRIPT>
      <!--add javascript here-->
  <script language="JavaScript">

    function validateAndSubmit(thisform,oper)
    {
        var actionType = document.getElementById("selActionType").value;
        var isFormValid = validate(thisform,oper,actionType);

        if(isFormValid){
            var isFormPopulated = populate(thisform,oper,actionType);    
        }

        if(isFormPopulated){
            thisform.submit(); 
        }     
    }

    function validate(thisform,oper,actionType){
        if(actionType=='email'){
            //validate fields related to email action
            var mailhostPortElement = document.getElementById("mailHostPort");
            var mailhostPortValue = mailhostPortElement.value;

            if(mailhostPortValue){
                if(isNumeric(mailhostPortValue)){
                    if(mailhostPortValue<1 || mailhostPortValue>65535){
                        alert("'SMTP host port' should be between 1 and 65535.")
                        mailhostPortElement.focus();
                        return false;
                    }
                }else {
                    alert("'SMTP host port' should be numeric.")
                    mailhostPortElement.focus();
                    return false;
                }
            }
            var fromEmailElement = document.getElementById("emailFromEmail");
            var fromEmailValue = trimStr(fromEmailElement.value);
            if(!validateEmail(fromEmailValue)){
                alert("Invalid email: '" + fromEmailValue + "' in 'From email' field.");
                fromEmailElement.focus();
                return false;
            }

            if(oper=='testConfiguration'){
                var testEmailToEmailElement = document.getElementById("emailTestEmailToEmail");
                var testEmailToEmailValue = trimStr(testEmailToEmailElement.value);
                if(!validateEmail(testEmailToEmailValue)){
                    alert("Invalid email: '" + testEmailToEmailValue + "' in 'Send test email to' field.");
                    testEmailToEmailElement.focus();
                    return false;
                }
            }
        } else if(actionType=='jira'){
            //validate fields related to jira action
            var jiraHostPortElement = document.getElementById("jiraHostPort").value;
            var jiraHostPortValue = jiraHostPortElement.value;

            if(jiraHostPortValue){
                if(isNumeric(jiraHostPortValue)){
                    if(jiraHostPortValue<1 || jiraHostPortValue>65535){
                        alert("'Port' should be between 1 and 65535.")
                        jiraHostPortElement.focus();
                        return false;
                    }
                }else {
                    alert("'Port' should be numeric.")
                    jiraHostPortElement.focus();
                    return false;
                }
            }

        }

        return true;
    }

    function isNumeric(num){
        return !isNaN(num)
    }

    function validateEmail(email) {
		var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return re.test(String(email).toLowerCase());
	}
	
	
    function trimStr(str) {
      return str.replace(/^\s+|\s+$/g, '');
    }

    function populate(thisform,oper, actionType){
        
        if(oper=="update" || oper=="testConfiguration"){
             
            //create JSON for action properties
			var actionConfigurationJSONObject = {};
			if(actionType=="email"){
				actionConfigurationJSONObject.mailHost = document.getElementById("mailHost").value;
                actionConfigurationJSONObject.mailHostPort = document.getElementById("mailHostPort").value;
                actionConfigurationJSONObject.user = document.getElementById("emailUser").value;
                actionConfigurationJSONObject.pass = document.getElementById("emailPass").value;
                actionConfigurationJSONObject.fromEmail = document.getElementById("emailFromEmail").value;
                if(oper=="testConfiguration"){
                    actionConfigurationJSONObject.testEmailToEmail = document.getElementById("emailTestEmailToEmail").value;
                }
			}else if(actionType=="jira"){
				actionConfigurationJSONObject.protocol = document.getElementById("selProtocol").value;
                actionConfigurationJSONObject.host = document.getElementById("jiraHost").value;
                actionConfigurationJSONObject.port = document.getElementById("jiraHostPort").value;
                actionConfigurationJSONObject.user = document.getElementById("jiraUser").value;
                actionConfigurationJSONObject.pass = document.getElementById("jiraPass").value;

			}
			
			var json = JSON.stringify(actionConfigurationJSONObject);
			thisform.configuration.value = json;
        }
            thisform.operation.value = oper;
            thisform.actionType.value = actionType;
            return true;
    }

    function handleActionTypeClick(pageOperation) {
		var actionTypeValue = document.getElementById("selActionType").value;
		//define controls related to action email
		var actionEmailMailhostRow = document.getElementById("action_email_mailHost_row");
        var actionEmailMailhostPortRow = document.getElementById("action_email_mailHostPort_row");
        var actionEmailUserRow = document.getElementById("action_email_user_row");
        var actionEmailPassRow = document.getElementById("action_email_pass_row");
        var actionEmailFromEmailRow = document.getElementById("action_email_fromEmail_row");
        var actionEmailTestEmailToRow = document.getElementById("action_email_testEmailTo_row");
        

		//define controls related to action jira
		var actionJiraProtocolRow = document.getElementById("action_jira_protocol_row");
        var actionJiraHostRow = document.getElementById("action_jira_host_row");
        var actionJiraHostPortRow = document.getElementById("action_jira_hostPort_row");
        var actionJiraUserRow = document.getElementById("action_jira_user_row");
        var actionJiraPassRow = document.getElementById("action_jira_pass_row");
        
        //define controls common to action email and jira
        var submitButtonRow = document.getElementById("submit_button_row");
        var submitButtonRowButton = document.getElementById("submit_button_row_button");
        
        //define controls common to action email and jira
        var noConfigurationMessageRow = document.getElementById("noConfigurationMessage_row");
        
        if(actionTypeValue=="email"){
			//show controls related to action email
			actionEmailMailhostRow.style.display ="";			
            actionEmailMailhostPortRow.style.display ="";
            actionEmailUserRow.style.display ="";
            actionEmailPassRow.style.display ="";
            actionEmailFromEmailRow.style.display ="";
            actionEmailTestEmailToRow.style.display ="";

			//hide controls related to action jira
			actionJiraProtocolRow.style.display ="none";			
            actionJiraHostRow.style.display ="none";
            actionJiraHostPortRow.style.display ="none";
            actionJiraUserRow.style.display ="none";
            actionJiraPassRow.style.display ="none";

            //change display name of submit button
            if(pageOperation=="display"){
                submitButtonRowButton.value="Send Test Email";
            }
            //show controls common to action email and jira
			submitButtonRow.style.display ="";	

            //hide controls common to action email and jira
			noConfigurationMessageRow.style.display ="none";		

		} else if (actionTypeValue=="jira"){

			//hide controls related to action email
			actionEmailMailhostRow.style.display ="none";			
            actionEmailMailhostPortRow.style.display ="none";
            actionEmailUserRow.style.display ="none";
            actionEmailPassRow.style.display ="none";
            actionEmailFromEmailRow.style.display ="none";
            actionEmailTestEmailToRow.style.display ="none";

			//hide controls related to action jira
			actionJiraProtocolRow.style.display ="";			
            actionJiraHostRow.style.display ="";
            actionJiraHostPortRow.style.display ="";
            actionJiraUserRow.style.display ="";
            actionJiraPassRow.style.display ="";

            //change display name of submit button
            if(pageOperation=="display"){
                submitButtonRowButton.value="Test Connection";
            }

            //show controls common to action email and jira 
			submitButtonRow.style.display ="";		

            //hide controls common to action email and jira
			noConfigurationMessageRow.style.display ="none";	

		} else {
			//hide controls related to action email
			actionEmailMailhostRow.style.display ="none";			
            actionEmailMailhostPortRow.style.display ="none";
            actionEmailUserRow.style.display ="none";
            actionEmailPassRow.style.display ="none";
            actionEmailFromEmailRow.style.display ="none";
            actionEmailTestEmailToRow.style.display ="none";

			//hide controls related to action jira
			actionJiraProtocolRow.style.display ="none";			
            actionJiraHostRow.style.display ="none";
            actionJiraHostPortRow.style.display ="none";
            actionJiraUserRow.style.display ="none";
            actionJiraPassRow.style.display ="none";

            //hide controls common to action email and jira
			submitButtonRow.style.display ="none";

            //show controls common to action email and jira
			noConfigurationMessageRow.style.display ="";		
		}
	}
  
  </script>
  <body>
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2">Administration &gt; Actions Configuration</td>
        </tr>
		
		%ifvar operation equals('update')%
			%invoke wx.monitoring.services.gui.administration:updateActionConfiguration%
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
        
        %ifvar operation equals('testConfiguration')%
			%invoke wx.monitoring.services.gui.administration:verifyActionConfiguration%
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
		
		%invoke wx.monitoring.services.gui.administration:getActionsConfiguration%
		%endinvoke%

        <tr>
            <td colspan="2">
                <ul class="listitems">
					<li class="listitem"><a href="actions-configuration.dsp">Refresh</a> </li>
                    %ifvar operation equals('edit')%
                        <li class="listitem"><a href="javascript:document.htmlform_actionConfiguration.submit();" onClick="return populate(document.htmlform_actionConfiguration,'display');">Cancel</a></li>
                    %else%
                        <li class="listitem"><a href="javascript:document.htmlform_actionConfiguration.submit();" onClick="return populate(document.htmlform_actionConfiguration,'edit');">Edit Configuration</a></li>
                    %endifvar%
                </ul>
            </td>
        </tr>
        <tr>
			<td>    
				<table id="ruleTable" class="tableView">
					<tr>
						<td class="heading" colspan="10">Action Configuration</td>
					</tr>
					<tr>
                        <td class="subheading">Action</td>    
                        <td class="oddrow-l">
                            <select id="selActionType" name="actionType" title="Select action type for which you want to change configuration" required onchange="handleActionTypeClick('%value operation%')" >
                                %ifvar actionsConfiguration%
                                    %loop actionsConfiguration%
                                        <option value="%value actionType encode(htmlattr)%" %ifvar actionType vequals(../actionType)% selected %endifvar% >%value actionDisplayName encode(htmlattr)%
                                        </option>
                                    %endloop%
                                %endifvar% 
                            </select>                                  
                        </td>
                    </tr>
                    
                    <tr id="noConfigurationMessage_row" class="field" align="left">
                        <TD colspan=8 class="oddrowdata-l">This action does not have any configurable settings</TD>
                    </tr>
                    %loop actionsConfiguration%
                        %rename ../operation operation -copy%
                        %ifvar actionType equals('email')%
                            <tr id="action_email_mailHost_row" style="display:none;">
                                <td class="subheading" >SMTP host name</td>
                                <td class="oddrow-l" >
                                    <input type="text" placeholder="SMTP host name for outbound messages" id="mailHost" size="42" %ifvar operation equals('display')% disabled %endifvar% value ='%value actionEmail/mailHost%'>
                                </td>
                            </tr>
                            <tr id="action_email_mailHostPort_row" style="display:none;">
                                <td class="subheading" >SMTP host port</td>
                                <td class="oddrow-l" >
                                    <input type="text" placeholder="Leave blank to use default SMTP port" id="mailHostPort" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value actionEmail/mailHostPort%'>
                                </td>
                            </tr>
                            <tr id="action_email_user_row" style="display:none;">
                                <td class="subheading" >Username</td>
                                <td class="oddrow-l" >
                                    <input type="text" placeholder="Authentication Username" id="emailUser" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value actionEmail/user%'>
                                </td>
                            </tr>
                            <tr id="action_email_pass_row" style="display:none;">
                                <td class="subheading" >Password</td>
                                <td class="oddrow-l" >
                                    <input type="password" placeholder="Authentication Password" id="emailPass" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value actionEmail/pass%'>
                                </td>
                            </tr>
                            <tr id="action_email_fromEmail_row" style="display:none;">
                                <td class="subheading" >From email</td>
                                <td class="oddrow-l" >
                                    <input type="text" placeholder="Send email from this email id" id="emailFromEmail" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value actionEmail/fromEmail%'>
                                </td>
                            </tr>
                            <tr id="action_email_testEmailTo_row" style="display:none;">
                                <td class="subheading">Send test email to</td>
                                <td class="oddrow-l" >
                                    <input type="text" placeholder="Send test email to this email id" id="emailTestEmailToEmail" size="42" %ifvar operation equals('display')% %else% disabled %endifvar%>
                                </td>
                            </tr>
                        %endifvar%
                        %ifvar actionType equals('jira')%
                            <tr id="action_jira_protocol_row" style="display:none;">
                                <td class="subheading" >Communication Protocol</td>
                                <td class="oddrow-l" >
                                    <select id="selProtocol" title="HTTP communication protocol" %ifvar operation equals('display')% disabled %else% required %endifvar% >
                                        <option value="http" %ifvar actionJira/protocol% %ifvar actionJira/protocol equals('http')% selected %endifvar% %else% selected %endifvar%>http</option> 
                                        <option value="https" %ifvar actionJira/protocol equals('https')% selected %endifvar%>https</option>
                                    </select>
                                </td>
                            </tr>
                            <tr id="action_jira_host_row" style="display:none;">
                                <td class="subheading" >JIRA Host</td>
                                <td class="oddrow-l" >
                                    <input type="text" placeholder="JIRA host name" id="jiraHost" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value actionJira/host%'>
                                </td>
                            </tr>
                            <tr id="action_jira_hostPort_row" style="display:none;">
                                <td class="subheading" >Port</td>
                                <td class="oddrow-l" >
                                    <input type="text" placeholder="Leave blank to use default Communication protocol port" id="jiraHostPort" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value actionJira/port%'>
                                </td>
                            </tr>
                            <tr id="action_jira_user_row" style="display:none;">
                                <td class="subheading" >Username</td>
                                <td class="oddrow-l" >
                                    <input type="text" placeholder="Authentication username" id="jiraUser" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value actionJira/user%'>
                                </td>
                            </tr>
                            <tr id="action_jira_pass_row" style="display:none;">
                                <td class="subheading" >Password</td>
                                <td class="oddrow-l" >
                                    <input type="password" placeholder="Authentication password" id="jiraPass" size="42" %ifvar operation equals('display')% disabled %endifvar% value = '%value actionJira/pass%'>
                                </td>
                            </tr>
                        %endifvar%
                    %endloop%
				</table>
			</td>
        </tr>
        <tr id="submit_button_row" style="display:none;">
            <td class="action" colspan=3>
                <input id="submit_button_row_button" type="submit" name="submit" value="Save Changes" %ifvar operation equals('display')% onclick="return validateAndSubmit(document.htmlform_actionConfiguration,'testConfiguration');" %else% onclick="return validateAndSubmit(document.htmlform_actionConfiguration,'update');" %endifvar%>
            </td>
        </tr>
        <script> handleActionTypeClick('%value operation%');</script>
    </table>
	<form name="htmlform_actionConfiguration" action="actions-configuration.dsp" method="POST">
        <input type="hidden" name="operation">
        <input type="hidden" name="actionType">
        <input type="hidden" name="configuration">
    </form>
  </body>   
</head>