<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" import="java.text.SimpleDateFormat"%>
<%
Date date = new Date();
SimpleDateFormat formatter = new SimpleDateFormat("YYMMDDHHmmss");
String strDate = formatter.format(date);
// 공연 id는 추가하는 시간(초단위까지)일치 하지 않으면 중복되지 않음
String performanceID = "pID" + strDate;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공연 추가하기</title>
<link rel="stylesheet" href="../css/performance.css?ver=3">
<script language="javascript" src="../js/resgisterPerformace.js?ver=20"></script>
</head>
<body>
	<h1>공연 추가</h1>
	<form action="regPerforProc.jsp" method="post" name="regPerfor">
		<input type="hidden" name="performanceId" value="<%=performanceID%>">
		<input type="hidden" name="xseats" id="xseatsInput">
		<table>
			<tr>
				<th>사용자 ID</th>
				<td><%=performanceID%></td>
			</tr>
			<tr>
				<th>공연명</th>
				<td>
					<div>
						<input type="text" name="performanceName" id="performanceName"
							onkeyup="nameCheck()"> <span id="nameInfo"
							style="color: red;"></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>장르</th>
				<td>
					<div>
						<select name="genre" id="genre" onchange="genreCheck(this)">
							<option value="뮤지컬">뮤지컬</option>
							<option value="콘서트">콘서트</option>
							<option value="연극">연극</option>
							<option value="기타">기타</option>
						</select> <span id="genreInfo" style="color: red;"></span>
					</div>
					<div id="customOption" style="display: none;">
						<label for="customGenre" style="font-size: 15px">&nbsp;&nbsp;기타
							장르:</label> <input type="text" id="customGenre" name="customGenre"
							onkeyup="customGenreCheck()">
					</div>
				</td>
			</tr>
			<tr>
				<th>공연일</th>
				<td>
					<div>
						<input type="date" id="dayOfPerformance" name="dayOfPerformance"
							onchange="dateCheck()"> <span id="dateInfo"
							style="color: red;"></span>
					</div>

				</td>
			</tr>
			<tr>
				<th>장소</th>
				<td>
					<div>
						<input type="venue" name="venue" id="venue" onkeyup="venueCheck()">
						<span id="venueInfo" style="color: red;"></span>
					</div>

				</td>
			</tr>
			<tr>
				<th>관람연령</th>
				<td>
					<div>
						<input type="number" name="limitAge" id="limitAge"
							onchange="limitAgeCheck()"> <span id="limitAgeInfo"
							style="color: red;"></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>좌석 수</th>
				<td>
					<div>
						<input type="number" name="totalSeats" id="totalSeats"
							onchange="seatsCheck()"> <span id="totalSeatsInfo"
							style="color: red;"></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>좌석 행</th>
				<td>
					<div>
						<input type="number" name="yseats" id="yseats"
							onchange="seatsCheck()"> <span id="yseatsInfo"
							style="color: red;"></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>좌석 열</th>
				<td><span id="xseats">좌석 수와 좌석열을 입력해주세요.</span></td>
			</tr>
			<tr>
				<th>가격</th>
				<td>
					<div>
						<input type="number" name="ticketPrice" id="ticketPrice"
							onchange="ticketPriceCheck()"> <span id="ticketPriceInfo"
							style="color: red;"></span>
					</div>
				</td>
			</tr>
		</table>
		<div class="submit">
			<button type="button" onclick="allCheck(event)">공연 추가하기</button>
			<input type="button" value="뒤로가기" onclick="window.location='../login.jsp'">
		</div>

	</form>

</body>
</html>