function logout() {
	var frm = document.getElementById("navFrm");
	frm.cmd.value="logout";
	frm.action="Confirm";
	frm.submit();
}