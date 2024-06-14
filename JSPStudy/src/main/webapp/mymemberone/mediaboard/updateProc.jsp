<%@page import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mymemberone.MediaBoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Collection"%>

<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%
request.setCharacterEncoding("UTF-8");
String ATTACHES_DIR = "C:\\temp2";
String contentType = request.getContentType();
%>
<jsp:useBean id="article" class="mymemberone.MediaBoardVO" scope="page">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>
<%
//자바 빈즈에서 받지 못한 데이터 값은  getParameter로 받는다.
String pageNum = request.getParameter("pageNum");

if (contentType != null && contentType.toLowerCase().startsWith("multipart/")) {
	Collection<Part> parts = request.getParts();
	article.setRegdate(new Timestamp(System.currentTimeMillis()));
	article.setIp(request.getRemoteAddr());//상대방 주소
	MediaBoardDAO dpPro = MediaBoardDAO.getInstance();
	for (Part part : parts) {
		
		//보내는 데이터가 파일인지, input 값인지 구별
		if (part.getHeader("Content-Disposition").contains("filename=")) {
			String fileName = part.getSubmittedFileName();
			if (part.getSize() > 0) {
				//임시저장된 파일 데이터를 복사하여 지정한 경로에 저장(InputStream, outPutStream)
				part.write(ATTACHES_DIR + File.separator + fileName);
				part.delete(); //임시저장 파일 제거 
				//다운로드할 것을 FileDownloadTest 서블릿을 만들어서 get 방식으로 요청을 한다. 
				String test = application.getContextPath() + "/FileDownloadTest?fileName=" + fileName;
				article.setUpload(test);
				article.setFileName(fileName);
				//out.print("파일명:<a href='" + test + "'>" + fileName + "</a href><br>");
				//out.print("파일크기: " + part.getSize() + " bytes" + "<br>");
				//out.print("article.getUpload:" + article.getUpload());
			} //end of if(part.getSize()>0)
		} else {
			//String formValue = request.getParameter(part.getName());
			//String data = String.format("<b>name : %s,value : %s  </b><br>", part.getName(), formValue);
			//out.print(data);
		
		}
		
		
	} //end of for
	int check = dpPro.updateArticle(article);
//1은 수정 성공 0은 암호 불일치 -1 데이터베이스 오류
if (check == 1) {
%>
<meta http-equiv="Refresh"
	content="0;url=mediaBoardList.jsp?pageNum=<%=pageNum%>">

<%
} else if (check == 0) {
%>
<script language="JavaScript">
<!--
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
	-->
</script>
<%
} else {
%>
<script language="JavaScript">
<!--
	alert("데이터베이스에 오류 발생");
	history.go(-1);
	-->
</script>
<%
}
} else {
	out.println("<p>enctype이 multipart/form-data가 아닙니다.</p>");
	out.println("<p>enctype:" + contentType + "</p>");
	out.println("<p>contentType: " + contentType + "</p>");
}
%>