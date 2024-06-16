<%@ page import="mymemberone.PerformanceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="vo" class="mymemberone.PerformanceVO" scope="page">
	<jsp:setProperty name="vo" property="*" />
</jsp:useBean>
<%
PerformanceDAO dao = PerformanceDAO.getInstance();
int value = dao.insertArticle(vo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
if (value == 0) {
%>
<meta http-equiv="Refresh" content="0;url=registerPerformanceForm.jsp">
<%
System.out.println("성공");
} else {
System.out.println("실패");
}
%>
<body>

</body>
</html>