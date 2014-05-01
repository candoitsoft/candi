package candi.file;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import candi.com.CandiUserObj;
import jm.com.JmProperties;
import jm.net.Dao;
import jm.net.DataEntity;

public class UploadDao {

	private static UploadDao instance = null;
	private JmProperties property = null;
	
	private UploadDao(){
		property = new JmProperties("/data/conf/candi.property");
	}
	
	public static UploadDao getInstance() {
		if(instance == null){
			instance = new UploadDao();
		}
		return instance;
	}
	
	/**
	 * cdi_user_vals 테이블에 데이터 입력.
	 * @param id
	 * @param key
	 * @param value
	 * @param comment
	 * @return
	 */
	private int saveCdiVals(String id, String key, String value, String comment){
		int result = 0;
		
		DataEntity data = new DataEntity();
		Dao dao = Dao.getInstance();
		
		data.put("id", id);
		data.put("pkey", key);
		data.put("pvalue", value);
		data.put("pcomment", comment);
		
		result = dao.inertData(property, "cdi_user_vals", data);
		return result;
	}
	
	/**
	 * cdi_user_vals 테이블에 데이터 삭제.
	 * @param id
	 * @param key
	 * @return
	 */
	private int delCdiVals(String id, String key){
		int result = 0;
		
		DataEntity data = new DataEntity();
		Dao dao = Dao.getInstance();
		
		data.put("id", id);
		data.put("pkey", key);
		result = dao.deleteData(property, "cdi_user_vals", data);
		
		return result;
	}
	
	/**
	 * 추가된 필드 저장.
	 * @param req
	 * @return
	 */
	public int saveAddFields(HttpServletRequest req){
		int result = 0;
		
		HttpSession session = req.getSession();
		String candiId = (String) session.getAttribute("candiId");
		CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
		if (candiId == null || candiId.equals("") || userObj == null) {
		} else {
			String key = req.getParameter("upFileSrc");
			String value = req.getParameter("addFieldVals");
			
			//delete & insert
			delCdiVals(candiId, key);
			result = saveCdiVals(candiId, key, value, "");
		}
		
		return result;
	}
	
	public DataEntity[] getAddFields(HttpServletRequest req){
		DataEntity[] result = null;
		
		HttpSession session = req.getSession();
		String candiId = (String) session.getAttribute("candiId");
		CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
		if (candiId == null || candiId.equals("") || userObj == null) {
		} else {
			String upFileSrc = req.getParameter("upFileSrc");
			Dao dao = Dao.getInstance();
			StringBuffer sql = new StringBuffer();
			sql.append("select * \n");
			sql.append("from cdi_user_vals \n");
			sql.append("where \n");
			sql.append("id = ? \n");
			sql.append("and pkey = ? \n");
			String[] params = {candiId, upFileSrc};
			
			result = dao.getResult(property, sql.toString(), params);
		}
		
		return result;
	}
	
	
}
