<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--@ page import="candoop.com.ConfigObj"--%>
<!DOCTYPE html>
<html lang="ko">
<%
	//	String id = (String) session.getAttribute("cdpId");
	//	ConfigObj clObj = (ConfigObj) session.getAttribute("cdpObj");
	if (false) {
		//	if (id == null || id.equals("") || clObj == null) {
%>
<head>
<script>
	alert("로그인 후 이용 해 주시기 바랍니다.");
	location.href = "index.jsp";
</script>
</head>
<%
	} else {
%>
<head>
<meta charset="utf-8">

<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

<title>Candi</title>
<meta name="description" content="">
<meta name="author" content="Candoitsoft">
<meta name="viewport" content="width=device-width; initial-scale=1.0">

<!-- Replace favicon.ico & apple-touch-icon.png in the root of your domain and delete these references -->
<link rel="shortcut icon" href="/favicon.ico">
<link rel="apple-touch-icon" href="/apple-touch-icon.png">

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width">

<link rel="stylesheet" href="css/bootstrap.light.min.css" title="Light">
<link rel="stylesheet" href="css/timepicker.css">
<link rel="stylesheet" href="css/animate.min.css">
<link rel="stylesheet" href="css/normalize.min.css">
<link rel="stylesheet" href="css/candi.css">
<!-- load the root require context -->
<script src="vendor/require/require.js"></script>
<script src="app/components/require.config.js"></script>
<script>
	require([ 'app' ], function() {
	});
</script>
<style>

</style>

</head>

<body ng-cloak>
	<div class="wrapper">
		<section id="kibanaMain">
    <link rel="stylesheet" ng-href="css/bootstrap.{{dashboard.current.style||'dark'}}.min.css">
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    
    <div class="navbar navbar-static-top">
      <div class="navbar-inner">
      
        <div class="container-fluid">
          <span class="brand">Candi</span>
            <ul id="topMenu" class="tNav pull-left">
					<li><a href="main.jsp">로그 설정</a></li>
					<li><a href="main1.jsp">계정 관리</a></li>
					<li><a href="main2.jsp">로그 모니터</a></li>
					<li><a href="main3.jsp#/dashboard/elasticsearch/Neowiz" >분석 보고서</a></li>
				</ul>
        </div>
      </div>
    </div>

		
		</section>

	</div>
	<footer>
		<p class="copyright">
			&copy; <span class="candoit">Candoit</span><span class="soft">soft</span>
			2013
		</p>
	</footer>
</body>

<%
	}
%>
</html>