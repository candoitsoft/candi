
var confVal = {
	"id" : "Y",
	"pw" : "N",
};

// ID 확인 버튼 활성
function idBtnChg() {
	if ($("#id").val().length > 3) {
		$("#chIdBtn").removeAttr("disabled");
	} else {
		$("#chIdBtn").attr("disabled", "disabled");
	}
	confVal.id = "N";
}

// ID 중복 확인
function checkId() {
	var tId = $("#id").val();
	$.ajax({
		type : "GET",
		data : "cmd=checkId&id=" + tId,
		url : "CandiAjax",
		success : function(data) {
			console.log(data);
			if (data == "OK") {
				alert("사용 가능한 아이디 입니다.");
				confVal.id = "Y";
			} else {
				alert("사용할 수 없는 아이디 입니다.");
				confVal.id = "N";
			}
		}
	});
}

// PW 확인
function chkPw() {
	if ($("#passwd").val().length == 0) {
		$("#chkPw").text("비밀번호를 입력하세요.");
	} else {
		if ($("#passwd2").val() == $("#passwd").val()) {
			$("#chkPw").text("비밀번호가 일치합니다.");
			$("#chkPw").attr("class", "text-primary");
			
			confVal.pw = "Y";
		} else {
			$("#chkPw").text("비밀번호가 일치하지 않습니다.");
			$("#chkPw").attr("class", "text-danger");
			confVal.pw = "N";
		}
	}
}

function signin(frm) {
	if(confVal.id == "Y" && confVal.pw == "Y"){
		if(confirm("입력하신 정보로 가입하시겠습니까?")){
			frm.cmd.value="insert";
			frm.toUrl.value="main.jsp";
			frm.action="Confirm";
			frm.submit();
		}
	} else if(confVal.id == "N"){
		alert("아이디 중복 확인이 되지 않았습니다.\n아이디 중복을 확인하십시오.");
	} else if(confVal.pw == "N"){
		alert("비밀번호가 일치하지 않습니다.\n비밀번호를 확인하십시오.");
	}
}
