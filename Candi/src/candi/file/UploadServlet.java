package candi.file;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jm.com.JmProperties;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONArray;
import org.json.JSONObject;

import candi.com.CandiMsg;
import candi.com.CandiUserObj;

public class UploadServlet extends HttpServlet {
	
	private static final long serialVersionUID = -3979331121443547693L;
	private File fileUploadPath;
	
	public void init(ServletConfig config) {
//		fileUploadPath = new File(config.getInitParameter("upload_path"));
		JmProperties property = new JmProperties("/data/conf/candi.property");
		fileUploadPath = new File(property.get("candiLogPath"));
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
		res.setContentType("text/html; charset=UTF-8");
		getFileList(req, res);
	}

	/**
	 * 업로드 한 파일 목록을 JSON 형식으로 리턴하는 내부 메서드.
	 * @param response
	 * @throws IOException
	 */
	private void getFileList(HttpServletRequest req, HttpServletResponse res) throws IOException{
		PrintWriter writer = res.getWriter();
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("candiId");
		CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
		if (id == null || id.equals("") || userObj == null) {
			//로그인 오류시 login.jsp 페이지로 이동.
			writer.write(CandiMsg.approachError());
		} else {
			File tempPath = new File( (fileUploadPath + "/").replaceAll("//","/") + id );
			
			File[] items = tempPath.listFiles();
			res.setContentType("application/json");
			JSONObject jsonf = new JSONObject();
			JSONArray json = new JSONArray();
			try {

				for (File item : items) {
					JSONObject jsono = new JSONObject();
					jsono.put("name", item.getName());
					jsono.put("size", item.length());
					jsono.put("deleteUrl", "upload?file=" + item.getName());
					jsono.put("deleteType", "DELETE");
					json.put(jsono);
				}
				jsonf.put("files", json);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				writer.write(jsonf.toString());
				writer.close();
			}
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 * 
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = res.getWriter();
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("candiId");
		CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
		if (id == null || id.equals("") || userObj == null) {
			//로그인 오류시 login.jsp 페이지로 이동.
			writer.write(CandiMsg.approachError());
		} else {
		
			if (!ServletFileUpload.isMultipartContent(req)) {
				throw new IllegalArgumentException(
						"Request is not multipart, please 'multipart/form-data' enctype for your form.");
			}

			// filePath/<id>/ 경로에 파일 업로드.
			File tempPath = new File( (fileUploadPath + "/").replaceAll("//","/") + id );
			if(!tempPath.exists()){
				tempPath.mkdirs(); 
			}
			ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
			res.setContentType("application/json");
			JSONObject jsonf = new JSONObject();
			JSONArray json = new JSONArray();
			try {
				List<FileItem> items = uploadHandler.parseRequest(req);
				for (FileItem item : items) {
					if (!item.isFormField()) {
						File file = new File(tempPath, item.getName());
						item.write(file);
						JSONObject jsono = new JSONObject();
						jsono.put("name", item.getName());
						jsono.put("size", item.getSize());
						jsono.put("deleteUrl", "upload?file=" + item.getName());
						jsono.put("deleteType", "DELETE");
						json.put(jsono);
					}
				}
				jsonf.put("files", json);
			} catch (FileUploadException e) {
				throw new RuntimeException(e);
			} catch (Exception e) {
				throw new RuntimeException(e);
			} finally {
				writer.write(jsonf.toString());
				writer.close();
			}
		}
		

	}
	
	public void doDelete(HttpServletRequest req, HttpServletResponse res) throws IOException{
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = res.getWriter();
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("candiId");
		CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
		if (id == null || id.equals("") || userObj == null) {
			//로그인 오류시 login.jsp 페이지로 이동.
			writer.write(CandiMsg.approachError());
		} else {
			String[] files_name = req.getParameterValues("file");
			File tempPath = new File( (fileUploadPath + "/").replaceAll("//","/") + id );
			for(String file_name : files_name){
				File   file      = new File( tempPath + "/" + file_name );
				if( file.exists() ) file.delete();
			}
			getFileList(req, res);
		}
		
	}
}