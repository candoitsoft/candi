<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="candi.com.CandiUserObj, candi.com.CandiMsg"%>
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
<title>파일 업로드</title>
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
	olHideObj();
	setLogPopover();
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
				<li class="active"><a href="#">로그데이터 입력</a></li>
				<li class=""><a href="metaUpload.jsp">메타데이터 입력</a></li>
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
		<h1>로그데이터 입력</h1>
		
		<blockquote>
			입력할 로그 파일에 다음의 필드들은 필수로 존재해야 합니다.<br/>
			마우스를 필드명에 가져다 대면 자세한 설명이 나타납니다.<br/>
			<p>
				<button id="btnFldUci" type="button" class="btn btn-info btn-xs"">uci</button>
				<button id="btnFldCid" type="button" class="btn btn-danger btn-xs">cid</button>
				<button id="btnFldSvcod" type="button" class="btn btn-danger btn-xs">svcod</button>
				<button id="btnFldStime" type="button" class="btn btn-danger btn-xs">stime</button>
				<button id="btnFldAsp" type="button" class="btn btn-info btn-xs">asp</button>
			</p>
			붉은색으로 표시된
			<button type="button" class="btn btn-danger btn-xs">cid</button>,
			<button type="button" class="btn btn-danger btn-xs">svcod</button>,
			<button type="button" class="btn btn-danger btn-xs">stime</button>
			필드들은 값에 null(공백)을 허용하지 않습니다. 반드시 값이 존재해야 합니다.<br/>
			필드의 값이 존재하지 않는 경우에도 공백값을 넣고 구분자로 구분해야 합니다.<br/>
			필수 필드 외에 사용자정의 필드 추가가 가능합니다.
		</blockquote>
		
		<h3>로그파일 형식 선택</h3>
		<div  class="col-lg-3">
			<label class="radio-inline"> <input type="radio" onclick="checkDatatype()"
				name="srcType" id="rdCsv" value="csv" checked="checked"> CSV
			</label> <label class="radio-inline"> <input type="radio" onclick="checkDatatype()"
				name="srcType" id="rdJson" value="json"> JSON
			</label> <label class="radio-inline"> <input type="radio" onclick="checkDatatype()"
				name="srcType" id="rdXml" value="xml"> XML
			</label> <label class="radio-inline"> <input type="radio" onclick="checkDatatype()"
				name="srcType" id="rdExcel" value="excel"> Excel
			</label> 
		</div>
		
		<div  class="col-lg-9">
			<form class="form-horizontal" role="form">
				<div class="form-group">
					<label for="addData" class="col-lg-2 control-label">필드 추가</label>
					<div class="col-lg-3">
						<input type="text" class="form-control" id="addData" placeholder="필드명" onkeypress="enterData(this,event);">
					</div>
					<div class="col-lg-4">
					<button id="btnAddData" type="button" class="btn btn-success" onclick="insertField();">추가</button>
					<button type="button" class="btn btn-danger" onclick="clearField();">초기화</button>
					</div>
				</div>
			</form>
		</div>
		
			<div  id="showCSV" class="container row">
