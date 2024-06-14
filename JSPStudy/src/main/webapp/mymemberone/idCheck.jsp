<%@page import="mymemberone.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
UserDAO dao = UserDAO.getInstance();
String userId = request.getParameter("userId");
boolean check = dao.idCheck(userId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복 체크 </title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>
<body>
<br>
<center>
<b><%=userId%></b>
<%
if(check){
out.println("는 이미 존재하는 ID입니다.<br></br>");
}else{
out.println("는 사용 가능 합니다.<br></br>");
}
%>
<a href="#" onClick="javascript:self.close()">닫기</a>
</center>
</body>
</html>