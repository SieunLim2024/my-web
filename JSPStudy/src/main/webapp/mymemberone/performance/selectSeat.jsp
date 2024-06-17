<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="mymemberone.SeatDAO"%>
<%@ page import="mymemberone.SeatVO"%>
<% 
//로그인 완료했는지 점검
String loginID = (String) session.getAttribute("loginID");

Date now = new Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
String formatedNow = formatter.format(now);
%>
<%
List<SeatVO> articleList = null;
SeatDAO dbProc = SeatDAO.getInstance();
// URL 쿼리 매개변수에서 performanceId 값을 가져옴
String performanceId = request.getParameter("performanceId");
int totalSeats= Integer.parseInt(request.getParameter("totalSeats"));
int xseats= Integer.parseInt(request.getParameter("xseats"));
int yseats= Integer.parseInt(request.getParameter("yseats"));
int cnt=0;
articleList= dbProc.getArticles(performanceId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택</title>
<link rel="stylesheet" href="../css/selectSeat.css?ver=<%=formatedNow%>">
</head>
<body>
<%
	if (loginID != null) {
	%>
<p align="center">좌석 배치도</p>

<form action="seatProc.jsp?performanceId=<%= performanceId %>" method="post">
<p>&nbsp;&nbsp;
	<% for(char c='A'; c<('A'+xseats); c++){ %>
		<%= c %>&nbsp;
	<%} %>
</p>
<% for(int i=1; i<=yseats;i++){ %>
	<%= i %>
	<% for(char c='A'; c<('A'+xseats); c++){ 	
			if(cnt>=totalSeats){%>
				&nbsp;&nbsp;&nbsp;
		<% }else{
				if(articleList.get(cnt).getState().trim().equals("Y")){
		%>
					<input type="checkbox" name="seat" value="<%= c %>-<%= i %>" checked="checked" disabled>
				<%cnt++;
				}else{%>
				<input type="checkbox" name="seat" value="<%= c %>-<%= i %>" >
					
				<% cnt++;
				}
			}
		}%>
		<br>
<%	}%>
<div class="submit-button">
      <button type="submit">예매 하기</button>
      
</div>
</form>
<%}else{ %>
<p>먼저 로그인을 해주세요.</p>
<% } %>
</body>
</html>