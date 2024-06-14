<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mymemberone.FreeBoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String pass = request.getParameter("pass");
FreeBoardDAO dbPro = FreeBoardDAO.getInstance();
int check = dbPro.deleteArticle(num, pass);
if (check == 1) {
%>
<meta http-equiv="Refresh" content="0;url=freeBoardList.jsp?pageNum=<%=pageNum%>">

<%
} else if(check==0) {
%>
<script language="JavaScript">
<!--
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
	-->
</script>
<%
}else{
%>
<script language="JavaScript">
<!--
	alert("데이터 베이스에 오류가 있습니다.");
	history.go(-1);
	-->
</script>
<% } %>