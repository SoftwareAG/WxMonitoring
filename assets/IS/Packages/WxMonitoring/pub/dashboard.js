
function populateProcessForm(form, businessDomain, server, processStatus){
    
    var fromTimeStr = document.getElementById('processFromTime').value;
    var toTimeStr  = document.getElementById('processToTime').value;
    //alert(fromTimeStr);
    var fromDateValueStr = extractDateStamp(fromTimeStr);
    var toDateValueStr = extractDateStamp(toTimeStr);
    
    var fromTimeValueStr = extractTimeTillMinutes(fromTimeStr);
    var toTimeValueStr = extractTimeTillMinutes(toTimeStr);
    
    form.fromDateValue.value = fromDateValueStr;
    form.toDateValue.value = toDateValueStr;
    form.fromTimeValue.value = fromTimeValueStr;
    form.toTimeValue.value = toTimeValueStr;
    form.server.value = server;
    form.businessDomain.value = businessDomain;
    form.processStatus.value = processStatus;
    
    //form.processTimeRange.value = document.getElementById('dashboardProcessTimeRange').value;
    //form.eventTimeRange.value = document.getElementById('dashboardeventTimeRange').value;
    //form.processBusinessDomain.value = document.getElementById('dashboardprocessBusinessDomain').value;
    //form.eventServer.value = document.getElementById('dashboardeventServer').value;

    return true;
}

            
function populateEventForm(form, searchIdentifier, searchID, eventSeverityValue, filterEventsWithNoAction){
//searchIdentifier = which table (server or date) is clicked i.e. searchID = server name or date.
    form.severity.value = eventSeverityValue;
    form.filterEventsWithNoAction.value = filterEventsWithNoAction;
    if(searchIdentifier == "server" ){
        form.logFile.value = "ALL";
        
        var fromTimeStr = document.getElementById('eventFromTime').value;
        var toTimeStr  = document.getElementById('eventToTime').value;
        
        var fromDateValueStr = extractDateStamp(fromTimeStr);
        var toDateValueStr = extractDateStamp(toTimeStr);
        
        var fromTimeValueStr = extractTimeTillMinutes(fromTimeStr);
        var toTimeValueStr = extractTimeTillMinutes(toTimeStr);
        
        form.fromDateValue.value = fromDateValueStr;
        form.toDateValue.value = toDateValueStr;
        form.fromTimeValue.value = fromTimeValueStr;
        form.toTimeValue.value = toTimeValueStr;
        
        if(searchID == "ALL") {
            form.server.value = "ALL"; //redundant but intuitive.
        }else{
            form.server.value = searchID;
        }
        
    }else if (searchIdentifier == "logFile" ) {
    
        var fromTimeStr = document.getElementById('eventFromTime').value;
        var toTimeStr  = document.getElementById('eventToTime').value;
        
        var fromDateValueStr = extractDateStamp(fromTimeStr);
        var toDateValueStr = extractDateStamp(toTimeStr);
        
        var fromTimeValueStr = extractTimeTillMinutes(fromTimeStr);
        var toTimeValueStr = extractTimeTillMinutes(toTimeStr);
        
        form.fromDateValue.value = fromDateValueStr;
        form.toDateValue.value = toDateValueStr;
        form.fromTimeValue.value = fromTimeValueStr;
        form.toTimeValue.value = toTimeValueStr;
        
        if(searchID == "ALL") {
            form.logFile.value = "ALL"; //redundant but intuitive.
        }else{
            form.logFile.value = searchID;
        }
    } else {
        if(searchID == "ALL") {
            var fromTimeStr = document.getElementById('eventFromTime').value;
            var toTimeStr  = document.getElementById('eventToTime').value;
            
            var fromDateValueStr = extractDateStamp(fromTimeStr);
            var toDateValueStr = extractDateStamp(toTimeStr);
            
            var fromTimeValueStr = extractTimeTillMinutes(fromTimeStr);
            var toTimeValueStr = extractTimeTillMinutes(toTimeStr);
            
            form.fromDateValue.value = fromDateValueStr;
            form.toDateValue.value = toDateValueStr;
            form.fromTimeValue.value = fromTimeValueStr;
            form.toTimeValue.value = toTimeValueStr;
        } else {
        
            var fromTimeStr = document.getElementById('eventFromTime').value;
            var toTimeStr  = document.getElementById('eventToTime').value;
            
            var fromDateValueStr = extractDateStamp(searchID);
            var toDateValueStr = extractDateStamp(searchID);
            
            var fromTimeValueStr = extractTimeTillMinutes(fromTimeStr);
            var toTimeValueStr = extractTimeTillMinutes(toTimeStr);

            if(fromDateValueStr==searchID){
                form.fromDateValue.value = searchID;
                form.fromTimeValue.value = fromTimeValueStr;
                form.toDateValue.value = searchID;
                form.toTimeValue.value = "23:59";
            } else if(toDateValueStr==searchID){
                form.fromDateValue.value = searchID;
                form.fromTimeValue.value = "00:00";
                form.toDateValue.value = searchID;
                form.toTimeValue.value = toTimeValueStr;
            }else {
                form.fromDateValue.value = searchID;
                form.fromTimeValue.value = "00:00";
                form.toDateValue.value = searchID;
                form.toTimeValue.value = "23:59";
            }
        }
    }
    return true;
}

