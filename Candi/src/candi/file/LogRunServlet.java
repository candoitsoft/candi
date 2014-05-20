package candi.file;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jm.com.JmProperties;

import org.json.JSONObject;

import candi.com.CandiMsg;
import candi.com.CandiParam;
import candi.com.CandiUserObj;
import candi.es.EsConnIO;
import candi.es.IndexIO;

public class LogRunServlet extends HttpServlet {
	
	private static final long serialVersionUID = -4196140532427639819L;
	private JmProperties property = null;
	private File fileUploadPath;
	
	public void init(ServletConfig config) {
		property = new JmProperties(CandiParam.property);
		fileUploadPath = new File(property.get("candiUpLogPath"));
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
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
			JSONObject resultJson = new JSONObject();
			try {
				String tempPath = (fileUploadPath + "/").replaceAll("//","/") + candiId;
				File tempFile = new File (tempPath);
				
				EsConnIO esConn = new EsConnIO();
				esConn.setInterval(candiId, "5s");	//대시보드 화면 리프레시 5초로 셋팅.
				
				if(tempFile.exists()){
					String[] runFiles = tempFile.list();
					IndexIO iio = IndexIO.getInstance();
					
					for(String runFileName : runFiles){
						String[] fnToken = runFileName.split("\\.");
						String ext = "";
						if(fnToken.length > 1){
							ext = fnToken[fnToken.length-1];
						}
						
						if("csv".equals(ext) || "CSV".equals(ext)){
							iio.saveLogCsv(tempPath, runFileName, candiId, userObj.getName());
							
						} else if("json".equals(ext) || "JSON".equals(ext)){
							
						} else if("xml".equals(ext) || "XML".equals(ext)){
							
						} else if("xls".equals(ext) || "XLS".equals(ext)){
							
						} else if("zip".equals(ext) || "ZIP".equals(ext)){
							
						} 
					}
				}
				esConn.setInterval(candiId, "false");	//대시보드 화면 리프레시 해제.
				out.print(resultJson.toString());
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
	}
	
}