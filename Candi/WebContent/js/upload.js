var initCsv = "";
var initJson = "";
var initXml = "";
var initExcel = "";
var initFieldBtn = "";

function olSaveHtml(){
	initCsv = $("#preCsv").html();
	initJson = $("#preJson").html();
	initXml = $("#preXml").html();
	initExcel = $("#fieldsExcel").html();
	initFieldBtn = $("#fieldBtns").html();
}

function enterData(field,e){
	if (e.which == 13) {
        $('#btnAddData').click();
    }
}

function insertField(){
	var filedName = $("#addData").val();
	
	if(filedName != ""){
		
		$("#fieldsCsv1").append(",\""+filedName+"-1\"");
		$("#fieldsCsv2").append(",\""+filedName+"-2\"");
		
		$("#fieldsJson1").append(",\n	\""+filedName+"\" : \""+filedName+"-1\"");
		$("#fieldsJson2").append(",\n	\""+filedName+"\" : \""+filedName+"-2\"");
		
		$("#fieldsXml1").append("	&lt;"+filedName+"&gt;"+filedName+"-1"+ "&lt;/"+filedName+"&gt;\n");
		$("#fieldsXml2").append("	&lt;"+filedName+"&gt;"+filedName+"-2"+ "&lt;/"+filedName+"&gt;\n");
		
		$("#xlHead").append("<th>"+filedName+"</th>");
		$("#xlBody1").append("<td>"+filedName+"-1</td>");
		$("#xlBody2").append("<td>"+filedName+"-2</td>");
		
		$("#addData").val("");
		
		$("#fieldBtns").append(" <button type=\"button\" class=\"btn btn-default btn-xs\">"+filedName+"</button>");
		
		$("#addFieldVals").val($("#addFieldVals").val()+","+filedName);
	}
}

function clearField(){
	if(confirm("사용자가 추가한 필드를 모두 초기화 합니다.\n\n기존에 저장한 사용자 필드도 모두 초기화됩니다.\n\n계속 하시겠습니까?")){
		$("#preCsv").html(initCsv);
		$("#preJson").html(initJson);
		$("#preXml").html(initXml);
		$("#fieldsExcel").html(initExcel);
		$("#fieldBtns").html(initFieldBtn);
		$("#addFieldVals").val("");
		
		saveField("clear");
	}
}

/**
 * 로그파일 필드 버튼 팝오버 설정.
 */
function setLogPopover(){
	$('#btnFldUci').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Universal Content Identifier',
		content : '<h5>컨텐츠의 UCI 코드.<br/><br/>예) <code>i500-KRA0508346.1112159303-1</code></h5>'
	});
	$('#btnFldCid').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Content ID (컨텐츠 ID)',
		content : '<h5>업체에서 관리하는 컨텐츠의 고유 일련번호.<br/><br/>예) <code>3454147</code>, <code>PA0047483001012</code></h5>'
	});
	$('#btnFldSvcode').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Service Code (서비스 코드)',
		content : '<h5>해당 컨텐츠에 적용된 서비스 코드. <br/><br/>예) <code>0001</code>:다운로드, <code>0002</code>:스트리밍</h5>'
	});
	$('#btnFldStime').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : "Service Time (서비스 시간)",
		content : "<h5>해당 컨텐츠가 소비된 시간<br/><br/>표시 형식 : <code>YYYY-MM-DDThh:mi:ss</code><br/><br/>예) <code>2014-04-21T17:52:43</code></h5>"
	});
	$('#btnFldAsp').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : "Service Provider (서비스 공급자)",
		content : "<h5>2차 서비스 공급자에게 컨텐츠를 제공하는 경우 해당 서비스 공급자를 명시. <br/><br/>예)<code>(주)카카오</code>, <code>(주)네이버뮤직</code></h5>"
	});
}

/**
 * 메타파일 필드 버튼 팝오버 설정.
 */
