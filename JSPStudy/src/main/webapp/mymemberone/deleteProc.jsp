<%@page import="mymemberone.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
UserDAO dao = UserDAO.getInstance();
String userId = (String) session.getAttribute("loginID");
String userPw = request.getParameter("userPw");
int check = dao.deleteMember(userId, userPw);
if (check == 1) {
	session.invalidate();
%>
<html>
<head>
<title>회원탈퇴</title>
</head>
<meta http-equiv="Refresh" content="3;url=login.jsp">
<body>
	<center>
		<font size="5" face="바탕체"> 회원정보가 삭제되었습니다<br></br> 안녕히 가세요 ! ᅲ.ᅲ<br></br>
			3초후에 로그인 페이지로 이동합니다
		</font>
	</center>
</body>
</html>
<%
} else { //삭제 실패시
%>
<script>
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
</script>
<%
}
%>
</body>
</html>