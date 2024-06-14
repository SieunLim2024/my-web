<%@page import="mymemberone.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="vo" class="mymemberone.UserVO"/>
<jsp:setProperty name="vo" property="*" />
<%
	UserDAO dao = UserDAO.getInstance();
	boolean flag = dao.memberInsert(vo);
%>
<html>
<head>
<title>회원가입 확인</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body bgcolor="#FFFFCC">
	<br></br>
	<center>
		<%
		if (flag) {
			out.println("<b>회원가입을 축하 드립니다.</b><br/>");
			out.println("<a href=login.jsp>로그인</a>");
		} else {
			out.println("<b>다시 입력하여 주십시오.</b><br/>");
			out.println("<a href=member.jsp>다시 가입</a>");
		}
		%>
	</center>
</body>
</html>