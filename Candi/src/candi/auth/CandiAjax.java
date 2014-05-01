package candi.auth;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import candi.com.CandiDao;
import candi.com.CandiMsg;
import candi.com.CandiUserObj;

public class CandiAjax extends HttpServlet{
	
	private static final long serialVersionUID = -4496829789988209505L;

	/**
	 * Candi 에서 사용하는 Ajax.
	 */
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
		res.setContentType("application/json; charset=UTF-8");
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		String candiId = (String) session.getAttribute("candiId");
		CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
		if (candiId == null || candiId.equals("") || userObj == null) {
			//로그인 오류시 login.jsp 페이지로 이동.
			out.write(CandiMsg.approachError());
		} else {
			CandiDao dao = CandiDao.getInstance();
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
	
}
