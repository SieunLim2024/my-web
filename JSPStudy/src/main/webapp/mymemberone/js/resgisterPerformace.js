function nameCheck() {
	var performanceName = document.getElementById('performanceName').value;
	var nameInfo = document.getElementById('nameInfo');

	if (performanceName.trim() === "") {
		nameInfo.innerHTML = `공연명을 입력해주세요`;
		return false;
	} else if(performanceName.length>60) {
		nameInfo.innerHTML = `공연명은 60자 이내로 입력해주세요`;
		return false;
	} else {
		nameInfo.innerHTML = `확인되었습니다.`;
		return true;
	}
}
function genreCheck(select) {
	var selectedValue = select.value;

	if (selectedValue === "") {
		genreInfo.innerHTML = `장르를 선택해주세요.`;
		return false;
	}
	if (selectedValue === "기타") {
		document.getElementById('customOption').style.display = 'block';
		return true;
	} else {
		document.getElementById('customOption').style.display = 'none';
	}
	return true;
}

function customGenreCheck() {
	var customGenre = document.getElementById('customGenre').value;
	var customOption = document.getElementById('customOption');
	if (customOption.style.display === 'block' && customGenre.trim() === "") {
		alert("기타 장르를 입력해주세요.");
		return false;
	} else if (customGenre.length > 10) {
		alert("기타 장르는 최대 10자까지 입력 가능합니다.");
		return false;
	} else {
		return true;
	}
}
function dateCheck(){
	var date = document.getElementById('dayOfPerformance').value;
	var nameInfo = document.getElementById('dateInfo');
	var selectedDate = new Date(date);
    var today = new Date();
            
	if (date.trim() === "") {
                dateInfo.innerHTML = "공연일을 선택해주세요";
                return false;
    } else if (selectedDate < today) {
                dateInfo.innerHTML = "이미 지난 날짜는 선택할 수 없습니다.";
                document.getElementById("performanceDate").value = ''; // 선택한 날짜 초기화
                return false;
    }else{
		dateInfo.innerHTML = "확인 되었습니다.";
                return true;
	}
}

function seatsCheck(){
	var total = document.getElementById('totalSeats').value;
	var totalSeatsInfo = document.getElementById('totalSeatsInfo').value;
    var y = document.getElementById('yseats').value;
    var yseatsInfo = document.getElementById('yseatsInfo').value;
    var x =document.getElementById('xseats').value;
    
    if(total<=0){
		totalSeatsInfo.innerHTML = "좌석은 1석 이상 입력해주세요.";
		return false;
	}else if(total===""){
		totalSeatsInfo.innerHTML = "좌석을 이상 입력해주세요.";
		return false;
	}else if(total>0){
		totalSeatsInfo.innerHTML = "확인 되었습니다.";
		return true;
	}
	
	if(y<=0){
		yseatsInfo.innerHTML = "좌석 행은 1 이상 입력해주세요.";
		return false;
	}else if(y===""){
		yseatsInfo.innerHTML = "좌석 행을 이상 입력해주세요.";
		return false;
	}else if(y>0){
		yseatsInfo.innerHTML = "확인 되었습니다.";
		return true;
	}
    
    
	
}