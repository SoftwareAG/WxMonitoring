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
			} else if(oper=="dropLogFiles"){
				if (!confirm('Are you sure you want to drop all uploaded log files?' ))
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

	<div CLASS="position">
		<table WIDTH="100%">
			<tbody>

<!-- page name (breadcrumb) -->
				<tr>
					<td class="breadcrumb" colspan="2">Data Administration &gt; Sample Data > Upload Log Files</td>
				</tr>

<!-- links -->
				<tr>
					<td colspan="2">
						<ul>
							<li class="listitem">
								<a href="sample-data.dsp">Return to Sample Data</a>
							</li>
						</ul>
					</td>
				</tr>
	
<!-- list page actions -->
				
%ifvar action%
	%invoke wx.monitoring.services.gui.dataAdministration:handleDspAction%
		%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message encode(html)%
		%ifvar errorMessage%
					: <i>%value errorMessage encode(html)%</i>
		%endif%
					</td></tr>
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

<!-- Upload Data -->
				<tr>
					<td>
						<form id="htmlform_upload_data" name="htmlform_upload_data" action="/invoke/wx.monitoring.services.admin.importEvents:uploadLogFile" method="post" enctype="multipart/form-data" >
							<input type="hidden" name="action">
							<input type="hidden" name="eventsJSON">							
							
						<TABLE class="tableView" width="100%">
							<TR>
								<TD colspan=3 class="heading">Upload Log Files</TD>
							</TR>  
							<TR class="oddrow">
								<TD nowrap align="left">
									<TABLE class="noborders">
										<TR>
											<TD>
												Select a file (zipped): 
											</TD>
											<TD>
												<input type="file" name="uploadLogFile">
											</TD>
										</TR>
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
									</TABLE>
								</TD> 
							</TR>
							<TR class="evenrow">
								<TD colspan=3 class="action">  
									<INPUT type="submit" VALUE="Upload Log Files" onclick="return validateForm(document.forms['htmlform_upload_data'], 'uploadLogs');">
								</TD>
							</TR>
						</TABLE>

						</form>
					</td>
				</tr>

<!-- List Import Log Files -->
%invoke wx.monitoring.services.admin.importEvents:lookupLogDir%
				<tr>
					<td>
						<form id="htmlform_import_logs" name="htmlform_import_logs" action="sample-uploadlogs.dsp" method="post" >
							<input type="hidden" name="action">
							<input type="hidden" name="eventsJSON">							
	
							<TABLE class="tableView" width="100%">
								<TR>
									<TD colspan="3" class="heading">List Import Log Files</TD>
								</TR>  
%ifvar logFiles%
								<tr class="subheading2">
									<td nowrap class="datacenter">Server ID</td>
									<td nowrap colspan="2" class="datacenter">Log files</td>
								</tr>
%loop logFiles%
								<TR class="oddrow">
									<td>
										%value env%
									</td>
									<td colspan="2">
	%loop files%
										%value filename%<br/>
	%endloop%
									</td>
								</TR>
%endloop%
								<TR class="evenrow">
										<TD colspan=3 class="action">  
											<INPUT type="submit" VALUE="Import Logs" onclick="return validateForm(document.forms['htmlform_import_logs'], 'importLogFiles');">
											<INPUT type="submit" VALUE="Drop Log Files" onclick="return validateForm(document.forms['htmlform_import_logs'], 'dropLogFiles');">
										</TD>
								</TR>	
%endif%
%ifvar logFiles -isnull%
								<TR class="oddrow">
									<td colspan="3">
										<center><i>no log files</i></center>
									</td>
								</TR>
%endif%
							</TABLE>

						</form>
					</td>
				</tr>
%endinvoke%
			</tbody>
		</table>                   
	</div>
	
</BODY>
</HTML>