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

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONArray;
import org.json.JSONObject;

public class UploadServlet extends HttpServlet {
	
	private static final long serialVersionUID = -3979331121443547693L;
	private File fileUploadPath;
	
	public void init(ServletConfig config) {
		fileUploadPath = new File(config.getInitParameter("upload_path"));
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		getFileList(response);
		
	}

	/**
	 * 업로드 한 파일 목록을 JSON 형식으로 리턴하는 내부 메서드.
	 * @param response
	 * @throws IOException
	 */
	private void getFileList(HttpServletResponse response) throws IOException{
		PrintWriter writer = response.getWriter();
		File[] items = fileUploadPath.listFiles();
		response.setContentType("application/json");
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
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 * 
	 */
	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		if (!ServletFileUpload.isMultipartContent(request)) {
			throw new IllegalArgumentException(
					"Request is not multipart, please 'multipart/form-data' enctype for your form.");
		}

		ServletFileUpload uploadHandler = new ServletFileUpload(
				new DiskFileItemFactory());
		PrintWriter writer = response.getWriter();
		response.setContentType("application/json");
		JSONObject jsonf = new JSONObject();
		JSONArray json = new JSONArray();
		try {
			List<FileItem> items = uploadHandler.parseRequest(request);
			for (FileItem item : items) {
				if (!item.isFormField()) {
					File file = new File(fileUploadPath, item.getName());
					item.write(file);
					JSONObject jsono = new JSONObject();
					jsono.put("name", item.getName());
					jsono.put("size", item.getSize());
					jsono.put("deleteUrl", "upload?delfile=" + item.getName());
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
	
	public void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException{
		System.out.println("doDelete");
		
		String file_name = request.getParameter("file");
		File   file      = new File( fileUploadPath +"/"+ file_name );
		if( file.exists() ) file.delete();
		
		getFileList(response);
	}
}