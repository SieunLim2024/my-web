//콜백 함수 (onLoad call back func)
function call_js() {
    //UI 객체참조 변수 선언
    let slideshow = document.querySelector(".slideshow");
    let slideshow_slides = document.querySelector(".slideshow_slides");
    //<a> UI 객체 배열
    let slides = document.querySelectorAll(".slideshow_slides a");
    let prev = document.querySelector(".prev");
    let next = document.querySelector(".next");
    let indicators = document.querySelectorAll(".indicator a");

    //회전목마의 현재 위치값, 시간 설정, 슬라이드 수
    let currentIndex = 0;
    let timer = null;
    let slideCount = slides.length;

    //회전목마이미지를 우축으로 배치시켜준다.
    for (let i = 0; i < slides.length; i++) {
        let newLeft = i * 100 + '%';
        slides[i].style.left = newLeft;
    }

    //회전목마를 움직인다.() slideshow_slides 왼쪽으로 -100% 이동
    function gotoSlide(index) {
        currentIndex = index;
        let newLeft = index * -100 + '%';
        slideshow_slides.style.left = newLeft;
        indicators.forEach((e) => {
            e.classList.remove("active");
        })
        // for (let i = 0; i < indicators.length; i++) {
        //   indicators[i].classList.remove("active");
        // }
        indicators[currentIndex].classList.add("active");
    }
    //0번부터 3번까지 3초간 gotoSlide(index)
    gotoSlide(0);
    function startTimer() {
        let count = 0;
        timer = setInterval(() => {
            currentIndex += 1;
            let index = currentIndex % slideCount;
            gotoSlide(index);
        }, 3000);
    }

    startTimer();
    //이벤트처리
    slideshow_slides.addEventListener("mouseenter", function () {
        clearInterval(timer);
    });
    slideshow_slides.addEventListener("mouseleave", function () {
        startTimer();
    });
    prev.addEventListener("mouseenter", function () {
        clearInterval(timer);
    });
    next.addEventListener("mouseenter", function () {
        clearInterval(timer);
    });
    prev.addEventListener("click", function (e) {
        e.preventDefault(); //a tag 기본 기능 막는다.
        currentIndex -= 1;
        if (currentIndex < 0) {
            currentIndex = slideCount - 1;
        }
        let index = currentIndex % slideCount;
        gotoSlide(index);

    });
    next.addEventListener("click", function (e) {
        e.preventDefault(); //a tag 기본 기능 막는다.
        currentIndex += 1;
        let index = currentIndex % slideCount;
        gotoSlide(index);
    });

    indicators.forEach((e) => {
        e.addEventListener("mouseenter", () => {
            clearInterval(timer);
        });
    });

    for (let i = 0; i < indicators.length; i++) {
        indicators[i].addEventListener("click", (e) => {
            e.preventDefault();
            gotoSlide(i)
        });
    }

}
function login() {
    let section1 = document.querySelector("#section1");
    section1.innerHTML = '<object width="100%" height="100%" type="text/html" data="./login.jsp"></object>';

}
function member() {
    let section1 = document.querySelector("#section1");
    section1.innerHTML = '<object scrolling="no" width="100%" height="100%" type="text/html" data="./member.jsp"></object>';

}
function board(boardTitle) {
    let section1 = document.querySelector("#section1");
    let str = '<object scrolling="no" width="100%" height="100%" type="text/html" data="./' + boardTitle.toLowerCase() +'/'+ boardTitle +'List.jsp"></object>'
    section1.innerHTML = str;
}
function reservationForm(){
    let section1 = document.querySelector("#section1");
    section1.innerHTML = '<object scrolling="no" width="100%" height="100%" type="text/html" data="./reservation/reservationForm.jsp"></object>';
}
function performanceList(){
    let section1 = document.querySelector("#section1");
    section1.innerHTML = '<object scrolling="no" width="100%" height="100%" type="text/html" data="./performance/performanceList.jsp"></object>';
}