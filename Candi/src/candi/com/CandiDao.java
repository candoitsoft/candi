package candi.com;

import javax.servlet.http.HttpServletRequest;

import jm.net.Dao;
import jm.net.DataEntity;

public class CandiDao {

	/**
	 *  request 로 부터 CandiUserObj 객체를 생성하는 메서드.
	 * @param req
	 * @return
	 */
	public CandiUserObj getUserObj(HttpServletRequest req){
		return getUserObj(req, new CandiUserObj());
	}
	
	/**
	 * request 로 부터 CandiUserObj 객체를 생성하는 메서드.
	 * @param req
	 * @param obj
	 * @return
	 */
	public CandiUserObj getUserObj(HttpServletRequest req, CandiUserObj obj){
		
		if(req.getParameter("id") != null)
			obj.setId(req.getParameter("id").trim());
		if(req.getParameter("passwd") != null)
			obj.setPasswd(req.getParameter("passwd"));
		if(req.getParameter("name") != null)
			obj.setName(req.getParameter("name"));
		
		return obj;
	}
	
	/**
	 * CandiUserObj 객체를 DB에 저장.
	 * @param userObj
	 * @return
	 */
	public int insertUserObj(CandiUserObj userObj){
		int result = 0;
		
		Dao dao = Dao.getInstance();
		DataEntity data = new DataEntity();
		
		data.put("id", userObj.getId());
		data.put("passwd", userObj.getPasswd());
		data.put("name", userObj.getName());
		
		result = dao.inertRemoteData("cdi_user", data);
		
		return result;
	}
	
	/**
	 * CandiUserObj 객체를 DB에 업데이트.
	 * @param userObj
	 * @return
	 */
	public int updateUserObj(CandiUserObj userObj){
		int result = 0;


		Dao dao = Dao.getInstance();
		DataEntity setData = new DataEntity();
		DataEntity whereData = new DataEntity();
		
		setData.put("passwd", userObj.getPasswd());
		setData.put("name", userObj.getName());
		
		whereData.put("id", userObj.getId());
		
		result = dao.updateRemoteData("cdi_user", setData, whereData);
		
		return result;
	}
}
