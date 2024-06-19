<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
Date now = new Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
String formatedNow = formatter.format(now);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="../css/paymentForm.css?ver=<%= formatedNow %>"></link>
<script src="../js/paymentForm.js?ver=<%= formatedNow %>"></script>
</head>

<body>
	<form name="paymentForm" action="paymentProc.jsp" method="post">
		<P>주문 상품</P>
		<table id="selectedItem">

		</table>

		<P>마일리지 사용</P>
		<table id="mileage">

		</table>
		<p>결제 수단</p>
		<table id="selectPay">

		</table>

		<p>결제 상세</p>
		<table id="recreipt">

		</table>

		<p>배송지</p>
		<input type="button" value="회원정보와 동일" id="adressDefualt"
			onclick="adressDefualt()">
		<table id="adress">
			<tr>
				<td>받는 이</td>
				<td>
					<div>
						<input type="text" name="userName" id="userName"
							onkeyup="userNameChek()"> <span id="userNameInfo"
							style="color: red;"></span>
					</div>

				</td>
			</tr>
			<tr>
				<td>연락처</td>
				<td>
					<div>
						<input type="text" name="phoneNum" id="phoneNum"
							onkeyup="phoneNumChek()"> <span id="phoneNumInfo"
							style="color: red;"></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td>
					<div>
						<input type="text" name="adressNum" id="adressNum"> <span
							id="adressNumInfo" style="color: red;"></span>
					</div>
					<button type="button" onclick="searchNum()">우편번호 검색</button>
				</td>
			</tr>
			<tr class="adress">
				<th>주소</th>
				<td>
					<div>
						<input type="text" name="adress1" id="adress1">
					</div>
					<div>
						<input type="text" name="adress2" id="adress2" placeholder="상세주소">
						<span id="adressInfo" style="color: red;"></span>
					</div>
					<div>
						<input type="text" name="adress3" id="adress3" placeholder="참고사항">
						<span id="adressInfo" style="color: red;"></span>
					</div>
				</td>
			</tr>

		</table>

		<div class="submit-button">
			<button type="submit">결제 하기</button>

		</div>
	</form>
</body>

</html>