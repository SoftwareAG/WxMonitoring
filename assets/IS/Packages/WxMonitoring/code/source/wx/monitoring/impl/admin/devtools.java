package wx.monitoring.impl.admin;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.BufferedReader;
import java.io.Reader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import com.softwareag.util.IDataMap;
import com.softwareag.util.IDataMap.IDataMapEntry;
// --- <<IS-END-IMPORTS>> ---

public final class devtools

{
	// ---( internal utility methods )---

	final static devtools _instance = new devtools();

	static devtools _newInstance() { return new devtools(); }

	static devtools _cast(Object o) { return (devtools)o; }

	// ---( server methods )---




	public static final void buildTemplate (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(buildTemplate)>> ---
		// @sigtype java 3.5
		// [i] object:0:required reader
		// [o] record:0:optional template
		// [o] - field:0:required name
		// [o] - field:0:optional method
		// [o] - field:0:optional index
		// [o] - field:0:optional requestBody
		IDataMap dm = new IDataMap(pipeline);
		try {
			IDataMap dm1 = new IDataMap();
			BufferedReader bufIn = new BufferedReader((Reader) dm.get("reader"));
			String line0 = bufIn.readLine();
			Matcher mat = Pattern.compile("^(\\S+)\\s+([^/]+)/?.+$").matcher(line0);
			if (mat.find()) {
				dm1.put("method", mat.group(1) ); //tokens[1]);
				dm1.put("index", mat.group(2));
			}
			
			String requestBody = org.apache.commons.io.IOUtils.toString(bufIn);
			dm1.put("requestBody", requestBody); 
			dm.put("template", dm1.getIData());
		
		} catch (Exception e) {
			throw new ServiceException(e);
		}
		
			
		// --- <<IS-END>> ---

                
	}
}

