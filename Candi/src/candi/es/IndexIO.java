package candi.es;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.json.JSONArray;
import org.json.JSONObject;

import candi.com.CandiParam;
import jm.com.JmProperties;

public class IndexIO {

	private static IndexIO instance = null;
	private JmProperties property = null;
	private File indexPath;
	private String metaIndex = "meta_music"; 
	
	private IndexIO(){
		property = new JmProperties(CandiParam.property);
		indexPath = new File(property.get("candiIndexPath"));
	}
	
	public static IndexIO getInstance() {
		if(instance == null){
			instance = new IndexIO();
		}
		return instance;
	}
	
	/**
	 * 메타 csv 파일을 json 형식의 로그 파일로 만들어서 저장.
	 * @param runFile
	 * @param candiId
	 */
	public void saveMetaCsv(String metaPath, String runFileName, String candiId){
		FileReader fr = null;
		BufferedReader br = null;
		FileWriter fw = null;
		BufferedWriter bw = null;
		try {
			fr = new FileReader(metaPath + "/" + runFileName);
			br = new BufferedReader(fr);
			
			if(!indexPath.exists()){ indexPath.mkdirs(); }
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA);
			fw = new FileWriter(indexPath+"/"+formatter.format(new Date())+"_"+candiId+"_"+runFileName+".log");
			bw = new BufferedWriter(fw);
			
			String rLine = null;
			while((rLine = br.readLine())!=null){
				rLine = rLine.replaceAll(",,", ",\"\",");
				String[] items = rLine.split("\",\"");
				if(items.length > 7){
					JSONObject json = new JSONObject();
					
					json.put("uci", items[0].replaceAll("\\\"", ""));
					
					String cid = items[1].replaceAll("\\\"", "");
					json.put("cid", cid);
					json.put("title", items[2].replaceAll("\\\"", ""));
					json.put("album", items[3].replaceAll("\\\"", ""));
					
					String[] artists = items[4].replaceAll("\\\"", "").split(",");
					JSONArray jsona = new JSONArray();
					for(String artist : artists){
						jsona.put(artist);
					}
					json.put("artist", jsona);
					
					json.put("genre", items[5].replaceAll("\\\"", ""));
					json.put("rdate", items[6].replaceAll("\\\"", ""));
					json.put("ptime", items[7].replaceAll("\\\"", ""));
					
					json.put("es_index", metaIndex);
					json.put("es_type", candiId);
					json.put("es_id", cid);
					
				    bw.write(json.toString());
				    bw.newLine();
				    
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				br.close();
				bw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 로그 csv 파일을 json 형식의 로그 파일로 만들어서 저장.
	 * @param runFile
	 * @param candiId
	 */
	public void saveLogCsv(String metaPath, String runFileName, String candiId){
		FileReader fr = null;
		BufferedReader br = null;
		FileWriter fw = null;
		BufferedWriter bw = null;
		try {
			fr = new FileReader(metaPath + "/" + runFileName);
			br = new BufferedReader(fr);
			
			if(!indexPath.exists()){ indexPath.mkdirs(); }
			fw = new FileWriter(indexPath+"/"+runFileName+".log");
			bw = new BufferedWriter(fw);
			
			String rLine = null;
			while((rLine = br.readLine())!=null){
				String[] items = rLine.split(",");
				if(items.length > 4){
					
					String uci = items[0].replaceAll("\\\"", "");
					String cid = items[1].replaceAll("\\\"", "");
					String svcod = items[2].replaceAll("\\\"", "");
					String stime = items[3].replaceAll("\\\"", "");
					String asp = items[4].replaceAll("\\\"", "");
					
					JSONObject json = appendMeta(cid, candiId);
					
//					json.put("uci", uci);
//					json.put("cid", cid);
					json.put("svcod", svcod);
					
					stime = stime.replace(":", "");
					stime = stime.replace("/", "");
					stime = stime.replace("-", "");
					stime = stime.replace(" ", "");
					String es_type = stime.substring(0,8);
					double rand = Math.random();
					double d = rand * 1000;
					int randomInt = (int)d;
					String es_id = stime+"_"+cid+"_"+randomInt;
					
					StringBuffer stimeBfr = new StringBuffer();
					stimeBfr.append(stime.substring(0,4)+"-");
					stimeBfr.append(stime.substring(4,6)+"-");
					stimeBfr.append(stime.substring(6,8)+"T");
					stimeBfr.append(stime.substring(8,10)+":");
					stimeBfr.append(stime.substring(10,12)+":");
					stimeBfr.append(stime.substring(12));
					stime = stimeBfr.toString();

					json.put("stime", stime);
					json.put("asp", asp);
					
					json.put("es_index", candiId);
					json.put("es_type", es_type);
					json.put("es_id", es_id);
					
				    bw.write(json.toString());
				    bw.newLine();
				    
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				br.close();
				bw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private JSONObject appendMeta(String cid, String candiId){
		EsDao esDao = EsDao.getInstance();
		String url = "http://localhost:9200/"+metaIndex+"/"+candiId+"/"+cid+"/_source";
		JSONObject metaJson = esDao.getJson(url);
		
		try {
			if(metaJson == null || metaJson.length() == 0){
				metaJson = new JSONObject();

				metaJson.put("uci", "");
				metaJson.put("cid", cid);
				metaJson.put("title", "");
				metaJson.put("album", "");
				metaJson.put("artist", "");
				metaJson.put("genre", "");
				metaJson.put("rdate", "");
				metaJson.put("ptime", "");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return metaJson;
	}
	
}
