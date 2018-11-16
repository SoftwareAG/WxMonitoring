			function manageDateFieldVisibility(){
				var select = document.getElementById("selCriteria");
				var divv = document.getElementById("dateFields");
				var value = select.value;
				if (value == "date" || value == "server") {
					toAppend = "&nbsp;&nbsp;<label for='dtFromDate'>From Date</label>&nbsp;<input id='dtFromDate' type='date' name='fromDate'/>&nbsp;&nbsp;<label for='dtToDate'>To Date</label>&nbsp;<input id='dtToDate' type='date' name='toDate'/>&nbsp;&nbsp;"; 
					divv.innerHTML=toAppend; 
					return;
				} else {
					toAppend = ""; 
					divv.innerHTML=toAppend; 
				}
			}
	
			function refresh(){	
		
				var url_string = window.location.href;		
				var url = new URL(url_string);
				var lastCriteria = url.searchParams.get("criteria");
		
				if(!lastCriteria){
				} else{
					var divv = document.getElementById("dateFields");
					if (lastCriteria == "date" || lastCriteria == "server") {

						toAppend = "&nbsp;&nbsp;<label for='dtFromDate'>From Date</label>&nbsp;<input id='dtFromDate' type='date' name='fromDate'/>&nbsp;&nbsp;<label for='dtToDate'>To Date</label>&nbsp;<input id='dtToDate' type='date' name='toDate'/>&nbsp;&nbsp;"; 
						divv.innerHTML=toAppend; 
						return;
					} else {
						toAppend = ""; 
						divv.innerHTML=toAppend; 
					} 
				}
			}
			