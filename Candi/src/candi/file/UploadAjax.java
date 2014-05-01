package candi.file;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

public class UploadAjax extends HttpServlet{
	
	private static final long serialVersionUID = 8704055824927294678L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		
		PrintWriter out = res.getWriter();
		res.setContentType("application/json; charset=UTF-8");
		
		UploadDao dao = UploadDao.getInstance();
		int result = dao.saveAddFields(req);
		
		JSONObject json = new JSONObject();
		
		try {
			json.put("result", result);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		out.write(json.toString());
		out.close();
	}
	
}
