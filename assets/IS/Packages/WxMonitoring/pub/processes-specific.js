function refresh(){
	var query_string = window.location.search;
	if(!query_string){
		resetDashboardState();
		document.getElementById("resultsPerPage").value = getElementLastValue("resultsPerPage");
		document.getElementById("requestedPageNumber").value = getElementLastValue("requestedPageNumber");
		setRadioButtonValue("order",getElementLastValue("order"));
	} else{
		document.getElementById("resultsPerPage").value = getElementLastValue("resultsPerPage");
		document.getElementById("requestedPageNumber").value = getElementLastValue("requestedPageNumber");
		setRadioButtonValue("order",getElementLastValue("order"));
	}
}

function setRadioButtonValue(radioObjName, newValue) {
	var radioObj = document.getElementsByName(radioObjName);
	if(!radioObj)
		return;
	var radioLength = radioObj.length;
	if(radioLength == undefined) {
		radioObj.checked = (radioObj.value == newValue.toString());
		return;
	}
	for(var i = 0; i < radioLength; i++) {
		radioObj[i].checked = false;
		if(radioObj[i].value == newValue.toString()) {
			radioObj[i].checked = true;
		}
	}
}

function getRadioButtonValue(radioObjName){
	var radios = document.getElementsByName(radioObjName);
	for (var i = 0, length = radios.length; i < length; i++){
		if (radios[i].checked){
  // do whatever you want with the checked radio
			return radios[i].value;
			// only one radio can be logically checked, don't check the rest
		break;
		}
	}
	return "";
}

function getCurrentDate() {
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

	if(dd<10) {
		dd = '0'+dd
	} 

	if(mm<10) {
		mm = '0'+mm
	} 

	today = yyyy + '-' + mm + '-' + dd;
	
	return today;
}

//get the saved value function - return the value of "v" from localStorage. 
function getElementLastValue(id){
	if (typeof(Storage) !== "undefined") {
    // Code for localStorage/sessionStorage.
		if(sessionStorage.getItem(id) == null) {
			if(id=="selStatus" || id == "selServer" || id == "selBusinessDomain"){
				return "ALL";
			} else if(id=="tmFromTime" || id == "tmToTime") {
				if(id=="tmFromTime"){
					return "00:00"
				} else {
					return "23:59"		
				}				
			} else if(id=="dtFromDate" || id == "dtToDate"){
				return getCurrentDate();
			} else if(id=="resultsPerPage"){
				return "100";
				
			} else if(id=="requestedPageNumber" || id=="totalPages"){
				return "1";				
			} else if(id=="order") {
				return "desc";
			}{
				return "";
		}			
		}
		return sessionStorage.getItem(id);
	} else {
    // Sorry! No Web Storage support..
	return "";
	}
}

function removeElementLastValue(id) {

	if (typeof(Storage) !== "undefined") {
    // Code for localStorage/sessionStorage.
		sessionStorage.removeItem(id);
	} else {
    // Sorry! No Web Storage support..
	//alert("setElementLastValue : current value : " + document.getElementById("tmFromTime").value);
	}	
	
}

function setElementLastValue(id, value) {

	if (typeof(Storage) !== "undefined") {
    // Code for localStorage/sessionStorage.
		sessionStorage.setItem(id, value);
	} else {
    // Sorry! No Web Storage support..
	//alert("setElementLastValue : current value : " + document.getElementById("tmFromTime").value);
	}	
	
}

function resetDashboardState(){
	removeElementLastValue("resultsPerPage") ;
	removeElementLastValue("requestedPageNumber") ;
	removeElementLastValue("order") ;
}

function saveDashboardState(){
	setElementLastValue("resultsPerPage", document.getElementById("resultsPerPage").value) ;
	setElementLastValue("requestedPageNumber", document.getElementById("requestedPageNumber").value) ;
	setElementLastValue("order", getRadioButtonValue("order")) ;
	setElementLastValue("totalPages", document.getElementById("totalPages").value) ;
}

function convertDateTimeToUTC(date, time){
	
	var dateString = date + " " + time + ":00";
	var date = new Date(dateString);
	var dateInISOFormat = date.toISOString();
	
	return dateInISOFormat;
}

