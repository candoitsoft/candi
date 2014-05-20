package candi.es;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jm.com.JmProperties;
import candi.com.CandiMsg;
import candi.com.CandiParam;
import candi.com.CandiUserObj;

public class ConfigJS extends HttpServlet {
	
	private static final long serialVersionUID = 4842624061916144084L;
	
	public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		String candiId = (String) session.getAttribute("candiId");
		CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
		
		if (candiId == null || candiId.equals("") || userObj == null) {
			//로그인 오류시 login.jsp 페이지로 이동.
			out.write(CandiMsg.approachError());
		} else {
			JmProperties property = new JmProperties(CandiParam.property);
			String kibanaEs = property.get("kibanaEs");
			StringBuffer outStr = new StringBuffer();
			
			outStr.append("define(['settings'],");
			outStr.append("function (Settings) {");
			outStr.append("	'use strict';");
			outStr.append("	return new Settings({");
			outStr.append("	elasticsearch: '"+kibanaEs+"',");
			outStr.append("	default_route     : '/dashboard/file/default.json',");
			outStr.append("	kibana_index: 'candi-osp',");
			outStr.append("	panel_names: [");
			outStr.append("		'histogram',");
			outStr.append("		'map',");
			outStr.append("		'pie',");
			outStr.append("		'table',");
			outStr.append("		'filtering',");
			outStr.append("		'timepicker',");
			outStr.append("		'text',");
			outStr.append("		'hits',");
			outStr.append("		'column',");
			outStr.append("		'trends',");
			outStr.append("		'bettermap',");
			outStr.append("		'query',");
			outStr.append("		'terms',");
			outStr.append("		'stats',");
			outStr.append("		'sparklines'");
			outStr.append("		]");
			outStr.append("	});");
			outStr.append("});");
			
			out.print(outStr.toString());
		}
	}
}
