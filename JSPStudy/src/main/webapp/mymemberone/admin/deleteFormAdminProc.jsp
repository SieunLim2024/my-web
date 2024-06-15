<%@page import="mymemberone.UserDAO"%>
<%@page import="jdbc.DBPoolUtil2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 삭제</title>
</head>
<body>
<%
	UserDAO dao = UserDAO.getInstance();
	int cnt=0;
    String[] userIds = request.getParameterValues("delete");

    if (userIds != null) {
        for(String data:userIds){
        	System.out.println(data);
        	int rs=dao.deleteMember(data);
        	if(rs==1){
        		cnt++;
        	};
        }
    } else {
        out.println("삭제할 사용자를 선택하지 않았습니다.");
    }
%>
<p><%= cnt %>개의 계정을 삭제 했습니다.</p>
<div style="text-align:center; margin-top:20px;">
    <input type="button" value="뒤로가기" onclick="window.location='deleteFormAdmin.jsp'">
    <a></a>
</div>
</body>
</html>