function convertUTCToLocalDateTimeString(utcDate){
	
	//alert("convertUTCToLocalDateTimeString :" + utcDate);
	var date = new Date(utcDate);
	var dateLocal= date.toLocaleString();
	//document.getElementById("eventTimestamp").innerText = "";
	document.write(dateLocal);
}

function concatDateAndTime(date, time){
	var dateString = date + " " + time + ":00";
	return dateString;
}

function refreshWithFilterValues(){
	
	var url = "process-stats-specific.dsp?fromTime=" + document.getElementById("fromTime").value + "&toTime=" + document.getElementById("toTime").value + "&server=" + document.getElementById("server").value + "&processStatus=" + document.getElementById("processStatus").value + "&businessDomain=" + document.getElementById("businessDomain").value + "&requestedPageNumber=" + getElementLastValue("requestedPageNumber") + "&resultsPerPage=" + getElementLastValue("resultsPerPage") + "&displayOrder=" + getElementLastValue("order");
	
	//setElementLastValue("testBox", url) ;
	location.href = url;
}

function saveDashboardStateAndRefresh() {
	saveDashboardState();
	
	refreshWithFilterValues();
		
}

function populateForm(form, processESID){
	
	form.processESID.value= processESID;
	form.navigationSequence.value = getElementLastValue("navigationSequence");
	return true;
}

function onReturnClick() {

	var navigationSequenceStr = getElementLastValue("navigationSequence");
	var allNavigationSources = navigationSequenceStr.split(";");
	var lastNavigationSource = allNavigationSources[0];
	allNavigationSources = allNavigationSources.splice(0,1); // remove first element from sequence
	navigationSequenceStr = allNavigationSources.join(';');
	setElementLastValue("navigationSequence", navigationSequenceStr);
	
	if(lastNavigationSource=="dashboard"){
		var url = "dashboard.dsp?processTimeRange=" + getElementLastValue("dashboardArg1") + "&eventTimeRange=" + getElementLastValue("dashboardArg2") + "&processBusinessDomain=" + getElementLastValue("dashboardArg3") + "&eventServer=" + getElementLastValue("dashboardArg4") + "&navigationSequence=" + getElementLastValue("navigationSequence");
	} else if(lastNavigationSource=="processStatsGeneral") {
		var url = "process-stats-general.dsp?businessDomain=" + getElementLastValue("processStatsGeneralArg1") + "&criteria=" + getElementLastValue("processStatsGeneralArg2") + "&fromDateValue=" + getElementLastValue("processStatsGeneralArg3") + "&fromTimeValue=" + getElementLastValue("processStatsGeneralArg4") + "&toDateValue=" + getElementLastValue("processStatsGeneralArg5") + "&toTimeValue=" + getElementLastValue("processStatsGeneralArg6") + "&navigationSequence=" + getElementLastValue("navigationSequence");
		
	} else {
		var url = "process-stats-general.dsp";
	}

	location.href = url;	
}
		
function saveReturnNavigationState(navigationSource, navigationSequence, arg1, arg2, arg3, arg4, arg5, arg6){
	setElementLastValue("navigationSource", navigationSource);
	setElementLastValue("navigationSequence", navigationSequence);
		
	if(navigationSource=="dashboard"){		
		setElementLastValue("dashboardArg1", arg1);
		setElementLastValue("dashboardArg2", arg2);
		setElementLastValue("dashboardArg3", arg3);
		setElementLastValue("dashboardArg4", arg4);
		
	} else if(navigationSource=="processStatsGeneral") {
		setElementLastValue("processStatsGeneralArg1", arg1); //businessDomain
		setElementLastValue("processStatsGeneralArg2", arg2); //criteria
		setElementLastValue("processStatsGeneralArg3", arg3); //fromDateValue
		setElementLastValue("processStatsGeneralArg4", arg4); //fromTimeValue
		setElementLastValue("processStatsGeneralArg5", arg5); //toDateValue
		setElementLastValue("processStatsGeneralArg6", arg6); //toTimeValue
	}
	
	
}
		
		