function setMetaPopover(){
	$('#btnFldUci').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Universal Content Identifier',
		content : '<h5>컨텐츠의 UCI 코드.<br/><br/>예) <code>i500-KRA0508346.1112159303-1</code></h5>'
	});
	$('#btnFldCid').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Content ID (컨텐츠 ID)',
		content : '<h5>업체에서 관리하는 컨텐츠의 고유 일련번호.<br/><br/>예) <code>3454147</code>, <code>PA0047483001012</code></h5>'
	});
	$('#btnFldTitle').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Title (제목)',
		content : '<h5>컨텐츠의 제목.</h5>'
	});
	$('#btnFldAlbum').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Album (앨범명)',
		content : '<h5>컨텐츠가 수록된 앨범명.</h5>'
	});
	$('#btnFldArtist').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Artist (가수/아티스트)',
		content : '<h5>컨텐츠에 참여한 가수 및 아티스트.<br/><br/>다수가 참여한 경우 :<br/> - CSV,Excel : 쉼표(,)로 구분<br/> - JSON : [ ] 배열로 입력<br/> - XML : &lt;item&gt; &lt;/item&gt; 태그로 구분<br/><br/>예) <code>["아이유(IU)","임슬옹"]</code></h5>'
	});
	$('#btnFldGenre').popover({
		html:true, trigger:'hover', placement:'bottom',
	    title : 'Genre (장르)',
	    content : '<h5>컨텐츠의 장르.</h5>'
	});
	$('#btnFldRdate').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Release Date (발매일)',
		content : "<h5>해당 컨텐츠가 발매된 일자.<br/><br/><code>YYYY-MM-DD</code>형식으로 기록 할 것.<br/><br/>예)<code>2014-04-21</code></h5>"
	});
	$('#btnFldPtime').popover({
		html:true, trigger:'hover', placement:'bottom',
	    title : 'Play Time (재생시간)',
	    content : '<h5>컨텐츠의 재생 시간.<br/>시분초 를 묶어 6자리 숫자로 표현한다.<br/><br/>예) 3분 55초 : <code>000355</code></h5>'
	});
}

/**
 * 추가된 필드 저장. Ajax 호출.
 */
function saveField(opt){
	var url="UploadAjax";
	var params = "";
	params+="cmd=saveField";
	params+="&";
	params+="upFileSrc="+$("#upFileSrc").val();
	params+="&";
	params+="addFieldVals="+$("#addFieldVals").val();
	
	$.ajax({
		type:"POST"
		,url:url
		,data:params
		,dataType:"json"
		,success:function(data){	//응답이 성공 상태 코드를 반환하면 호출되는 함수
			if(data.result > 0){
				if(opt=="clear"){
					alert("초기화 되었습니다.");
				} else {
					alert("저장되었습니다.");
				}
			}
		}
	    ,error:function(e) {	// 이곳의 ajax에서 에러가 나면 얼럿창으로 에러 메시지 출력
	    	console.log(e.responseText);
	    }
	});
}

/**
 * 추가된 필드 불러오는 메서드
 */
function setInitField(){
	var url="UploadAjax";
	var params = "";
	params = "cmd=getInintField";
	params+="&";
	params+="upFileSrc="+$("#upFileSrc").val();
	
	$.ajax({
		type:"POST"
		,url:url
		,data:params
		,dataType:"json"
		,success:function(data){	//응답이 성공 상태 코드를 반환하면 호출되는 함수
			for(var i=0; i< data.fieldVals.length; i++){
				$("#addData").val(data.fieldVals[i]);
				insertField();
			}
		}
	    ,error:function(e) {	// 이곳의 ajax에서 에러가 나면 얼럿창으로 에러 메시지 출력
	    	console.log(e.responseText);
	    }
	});
}

/**
 * 업로드한 메타 파일 인덱싱
 */
