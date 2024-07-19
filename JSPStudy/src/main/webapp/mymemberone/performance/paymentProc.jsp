<%@page import="mymemberone.ReceiptVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mymemberone.ReceiptDAO"%>
<%@ page import="mymemberone.PaymentDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%
ReceiptVO receipt = new ReceiptVO();
receipt.setPrice(Integer.parseInt(request.getParameter("price")));
receipt.setTotalPrice(Integer.parseInt(request.getParameter("totalPrice")));
receipt.setUseMileage(Integer.parseInt(request.getParameter("useMileage")));
receipt.setUserId((String) session.getAttribute("loginID"));
String[] cartNO = request.getParameterValues("reservation");

//영수증 등록
ReceiptDAO receiptDbPro = ReceiptDAO.getInstance();
int rs1=receiptDbPro.insertArticle(receipt);

//구매 내역 추가
PaymentDAO paymentDbPro = PaymentDAO.getInstance();
int rs2=paymentDbPro.insertArticle(cartNO);
%>
<meta http-equiv="Refresh"
	content="0;url=paymentList.jsp">
