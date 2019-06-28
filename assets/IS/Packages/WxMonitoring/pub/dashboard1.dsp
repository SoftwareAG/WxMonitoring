<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
		<title>Dashboard</title>
		<link rel="stylesheet" type="text/css" href="webMethods.css">
		<!-- <link rel="stylesheet" type="text/css" href="bar-pie-graph.css">
		<link rel="stylesheet" type="text/css" href="indented-tree.css">
		<link rel="stylesheet" type="text/css" href="nodal-Tree.css"> -->
		<link rel="stylesheet" type="text/css" href="dashboard.css">
		<script src="webMethods.js.txt"></script>
		<script src="common-navigation.js"></script>
        <script src="dashboard.js"></script>
		
		
		<script src="indented-tree-d3_v4_min.js"></script>
		<script>
				d3version4 = d3
				window.d3 = null
			  </script>
		<script src="bar-pie-graph-d3_v3_min.js"></script>
		<script>
				d3version3 = d3
				window.d3 = null
			  </script>
		<script src="bar-pie-graph.js"></script>
		
		<script src="indented-tree.js"></script>
		<script src="nodal-tree.js"></script>
        <script>
            function toggleCtrl_TimeRange() {
                
                var selTimeRange = document.getElementById("selTimeRange");
                var dtFromDate = document.getElementById("fromCustomDate");
                var tmFromTime = document.getElementById("fromCustomTime");
                var dtToDate = document.getElementById("toCustomDate");
                var tmToTime = document.getElementById("toCustomTime");
                
                if (selTimeRange.value == 'custom') {
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
		</script>
		<style>
			
		</style>
    </head>
    <body>
		%invoke wx.monitoring.services.gui.dashboard:getDashboard1%
		%endinvoke%
		%scope dashboard%
		%rename ../timeRange timeRange -copy%
		%rename ../fromCustomDate fromDate -copy%
		%rename /fromCustomTime fromTime -copy%
		%rename /toCustomDate toDate -copy%
		%rename /toCustomTime toTime -copy%

			<div class="flex-container-content">
				<div class="flex-container-column">
						
						<table border="0"  width="100%" border="1" class="tableView">
								<tr>
									<td colspan="1" class="heading">Processes Summary- By Business Domain | From : %value fromTime encode(html)% | To : %value toTime encode(html)% </td>
								</tr>
								<tr>
									<td style="border: 0px;padding: 0px">

											<div id="processServerStructure_tree" class="flex-container-item"></div>
									</td>

								</tr>
							</table>
						<script>
								var processServerStructureString = '%value processServerStructureTreeJson encode(javascript)%' ;
								//alert(processServerStructureString);
								var processServerStructureJson = JSON.parse(processServerStructureString);
								createTree("#processServerStructure_tree",processServerStructureJson);
							</script>
					<table border="0"  width="100%" border="1" class="tableView">
							<tr>
								<td colspan="1" class="heading">Processes Summary- By Business Domain | From : %value fromTime encode(html)% | To : %value toTime encode(html)% </td>
							</tr>
							<tr>
								<td style="border: 0px;padding: 0px;">

										<div id="processStats_barPieGraph" class="flex-container-item"></div>
								</td>
							</tr>
						</table>
					<script>
						var processStatsString = '%value processStatsBarPieJson encode(javascript)%' ;
						var processStatsBarPieJson = JSON.parse(processStatsString);
						createGraph("#processStats_barPieGraph", processStatsBarPieJson,"process")
					</script> 

					
					
				</div>

				<div class="flex-container-column">
						
						<table border="0"  width="100%" border="1" class="tableView">
								<tr>
									<td colspan="1" class="heading">Event Summary- By Business Domain | From : %value fromTime encode(html)% | To : %value toTime encode(html)% </td>
								</tr>
								<tr>
									<td style="border: 0px;padding: 0px;">
	
											<div id="processStats_barPieGraph1" class="flex-container-item"></div>
									</td>
	
								</tr>
							</table>
					
					<script>
						var processStatsString1 = '%value eventStatsBarPieJson encode(javascript)%' ;
						
						var processStatsBarPieJson1 = JSON.parse(processStatsString1);
						createGraph("#processStats_barPieGraph1", processStatsBarPieJson1,"event")
					</script> 
					
					<div class="flex-container-item">
							<div id="processServerStructure_tree1" ></div>
					</div>
					<!-- <table border="0"  width="100%" border="1" class="tableView">
							<tr>
								<td colspan="1" class="heading">Processes Summary- By Business Domain | From : %value fromTime encode(html)% | To : %value toTime encode(html)% </td>
							</tr>
							<tr>
								<td style="border: 0px;padding: 0px;">

										<div id="processServerStructure_tree" class="flex-container-item"></div>
								</td>

							</tr>
						</table> -->

					
					
					<script>
						
						// var processServerStructureString = '%value processServerStructureTreeJson encode(javascript)%' ;
						
						// var processServerStructureJson = JSON.parse(processServerStructureString);
						// createTree("#processServerStructure_tree1",processServerStructureJson);

						var dataString = '{"children":[{"children":[{"children":[{"name":"AgglomerativeCluster","value":3938},{"name":"CommunityStructure","value":3812},{"name":"HierarchicalCluster","value":6714},{"name":"MergeEdge","value":743}],"name":"cluster"},{"children":[{"name":"BetweennessCentrality","value":3534},{"name":"LinkDistance","value":5731},{"name":"MaxFlowMinCut","value":7840},{"name":"ShortestPaths","value":5914},{"name":"SpanningTree","value":3416}],"name":"graph"},{"children":[{"name":"AspectRatioBanker","value":7074}],"name":"optimization"}],"name":"analytics"}],"name":"flare"}';
				var data = JSON.parse(dataString);
				createNodalTree("#processServerStructure_tree1",data);
					</script>
					
				</div>
			</div> 
		%endscope%
    </body>
        <!-- POST page load -->
	<script language="JavaScript">
        //toggleCtrl_TimeRange()
    </script>
</html>