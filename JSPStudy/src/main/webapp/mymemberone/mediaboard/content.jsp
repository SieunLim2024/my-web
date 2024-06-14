<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mymemberone.MediaBoardDAO"%>
<%@ page import="mymemberone.MediaBoardVO"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="../view/boardColor.jsp"%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
int num = Integer.parseInt(request.getParameter("num"));
int pageNum = Integer.parseInt(request.getParameter("pageNum"));
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
try {
	MediaBoardDAO dbPro = MediaBoardDAO.getInstance();
	MediaBoardVO article = dbPro.getArticle(num);
	int ref = article.getRef();
	int step = article.getStep();
	int depth = article.getDepth();
%>
<body bgcolor="<%=bodyback_c%>">
	<center>
		<b>글내용 보기</b> <br></br>
		<form>
			<table width="500" border="1" cellspacing="0" cellpadding="0"
				bgcolor="<%=bodyback_c%>" align="center">

				<tr height="30">
					<td align="center" width="125" bgcolor="<%=value_c%>">글번호</td>
					<td align="center" width="125" align="center"><%=article.getNum()%></td>
					<td align="center" width="125" bgcolor="<%=value_c%>">조회수</td>
					<td align="center" width="125" align="center"><%=article.getReadcount()%></td>
				</tr>
				<tr height="30">
					<td align="center" width="125" bgcolor="<%=value_c%>">작성자</td>
					<td align="center" width="125" align="center"><%=article.getWriter()%></td>
					<td align="center" width="125" bgcolor="<%=value_c%>">작성일</td>
					<td align="center" width="125" align="center"><%=sdf.format(article.getRegdate())%></td>
				</tr>
				<tr height="30">
					<td align="center" width="125" bgcolor="<%=value_c%>">글제목</td>
					<td align="center" width="375" align="center" colspan="3"><%=article.getSubject()%></td>
				</tr>
				<tr>
					<td align="center" width="125" bgcolor="<%=value_c%>">글내용</td>
					<td align="left" width="375" colspan="3"><pre><%=article.getContent()%></pre></td>
				</tr>
				<tr>
					<td align="center" width="125" bgcolor="<%=value_c%>">첨부파일</td>
					<% if(article.getUpload()!=null||article.getFileName()!=null){
					%>
					<td align="left" width="375" colspan="3"><pre><a href='<%=article.getUpload()%>'><%=article.getFileName()%></a href></pre></td>
					<% }else{ %>
					<td align="left" width="375" colspan="3"></td>
					<% } %>
				</tr>
				
				<tr height="30">
					<td colspan="4" bgcolor="<%=value_c%>" align="right">
					<input
						type="button" value="답글 달기"
						onclick="document.location.href='writeForm.jsp?num=<%=article.getNum()%>&ref=<%=article.getRef()%>&step=<%=article.getStep()%>&depth=<%=article.getDepth()%>'">
					&nbsp;&nbsp;
					<input
						type="button" value="글수정"
						onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
						&nbsp;&nbsp;
						<input type="button" value="글삭제"
                        onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
						&nbsp;&nbsp; <!-- 수정<1> --> <input type="button"
						value="글목록"
						onclick="document.location.href='mediaBoardList.jsp?pageNum=<%=pageNum%>'">

					</td>
				</tr>
			</table>
			<%
			} catch (Exception e) {
			}
			%>
		</form>
	</center>
</body>
</html>