<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//로그인 완료했는지 점검
String loginID = (String) session.getAttribute("loginID");
%>

<!DOCTYPE html>
<html>
<script language="javascript" src="script.js?"></script>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="login.css?ver=1" type="text/css">
</head>
<body>
	<%
	if (loginID == null) {
	%>
	<form method="post" action="loginProc.jsp" name="regForm">
		<div>
			<h1>로그인</h1>
		</div>
		<div>
			<input type="radio" name="member" value="radio1" id="radio1">
			<label for="radio1"><b>회원</b></label> <input type="radio"
				name="member" value="radio2" id="radio2"> <label
				for="radio2"><b>비회원(주문조회)</b></label>
		</div>
		<div class="menu1">
			<div class="left1">
				<input type="text" placeholder="아이디" id="userId" name="userId"
					required> <input type="password" placeholder="비밀번호" id="userPw"
					name="userPw" required>
			</div>
			<div class="right1">
				<input type="submit" value="로그인">
			</div>
		</div>
		<div class="menu2">
			<div class="left2">
				<input type="checkbox" value="1" id="checkbox1"> <label
					for="checkbox1"><b>아이디저장</b></label>
			</div>
			<div class="right2">
				<a href="#">OTP 로그인</a>
			</div>
		</div>
		<div class="menu3">
			<input type="button" value="회원가입"
				onclick="location.href='member.jsp'"> <input type="button"
				value="아이디 찾기"> <input type="button" value="비밀번호 찾기">
		</div>
	</form>
		<%}else if(loginID.equals("admin")){ %>
	<table border="1" width="300">
		<tr>
			<td colspan="3" align="center">관리자님 환영합니다.</td>
		</tr>
		<tr>
			<td align="center" width="100"><a href="./admin/deleteFormAdmin.jsp">회원관리</a></td>
			<td align="center" width="100"><a href="./admin/deleteFormAdmin.jsp">공연추가</a></td>
			<td align="center" width="100"><a href="./admin/deleteFormAdmin.jsp">공연관리</a></td>
			<td align="center" width="100"><a href="logout.jsp">로그아웃</a></td>

		</tr>
	</table>
	<%
	} else {
	%>
	<table border="1" width="300">
		<tr>
			<td colspan="3" align="center"><%=loginID%>님 환영합니다.</td>
		</tr>
		<tr>
			<td align="center" width="100"><a href="modifyForm.jsp">정보수정</a></td>
			<td align="center" width="100"><a href="deleteForm.jsp">회원탈퇴</a></td>
			<td align="center" width="100"><a href="logout.jsp">로그아웃</a></td>

		</tr>
	</table>
	<%
	}
	%>
</body>
</html>