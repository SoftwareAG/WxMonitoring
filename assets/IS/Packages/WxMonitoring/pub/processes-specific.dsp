<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HTML>
<head>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods_extentions.css">
	<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
	<SCRIPT SRC="pagination.js"></SCRIPT>
	<script SRC="processes-specific.js"></script>
	<script SRC="common-navigation.js"></script>
	<script language="JavaScript">
		function handleProcessDetailClick(form, processID){

			form.processID.value = processID;
			form.submit();

			return true;
		}
		
		function createPageState(fromDateValue, fromTimeValue, toDateValue, toTimeValue, processStatus, server, businessDomain, sortBy, displayOrder, resultsPerPage, requestedPageNumber, criteria) {
			var stateJSONObject = {};
			stateJSONObject.currentPageName = "processes-specific.dsp";
			stateJSONObject.previousPageName = getLastPageName("processes-specific.dsp");
			stateJSONObject.fromDateValue = fromDateValue;
			stateJSONObject.fromTimeValue = fromTimeValue;
			stateJSONObject.toDateValue = toDateValue;
			stateJSONObject.toTimeValue = toTimeValue;
			stateJSONObject.processStatus = processStatus;
			stateJSONObject.server = server;
			stateJSONObject.businessDomain = businessDomain;
			stateJSONObject.sortBy = sortBy;
			stateJSONObject.displayOrder = displayOrder;
			stateJSONObject.resultsPerPage = resultsPerPage;
			stateJSONObject.requestedPageNumber = requestedPageNumber;
			stateJSONObject.criteria = criteria;
		
			return stateJSONObject;
		}
		
		function populateForm(form, processESID){
	
			form.processESID.value= processESID;
			return true;
		}

		function onReturnClick() {
			
			var currentPageState = getPageState("processes-specific.dsp");
			var previousPageState =  getPageState(currentPageState.previousPageName);
			cleanNavigationSequence();
			
			if(previousPageState.currentPageName=="process-stats-general.dsp"){
				var url = "process-stats-general.dsp?fromDateValue=" + previousPageState.fromDateValue + "&fromTimeValue=" + previousPageState.fromTimeValue + "&toDateValue=" + previousPageState.toDateValue + "&toTimeValue=" + previousPageState.toTimeValue + "&businessDomain=" + previousPageState.businessDomain + "&criteria=" + previousPageState.criteria;
			}else if(previousPageState.currentPageName=="dashboard.dsp"){
				var url = "dashboard.dsp?processTimeRange=" + previousPageState.processTimeRange + "&processBusinessDomain=" + previousPageState.processBusinessDomain + "&eventTimeRange=" + previousPageState.eventTimeRange + "&eventServer=" + previousPageState.eventServer;
				
			}
			var res = encodeURI(url);
			
			location.href = res;	
		}
	
	</script>
</head>
<BODY>

	<div CLASS="position">
		<table WIDTH="100%">
			<tbody>
				<tr>
<!-- page name (breadcrumb) -->
					<td class="breadcrumb" colspan="2">Processes &gt; Statistics &gt; Specific</td>
				</tr>
