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
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.TimeZone;
import org.apache.commons.io.FileUtils;
import com.softwareag.util.IDataMap;
// --- <<IS-END-IMPORTS>> ---

public final class util

{
	// ---( internal utility methods )---

	final static util _instance = new util();

	static util _newInstance() { return new util(); }

	static util _cast(Object o) { return (util)o; }

	// ---( server methods )---




	public static final void calculateDateDifference (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(calculateDateDifference)>> ---
		// @sigtype java 3.5
		// [i] field:0:required startDate
		// [i] field:0:required startDateFormat
		// [i] field:0:required endDate
		// [i] field:0:required endDateFormat
		// [o] field:0:required diffInDays
		// [o] field:0:required diffInHours
		// [o] field:0:required diffInMinutes
		// [o] field:0:required diffInSeconds
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	startDate = IDataUtil.getString( pipelineCursor, "startDate" );
		String	startDateFormat = IDataUtil.getString( pipelineCursor, "startDateFormat" );
		String	endDate = IDataUtil.getString( pipelineCursor, "endDate" );
		String	endDateFormat = IDataUtil.getString( pipelineCursor, "endDateFormat" );
		pipelineCursor.destroy();
		
		SimpleDateFormat startDateformat = new SimpleDateFormat( startDateFormat );  
		startDateformat.setLenient(false);  
		Date dtStartDate = null;  
		
		SimpleDateFormat endDateformat = new SimpleDateFormat( endDateFormat );  
		endDateformat.setLenient(false);  
		Date dtEndDate = null;
		
		String diffInDays, diffInHours, diffInMinutes, diffInSeconds;
		
		try  
		{  
			dtStartDate = startDateformat.parse(startDate );
			dtEndDate = endDateformat.parse(endDate ); 
			
			long diffInMillies = dtEndDate.getTime() - dtStartDate.getTime();
			diffInDays =  Long.toString(TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS));
			diffInHours = Long.toString(TimeUnit.HOURS.convert(diffInMillies, TimeUnit.MILLISECONDS));
			diffInMinutes = Long.toString(TimeUnit.MINUTES.convert(diffInMillies, TimeUnit.MILLISECONDS));
			diffInSeconds = Long.toString(TimeUnit.SECONDS.convert(diffInMillies, TimeUnit.MILLISECONDS));
			
		    //timeUnit.convert(diffInMillies,TimeUnit.MILLISECONDS);
		}  
		catch( Throwable t )  
		{   
		    throw new ServiceException(t);  
		} 
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "diffInDays", diffInDays );
		IDataUtil.put( pipelineCursor_1, "diffInHours", diffInHours );
		IDataUtil.put( pipelineCursor_1, "diffInMinutes", diffInMinutes );
		IDataUtil.put( pipelineCursor_1, "diffInSeconds", diffInSeconds );
		pipelineCursor_1.destroy();
		
			
		// --- <<IS-END>> ---

                
	}



	public static final void createRandomInt (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createRandomInt)>> ---
		// @sigtype java 3.5
		// [i] field:0:required greaterThanOrEqualTo
		// [i] field:0:required lessThanOrEqualTo
		// [o] field:0:required randomNumber
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	greaterThanOrEqualTo = IDataUtil.getString( pipelineCursor, "greaterThanOrEqualTo" );
			String	lessThanOrEqualTo = IDataUtil.getString( pipelineCursor, "lessThanOrEqualTo" );
		pipelineCursor.destroy();
		
		int min = 0;
		int max = 0;
		
		if(greaterThanOrEqualTo!=null) {
			
			min = Integer.parseInt(greaterThanOrEqualTo);
		} else {
			min = Integer.MIN_VALUE;
		}
		
		if(lessThanOrEqualTo!=null) {
			
			max = Integer.parseInt(lessThanOrEqualTo);
		} else {
			max = Integer.MAX_VALUE;
		}
		
		if(min<max){
			int temp = min;
			min = max;
			max = temp;
		}
		int randomNumber =  min + (int)(Math.random() * ((max - min) + 1));
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "randomNumber", String.valueOf(randomNumber) );
		pipelineCursor_1.destroy();
		
			
		// --- <<IS-END>> ---

                
	}



	public static final void dateTimeFormat (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dateTimeFormat)>> ---
		// @sigtype java 3.5
		// [i] field:0:required inString
		// [i] field:0:required currentPattern
		// [i] field:0:required currentTimezone
		// [i] field:0:required newPattern
		// [i] field:0:required newTimezone
		// [o] field:0:required value
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	inString = IDataUtil.getString( pipelineCursor, "inString" );
			String	currentPattern = IDataUtil.getString( pipelineCursor, "currentPattern" );
			String	currentTimezone = IDataUtil.getString( pipelineCursor, "currentTimezone" );
			String	newPattern = IDataUtil.getString( pipelineCursor, "newPattern" );
			String	newTimezone = IDataUtil.getString( pipelineCursor, "newTimezone" );
		pipelineCursor.destroy();
		 
		SimpleDateFormat format = new SimpleDateFormat( currentPattern ); 
		
		try  
		{ 
			format.setTimeZone(TimeZone.getTimeZone(currentTimezone));
			
		}  
		catch( Throwable t )  
		{  
			format.setTimeZone(TimeZone.getDefault());
			
		} 
		
		format.setLenient(false);  
		Date currentDate;  
		try  
		{  
		    currentDate = format.parse(inString ); 
		}  
		catch( Throwable t )  
		{    
		    throw new ServiceException(t);  
		}  
		format = new SimpleDateFormat(newPattern);  
		try  
		{  
			format.setTimeZone(TimeZone.getTimeZone(newTimezone));
		}  
		catch( Throwable t )  
		{  
			format.setTimeZone(TimeZone.getDefault());
		} 
		
		String value = format.format(currentDate); 
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "value", value );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void filterServices (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(filterServices)>> ---
		// @sigtype java 3.5
		// [i] field:0:optional filter
		// [i] field:1:required names
		// [o] field:1:required names
		IDataMap dm = new IDataMap(pipeline);
		
		String filter = dm.getAsString("filter");
		if (filter == null || filter.length() == 0)
			return;
		String[] f = filter.split(",");
		String[] namesIn = dm.getAsStringArray("names"); 
		
		List<String> list1 = new ArrayList<String>();
		for (int i = 0; i < namesIn.length;i++) {
			boolean hit = false;
			for (int j = 0; !hit && j < f.length; j++)
				hit = namesIn[i].startsWith(f[j]);
					
			if (hit) 
				list1.add(namesIn[i]);
		}
		IData[] tmp = new IData[list1.size()];
		tmp = list1.toArray(tmp);
		dm.put("names", tmp);
			
		// --- <<IS-END>> ---

                
	}



	public static final void getServiceComment (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getServiceComment)>> ---
		// @sigtype java 3.5
		// [i] field:0:required service
		// [o] field:0:required comment
		IDataMap dm = new IDataMap(pipeline);
		String svcname = dm.getAsString("service");
		 
		BaseService service = Namespace.getService(NSName.create(svcname));
		dm.put("comment", service.getComment());
			
		// --- <<IS-END>> ---

                
	}



	public static final void longToDate (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(longToDate)>> ---
		// @sigtype java 3.5
		// [i] field:0:required timeAsLong
		// [o] field:0:required dateString
		IDataMap dm = new IDataMap(pipeline);
		// just a one liner
		dm.put("dateString", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format( new Date(Long.parseLong(dm.getAsString("timeAsLong")))));
			
		// --- <<IS-END>> ---

                
	}



	public static final void matchStrings (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(matchStrings)>> ---
		// @sigtype java 3.5
		// [i] field:0:required parentString
		// [i] field:0:required substring
		// [i] field:0:required useRegex {"true","false"}
		// [o] field:0:required matches {"true","false"}
		
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	parentString = IDataUtil.getString( pipelineCursor, "parentString" );
			String	substring = IDataUtil.getString( pipelineCursor, "substring" );
			String	useRegex = IDataUtil.getString( pipelineCursor, "useRegex" );
		pipelineCursor.destroy();
		boolean matches = false;
		if(useRegex=="true"){
			matches = parentString.matches(substring);
		}else{
			matches = parentString.matches("(.*)"+substring+"(.*)");
		}
		
		
		// pipeline
		IDataCursor pipelineCursor_1 = pipeline.getCursor();
		IDataUtil.put( pipelineCursor_1, "matches", String.valueOf(matches) );
		pipelineCursor_1.destroy();
		// --- <<IS-END>> ---

                
	}
}

