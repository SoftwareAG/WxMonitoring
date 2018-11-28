<HTML>
    <HEAD>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
		<link rel="stylesheet" type="text/css" href="top.css">
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
		<script src="csrf-guard.js.txt"></script>
    </HEAD>

    <script>
        function launchHelp() {
            if (parent.menu != null){
                window.open(parent.menu.document.forms["urlsaver"].helpURL.value, 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
            }
        }
        
	function logIEout() {
	  if (confirm("OK to log off?")) {
	    return true;
	  } else {
	    return false;
	  }
	} 
	   
        function loadPage(url) {
			if(is_csrf_guard_enabled && needToInsertToken) {
				if(url.indexOf("?") != -1){
					url = url+"&"+ _csrfTokenNm_ + "=" + _csrfTokenVal_;
				} else {
					url = url+"?"+ _csrfTokenNm_ + "=" + _csrfTokenVal_;
				}
			} 
            window.location.replace(url);
        }
    function switchToQuiesceMode(form , mode)
	{
		var delayTime=-1;
                if(mode == "false" || mode == false) {
                        delayTime = prompt("OK to enter quiesce mode?\nSpecify the maximum number of minutes to wait before disabling packages:",0);
                        if(delayTime == null) { return false;}
                        else{
                                if(((parseFloat(delayTime) == parseInt(delayTime)) && !isNaN(delayTime)) && parseInt(delayTime) >= 0){
                                        form.isQuiesceMode.value = true;
                                        form.timeout.value = delayTime;
                                        return true;
                                }
                                else{ alert("Enter positive integer value.");
                                        return false;
                                }
                        }
                }
                if(mode == "true" || mode == true) {
                        if (confirm("OK to exit quiesce mode?")) {
                                form.isQuiesceMode.value = false;
                                return true;
                        } else {
                                return false;
                        }
                }
                return false;
	}
	function displayMode(mode) {
		var temp = document.getElementById("quieseModeMessage");
		if(temp == null || temp == undefined) 
			return;
		
		if(mode == "true" || mode == true){
			
			if(temp.innerHTML == '' || temp.innerHTML == '&nbsp;'){
				temp.style.display = "block";
				temp.innerHTML = "<center>Integration Server is running in quiesce mode.</center>";
			}	
		}
	}

	function displayMessage(mode,message) {
		var temp = document.getElementById("quieseModeMessage");
		if(temp == null || temp == undefined) 
			return;
		if(mode == "true" || mode == true){
			
			temp.style.display = "block";
			temp.innerHTML = "<center>"+message+"</center>";
		}
		else
		{
			temp.innerHTML = "";
			temp.style.display = "none";
		}
	}
	
        %ifvar message%
            %ifvar norefresh%
            %else%
                setTimeout("loadPage('top.dsp')", 30000);
            %endif%
        %endif%
    </script>

    <BODY class="topbar" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
         
        <table border=0 cellspacing=0 cellpadding=0 height=70 width=100%>
            <tr>
                <td>
                    <TABLE height=14 width=100% CELLSPACING=0 cellpadding=0 BORDER=0>
                        <TR>

                            %invoke wm.server.query:getServerInstanceName%

							<td class="saglogo">
								%ifvar productname equals('Integration Agent')%
								<img src="images/ia_logo.png" /><br/>
								%else%
								<img src="images/is_logo.png" /><br/>
								%endif%
			              	</td>
                            <TD nowrap class="toptitle" width="100%">
                                %ifvar instancename%
                                  %value instancename%
                                  ::
                                %endif%
                                %value $host%
                                %ifvar text%
                                    ::
                                    %value text%
                                %endif%
								%invoke wm.server.query:getCurrentUser%
								%ifvar username%
									:: %value  username%
								%endif%
								%endinvoke%
                            </TD>
                            %endinvoke%
                        </TR>
                    </TABLE>
                </td>
            </tr>
      
            <tr height=100%>
				<td nowrap valign="top">
                    <TABLE width=100% height=40 CELLSPACING=0  cellpadding=0>       
						<TR >
							<TD width = "60%"  height = "100%" >
								<TABLE width = "100%"  height = "100%" CELLSPACING=0 cellpadding=0>
									<tr  width = "100%" >
										<td  width=100% class="keymessage" id="quieseModeMessage" name="quieseModeMessage" style = "display:none;"></td>
									</tr>
									<tr  width = "100%">
							 			%ifvar adapter%
										%else%
											%invoke wm.server.query:isSafeMode%
												%ifvar isSafeMode equals('true')%
													%ifvar isSane equals('false')%
														<TD width=100% class="keymessage" >
															<center>
																SERVER IS RUNNING IN SAFE MODE. Master password sanity check failed -- invalid master password provided. 
															</center>
														</TD>
													%else%
														<TD width=100% class="keymessage" >
															<center>
																SERVER IS RUNNING IN SAFE MODE
															</center>
														</TD>
													%endif%
													
												%endif%
											%endinvoke%

											%invoke wm.server.query:getLicenseSettings%
												%ifvar keyExpired%
													<TD width=100% class="keymessage">
														<center>
															<A  class="keymessage" HREF="settings-license-edit.dsp" TARGET="main">
																License Key is Expired or Invalid.
															</A>
														</center>
													</TD>
												%else%
													%ifvar keyExpiresIn%
														<TD width=100% class="keymessage">
															<center>
																&nbsp;
																<A class="keymessage" HREF="settings-license-edit.dsp" TARGET="main">
																	%ifvar keyExpiresIn equals('0')%
																		License Key expires today.
																	%else%
																		License Key expires in about %value keyExpiresIn% days
																	%endif%
																</A>
															</center>
														</TD>
													%else%
														<!--removed code while adding quiese support -->
													%endif%
												%endif%
											%endinvoke%
											
											%endif%
									</tr>
								</TABLE>
							</td>	
							<!--
                            <TD nowrap valign="bottom" class="topmenu">
			        
				 %invoke wm.server:getSessionID% 
				   %ifvar sessionid not  equals('null')%				  
				   %endif%  
				   
                                %ifvar adapter%
				   
                                    <A href='javascript:window.parent.close();'>Close Window</A>
                
                                    %ifvar adapter equals('SAP')%
                                        | <a  TARGET="main" href="/SAP/sapAbout_aboutPage.dsp">About</a>
                                    %endif%
                                    %ifvar help%
                                        | <A target='adapter-body' onclick="launchHelp();return false;" href='#'>Help</A>
                                    %endif%
                               %else%

									%invoke wm.server.quiesce:getCurrentMode%
										 %ifvar isQuiesceMode equals('true')%
											<A  TARGET="main" href='quiesce-report.dsp' onclick="return switchToQuiesceMode(document.htmlform_toggle_mode,'%value isQuiesceMode%');"  id="Qlink">Exit Quiesce Mode</A>
										 %else%
											<A  TARGET="main" href='quiesce-report.dsp' onclick="return switchToQuiesceMode(document.htmlform_toggle_mode,'%value isQuiesceMode%');"  id="Qlink">Enter Quiesce Mode</A>
										 %endif%
									
									<script>displayMode('%value isQuiesceMode%');</script>
									%endinvoke%
									|

                                    <A target='main' href='server-shutdown.dsp%ifvar css%?css=%value css%%endif%'>
                                        Shut Down and Restart
                                    </A>
                                    |
                                    <A target='main' href='top-logoff.dsp?sessionid=%value sessionid%'
               onclick="return logIEout();" >Log Off</A>
               			    |
                                    <A target='main' href='server-environment.dsp'>About</A>
                                    |
                                    <A target='main' onclick="launchHelp();return false;" href='#'>Help</A>&nbsp;
				    
                                %endif%
				 %end%
                                 
				
                            </TD>-->
                        </TR>
    
                        <TR>
                        </TR>
                    </TABLE>
                </td>
            </tr>
        </table>
		<form name="htmlform_toggle_mode" action="quiesce-report.dsp" method="POST">
			<input type="hidden" name="isQuiesceMode">
			<input type="hidden" name="timeout">
			<input type="hidden" name="triggredAction" value="qAction">
		</form>
    </BODY>
</HTML>
