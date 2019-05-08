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
    function submitAction(action, id, param1)
    {
		var form = document.htmlform;
		document.getElementById("action").value  = action;
		form.id.value = id;
		form.param1.value = param1;
		form.submit();
    }
  
  </script>
  <body>
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2">Administration &gt; Rules Scheduler</td>
        </tr>
		
		%ifvar action%
			%invoke wx.monitoring.services.gui.events:handleAdminSchedulerDspAction%
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
		
		%invoke wx.monitoring.services.gui.administration:getRulesScheduler%
		%endinvoke%
        <tr>
            <td colspan="2">
                <ul class="listitems">
					<li class="listitem"><a href="admin-scheduler.dsp">Refresh</a> </li>
                </ul>
            </td>
        </tr>
        <tr>
			<td>    
				<table id="ruleTable" class="tableView">
					<tr>
						<td class="heading" colspan="10">Scheduler Settings</td>
					</tr>
					<tr>
						
						<td class="subheading">Name</td>
						<td class="subheading">Last Run</td>
						<td class="subheading">Next Run</td>
						<td class="subheading">Interval</td>
						<td class="subheading">Current Status</td>
					</tr>
					%ifvar scheduler%
						%loop scheduler%
							<tr class="rowCounter">
								<td nowrap class="evenrow-l">
									%value description encode(html)%
								</td>
								<td nowrap class="evenrowdata">
									%value lastRun encode(html)% <br/>
									%value lastEventID encode(html)% <br/>
								</td> 
								<td nowrap class="evenrowdata">
									%value nextRun encode(html)%
								</td>
								<td nowrap class="evenrowdata">
									%ifvar status equals('ready')% 
										%value interval encode(html)% sec
									%else%
										<input type="text" id="txtInterval_%value $index%" value="%value interval encode(html)%" size="12" />
										<input type="button" onclick="submitAction('updateInterval','%value id encode(html)%',document.getElementById('txtInterval_%value $index%').value)" value="Update" />
									%endifvar%
								</td>
								<td nowrap class="evenrowdata">
									%ifvar status equals('ready')% 
										<img src="images/green_check.png" width="13" height="13" border="0">
										<a href="javascript:submitAction('setStatus','%value id encode(html)%','suspend')" onclick="return confirm('Are you sure you want to suspend scheduler?');">Active</a> 
									%else% 
										<a href="javascript:submitAction('setStatus','%value id encode(html)%','active')">Suspended</a> 
									%endifvar%
								</td>
							</tr>
						%endloop%
					%else%
						<tr id="noResultBanner" class="field" align="left">
							<TD colspan=6 class="oddrowdata-l">---------------------------------- no scheduler ----------------------------------</TD>
						</tr>
					%endifvar%
				</table>
			</td>
        </tr>
    </table>
	<form name="htmlform" action="admin-scheduler.dsp" method="POST">
        <input type="hidden" name="action" id="action">
        <input type="hidden" name="id">
		<input type="hidden" name="param1">
    </form>
  </body>   
</head>
