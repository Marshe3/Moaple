
<%@page import="com.aischool.entity.Reservation.ReservationStatus"%>
<%@page import="com.aischool.entity.Reservation"%>
<%@page import="com.aischool.entity.Users"%>
<%@page import="com.aischool.entity.Comments"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>프로필 페이지</title>
  <style>
    /* 기본 초기화 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  width:100%;
  height:100%;
  font-family: "Noto Sans KR", sans-serif;
  background-color: #E7EAF5;
  color: #333;
  padding: 20px;
  position: relative;
}

/* 헤더 스타일 */
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 30px;
  background-color: white;
  border-bottom: 1px solid #ddd;
}

.logo {
  font-size: 24px;
  font-weight: 700;
  color: #2059cc;
}

.nav-list {
  display: flex;
  list-style: none;
  gap: 30px;
}

.nav-list li {
  cursor: pointer;
  padding: 10px 0;
  font-weight: 600;
  color: #666;
}

.nav-list li.active {
  color: #2059cc;
  border-bottom: 3px solid #2059cc;
}

.content2{color: #555555;}

/* 프로필 카드 레이아웃 */
.profile-card {
  max-width: 1200px;
  min-height: 510px;
  margin: 40px auto;
  background-color: white;
  padding: 30px 40px;
  border-radius: 12px;
  
  text-align: center;
}

/* 프로필 아이콘 */
.profile-icon {
  width: 72px;
  height: 72px;
  margin: 0 auto 10px;
  background-color: #c4c4c4;
  border-radius: 50%;
   /* 프로필 이미지 대체 */
  background-size: cover;
  background-position: center;
}

/* 이름 */
.profile-name {
  font-size: 20px;
  font-weight: 700;
  margin-bottom: 4px;
}

.profile-role {
  font-size: 14px;
  color: #98A4B4;
  margin-bottom: 20px;
}

/* 프로필 수정 버튼 */
.edit-profile-btn {
  background-color: #2059cc;
  color: white;
  border: none;
  border-radius: 6px;
  padding: 8px 20px;
  cursor: pointer;
  font-weight: 600;
  margin-bottom: 30px;
}

.edit-profile-btn:hover {
  background-color: #153d99;
}

/* 탭 메뉴 스타일 */
.tab-menu {
  display: flex;
  justify-content: center;
  gap: 40px;
  margin-bottom: 25px;
}

.tab-btn {
  background: none;
  border: none;
  font-weight: 600;
  font-size: 16px;
  cursor: pointer;
  color: #555;
  padding-bottom: 10px;
  border-bottom: 3px solid transparent;
  transition: all 0.3s;
}

.tab-btn.active {
  color: #2059cc;
  border-color: #2059cc;
}

/* 탭 내용 영역 */
.reservation-item.cancelled{
    max-width: 900px;
  display: flex;
  justify-content: space-between;
  border: 1px solid #ddd;
  border-radius: 6px;
  padding: 12px 20px;
  margin-bottom: 12px;
  font-size: 1px;
 margin: 0 auto;
  flex-direction: column;
}
.reservation-top{
  max-width: 900px;
   display: flex;
  justify-content: space-between;
  align-content: center;
  font-weight: 600 ;
  font-size: 18px;
  color: #333;
}
.reservation-bottom{
  max-width: 900px;
   display: flex;
  justify-content: space-between;
  align-content: center;
  font-weight: 600 ;
  font-size: 15px;
  color: #555555;
  margin-top: 5px;
}
.activity {
  display: flex;
  flex-direction: column;
  gap: 12px; /* 항목 간격 */
  margin-top: 10px;
}

.item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  padding: 12px 16px;
  background: #fff;
}
.left.tag{
  font-size: 18px;
}
.left.date{
  font-size: 15px;
}
.item .left {
  display: flex;
  flex-direction: column;
  min-width: 130px; /* 왼쪽 넓이 고정 */
  
}
.activity-total{
	min-height: 200px;
}
.item .tag {
  color: #1976d2;
  font-weight: bold;
  margin-bottom: 4px;
}

