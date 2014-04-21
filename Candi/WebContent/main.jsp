<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="candi.com.CandiUserObj, candi.com.CandiMsg"%>
<%

	//사용자 로그인 체크하는 로직. 모든 페이지에 반드시 포함할것.
	String id = (String) session.getAttribute("candiId");
	CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
	if (id == null || id.equals("") || userObj == null) {
		//로그인 오류시 login.jsp 페이지로 이동.
		out.print(CandiMsg.loginError());
	} else {
		
		if("osp".equals(userObj.getType())){
			response.sendRedirect("osp.jsp");
		} else if("org".equals(userObj.getType())){
			response.sendRedirect("org.jsp");
		} else if("gov".equals(userObj.getType())){
			response.sendRedirect("gov.jsp");
		}
%>

<%
	}
%>