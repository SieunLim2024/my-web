<%@page import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" var="nowDate" />
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="mymemberone.FoundArticleDAO"%>


<%@ page import="mymemberone.FoundArticleVO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="../view/boardColor.jsp"%>
<%
// 수정 <1>
//리스트에 전체 보여줄 페이지 라이눗. 한 페이지에 10개 보여줌
int pageSize = 5;

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
//<수정 2>
//페이지를 지정한 것이 없으면 기본으로 1페이지세팅
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}

//현재 페이지와 현재 페이지 시작 라인, 끝라인 계산한다.
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

int count = 0;
int number = 0;

ArrayList<FoundArticleVO> articleList = null;
ArrayList<FoundArticleVO> foundArticleSelectList = null;
FoundArticleDAO dbPro = FoundArticleDAO.getInstance();


articleList = dbPro.webConnection();//공공 데이터 가져옴
count = articleList.size();//전체 글수

number = count;

if (count>0){
	FoundArticleDAO.insertArticle(articleList);//DB에 저장
	foundArticleSelectList = FoundArticleDAO.selectArticle();//DB에서 가져옴
}
%>
<html>
<head>
<title>습득물 게시판</title>
<link href="../css/board.css?ver=${nowDate}" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">

</script>
<body bgcolor="<%=bodyback_c%>">
	<center>
		<b>습득물 목록(전체 글:<%=count%>)
		</b>
		<%
		if (count == 0) {
		%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">등록된 물품이 없습니다.</td>
			</tr>
		</table>
		<input type="button" value="목록" onclick="onClick()">
		<%
		} else {
		%>
		<table border="1" width="700" cellpadding="0" cellspacing="0"
			align="center">

			<tr height="30" bgcolor="<%=value_c%>">
				<td align="center" width="50">관리ID</td>
				<td align="center" width="250">보관장소</td>
				<td align="center" width="100">분실물명</td>
				<td align="center" width="150">습득일자</td>
				<td align="center" width="150">물품분류명</td>
				<td align="center" width="10">반납여부</td>
			</tr>
			<%
			for (int i = 0; i < foundArticleSelectList.size(); i++) {
				FoundArticleVO article = (FoundArticleVO) articleList.get(i);
			%>
			<tr height="30">
				<td align="center" width="50"><%= article.getAtcId() %></td>
				<td align="center" width="250"><%= article.getDepPlace() %></td>
				<td align="center" width="100"><%= article.getFdPrdtNm() %></td>
				<td align="center" width="150"><%= article.getFdYmd() %></td>
				<td align="center" width="150"><%= article.getPrdtClNm() %></td>
				<td align="center" width="10"><%= article.getState() %></td>
			</tr>
			<%
			}
			%>
		</table>
		<%
		}
		%>
	</center>
</body>
</html>