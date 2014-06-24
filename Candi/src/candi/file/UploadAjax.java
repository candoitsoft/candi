package candi.file;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jm.net.DataEntity;

import org.json.JSONArray;
import org.json.JSONObject;

import candi.com.CandiMsg;
import candi.com.CandiUserObj;
import candi.es.EsDao;

public class UploadAjax extends HttpServlet{
	
	private static final long serialVersionUID = 8704055824927294678L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		res.setContentType("application/json; charset=UTF-8");
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		String candiId = (String) session.getAttribute("candiId");
		CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
		if (candiId == null || candiId.equals("") || userObj == null) {
			//로그인 오류시 login.jsp 페이지로 이동.
			out.write(CandiMsg.approachError());
		} else {
			UploadDao dao = UploadDao.getInstance();
			JSONObject resultJson = new JSONObject();	//리턴할 결과값을 담는 JSON
			
			try {
				String cmd = req.getParameter("cmd");
				System.out.println("cmd: "+cmd);
				if(cmd != null && "saveField".equals(cmd)){
					//추가된 필드 저장.
					int result = dao.saveAddFields(req);
					resultJson.put("result", result);
					
				} else if(cmd != null && "getInintField".equals(cmd)){
					//필드 불러오기
					DataEntity[] result = dao.getAddFields(req);
					
					JSONArray jsona = new JSONArray();
					if(result.length == 1){
						String valueStr = (String)result[0].get("pvalue");
						String[] vals = valueStr.split(",");
						for(String tvals : vals){
							jsona.put(tvals);
						}
					}
					resultJson.put("fieldVals", jsona);
					
				} else if(cmd != null && "getRunStatus".equals(cmd)){
					String uptype = req.getParameter("uptype");
					EsDao esDao = EsDao.getInstance();
					if("log".equals(uptype)){
						Thread.sleep(3000);
					} else {
						Thread.sleep(1000);
					}
					DataEntity[] upStatDatas = esDao.getStatus(candiId, uptype);
					if(upStatDatas != null){
						JSONArray jsona = new JSONArray();
						for(DataEntity upStatData : upStatDatas){
							JSONObject jsond = new JSONObject();
							jsond.put("filename", upStatData.get("filename"));
							jsond.put("cnt", upStatData.get("cnt"));
							jsond.put("stat", upStatData.get("stat"));
							jsond.put("totlines", upStatData.get("totlines"));
							jsond.put("percent", upStatData.get("percent"));
							jsona.put(jsond);
						}
						resultJson.put("runStats", jsona);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				System.out.println(resultJson.toString());
				out.write(resultJson.toString());
				out.close();	
			}
		}
	}
	
}
