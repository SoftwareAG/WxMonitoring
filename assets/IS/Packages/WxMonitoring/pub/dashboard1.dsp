<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
		<title>Dashboard</title>
		<link rel="stylesheet" type="text/css" href="webMethods.css">
		<link rel="stylesheet" type="text/css" href="bar-pie-graph.css">
		<link rel="stylesheet" type="text/css" href="indented-tree.css">
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
		<script src="bar-pie-graph3.js"></script>
		
        <script src="indented-tree.js"></script>
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
			.flex-container-content {
				display: flex;
				flex-direction: row;
				
				}
			.flex-container-column {
				display: flex;
				flex-direction: column;
				align-items:flex-start;
				justify-content: space-between
				}
			.flex-container-item {
				display: flex;
				justify-content: flex-start;
				flex-wrap: nowrap;
				flex-basis: auto;
				align-content: stretch;
				}
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
						
						<div id="processServerStructure_tree" class="flex-container-item"></div>
						<script>
								//var processServerStructureString = '{"name":"WxMonitoring","children":[{"name":"Server1","children":[{"name":"BD1","children":[{"name":"Process1","size":3938},{"name":"Process2","size":3812},{"name":"Process3","size":6714}]},{"name":"BD2","children":[{"name":"Process4","size":3534},{"name":"Process1","size":5731}]},{"name":"BD3","children":[{"name":"Process5","size":7074}]}]},{"name":"Server2","children":[{"name":"BD4","children":[{"name":"Process4","size":1983},{"name":"Process1","size":2047},{"name":"Process5","size":1375}]}]},{"name":"Server3","children":[{"name":"BD5","children":[{"name":"Process6","size":721},{"name":"Process7","size":4294},{"name":"Process8","size":9800},{"name":"Process1","size":1314},{"name":"Process9","size":2220}]}]}]}';
								var processServerStructureString = '%value processServerStructureTreeJson encode(javascript)%' ;
								//alert(processServerStructureString);
								var processServerStructureJson = JSON.parse(processServerStructureString);
								createTree("#processServerStructure_tree",processServerStructureJson);
							</script>
					<div id="processStats_barPieGraph" class="flex-container-item"></div>
					<script>
						var processStatsString = '%value processStatsBarPieJson encode(javascript)%' ;
						var processStatsBarPieJson = JSON.parse(processStatsString);
						createGraph("#processStats_barPieGraph", processStatsBarPieJson,"process")
					</script> 

					
					
				</div>

				<div class="flex-container-column">
					<div id="processStats_barPieGraph1" class="flex-container-item"></div>
					<script>
						var processStatsString = '%value processStatsBarPieJson encode(javascript)%' ;
						var processStatsBarPieJson = JSON.parse(processStatsString);
						createGraph("#processStats_barPieGraph1", processStatsBarPieJson,"process")
					</script> 

					<div id="processServerStructure_tree1" class="flex-container-item"></div>
					<script>
						//var processServerStructureString = '{"name":"WxMonitoring","children":[{"name":"Server1","children":[{"name":"BD1","children":[{"name":"Process1","size":3938},{"name":"Process2","size":3812},{"name":"Process3","size":6714}]},{"name":"BD2","children":[{"name":"Process4","size":3534},{"name":"Process1","size":5731}]},{"name":"BD3","children":[{"name":"Process5","size":7074}]}]},{"name":"Server2","children":[{"name":"BD4","children":[{"name":"Process4","size":1983},{"name":"Process1","size":2047},{"name":"Process5","size":1375}]}]},{"name":"Server3","children":[{"name":"BD5","children":[{"name":"Process6","size":721},{"name":"Process7","size":4294},{"name":"Process8","size":9800},{"name":"Process1","size":1314},{"name":"Process9","size":2220}]}]}]}';
						var processServerStructureString = '%value processServerStructureTreeJson encode(javascript)%' ;
						//alert(processServerStructureString);
						var processServerStructureJson = JSON.parse(processServerStructureString);
						createTree("#processServerStructure_tree1",processServerStructureJson);
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