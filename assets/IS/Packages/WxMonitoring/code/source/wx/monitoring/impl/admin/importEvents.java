package wx.monitoring.impl.admin;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.file.FileSystem;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Stack;
import com.softwareag.util.IDataMap;
// --- <<IS-END-IMPORTS>> ---

public final class importEvents

{
	// ---( internal utility methods )---

	final static importEvents _instance = new importEvents();

	static importEvents _newInstance() { return new importEvents(); }

	static importEvents _cast(Object o) { return (importEvents)o; }

	// ---( server methods )---




	public static final void lookupLogDir (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(lookupLogDir)>> ---
		// @sigtype java 3.5
		// [i] field:0:required baseDir
		// [i] field:0:required deepSearch {"false","true"}
		// [o] record:1:required logFiles
		// [o] - field:0:required env
		// [o] - field:0:required log_identifier
		// [o] - field:0:required source
		// [o] - record:1:required files
		// [o] -- field:0:required filename
		// [o] -- field:0:required noLines
		IDataMap dm = new IDataMap(pipeline);
		String baseDir = dm.getAsString("baseDir");
		boolean deepSearch = Boolean.parseBoolean( dm.getAsString("deepSearch", "true") );
		
		try {
			File f1 = new File(baseDir);
			File[] listFiles = f1.listFiles();
			List<IData> logFiles = new ArrayList<IData>();
			for (int i = 0; i < listFiles.length; i++) {
				String name = listFiles[i].getName();
				
				if (listFiles[i].isDirectory()) {
					List<File> scanDirs = new ArrayList<File>();
					scanDirs.add(new File(f1, name));
					while (!scanDirs.isEmpty()) {
						File curDir = scanDirs.remove(0);
						if (deepSearch) {
							// queue all subdirectories 
							File[] fd = curDir.listFiles(new FilenameFilter() {
								@Override
								public boolean accept(File dir, String name) {
									return (new File(dir, name).isDirectory());
								}
							});
							scanDirs.addAll(Arrays.asList(fd));
						}
		
						// scan recursive
						File[] f2 = curDir.listFiles(new FilenameFilter() {
							@Override
							public boolean accept(File dir, String name) {
								return (name.startsWith("server.log"));
							}
						});
						
						if (f2 != null && f2.length > 0) {
							IDataMap dm1 = new IDataMap();
							dm1.put("env", name);
							dm1.put("log_identifier", "server_log");
							dm1.put("source", "\\IS\\server.log");
							IData[] da1 = new IData[f2.length];
							for (int j = 0; j < f2.length; j++) {
								IDataMap dm2 = new IDataMap();
								dm2.put("filename", f2[j].getCanonicalPath());
								da1[j] = dm2.getIData();
							}
							dm1.put("files", da1);
							logFiles.add(dm1.getIData());
						}
		
				//			} else if (listFiles[i].isFile()) {
				//				dm1.put("type", "file");
					}
						
					}
				
			}
			
			//
			IData[] out = new IData[logFiles.size()];
			out = logFiles.toArray(out);
			dm.put("logFiles", out);		
		
		} catch (IOException e) {
			throw new ServiceException(e.toString());
		}
			
		// --- <<IS-END>> ---

                
	}



	public static final void readMsgFromLog (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(readMsgFromLog)>> ---
		// @sigtype java 3.5
		// [i] object:0:optional fileReader
		// [i] object:0:optional bufReader
		// [i] field:0:optional nextLine
		// [i] field:0:optional noLines
		// [o] object:0:optional bufReader
		// [o] field:0:required isEOF {"false","true"}
		// [o] field:0:required messageML
		// [o] field:0:optional nextLine
		// [o] field:0:optional noLines
		IDataMap dm = new IDataMap(pipeline);
		try {
			BufferedReader bufIn1 = null;
			if (!dm.containsKey("bufReader")) {
				// make buffered reader at first time
				bufIn1 = new BufferedReader( (FileReader) dm.get("fileReader"));
				dm.put("bufReader", bufIn1);
			} else {
				bufIn1 = (BufferedReader) dm.get("bufReader");
			}
		
			boolean isEOF = false;
			int noLines = Integer.parseInt( dm.getAsString("noLines", "0"));
			String nextLine = dm.getAsString("nextLine");
			StringBuilder buf = new StringBuilder();
			boolean repeat = true;
		
			while (repeat) {
				// read next line
				String line = bufIn1.readLine();
				if (line == null) {
					// EOF
					if (nextLine == null){
						isEOF = true;
					} else {
						if (buf.length()>0) buf.append("\r\n");
						buf.append(nextLine);
						nextLine = null;
						noLines++;
					}
					repeat = false;
				} else {
					if (nextLine == null) {
						nextLine = line;
						continue;
					} else {
						if (buf.length()>0) buf.append("\r\n");
						buf.append(nextLine);
						nextLine = line;
						if (line.length() > 0 && Character.isDigit(line.charAt(0))) {
							// next line: 201x-xx-xxx ...
							repeat = false;
							noLines++;
						}
						continue;
					}
				}			
			}
		
			// store values
			dm.put("noLines", ""+noLines);
			dm.put("nextLine", nextLine);
			dm.put("messageML", buf.toString());
			dm.put("isEOF", Boolean.toString(isEOF));
		
		} catch (IOException e) {
			throw new ServiceException(e);
		}
			
		// --- <<IS-END>> ---

                
	}
}

