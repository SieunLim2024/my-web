function userNameCheck() {
	const userName = document.querySelector("#userName");
	const userNameInfo = document.querySelector("#userNameInfo");
	const namePattern = /^[가-힣]{2,4}$/;
	if (userName.value === "") {
		userNameInfo.innerHTML = `필수 입력 항목 입니다.`;
		return false;
	} else if (!userName.value.match(namePattern)) {
		userNameInfo.innerHTML = `2~4자 이내 한글만 적어주세요.`;
		return false;
	} else {
		userNameInfo.innerHTML = `성명이 정상적으로 확인되었습니다.`;
		return true;
	}
}

function adressNumCheck() {
	const adressNum = document.querySelector("#adressNum");
	// const adressNum2 = document.querySelector("#adressNum2");
	const adressNumInfo = document.querySelector("#adressNumInfo");
	if (adressNum.value === "") {
		adressNumInfo.innerHTML = `필수 입력 항목 입니다.`;
		return false;
	} else {
		adressNumInfo.innerHTML = `정상적으로 확인되었습니다.`;
		return true;
	}

}

function adressCheck() {
	const adress1 = document.querySelector("#adress1");
	const adress2 = document.querySelector("#adress2");
	const adressInfo = document.querySelector("#adressInfo");
	if (adress1.value === "" || adress2.value === "") {
		adressInfo.innerHTML = `필수 입력 항목 입니다.`;
		return false;
	} else {
		adressInfo.innerHTML = `정상적으로 확인되었습니다.`;
		return true;
	}

}
function phoneNumCheck() {
	const phoneNum = document.querySelector("#phoneNum");
	const phoneNumInfo = document.querySelector("#phoneNumInfo");
	const phoneNumPattern = /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/;
	if (phoneNum.value === "") {
		phoneNumInfo.innerHTML = `필수 입력 항목 입니다.`;
		return false;
	} else if (!phoneNum.value.match(phoneNumPattern)) {
		phoneNumInfo.innerHTML = `올바르게 입력해주세요 ex)010-1234-1234`;
		return false;
	} else {
		phoneNumInfo.innerHTML = `연락처가 정상적으로 확인되었습니다.`;
		return true;
	}
}
function searchNum() {
		new daum.Postcode({
			oncomplete : function(data) {
				var addr = '';
				var extraAddr = '';

				if (data.userSelectedType === 'R') {
					addr = data.roadAddress;
				}
				if (data.userSelectedType == 'R') {
					if (data.bname != '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					if (data.bulidingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.bulidingName : data.bulidingName);
					}
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					document.getElementById("adress2").value = extraAddr;
				} else {
					document.getElementById("adress2").value = '';
				}
				document.getElementById('adressNum').value = data.zonecode;
				document.getElementById("adress1").value = addr;
				document.getElementById("adress2").focus();
			}
		}).open();
	}
	
	

//모든 내용 확인후 이상 없으면 서버로 
//이상 있으면 경고창 주고 전송버튼에 이벤트 기능 막기
function allCheck(event) {
	if (userIdCheck() && userPwCheck() && userPwCheckCheck() && userNameCheck()
		&& emailCheck() && phoneNumCheck() && adressNum.value !== "") {
		alert(`정상적으로 가입이 되었습니다.`);
		document.member.submit();
		return true;
	} else {
		alert("가입 내용에 문제가 있습니다.");
		event.preventDefault();
	}
}