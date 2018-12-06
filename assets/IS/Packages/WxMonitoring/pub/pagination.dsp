%ifvar requestedPageNumber equals('1')%
%else%
	<a href="#"  onclick="goToFirstClick(%value form%);" id="goToFirst">&lt;&lt; Go to first</a> |
	<a href="#"  onclick="onPreviousClick(%value form%);" id="previous">&lt;Previous</a> |
%endifvar%
%ifvar totalPages vequals(requestedPageNumber)%
%else%
	<a href="#"  onclick="onNextClick(%value form%, '%value totalPages%');" id="next">Next &gt;</a> |
	<a href="#"  onclick="goToLastClick(%value form%, '%value totalPages%');" id="goToLast">Go to last &gt;&gt;</a> </br>							
%endifvar%
<span id="page_info">You are currently viewing page %value requestedPageNumber% of %value totalPages%</script></span>