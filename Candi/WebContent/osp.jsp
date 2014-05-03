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
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=userObj.getName()%> 대시보드</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css">

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/candoit.js"></script>
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
				<li class="active"><a href="#">데이터 분석</a></li>
				<li class=""><a href="logUpload.jsp">로그데이터 입력</a></li>
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
	
		
<div class="">
	<ul id="ospTab" class="nav nav-tabs">
		<li class="active"><a href="#today" data-toggle="tab">실시간 데이터 분석</a></li>
		<li ><a href="#past" data-toggle="tab">지난 데이터 통계</a></li>
	</ul>
	<div id="myTabContent" class="tab-content">
	
		<div class="tab-pane fade active in" id="today">
			
<iframe id="today_frame" width="100%" scrolling=no frameborder=0 src="osp_today.jsp#/dashboard/elasticsearch/Neowiz">
</iframe>
<script>

//kibana iframe 화면 크기 계산해서 1초마다 다시 그려주는 메서드.. 
var todayFrObj = document.getElementById("today_frame");
window.setInterval(function(){
	todayFrObj.height = todayFrObj.contentDocument.body.offsetHeight;
	},1000);
</script>
			
		</div>
		
		<div class="tab-pane fade" id="past">
			
<div class="container">


	<h3>월별 요약 통계</h3>
<div class="row">
	<div class="col-md-8">
	
<table class="table table-striped">
	<thead>
		<tr>
			<th>날짜</th>
			<th>전체 Hit 수</th>
			<th>일 평균 hit 수</th>
			<th>전월 대비 hit 수</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>2014-1</th>
			<td>33124121</td>
			<td>42342</td>
			<td>+13123</td>
		</tr>
		<tr>
			<th>2014-2</th>
			<td>33211221</td>
			<td>42542</td>
			<td>-1323</td>
		</tr>
		<tr>
			<th>2014-3</th>
			<td>34331121</td>
			<td>421342</td>
			<td>+13123</td>
		</tr>
	</tbody>
</table>

	</div>
</div>

<br/>
	<h3>일별 요약 통계</h3>
<div class="row">
	<div class="col-md-8">
	
<table class="table table-striped">
	<thead>
		<tr>
			<th>날짜</th>
			<th>전체 Hit 수</th>
			<th>일 평균 hit 수</th>
			<th>전일 대비 hit 수</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>2014-3-1</th>
			<td>334121</td>
			<td>442</td>
			<td>+123</td>
		</tr>
		<tr>
			<th>2014-3-2</th>
			<td>332121</td>
			<td>422</td>
			<td>-13</td>
		</tr>
		<tr>
			<th>2014-3-3</th>
			<td>343311</td>
			<td>4212</td>
			<td>+123</td>
		</tr>
	</tbody>
</table>

	</div>
</div>


<br/>	
	<h3>서비스별 요약 통계</h3>
	
<div class="row">
	<div class="col-md-8">
	
<table class="table table-striped">
	<thead>
		<tr>
			<th>서비스 코드</th>
			<th>전체 Hit 수</th>
			<th>일 평균 hit 수</th>
			<th>전일 대비 hit 수</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>SC00001</th>
			<td>33124121</td>
			<td>42342</td>
			<td>+13123</td>
		</tr>
		<tr>
			<th>SC00002</th>
			<td>33211221</td>
			<td>42542</td>
			<td>-1323</td>
		</tr>
		<tr>
			<th>SC00003</th>
			<td>34331121</td>
			<td>421342</td>
			<td>+13123</td>
		</tr>
	</tbody>
</table>

	
	
</div>
			
		</div>
		
	</div>
</div>

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