<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<HTML>
	
	<head>
		<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
		<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods_extentions.css">
		<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
		<SCRIPT SRC="common-navigation.js"></SCRIPT>
		<script language="JavaScript">
			function handleProcessDetailClick(form, processID) {
	
				form.processID.value = processID;
				form.submit();
	
				return true;
			}
	
			function toggleCtrl_TimeRange() {
				var selTimeRange = document.getElementById("selProcessTimeRange");
				var dtFromDate = document.getElementById("dtFromDate");
				var dtToDate = document.getElementById("dtToDate");
				var tmFromTime = document.getElementById("tmFromTime");
				var tmToTime = document.getElementById("tmToTime");
	
				if (selTimeRange.value == 'Custom') {
					// enable all custom ctrls 
					dtFromDate.removeAttribute('readonly');
					dtToDate.removeAttribute('readonly');
					tmFromTime.removeAttribute('readonly');
					tmToTime.removeAttribute('readonly');
				} else {
					// set all custom ctrls readonly
					dtFromDate.setAttribute('readonly', 'readonly');
					dtToDate.setAttribute('readonly', 'readonly');
					tmFromTime.setAttribute('readonly', 'readonly');
					tmToTime.setAttribute('readonly', 'readonly');
				}
			}
	
			function createPageState(processLogText, processTimeRange, fromDateValue, fromTimeValue, toDateValue, toTimeValue, processStatus, server, businessDomain, sortBy, displayOrder, resultsPerPage, requestedPageNumber) {
				var stateJSONObject = {};
				stateJSONObject.currentPageName = "process-instances.dsp";
				stateJSONObject.previousPageName = "";
				stateJSONObject.processLogText = processLogText;
				stateJSONObject.processTimeRange = processTimeRange;
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
						<td class="breadcrumb" colspan="2">Processes &gt; Process Instances</td>
					</tr>
	
					<!-- list page actions -->
					%invoke wx.monitoring.services.gui.processes:getProcesses%
					%endinvoke%
					%invoke wx.monitoring.services.gui.common:getAllBusinessDomainsNames%
					%endinvoke%
	
					%invoke wx.monitoring.services.gui.common:getAllServerNames%
					%ifvar message%
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td class="message" colspan="2">%value message encode(html)%</td>
					</tr>
					%endif%
					%onerror%
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td class="message" colspan=2>%value errorMessage encode(html)%</td>
					</tr>
					%endinvoke%
	
					<script>
						var stateJSONObject = createPageState('%value /processLogText encode(javascript)%', '%value /processTimeRange encode(javascript)%','%value /fromDateValue encode(javascript)%', '%value /fromTimeValue encode(javascript)%', '%value /toDateValue encode(javascript)%', '%value /toTimeValue encode(javascript)%', '%value /processStatus encode(javascript)%', '%value /server encode(javascript)%', '%value /businessDomain encode(javascript)%', '%value /sortBy encode(javascript)%', '%value /displayOrder encode(javascript)%', '%value /resultsPerPage encode(javascript)%', '%value /requestedPageNumber encode(javascript)%');
	
						var startNewNavigationSequence = true;
						savePageState("process-instances.dsp", stateJSONObject, startNewNavigationSequence);				
					</script>
					<tr>
						<td>
							<form name="htmlform_process_detail" action="process-detail.dsp" method="POST">
								<input type="hidden" name="processID">
							</form>
							<form name="htmlform_processes_general" action="process-instances.dsp" method="GET">
								<TABLE class="tableView">
									<TR>
										<TD colspan=9 class="heading">Processes Display Controls</TD>
									</TR>
									<TR class="oddrow">
										<TD class="oddrow" nowrap>
											<TABLE class="noborders">
												<TR>
													<TD>
														
															Process Log Contains:
													</TD>
												</TR>
												<TR>
													<TD>
														<textarea id="processLogText" rows="4" cols="40" placeholder="Can be used to search process with process id" name="processLogText">%value processLogText%</textarea>
													</TD>
												</TR>
											</TABLE>
										</TD>
						<TD class="oddrow" nowrap>
							<TABLE class="noborders">
								<TR>
									<TD>
										Time Range
									</TD>
									<TD>
										<select id="selProcessTimeRange" name="processTimeRange"
											onchange="toggleCtrl_TimeRange()">
											<option value="today" %ifvar processTimeRange% %ifvar processTimeRange equals('today')%selected %endifvar% %else% selected %endifvar%>Today
											</option>
											<option value="lastSevenDays" %ifvar processTimeRange equals('lastSevenDays')%selected %endifvar%>Past 7 days</option>
											<option value="lastFifteenDays" %ifvar processTimeRange equals('lastFifteenDays')%selected %endifvar%>Past 15 days</option>
											<option value="lastThirtyDays" %ifvar processTimeRange equals('lastThirtyDays')%selected %endifvar%>Past 30 days</option>
											<option value="ALL" %ifvar processTimeRange equals('ALL')%selected %endifvar%>ALL</option>
											<option value="Custom" %ifvar processTimeRange equal ('Custom') %selected %endifvar%>Custom</option>
										</select>
									</TD>
								</TR>
								<TR>
									<TD>
										Start date
									</TD>
									<TD>
										<input id="dtFromDate" type="date" name="fromDateValue"
											value="%value fromDateValue%" />
									</TD>
									<TD>
										End date
									</TD>
									<TD>
										<input id="dtToDate" type="date" name="toDateValue" value="%value toDateValue%" />
									</TD>
								</TR>
								<TR>
									<TD>
										Start time
									</TD>
									<TD>
										<input id="tmFromTime" type="time" name="fromTimeValue" pattern="[0-9]{2}:[0-9]{2}"
											value="%value fromTimeValue%" />
									</TD>
									<TD>
										End time
									</TD>
									<TD>
										<input id="tmToTime" type="time" name="toTimeValue" pattern="[0-9]{2}:[0-9]{2}"
											value="%value toTimeValue%" />
									</TD>
								</TR>
							</TABLE>
						</TD>
						<script>toggleCtrl_TimeRange();</script>
						<TD class="oddrow" nowrap>
							<TABLE class="noborders">
								<TR>
									<TD>
										Server
									</TD>
									<TD>
										<select id="selServer" name="server">
											%loop serverNames%
											<option value="%value key encode(htmlattr)%" %ifvar ../server vequals(key)%
												selected %endifvar%>%value name encode(html)%</option>
											%endloop%
											<option value="ALL" %ifvar server equals('ALL')% selected %endifvar%>All
											</option>
										</select>
									</TD>
								</TR>
								<TR>
									<TD>
										Status
									</TD>
									<TD>
										<select id="selStatus" name="processStatus">
											<option value="started" %ifvar processStatus equals('started')%selected
												%endifvar%>Active</option>
											<option value="failed" %ifvar processStatus equals('failed')%selected
												%endifvar%>Failed</option>
											<option value="completed" %ifvar processStatus equals('completed')%selected
												%endifvar%>Completed</option>
											<option value="cancelled" %ifvar processStatus equals('cancelled')%selected
												%endifvar%>Cancelled</option>
											<option value="ALL" %ifvar processStatus equals('ALL')%selected %endifvar%>All
											</option>
										</select>
									</TD>
								</TR>
								<TR>
									<TD>
										Business Domain
									</TD>
									<TD>
										<select id="selBusinessDomain" name="businessDomain">
											%loop businessDomains%
											<option value="%value key encode(htmlattr)%" %ifvar ../businessDomain
												vequals(key)%selected %endifvar%>%value name encode(html)%</option>
											%endloop%
											<option value="ALL" %ifvar businessDomain equals('ALL')%selected %endifvar%>All
											</option>
										</select>
									</TD>
								</TR>
							</TABLE>
						</TD>
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
										<INPUT type="number" name="resultsPerPage" id="resultsPerPage"
											value="%value resultsPerPage%">
									</TD>
								</TR>
								<TR>
									<TD>
										Go to page
									</TD>
									<TD>
										<INPUT type="number" name="requestedPageNumber" id="requestedPageNumber"
											value="%value requestedPageNumber%">
									</TD>
								</TR>
							</TABLE>
						</TD>
						<TD class="oddrow"> <INPUT type="submit" VALUE="Refresh"></TD>
					</TR>
			</TABLE>
			</form>
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
								<td class="subheading">Process ID</td>
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
								<td>%value businessDomainBeautified%</td>
								<td>%value processName%</td>
								<td>%value processID%</td>
								<td>
									%ifvar currentStatus equals('started')%Active %else% %ifvar currentStatus equals('completed')%Completed %else% %ifvar currentStatus equals('exception')%Failed* %else% %ifvar currentStatus equals('failed')%Failed %else% %ifvar currentStatus equals('cancelled')%Cancelled %else% - %endifvar%%endifvar% %endifvar%%endifvar%%endifvar%
								</td>
								<td>%value startedTimestamp%</td>
								<td>
									%ifvar duration% %ifvar duration/days -notempty% %ifvar duration/days equals('0')% %else% %value duration/days% days %endifvar% %endifvar% %ifvar duration/hours -notempty% %ifvar duration/hours equals('0')% %else% %value duration/hours% hrs %endifvar% %endifvar% %ifvar duration/minutes -notempty% %ifvar duration/minutes equals('0')% %else% %value duration/minutes% mins %endifvar% %endifvar% %ifvar duration/seconds -notempty% %ifvar duration/seconds equals('0')% ~0 sec %else% %value duration/seconds% sec %endifvar% %endifvar% %else% - %endifvar%
								</td>
								<td>%value lastUpdated%</td>
								<td>%value exceptions[0]/exceptionMessage%</td>
								<td class="oddrowdata">
									<a href="#"
										onclick="handleProcessDetailClick(document.htmlform_process_detail, '%value processESID%');"
										id="moreInfo">
										<img src="images/ifcdot.gif" border="no">
									</a>
								</td>
							</tr>
							%endloop%
							%else%
							<tr class="field" align="left">
								<TD colspan="13" class="oddrowdata-l">---------------------------------- no results
									----------------------------------</TD>
							</tr>
							%endifvar%
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<input type="hidden" id="totalPages" name="totalPages" value="%value totalPages%">
				<td id="pagination" colspan="1">
					%scope param(form='htmlform_processes_general')%
					%include pagination.dsp%
					%endscope%
				</td>
				<td> </td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
			</tr>
	
			<tr>
				<td>
					Failed* represents processes that have encountered an exception and are likely to fail but have not
					reported status 'Failed' yet.
				</td>
			</tr>
	
			</tbody>
			</table>
		</div>
	</BODY>
	</HTML>