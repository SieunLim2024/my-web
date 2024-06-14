<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMddHHmmss" var="nowDate" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인 페이지</title>
<link rel="stylesheet" href="./css/main.css?ver=${nowDate}">
<script src="https://kit.fontawesome.com/8402defbf8.js"
	crossorigin="anonymous"></script>
<script src="./js/main.js?ver=${nowDate}11">
	
</script>
</head>
<body onload="call_js()">
	<header>
		<div class="left" onclick="location.href='main.jsp'"
			style="cursor: pointer;">
			<img src="./img/logo_white.png" alt="로고"> <img
				src="./img/onthetable1_white.png" alt="상호" style="height: 40px;">
		</div>
		<div class="right">
			<a href="main.jsp">Home</a> <a href="#">Sitemap</a>
		</div>
	</header>
	<nav>
		<div class="left">
			<ul class="menu">
				<li class="menu"><a href="main.jsp">Home</a></li>
				<li class="menu"><a href="">About</a>
					<div class="drop">
						<a href="#">소개</a> <a href="">오시는 길</a>
					</div></li>
				<li class="menu"><a href="" class="drop">Reservation</a>
					<div class="drop">
						<a href="#" onclick="reservationFrom()">예약 하기</a> <a href="#">예약 확인하기</a>
					</div></li>
				<li class="menu"><a href="" class="drop">Contact</a>
					<div class="drop">
						<a href="#" onclick="board('freeBoard')">자유 게시판</a> <a href="#" onclick="board('mediaBoard')">자료
							게시판</a> <a href="#">건의 게시판</a>
					</div></li>
			</ul>
		</div>
		<div class="right">
			<ul>
				<li class="menu"><a onclick="login()">로그인</a></li>
				<li class="menu"><a onclick="member()">회원가입</a></li>
			</ul>
		</div>
	</nav>
    <section id="section1">
        <div class="slideshow">
            <div class="slideshow_slides">
              <a href="#"><img src="./img/slide-1.jpg" alt=""></a>
              <a href="#"><img src="./img/slide-2.jpg" alt=""></a>
              <a href="#"><img src="./img/slide-3.jpg" alt=""></a>
              <a href="#"><img src="./img/slide-4.jpg" alt=""></a>
              <a href="#"><img src="./img/slide-5.jpg" alt=""></a>
              <a href="#"><img src="./img/slide-6.jpg" alt=""></a>
              <a href="#"><img src="./img/slide-7.jpg" alt=""></a>

            </div>
            <div class="slideshow_nav">
              <a href="" class="prev"><i class="fa-solid fa-circle-chevron-left"></i></a>
              <a href="" class="next"><i class="fa-solid fa-circle-chevron-right"></i></a>
            </div>
            <div class="indicator">
              <a href="#" class="active"><i class="fa-solid fa-circle-dot"></i></a>
              <a href="#"><i class="fa-solid fa-circle-dot"></i></a>
              <a href="#"><i class="fa-solid fa-circle-dot"></i></a>
              <a href="#"><i class="fa-solid fa-circle-dot"></i></a>
              <a href="#"><i class="fa-solid fa-circle-dot"></i></a>
              <a href="#"><i class="fa-solid fa-circle-dot"></i></a>
              <a href="#"><i class="fa-solid fa-circle-dot"></i></a>

            </div>
          </div>
    </section>
    <footer>
        <div class="footer1">
            <a href="">개인정보처리방침</a>
            <a href="">고객상담</a>
            <a href="">이용약관</a>
            <a href="">오시는길</a>
        </div>
        <div class="footer2">
            <p>on The Table: 서울시 중구 개발자로 1길 8282 열공빌딩 1층 tel:12-345-6789</p>
            <p>2024 ⓒ on The Table. All Rights Reserved</p>
        </div>
    </footer>
</body>
</html>