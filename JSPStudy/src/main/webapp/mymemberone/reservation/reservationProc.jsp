<%@page import="mymemberone.*"%>
<%@page import="jdbc.DBPoolUtil2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
ReservationDAO dao = ReservationDAO.getInstance();
String userId = (String) session.getAttribute("loginID");
int cnt = 0;
String[] SelectNos = request.getParameterValues("reservation");

if (SelectNos != null) {
	for (String data : SelectNos) {
		int rs = dao.reservationInsert(Integer.parseInt(data), userId);
		if (rs > 0) {
	cnt++;
		}
		;
	}
} else {
	out.println("1개 이상 선택해야 예약이 가능합니다.");
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