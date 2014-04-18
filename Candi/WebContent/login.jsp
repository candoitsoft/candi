<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<title>로그인</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/signin.css">

</head>

<body>

	<div class="container">

		<form class="form-signin" name="loginForm">
			<h2 class="form-signin-heading">로그인 하십시오</h2>
			<input type="text" id="id" name="id" class="form-control" placeholder="ID" />
			<input type="password" id="passwd" name="passwd" class="form-control" placeholder="Password" />
<!-- 
        <label class="checkbox">
          <input type="checkbox" value="remember-me"> 자동 로그인
        </label>
 -->
 			<input type="hidden" name="cmd" />
			<input type="hidden" name="toUrl" />
			<button class="btn btn-lg btn-primary btn-block" type="button" onclick="login(this.form);">로그인</button>
			<a class="btn btn-lg btn-success btn-block" href="signin.jsp" >회원가입</a>
		</form>
	</div>

<script type="text/javascript">

function login(frm) {
	if (frm.id.value == "") {
		alert("아이디를 입력하세요.");
		return false;
	}
	if (frm.passwd.value == "") {
		alert("비밀번호를 입력하세요.");
		return false;
	}
	frm.cmd.value="login";
	frm.toUrl.value="main.jsp";
	frm.action="Confirm";
	frm.submit();
}

</script>

	<nav class="navbar navbar-default navbar-fixed-bottom">
		<footer>
			<p class="copyright">
				&copy; <span class="candoit">Candoit</span><span class="soft">soft</span> 2014
			</p>
		</footer>
	</nav>

</body>

</html>