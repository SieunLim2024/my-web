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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 확인</title>
</head>
<body>
	<p><%=cnt%>개의 예약을 추가 했습니다.
	</p>
	<div style="text-align: center; margin-top: 20px;">
		<input type="button" value="뒤로가기"
			onclick="window.location='reservationForm.jsp'"> 
		<input
			type="button" value="예약확인하기"
			onclick="window.location='reservationList.jsp'">
	</div>
</body>
</html>