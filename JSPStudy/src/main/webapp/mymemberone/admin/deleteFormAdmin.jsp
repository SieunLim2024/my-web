
<%@page import="java.util.ArrayList"%>
<%@page import="mymemberone.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
UserDAO dao = UserDAO.getInstance();
ArrayList<UserVO> list = dao.getMemberList();
System.out.println("size="+list.size());
%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
</head>
<body>
<h2>삭제할 회원 선택</h2>
<form action="deleteFormAdminProc.jsp" method="post">
	<table align="center" width="1000" border="1">
		<tr>
			<th>사용자 ID</th>
			<th>비밀번호</th>
			<th>성명</th>
			<th>E-mail</th>
			<th>우편번호</th>
			<th>주소</th>
			<th>상세주소</th>
			<th>참고사항</th>
			<th>휴대폰번호</th>
			<th>회원등급</th>
			<th>누적구매</th>
			<th>마일리지</th>
			<th>선택</th>
		</tr>
		<% for(int i=0;i<list.size();i++){ %>
					<tr>
					<td><%= list.get(i).getUserId() %></td>
					<td><%= list.get(i).getUserPw() %></td>
					<td><%= list.get(i).getUserName() %></td>
					<td><%= list.get(i).getEmail() %></td>
					<td><%= list.get(i).getAdressNum() %></td>
					<td><%= list.get(i).getAdress1() %></td>
					<td><%= list.get(i).getAdress2() %></td>
					<td><%= list.get(i).getAdress3() %></td>
					<td><%= list.get(i).getPhoneNum() %></td>
					<td><%= list.get(i).getGrade() %></td>
					<td><%= list.get(i).getAmount() %></td>
					<td><%= list.get(i).getMileage() %></td>
					<td><input type="checkbox" name="delete" value="<%= list.get(i).getUserId()%>"></td>
					</tr>
		<% }%>
		</table>
		<div style="text-align:center; margin-top:20px;">
        <input type="submit" value="삭제">
    </div>
</form>
</body>
</html>