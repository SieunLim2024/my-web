<%@page import="mymemberone.*"%>
<%@ page contentType="text/html;charset=utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="vo" class="mymemberone.UserVO">
<jsp:setProperty name="vo" property="*"/>
</jsp:useBean>
<%
UserDAO dao = UserDAO.getInstance();
String loginID = (String)session.getAttribute("loginID");
vo.setUserId(loginID);
dao.updateMember(vo);
%>
<html>
<head><title>Update Process</title></head>
<meta http-equiv="Refresh" content="3;url=login.jsp">
<body>
<center>
<font size="5" face="바탕체">
입력하신 내용대로 <b>회원정보가 수정 되었습니다.</b><br></br>
3초후에 Logon Page로 이동합니다</font>
</center>
</body>
</html>