package candi.es;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

public class EsDao {
	
	private static EsDao instance = null;
	
	private EsDao(){
	}
	
	public static EsDao getInstance() {
		if(instance == null){
			instance = new EsDao();
		}
		return instance;
	}
	
	public JSONObject getJson(String url){
		JSONObject json = null;
		
		try {
			URL esUrl = new URL(url);
	        HttpURLConnection conn = (HttpURLConnection) esUrl.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-length", "0");
	        conn.setUseCaches(false);
	        conn.setAllowUserInteraction(false);
	        conn.setConnectTimeout(10000);
	        conn.setReadTimeout(10000);
	        conn.connect();
	        int status = conn.getResponseCode();
            StringBuilder sb = new StringBuilder();
            
	        switch (status) {
	            case 200:
	            case 201:
	                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	                String line;
	                while ((line = br.readLine()) != null) {
	                    sb.append(line+"\n");
	                }
	                br.close();
	        }
			String jsonStr = sb.toString();
			if("".equals(jsonStr.trim())){
				// 메타가 없는 경우 집계할지 안할지 결정.
				json = new JSONObject();
			} else {
				json = new JSONObject(jsonStr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
}
