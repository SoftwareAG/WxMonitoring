<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HTML>
<head>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods_extentions.css">
	<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
	<SCRIPT SRC="common-navigation.js"></SCRIPT>
	<script language="JavaScript">
		function validateForm(form, oper){
			form.action.value = oper;
			if(oper=="loadEvent"){
				var eventDataString = form.eventData.value;
				var eventsArray = eventDataString.split("\n");
				//form.events.value = array;
				
				var eventsJSONObject = {};
				eventsJSONObject.events = eventsArray;
				var json = JSON.stringify(eventsJSONObject);
				form.eventsJSON.value = json;
				//alert(array[1]);
			
			} else if(oper=="purgeData"){
				if (!confirm('Are you sure you want to purge all data for server "' + form.serverid.value + '"?' ))
					return false;
			}

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

<form name="htmlform_sample_data" action="dev-tools.dsp" method="POST">
	<input type="hidden" name="action">							
	<input type="hidden" name="eventsJSON">
			

	<div CLASS="position">
		<table WIDTH="100%">
			<tbody>

<!-- page name (breadcrumb) -->
				<tr>
					<td class="breadcrumb" colspan="2">Administration &gt; Development Tools</td>
				</tr>

<!-- links -->
				<tr>
					<td colspan="2">
						<ul>
							<li class="listitem">
								<a href="#">Edit Global Variables</a>
							</li>
						</ul>
					</td>
				</tr>
	
<!-- list page actions -->
				
%ifvar action%
	%invoke wx.monitoring.services.gui.administration:handleDspAction%
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
				<tr>
					<td colspan="2"><br></td>
				</tr>
				<script>
					var stateJSONObject = createPageState('%value /fromDateValue encode(javascript)%','%value /fromTimeValue encode(javascript)%','%value /toDateValue encode(javascript)%','%value /toTimeValue encode(javascript)%', '%value /severity encode(javascript)%', '%value /server encode(javascript)%', '%value /logFile encode(javascript)%', '%value /displayOrder encode(javascript)%', '%value /resultsPerPage encode(javascript)%', '%value /requestedPageNumber encode(javascript)%');
					
					var startNewNavigationSequence = true;
					savePageState("events-general.dsp", stateJSONObject, startNewNavigationSequence);				
				</script>
<!-- View Settings  -->
%invoke wx.monitoring.services.gui.administration:getDevToolsSettings%
				<tr>
					<td>
						<table class="tableView" width="50%">
							<tbody>
								<tr>
									<td class="heading" colspan="3">Settings</td>
								</tr>
								<tr>
									<td class="oddrow" width="30%" nowrap="">
										Elastic Search URL</td>
									<td class="oddrowdata-l" width="70%">
										%value settings/esUrl% 
									</td>
								</tr>
								<tr>
									<td class="evenrow" nowrap="">
										HTTP Headers</td>
									<td class="evenrowdata-l" >
%ifvar settings/httpHeaders%										
	%loop settings/httpHeaders%
										%value key%: %value value%%loopsep '<p/>'% 
	%endloop%
%endifvar%
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
<!-- Request - Response -->
				<tr>
					<td>
			
						<TABLE class="tableView" width="100%">
							<TR>
								<TD colspan=3 class="heading">Request Elastic Search</TD>
							</TR>  
							<TR>
								<TD colspan=3 class="subheading2">
									Load Template
									<select id="selTemplate" name="templateSelected">
%loop settings/templates%
											<option %ifvar name vequals(/template/name)% selected="selected"%endif%>%value name%</option>
%endloop%
									</select>
									<INPUT type="submit" VALUE="load" onclick="return validateForm(this.form, 'loadTemplateESRequest');">
								</TD>
							</TR>
							<TR class="oddrow">
								<TD nowrap align="left">
<!-- Request -->
									<TABLE class="noborders" width="100%">
										<tr>
											<TD>
												Method 
												<select id="selReqMethod" name="reqMethodType">
%loop settings/reqMethods%
													<option %ifvar reqIndex vequals(/settings/reqMethods[$index])% selected="selected"%endif%>%value%</option>
%endloop%
												</select>
												Index
												<input id="reqIndex" name="reqIndex" type="text" size="40" value="%value template/index%" />
											</TD>
										</TR>
										<TR>  
											<TD colspan=3 >
												<textarea id="reqBody" name="reqBody" rows="13" cols="40" style='white-space: pre-wrap; width: 100%; font-family: monospace'>
%value +nl template/requestBody %
												</textarea>
											</TD>
										</TR>
										<TR>
											<TD colspan=3 class="action">
												<INPUT type="submit" VALUE="send" onclick="return validateForm(this.form, 'sendRequest2ES');">
											</TD>
										</TR>
									</TABLE>
								</TD> 
								<TD nowrap align="left">
<!-- Response -->
									<TABLE class="noborders" width="100%">
										<TR>
											<TD>
												Request Time
											</TD>
											<TD>
												<input id="reqTime" name="reqTime" type="text" size="50" value="%value reqTime%"
													style="width: 100%" />
											</TD>
										</TR>
										<TR>
											<TD>
												Request URL
											</TD>
											<TD>
												<input id="tmp" type="text" size="50" value="%value reqMethodType% %value reqURL%"
													style="width: 100%" />
											</TD>
										</TR>
										<TR>
											<TD>
												Response
											</TD>
											<TD>
												<input id="tmp" " type="text" size="50" value="%value respMsg/code% %value respMsg/msg%" style="width: 100%" />
											</TD>
										</TR>
										<TR>
											<TD colspan=3>
												<textarea name="respPayload" rows="8" cols="40" style='white-space: pre-wrap; width: 100%; font-family: monospace'>
%value +nl respPayload %
												</textarea>
											</TD>		
										</TR>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
					
					</td>
				</tr>
	
	</tbody>
		</table>                   
	</div>
	
</form>
</BODY>
</HTML>