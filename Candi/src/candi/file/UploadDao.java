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
	
	
	public int saveAddFields(HttpServletRequest req){
		int result = 0;
		
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("candiId");
		CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
		if (id == null || id.equals("") || userObj == null) {
		} else {
			String key = req.getParameter("upFileSrc");
			String value = req.getParameter("addFieldVals");
			
			//delete & insert
			delCdiVals(id, key);
			result = saveCdiVals(id, key, value, "");
		}
		
		return result;
	}
}
