<tr name="%value section%_subMenu" style="display: %value display%">
  <td id="i%value encode(htmlattr) url%"
    %ifvar url equals('nonedsp')%
      class="menuitem-unclickable"
    %else%
      class="menuitem %value className%"
      onmouseover="menuMouseOver(this, '%value url encode(javascript)%');"
      onmouseout="menuMouseOut(this, '%value url encode(javascript)%');"
      onclick="menuSelect(this, '%value url encode(javascript)%'); document.all['a%value url encode(javascript)%'].click();"
    %endif%>
    <span style="white-space: nowrap">
      %ifvar url equals('dummy-horizontal-linedsp')%
        <hr/>
      %else%
        %ifvar url equals('nonedsp')%
          %value none text%
        %else%
          <a id="a%value encode(htmlattr) url%" 
             target="%ifvar target%%value $host%%value target%%else%body%endif%" 
             href="%value encode(htmlattr) url%">
            %value text% %ifvar target% ... %endif%
          </a>
        %endif%
      %endif%
    </span>
  </td>
</tr>