<h4>CSV 입력 규칙</h4>
<blockquote>
	각 열(column)들은 따옴표(") 로 감싸서 입력하고 구분자는 쉼표(,) 입니다.<br/>
	값이 비어있는 열도 빈 따옴표 ("") 로 입력해서 자리를 맞춥니다.<br/>
	하나의 행(row)은 한 줄에 입력되고 새로운 행은 줄바꿈해야 합니다.<br/>
	입력될 데이터 이외에 제목 등의 기타 정보는 일체 없어야 합니다.
</blockquote>
<pre id="preCsv">
<span id="fieldsCsv1">"uci-val-1","cid-val-1","svcod-val-1","stime-val-1","asp-val-1"</span>
<span id="fieldsCsv2">"uci-val-2","cid-val-2","svcod-val-2","stime-val-2","asp-val-2"</span>
</pre>
<h4>실제 입력 예</h4>
<pre>
"i500-JP13072061.1200651160-1","3481070","25026","2014-04-28T01:12:15","(주)카카오"
"i500-US13013671.1200121916-1","10429203","25012","2014-04-28T17:27:49",""
"","80062835","25012","20140428-17:34:16",""
</pre>
			</div>
			
			<div  id="showJSON" class="container row">
<h4>입력 규칙</h4>
<pre id="preJson">{
<span id="fieldsJson1">	"uci" : "uci-val-1",
	"cid" : "cid-val-1",
	"svcod" : "svcod-val-1",
	"stime" : "stime-val-1",
	"asp" : "asp-val-1"</span>
}
{
<span id="fieldsJson2">	"uci" : "uci-val-2",
	"cid" : "cid-val-2",
	"svcod" : "svcod-val-2",
	"stime" : "stime-val-2",
	"asp" : "asp-val-2"</span>
}
</pre>
<h4>실제 입력 예</h4>
<pre id="preJson">
[
{"uci":"i500-JP13072061.1200651160-1","cid":"3481070","svcod":"25026","stime":"2014-04-28T01:12:15","asp":"(주)카카오"},
{"uci":"i500-US13013671.1200121916-1","cid":"10429203","svcod":"25012","stime":"2014-04-28T17:27:49","asp":""},
{"uci":"","cid":"80062835","svcod":"25012","stime":"20140428-17:34:16","asp":""}
]
</pre>
			</div>
			
			<div id="showXML" class="container row">
<h4>입력 규칙</h4>			
<pre id="preXml">
&lt;log&gt;<span id="fieldsXml1">
	&lt;uci&gt; uci-val-1 &lt;/uci&gt;
	&lt;cid&gt; cid-val-1 &lt;cid&gt;
	&lt;svcod&gt; svcod-val-1 &lt;svcode&gt;
	&lt;stime&gt; stime-val-1 &lt;stime&gt;
	&lt;asp&gt; asp-val-1 &lt;asp&gt;
</span>&lt;/log&gt;
&lt;log&gt;<span id="fieldsXml2">
	&lt;uci&gt; uci-val-2 &lt;/uci&gt;
	&lt;cid&gt; cid-val-2 &lt;cid&gt;
	&lt;svcod&gt; svcod-val-2 &lt;svcode&gt;
	&lt;stime&gt; stime-val-2 &lt;stime&gt;
	&lt;asp&gt; asp-val-2 &lt;asp&gt;
</span>&lt;/log&gt;
</pre>
			</div>
			
			<div id="showExcel" class="container row">
<h4>입력 규칙</h4>
<table id="fieldsExcel" class="table table-bordered">
	<thead>
		<tr id="xlHead" class="active">
			<th>uci</th>
			<th>cid</th>
			<th>svcod</th>
			<th>stime</th>
			<th>asp</th>
		</tr>
	</thead>
	<tbody>
		<tr id="xlBody1">
			<td>uci-val-1</td>
			<td>cid-val-1</td>
			<td>svcod-val-1</td>
			<td>stime-val-1</td>
			<td>asp-val-1</td>
		</tr>
		<tr id="xlBody2">
			<td>uci-val-2</td>
			<td>cid-val-2</td>
			<td>svcod-val-2</td>
			<td>stime-val-2</td>
			<td>asp-val-2</td>
		</tr>
	</tbody>
</table>
			</div>
			
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
			<p>
				<blockquote>로그 파일을 직접 업로드 합니다.</blockquote>
		
<!-- The file upload form used as target for the file upload widget -->
		<form id="fileupload" action="//jquery-file-upload.appspot.com/"
			method="POST" enctype="multipart/form-data">
			<!-- Redirect browsers with JavaScript disabled to the origin page -->
			<noscript>
				<input type="hidden" name="redirect"
					value="http://blueimp.github.io/jQuery-File-Upload/">
			</noscript>
			<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
			<div class="row fileupload-buttonbar">
				<div class="col-lg-7">
					<!-- The fileinput-button span is used to style the file input field as button -->
					<span class="btn btn-success fileinput-button"> <i
						class="glyphicon glyphicon-plus"></i> <span>Add files...</span> <input
						type="file" name="files[]" multiple>
					</span>
					<button type="submit" class="btn btn-primary start">
						<i class="glyphicon glyphicon-upload"></i> <span>Start
							upload</span>
					</button>
					<button type="reset" class="btn btn-warning cancel">
						<i class="glyphicon glyphicon-ban-circle"></i> <span>Cancel
							upload</span>
					</button>
					<button type="button" class="btn btn-danger delete">
						<i class="glyphicon glyphicon-trash"></i> <span>Delete</span>
					</button>
					<input type="checkbox" class="toggle">
					<!-- The global file processing state -->
					<span class="fileupload-process"></span>
				</div>
				<!-- The global progress state -->
				<div class="col-lg-5 fileupload-progress fade">
					<!-- The global progress bar -->
					<div class="progress progress-striped active" role="progressbar"
						aria-valuemin="0" aria-valuemax="100">
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
		<div id="blueimp-gallery"
			class="blueimp-gallery blueimp-gallery-controls" data-filter=":even">
			<div class="slides"></div>
			<h3 class="title"></h3>
			<a class="prev">‹</a> <a class="next">›</a> <a class="close">×</a> <a
				class="play-pause"></a>
			<ol class="indicator"></ol>
		</div>
	
	<button type="button" class="btn btn-primary start">로그 입력 시작</button>
	
			</p>
		</div>
		
		<div class="tab-pane fade" id="fileAgent">
			<p>
				<blockquote>
				로그가 생성되는 시스템에 클라이언트 프로그램을 설치합니다.<br/>
				지정된 경로에 로그 파일을 저장하면 클라이언트 프로그램이 주기적으로 로그 파일을 서버로 전송합니다.<br/>
				클라이언트를 실행하기 위해서는 Java 6.0 이상이 설치되어 있어야 하며 XXXX 포트를 사용합니다.<br/>
				XXXX 포트는 다른 프로세서가 사용하지 않아야 하고 외부 네트워크에서 접근 가능하도록 방화벽 설정이 필요합니다.<br/>
				</blockquote>
			</p>
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
	<li>로그 파일이 저장되는 시스템에 저장하고 압축을 푼다.</li>
	<li>유닉스의 경우 start.sh / 윈도우 서버는 start.bat 를 실행한다.</li>
</ol>
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
			
		</div>
		
		<div class="tab-pane fade" id="fileFtp">
			<p>
				<blockquote>
				지정된 FTP 경로로 파일을 업로드 하면 시스템이 주기적으로 파일을 검색하여 로그시스템에 반영합니다.
				</blockquote>
			</p>
			<div  class="col-lg-2">FTP 주소 : </div>
				<div  class="col-lg-10">ftp.candoitsoft.kr</div>
		</div>

      </div>
    </div>
</div>

	
	<!-- The template to display files available for upload -->
	<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
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
                    <span>Start</span>
                </button>
            {% } %}
            {% if (!i) { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
	<!-- The template to display files available for download -->
	<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        <td>
            <span class="preview">
                {% if (file.thumbnailUrl) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
                {% } %}
            </span>
        </td>
        <td>
            <p class="name">
                {% if (file.url) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
                {% } else { %}
                    <span>{%=file.name%}</span>
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
                    <span>Delete</span>
                </button>
                <input type="checkbox" name="delete" value="1" class="toggle">
            {% } else { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
	<script src="js/vendor/jquery.ui.widget.js"></script>
	<!-- The Templates plugin is included to render the upload/download listings -->
	<script
		src="http://blueimp.github.io/JavaScript-Templates/js/tmpl.min.js"></script>
	<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
	<script
		src="http://blueimp.github.io/JavaScript-Load-Image/js/load-image.min.js"></script>
	<!-- The Canvas to Blob plugin is included for image resizing functionality -->
	<script
		src="http://blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
	<!-- Bootstrap JS is not required, but included for the responsive demo navigation -->
	<script
		src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	<!-- blueimp Gallery script -->
	<script
		src="http://blueimp.github.io/Gallery/js/jquery.blueimp-gallery.min.js"></script>
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
	<script src="js/log_main.js"></script>
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