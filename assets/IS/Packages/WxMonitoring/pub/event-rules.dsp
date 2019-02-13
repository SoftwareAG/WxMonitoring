<html>
<head>
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
  <meta http-equiv="Expires" content="-1">
  <link rel="stylesheet" TYPE="text/css" href="webMethods.css">
  <link rel="stylesheet" TYPE="text/css" href="webMethods_extentions.css">
  <script src="webMethods.js.txt"></script>
  <SCRIPT SRC="common-navigation.js"></SCRIPT>
  <script language="JavaScript">
    <!--add jscript here-->
    function populateForm(form , ruleID, eventPattern ,oper,ruleRank)
    {
        if('add' == oper){
			form.operation.value = "add";
			var oTable = document.getElementById('ruleTable');

			//gets rows of table

			var rowLength = oTable.rows.length;
			if(oTable.rows[2].id=="noResultBanner"){
				rowLength = 2;
			}
			var noOfRules = rowLength-2; //-2 to remove header
			var nextRank = noOfRules+1;
			form.ruleRank.value = nextRank;
		} else if('delete' == oper)
        {
            if (!confirm ("OK to delete '"+eventPattern+"'?")) {
                return false;
            }
			form.ruleID.value = ruleID;
            form.operation.value = 'rule_del';    
        } else if('view' == oper){
			form.operation.value = "display";
			form.ruleID.value = ruleID;
			form.ruleRank.value = ruleRank;
		}

        return true;
    }
	
	function get_previoussibling(n)
	{
	    x=n.previousSibling;
	    while (x.nodeType!=1)
	      {
	      x=x.previousSibling;
	      }
	    return x;
	} 

	function get_nextsibling(n)
	{
	    x=n.nextSibling;
	    while ( x != null && x.nodeType!=1)
	      {
	      x=x.nextSibling;
	      }
	    return x;
	} 
	function MoveUp()
    {
        var table,
            row = this.parentNode;
        
        while ( row != null ) {
            if ( row.nodeName == 'TR' ) {
                break;
            }
            row = row.parentNode;
        }
        table = row.parentNode;
		var headingRow = table.firstChild;
		var subHeadingRow = get_nextsibling(headingRow);
		var firstDataRow = get_nextsibling(subHeadingRow);
		if(firstDataRow==row){
		}else{
        table.insertBefore ( row, get_previoussibling( row ) );
		}
    }

    function MoveDown()
    {
        var table,
            row = this.parentNode;
        
        while ( row != null ) {
            if ( row.nodeName == 'TR' ) {
                break;
            }
            row = row.parentNode;
        }
        table = row.parentNode;
        table.insertBefore ( row, get_nextsibling ( get_nextsibling( row ) ) );
    }
	
	function changeRulePriority(form){
		var ruleIDList="";
		//gets table
		var oTable = document.getElementById('ruleTable');

		//gets rows of table
		var rowLength = oTable.rows.length;
		
		//loops through rows    
		for (i = 2; i < rowLength; i++){

		   //gets cells of current row
			var oCells = oTable.rows.item(i).cells;
			var cellVal = oCells.item(6).innerHTML; // 7th column is ruleID
			cellVal = trimStr(cellVal)+";";
			ruleIDList +=cellVal;
		   //gets amount of cells of current row
		   //var cellLength = oCells.length;

		   //loops through each cell in current row
		   //for(var j = 0; j < cellLength; j++){
		      /* get your cell info here */
		      /* var cellVal = oCells.item(j).innerHTML; */
		   //}
		}

		form.ruleIDPriorityList.value=ruleIDList;
		form.operation.value = "display";
		return true;
	}
	
	function trimStr(str) {
      return str.replace(/^\s+|\s+$/g, '');
    }
	
	function createPageState(fromDateValue, fromTimeValue, toDateValue, toTimeValue, severity, server, logFile, displayOrder, resultsPerPage, requestedPageNumber) {
			var stateJSONObject = {};
			stateJSONObject.currentPageName = "event-rules.dsp";
			stateJSONObject.previousPageName = "";
			
			return stateJSONObject;
		}
    
  </script>
  <!-- <body onLoad="setNavigation('settings-global-variables.dsp', '/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_GlobalVariables');">-->
  <body>
   
    <table width="100%">
        <tr>
            <td class="breadcrumb" colspan="2">Monitoring &gt; Rules</td>
        </tr>
		
		%ifvar action%
			%invoke wx.monitoring.services.gui.events:handleEventRulesDspAction%
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
		
		%invoke wx.monitoring.services.gui.events:getEventRules%
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
        <tr>
            <td colspan="2">
                <ul style="none" class="listitems">
					%ifvar operation equals('editPriority')%
						<li class="listitem"><a disabled href="javascript:document.htmlform_rule_priority.submit();" onClick="return changeRulePriority(document.htmlform_rule_priority);">Save</a> </li>
						<li class="listitem"><a disabled href="event-rules.dsp">Cancel</a></li>
					%else%
	                    <li class="listitem"><a href="javascript:document.htmlform_rule_add.submit();" onClick="return populateForm(document.htmlform_rule_add, '' ,'','add','');">Add&nbsp;Rule&nbsp;</a></li>
						<li class="listitem"><a href="event-rules.dsp?operation=editPriority">Change Rules Priority</a> </li>
					%endifvar%
                </ul>
            </td>
        </tr>
        <tr>
			<td>    
				<table id="ruleTable" %ifvar operation equals('editPriority')%class="movingTable"%else%class="tableView"%endifvar%>
					<tr>
						<td class="heading" colspan="10">Monitoring Rules</td>
					</tr>
					<tr>
						
						<td class="subheading">Rule Pattern</td>
						<td class="subheading">Use Regex</td>
						<td class="subheading">Severity Threshold</td>
						<td class="subheading">Action</td>
						<td class="subheading">Enabled</td>
						<td class="subheading">%ifvar operation equals('editPriority')%Priority%else%Delete Rule%endifvar%</td>
						<td class="subheading" style="display:none;">Rule ID</td>
					</tr>
					%ifvar eventRules%
						%loop eventRules%
							<tr class="rowCounter">
								<td nowrap class="evenrowdata">
									<a  href="javascript:document.htmlform_rule_view.submit();" onClick="return populateForm(document.htmlform_rule_view, '%value id encode(javascript)%' ,'','view', '%value ruleRank encode(javascript)%');">
									   %value eventPattern encode(html)%
									</a>   
								</td>
								<td nowrap class="evenrowdata">
									%ifvar useRegex equals('true')% Yes %else% No %endifvar%                                               
								</td> 
								<td nowrap class="evenrowdata">
									%ifvar severity/severityThresholdOperator equals('gte')%&#62;&#61;%else%%ifvar severity/severityThresholdOperator equals('lte')%&#60;&#61;%else% &#61;%endifvar%%endifvar% %value severity/severityThreshold encode(html)%    
								</td>
								<td nowrap class="evenrowdata">
									%value action/actionDisplayName encode(html)%
								</td>
								<td nowrap class="evenrowdata">
									%ifvar isActive equals('true')% <img src="images/green_check.png" width="13" height="13" border="0">Yes</a> %else% No %endifvar%
								</td>
								<td nowrap class="evenrowdata">
								%ifvar /operation equals('editPriority')%
									<button onClick="MoveUp.call(this);">&#8679;</button>
									<button onClick="MoveDown.call(this);">&#8681;</button>
								%else%
									<a disabled href="javascript:document.htmlform_rule_delete.submit();" onClick="return populateForm(document.htmlform_rule_delete,'%value id encode(javascript)%' ,'%value eventPattern encode(javascript)%','delete');">
										<img src="images/delete.gif" border="no">
									</a> 
								%endifvar%
								</td>
								<td nowrap class="evenrowdata" style="display:none;">
									%value id encode(html)% 
								</td>
							</tr>
						%endloop%
					%else%
						<tr id="noResultBanner" class="field" align="left">
							<TD colspan=6 class="oddrowdata-l">---------------------------------- no results ----------------------------------</TD>
						</tr>
					%endifvar%
				</table>
			</td>
        </tr>
		<tr>
			<td colspan=1>
				<br>
				Rules will be executed in the order displayed. To update rule priority click "Change Rule Priority" link on top of the page.
			</td>
		</tr>
    </table>
	<form name="htmlform_rule_view" action="event-rule-addedit.dsp" method="POST">
        <input type="hidden" name="operation">
        <input type="hidden" name="ruleID">
		<input type="hidden" name="ruleRank">
    </form>
    <form name="htmlform_rule_delete" action="event-rules.dsp" method="POST">
        <input type="hidden" name="operation">
		<input type="hidden" name="action" value="deleteEventRule">
        <input type="hidden" name="ruleID">
    </form>
	<form name="htmlform_rule_priority" action="event-rules.dsp" method="POST">
        <input type="hidden" name="operation">
		<input type="hidden" name="action" value="updateRulesPriority">
        <input type="hidden" name="ruleIDPriorityList">
    </form>
	<form name="htmlform_rule_add" action="event-rule-addedit.dsp" method="POST">
        <input type="hidden" name="operation" value="add">
        <input type="hidden" name="ruleRank">
    </form>
  </body>   
</head>
