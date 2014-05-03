package candi.es;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import org.json.JSONArray;
import org.json.JSONObject;

import jm.com.JmProperties;

public class IndexIO {

	private static IndexIO instance = null;
	private JmProperties property = null;
	private File indexPath;
	
	private IndexIO(){
		property = new JmProperties("/data/conf/candi.property");
		indexPath = new File(property.get("candiIndexPath"));
	}
	
	public static IndexIO getInstance() {
		if(instance == null){
			instance = new IndexIO();
		}
		return instance;
	}
	
	/**
	 * csv 파일을 json 형식의 로그 파일로 만들어서 저장.
	 * @param runFile
	 * @param candiId
	 */
	public void saveCsv(File runFile, String candiId){
		FileReader fr = null;
		BufferedReader br = null;
		
		FileWriter fw = null;
		BufferedWriter bw = null;
		try {
			fr = new FileReader(runFile);
			br = new BufferedReader(fr);
			
			if(!indexPath.exists()){ indexPath.mkdirs(); }
			fw = new FileWriter(indexPath + "/" + runFile+".log");
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
					
					
					json.put("es_index", "music_meta");
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
	
	
	
}
