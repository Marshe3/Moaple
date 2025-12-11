<%@page import="com.aischool.entity.Tracks"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <style>
    
{
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;}

    body {
      margin: 0;
      background-color: #00459B; /* 배경 파란색 */
      display: flex;
      justify-content: center;
      align-items: flex-start;
      padding: 60px 0;
      min-height: 100vh;
    }

    .container {
      background-color: white;
      border-radius: 20px;
      width: 450px;
      padding: 20px 30px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      /*text-align: center;*/
       margin-top: 80px;
    }

    .container h2,
    .profile-img,
    .profile-label {
      text-align: center;
    }

    .logo {
      position: absolute;
      margin: -5px auto 10px;
      margin-right: 100px;
      top: 30px;
      text-align: center;
      color: white;
      font-size: 30px;
      font-weight: bold;
      pointer-events: none;
      user-select: none;
    }

    .logo img {
      height: 70px;
    }

    h2 {
      margin-bottom: 10px;
      font-size: 20px;
      color: #333;
    }

    .profile-img {
      width: 60px;
      height: 60px;
      background-color: #F0F0F0;
      border-radius: 50%;
      margin: 0 auto 10px;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 12px;
      color: #666;
    }

    .profile-label {
      font-size: 13px;
      color: #666;
      margin-bottom: 20px;
      cursor: pointer;
    }

    input, select {
      width: 100%;
      padding: 12px;
      margin: 6px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
    }

    .checkbox-area {
      display: flex;
      align-items: center;
      justify-content: flex-start;
      margin-top: 12px;
      font-size: 13px;
      color: #333;
      width: 100%;
      padding: 0;
      margin-left: 0;
    }

    .checkbox-area label {
      padding: 0;
      margin-left: 6px;
      cursor: pointer;
      flex-grow: 1;
    }

    .checkbox-area input {
      padding: 0;
      margin: 0;
    }

    .highlight {
      color: blue;
      font-weight: 500;
    }

    .submit-btn {
      margin-top: 20px;
      width: 100%;
      padding: 13px;
      background-color: #003C9E;
      color: white;
      font-size: 16px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }
  </style>
</head>
<body>

  <!-- 로고 텍스트 -->
  <div class="logo">
    <a href="#home" class="logo">
            <div class="logo-icon">
                <img src="logo5.png" 
                     alt="모아플 로고" 
                     class="logo-image"
                     onerror="this.style.display='none';">
            </div>
        </a>
  </div>

  <!-- 회원가입 박스 -->
  <div class="container">
    <h2>회원가입</h2>
	<form method="post" action="join.do" enctype="multipart/form-data">
    <div class="profile-img">👤</div>
    <div class="profile-label"><input type="file" name="profileImg">프로필 변경</div>

    <input type="text" placeholder="아이디" name="userName" id="userName" onblur="checkDuplicate()"/>
    <div id="userNameMsg" style="font-size:12px; margin-top:-5px;"></div>
    <input type="password" placeholder="비밀번호" name="password" id="password"/>
    <!--<input type="password" placeholder="비밀번호 확인" />-->
    <input type="text" placeholder="이름" name="name"/>

    <select name="trackId">
      <option>소속 트랙별 번호</option>
      <% List<Tracks> t = (List<Tracks>)request.getAttribute("tracks");   
      	if(t != null) {
      		for(int i = 0; i < t.size(); i++){
      		%>
      		<option value="<%= t.get(i).getTrackId() %>"><%= t.get(i).getTrackName() %></option>
      	<% 
      		}
      	}
      %>
      <!-- 
      <option>자연어처리 A</option>
      <option>자연어처리 B</option>
      <option>컴퓨터비전 A</option>
      <option>컴퓨터비전 B</option>
      <option>AI플랫폼및인프라</option>
      <option>AI서비스개발 A</option>
      <option>AI서비스개발 B</option>
      <option>AI서비스개발_B</option> 
      -->
    </select>

    <input type="text" placeholder="프로젝트 팀명" name="projectTeamName"/>
    <input type="text" placeholder="휴대폰 번호" name="phone" id="phone" oninput="onlyNumbers(this)"/>

    <div class="checkbox-area">
      <input type="checkbox" id="agree">
      <label for="agree">
        <span class="highlight">개인정보 수집/이용</span>에 동의합니다 (필수)
      </label>
    </div>

    <button class="submit-btn" type="submit" onclick="return validateForm()">가입하기</button>
    </form>
  </div>

<script>
let isUserNameAvailable = false;

// 중복 아이디 체크
function checkDuplicate() {
    const userName = document.getElementById('userName').value;
    const msgDiv = document.getElementById('userNameMsg');
    
    if(userName.trim() === '') {
        msgDiv.innerHTML = '';
        isUserNameAvailable = false;
        return;
    }
    
    fetch('checkUserName.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'userName=' + encodeURIComponent(userName)
    })
    .then(response => response.text())
    .then(result => {
        if(result === 'duplicate') {
            msgDiv.innerHTML = '<span style="color:red;">이미 사용중인 아이디입니다.</span>';
            isUserNameAvailable = false;
        } else {
            msgDiv.innerHTML = '<span style="color:green;">사용 가능한 아이디입니다.</span>';
            isUserNameAvailable = true;
        }
    })
    .catch(error => {
        console.error('Error:', error);
        msgDiv.innerHTML = '<span style="color:red;">중복 체크 중 오류가 발생했습니다.</span>';
        isUserNameAvailable = false;
    });
}

// 숫자만 입력 허용
function onlyNumbers(input) {
    input.value = input.value.replace(/[^0-9]/g, '');
}

// 폼 유효성 검사
function validateForm() {
    const userName = document.getElementById('userName').value;
    const password = document.getElementById('password').value;
    const phone = document.getElementById('phone').value;
    const agree = document.getElementById('agree').checked;
    
    if(userName.trim() === '') {
        alert('아이디를 입력해주세요.');
        return false;
    }
    
    if(!isUserNameAvailable) {
        alert('아이디 중복 체크를 완료해주세요.');
        return false;
    }
    
    if(password.length < 4) {
        alert('비밀번호는 4자리 이상 입력해주세요.');
        return false;
    }
    
    if(phone.trim() === '') {
        alert('휴대폰 번호를 입력해주세요.');
        return false;
    }
    
    if(!agree) {
        alert('개인정보 수집/이용에 동의해주세요.');
        return false;
    }
    
    return true;
}
</script>

</body>
</html>