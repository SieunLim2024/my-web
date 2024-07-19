<%@page import="jakarta.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@ page import="mymemberone.*"%>
<%@ page import="java.util.*"%>
<%
String userId = (String) session.getAttribute("loginID");

PaymentDAO paydbPro = PaymentDAO.getInstance();
List<HashMap> paymentList = paydbPro.selectArticle(userId);

ReceiptDAO RdbPro = ReceiptDAO.getInstance();
List<HashMap> receipttList = RdbPro.selectArticle(userId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 내역</title>
<link href="../css/performancelist.css?ver=${formatedNow}"
	rel="stylesheet" type="text/css">
</head>
<body>
	<%
	System.out.println(paymentList.size() + userId);
	if (userId != null && receipttList.size() > 0) {
		for (int j = 0; j < receipttList.size(); j++) {
			String nowIDStr = (String)receipttList.get(j).get("receiptId");
			int nowID= Integer.parseInt(nowIDStr);
	%>
	<p>결제 상세</p>
	<table id="recreipt">
		<tr height="30">
			<td>주문일:</td>
			<td colspan="2" align="right"><%=receipttList.get(j).get("paymentDate")%></td>
		</tr>
		<tr height="30">
			<td>주문 금액:</td>
			<td colspan="2" align="right"><%=receipttList.get(j).get("price")%></td>
		</tr>
		<tr height="30" name="useMileage">
			<td>마일리지 사용:</td>
			<td colspan="2" align="right"><%=receipttList.get(j).get("useMileage")%></span></td>
		</tr>
		<tr height="30">
			<td>최종 금액:</td>
			<td colspan="2" align="right"><%=receipttList.get(j).get("totalPrice")%></span></td>
		</tr>
	</table>





	<p>주문 내용</p>
	<table border="1" width="700" cellpadding="0" cellspacing="0"
		align="center">

		<tr height="30">
			<td align="center" width="300">공연명</td>
			<td align="center" width="150">장르</td>
			<td align="center" width="150">공연일</td>
			<td align="center" width="250">공연장</td>
			<td align="center" width="150">좌석 번호</td>
		</tr>
		<%
		for (int i = 0; i < paymentList.size(); i++) {
			HashMap<String, String> map = (HashMap<String, String>) paymentList.get(i);
			if (map.containsValue(nowID + "")) {
		%>
		<tr height="30">
			<td align="center" width="300"><%=map.get("performanceName")%></td>
			<td align="center" width="150"><%=map.get("genre")%></td>
			<td align="center" width="150"><%=map.get("dayOfPerformance")%></td>
			<td align="center" width="200"><%=map.get("venue")%></td>
			<td align="center" width="150"><%=map.get("seatNum")%></td>
		</tr>
		<%
		}
		}
		%>
	</table>
	<br>
	<hr>
	<br>
	<%
	}
	%>


	<%
	} else if (userId == null) {
	%>
	<p>로그인 해주세요</p>

	<%
	} else {
	%>
	<p>구매 내역이 없습니다.</p>
	<%
	}
	%>

</body>
</html>