<%@page
	import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" var="nowDate" />
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="mymemberone.DinnerDAO"%>


<%@ page import="mymemberone.DinnerVO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="../view/boardColor.jsp"%>
<%
// 수정 <1>
//리스트에 전체 보여줄 페이지 라이눗. 한 페이지에 10개 보여줌
int pageSize = 5;
%>
<%
/*
//<수정 2>
//페이지를 지정한 것이 없으면 기본으로 1페이지세팅
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}

//현재 페이지와 현재 페이지 시작 라인, 끝라인 계산한다.
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

int count = 0;
int number = 0;
*/
List<DinnerVO> articleList = null;
DinnerDAO dbPro = DinnerDAO.getInstance();
int count = dbPro.getArticleCount();//전체 글수
if (count > 0) {
	articleList = dbPro.getArticles();
}
//number = count;//수정<4>

//로그인 완료했는지 점검
String loginID = (String) session.getAttribute("loginID");
%>
<html>
<head>
<title>예약하기</title>
<link href="../css/board.css?ver=${nowDate}" rel="stylesheet"
	type="text/css">
	<script src="../js/main.js?ver=${nowDate}">
</script>
</head>
<body bgcolor="<%=bodyback_c%>">
	<%
	if (loginID != null) {
	%>
	<center>
		<b>예약 가능 목록(전체 :<%=count%>)
		</b>
		<%
		if (count == 0) {
		%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">남은 예약 가능일이 없습니다..</td>
		</table>


		<%
		} else {
		%>
		<form action="reservationProc.jsp" method="post">
			<table border="1" width="700" cellpadding="0" cellspacing="0"
				align="center">

				<tr height="30" bgcolor="<%=value_c%>">
					<td align="center" width="100">번 호</td>
					<td align="center" width="150">예약 일</td>
					<td align="center" width="150">예약 시간</td>
					<td align="center" width="150">타입</td>
					<td align="center" width="150">가격</td>
					<td align="center" width="100">선택</td>
				</tr>
				<%
				for (int i = 0; i < articleList.size(); i++) {
					DinnerVO article = (DinnerVO) articleList.get(i);
				%>
				<tr height="30">
					<td align="center" width="150"><%=article.getNo()%></td>
					<td align="center" width="150"><%=article.getDinnerdate()%></td>
					<td align="center" width="150"></a><%=article.getDinnertime()%></td>
					<td align="center" width="150"><%=article.getDinnertype()%></td>
					<td align="center" width="150"><%=article.getPrice()%></td>
					<td align="center" width="100"><input type="checkbox"
						name="reservation" value="<%= article.getNo() %>"></td>
				</tr>
				<%
				}
				%>
			</table>
			<div style="text-align: center; margin-top: 20px;">
				<input type="submit" value="예약하기">
			</div>
		</form>
		<%
		}
		%>
		</center>
		<%
		}else{
		%>
		<p>먼저 로그인을 해주세요.</p>
<!-- 		<input type="button" value="로그인 하기" onclick="login()"> -->
		<%
		}
		%>
</body>
</html>