<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<HTML>
<head>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods_extentions.css">
	<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
	<SCRIPT SRC="common-navigation.js"></SCRIPT>
	<script language="JavaScript">
		function handleDataDeleteClick(FORM, dataID, dataIndex){

			if (!confirm ("OK to delete?")) {
                return false;
            }
			FORM.ruleID.value = dataID;
            FORM.dataIndex.value = dataIndex;  
			FORM.submit();

			return true;
		}
		
		function handleDataDetailClick(FORM, entity, dataID, dataIndex){
			
			if(entity=="event"){
				FORM.eventID.value = dataID;
				FORM.eventIndex.value = dataIndex;  
			}else if(entity=="process"){
				FORM.processID.value = dataID;
			} else {
				return false;
			}
			
			FORM.submit();

			return true;
		}
		
		function createPageState(entity, filterCriteria, timeRange, filterImportedData) {
			//filterCriteria = name of server id if entity value is "events" otherwise it is name of Business Domain
			var stateJSONObject = {};
			stateJSONObject.currentPageName = "import-data-manage.dsp";
			stateJSONObject.previousPageName = "";
			stateJSONObject.entity = entity;
			stateJSONObject.filterCriteria = filterCriteria;
			stateJSONObject.timeRange = timeRange;
			stateJSONObject.filterImportedData = filterImportedData;
			
			
			return stateJSONObject;
		}
		
		function manageFilterCriteriaVisibility(){
			
			var entitySelect = document.getElementById("selEntity");
			var filterCriteriaLabel = document.getElementById("labelFilterCriteria");
			var filterCriteriaSelect = document.getElementById("selFilterCriteria");
			var businessDomainsSelect = document.getElementById("selBusinessDomain");
			var serverSelect = document.getElementById("selServer");
			if (entitySelect.value == "processes"){
				filterCriteriaLabel.innerHTML  = "Business Domain";
				
				for(var i = filterCriteriaSelect.options.length - 1 ; i >= 0 ; i--)
				{
					filterCriteriaSelect.remove(i);
				}
				
				for (var i = 0; i < businessDomainsSelect.options.length; i++) {
					var o = document.createElement("option");
					o.value = businessDomainsSelect.options[i].value;
					o.text = businessDomainsSelect.options[i].text;
					filterCriteriaSelect.appendChild(o);
				}
				filterCriteriaSelect.value = businessDomainsSelect.value;
				
			} else{
				filterCriteriaLabel.innerHTML  = "Server";
				
				for(var i = filterCriteriaSelect.options.length - 1 ; i >= 0 ; i--)
				{
					filterCriteriaSelect.remove(i);
				}
				
				for (var i = 0; i < serverSelect.options.length; i++) {
					var o = document.createElement("option");
					o.value = serverSelect.options[i].value;
					o.text = serverSelect.options[i].text;
					filterCriteriaSelect.appendChild(o);
				}
				filterCriteriaSelect.value = serverSelect.value;
			}
			//alert("hi");
		}
	</script>
</head>
<BODY>
	<div CLASS="position">
		<table WIDTH="100%">
			<tbody>
				<TR>
<!-- page name (breadcrumb) -->
					<TD class="breadcrumb" colspan="2">Administration &gt; Manage Imported Data</TD>
				</TR>
		
		
		%invoke wx.monitoring.services.gui.administration:getImportedData%		
		%endinvoke%
		
		%invoke wx.monitoring.services.gui.common:getAllBusinessDomainsNames%
		%endinvoke% 
		
		%invoke wx.monitoring.services.gui.common:getAllServerNames%
			%ifvar message%
				<TR><TD colspan="2">&nbsp;</TD></TR>
				<TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
			%endif%
		%onerror%
				<TR><TD colspan="2">&nbsp;</TD></TR>
				<TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
		%endinvoke% 
			

		<script>
			var stateJSONObject = createPageState('%value /entity encode(javascript)%','%value /filterCriteria encode(javascript)%','%value /timeRange encode(javascript)%', '%value /filterImportedData encode(javascript)%');
			
			var startNewNavigationSequence = true;
			savePageState("import-data-manage.dsp", stateJSONObject, startNewNavigationSequence,);				
		</script>
