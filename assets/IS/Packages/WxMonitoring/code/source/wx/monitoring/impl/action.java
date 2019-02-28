package wx.monitoring.impl;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.lang.ns.NSName;
import com.wm.app.b2b.server.BaseService;
import com.wm.app.b2b.server.ns.Namespace;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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




	public static final void getServiceInfo (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getServiceInfo)>> ---
		// @sigtype java 3.5
		// [i] field:0:required service
		// [o] field:0:required comment
		// [o] record:1:optional annotations
		// [o] - field:0:required key
		// [o] - field:0:required parameter
		IDataMap dm = new IDataMap(pipeline);
		String svcname = dm.getAsString("service");
		
		BaseService service = Namespace.getService(NSName.create(svcname));
		String comment = service.getComment();
		dm.put("comment", comment);
		
		Pattern pat = Pattern.compile("@([^\\(]+)\\(([^\\)]*)\\)");
		
		List<IData> params = new ArrayList<IData>();
		BufferedReader sink = new BufferedReader( new StringReader(comment) );
		String line = null;
		try {
			while ((line = sink.readLine()) != null) {
				// try to identify annotations
				Matcher mat = pat.matcher(line);
				if (mat.find()) {
					IDataMap tmp = new IDataMap("key",mat.group(1), "parameter", mat.group(2));
					params.add(tmp.getIData());
				}
			}
			sink.close();
		} catch (IOException e) {
			throw new ServiceException(e); 
		}
		
		if (params.size()>0) {
			IData[] atmp = new IData[params.size()];
			atmp = params.toArray(atmp);
			dm.put("annotations", atmp);
		}
			
		// --- <<IS-END>> ---

                
	}



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



	public static final void parseServiceName (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(parseServiceName)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required packageName
		// [o] field:0:required ns
		// [o] field:0:required folder
		// [o] field:0:required serviceName
		// [o] field:0:required genName
		IDataMap dm = new IDataMap(pipeline);
		String srvName = dm.getAsString("name");
		
		String[] tmp = srvName.split("/");
		dm.put("packageName", tmp.length>1 ? tmp[0] : null);
		dm.put("ns", tmp.length>1 ? tmp[1] : tmp[0]);
		tmp = srvName.split(":");
		dm.put("folder", tmp[0]);
		String ssn = tmp[1];
		dm.put("serviceName", ssn);
		
		if (ssn.startsWith("test"))
			ssn = ssn.substring(4);
		StringBuilder buf = new StringBuilder();
		char lastChar = 0;
		int wordLength = 0; 
		for (int i = 0; i < ssn.length(); i++) {
			char c = ssn.charAt(i);
			if (Character.isUpperCase(c)) {
				if (!Character.isUpperCase(lastChar) && wordLength>0) {
					buf.append(" ");
					wordLength = 0;
				}
			} else if (Character.isDigit(c)) { 
				if (!Character.isDigit(lastChar) && wordLength>0) {
					buf.append(" ");
					wordLength = 0;
				}
			} else { // is lower case
				if (Character.isUpperCase(lastChar) && wordLength>1) {
					buf.insert(buf.length()-1, " ");
				}
			} 
			if (c != '_') {
				buf.append(c);
				wordLength++;
			}
			lastChar = c;
		}
		dm.put("genName", buf.toString().trim());
			
		// --- <<IS-END>> ---

                
	}
}

