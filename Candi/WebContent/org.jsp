<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="candi.com.CandiUserObj, candi.com.CandiMsg, candi.com.CandiDao, jm.net.DataEntity;"%>
<%
	//사용자 로그인 체크하는 로직. 모든 페이지에 반드시 포함할것.
	String id = (String) session.getAttribute("candiId");
	CandiUserObj userObj = (CandiUserObj) session.getAttribute("candiUserObj");
	if (id == null || id.equals("") || userObj == null) {
		//로그인 오류시 login.jsp 페이지로 이동.
		out.print(CandiMsg.loginError());
	} else {
		CandiDao dao = CandiDao.getInstance();
		DataEntity[] ospList = dao.getOspList(); 
		
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
				<li class="active"><a href="#">업체별 데이터 분석</a></li>
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
	<ul id="orgTab" class="nav nav-tabs">
		<li class="active"><a href="#totalOsp" data-toggle="tab">전체 사업자</a></li>
<% for(int os=0; os< ospList.length; os++){ %>
		<li ><a href="#<%=ospList[os].get("id") %>" data-toggle="tab"><%=ospList[os].get("name") %></a></li>
<% } %>		
	</ul>
	<div id="myTabContent" class="tab-content">
	
		<div class="tab-pane fade active in" id="totalOsp">			
			<iframe width="100%" height="2500px" scrolling=no frameborder=0 src="osp_today.jsp#/dashboard/elasticsearch/<%=id %>">
			</iframe>
		</div>
		
<% for(int os=0; os< ospList.length; os++){ %>
		<div class="tab-pane fade" id="<%=ospList[os].get("id") %>">			
			<iframe width="100%" height="2400px" scrolling=no frameborder=0 src="osp_today.jsp#/dashboard/elasticsearch/<%=ospList[os].get("id")%>_pub">
			</iframe>
		</div>
<% } %>

	</div>
</div>
<!-- 
<script>
var todayFrObj = document.getElementById("today_frame");
window.setInterval(function(){
	todayFrObj.height = todayFrObj.contentDocument.body.offsetHeight;
	},1000);
</script>
 -->
 
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