<!-- list page actions -->
				<TR>
					<TD colspan="6">
						%ifvar entity equals('events')%
							<form name="htmlform_event_details" action="event-detail.dsp" method="POST">
								<input type="hidden" name="eventID">
								<input type="hidden" name="eventIndex">
							</form>	
						%else%
							<form name="htmlform_process_details" action="process-detail.dsp" method="POST">
								<input type="hidden" name="processID">
							</form>
						%endifvar%
						<form name="htmlform_data_delete" action="import-data-manage.dsp" method="POST">
							<input type="hidden" name="operation">
							<input type="hidden" name="dataID">
							<input type="hidden" name="dataIndex">
						</form>	
						<TABLE style="border-collapse: separate; border-spacing: 10px;"> 
							<TR> 
								<TD>
									<form name="htmlform_imported_data_display" action="import-data-manage.dsp" method="POST">
										<INPUT type="hidden" name="operation">
										<select id="selBusinessDomain" name="processBusinessDomain" style="visibility:hidden;">	
											
											%loop businessDomains%
												<option value="%value key encode(htmlattr)%" %ifvar /filterCriteria vequals(key)%selected %endifvar%>%value name encode(html)%</option>
											%endloop%
										<option value="ALL" %ifvar /filterCriteria% %ifvar /filterCriteria equals('ALL')% selected %endifvar% %else% selected %endifvar%>All</option>
										</select>
										
										<select id="selServer" name="eventServer" style="visibility:hidden;">	
											%loop serverNames%
												%rename key currentServerName -copy%
												%rename /filterCriteria eventServer -copy%
												<option value="%value currentServerName encode(htmlattr)%" %ifvar eventServer vequals(currentServerName)% selected %endifvar%>%value currentServerName encode(html)%</option>
											%endloop%
											<option value="ALL" %ifvar /filterCriteria% %ifvar /filterCriteria equals('ALL')%selected %endifvar% %else% selected %endifvar%>All</option>
										</select>
												
										<table border="1" class="tableView">	
											<tr>
												<td nowrap colspan=5 class="heading">
													Data Display Controls
												</td>
											</tr>
											<tr>
												<td nowrap class="oddrow"> 
													Entity
													<select id="selEntity" name="entity" onchange="manageFilterCriteriaVisibility();">	
														<option value="events" %ifvar /entity% %ifvar /entity equals('events')% selected %endifvar% %else% selected %endifvar%>Events</option>
														<option value="processes" %ifvar /entity equals('processes')% selected %endifvar%>Processes</option>
													</select>
												</td>
												
												<td nowrap class="oddrow"> 
													<DIV id="filterCriteriaDiv">
														<label id="labelFilterCriteria" for='selFilterCriteria'>""</label>
														<select id="selFilterCriteria" name="filterCriteria">
													</DIV>
													<script>manageFilterCriteriaVisibility();</script>
												</td>
												<TD class="oddrow" nowrap>
													<TABLE class="noborders">
														
														<TR>
															<TD class="evenrowdata" colspan=2>
																Filter : 
															</TD>
															<TD>
																<INPUT TYPE="radio" NAME="filterImportedData" VALUE="allImportedData" %ifvar filterImportedData equals('allImportedData')%checked %endifvar%>
															</TD>
															<TD>
																All imported data 
															</TD>
														</TR>
														<TR>
															<TD class="evenrowdata" colspan=2>
																&nbsp; 
															</TD>
															<TD>
																<INPUT TYPE="radio" NAME="filterImportedData" VALUE="sampleData" %ifvar filterImportedData equals('sampleData')%checked %endifvar%>
															</TD>
															<TD>
																Only sample data 
															</TD>
														</TR>
													</TABLE>
												</TD>
												<td nowrap class="oddrow"> 
													Time Range
													<select id="selTimeRange" name="timeRange">
														<option value="today" %ifvar timeRange% %ifvar timeRange equals('today')%selected %endifvar% %else% selected %endifvar%>Today</option>
														<option value="lastSevenDays" %ifvar timeRange equals('lastSevenDays')%selected %endifvar%>Past 7 days</option>
														<option value="lastFifteenDays" %ifvar timeRange equals('lastFifteenDays')%selected %endifvar%>Past 15 days</option>
														<option value="lastThirtyDays" %ifvar timeRange equals('lastThirtyDays')%selected %endifvar%>Past 30 days</option>
														<option value="ALL" %ifvar timeRange equals('ALL')%selected %endifvar%>All</option>
													</select>
												</td>
												<td nowrap class="oddrow"> 
													<INPUT type="submit" VALUE="View Data">
												</td>
											</tr>
										</table>
									</form>
									&nbsp;
								</TD>
								<TD></br>
									<form name="htmlform_imported_data_action" action="import-data-manage.dsp" method="POST">
										<INPUT type="hidden" name="operation" value="perform_action">
										<INPUT type="hidden" name="entity" value="%value entity encode(htmlattr)%">
										<INPUT type="hidden" name="filterCriteria" value="%value filterCriteria encode(htmlattr)%">
										<INPUT type="hidden" name="requestedPageNumber" value="%value requestedPageNumber encode(htmlattr)%">
										<INPUT type="hidden" name="timeRange" value="%value timeRange encode(htmlattr)%">
										<INPUT type="hidden" name="filterImportedData" value="%value filterImportedData encode(htmlattr)%">
										<table border="1" class="tableView">
												
											<tr>
												<TD colspan=7 class="heading">Action Controls</TD>
											</tr>
											<tr>
												<TD class="oddrow" nowrap>
													<TABLE class="noborders">
														<TR>
															<TD>
																Select Action
															</TD>
															<TD>
																<select id="selAction" name="action" required>
																	<option selected value="delData">Delete data</option>
																	<option disabled value="exportData">Export data to file</option>
																</select>
															</TD>
														</TR>
														<TR>  
															<TD>
																*action will be performed for all selected data
															</TD>
														</TR>
													</TABLE>
												</TD>

												<td nowrap class="oddrow"> 
													<INPUT type="submit" VALUE="Perform Action" disabled onClick="return populateForm(document.htmlform_imported_data_action, 'perform_action');">
												</td>
											</tr>
										</table>
									</form>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD id="result" colspan="6" align="right"></TD>
				</TR>
				<TR>
					<TD>
						<table class="tableView" id="head" name="head">
							%ifvar entity equals('events')%
								<tbody>
								<tr>
									<td class="heading" colspan="9">Imported Events</td>
								</tr>
								<tr class="subheading2">
									<td class="subheading">Event Timestamp</td>
									<td class="subheading">Server ID</td>
									<td class="subheading">Event Code</td>
									<td class="subheading">Severity</td>
									<td class="subheading">Event Information</td>
									<td class="subheading">Event ESID (for dev purpose only)</td>
									<td class="subheading">Log File</td>
									<td class="subheading">More Info</td>
									<td class="subheading">Delete Event Log?</td>
								</tr>
									%ifvar data%
										%loop data%
								<tr class="field">
									<td>%value eventTimestamp%</td>
									<td >%value serverID%</td>
									<td >%value typeID%</td>
									<td >%value severity%</td>
									<td >%value eventInformation%</td>
									<td >%value eventESID%</td>
									<td >%value sourceFileFullName%</td>
									<td class="evenrowdata">
										<a href="#" onclick="handleDataDetailClick(document.htmlform_event_details, 'event', '%value eventESID%', '%value eventESIndex%');" id="moreInfo">
											<img src="images/ifcdot.gif" border="no">
										</a> 
									</td>
									<td class="evenrowdata">
										<a href="#" disabled onclick="handleDataDeleteClickk(document.htmlform_imported_data_display, 'event', '%value eventESID%', '%value eventESIndex%');" id="deleteData">
											<img src="images/delete.gif" border="no">
										</a> 
									</td>
								</tr>
										%endloop%
									%else%
								<tr class="field" align="left">
									<TD colspan=8 class="oddrowdata-l">---------------------------------- no results ----------------------------------</TD>
								</tr>
									%endifvar%
 
							</tbody>
							%else%
								<tbody>
									<tr>
										<td class="heading" colspan="13">Imported Processes</td>
									</tr>
									<tr class="subheading2">
										<td class="subheading">Server ID</td>
										<td class="subheading">Business Domain</td>
										<td class="subheading">Process Name</td>
										<td class="subheading">Process ID</td>
										<td class="subheading">Current Status</td>
										<td class="subheading">Started At</td>
										<td class="subheading">Duration</td>
										<td class="subheading">Last Updated</td>
										<td class="subheading">Exception Message</td>
										<td class="subheading">More Info</td>
										<td class="subheading">Delete Process Log?</td>
									</tr>
									
										%ifvar data%
											%loop data%
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
										<td class="evenrowdata">
											<a href="#"  onclick="handleDataDetailClick(document.htmlform_process_details, 'process', '%value processESID%');" id="moreInfo">
												<img src="images/ifcdot.gif" border="no">
											</a> 
										</td>
										<td class="evenrowdata">
										<a href="#" disabled onclick="handleDataDeleteClickk(document.htmlform_process_details, 'process', '%value processESID%');" id="deleteData">
											<img src="images/delete.gif" border="no">
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
							%endifvar%
						</table>
					</TD>
				</TR>
				<tr>
					<input type="hidden" id="totalPages" name="totalPages" value="%value totalPages%">
					<td id="pagination" colspan="1" >
						 %scope param(form='htmlform_imported_data_display')%
							%include pagination.dsp%
						%endscope%
					</td>
					<td>  </td>
				</tr>
			</tbody>
		</table>          
         
	</div>					
</BODY>
</HTML>