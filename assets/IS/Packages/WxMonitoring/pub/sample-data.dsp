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

<form name="htmlform_sample_data" action="sample-data.dsp" method="POST">
	<input type="hidden" name="action">							
	<input type="hidden" name="eventsJSON">
			

	<div CLASS="position">
		<table WIDTH="100%">
			<tbody>

<!-- page name (breadcrumb) -->
				<tr>
					<td class="breadcrumb" colspan="2">Administration &gt; Import Data</td>
				</tr>

<!-- links -->
				<tr>
					<td colspan="2">
						<ul>
							<li class="listitem">
								<a href="sample-uploadlogs.dsp">Upload Log Files</a>
							</li>
						</ul>
					</td>
				</tr>
	
<!-- list page actions -->
				
%ifvar action%
	%invoke wx.monitoring.services.gui.dataAdministration:handleDspAction%
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
<!-- Load Sample Data -->
				<tr>
					<td>
						<TABLE class="tableView" width="100%">
							<TR>
								<TD colspan=3 class="heading">Sample Data</TD>
							</TR>  
							<TR>
								<TD colspan=3 class="subheading2">
									On this page you can add sample data and quickly test if the data is inserted into ElasticSearch. Please add the data that is consistent with IS server log style or wrapper log style. </br>For e.g write event in format "2018-11-29 14:24:34 MEZ [ISS.1055.3238I] Test IS log".</br>You can also generate a random event by clicking "Generate event" button.
								</TD>
							</TR>  
							<TR class="oddrow">
								<TD nowrap align="left">
									<TABLE class="noborders">
										<TR>
											<TD>
												Event type 
											</TD>
											<TD>
												<select id="selEventType" name="eventType">
													<option value="is" %ifvar eventType equals('is')% selected %endifvar% selected>IS log entries</option>
													<option value="process" %ifvar eventType equals('process')% selected %endifvar%>Process log entries</option>
												</select>
											</TD>
										</TR>
										<TR>  
											<TD>
												Number of events/processes 
											</TD>
											<TD>
												<select id="selNumberOfEvents" name="numberOfEvents">
													<option value="1" %ifvar numberOfEvents -isnull% selected %else% %ifvar numberOfEvents equals('1')% selected %endifvar% %endifvar% selected>1</option>
													<option value="10" %ifvar numberOfEvents equals('10')% selected %endifvar%>10</option>
													<option value="50" %ifvar numberOfEvents equals('50')% selected %endifvar%>50</option>
													<option value="100" %ifvar numberOfEvents equals('100')% selected %endifvar%>100</option>
												</select>
											</TD>
										</TR>
									</TABLE>
								</TD> 
								<TD nowrap align="left">
									<TABLE class="noborders">
										<TR>
											<TD>
												Server ID
											</TD>
											<TD>
												%ifvar serverIDName%
													<input id="serverIDName" type="text" name="serverIDName"  value="%value serverIDName%"/>
												%else%
													<input id="serverIDName" type="text" name="serverIDName"  value="import_server1"/>
												%endifvar%
											</TD>
										</TR>
										<TR>  
											<TD>
												Log file name
											</TD>
											<TD>
												%ifvar logfileName%
													<input id="logfileName" type="text" name="logfileName" value="%value logfileName%"/>
												%else%
													<input id="logfileName" type="text" name="logfileName" value="import_logfile1"/>
												%endifvar%
												
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD nowrap align="left">  <INPUT type="submit" VALUE="Generate event" onclick="return validateForm(this.form, 'generateEvent');"></TD>
							</TR>
							<TR class="oddrow">
								<TD colspan=3 >  <textarea name="eventData" rows="10" cols="100" style='white-space: pre-wrap;'>%ifvar action equals('generateEvent')%%value events encode(htmlattr)% %else%Enter event here...%endifvar%</textarea></TD>
							</TR>
							<TR class="oddrow">
								<TD colspan=3 class="action">  <INPUT type="submit" VALUE="Load event" onclick="return validateForm(this.form, 'loadEvent');"></TD>
							</TR>
						</TABLE>
					</td>
				</tr>

<!-- Purge Data -->
<tr>
		<td>
			<TABLE class="tableView" width="100%">
				<TR>
					<TD colspan=3 class="heading">Purge Sample Data</TD>
				</TR>  
				<TR class="oddrow">
					<TD nowrap align="left">
						<TABLE class="noborders">
							<TR>
								<TD>
									Server ID 
								</TD>
								<TD>
%invoke wx.monitoring.services.gui.common:getAllServerNames%
									<select id="selServerid" name="serverid">
%loop serverNames%
										<option value="%value key encode(htmlattr)%" %ifvar ../server vequals(key)% selected %endifvar%>%value name encode(html)%</option>
%endloop%
									</select>
%endinvoke%											
								</TD>
							</TR>
						</TABLE>
					</TD> 
				</TR>
				<TR class="evenrow">
					<TD colspan=3 class="action">  
						<INPUT type="submit" VALUE="Purge data" onclick="return validateForm(this.form, 'purgeData');">
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