.item .right {
  flex: 1;  /* 오른쪽이 남은 공간 차지 */
  margin-left: 20px;
  font-size: 15px;
}
.comment{color: #00459B;}
.date{
  text-align: left;
  display: inline-block;
}
.tab-content {
  max-width: 900px;
  
  margin: 0 auto;

  
  font-size: 18px;
  color: #555;
}
.status.complete{
  color: #00459B;
}
.status.cancelled{
  color: #FF0004;
}
.recentreserv{
  text-align: left;
  margin-bottom: 5px;
  color: #333;
}
/* 숨김 클래스 */
.hidden {
  display: none;
}
.text-limit {
  display: -webkit-box;        /* flexbox 비슷한 박스 형태 */
  -webkit-box-orient: vertical; /* 세로 방향으로 박스 정렬 */
  -webkit-line-clamp: 3;        /* 최대 줄 수 지정 */
  overflow: hidden;             /* 넘치는 부분 숨김 */
  text-overflow: ellipsis;      /* 말줄임(...) 표시 */
}
/* 예약 내역 스타일 */
.reservation-item {
  
  display: flex;
  justify-content: space-between;
  border: 1px solid #ddd;
  border-radius: 6px;
  padding: 12px 20px;
  margin-bottom: 12px;
  font-size: 14px;
 
  flex-direction: column;
}
.status.complete{ 
  text-align: right; 
  display: inline;
}
.reservation-item.completed {

width: 100%;
  max-width: 900px;
  margin: 0 auto; /* 가운데 정렬 */
  border-color: #4a7cfb;
  height: 90px;
}

.status-span {
  font-size: 13px;
  padding: 4px 10px;
  border: none;
  border-radius: 18px;
  font-weight: 700;
  min-width: 80px;
  text-align: right;
}

.status-btn.complete {
  background-color: #4a7cfb;
  color: white;
}

.status-btn.cancel {
  background-color: #fd5f5f;
  color: white;
}
.cancel-btn{
  width: 65px;
}
.info-box {
  max-width: 600px;
  margin: 0 auto;
  font-family: "Noto Sans KR", sans-serif;
}

.info-box h4 {
  margin-bottom: 12px;
  font-size: 16px;
  font-weight: bold;
}

.info-table {
  width: 100%;
  border-collapse: collapse;
  border: 1px solid #eee;
  border-radius: 8px;
  overflow: hidden;
}

.info-table tr {
  border-bottom: 1px solid #eee;
}

.info-table tr:last-child {
  border-bottom: none;
}

.info-table td {
  padding: 14px;
  font-size: 14px;
}

.info-table td:first-child {
  color: #333;
  font-weight: 500;
  width: 150px;
}

.info-table td:last-child {
  text-align: right;
  color: #555;
}


/* 팝업창 */
.pop{
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background-color: rgba(0, 0, 0, 0.5);
   z-index: 999;
   display: none;
}
.popup{
  position: absolute;
  width: 480px;
  height: 660px;
  background-color: rgb(207, 244, 185);
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  text-align: center;
  border-radius: 25px;
  padding: 20px;
  z-index: 10;
}
.popup > .profile-icon{
  margin-top: 25px;
}


.popup > form{
  text-align: left;
}


.popbtn{
   width: 440px;
  height: 50px;
  text-align: center;
  color: #fff;
  background-color: #aaabab;
  margin-top: 10px;
  border: none;
  border-radius: 15px;
}
.popbtn1{
  background-color: #00459B;
}
.popbtn1:hover{
  background-color: #013574;
  cursor: pointer;
}
.popbtn2{  
  background-color: #aaabab;
}
.popbtn2:hover{  
  background-color: #7a7a7a;
  cursor: pointer;
}
.pop-box{
  width: 440px;
  height: 45px;
  padding-left: 10px;
  border: none;
  border-radius: 12px;
  margin-top: 5px;
}
.pop-select{
  width: 440px;
  height: 45px;
  padding-left: 10px;
  border: none;
  border-radius: 12px;
  margin-top: 5px;
  cursor: pointer;
}
.pop-select>option{
  cursor: pointer;
  
}
.black{
  background-color: rgba(0, 0, 0, 0.5);
}
  </style>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>

<body>
  <jsp:include page="nav.jsp"></jsp:include>
	<% ArrayList<Comments> comment = (ArrayList<Comments>)request.getAttribute("comment");  
   		
		Users user = (Users)request.getAttribute("loginUser"); 
  		ArrayList<Reservation> reserv = (ArrayList<Reservation>)request.getAttribute("reservation"); 
   		
   		String[] roomName =  (String[])request.getAttribute("myroom"); 
   		String trackName = (String)request.getAttribute("trackName");
   		
   		%>
  <div class="container">
    <div class="profile-card">
      <div class="profile-icon" style="background-image: url('<%=request.getContextPath()%>/resources/profile/<%=user.getProfileImg()%>');"></div>
      <h2 class="profile-name"><%= user.getName() %></h2>
      <p class="profile-role"></p>
      <button class="edit-profile-btn">프로필 수정</button>

      <div class="tab-menu">
        <button class="reservation tab-btn active" data-tab="reservation">예약 내역</button>
        <button class="activ tab-btn" data-tab="activity">활동 내역</button>
        <button class="info tab-btn" data-tab="info">내 정보</button>
      </div>
      
      <div class="reserv ">
        <div class="tab-content">
        
           <h2 class="recentreserv">최근 예약</h2>
          <%
          if (reserv != null && !reserv.isEmpty()) {
      		for(int i = 0;i < reserv.size();i++){
      %>
          <!-- DEBUG: 예약 <%= i %> - 상태: <%= reserv.get(i).getStatus() %> -->
          <div class="reservation-item">
            <div class="reservation-top">
              <div class="date"><%= reserv.get(i).getReservationDate() %></div>
              <div class="status">상태: <%= reserv.get(i).getStatus() %></div>
            </div>
            <div class="reservation-bottom">
              <span class="time"><%= reserv.get(i).getStartTime() %> ~ <%= reserv.get(i).getEndTime() %> <%= roomName[i] %></span>
            </div>
          </div>
        <% } }else{%>
		<div style="text-align: center; color: #888; margin-top: 20px;">
        예약 내역이 없습니다.
    	</div>
    	<%} %>
		</div>
      </div>

      <div class="activity-total hidden">
        <div class="tab-content">
          <h2 class="recentreserv">최근 활동</h2>
          <%
          
          int comsize = Math.min(comment.size(), 4);
          if(comment != null && !comment.isEmpty()){
          	for(int i = 0;i < comsize; i++){ %>
          <div class="activity">
            <div class="item">
              <div class="left">
                <span class="tag">[댓글]</span>
                <span class="date"><%=comment.get(i).getUpdatedAt() %></span>
              
              </div>
              <div class="right text-limit">
                <%=comment.get(i).getContent() %>
              </div>
              <%} %>
            </div>
          </div>
		<% }else{ %>
          <div style="text-align: center; color: #888; margin-top: 20px;">
                활동 내역이 없습니다.
            </div>
		<% } %>

        </div>
      </div>

      <div class="info-box hidden">
        <h4>내 정보</h4>
        <table class="info-table">
          <tr>
            <td>이름</td>
            <td><%= user.getName() %></td>
          </tr>
          <tr>
            <td>소속 트랙반</td>
            <td><%= trackName %></td>
          </tr>
          <tr>
            <td>프로젝트 팀명</td>
            <td><%= user.getProjectTeamName() %></td>
          </tr>
          <tr>
            <td></td>
            <td></td>
          </tr>
        </table>
      </div>

    </div>
  </div>
  <div class="pop">
    <div class="popup">
      
      <form action="userModify" method="post" enctype="multipart/form-data"><!-- 어디로 보낼지 -->
        
      	
        <div class="profile-icon"  style="background-image: url('<%=request.getContextPath()%>/resources/profile/<%=user.getProfileImg()%>');"></div>
        <td>프로필변경</td><br>
        <input type="file" name="profileImg">
        <br>
        <td>전화번호</td>
        <br>
        <td><input class="pop-box" name="phone" type="text" value="<%= user.getPhone()%>"></td>
        <br>
        <td class="pop-name">비밀번호</td>
        <br>
        <td><input class="pop-box" name="password" type="password" placeholder="변경할비밀번호를 입력하세요"></td>
        <br>
        <td class="pop-name" >이름</td>
        <br>
        <td><input class="pop-box" type="text" name="name" value="<%= user.getName()%>"></td>
        <br>
        <td class="pop-name">소속 트랙반 번호</td>
        <br>
        <td><select class="pop-select" name="trackId">
        <% 
    String[] trackNames = {
        "자연어 처리 A",
        "자연어 처리 B",
        "컴퓨터 비전 A",
        "컴퓨터 비전 B",
        "AI 플랫폼 및 인프라",
        "AI 서비스 개발 B",
        "AI 서비스 개발 A",
        "AI 서비스 기획",
        "AI 비즈니스",
        "데이터 분석"
    };
%>
        	<% for(int i = 0; i<trackNames.length;i++){ %>
            <option value="<%= i+1 %>" <%= user.getTrackId() == i+1 ? "selected" : "" %>><%=trackNames[i] %></option>
            <% } %>
          </select>
        </td>
        <br>
        <td class="pop-name">프로젝트 팀네임</td>
        <br>
        <td><input class="pop-box" type="text" name="projectTeamName" value="<%= user.getProjectTeamName()%>"></td>
        <br>
        <button type="submit" class="popbtn1 popbtn">저장</button>
        <button type="reset" class="popbtn2 popbtn">취소</button>
      </form>
      
    </div>
  </div>

<script type="text/javascript">
	
		$(".edit-profile-btn").click(function() {
			$(".pop").show();
		});
	$(".popbtn2").click(function(){
			$(".pop").hide();
		});
    $(".reservation").click(function(){
			$(".hidden").removeClass("hidden");
			$(".activity-total").addClass("hidden");
			$(".info-box").addClass("hidden");
			$(".active").removeClass("active");
			$(".reservation").addClass("active");
			
		});
		$(".activ").click(function(){
			$(".hidden").removeClass("hidden");
			$(".reserv").addClass("hidden");
			$(".info-box").addClass("hidden");
			$(".active").removeClass("active");
			$(".activ").addClass("active");
		});
		$(".info").click(function(){
			$(".hidden").removeClass("hidden");
			$(".activity-total").addClass("hidden");
			$(".reserv").addClass("hidden");
			$(".active").removeClass("active");
			$(".info").addClass("active");
		});
	
</script>
</body>

</html>