<!-- list page actions -->				
			%invoke wx.monitoring.services.gui.processes:getProcesses%
				%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
				%endif%
				%onerror%
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td class="message" colspan=2>%value errorMessage encode(html)%</td></tr>
			%endinvoke%	
			
			<script>
				var stateJSONObject = createPageState('%value /fromDateValue encode(javascript)%','%value /fromTimeValue encode(javascript)%','%value /toDateValue encode(javascript)%','%value /toTimeValue encode(javascript)%', '%value /processStatus encode(javascript)%', '%value /server encode(javascript)%', '%value /businessDomain encode(javascript)%', '%value /sortBy encode(javascript)%', '%value /displayOrder encode(javascript)%', '%value /resultsPerPage encode(javascript)%', '%value /requestedPageNumber encode(javascript)%', '%value /criteria encode(javascript)%');
				
				var startNewNavigationSequence = false;
				savePageState("processes-specific.dsp", stateJSONObject, startNewNavigationSequence);				
			</script>
			
				<tr>
					<td colspan="2">
						<ul class="listitems">
							<li class="listitem">
								<a href="#"  onclick="onReturnClick();" id="return">
								 <script> 
										var currentPageState = getPageState("processes-specific.dsp");
										if(currentPageState.previousPageName == "dashboard.dsp") { 
											document.write("Return to dashboard");
											} else if(currentPageState.previousPageName == "process-stats-general.dsp"){
											document.write("Return to general");
										} else {
											document.write("Returnnnnn to general");
										}
									</script>
								 </a>
							</li>
						</ul>
					</td>
				</tr>				
				<tr>
					<td colspan="6">
					<form name="htmlform_process_detail" action="process-detail.dsp" method="POST">
							<input type="hidden" name="processID">
					</form>
					<form name="htmlform_processes_specific" action="processes-specific.dsp" method="GET">
							<input type="hidden" name="fromDateValue" value="%value fromDateValue encode(htmlattr)%">
							<input type="hidden" name="fromTimeValue" value="%value fromTimeValue encode(htmlattr)%">
							<input type="hidden" name="toDateValue" value="%value toDateValue encode(htmlattr)%">
							<input type="hidden" name="toTimeValue" value="%value toTimeValue encode(htmlattr)%">
							<input type="hidden" name="server" value="%value server encode(htmlattr)%">
							<input type="hidden" name="processStatus" value="%value processStatus encode(htmlattr)%">
							<input type="hidden" name="businessDomain" value="%value businessDomain encode(htmlattr)%">
							<input type="hidden" name="totalPages" value="%value totalPages encode(htmlattr)%">
						<TABLE class="tableView">
							<TR>
								<TD colspan=7 class="heading">Processes Display Controls</TD>
							</TR>  
							<TR class="oddrow">
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>
											<TD class="evenrowdata" colspan=2>
												Sort By
											</TD>
										</TR>
										<TR>
											<TD>
												<INPUT TYPE="radio" NAME="sortBy" VALUE="lastUpdated" %ifvar sortBy equals('lastUpdated')%checked %endifvar%>
											</TD>
											<TD>
												Last Updated 
											</TD>
										</TR>
										<TR>  
											<TD>
												<INPUT TYPE="radio" NAME="sortBy" VALUE="duration" %ifvar sortBy equals('duration')%checked %endifvar%>
											</TD>
											<TD>
												Duration 
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>
											<TD class="evenrowdata" colspan=2>
												Display Order
											</TD>
										</TR>
										<TR>
											<TD>
												<INPUT TYPE="radio" NAME="displayOrder" VALUE="asc" %ifvar displayOrder equals('asc')%checked %endifvar%>
											</TD>
											<TD>
												Ascending 
											</TD>
										</TR>
										<TR>  
											<TD>
												<INPUT TYPE="radio" NAME="displayOrder" VALUE="desc" %ifvar displayOrder equals('desc')%checked %endifvar%>
											</TD>
											<TD>
												Descending 
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD class="oddrow" nowrap>
									<TABLE class="noborders">
										<TR>                            
											<TD>
												Number of entries per page
											</TD>
											<TD>
												<INPUT type="number" name="resultsPerPage" id="resultsPerPage"  value="%value resultsPerPage%">
											</TD>
										</TR>
										<TR>                              
											<TD>
												Go to page
											</TD>
											<TD>
												<INPUT type="number" name="requestedPageNumber" id="requestedPageNumber" value="%value requestedPageNumber%">
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD class="oddrow">  <INPUT type="submit" VALUE="Refresh"></TD>
							</TR>						
						</TABLE>
					</td>
				</tr>
				<tr>
					<td id="result" colspan="6" align="right"></td>
				</tr>
				
				<tr>
					<td>
						<table class="tableView" id="head" name="head">
							<tbody>
								<tr>
									<td class="heading" colspan="13">Processes</td>
								</tr>
								<tr class="subheading2">
									<td class="subheading">Server ID</td>
									<td class="subheading">Business Domain</td>
									<td class="subheading">Process Name</td>
									<td class="subheading">Process ID (for Dev purpose only)</td>
									<td class="subheading">Current Status</td>
									<td class="subheading">Started At</td>
									<td class="subheading">Duration</td>
									<td class="subheading">Last Updated</td>
									<td class="subheading">Exception Message</td>
									<td class="subheading">More Info</td>
								</tr>
								
									%ifvar processes%
										%loop processes%
								<tr class="field">
									<td>%value serverID%</td>
									<td >%value businessDomainBeautified%</td>
									<td >%value processName%</td>
									<td >%value processID%</td>
									<td >%ifvar currentStatus equals('started')%Active %else% %ifvar currentStatus equals('completed')%Completed %else% %ifvar currentStatus equals('exception')%Failed* %else% %ifvar currentStatus equals('failed')%Failed %else% %ifvar currentStatus equals('cancelled')%Cancelled %else% - %endifvar%%endifvar% %endifvar%%endifvar%%endifvar%</td>
									<td >%value startedTimestamp%</td>
									<td >%ifvar duration% %ifvar duration/days -notempty% %ifvar duration/days equals('0')% %else% %value duration/days% days %endifvar% %endifvar% %ifvar duration/hours -notempty% %ifvar duration/hours equals('0')% %else% %value duration/hours% hrs %endifvar% %endifvar% %ifvar duration/minutes -notempty% %ifvar duration/minutes equals('0')% %else% %value duration/minutes% mins %endifvar% %endifvar% %ifvar duration/seconds -notempty% %ifvar duration/seconds equals('0')% ~0 sec %else% %value duration/seconds% sec %endifvar% %endifvar% %else% - %endifvar%</td>
									<td >%value lastUpdated%</td>
									<td >%value exceptions[0]/exceptionMessage%</td>
									<td>
										<a href="#"  onclick="handleProcessDetailClick(document.htmlform_process_detail, '%value processESID%');" id="moreInfo">
											<img src="images/ifcdot.gif" border="no">
										</a> 
									</td>
								</tr>
										%endloop%
									%else%
								<tr class="field" align="left">
									<TD colspan="13" class="oddrowdata-l">---------------------------------- no results ----------------------------------</TD>
								</tr>
									%endifvar%	
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<input type="hidden" id="totalPages" name="totalPages" value="%value totalPages%">
					<td id="pagination" colspan="1" >
						<a href="#"  onclick="goToFirstClick(htmlform_processes_specific);" id="goToFirst">&lt;&lt; Go to first</a> |
						<a href="#"  onclick="onPreviousClick(htmlform_processes_specific);" id="previous">&lt;Previous</a> |
						<a href="#"  onclick="onNextClick(htmlform_processes_specific, '%value totalPages%');" id="next">Next &gt;</a> |
						<a href="#"  onclick="goToLastClick(htmlform_processes_specific, '%value totalPages%');" id="goToLast">Go to last &gt;&gt;</a> </br>							
						<span id="page_info">You are currently viewing page %value requestedPageNumber% of %value totalPages%</script></span>
					</td>
				</tr>
				<tr>
					<td>
					&nbsp;
					</td>
				</tr>
				
				<tr>
					<td>
					Failed* represents processes that have encountered an exception and are likely to fail but have not reported status 'Failed' yet.
					</td>
				</tr>

			</tbody>
		</table>          
         
	</div>
					
				
</BODY>
</HTML>