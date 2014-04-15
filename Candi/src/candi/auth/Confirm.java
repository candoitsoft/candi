package candi.auth;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import candi.com.CandiDao;
import candi.com.CandiUserObj;

public class Confirm extends HttpServlet {
	
	private static final long serialVersionUID = 4784289161430396081L;

	public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		String cmd = req.getParameter("cmd");
		String toUrl = req.getParameter("toUrl");
		HttpSession session = req.getSession();
		
		CandiDao dao = new CandiDao(); 
		CandiUserObj obj = null;
		
		if(cmd != null && cmd.equals("insert")){
			
			obj = dao.getUserObj(req);
			int result = dao.insertUserObj(obj);
			
			if (result > 0) {
				session.setAttribute("candiId", obj.getId());
				session.setAttribute("candiUserObj", obj);
				
				res.sendRedirect(toUrl);
			} else {
				out.println("<script>");
				out.println("	alert(\"저장하는데 문제가 발생했습니다.\");");
				out.println("	history.go(-1);");
				out.println("</script>");
			}
		} else if(cmd != null && cmd.equals("update")){
			obj = (CandiUserObj) session.getAttribute("cdpObj");
			obj = dao.getUserObj(req, obj);
			int result = dao.updateUserObj(obj);
//			io.saveConfig(obj);
			
			if (result > 0) {
				session.setAttribute("candiId", obj.getId());
				session.setAttribute("candiUserObj", obj);
				
				res.sendRedirect(toUrl);
			} else {
				out.println("<script>");
				out.println("	alert(\"저장하는데 문제가 발생했습니다.\");");
				out.println("	history.go(-1);");
				out.println("</script>");
			}
		} else if(cmd != null && cmd.equals("login")){
			/*
			String id = req.getParameter("id");
			String pw = req.getParameter("pw");
			int check = dao.login(id, pw);
			
			if (check == 2) {
				obj = dao.getClAdminObj(id);
				session.setAttribute("candiId", obj.getId());
				session.setAttribute("candiUserObj", obj);
				res.sendRedirect(toUrl);
			} else if (check == 1) {
				out.println("<script>");
				out.println("	alert(\"비밀번호가 맞지 않습니다.\");");
				out.println("	history.go(-1);");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("	alert(\"없는 ID입니다. 다시 확인하고 로그인 하십시오.\");");
				out.println("	history.go(-1);");
				out.println("</script>");
			}
			*/
		} else {
			out.println("<script>");
			out.println("	alert(\"잘못된 접근입니다.\");");
			out.println("	history.go(-1);");
			out.println("</script>");
		}
		
	}
}
