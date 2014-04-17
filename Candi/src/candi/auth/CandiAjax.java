package candi.auth;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import candi.com.CandiDao;

public class CandiAjax extends HttpServlet{
	
	private static final long serialVersionUID = -4496829789988209505L;

	/**
	 * Candi 에서 사용하는 Ajax.
	 */
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		CandiDao dao = new CandiDao();
		
		String cmd = req.getParameter("cmd");
		
		if(cmd != null){
			/**
			 * 중복 ID 체크.
			 */
			if(cmd.equals("checkId")){
				String id = req.getParameter("id");
				if(!dao.isExistId(id)){
					out.print("OK");
				} else {
					out.print("EXIST");
				}
			}
		}
		
	}
	
}
