function populateForm(form, action){
	if(action == "goToMWSProcess"){
		form.operation.value= 'goToMWSProcess';
	} else if(action == "processSendEmail"){
		form.operation.value= 'processSendEmail';
	} else if(action == "processRaiseJIRA"){
		form.operation.value= 'processRaiseJIRA';
	}
	
	return true;
}

function setElementLastValue(id, value) {
	if (typeof(Storage) !== "undefined") {
    // Code for localStorage/sessionStorage.
		sessionStorage.setItem(id, value);
	} else {
    // Sorry! No Web Storage support..
	}	
}

function getElementLastValue(id){
	if (typeof(Storage) !== "undefined") {
    // Code for localStorage/sessionStorage.
		if(sessionStorage.getItem(id) == null) {
			return "" ;
		}
		return sessionStorage.getItem(id);
	} else {
    // Sorry! No Web Storage support..
	return "";
	}
}


function saveReturnNavigationState(navigationSource, navigationSequence, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11){
	setElementLastValue("navigationSource", navigationSource);
	setElementLastValue("navigationSequence", navigationSequence);
	
	if(navigationSource=="processesGeneral"){
		setElementLastValue("processesGeneralArg1", arg1);
		setElementLastValue("processesGeneralArg2", arg2);
		setElementLastValue("processesGeneralArg3", arg3);
		setElementLastValue("processesGeneralArg4", arg4);
		setElementLastValue("processesGeneralArg5", arg5);
		setElementLastValue("processesGeneralArg6", arg6);
		setElementLastValue("processesGeneralArg7", arg7);
		setElementLastValue("processesGeneralArg8", arg8);
		setElementLastValue("processesGeneralArg9", arg9);
		setElementLastValue("processesGeneralArg10", arg10);
		setElementLastValue("processesGeneralArg11", arg11);
	} else if (navigationSource=="processesSpecific"){
		setElementLastValue("processesSpecificArg1", arg1);
		setElementLastValue("processesSpecificArg2", arg2);
		setElementLastValue("processesSpecificArg3", arg3);
		setElementLastValue("processesSpecificArg4", arg4);
		setElementLastValue("processesSpecificArg5", arg5);
		setElementLastValue("processesSpecificArg6", arg6);
		setElementLastValue("processesSpecificArg7", arg7);
		setElementLastValue("processesSpecificArg8", arg8);
		setElementLastValue("processesSpecificArg9", arg9);
		setElementLastValue("processesSpecificArg10", arg10);
		setElementLastValue("processesSpecificArg11", arg11);		
	}
}

function onReturnClick() {
	
	var navigationSequenceStr = getElementLastValue("navigationSequence");
	var allNavigationSources = navigationSequenceStr.split(";");
	var lastNavigationSource = allNavigationSources[0];
	allNavigationSources.splice(0,1); // remove first element from sequence
	navigationSequenceStr = allNavigationSources.join(';');
	setElementLastValue("navigationSequence", navigationSequenceStr);

	if(lastNavigationSource=="processesGeneral"){
		var url = "processes-general.dsp?fromDateValue=" + getElementLastValue("processesGeneralArg1") + "&fromTimeValue=" + getElementLastValue("processesGeneralArg2") + "&toDateValue=" + getElementLastValue("processesGeneralArg3") + "&toTimeValue=" + getElementLastValue("processesGeneralArg4") + "&server=" + getElementLastValue("processesGeneralArg5") + "&processStatus=" + getElementLastValue("processesGeneralArg6") + "&businessDomain=" + getElementLastValue("processesGeneralArg7") + "&sortBy=" + getElementLastValue("processesGeneralArg8") + "&displayOrder=" + getElementLastValue("processesGeneralArg9") + "&resultsPerPage=" + getElementLastValue("processesGeneralArg10") + "&requestedPageNumber=" + getElementLastValue("processesGeneralArg11") + "&navigationSequence=" + getElementLastValue("navigationSequence");
	} else if(lastNavigationSource=="processesSpecific"){
		var url = "process-stats-specific.dsp?fromDateValue=" + getElementLastValue("processesSpecificArg1") + "&fromTimeValue=" + getElementLastValue("processesSpecificArg2") + "&toDateValue=" + getElementLastValue("processesSpecificArg3") + "&toTimeValue=" + getElementLastValue("processesSpecificArg4") + "&server=" + getElementLastValue("processesSpecificArg5") + "&processStatus=" + getElementLastValue("processesSpecificArg6") + "&businessDomain=" + getElementLastValue("processesSpecificArg7") + "&sortBy=" + getElementLastValue("processesSpecificArg8") + "&displayOrder=" + getElementLastValue("processesSpecificArg9") + "&resultsPerPage=" + getElementLastValue("processesSpecificArg10") + "&requestedPageNumber=" + getElementLastValue("processesSpecificArg11") + "&navigationSequence=" + getElementLastValue("navigationSequence");
	} else {
		var url = "processes-general.dsp";
	}
	location.href = url;	
}