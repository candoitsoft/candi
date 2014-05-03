package candi.file;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jm.com.JmProperties;

import org.json.JSONArray;
import org.json.JSONObject;

import candi.com.CandiMsg;
import candi.com.CandiUserObj;

public class MetaRunServlet extends HttpServlet {
	
	private static final long serialVersionUID = -4196140532427639819L;
	private File fileUploadPath;
	
	public void init(ServletConfig config) {
//		fileUploadPath = new File(config.getInitParameter("upload_path"));
		JmProperties property = new JmProperties("/data/conf/candi.property");
		fileUploadPath = new File(property.get("candiMetaPath"));
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		System.out.println("1");
	}
	
	/**
	 * 
	 */
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		String candiId = (String) session.getAttribute("candiId");
		CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
		if (candiId == null || candiId.equals("") || userObj == null) {
			//로그인 오류시 login.jsp 페이지로 이동.
			res.setContentType("text/html; charset=UTF-8");
			out.write(CandiMsg.approachError());
		} else {
			res.setContentType("application/json");
			System.out.println("==> 1");
			try {
				String tempPath = (fileUploadPath + "/").replaceAll("//","/") + candiId;
				File tempFile = new File (tempPath);
				System.out.println("tempPath ==> " + tempFile);
				if(tempFile.exists()){
					String[] runFiles = tempFile.list();
					for(String runFileName : runFiles){
						System.out.println("runFileName ==> " + runFileName);
						File runFile = new File(tempPath + "/" + runFileName);
						FileReader fr = new FileReader(runFile);
						BufferedReader br = new BufferedReader(fr);
						String rLine = null;
						
						String[] fnToken = runFileName.split("\\.");
						String ext = "";
						System.out.println("fnToken.length ==> " + fnToken.length);
						if(fnToken.length > 1){
							ext = fnToken[fnToken.length-1];
						}
						System.out.println("ext ==> " + ext);
						
						if("csv".equals(ext) || "CSV".equals(ext)){
							while((rLine = br.readLine())!=null){
								System.out.println("rLine ==> " + rLine);
								
								String[] items = rLine.split(",");
								if(items.length > 7){
									JSONObject json = new JSONObject();
									
									json.put("cid", items[1].replaceAll("\\\"", ""));
									json.put("title", items[2].replaceAll("\\\"", ""));
									json.put("album", items[3].replaceAll("\\\"", ""));
									
									String[] artists = items[4].replaceAll("\\\"", "").split(",");
									JSONArray jsona = new JSONArray();
									for(String artist : artists){
										jsona.put(artist);
									}
									json.put("artist", jsona);
									
									json.put("genre", items[5].replaceAll("\\\"", ""));
									json.put("rdate", items[6].replaceAll("\\\"", ""));
									json.put("ptime", items[7].replaceAll("\\\"", ""));
									
									System.out.println(json.toString());
								}
							}
						} else if("json".equals(ext) || "JSON".equals(ext)){
							
						} else if("xml".equals(ext) || "XML".equals(ext)){
							
						} else if("xls".equals(ext) || "XLS".equals(ext)){
							
						} else if("zip".equals(ext) || "ZIP".equals(ext)){
							
						} 
						
						br.close();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
	}
	
}