function runMeta(){
	if(confirm("업로드한 메타 파일의 색인을 시작하시겠습니까?")){
		var url="meta_run";
		var params = "";
		params = "cmd=runMeta";
		params+="&";
		
		$.ajax({
			type:"POST"
			,url:url
			,data:params
			,dataType:"json"
			,success:function(data){
			}
		    ,error:function(e) {	// 이곳의 ajax에서 에러가 나면 얼럿창으로 에러 메시지 출력
		    	console.log(e.responseText);
		    }
		});
		getRunInit("meta");
	}
}

function runLog(){
	if(confirm("업로드한 로그 파일의 색인을 시작하시겠습니까?")){
		var url="log_run";
		var params = "";
		params = "cmd=runLog";
		params+="&";
		
		$.ajax({
			type:"POST"
			,url:url
			,data:params
			,dataType:"json"
			,success:function(data){
			}
		    ,error:function(e) {	// 이곳의 ajax에서 에러가 나면 얼럿창으로 에러 메시지 출력
		    	console.log(e.responseText);
		    }
		});
		getRunInit("log");
	}
}

function getRunInit(opt){
	var upFileNames = document.getElementsByName("upFileName");
	var fileCnt = upFileNames.length;
	var fileStatHtml = "";
	for(var fc=0; fc < fileCnt; fc++){
		fileStatHtml+='<div class="row" name="runStatDiv">';
		fileStatHtml+='	<label for="runStat" class="col-lg-3 control-label text-right">'+$("#upFileName"+fc).html()+'</label>';
		fileStatHtml+='	<div class="col-lg-6">';
		fileStatHtml+='		<div id="fcBarMain'+fc+'" class="progress active">';
		fileStatHtml+='			<div id="fcBar'+fc+'" class="progress-bar" role="progressbar"></div>';
		fileStatHtml+='		</div>';
		fileStatHtml+='	</div>';
		fileStatHtml+='	<div class="col-lg-2">';
		fileStatHtml+='		<span id="runStatTxt'+fc+'">파일이 적용되지 않았습니다.</span>';
		fileStatHtml+='	</div>';
		fileStatHtml+='</div>';
	}
	$("#runFileStat").html(fileStatHtml);
	getRunStatus(opt,fileCnt);
}

function getRunStatus(opt,fileCnt){
	var url="UploadAjax";
	var params = "";
	params = "cmd=getRunStatus";
	params+="&";
	params+="uptype="+opt;
	
	$.ajax({
		type:"POST"
		,url:url
		,data:params
		,dataType:"json"
		,success:function(data){	//응답이 성공 상태 코드를 반환하면 호출되는 함수
			var doneCnt = 0;
			if(data != null && data.runStats != null && data.runStats.length > 0){
				for(var fc=0; fc < data.runStats.length; fc++){
					var $bar = $("#fcBar"+fc);
					$bar.text(data.runStats[fc].percent + "%");
					$bar.css('width', data.runStats[fc].percent + "%");
					if(data.runStats[fc].stat == "done"){
						$("#runStatTxt"+fc).html("완료되었습니다.");
						doneCnt++;
					} else {
						$("#runStatTxt"+fc).html("적용중입니다.");
					}
				}
			}
			if(fileCnt == 0){
				getRunInit(opt);
			} else {
				if(doneCnt < fileCnt){
					if(data.runStats.length > 0){
						getRunStatus(opt,fileCnt);
					}
				}
			}
		}
	    ,error:function(e) {	// 이곳의 ajax에서 에러가 나면 얼럿창으로 에러 메시지 출력
	    	console.log(e.responseText);
	    }
	});
}


function delUpFiles(opt, filename){
	var url=opt+"_upload";
	var params = "file="+filename;
	$.ajax({
		type:"DELETE"
		,url:url
		,data:params
		,dataType:"json"
		,success:function(data){
		}
	    ,error:function(e) {	// 이곳의 ajax에서 에러가 나면 얼럿창으로 에러 메시지 출력
	    	console.log(e.responseText);
	    }
	});
}