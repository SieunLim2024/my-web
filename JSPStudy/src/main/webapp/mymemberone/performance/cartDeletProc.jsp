<%@page import="mymemberone.ReceiptVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mymemberone.*"%>
<%@ page import="java.sql.Timestamp"%>
<%
request.setCharacterEncoding("UTF-8");

String[] reservationNos = request.getParameterValues("reservation");
if (reservationNos != null) {
	CartDAO dbPro = CartDAO.getInstance();
	dbPro.deleteArticle(reservationNos);
} else {
	out.println("바르게 선택해주세요");
}
%>
<meta http-equiv="Refresh"
	content="0;url=cartList.jsp">