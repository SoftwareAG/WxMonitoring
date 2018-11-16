<tr manualhide="%ifvar expanded equals('true')%false%else%true%endif%" 
    onClick="toggle(this, '%value text%_subMenu', '%value text%_twistie');" 
    onMouseOver="this.className='cursor';"/>
  <td class="menusection menusection-%ifvar expanded equals('true')%expanded%else%collapsed%endif%" 
      id="elmt_%value text%_subMenu"/>
    <img id='%value text%_twistie' 
         src="images/%ifvar expanded equals('true')%expanded.gif%else%collapsed_blue.png%endif%" />
      &nbsp;%value text%
  </td>
</tr>
