<%@page
	import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="mymemberone.PerformanceDAO"%>
<%@ page import="mymemberone.PerformanceVO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
int pageSize = 5;
%>
<%
List<PerformanceVO> articleList = null;
PerformanceDAO dbPro = PerformanceDAO.getInstance();
int count = dbPro.getArticleCount("ALL");//전체 글수
if (count > 0) {
	articleList = dbPro.getArticles("ALL");
}
%>
<html>
<head>
<title>상영 공연</title>
<link href="../css/performancelist.css?ver=${nowDate}" rel="stylesheet"
	type="text/css">
<%-- 	<script src="../js/main.js?ver=${nowDate}"> --%>
</script>
</head>
<body>
	<center>
		<b>공연 목록 목록(전체 :<%=count%>)
		</b>
		<%
		if (count == 0) {
		%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">예매 가능한 공연이 없습니다..</td>
		</table>


		<%
		} else {
		%>
<!-- 		<form action="reservationProc.jsp" method="post"> -->
			<table border="1" width="700" cellpadding="0" cellspacing="0"
				align="center">

				<tr height="30">
					<td align="center" width="300">공연명</td>
					<td align="center" width="150">장르</td>
					<td align="center" width="150">공연일</td>
					<td align="center" width="250">공연장</td>
					<td align="center" width="150">시청연령</td>
					<td align="center" width="150">남은 좌석</td>
<!-- 					<td align="center" width="100">선택</td> -->
				</tr>
				<%
				for (int i = 0; i < articleList.size(); i++) {
					PerformanceVO article = (PerformanceVO) articleList.get(i);
				%>
				<tr height="30">
					<td align="center" width="300">
						<a href="./performance/selectSeat.jsp?performanceId=<%= article.getPerformanceId() %>">
							<%=article.getPerformanceName()%>
						</a>
					</td>
					<td align="center" width="150"><%=article.getGenre()%></td>
					<td align="center" width="150"><%=article.getDayOfPerformance()%></td>
					<td align="center" width="250"><%=article.getVenue()%></td>
					<td align="center" width="150"><%=article.getLimitAge()%></td>
					<td align="center" width="150"><%=article.getTotalSeats()-article.getSoldSeats()%>/<%= article.getTotalSeats()%></td>
					<%-- <td align="center" width="100">
					<input type="checkbox" name="reservation" value="<%= article.getPerformanceId() %>">
						</td> --%>
				</tr>
				<%
				}
				%>
			</table>
			<div style="text-align: center; margin-top: 20px;">
				<input type="submit" value="예약하기">
			</div>
<!-- 		</form> -->
		<%
		}
		%>
		</center>
<%-- 		<%
		}else{
		%> --%>
<!-- 		<p>먼저 로그인을 해주세요.</p>
	 		<input type="button" value="로그인 하기" onclick="login()"> -->

</body>
</html>