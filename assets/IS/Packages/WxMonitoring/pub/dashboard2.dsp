<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
		<title>Dashboard</title>
        <link rel="stylesheet" type="text/css" href="webMethods.css">
        <link rel="stylesheet" type="text/css" href="nodal-tree.css">
		<script src="webMethods.js.txt"></script>
		<script src="common-navigation.js"></script>
        <script src="dashboard.js"></script>
        <script src="indented-tree-d3_v4_min.js"></script>
        <script>
				d3version4 = d3
				window.d3 = null
			  </script>
        <script src="nodal-tree.js"></script>
        
	</head>
<body>
        <div id="chart" width="500"></div>
        <script>
                var dataString = '{"children":[{"children":[{"children":[{"name":"AgglomerativeCluster","value":3938},{"name":"CommunityStructure","value":3812},{"name":"HierarchicalCluster","value":6714},{"name":"MergeEdge","value":743}],"name":"cluster"},{"children":[{"name":"BetweennessCentrality","value":3534},{"name":"LinkDistance","value":5731},{"name":"MaxFlowMinCut","value":7840},{"name":"ShortestPaths","value":5914},{"name":"SpanningTree","value":3416}],"name":"graph"},{"children":[{"name":"AspectRatioBanker","value":7074}],"name":"optimization"}],"name":"analytics"}],"name":"flare"}';
                var data = JSON.parse(dataString);
                createNodalTree("#chart",data);
            </script>
    </body>