package candi.es;

import candi.com.CandiParam;
import jm.com.JmProperties;
import jm.net.Dao;
import jm.net.DataEntity;

public class EsDao {
	
	private static EsDao instance = null;
	private JmProperties property = null;
	
	private EsDao(){
		property = new JmProperties(CandiParam.property);
	}
	
	public static EsDao getInstance() {
		if(instance == null){
			instance = new EsDao();
		}
		return instance;
	}
	
	/**
	 * 파일 업로드 상태 데이터 생성.
	 * @param id
	 * @param uptype
	 * @param filename
	 * @return
	 */
	public int createStatus(String id, String uptype, String filename, int totlines	){
		int result = 0;
		DataEntity data = new DataEntity();
		Dao dao = Dao.getInstance();
		
		data.put("id", id);
		data.put("uptype", uptype);
		data.put("filename", filename);
		data.put("totlines", totlines+"");
		result = dao.inertData(property, "cdi_index_temp", data);
		
		return result;
	}
	
	/**
	 * 파일 업로드 카운트 +1
	 * @param id
	 * @param uptype
	 * @param filename
	 * @return
	 */
	public int plusStatus(String id, String uptype, String filename){
		int result = 0;
		Dao dao = Dao.getInstance();
		
		StringBuffer sql = new StringBuffer();
		sql.append("update cdi_index_temp \n");
		sql.append("set cnt=(cnt+1) \n");
		sql.append("where id = ? \n");
		sql.append("and uptype = ? \n");
		sql.append("and filename = ? \n");
		String[] params = {id, uptype, filename};
		result = dao.updateSql(property, sql.toString(), params);
		
		return result;
	}
	
	/**
	 * 파일 업로드 카운트 삭제
	 * @param id
	 * @param uptype
	 * @param filename
	 * @return
	 */
	public int deleteStatus(String id, String uptype, String filename){
		int result = 0;
		DataEntity data = new DataEntity();
		Dao dao = Dao.getInstance();
		
		data.put("id", id);
		data.put("uptype", uptype);
		data.put("filename", filename);
		result = dao.deleteData(property, "cdi_index_temp", data);
		
		return result;
	}
	
	/**
	 * 파일 업로드 카운트와 상태값 가져오는 메서드.
	 * @return
	 */
	public DataEntity[] getStatus(String id, String uptype){
		DataEntity[] result = null;
		Dao dao = Dao.getInstance();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select filename, cnt, stat, totlines \n");
		sql.append("from cdi_index_temp \n");
		sql.append("where id = ? \n");
		sql.append("and uptype = ? \n");
		String[] params = {id, uptype};
		result = dao.getResult(property, sql.toString(), params);
		
		return result;
	}
	
	/**
	 * 파일 업로드 카운트값이 있는지 체크.
	 * @param id
	 * @param uptype
	 * @param filename
	 * @return
	 */
	public int isStatExist(String id, String uptype, String filename){
		int result = 0;
		Dao dao = Dao.getInstance();
		
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) cnt \n");
		sql.append("from cdi_index_temp \n");
		sql.append("where id = ? \n");
		sql.append("and uptype = ? \n");
		sql.append("and filename = ? \n");
		String[] params = {id, uptype, filename};
		result = dao.getCount(property, sql.toString(), params);
		
		return result;
	}
	
}
