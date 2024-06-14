<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mymemberone.FreeBoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="article" class="mymemberone.FreeBoardVO" scope="page">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>
<%
article.setRegdate(new Timestamp(System.currentTimeMillis()));
article.setIp(request.getRemoteAddr());//상대방 주소
FreeBoardDAO dpPro = FreeBoardDAO.getInstance();
boolean flag = dpPro.insertArticle(article);
if(flag==true){
response.sendRedirect("freeBoardList.jsp");
	
}else{
	String message="입력이 실패했습니다.";
}
%>