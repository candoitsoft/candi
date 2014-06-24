<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="candi.com.CandiUserObj,candi.com.CandiMsg"%>
<%
	//사용자 로그인 체크하는 로직. 모든 페이지에 반드시 포함할것.
	String id = (String) session.getAttribute("candiId");
	CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
	if (id == null || id.equals("") || userObj == null) {
		//로그인 오류시 login.jsp 페이지로 이동.
		out.print(CandiMsg.loginError());
	} else {
%>
<!DOCTYPE HTML>
<!--
/*
 * jQuery File Upload Plugin Demo 9.0.1
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */
-->
<html lang="en">
<head>
<!-- Force latest IE rendering engine or ChromeFrame if installed -->
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<![endif]-->
<meta charset="utf-8">
<title>메타데이터 입력</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap styles -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- Generic page styles -->
<link rel="stylesheet" href="css/style.css">
<!-- blueimp Gallery styles -->
<link rel="stylesheet" href="css/blueimp-gallery.min.css">
<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
<link rel="stylesheet" href="css/jquery.fileupload.css">
<link rel="stylesheet" href="css/jquery.fileupload-ui.css">
<!-- CSS adjustments for browsers with JavaScript disabled -->
<noscript>
	<link rel="stylesheet" href="css/jquery.fileupload-noscript.css">
</noscript>
<noscript>
	<link rel="stylesheet" href="css/jquery.fileupload-ui-noscript.css">
</noscript>
<script src="js/candoit.js"></script>
<script src="js/upload.js"></script>
<script type="text/javascript">

/**
 * 첫 화면에서 실행하는 함수 모음.
 */
window.onload = function(){	
	olSaveHtml();
	setMetaPopover();
	setInitField();
	getRunInit("meta");
}

</script>

</head>
<body>

	<nav class="navbar navbar-inverse" role="navigation">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
				<span class="sr-only">상단 네비게이션</span>
			</button>
			<a class="navbar-brand" href="#"><%=userObj.getName()%></a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse navbar-ex1-collapse">
			<ul class="nav navbar-nav">
				<li class=""><a href="main.jsp">데이터 분석</a></li>
				<li class=""><a href="logUpload.jsp">로그데이터 입력</a></li>
				<li class="active"><a href="#">메타데이터 입력</a></li>
			</ul>
			<form id="navFrm" name="navFrm" class="navbar-form navbar-right btn-group" role="search">
				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					<i class="glyphicon glyphicon-cog"></i>
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="menu">
					<li><a href="#">사용자정보 변경</a></li>
					<li><a href="#">대시보드 환경설정</a></li>
					<li class="divider"></li>
					<li><a href="javascript:logout();">로그아웃</a></li>
				</ul>
				<input type="hidden" name="cmd" />
				<input type="hidden" name="toUrl" />
			</form>
		</div>
	</nav>
	
	<div class="container">
		<h1>메타데이터 입력</h1>
		<h3>데이터 필드</h3>
		<p>
			<label class="">필드 목록 : </label> 
			<span id="fieldBtns">
				<button id="btnFldUci" type="button" class="btn btn-info btn-xs">uci</button>
				<button id="btnFldCid" type="button" class="btn btn-danger btn-xs">cid</button>
				<button id="btnFldTitle" type="button" class="btn btn-danger btn-xs">title</button>
				<button id="btnFldAlbum" type="button" class="btn btn-info btn-xs">album</button>
				<button id="btnFldArtist" type="button" class="btn btn-info btn-xs">artist</button>
				<button id="btnFldGenre" type="button" class="btn btn-info btn-xs">genre</button>
				<button id="btnFldRdate" type="button" class="btn btn-info btn-xs">rdate</button>
				<button id="btnFldPtime" type="button" class="btn btn-info btn-xs">ptime</button>
			</span>
		</p>
		<blockquote>
			입력할 메타 파일에 위의
			<button type="button" class="btn btn-info btn-xs">공백허용</button>
			<button type="button" class="btn btn-danger btn-xs">공백불가</button> 
			필드들은 필수로 입력해야 합니다.<br/>
			마우스를 필드명에 가져다 대면 자세한 설명이 나타납니다.<br/>
			반드시 설명을 읽고 올바른 형식 대로 입력 하십시오.<br/>
			붉은색으로 표시된
			<button type="button" class="btn btn-danger btn-xs">cid</button>
			<button type="button" class="btn btn-danger btn-xs">title</button>
			필드들은 값에 null(공백)을 허용하지 않습니다. 반드시 유효한 값이 존재해야 합니다.<br/>
			필드의 값이 존재하지 않는 경우에도 공백값을 넣고 구분자로 구분해야 합니다.<br/>
			필수 필드 외에
			<button type="button" class="btn btn-default btn-xs">사용자정의</button>
			필드 추가가 가능합니다.
		</blockquote>
		
		<div  class="row">
			<form class="form-horizontal" role="form">
				<div class="form-group">
					<label for="addData" class="col-lg-1 control-label">필드 추가</label>
					<div class="col-lg-3">
						<input type="text" class="form-control" id="addData" placeholder="필드명" onkeypress="enterData(this,event);">
					</div>
					<div class="col-lg-4">
					<button type="button" class="btn btn-success" onclick="insertField();"><i class="glyphicon glyphicon-plus"></i> <span>추가</span></button>
					<button type="button" class="btn btn-primary" onclick="saveField();"><i class="glyphicon glyphicon-save"></i> <span>저장</span></button>
					<button type="button" class="btn btn-danger" onclick="clearField();"><i class="glyphicon glyphicon-remove"></i> <span>초기화</span></button>
					</div>
				</div>
				<input type="hidden" id="upFileSrc" name="upFileSrc" value="metaAddField"/>
				<input type="hidden" id="addFieldVals" name="addFieldVals" value=""/>
			</form>
		</div>
		
		<h3>메타파일 형식</h3>
		
		<blockquote>
			입력 가능한 메타의 형식은 CSV, JSON, XML, Excel 입니다.<br/>
			각 탭을 선택하면 해당 형식에 대한 설명을 볼 수 있습니다.<br/>
		</blockquote>
		
		<!-- 메타파일 형식 탭 시작 -->
		<div class="bs-example bs-example-tabs">
			<ul id="fldFmtTab" class="nav nav-tabs">
				<li class="active"><a href="#tabCsv" data-toggle="tab">CSV</a></li>
				<li ><a href="#tabJson" data-toggle="tab">JSON</a></li>
				<li ><a href="#tabXml" data-toggle="tab">XML</a></li>
				<li ><a href="#tabExcel" data-toggle="tab">Excel</a></li>
			</ul>
			
			<div id="fldFmtTabContent" class="tab-content">

<!-- CSV 형식 시작 -->
<div class="tab-pane fade active in" id="tabCsv">
	
	<h4>CSV 입력 규칙</h4>
	<blockquote>
		각 열(column)들은 따옴표(") 로 감싸서 입력하고 구분자는 쉼표(,) 입니다.<br/>
		값이 비어있는 열 에도 빈 따옴표("")를 입력해서 자리를 맞춥니다.<br/>
		한 필드에 2개 이상의 값이 있을때는 쉼표(,)로 구분합니다.<br/>
		하나의 행(row)은 한 줄에 입력되고 새로운 행은 줄바꿈해야 합니다.<br/>
		메타 데이터 외에 헤더, 주석 등의 불필요한 값은 입력하지 않도록 합니다.
	</blockquote>
<pre id="preCsv">
<span id="fieldsCsv1">"uci-1","cid-1","title-1","album-1","artist-1","genre-1","rdate-1","ptime-1"</span>
<span id="fieldsCsv2">"uci-2","cid-2","title-2","album-2","artist-2","genre-2","rdate-2","ptime-2"</span>
</pre>
	
	<h4>실제 입력 예</h4>
<pre>
"i500-USA3017721.1200166076-1","10429203","Let It Go","프로즌 (Frozen) OST","Idina Menzel(이디나 멘젤)","OST","2013-12-05","000344"
"i500-KRA0104042.0009298925-1","6121428","잔소리 (With 2AM 슬옹)","잔소리","아이유(IU),임슬옹","2010-06-03",""
"","5921418","벚꽃 엔딩","","버스커 버스커","","",""
</pre>

</div>
<!-- CSV 형식 끝 -->

<!-- JSON 형식 시작 -->
<div class="tab-pane fade" id="tabJson">

	<h4>JSON 입력 규칙</h4>
	<blockquote>
		각 열(column)의 값 들은 key : value 형식으로 표시합니다.<br/>
		key와 value 는 모두 따옴표(") 로 감싸서 입력하고 열 간 구분자는 쉼표(,) 입니다.<br/>
		값이 비어있는 열 에도 key는 존재해야 합니다. 값은 빈 따옴표 ("") 로 입력합니다.<br/>
		한 필드에 2개 이상의 값이 있을때는 대괄호([ ]) 안에 배열로 입력합니다.<br/>
		하나의 행(row)는 중괄호{} 로 묶고 행 간 구분자는 쉼표(,) 입니다.<br/>
		하나의 행(row)은 한 줄에 입력되고 새로운 행은 줄바꿈해야 합니다.<br/>
		메타 데이터 외에 헤더, 주석 등의 불필요한 값은 입력하지 않도록 합니다.
	</blockquote>

<pre id="preJson">{
<span id="fieldsJson1">	"uci" : "uci-1",
	"cid" : "cid-1",
	"title" : "title-1",
	"album" : "album-1",
	"artist" : "artist-1",
	"genre" : "genre-1",
	"rdate" : "rdate-1",
	"ptime" : "ptime-1"</span>
},
{
<span id="fieldsJson2">	"uci" : "uci-2",
	"cid" : "cid-2",
	"title" : "title-2",
	"album" : "album-2",
	"artist" : ["artist-2-1","artist-2-2"],
	"genre" : "genre-2",
	"rdate" : "rdate-2",
	"ptime" : "ptime-2"</span>
}
</pre>
	
	<h4>실제 입력 예</h4>
<pre>
{"uci":"i500-USA3017721.1200166076-1","cid":"10429203","title":"Let It Go","album":"프로즌 (Frozen) OST","artist":"Idina Menzel(이디나 멘젤)","genre":"OST","rdate":"2013-12-05","ptime":"000344"},
{"uci":"i500-KRA0104042.0009298925-1","cid":"6121428","title":"잔소리 (With 2AM 슬옹)","album":"잔소리","artist":["아이유(IU)","임슬옹"],"genre":"","rdate":"2010-06-03","ptime":""},
{"uci":"","cid":"5921418","title":"벚꽃 엔딩","album":"","artist":"버스커 버스커","genre":"","rdate":"","ptime":""}
</pre>

</div>
<!-- JSON 형식 끝 -->

<!-- XML 형식 시작 -->
<div class="tab-pane fade" id="tabXml">

	<h4>XML 입력 규칙</h4>
	<blockquote>
		각 열(column)의 값 들은 <code>&lt;필드명&gt;</code> <code>&lt;/필드명&gt;</code> 태그로 묶습니다.<br/>
		값이 비어있는 열 에도 필드명의 태그는 존재해야 합니다.<br/>
		한 필드에 2개 이상의 값이 있을때는 <code>&lt;item&gt;</code> <code>&lt;/item&gt;</code> 태그로 분리하여 표시합니다.<br/>
		하나의 행(row)는 <code>&lt;row&gt;</code> <code>&lt;/row&gt;</code> 태그로 묶습니다.<br/>
		가독성을 위해 행(row)이 바뀌면 줄바꿈 하도록 합니다.<br/>
		상단에 <code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;</code> 헤더를 입력합니다.<br/>
		그 외에 주석 등의 불필요한 값은 입력하지 않도록 합니다.
	</blockquote>
<pre id="preXml">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;row&gt;<span id="fieldsXml1">
	&lt;uci&gt;uci-1&lt;/uci&gt;
	&lt;cid&gt;cid-1&lt;/cid&gt;
	&lt;title&gt;title-1&lt;/title&gt;
	&lt;album&gt;album-1&lt;/album&gt;
	&lt;artist&gt;artist-1&lt;/artist&gt;
	&lt;genre&gt;genre-1&lt;/genre&gt;
	&lt;rdate&gt;rdate-1&lt;/rdate&gt;
	&lt;ptime&gt;ptime-2&lt;/ptime&gt;
</span>&lt;/row&gt;
&lt;row&gt;<span id="fieldsXml2">
	&lt;uci&gt;uci-2&lt;/uci&gt;
	&lt;cid&gt;cid-2&lt;/cid&gt;
	&lt;title&gt;title-2&lt;/title&gt;
	&lt;album&gt;album-2&lt;/album&gt;
	&lt;artist&gt;
		&lt;item&gt;artist-2-1&lt;/item&gt;
		&lt;item&gt;artist-2-2&lt;/item&gt;
	&lt;/artist&gt;
	&lt;genre&gt;genre-2&lt;/genre&gt;
	&lt;rdate&gt;rdate-2&lt;/rdate&gt;
	&lt;ptime&gt;ptime-2&lt;/ptime&gt;
</span>&lt;/row&gt;
</pre>

	<h4>실제 입력 예</h4>
<pre>
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;row&gt;
	&lt;uci&gt;i500-USA3017721.1200166076-1&lt;/uci&gt;
	&lt;cid&gt;10429203&lt;/cid&gt;
	&lt;title&gt;Let It Go&lt;/title&gt;
	&lt;album&gt;프로즌 (Frozen) OST&lt;/album&gt;
	&lt;artist&gt;Idina Menzel(이디나 멘젤)&lt;/artist&gt;
	&lt;genre&gt;OST&lt;/genre&gt;
	&lt;rdate&gt;2013-12-05&lt;/rdate&gt;
	&lt;ptime&gt;000344&lt;/ptime&gt;
&lt;/row&gt;
&lt;row&gt;
	&lt;uci&gt;i500-KRA0104042.0009298925-1&lt;/uci&gt;
	&lt;cid&gt;6121428&lt;/cid&gt;
	&lt;title&gt;잔소리 (With 2AM 슬옹)&lt;/title&gt;
	&lt;album&gt;잔소리&lt;/album&gt;
	&lt;artist&gt;
		&lt;item&gt;아이유(IU)&lt;/item&gt;
		&lt;item&gt;임슬옹&lt;/item&gt;
	&lt;/artist&gt;
	&lt;genre&gt;&lt;/genre&gt;
	&lt;rdate&gt;2010-06-03&lt;/rdate&gt;
	&lt;ptime&gt;&lt;/ptime&gt;
&lt;/row&gt;
&lt;row&gt;
	&lt;uci&gt;&lt;/uci&gt;
	&lt;cid&gt;5921418&lt;/cid&gt;
	&lt;title&gt;벚꽃 엔딩&lt;/title&gt;
	&lt;album&gt;&lt;/album&gt;
	&lt;artist&gt;버스커 버스커&lt;/artist&gt;
	&lt;genre&gt;&lt;/genre&gt;
	&lt;rdate&gt;&lt;/rdate&gt;
	&lt;ptime&gt;&lt;/ptime&gt;
&lt;/row&gt;
</pre>	
	
	
</div>
<!-- XML 형식 끝 -->

<!-- Excel 형식 시작 -->
<div class="tab-pane fade" id="tabExcel">

	<h4>Excel 입력 규칙</h4>
	<blockquote>
		모든 셀의 형식은 "텍스트" 로 되어 있어야 합니다.(자동,숫자,날짜 등 X)<br/>
		데이터는 엑셀 파일의 첫번째 시트(Sheet)에 있어야 합니다.<br/>
		데이터가 많아 한 시트에 입력이 불가능한 경우 다음 시트에 연속해서 입력합니다.<br/>
		첫 행(row) 에는 각 열의 이름이 들어갑니다. 시트가 2개 이상인 경우 모든 시트에 동일하게 적용됩니다.<br/>
		맨 마지막 행이 끝날 때 까지 중간에 비어있는 행이 없어야 합니다.<br/>
		한 필드에 2개 이상의 값이 있을때는 쉼표(,)로 구분합니다.<br/>
		그 외에 주석 등의 불필요한 값은 입력하지 않도록 합니다.
	</blockquote>

<table id="fieldsExcel" class="table table-bordered">
	<thead>
		<tr id="xlHead" class="active">
			<th>uci</th>
			<th>cid</th>
			<th>title</th>
			<th>album</th>
			<th>artist</th>
			<th>genre</th>
			<th>rdate</th>
			<th>ptime</th>
		</tr>
	</thead>
	<tbody>
		<tr id="xlBody1">
			<td>uci-1</td>
			<td>cid-1</td>
			<td>title-1</td>
			<td>album-1</td>
			<td>artist-1</td>
			<td>genre-1</td>
			<td>rdate-1</td>
			<td>ptime-1</td>
		</tr>
		<tr id="xlBody2">
			<td>uci-2</td>
			<td>cid-2</td>
			<td>title-2</td>
			<td>album-2</td>
			<td>artist-2-1,artist-2-2</td>
			<td>genre-2</td>
			<td>rdate-2</td>
			<td>ptime-2</td>
		</tr>
	</tbody>
</table>

	<h4>실제 입력 예</h4>
<table class="table table-bordered">
	<thead>
		<tr class="active">
			<th>uci</th>
			<th>cid</th>
			<th>title</th>
			<th>album</th>
			<th>artist</th>
			<th>genre</th>
			<th>rdate</th>
			<th>ptime</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>i500-USA3017721.1200166076-1</td>
			<td>10429203</td>
			<td>Let It Go</td>
			<td>프로즌 (Frozen) OST</td>
			<td>Idina Menzel(이디나 멘젤)</td>
			<td>OST</td>
			<td>2013-12-05</td>
			<td>000344</td>
		</tr>
		<tr>
			<td>i500-KRA0104042.0009298925-1</td>
			<td>6121428</td>
			<td>잔소리 (With 2AM 슬옹)</td>
			<td>잔소리</td>
			<td>아이유(IU),임슬옹</td>
			<td></td>
			<td>2010-06-03</td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td>5921418</td>
			<td>벚꽃 엔딩</td>
			<td></td>
			<td>버스커 버스커</td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</tbody>
</table>
</div>
<!-- Excel 형식 끝 -->
				
			</div>
		</div>
		<!-- 메타파일 형식 탭 끝 -->
		
	</div>

<div class="container">

		<h3>파일 전송</h3>
		
<div class="bs-example bs-example-tabs">
	<ul id="myTab" class="nav nav-tabs">
		<li class="active"><a href="#fileSelf" data-toggle="tab">파일 직접 업로드</a></li>
		<li ><a href="#fileAgent" data-toggle="tab">파일 전송 클라이언트</a></li>
		<li ><a href="#fileFtp" data-toggle="tab">FTP를 이용한 파일 전송</a></li>
	</ul>
	
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade active in" id="fileSelf">
			<p></p>
			<blockquote>
				메타 파일을 직접 업로드 합니다.<br/>
				<code>.csv</code> <code>.json</code> <code>.xml</code> <code>.xls</code> <code>.zip</code> 형식의 파일만 업로드가 가능합니다.<br/>
				<code>.csv</code> <code>.json</code> <code>.xml</code> 파일의 인코딩 포맷은 UTF-8 입니다.<br/>
				<code>.zip</code> 파일로 압축해서 업로드하는 경우 파일이 디렉토리 안에 포함되지 않도록 압축하십시오.
			</blockquote>
			
<!-- The file upload form used as target for the file upload widget -->
		<form id="fileupload" action="//jquery-file-upload.appspot.com/" method="POST" enctype="multipart/form-data">
			<!-- Redirect browsers with JavaScript disabled to the origin page -->
			<noscript>
				<input type="hidden" name="redirect" value="http://blueimp.github.io/jQuery-File-Upload/">
			</noscript>
			<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
			<div class="row fileupload-buttonbar">
				<div class="col-lg-7">
					<!-- The fileinput-button span is used to style the file input field as button -->
					<span class="btn btn-success fileinput-button">
						<i class="glyphicon glyphicon-plus"></i> <span>파일 추가</span>
						<input type="file" name="files[]" multiple>
					</span>
					<button type="submit" class="btn btn-primary start">
						<i class="glyphicon glyphicon-upload"></i> <span>업로드 시작</span>
					</button>
					<button type="reset" class="btn btn-warning cancel">
						<i class="glyphicon glyphicon-ban-circle"></i> <span>취소</span>
					</button>
					<button type="button" class="btn btn-danger delete">
						<i class="glyphicon glyphicon-trash"></i> <span>삭제</span>
					</button>
					<input type="checkbox" class="toggle">
					<!-- The global file processing state -->
					<span class="fileupload-process"></span>
				</div>
				<!-- The global progress state -->
				<div class="col-lg-5 fileupload-progress fade">
					<!-- The global progress bar -->
					<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
						<div class="progress-bar progress-bar-success" style="width: 0%;"></div>
					</div>
					<!-- The extended global progress state -->
					<div class="progress-extended">&nbsp;</div>
				</div>
			</div>
			<!-- The table listing the files available for upload/download -->
			<table role="presentation" class="table table-striped">
				<tbody class="files"></tbody>
			</table>
		</form>

		<!-- The blueimp Gallery widget -->
		<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls" data-filter=":even">
			<div class="slides"></div>
			<h3 class="title"></h3>
			<a class="prev">‹</a> <a class="next">›</a> <a class="close">×</a>
			<a class="play-pause"></a>
			<ol class="indicator"></ol>
		</div>
	
	<div class="row container">
		<div class="row">
			<button type="button" class="btn btn-primary start" onclick="runMeta()">메타정보 입력</button>
		</div>
		<p></p>
		
		<div class="container" id="runFileStat"></div>
		
	</div>
	<p></p>
	
		</div>
		
		<div class="tab-pane fade" id="fileAgent">
			<p></p>
			<blockquote>
				메타가 생성되는 시스템에 클라이언트 프로그램을 설치합니다.<br/>
				지정된 경로에 메타 파일을 저장하면 클라이언트 프로그램이 주기적으로 메타 파일을 서버로 전송합니다.<br/>
				클라이언트를 실행하기 위해서는 Java 6.0 이상이 설치되어 있어야 하며 XXXX 포트를 사용합니다.<br/>
				XXXX 포트는 다른 프로세서가 사용하지 않아야 하고 외부 네트워크에서 접근 가능하도록 방화벽 설정이 필요합니다.<br/>
			</blockquote>
			<p>
			<button type="button" class="btn btn-primary">클라이언트 프로그램 다운로드</button>
			
<!-- Button trigger modal -->
<button class="btn btn-default" data-toggle="modal" data-target="#cliIntro">설치 방법 안내</button>
<!-- Modal -->
<div class="modal fade" id="cliIntro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">클라이언트 설치 방법</h4>
				
			</div>
			<div class="modal-body">
			
<ol>
	<li>프로그램을 다운로드 한다.</li>
	<li>메타 파일이 저장되는 시스템에 저장하고 압축을 푼다.</li>
	<li>유닉스의 경우 start.sh / 윈도우 서버는 start.bat 를 실행한다.</li>
</ol>
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

			</p>
		</div>
		
		<div class="tab-pane fade" id="fileFtp">
			<p>
				<blockquote>
				지정된 FTP 경로로 파일을 업로드 하면 시스템이 주기적으로 파일을 검색하여 메타시스템에 반영합니다.
				</blockquote>
			</p>
			<p>
				<div  class="col-lg-2">FTP 주소 : </div>
				<div  class="col-lg-10">ftp.candoitsoft.kr</div>
			</p>
		</div>

      </div>
    </div>
</div>

	
	<!-- The template to display files available for upload -->
	<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
{%
	var fsplit = file.name.split(".");
	var ext = fsplit[fsplit.length-1];
	if(ext=="csv"||ext=="CSV"||ext=="json"||ext=="JSON"||ext=="xml"||ext=="XML"||ext=="xls"||ext=="XLS"||ext=="zip"||ext=="ZIP"){
%}
    <tr class="template-upload fade">
        <td>
            <span class="preview"></span>
        </td>
        <td>
            <p class="name">{%=file.name%}</p>
            <strong class="error text-danger"></strong>
        </td>
        <td>
            <p class="size">Processing...</p>
            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
        </td>
        <td>
            {% if (!i && !o.options.autoUpload) { %}
                <button class="btn btn-primary start" disabled>
                    <i class="glyphicon glyphicon-upload"></i>
                    <span>업로드 시작</span>
                </button>
            {% } %}
            {% if (!i) { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>취소</span>
                </button>
            {% } %}
        </td>
    </tr>
{%
	} else { 
		alert("업로드 가능한 형식의 파일이 아닙니다.\n\n사용 가능한 파일의 확장자는\n\n.csv .json .xml .xls .zip 입니다.");
	}
%}
{% } %}
</script>
	<!-- The template to display files available for download -->
	<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        <td>
            <span class="preview">
            </span>
        </td>
        <td>
            <p class="name" name="upFileName">
                {% if (file.url) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
                {% } else { %}
                    <span id="upFileName{%=i%}">{%=file.name%}</span>
                {% } %}
            </p>
            {% if (file.error) { %}
                <div><span class="label label-danger">Error</span> {%=file.error%}</div>
            {% } %}
        </td>
        <td>
            <span class="size">{%=o.formatFileSize(file.size)%}</span>
        </td>
        <td>
            {% if (file.deleteUrl) { %}
                <button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                    <i class="glyphicon glyphicon-trash"></i>
                    <span>삭제</span>
                </button>
                <input type="checkbox" name="delete" value="1" class="toggle">
            {% } else { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>취소</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
	<script src="js/vendor/jquery.ui.widget.js"></script>
	<!-- The Templates plugin is included to render the upload/download listings -->
	<script src="http://blueimp.github.io/JavaScript-Templates/js/tmpl.min.js"></script>
	<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
	<script src="http://blueimp.github.io/JavaScript-Load-Image/js/load-image.min.js"></script>
	<!-- The Canvas to Blob plugin is included for image resizing functionality -->
	<script src="http://blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
	<!-- Bootstrap JS is not required, but included for the responsive demo navigation -->
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	<!-- blueimp Gallery script -->
	<script src="http://blueimp.github.io/Gallery/js/jquery.blueimp-gallery.min.js"></script>
	<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
	<script src="js/jquery.iframe-transport.js"></script>
	<!-- The basic File Upload plugin -->
	<script src="js/jquery.fileupload.js"></script>
	<!-- The File Upload processing plugin -->
	<script src="js/jquery.fileupload-process.js"></script>
	<!-- The File Upload image preview & resize plugin -->
	<script src="js/jquery.fileupload-image.js"></script>
	<!-- The File Upload audio preview plugin -->
	<script src="js/jquery.fileupload-audio.js"></script>
	<!-- The File Upload video preview plugin -->
	<script src="js/jquery.fileupload-video.js"></script>
	<!-- The File Upload validation plugin -->
	<script src="js/jquery.fileupload-validate.js"></script>
	<!-- The File Upload user interface plugin -->
	<script src="js/jquery.fileupload-ui.js"></script>
	<!-- The main application script -->
	<script src="js/meta_main.js"></script>
	<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE 8 and IE 9 -->
	<!--[if (gte IE 8)&(lt IE 10)]>
<script src="js/cors/jquery.xdr-transport.js"></script>
<![endif]-->

	<footer>
		<p class="copyright">
			&copy; <span class="candoit">Candoit</span><span class="soft">soft</span> 2014
		</p>
	</footer>
	
</body>
</html>

<%
	}
%>