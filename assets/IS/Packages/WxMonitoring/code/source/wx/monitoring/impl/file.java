package wx.monitoring.impl;

// -----( IS Java Code Template v1.2

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.TimeZone;
import org.apache.commons.io.FileUtils;
import com.softwareag.util.IDataMap;
// --- <<IS-END-IMPORTS>> ---

public final class file

{
	// ---( internal utility methods )---

	final static file _instance = new file();

	static file _newInstance() { return new file(); }

	static file _cast(Object o) { return (file)o; }

	// ---( server methods )---




	public static final void closeFileReader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(closeFileReader)>> ---
		// @sigtype java 3.5
		// [i] object:0:optional fileReader
		IDataMap dm = new IDataMap(pipeline);
		try {
			FileReader bufIn1 = (FileReader) dm.get("fileReader");
			bufIn1.close();
		} catch (IOException e) {
			throw new ServiceException(e);
		}
			
		// --- <<IS-END>> ---

                
	}



	public static final void dropDirectory (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(dropDirectory)>> ---
		// @sigtype java 3.5
		// [i] field:0:required baseDir
		IDataMap dm = new IDataMap(pipeline);
		File baseDir = new File(dm.getAsString("baseDir"));
		 
		try {
			// make sure dir exists and is empty!
			FileUtils.forceMkdir(baseDir);
			FileUtils.cleanDirectory(baseDir);
			FileUtils.forceDelete(baseDir);
			FileUtils.deleteDirectory(baseDir);
		} catch (Exception e) {
			throw new ServiceException(e.toString());
		}
			
		// --- <<IS-END>> ---

                
	}



	public static final void listFiles (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(listFiles)>> ---
		// @sigtype java 3.5
		// [i] field:0:required directory
		// [o] field:1:required templates
		IDataMap dm = new IDataMap(pipeline);
		try {
			File dir = new File( dm.getAsString("directory", "."));
			if (dir.isDirectory()) {
				String[] list = dir.list(new FilenameFilter() {
					public boolean accept(File dir, String name) {
						return name.toLowerCase().contains("esq");
					}
				});
				dm.put("files", list);
			}
		} catch (Exception e) {
			throw new ServiceException(e);
		}
		// --- <<IS-END>> ---

                
	}



	public static final void openFileReader (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(openFileReader)>> ---
		// @sigtype java 3.5
		// [i] field:0:required filename
		// [o] object:0:required fileReader
		IDataMap dm = new IDataMap(pipeline);
		try {
			FileReader bufIn1 = new FileReader( dm.getAsString("filename") );
			dm.put("fileReader", bufIn1);
		} catch (IOException e) {
			throw new ServiceException(e);
		}
			
		// --- <<IS-END>> ---

                
	}



	public static final void unzipFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(unzipFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:optional filename
		// [i] object:0:optional stream
		// [i] field:0:required unzipToDir
		// [i] field:0:optional cleanDir
		// [o] field:0:required isInvalidZipFile
		IDataMap dm = new IDataMap(pipeline);
		String filename = dm.getAsString("filename");
		File destDir = new File(dm.getAsString("unzipToDir"));
		
		boolean isDeleteDirectory = Boolean.parseBoolean( dm.getAsString("cleanDir", "true") );
		InputStream is = (InputStream) dm.get("stream");
		
		// try to open zip file
		ZipInputStream zis = null;
		try {
			zis =  new ZipInputStream( is!= null ? is : new FileInputStream(filename));
		
			if (isDeleteDirectory) {
				// make sure dir exists and is empty!
				FileUtils.forceMkdir(destDir);
				FileUtils.cleanDirectory(destDir);
				FileUtils.forceDelete(destDir);
				FileUtils.deleteDirectory(destDir);
			}
		} catch (Exception e) {
			dm.put("isInvalidZip", true);
			dm.put("_error", e.toString());
			return;
		}
		
		// unzip all entries
		try {
			byte[] buffer = new byte[8192];
			ZipEntry zipEntry = zis.getNextEntry();
			while (zipEntry != null) {
			    File newFile = new File(destDir, zipEntry.getName());
			    
			    if (!zipEntry.isDirectory()) {
				    // make dir if needed
				    FileUtils.forceMkdir(newFile.getParentFile());
				    
				    // copy file to 
				    FileOutputStream fos = new FileOutputStream(newFile);
				    int len;
				    while ((len = zis.read(buffer)) > 0) {
				        fos.write(buffer, 0, len);
				    }
				    fos.close();
			    }
			    zipEntry = zis.getNextEntry();
			}
			zis.closeEntry();
			zis.close();
		} catch (Exception e) {
			throw new ServiceException(e.toString());
		} 
		
		dm.put("isInvalidZip", false);
			
		// --- <<IS-END>> ---

                
	}



	public static final void writeFile (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(writeFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required filename
		// [i] object:0:required stream
		// [i] field:0:optional forceDir {"true","false"}
		IDataMap dm = new IDataMap(pipeline);
		String filename = dm.getAsString("filename");
		boolean isForceDirectory = Boolean.parseBoolean( dm.getAsString("forceDir", "false") );
		InputStream is = (InputStream) dm.get("stream");
		try {
			File f1 = new File(filename);
			if (isForceDirectory)
				FileUtils.forceMkdir(f1);
			FileUtils.copyInputStreamToFile(is, f1);
		} catch (Exception e) {
			throw new ServiceException(e.toString());
		}
			
		// --- <<IS-END>> ---

                
	}
}

