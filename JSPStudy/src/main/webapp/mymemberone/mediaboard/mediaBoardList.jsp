<%@page
	import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" var="nowDate" />
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="mymemberone.MediaBoardDAO"%>


<%@ page import="mymemberone.MediaBoardVO"%>
<%@ page import="java.util.List"%>
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
List<MediaBoardVO> articleList = null;
MediaBoardDAO dbPro = MediaBoardDAO.getInstance();
count = dbPro.getArticleCount();//전체 글수
if (count > 0) {
	articleList = dbPro.getArticles(startRow, endRow);//수정<3>
}
number = count;//수정<4>
%>
<html>
<head>
<title>게시판</title>
<link href="../css/board.css?ver=${nowDate}" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
	<center>
		<b>글목록(전체 글:<%=count%>)
		</b>
		<table width="700">
			<tr>
				<td align="right" bgcolor="<%=value_c%>"><a
					href="writeForm.jsp">글쓰기</a></td>
		</table>
		<%
		if (count == 0) {
		%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
		</table>


		<%
		} else {
		%>
		<table border="1" width="700" cellpadding="0" cellspacing="0"
			align="center">

			<tr height="30" bgcolor="<%=value_c%>">
				<td align="center" width="50">번 호</td>
				<td align="center" width="250">제 목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
				<td align="center" width="50">조 회</td>
				<td align="center" width="100">IP</td>
			</tr>
			<%
			for (int i = 0; i < articleList.size(); i++) {
				MediaBoardVO article = (MediaBoardVO) articleList.get(i);
			%>
			<tr height="30">
				<td align="center" width="50"><%=number--%></td>
				<td width="250">
					<!-- 수정 <5> --> <%
 int wid = 0;
 if (article.getDepth() > 0) {
 	wid = 5 * (article.getDepth());
 %> <img src="../img/level.gif" width="<%=wid%>" height="16"> <img
					src="../img/re.gif"> <%
 } else {
 %> <img src="../img/level.gif" width="<%=wid%>" height="16"> <%
 }
 %> <a
					href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
						<!-- 수정<6> --> <%=article.getSubject()%></a> <%
 if (article.getReadcount() >= 20) {
 %> <img src="../img/hot.gif" border="0" height="16"> <%
 }
 %>

				</td>
				<td align="center" width="100"><a
					href="mailto:<%=article.getEmail()%>"> <%=article.getWriter()%></a></td>

				<td align="center" width="150"><%=sdf.format(article.getRegdate())%></td>
				<td align="center" width="50"><%=article.getReadcount()%></td>
				<td align="center" width="100"><%=article.getIp()%></td>
			</tr>
			<%
			}
			%>
		</table>
		<%
		}
		%>
		<%
		if (count > 0) {
			//하단에 보여줄 페이지 [1][2][3]][4][5]
			int pageBlock = 5;
			int pageCount = count / pageSize + ((count % pageSize == 0) ? (0) : (1));
			int startPage = (int) ((currentPage - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;

			// 50(endPage) >48(pageCount) 이럴때는 endPage = pageCount;
			if (endPage > pageCount) {
				endPage = pageCount;
			}

			//페이지 출력 [이전][6][7][8][9][10][다음]
			if (startPage > pageBlock) {
		%>
		<a href="mediaBoardList.jsp?pageNum=<%=startPage - pageBlock%>">[이전]</a>

		<%
		}
		//페이지 출력
		for (int i = startPage; i <= endPage; i++) {
		%>
		<a href="mediaBoardList.jsp?pageNum=<%=i%>">[<%=i%>]
		</a>
		<%
		}
		if (endPage < pageCount) {
		%>
		<a href="mediaBoardList.jsp?pageNum=<%=startPage + pageBlock%>">[다음]</a>
		<%
		}
		}
		%>
	</center>
</body>
</html>