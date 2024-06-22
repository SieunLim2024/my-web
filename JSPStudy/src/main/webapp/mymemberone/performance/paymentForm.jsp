<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@ page import="mymemberone.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
Date now = new Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
String formatedNow = formatter.format(now);

CartDAO dbPro = CartDAO.getInstance();
UserDAO userdbProc = UserDAO.getInstance();

String userId = (String) session.getAttribute("loginID");
String[] reservationNos = request.getParameterValues("reservation");
List<HashMap> articleList = new ArrayList<>();
if (reservationNos != null) {
	for (int i = 0; i < reservationNos.length; i++) {
		HashMap<String, String> map = new HashMap<>();
		System.out.println(reservationNos[i]);
		map = dbPro.selectArticle(userId, reservationNos[i]);
		articleList.add(map);
	}
}

int mileage = userdbProc.getMileage(userId);

Map<String, int[]> countMap = new HashMap<>();

for (HashMap<String, String> map : articleList) {
	String key = map.get("performanceId");
	if (key != null) {
		if (countMap.containsKey(key)) {
	int[] value = countMap.get(key);
	value[0]++;
	value[1] += Integer.parseInt(map.get("ticketPrice"));
	countMap.put(key, value);
		} else {
	countMap.put(key, new int[] { 1, Integer.parseInt(map.get("ticketPrice")) });
		}
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet"
	href="../css/performancelist.css?ver=<%=formatedNow%>"></link>
<script src="../js/paymentForm.js?ver=<%=formatedNow%>"></script>
</head>

<body>
	<form name="paymentForm" action="paymentProc.jsp" method="post">
		<P>주문 상품</P>
		<table id="selectedItem">
			<tr height="30">
				<td align="center" width="24%">공연명</td>
				<td align="center" width="19%">장르</td>
				<td align="center" width="19%">공연일</td>
				<td align="center" width="19%">공연장</td>
				<td align="center" width="19%">좌석 번호</td>
			</tr>
			<%
			for (int i = 0; i < articleList.size(); i++) {
				HashMap<String, String> map = (HashMap<String, String>) articleList.get(i);
			%>
			<tr height="30">
				<td align="center" width="24%"><%=map.get("performanceName")%></td>
				<td align="center" width="19%"><%=map.get("genre")%></td>
				<td align="center" width="19%"><%=map.get("dayOfPerformance")%></td>
				<td align="center" width="19%"><%=map.get("venue")%></td>
				<td align="center" width="19%"><%=map.get("seatNum")%></td>
				<td><input type="hidden" name="reservation"
					value="<%=map.get("no")%>"></td>
			</tr>
			<%
			}
			%>
		</table>

		<P>마일리지 사용</P>
		<table id="mileage">
			<tr>
				<td>보유 마일리지</td>
				<td><%=mileage%>
				<td>
			</tr>
			<tr>
				<td>사용할 마일리지</td>
				<td>
					<div>
						<input type="text" name="mileage" id="mileage"
							onkeyup="mileageCheck()"> <span id="mileageInfo"
							style="color: red;"></span>
					</div>
				<td>
			</tr>
		</table>
		<p>결제 상세</p>
		<table id="recreipt">
			<tr height="30">
				<td align="center" width="300">공연명</td>
				<td align="center" width="150">수량</td>
				<td align="center" width="150">가격</td>

			</tr>
			<%
			HashSet<String> set = new HashSet<>();
			int setSize = 0;
			int totalPrice = 0;
			for (int i = 0; i < articleList.size(); i++) {
				HashMap<String, String> map = (HashMap<String, String>) articleList.get(i);
				set.add(map.get("performanceId"));
				totalPrice += Integer.parseInt(map.get("ticketPrice"));
				if (setSize >= set.size()) {
					continue;
				} else {
					setSize = set.size();
					int[] count = countMap.get(map.get("performanceId"));
			%>
			<tr>
				<td style="border: 0px;"><input type="hidden"
					name="reservation" value="<%=map.get("no")%>"></td>
			</tr>
			<tr height="30">
				<td align="center" width="300"><%=map.get("performanceName")%></td>
				<td align="center" width="150"><%=count[0]%></td>
				<td align="center" width="150"><%=count[1]%></td>
			</tr>
			<%
			}
			}
			%>
			<tr height="30">
				<td>주문 금액:</td>
				<td colspan="2" align="right"><%=totalPrice%></td>
			</tr>
			<tr height="30">
				<td>마일리지 사용:</td>
				<td colspan="2" align="right"></td>
			</tr>
			<tr height="30">
				<td>등급 할인:</td>
				<td colspan="2" align="right"></td>
			</tr>
			<tr height="30">
				<td>최종 금액:</td>
				<td colspan="2" align="right"><%=totalPrice%></td>
			</tr>
		</table>

		<p>배송지</p>
		<div class="button">
			<input type="button" value="회원정보와 동일" id="adressDefualt"
				onclick="adressDefualt()">
		</div>

		<table class="adress">
			<tr>
				<th>받는 이</th>
				<td>
					<div>
						<input type="text" name="userName" id="userName"
							onkeyup="userNameChek()"> <span id="userNameInfo"
							style="color: red;"></span>
					</div>

				</td>
			</tr>
			<tr>
				<th>연락처</th>
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

		<div class="button">
			<button type="submit">결제 하기</button>
		</div>
	</form>
</body>

</html>