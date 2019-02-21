package test.wx.monitoring.services;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.lang.ns.NSService;
import com.softwareag.util.IDataMap;
// --- <<IS-END-IMPORTS>> ---

public final class misc

{
	// ---( internal utility methods )---

	final static misc _instance = new misc();

	static misc _newInstance() { return new misc(); }

	static misc _cast(Object o) { return (misc)o; }

	// ---( server methods )---




	public static final void getServiceComment (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getServiceComment)>> ---
		// @sigtype java 3.5
		// [i] field:0:required serviceName
		// [o] field:0:required comment
		IDataMap dm = new IDataMap(pipeline);
		String tmp = dm.getAsString("serviceName");
		// todo some magic ...
		String comment = "@actionType(jira)";
		
		// output pipeline
		dm.put("comment", comment);
			
		// --- <<IS-END>> ---

                
	}
}

