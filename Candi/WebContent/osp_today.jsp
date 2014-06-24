<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="candi.com.CandiUserObj,candi.com.CandiMsg"%>
<%
	//사용자 로그인 체크하는 로직. 모든 페이지에 반드시 포함할것.
	String id_sub = (String) session.getAttribute("candiId");
	CandiUserObj userObj_sub = (CandiUserObj) session.getAttribute("candiUserObj");
	if (id_sub == null || id_sub.equals("") || userObj_sub == null) {
		//로그인 오류시 login.jsp 페이지로 이동.
		out.print(CandiMsg.loginError());
	} else {
%>
<%-- Kibana 페이지에서 복사. osp.jsp 에 include. --%>

<!DOCTYPE html>
<html lang="ko">

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
<link rel="stylesheet" href="css/kibana.css">

<!-- load the root require context -->
<script src="vendor/require/require.js"></script>
<script src="app/components/require.config.js"></script>
<script>
	require([ 'app' ], function() {
	});
	
/*
	$scope.$on('$viewContentLoaded', function() {
		alert("1231231");
	});
*/

</script>
<style>

</style>

</head>

<body ng-cloak>
	<div class="wrapper">
		<section id="kibanaMain">
		
    <!--<link rel="stylesheet" ng-href="css/bootstrap.{{dashboard.current.style||'dark'}}.min.css">-->
    <link rel="stylesheet" ng-href="css/bootstrap.{{dashboard.current.style||'dark'}}.min.css">
    <link rel="stylesheet" href="css/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">

    <div ng-repeat='alert in dashAlerts.list' class="alert-{{alert.severity}} dashboard-notice" ng-show="$last">
      <button type="button" class="close" ng-click="dashAlerts.clear(alert)" style="padding-right:50px">&times;</button>
      <strong>{{alert.title}}</strong>
      <span ng-bind-html='alert.text'></span>
      <div style="padding-right:10px" class='pull-right small'> {{$index + 1}} alert(s) </div>
    </div>
    
    <div ng-view></div>
		</section>
	</div>

</body>
</html>

<%
	}
%>