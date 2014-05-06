<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="description" content="">
<meta name="author" content="">

<title>Candoit 회원 가입</title>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="js/signin.js"></script>

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css">
		
</head>
<body>

	<div class="container">
		<h1>회원 가입</h1>
		<h2 class="lead">아래 정보를 입력하십시오.</h2>
		
		<form role="form">
			<label for="id">사용자 아이디</label>
			<div class="row">
				<div class="form-group col-md-3">
						<input type="text" class="form-control" id="id" name="id" placeholder="아이디"  required="required" onkeyup="idBtnChg();" maxlength="12" pattern="[a-zA-Z0-9]{4,12}" >
					<p class="help-block">영문 소문자, 숫자 조합 4~12자.<br/>공백이나 특수문자는 사용하실 수 없습니다.</p>
				</div  class="form-group col-md-2">
				<div>
				<button type="button" class="btn btn-primary" id="chIdBtn" onclick="checkId();" disabled="disabled" >중복확인</button>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-3">
					<label for="passwd">비밀번호</label>
					<input type="password" class="form-control" id="passwd" name="passwd" placeholder="비밀번호"  required="required" maxlength="12" />
					<p class="help-block">12자 이내.</p>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-3">
					<label for="passwd2">비밀번호 확인</label>
					<input type="password" class="form-control" id="passwd2" name="passwd2" placeholder="비밀번호"  required="required" maxlength="12" onkeyup="chkPw();" />
					<p id="chkPw" class="help-block"></p>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-4">
					<label for="name">회사(단체)명</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="회사(단체)명" maxlength="30">
					<p class="help-block">30자 이내.</p>
				</div>
			</div>
			
			<div class="row">
				<div class="form-group col-md-4">
				<label for="type1">사용자 구분</label>
					<div class="radio">
						<label for="type1">
							<input type="radio" name="type" id="type1" value="osp" checked>온라인 서비스 공급자
						</label>
					</div>
					<div class="radio">
						<label for="type2">
							<input type="radio" name="type" id="type2" value="org" >저작권 신탁 단체
						</label>
					</div>
					<div class="radio">
						<label for="type3">
							<input type="radio" name="type" id="type3" value="gov" >유관기관
						</label>
					</div>
				</div>
			</div>
			
			<div class="row col-md-4">
				<button type="button" onclick="signin(this.form);" class="btn btn-success btn-block">회원 가입</button>
				<input type="hidden" name="cmd" />
				<input type="hidden" name="toUrl" />
			</div>
		</form>
		
	</div>
	
	<br/><br/>
	<footer>
		<p class="copyright">
			&copy; <span class="candoit">Candoit</span><span class="soft">soft</span> 2014
		</p>
	</footer>
	
</body>
</html>