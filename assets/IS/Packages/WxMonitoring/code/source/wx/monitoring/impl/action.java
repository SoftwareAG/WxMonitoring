package wx.monitoring.impl;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import com.softwareag.util.IDataMap;
// --- <<IS-END-IMPORTS>> ---

public final class action

{
	// ---( internal utility methods )---

	final static action _instance = new action();

	static action _newInstance() { return new action(); }

	static action _cast(Object o) { return (action)o; }

	// ---( server methods )---




	public static final void parseAnnotations (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(parseAnnotations)>> ---
		// @sigtype java 3.5
		// [i] field:0:required string
		// [o] record:1:required annotations
		// [o] - field:0:required name
		// [o] - field:0:required parameter
		IDataMap dm = new IDataMap(pipeline);
		String tmp = dm.getAsString("string");
		BufferedReader buf = new BufferedReader(new StringReader(tmp));
		List<IData> list1 = new ArrayList<IData>();
		try {
			while(buf.read() >= 0){
				String line = buf.readLine().trim();
				Pattern pat = Pattern.compile("^@(.*)\\((.*)\\)$");
				Matcher mat = pat.matcher(line);
				if (mat.find()) {
					IDataMap dm1 = new IDataMap();
					dm1.put("name", mat.group(1));
					dm1.put("parameter", mat.group(2));
					list1.add(dm1.getIData());
				}
			}
		} catch (IOException e) {
			throw new ServiceException(e);
		}
		// --- <<IS-END>> ---

                
	}
}

