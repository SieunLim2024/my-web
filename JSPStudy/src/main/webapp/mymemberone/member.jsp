<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <link rel="stylesheet" href="member.css">
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script language="javascript" src="script.js?ver=3"></script>
  <script>
    function userIdChek(){
      const userId = document.querySelector("#userId");
      const userIdInfo= document.querySelector("#userIdInfo");
      const userIdPettern=/^[a-z0-9]{4,10}$/;
      if(userId.value ===""){
        userIdInfo.innerHTML=`필수 입력 항목 입니다.`
        return false;
      }else if(!userId.value.match(userIdPettern)){
        userIdInfo.innerHTML=`4~10자 이내 알파벳와 숫자만 입력하세요.`;
        return false;
      }else{
        userIdInfo.innerHTML=`입력 가능한 아이디입니다.`
        return true;
      }
    }
    function userPwChek(){
      const userPw = document.querySelector("#userPw");
      const userPwInfo= document.querySelector("#userPwInfo");
      const userPwPettern=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*+=-]).{6,16}$/;
      if(userPw.value ===""){
        userPwInfo.innerHTML=`필수 입력 항목 입니다.`
        return false;
      }else if(!userPw.value.match(userPwPettern)){
        userPwInfo.innerHTML=`6~16자 영문자와 숫자,특수기호를 조합해 입력해주세요`;
        return false;
      }else{
        userPwInfo.innerHTML=`입력 가능한 패스워드입니다.`
        return true;
      }
    }
    function userPwCheckChek(){
      const userPw = document.querySelector("#userPw");
      const userPwCheck = document.querySelector("#userPwCheck");
      const userPwCheckInfo= document.querySelector("#userPwCheckInfo");
      if(userPwCheck.value ===""){
        userPwCheckInfo.innerHTML=`필수 입력 항목 입니다.`
        return false;
      }else if(userPwCheck.value ===userPw.value){
        userPwCheckInfo.innerHTML=`일치`
        return true;
      }else{
        userPwCheckInfo.innerHTML=`불일치`
        return false;
      }
    }
    function userNameChek(){
      const userName = document.querySelector("#userName");
      const userNameInfo= document.querySelector("#userNameInfo");
      const namePattern = /^[가-힣]{2,4}$/;
      if(userName.value === ""){
        userNameInfo.innerHTML=`필수 입력 항목 입니다.`;
        return false;
      }else if(!userName.value.match(namePattern)){
        userNameInfo.innerHTML=`2~4자 이내 한글만 적어주세요.`;
        return false;
      }else{
        userNameInfo.innerHTML=`성명이 정상적으로 확인되었습니다.`;
        return true;
      }
    }
    
    function emailChek(){
      const email = document.querySelector("#email");
      const emailInfo= document.querySelector("#emailInfo");
      const emailPattern = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
      if(email.value === ""){
        emailInfo.innerHTML=`필수 입력 항목 입니다.`;
        return false;
      }else if(!email.value.match(emailPattern)){
        emailInfo.innerHTML=`올바른 이메일 형식으로 입력해주세요`;
        return false;
      }else{
        emailInfo.innerHTML=`이메일이 정상적으로 확인되었습니다.`;
        return true;
      }
    }
    function adressNumChek(){
      const adressNum = document.querySelector("#adressNum");
      // const adressNum2 = document.querySelector("#adressNum2");
      const adressNumInfo= document.querySelector("#adressNumInfo");
      if(adressNum.value === ""){
        adressNumInfo.innerHTML=`필수 입력 항목 입니다.`;
        return false;
      }else{
        adressNumInfo.innerHTML=`정상적으로 확인되었습니다.`;
        return true;
      }
      // }else if(adressNum1.value.match(/\d{3}/)&&adressNum2.value.match(/\d{3}/)){
      //   adressNumInfo.innerHTML=`정상적으로 확인되었습니다.`;
      //   return true;
      // }else{
      //   adressNumInfo.innerHTML=`바르게 입력해주세요`;
      //   return false;
      // }
    }
    
    function adressChek(){
      const adress1 = document.querySelector("#adress1");
      const adress2 = document.querySelector("#adress2");
      const adressInfo= document.querySelector("#adressInfo");
      // const adressPattern = /^[가-힣]{2,4}$/;
      if(adress1.value === ""||adress2.value === ""){
        adressInfo.innerHTML=`필수 입력 항목 입니다.`;
        return false;
      }else{
        adressInfo.innerHTML=`정상적으로 확인되었습니다.`;
        return true;
      }
      // }else if(adress1.value.match(adressPattern)&&adress2.value.match(adressPattern)){
      //   adressInfo.innerHTML=`정상적으로 확인되었습니다.`;
      //   return true;
      // }else{
      //   adressInfo.innerHTML=`올바른 형식으로 입력해주세요`;
      //   return false;
      // }
    }
    function phoneNumChek(){
      const phoneNum = document.querySelector("#phoneNum");
      const phoneNumInfo= document.querySelector("#phoneNumInfo");
      const phoneNumPattern = /^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$/;
      if(phoneNum.value === ""){
        phoneNumInfo.innerHTML=`필수 입력 항목 입니다.`;
        return false;
      }else if(!phoneNum.value.match(phoneNumPattern)){
        phoneNumInfo.innerHTML=`올바르게 입력해주세요 ex)010-1234-1234`;
        return false;
      }else{
        phoneNumInfo.innerHTML=`연락처가 정상적으로 확인되었습니다.`;
        return true;
      }
    }
    //모든 내용 확인후 이상 없으면 서버로 
    //이상 있으면 경고창 주고 전송버튼에 이벤트 기능 막기
    function allCheck(event){
      // adressNumChek();
      // adressChek();
      if(userIdChek()&&userPwChek()&&userPwCheckChek()&&userNameChek()
      &&emailChek()&&phoneNumChek()&&adressNum.value !== ""){
        alert(`정상적으로 가입이 되었습니다.`);
        document.member.submit();
        return true;
      }else{
        alert("가입 내용에 문제가 있습니다.");
        event.preventDefault();
      }
    }
    function searchNum(){
      new daum.Postcode({
        oncomplete: function(data) {
          var addr = '';
          var extraAddr ='';

          if(data.userSelectedType==='R'){
            addr = data.roadAddress;
          }
          if(data.userSelectedType=='R'){
            if(data.bname!=''&&/[동|로|가]$/g.test(data.bname)){
              extraAddr+=data.bname;
            }
            if(data.bulidingName!==''&&data.apartment==='Y'){
              extraAddr+= (extraAddr!==''?', '+data.bulidingName:data.bulidingName);
            }
            if(extraAddr!==''){
              extraAddr=' ('+extraAddr+')';
            }
            document.getElementById("adress2").value=extraAddr;
          }else{
            document.getElementById("adress2").value='';
          }
          document.getElementById('adressNum').value =data.zonecode;
          document.getElementById("adress1").value =addr;
          document.getElementById("adress2").focus();
          }
        }).open();
    }
  </script>
