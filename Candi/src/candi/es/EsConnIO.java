package candi.es;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.JSONObject;

public class EsConnIO {
	
	private static EsConnIO instance = null;
	
	private EsConnIO(){
	}
	
	public static EsConnIO getInstance() {
		if(instance == null){
			instance = new EsConnIO();
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
	
	/**
	 * 키바나에 최초 값 입력.
	 * @param id
	 */
	public void setKibana(String id){
		String data = "{\"user\":\"guest\",\"group\":\"guest\",\"title\":\""+id+"\",\"dashboard\":\"{\\\"title\\\":\\\""+id+"\\\",\\\"services\\\":{\\\"query\\\":{\\\"list\\\":{\\\"0\\\":{\\\"query\\\":\\\"*\\\",\\\"alias\\\":\\\"\\\",\\\"color\\\":\\\"#7EB26D\\\",\\\"id\\\":0,\\\"pin\\\":false,\\\"type\\\":\\\"lucene\\\",\\\"enable\\\":true}},\\\"ids\\\":[0]},\\\"filter\\\":{\\\"list\\\":{},\\\"ids\\\":[]}},\\\"rows\\\":[{\\\"title\\\":\\\"row1\\\",\\\"height\\\":\\\"320px\\\",\\\"editable\\\":false,\\\"collapse\\\":false,\\\"collapsable\\\":true,\\\"panels\\\":[{\\\"error\\\":false,\\\"span\\\":3,\\\"editable\\\":false,\\\"type\\\":\\\"column\\\",\\\"loadingEditor\\\":false,\\\"panels\\\":[{\\\"type\\\":\\\"hits\\\",\\\"chart\\\":\\\"total\\\",\\\"height\\\":\\\"40px\\\",\\\"style\\\":{\\\"font-size\\\":\\\"36pt\\\"},\\\"arrangement\\\":\\\"horizontal\\\",\\\"counter_pos\\\":\\\"above\\\",\\\"donut\\\":false,\\\"tilt\\\":false,\\\"labels\\\":true,\\\"spyable\\\":false,\\\"queries\\\":{\\\"mode\\\":\\\"all\\\",\\\"ids\\\":[0]},\\\"title\\\":\\\"전체\\\",\\\"editable\\\":false},{\\\"loading\\\":false,\\\"sizeable\\\":false,\\\"draggable\\\":false,\\\"removable\\\":false,\\\"span\\\":10,\\\"height\\\":\\\"150px\\\",\\\"editable\\\":false,\\\"type\\\":\\\"hits\\\",\\\"chart\\\":\\\"list\\\",\\\"style\\\":{\\\"font-size\\\":\\\"14pt\\\"},\\\"arrangement\\\":\\\"horizontal\\\",\\\"counter_pos\\\":\\\"above\\\",\\\"donut\\\":false,\\\"tilt\\\":false,\\\"labels\\\":true,\\\"spyable\\\":false,\\\"queries\\\":{\\\"mode\\\":\\\"all\\\",\\\"ids\\\":[0]},\\\"title\\\":\\\"검색결과별\\\"}],\\\"title\\\":\\\"카운트\\\"},{\\\"error\\\":false,\\\"span\\\":9,\\\"editable\\\":false,\\\"type\\\":\\\"terms\\\",\\\"loadingEditor\\\":false,\\\"field\\\":\\\"title\\\",\\\"exclude\\\":[],\\\"missing\\\":false,\\\"other\\\":false,\\\"size\\\":20,\\\"order\\\":\\\"count\\\",\\\"style\\\":{\\\"font-size\\\":\\\"10pt\\\"},\\\"donut\\\":false,\\\"tilt\\\":false,\\\"labels\\\":true,\\\"arrangement\\\":\\\"horizontal\\\",\\\"chart\\\":\\\"bar\\\",\\\"counter_pos\\\":\\\"above\\\",\\\"spyable\\\":false,\\\"queries\\\":{\\\"mode\\\":\\\"all\\\",\\\"ids\\\":[0]},\\\"tmode\\\":\\\"terms\\\",\\\"tstat\\\":\\\"total\\\",\\\"valuefield\\\":\\\"\\\",\\\"title\\\":\\\"TOP 20 타이틀\\\"}],\\\"notice\\\":false},{\\\"title\\\":\\\"row2\\\",\\\"height\\\":\\\"300px\\\",\\\"editable\\\":false,\\\"collapse\\\":false,\\\"collapsable\\\":true,\\\"panels\\\":[{\\\"error\\\":false,\\\"span\\\":4,\\\"editable\\\":false,\\\"type\\\":\\\"terms\\\",\\\"loadingEditor\\\":false,\\\"field\\\":\\\"asp\\\",\\\"exclude\\\":[],\\\"missing\\\":false,\\\"other\\\":true,\\\"size\\\":10,\\\"order\\\":\\\"count\\\",\\\"style\\\":{\\\"font-size\\\":\\\"10pt\\\"},\\\"donut\\\":false,\\\"tilt\\\":false,\\\"labels\\\":true,\\\"arrangement\\\":\\\"horizontal\\\",\\\"chart\\\":\\\"pie\\\",\\\"counter_pos\\\":\\\"above\\\",\\\"spyable\\\":false,\\\"queries\\\":{\\\"mode\\\":\\\"all\\\",\\\"ids\\\":[0]},\\\"tmode\\\":\\\"terms\\\",\\\"tstat\\\":\\\"total\\\",\\\"valuefield\\\":\\\"\\\",\\\"title\\\":\\\"서비스 공급자별 분포\\\"},{\\\"error\\\":false,\\\"span\\\":8,\\\"editable\\\":false,\\\"type\\\":\\\"terms\\\",\\\"loadingEditor\\\":false,\\\"field\\\":\\\"artist\\\",\\\"exclude\\\":[],\\\"missing\\\":false,\\\"other\\\":false,\\\"size\\\":20,\\\"order\\\":\\\"count\\\",\\\"style\\\":{\\\"font-size\\\":\\\"10pt\\\"},\\\"donut\\\":false,\\\"tilt\\\":false,\\\"labels\\\":true,\\\"arrangement\\\":\\\"horizontal\\\",\\\"chart\\\":\\\"bar\\\",\\\"counter_pos\\\":\\\"above\\\",\\\"spyable\\\":false,\\\"queries\\\":{\\\"mode\\\":\\\"all\\\",\\\"ids\\\":[0]},\\\"tmode\\\":\\\"terms\\\",\\\"tstat\\\":\\\"total\\\",\\\"valuefield\\\":\\\"\\\",\\\"title\\\":\\\"TOP 20 아티스트\\\"}],\\\"notice\\\":false},{\\\"title\\\":\\\"row3\\\",\\\"height\\\":\\\"300px\\\",\\\"editable\\\":false,\\\"collapse\\\":false,\\\"collapsable\\\":true,\\\"panels\\\":[{\\\"span\\\":8,\\\"editable\\\":false,\\\"type\\\":\\\"histogram\\\",\\\"loadingEditor\\\":false,\\\"mode\\\":\\\"count\\\",\\\"time_field\\\":\\\"stime\\\",\\\"value_field\\\":null,\\\"x-axis\\\":true,\\\"y-axis\\\":true,\\\"scale\\\":1,\\\"y_format\\\":\\\"none\\\",\\\"grid\\\":{\\\"max\\\":null,\\\"min\\\":0},\\\"queries\\\":{\\\"mode\\\":\\\"all\\\",\\\"ids\\\":[0]},\\\"annotate\\\":{\\\"enable\\\":false,\\\"query\\\":\\\"*\\\",\\\"size\\\":20,\\\"field\\\":\\\"_type\\\",\\\"sort\\\":[\\\"_score\\\",\\\"desc\\\"]},\\\"auto_int\\\":false,\\\"resolution\\\":100,\\\"interval\\\":\\\"1h\\\",\\\"intervals\\\":[\\\"auto\\\",\\\"1s\\\",\\\"1m\\\",\\\"5m\\\",\\\"10m\\\",\\\"30m\\\",\\\"1h\\\",\\\"3h\\\",\\\"12h\\\",\\\"1d\\\",\\\"1w\\\",\\\"1y\\\"],\\\"lines\\\":false,\\\"fill\\\":0,\\\"linewidth\\\":3,\\\"points\\\":false,\\\"pointradius\\\":5,\\\"bars\\\":true,\\\"stack\\\":true,\\\"spyable\\\":false,\\\"zoomlinks\\\":true,\\\"options\\\":true,\\\"legend\\\":true,\\\"show_query\\\":true,\\\"interactive\\\":true,\\\"legend_counts\\\":true,\\\"timezone\\\":\\\"browser\\\",\\\"percentage\\\":false,\\\"zerofill\\\":true,\\\"derivative\\\":false,\\\"tooltip\\\":{\\\"value_type\\\":\\\"cumulative\\\",\\\"query_as_alias\\\":true},\\\"title\\\":\\\"시간대 별 hit 수\\\"},{\\\"error\\\":false,\\\"span\\\":4,\\\"editable\\\":false,\\\"type\\\":\\\"terms\\\",\\\"loadingEditor\\\":false,\\\"field\\\":\\\"svcode\\\",\\\"exclude\\\":[],\\\"missing\\\":false,\\\"other\\\":true,\\\"size\\\":10,\\\"order\\\":\\\"count\\\",\\\"style\\\":{\\\"font-size\\\":\\\"10pt\\\"},\\\"donut\\\":false,\\\"tilt\\\":false,\\\"labels\\\":true,\\\"arrangement\\\":\\\"horizontal\\\",\\\"chart\\\":\\\"table\\\",\\\"counter_pos\\\":\\\"above\\\",\\\"spyable\\\":false,\\\"queries\\\":{\\\"mode\\\":\\\"all\\\",\\\"ids\\\":[0]},\\\"tmode\\\":\\\"terms\\\",\\\"tstat\\\":\\\"total\\\",\\\"valuefield\\\":\\\"\\\",\\\"title\\\":\\\"서비스 코드별 카운트\\\"}],\\\"notice\\\":false},{\\\"title\\\":\\\"row4\\\",\\\"height\\\":\\\"300px\\\",\\\"editable\\\":false,\\\"collapse\\\":false,\\\"collapsable\\\":true,\\\"panels\\\":[{\\\"error\\\":false,\\\"span\\\":12,\\\"editable\\\":false,\\\"type\\\":\\\"table\\\",\\\"loadingEditor\\\":false,\\\"size\\\":20,\\\"pages\\\":5,\\\"offset\\\":0,\\\"sort\\\":[\\\"_score\\\",\\\"desc\\\"],\\\"overflow\\\":\\\"min-height\\\",\\\"fields\\\":[],\\\"highlight\\\":[],\\\"sortable\\\":true,\\\"header\\\":true,\\\"paging\\\":true,\\\"field_list\\\":true,\\\"all_fields\\\":false,\\\"trimFactor\\\":300,\\\"localTime\\\":false,\\\"timeField\\\":\\\"@timestamp\\\",\\\"spyable\\\":false,\\\"queries\\\":{\\\"mode\\\":\\\"all\\\",\\\"ids\\\":[0]},\\\"style\\\":{\\\"font-size\\\":\\\"9pt\\\"},\\\"normTimes\\\":true,\\\"title\\\":\\\"로그 데이터\\\"}],\\\"notice\\\":false}],\\\"editable\\\":true,\\\"failover\\\":false,\\\"index\\\":{\\\"interval\\\":\\\"none\\\",\\\"pattern\\\":\\\"[logstash-]YYYY.MM.DD\\\",\\\"default\\\":\\\""+id+"\\\",\\\"warm_fields\\\":false},\\\"style\\\":\\\"light\\\",\\\"panel_hints\\\":false,\\\"pulldowns\\\":[{\\\"type\\\":\\\"query\\\",\\\"collapse\\\":true,\\\"notice\\\":false,\\\"enable\\\":true,\\\"query\\\":\\\"*\\\",\\\"pinned\\\":true,\\\"history\\\":[],\\\"remember\\\":10},{\\\"type\\\":\\\"filtering\\\",\\\"collapse\\\":true,\\\"notice\\\":false,\\\"enable\\\":true}],\\\"nav\\\":[{\\\"type\\\":\\\"timepicker\\\",\\\"collapse\\\":false,\\\"notice\\\":false,\\\"enable\\\":true,\\\"status\\\":\\\"Stable\\\",\\\"time_options\\\":[\\\"5m\\\",\\\"15m\\\",\\\"1h\\\",\\\"6h\\\",\\\"12h\\\",\\\"24h\\\",\\\"2d\\\",\\\"7d\\\",\\\"30d\\\"],\\\"refresh_intervals\\\":[\\\"5s\\\",\\\"10s\\\",\\\"30s\\\",\\\"1m\\\",\\\"5m\\\",\\\"15m\\\",\\\"30m\\\",\\\"1h\\\",\\\"2h\\\",\\\"1d\\\"],\\\"timefield\\\":\\\"stime\\\"}],\\\"loader\\\":{\\\"save_gist\\\":false,\\\"save_elasticsearch\\\":true,\\\"save_local\\\":true,\\\"save_default\\\":true,\\\"save_temp\\\":true,\\\"save_temp_ttl_enable\\\":true,\\\"save_temp_ttl\\\":\\\"30d\\\",\\\"load_gist\\\":false,\\\"load_elasticsearch\\\":true,\\\"load_elasticsearch_size\\\":20,\\\"load_local\\\":true,\\\"hide\\\":false},\\\"refresh\\\":false}\"}";
		String urls = "http://localhost:9200/candi-osp/dashboard/"+id;

		StringBuffer res = new StringBuffer();
		URL url = null;
		HttpURLConnection conn = null;
		try {

			url = new URL(urls);
			conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");

			OutputStream os = conn.getOutputStream();
			os.write(data.getBytes());
			os.flush();

			BufferedReader br = new BufferedReader(new InputStreamReader(
					conn.getInputStream()));
			String output;
			while ((output = br.readLine()) != null) {
				res.append(output);
			}
			conn.disconnect();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
			// 오류의 경우 getErrorStream 으로 오류 스트림 전달.
			try {
				BufferedReader br = new BufferedReader(new InputStreamReader(
						conn.getErrorStream()));
				String errOutput;
				res = new StringBuffer();
				while ((errOutput = br.readLine()) != null) {
					res.append(errOutput);
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		System.out.println("rs : \n"+res.toString());
	}
}
