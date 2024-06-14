<%@page import="mymemberone.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
UserDAO dao = UserDAO.getInstance();
String userId = request.getParameter("userId");
String userPw = request.getParameter("userPw");

int check = dao.loginCheck(userId, userPw);
String message="아이디가 존재하지 않습니다.";
//로그인 성공 세션 등록
if (check == 1) {//로그인 성공

	session.setAttribute("loginID", userId);
	response.sendRedirect("login.jsp");
} else if (check == 0) {//아이디는 있는데 비밀번호 오류
	message="비밀번호가 틀렸습니다.";
}
%>
<script>
	alert("<%= message %>");
	history.go(-1);

</script>