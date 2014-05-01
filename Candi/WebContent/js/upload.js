var initCsv = "";
var initJson = "";
var initXml = "";
var initExcel = "";
var initFieldBtn = "";
/**
 * 첫 화면에서 숨겨야 할 오브젝트 숨김.
 */
function olHideObj(){
	$("#showCSV").show(); $("#showJSON").hide(); $("#showXML").hide(); $("#showExcel").hide();
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
	    
function checkDatatype(rdSel){
	if($("#rdCsv").is(":checked")){
		$("#showCSV").show(); $("#showJSON").hide(); $("#showXML").hide(); $("#showExcel").hide();
	}
	if($("#rdJson").is(":checked")){
		$("#showCSV").hide(); $("#showJSON").show(); $("#showXML").hide(); $("#showExcel").hide();
	}
	if($("#rdXml").is(":checked")){
		$("#showCSV").hide(); $("#showJSON").hide(); $("#showXML").show(); $("#showExcel").hide();
	}
	if($("#rdExcel").is(":checked")){
		$("#showCSV").hide(); $("#showJSON").hide(); $("#showXML").hide(); $("#showExcel").show();
	}
}

function insertField(){
	var filedName = $("#addData").val();
	
	if(filedName != ""){
		
		$("#fieldsCsv1").append(",\""+filedName+"-val-1\"");
		$("#fieldsCsv2").append(",\""+filedName+"-val-2\"");
		
		$("#fieldsJson1").append(",\n	\""+filedName+"\" : \""+filedName+"-val-1\"");
		$("#fieldsJson2").append(",\n	\""+filedName+"\" : \""+filedName+"-val-2\"");
		
		$("#fieldsXml1").append("	&lt;"+filedName+"&gt; "+filedName+"-val-1 "+ "&lt;/"+filedName+"&gt;\n");
		$("#fieldsXml2").append("	&lt;"+filedName+"&gt; "+filedName+"-val-2 "+ "&lt;/"+filedName+"&gt;\n");
		
		$("#xlHead").append("<th>"+filedName+"</th>");
		$("#xlBody1").append("<td>"+filedName+"-val-1</td>");
		$("#xlBody2").append("<td>"+filedName+"-val-2</td>");
		
		$("#addData").val("");
		
		$("#fieldBtns").append(" <button type=\"button\" class=\"btn btn-default btn-xs\">"+filedName+"</button>");
		
		$("#addFieldVals").val($("#addFieldVals").val()+","+filedName);
	}
}

function clearField(){
	
	$("#preCsv").html(initCsv);
	$("#preJson").html(initJson);
	$("#preXml").html(initXml);
	$("#fieldsExcel").html(initExcel);
	$("#fieldBtns").html(initFieldBtn);
	$("#addFieldVals").val("");
	
	saveField();
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
	$('#btnFldSvcod').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Service Code (서비스 코드)',
		content : '<h5>해당 컨텐츠에 적용된 서비스 코드. <br/><br/>예) <code>0001</code>:다운로드, <code>0002</code>:스트리밍</h5>'
	});
	$('#btnFldStime').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : "Service Time (서비스 시간)",
		content : "<h5>해당 컨텐츠가 소비된 시간<br/><code>YYYY-MM-DDThh:mi:ss</code><br/>형식으로 기록 할 것 <br/><br/>예)<code>2014-04-21T17:52:43</code></h5>"
	});
	$('#btnFldAsp').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : "Service Provider (서비스 공급자)",
		content : "<h5>서비스 공급자.<br/> 2차 서비스 공급자에게 컨텐츠를 제공하는 경우 해당 서비스 공급자를 명시. <br/><br/>예)<code>(주)카카오</code>, <code>(주)네이버뮤직</code></h5>"
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
		content : '<h5>컨텐츠에 참여한 가수 및 아티스트.<br/>다수가 참여한 경우에는 [ ] 배열로 묶어서 입력.<br/><br/>예) <code>["아이유","슬옹"]</code></h5>'
	});
	$('#btnFldGenre').popover({
		html:true, trigger:'hover', placement:'bottom',
	    title : 'Genre (장르)',
	    content : '<h5>컨텐츠의 장르.</h5>'
	});
	$('#btnFldRdate').popover({
		html:true, trigger:'hover', placement:'bottom',
		title : 'Release Date (발매일)',
		content : "<h5>해당 컨텐츠가 발매된 일자.<br/><code>YYYY-MM-DD</code>형식으로 기록 할 것.<br/><br/>예)<code>2014-04-21</code></h5>"
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
function saveField(){
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
			//{"DATA1":"1234","DATA2":"5678"}	<- 리턴되는 서블릿 JSON
			//$("#aIP").attr("value", data.DATA1); <- 이런 형태로 사용.
			if(data.result > 0){
				alert("저장되었습니다.");
			}
		}
	    ,error:function(e) {	// 이곳의 ajax에서 에러가 나면 얼럿창으로 에러 메시지 출력
	    	console.log(e.responseText);
	    }
	});
}

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
			//{"DATA1":"1234","DATA2":"5678"}	<- 리턴되는 서블릿 JSON
			//$("#aIP").attr("value", data.DATA1); <- 이런 형태로 사용.
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