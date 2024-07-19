<%@page import="mymemberone.*"%>
<%@page import="jdbc.DBPoolUtil2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
CartDAO dao = CartDAO.getInstance();
String userId = (String) session.getAttribute("loginID");
int cnt = 0;
String[] SelectNum = request.getParameterValues("seat");

//URL 쿼리 매개변수에서 performanceId 값을 가져옴
String performanceId = request.getParameter("performanceId");

if (SelectNum != null) {
	for (String data : SelectNum) {
		int rs = dao.insertArticle(performanceId, userId, data);
		if (rs > 0) {
	cnt++;
		}
		;
	}
} else {
	out.println("좌석을 선택해주세요");
}
%>
<meta http-equiv="Refresh"
	content="0;url=cartList.jsp">
