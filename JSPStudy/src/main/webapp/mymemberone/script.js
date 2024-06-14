//아이디 체크 함수
function idCheck(userId) {
	if (userId == "") {
		alert("아이디를 입력해 주세요.");
		document.member.userId.focus();
	} else {
		url = "idCheck.jsp?userId=" + userId;
		window.open(url, "post", "width=300,height=150");
	}
}