</head>
<body>
  <div class="info">
    <h1>회원가입</h1>
    <span><b>온라인 회원가입 작성</b></span>
    <hr>
    <span>고객님의 정보는 개인정보보호정책에 의해 철저하게 보호됩니다.</span>
    <hr>

  </div>
  <form action="regProc.jsp" method="post" name="member">
    <table>
      <tr>
        <th>사용자 ID</th>
        <td>
          <div>
            <input type="text" name="userId" id="userId" onkeyup="userIdChek()">
            <span id="userIdInfo" style="color: red;"></span>
          </div>
          <input type="button" onClick="idCheck(this.form.userId.value)" value="ID 중복확인"/>
        </td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td>
          <div>
            <input type="password" name="userPw" id="userPw" onkeyup="userPwChek()">
            <span id="userPwInfo" style="color: red;"></span>
            
          </div>
        </td>
      </tr>
      <tr>
        <th>비밀번호 확인</th>
        <td>
          <div>
            <input type="password" name="userPwCheck" id="userPwCheck" onkeyup="userPwCheckChek()">
            <span id="userPwCheckInfo" style="color: red;"></span>
          </div>
        </td>
      </tr>
      <tr>
        <th>성명</th>
        <td>
          <div>
            <input type="text" name="userName" id="userName" onkeyup="userNameChek()">
          <span id="userNameInfo" style="color: red;"></span>
          </div>
          
        </td>
      </tr>
      <tr>
        <th>E-mail</th>
        <td>
          <div>
            <input type="email" name="email" id="email" onkeyup="emailChek()">
          <span id="emailInfo" style="color: red;"></span>
          </div>
          
        </td>
      </tr>
      <tr>
        <th>우편번호</th>
        <td>
          <div>
            <input type="text" name="adressNum" id="adressNum">
            <span id="adressNumInfo" style="color: red;"></span>
          </div>
          <button type="button" onclick="searchNum()">우편번호 검색</button>
        </td>
      </tr>
      <tr class="adress">
        <th>주소</th>
        <td>
          <div>
            <input type="text" name="adress1" id="adress1">
          </div>
          <div>
            <input type="text" name="adress2" id="adress2" placeholder="상세주소">
            <span id="adressInfo" style="color: red;"></span>
          </div>
          <div>
            <input type="text" name="adress3" id="adress3"  placeholder="참고사항">
            <span id="adressInfo" style="color: red;"></span>
          </div>
        </td>
      </tr>
      <tr>
        <th>휴대폰번호</th>
        <td>
          <div>
            <input type="text" name="phoneNum" id="phoneNum" onkeyup="phoneNumChek()">
            <span id="phoneNumInfo" style="color: red;"></span>
          </div>
        </td>
      </tr>
    </table>
    <div class="submit">
      <button  type="button" onclick="allCheck(event)">가입</button>
    </div>

  </form>
</body>
</html>