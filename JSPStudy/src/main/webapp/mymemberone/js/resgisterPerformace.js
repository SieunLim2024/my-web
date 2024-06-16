function nameCheck() {
	var performanceName = document.getElementById('performanceName').value;
	var nameInfo = document.getElementById('nameInfo');

	if (performanceName.trim() === "") {
		nameInfo.innerHTML = `공연명을 입력해주세요`;
		return false;
	} else if (performanceName.length > 60) {
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
function dateCheck() {
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
	} else {
		dateInfo.innerHTML = "확인 되었습니다.";
		return true;
	}
}
function limitAgeCheck() {
	var limitAge = document.getElementById('limitAge').value;
	var limitAgeInfo = document.getElementById('limitAgeInfo');

	if (limitAge.trim() === "" || isNaN(limitAge) || limitAge < 0) {
		limitAgeInfo.innerHTML = "유효한 관람연령을 입력해주세요.";
		return false;
	} else {
		limitAgeInfo.innerHTML = "확인되었습니다.";
		return true;
	}
}
function seatsCheck() {
	var totalSeats = document.getElementById('totalSeats').value;
	var ySeats = document.getElementById('yseats').value;
	var totalSeatsInfo = document.getElementById('totalSeatsInfo');
	var ySeatsInfo = document.getElementById('yseatsInfo');
	var xSeats = document.getElementById('xseats');

	totalSeats = parseInt(totalSeats);
	ySeats = parseInt(ySeats);

	if (isNaN(totalSeats) || totalSeats <= 0) {
		totalSeatsInfo.innerHTML = "유효한 좌석 수를 입력해주세요.";
		return false;
	} else {
		totalSeatsInfo.innerHTML = "확인되었습니다.";
	}

	if (isNaN(ySeats) || ySeats <= 0) {
		ySeatsInfo.innerHTML = "유효한 좌석 행 수를 입력해주세요.";
		return false;
	} else {
		ySeatsInfo.innerHTML = "확인되었습니다.";
	}

	if (totalSeats > 0 && ySeats > 0) {
		var xSeatsCount = parseInt(totalSeats / ySeats);
		if (totalSeats % ySeats > 0) {
			xSeatsCount += 1;
		}
		xSeats.innerHTML = xSeatsCount;
		document.getElementById('xseatsInput').value = xSeatsCount;
	}

	return true;
}

function ticketPriceCheck() {
	var ticketPrice = document.getElementById('ticketPrice').value;
	var ticketPriceInfo = document.getElementById('ticketPriceInfo');

	if (ticketPrice.trim() === "" || isNaN(ticketPrice) || parseInt(ticketPrice) <= 0) {
		ticketPriceInfo.innerHTML = "유효한 티켓 가격을 입력해주세요.";
		return false;
	} else {
		ticketPriceInfo.innerHTML = "확인되었습니다.";
		return true;
	}
}
function venueCheck() {
	var venue = document.getElementById('venue').value;
	var venueInfo = document.getElementById('venueInfo');

	if (venue.trim() === "") {
		venueInfo.innerHTML = "공연 장소를 입력해주세요.";
		return false;
	} else if (venue.length > 50) {
		venueInfo.innerHTML = "공연 장소는 최대 50자까지 입력 가능합니다.";
		return false;
	} else {
		venueInfo.innerHTML = "확인되었습니다.";
		return true;
	}
}

function allCheck(event) {
	event.preventDefault();

	var isNameCheck = nameCheck();
	var genreSelect = document.getElementById('genre');
	var isGenreCheck = genreCheck(genreSelect);

	var isDateCheck = dateCheck();
	var isVenueCheck = venueCheck();
	var isLimitAgeCheck = limitAgeCheck();
	var isSeatsCheck = seatsCheck();
	var isTicketPriceCheck = ticketPriceCheck();

	if (genreSelect.value !== '기타' && isNameCheck && isGenreCheck && isDateCheck && isVenueCheck &&
		isLimitAgeCheck && isSeatsCheck && isTicketPriceCheck) {
		var customOption = document.getElementById('customOption');
		if (customOption) { // customOption이 존재하는 경우에만 remove 실행
			customOption.remove();
		}
		document.regPerfor.submit();
	} else if (genreSelect.value === '기타' && isNameCheck && isGenreCheck && isDateCheck && isVenueCheck &&
		isLimitAgeCheck && isSeatsCheck && isTicketPriceCheck) {
		var isCustomGenreCheck = customGenreCheck();
		if (isCustomGenreCheck) {
			var customOption = document.getElementById('customOption');
			var customGenre = document.getElementById('customGenre').value;
			
			var newOption = document.createElement('option');
				newOption.value = customGenre;
				newOption.text = customGenre;
				genreSelect.add(newOption);
			
			genreSelect.value=customGenre;
			if (customOption) { // customOption이 존재하는 경우에만 remove 실행
				customOption.remove();
			}
			document.regPerfor.submit();
		}

	} else {
		alert("입력 내용에 문제가 있습니다..");
	}
}