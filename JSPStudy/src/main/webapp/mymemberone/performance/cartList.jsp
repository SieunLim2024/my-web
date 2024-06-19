<%@page import="jakarta.websocket.Session"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@ page import="mymemberone.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" var="nowDate" />
<%
String userId = (String) session.getAttribute("loginID");
List<HashMap> articleList = null;
CartDAO dbPro = CartDAO.getInstance();
articleList = dbPro.selectArticle(userId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 보기</title>
<link href="../css/cartlist.css?ver=${nowDate}" rel="stylesheet"
	type="text/css">
<script src="../js/cartList.js?ver=${nowDate}"></script>
</head>
<body>
	<%
	System.out.println(articleList.size()+userId);
/* 	if (userId!=null&&articleList.size() > 0) { */
	%>
	<form id="cartForm" method="post">
		<table border="1" width="700" cellpadding="0" cellspacing="0"
			align="center">

			<tr height="30">
				<td align="center" width="300">공연명</td>
				<td align="center" width="150">장르</td>
				<td align="center" width="150">공연일</td>
				<td align="center" width="250">공연장</td>
				<td align="center" width="150">좌석 번호</td>
				<td align="center" width="100">선택</td>
			</tr>
			<%
			for (int i = 0; i < articleList.size(); i++) {
				HashMap<String, String> map = (HashMap<String, String>) articleList.get(i);
			%>
			<tr height="30">
				<td align="center" width="300"><%=map.get("performanceName")%></td>
				<td align="center" width="150"><%=map.get("genre")%></td>
				<td align="center" width="150"><%=map.get("dayOfPerformance")%></td>
				<td align="center" width="200"><%=map.get("venue")%></td>
				<td align="center" width="150"><%=map.get("seatNum")%></td>
				<td align="center" width="100"><input type="checkbox"
					name="reservation" value="<%=map.get("no")%>"></td>
			</tr>
			<%
			}
			%>
		</table>
		<div style="text-align: center; margin-top: 20px;">
			<input type="button" onclick="setActionAndSubmit('./cartDeletProc.jsp')" value="선택 삭제">
			<input type="button" onclick="setActionAndSubmit('./paymentForm.jsp')" value="결제하기">
		</div>
	</form>
<%-- 	<%
	} else if(userId==null) {
	%>
		<p>로그인 해주세요</p>

	<%
	} else {
	%>
		<p>장바구니가 비어 있습니다.</p>
	<%
	}
	%> --%>

</body>
</html>