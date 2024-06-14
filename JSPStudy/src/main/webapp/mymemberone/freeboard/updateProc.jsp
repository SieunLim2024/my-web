<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="mymemberone.FreeBoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" scope="page" class="mymemberone.FreeBoardVO">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>
<%
//자바 빈즈에서 받지 못한 데이터 값은  getParameter로 받는다.
String pageNum = request.getParameter("pageNum");
FreeBoardDAO dbPro = FreeBoardDAO.getInstance();
int check = dbPro.updateArticle(article);
//1은 수정 성공 0은 암호 불일치 -1 데이터베이스 오류
if (check == 1) {
%>
<meta http-equiv="Refresh" content="0;url=freeBoardList.jsp?pageNum=<%=pageNum%>">

<%
} else if(check==0){
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
	alert("데이터베이스에 오류 발생");
	history.go(-1);
	-->
</script>
<%}%>