function manageProcessAndEventRefresh(form, operation, arg1, arg2, refreshSource){

    if(refreshSource == "event") {
        var processTimeRangeValue = arg1;
        var processBusinessDomainValue = arg2;
        
        form.processTimeRange.value = processTimeRangeValue;
        form.processBusinessDomain.value = processBusinessDomainValue;
        form.eventTimeRange.value = document.getElementById('selEventTimeRange').value;
        form.eventServer.value = document.getElementById('selServer').value;
    } else {
        var eventTimeRangeValue = arg1;
        var eventServerValue = arg2;
        
        form.processTimeRange.value = document.getElementById('selProcessTimeRange').value;
        form.processBusinessDomain.value = document.getElementById('selBusinessDomain').value;
        form.eventTimeRange.value = eventTimeRangeValue;
        form.eventServer.value = eventServerValue;
    }
    
    form.submit();
    return true;

}

function concatDateAndTime(date, time){
    var dateTimeString = date + " " + time + ":00";
    return dateTimeString;
}

function extractDateStamp(dateTimeString){
    var dateTime = new Date(dateTimeString);
    var day = dateTime.getDate(); //Date of the month: 2 in our example
    if(day < 10){
        day = "0" + day;
    }
    var month = dateTime.getMonth(); //Month of the Year: 0-based index, so 1 in our example
    month = month + 1;
    if(month < 10){
        month = "0" + month;
    }
    var year = dateTime.getFullYear()
    var dateStamp = year + "-" + month + "-" + day;
    
    return dateStamp;
}

function extractTimeTillMinutes(dateTimeString){
    var dateTime = new Date(dateTimeString);
    var hours = dateTime.getHours(); //Date of the month: 2 in our example
    if(hours < 10){
        hours = "0" + hours;
    }
    var minutes = dateTime.getMinutes(); //Month of the Year: 0-based index, so 1 in our example
    if(minutes < 10){
        minutes = "0" + minutes;
    }
    var year = dateTime.getFullYear()
    var timestamp = hours + ":" + minutes;
    
    return timestamp;
}

function AddProcesses(total, active, completed, exception, failed, cancelled){

if(total)
{
var currentTotalSum = document.getElementById("allTotal").value;
currentTotalSum = parseInt(currentTotalSum) + parseInt(total);
document.getElementById("allTotal").value = currentTotalSum;
}

if(active){
var currentActiveSum = document.getElementById("allActive").value;
currentActiveSum = parseInt(currentActiveSum) + parseInt(active);
document.getElementById("allActive").value = currentActiveSum;
}

if(completed){
var currentCompletedSum = document.getElementById("allCompleted").value;
currentCompletedSum = parseInt(currentCompletedSum) + parseInt(completed);
document.getElementById("allCompleted").value = currentCompletedSum;
}

if(exception){
var currentExceptionSum = document.getElementById("allException").value;
currentExceptionSum = parseInt(currentExceptionSum) + parseInt(exception);
document.getElementById("allException").value = currentExceptionSum;
}

if(failed || exception){
var currentFailedSum = document.getElementById("allFailed").value;
if(failed){
currentFailedSum = parseInt(currentFailedSum) + parseInt(failed);
}
if(exception){
    currentFailedSum = parseInt(currentFailedSum) + parseInt(exception) ;
}
document.getElementById("allFailed").value = currentFailedSum;
}

if(cancelled){
var currentCancelledSum = document.getElementById("allCancelled").value;
currentCancelledSum = parseInt(currentCancelledSum) + parseInt(cancelled);
document.getElementById("allCancelled").value = currentCancelledSum;
}
}

function writeAttributeValue(myAttributeID){
    var myAttributeValue =  document.getElementById(myAttributeID).value;
    myAttributeValue = myAttributeValue.bold();
    document.write(myAttributeValue);
    document.getElementById(myAttributeID).value = "0";
}

function writeFailedProcessesCount(exceptionCount, failedCount){
    var myAttributeValue =  0;

    if(exceptionCount || failedCount){
    
        if(failedCount){
            myAttributeValue = parseInt(myAttributeValue) + parseInt(failedCount);
        }
        if(exceptionCount){
            myAttributeValue = parseInt(myAttributeValue) + parseInt(exceptionCount) ;
        }
    } else {
        myAttributeValue = "-";
    }
    
    document.write(myAttributeValue);
    
}

function createPageState(processTimeRange, eventTimeRange, processBusinessDomain, eventServer) {
    var stateJSONObject = {};
    stateJSONObject.currentPageName = "dashboard.dsp";
    stateJSONObject.previousPageName = "";
    stateJSONObject.processTimeRange = processTimeRange;
    stateJSONObject.eventTimeRange = eventTimeRange;
    stateJSONObject.processBusinessDomain = processBusinessDomain;
    stateJSONObject.eventServer = eventServer;
    
    return stateJSONObject;
}

