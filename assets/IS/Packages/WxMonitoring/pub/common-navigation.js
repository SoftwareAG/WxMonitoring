function setElementLastValue(id, value) {

	if (typeof(Storage) !== "undefined") {
    // Code for localStorage/sessionStorage.
		sessionStorage.setItem(id, JSON.stringify(value));
	} else {
    // Sorry! No Web Storage support..
	//alert("setElementLastValue : current value : " + document.getElementById("tmFromTime").value);
	}	
	
}

//get the saved value function - return the value of "v" from localStorage. 
function getElementLastValue(id){
	if (typeof(Storage) !== "undefined") {
    // Code for localStorage/sessionStorage.
		if(sessionStorage.getItem(id) == null) {
			return "" ;
		}
		var storedItem = JSON.parse(sessionStorage.getItem(id));
		return storedItem;
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

function getLastPageName(currentPageName) {

	var navigationSequenceArray = getElementLastValue("navigation_sequence");
	if(navigationSequenceArray){
		var last = navigationSequenceArray[navigationSequenceArray.length - 1];
		if(last==currentPageName){
			if(navigationSequenceArray.length>1){
				return navigationSequenceArray[navigationSequenceArray.length - 2];
			}
		}else{
			return last;
		}
		
	}else{
		return "";
	}
}

function printArray(arrayToPrint){
	var arrayStr ="";
	for(var i=0;i<arrayToPrint.length;i++){
		arrayStr +=arrayToPrint[i]+" --> ";
	}
	alert(arrayStr);
	
}

function savePageState(pageName, pageState, startNewNavigationSequence){
	var navigationSequenceArray = getElementLastValue("navigation_sequence");

	if(startNewNavigationSequence==true){
		navigationSequenceArray = [];
		navigationSequenceArray.push(pageName);
	}else{
		
		if(navigationSequenceArray){
			var last = navigationSequenceArray[navigationSequenceArray.length - 1];
			if(last != pageName){
				navigationSequenceArray.push(pageName);
			}		
		}else{
				navigationSequenceArray = [];
				navigationSequenceArray.push(pageName);
			}
	}

	setElementLastValue("navigation_sequence", navigationSequenceArray);
	
	var stateKey = pageName + "_state";
	setElementLastValue(stateKey, pageState);
	
	//printArray(navigationSequenceArray);
}



function cleanNavigationSequence(){	
	var navigationSequenceArray = getElementLastValue("navigation_sequence");
	//remove itself and also previous page from sequence
	if(navigationSequenceArray){
		for(var i=0;i<2;i++){
			if(navigationSequenceArray.length !=0)
				navigationSequenceArray.pop();	
		} 
	}	
	//put remaining back in storage.
	if(navigationSequenceArray.length !=0){
		setElementLastValue("navigation_sequence", navigationSequenceArray);	
	} 
}

function getPageState(pageName){
	//get page state.
	var stateKey = pageName + "_state";
	return getElementLastValue(stateKey);
}

function onNextClick(currentForm, totalPagesValue) {
	//var totalPagesValue = currentForm.totalPages.value;
	totalPagesValue = parseInt(totalPagesValue);
	var currPageNo = currentForm.requestedPageNumber.value;
	currPageNo = parseInt(currPageNo);
	currPageNo = currPageNo + 1;

	if(currPageNo<=totalPagesValue){

		currentForm.requestedPageNumber.value = currPageNo;

		currentForm.submit();
	}
}

function onPreviousClick(currentForm) {
	
	var currPageNo = currentForm.requestedPageNumber.value;
	currPageNo = parseInt(currPageNo);
	if(currPageNo>1){
		currPageNo = currPageNo - 1;
		currentForm.requestedPageNumber.value = currPageNo;
	
		currentForm.submit();
	}		
}

function goToFirstClick(currentForm) {
	
	var currPageNo = currentForm.requestedPageNumber.value;
	currPageNo = parseInt(currPageNo);
	
	if(currPageNo != 1){
		currPageNo = 1;
		currentForm.requestedPageNumber.value = currPageNo;
	
		currentForm.submit();
	}
}

function goToLastClick(currentForm, totalPagesValue) {

	//var totalPagesValue = currentForm.totalPages.value;
	totalPagesValue = parseInt(totalPagesValue);
	var currPageNo = currentForm.requestedPageNumber.value;
	currPageNo = parseInt(currPageNo);

	if(currPageNo!=totalPagesValue){

		currentForm.requestedPageNumber.value = totalPagesValue;

		currentForm.submit();
	}
}

