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
int num=dao.updateMember(vo);
%>
<html>
<head><title>Update Process</title></head>
<% if(num==1){ %>
<meta http-equiv="Refresh" content="0;url=login.jsp">
<% }else{ %>
<meta http-equiv="Refresh" content="3;url=login.jsp">
<body>
<center>
<font size="5" face="바탕체">
올바르게 수정되지 않았습니다.
Logon Page로 이동합니다</font>
</center>
</body>
</html>
<% } %>