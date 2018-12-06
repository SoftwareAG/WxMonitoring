<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HTML>
<head>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods_extentions.css">
	<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
	<SCRIPT SRC="common-navigation.js"></SCRIPT>
	<script language="JavaScript">
		function validateForm(form, oper){
			form.operation.value = oper;
			//form.operation.value = oper;
			if(oper=="loadEvent"){
				var eventDataString = form.eventData.value;
				var eventsArray = eventDataString.split("\n");
				//form.events.value = array;
				
				var eventsJSONObject = {};
				eventsJSONObject.events = eventsArray;
				var json = JSON.stringify(eventsJSONObject);
				form.eventsJSON.value = json;
				//alert(array[1]);
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
	<div CLASS="position">
		<table WIDTH="100%">
			<tbody>
				<tr>
<!-- page name (breadcrumb) -->
					<td class="breadcrumb" colspan="2">Smoke Test &gt; Load Sample Data</td>
				</tr>
         
				<tr>
					<td colspan="2"><br></td>
				</tr>
<!-- list page actions -->
				
				%ifvar operation equals('generateEvent')%
					%invoke wx.monitoring.services.gui.smokeTest:generateSampleEvent%
						%ifvar message%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
						%endif%
						%onerror%
							<tr><td colspan="2">&nbsp;</td></tr>
							<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
						%endinvoke% 
				%endifvar%
				%ifvar operation equals('loadEvent')%
					%invoke wx.monitoring.services.gui.smokeTest:loadSampleEvents%
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
				<script>
					var stateJSONObject = createPageState('%value /fromDateValue encode(javascript)%','%value /fromTimeValue encode(javascript)%','%value /toDateValue encode(javascript)%','%value /toTimeValue encode(javascript)%', '%value /severity encode(javascript)%', '%value /server encode(javascript)%', '%value /logFile encode(javascript)%', '%value /displayOrder encode(javascript)%', '%value /resultsPerPage encode(javascript)%', '%value /requestedPageNumber encode(javascript)%');
					
					var startNewNavigationSequence = true;
					savePageState("events-general.dsp", stateJSONObject, startNewNavigationSequence);				
				</script>
				<tr>
					<td colspan="6">
					On this page you can add sample data and quickly test if the data is inserted into ElasticSearch. Please add the data that is consistent with IS server log style or wrapper log style. </br>For e.g write event in format "2018-11-29 14:24:34 MEZ [ISS.1055.3238I] Test IS log" or in format "INFO   | jvm 1    | 2018/12/05 09:12:38 | Test wrapper log". </br>You can also generate a random event by clicking "Generate event" button.
						<form name="htmlform_smoketest_event_load" action="smoke-test-events-load.dsp" method="GET">
							<input type="hidden" name="operation">							
							<input type="hidden" name="eventsJSON">
						<TABLE class="tableView">
							<TR>
								<TD colspan=3 class="heading">Load Sample Events</TD>
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
													<option value="is" %ifvar eventType equals('is')% selected %endifvar% selected>IS log</option>
													<option value="process" %ifvar eventType equals('process')% selected %endifvar%>Process log</option>
													<option value="wrapper" %ifvar eventType equals('wrapper')% selected %endifvar%>Wrapper log</option>
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
								<TD colspan=3 >  <textarea name="eventData" rows="10" cols="100" style='white-space: pre-wrap;'>%ifvar operation equals('generateEvent')%%value events encode(htmlattr)% %else%Enter event here...%endifvar%</textarea></TD>
							</TR>
							<TR class="oddrow">
								<TD colspan=3 class="action">  <INPUT type="submit" VALUE="Load event" onclick="return validateForm(this.form, 'loadEvent');"></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</tbody>
		</table>                   
	</div>				
</BODY>
</HTML>