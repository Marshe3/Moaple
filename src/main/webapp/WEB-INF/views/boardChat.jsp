<%@page import="com.aischool.entity.Board"%>
<%@page import="com.aischool.entity.Comment"%>
<%@page import="com.aischool.entity.Users"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모아플 커뮤니티</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/main/favicon.png">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Pretendard', sans-serif;
}

body {
  background: #E7EAF5;
  color: #333;
}

a:link { 
  color:#000;
  border-bottom:none;
  text-decoration: none;
}
/* 게시판 */
.board-container {
  overflow: hidden;
  display: flex;
  justify-content: center;
  padding: 50px 0;
  background-color: #E7EAF5;
  box-sizing: border-box;
}

.board-box {
  
  position: relative;
  width: 1200px;
  height: 705px;;
  background: #fff;
  border-radius: 30px;
  padding: 65px 35px 40px;
  box-sizing: border-box;
  box-shadow: 0px 5px 50px 20px #00000008;
}
.board-scroll {
  overflow: auto;
  max-width: 100%;
  max-height: 570px; 
  scrollbar-gutter: stable both-edges; 
  padding-right: 5px;
}

/* 크롬, 엣지, 사파리(웹킷 기반) */
.board-scroll::-webkit-scrollbar {
  width: 7px; 
  height: 7px;
}

.board-scroll::-webkit-scrollbar-track {
  background: #f7f7f7; 
  border-radius: 10px;
}

.board-scroll::-webkit-scrollbar-thumb {
  background: #c8c8c8; 
  border-radius: 10px;
}

/* 파이어폭스 */
.post-content {
  scrollbar-width: thin;       
  scrollbar-color: #c8c8c8 #fff; 
}
.board-detail-header {
  border-top: 1px solid #000;
  border-bottom: 1px solid #ddd;
  padding: 29px;
  margin-bottom: 15px;
  background-color:#F6F8FA;
}

.board-title {
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 10px;
  width:80%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.board-info {
  font-size: 14px;
  color: #666;
}

.board-info span {
  margin-right: 16px;
}

.board-content {
  padding: 20px 29px 31px;
  font-size: 16px;
  line-height: 1.6;
  border-bottom: 1px solid #ddd;
  margin-bottom: 15px;
}
.board-content.chat {
  margin-bottom:0;
}
/* 접근성용 숨김 텍스트 */
.sr-only {
  position:absolute; 
  width:1px; 
  height:1px; 
  padding:0; 
  margin:-1px;
  overflow:hidden; 
  clip:rect(0,0,0,0); 
  white-space:nowrap; 
  border:0;
}

.comment-avatar {
  width:28px;
  height:28px;
  margin-bottom: 17px;
}

/* 댓글 작성 섹션 */
.comment-write { 
  padding: 25px 29px;    
  border-bottom:1px solid #ddd;
}

.comment-form-header{
  display:flex; 
  align-items:center; 
  gap:12px;
  margin-bottom:10px;
}

.comment-name{ 
  display: block;
  font-size:18px; 
  font-weight:500; 
  color:#000; 
  margin-bottom: 5px;
}

.comment-role{ 
  font-size:14px; 
  color:#98A4B4; 
}

/* 입력 textarea (말풍선 느낌) */
.comment-textarea{
  width:100%;
  min-height:120px;
  padding:14px 16px;
  border-radius:12px;
  background:#F6F8FA;
  border:1px solid #EEF1F5;
  font-size:15px; line-height:1.6; color:#111827;
  resize:vertical; outline:none;
  transition:border-color .15s ease, box-shadow .15s ease;
  /* 입력창 안 스크롤도 커스텀 */
  scrollbar-width: thin;                 
  scrollbar-color:#c8c8c8 #EDEFF3;       
}

.comment-textarea:focus{
  border-color:#00459B;
  box-shadow:0 0 0 3px rgba(0,69,155,.12);
}

/* 작성 버튼 */
.comment-actions{
  display:flex; 
  justify-content:center; 
  gap:8px;
  margin-top: 60px;
}

.btn {
  min-width: 120px;
  height: 45px;
  padding: 0 22px;
  font-weight: 600;
  border-radius: 5px;
  border: 1px solid transparent;
  cursor: pointer;
  transition: .16s;
  font-size: 16px;
}

.btn-outline {
  background: #fff;
  border-color: #A3B5C2;
  color: #000;
}

.btn-primary {
  background: #00459B;
  color: #fff;
}

@media (max-width: 1200px) {
  .board-container {
    padding:50px 60px;
  }
  .board-box {
    width: 100%;
  }
}

@media (max-width: 1024px) {
  .board-box {
    padding:40px 35px;
  }
  .board-scroll {
    max-height: 620px; 
  }

}

@media (max-width: 768px) {
  .board-box {
    height:auto;
  }
  .board-title {
    font-size:18px;
  }

  .board-detail-header {
    padding: 29px 17px;
  }

  .board-content {
  padding: 20px 17px 31px;
  }
  .board-detail-header {
    padding: 29px 17px;
  }

  .board-actions button {
    padding: 8px 13px;
    font-size: 16px;
  }

  .comment-section { 
    padding: 0 17px; 
  }
  .comment-write {
    padding: 25px 17px;
  }
  .board-actions--center { 
    padding: 20px 17px; 
  }
  .btn { 
    min-width: 104px !important; 
    height: 50px !important; 
    padding: 0 18px !important; 
  }
  .btn-primary {
    font-size: 16px !important;
    line-height: 51px !important;
  }
}

@media (max-width: 480px) {

  body {
    padding-bottom:85px;
    box-sizing: border-box;
  }
  .board-container {
    padding:40px 24px;
  }

  .board-box {
    padding: 40px 15px;
  }
  .board-scroll {
    max-height: 535px; 
  }
  .board-detail-header {
    padding: 20px 17px;
    margin-bottom:0;
  }

  .board-title {
    font-size: 16px;
  }

  .board-info span {
    margin-right: 12px;
  }
  .comment-section { 
    padding: 0 17px; 
  }

  .comment-avatar {
    width: 22px;
    height: 22px;
  }
  
  .comment-name {
    font-size: 16px;
    margin-bottom:0;
  }

  .comment-role {
    font-size: 12px;
  }
  .btn { 
    min-width: 96px !important; 
  }
  
  .comment-actions { 
    margin-top: 50px;
  }
}
</style>
  <jsp:include page="nav.jsp"></jsp:include>

  <!-- 게시판 박스 -->
  <main class="board-container">
    <div class="board-box">
      <div class="board-scroll">
      
        <!-- 게시글 헤더 -->
        <% 
          Board vo = (Board)request.getAttribute("vo"); 
          if (vo == null) {
              response.sendRedirect("boardList.do");
              return;
          }
        %>
        <div class="board-detail-header">
          <h2 class="board-title"><%= vo.getTitle() %></h2>
          <div class="board-info">
            <span class="writer">사용자 ID: <%= vo.getUserId() %></span>
            <span class="date"><%= vo.getCreatedAt() %></span>
            <span class="view">조회수: <%= vo.getViewCount() %></span>
          </div>
        </div>

        <!-- 게시글 본문 -->
        <div class="board-content chat">
          <% if(vo.getFilepath() != null) { %>
          <div class="board-image">
            <img style="width:200px; height:auto; max-width:100%; margin-bottom:20px; display:block;" src="resources/upload/<%= vo.getFilepath() %>">
          </div>
	      <% } %>
	      <div class="board-text">
	        <%= vo.getContent() != null ? vo.getContent().replace("\n", "<br>") : "" %>
	      </div>
        </div>

        <% 
        
        // comment entity 불러오기  
        Comment editComment = (Comment)request.getAttribute("editComment");
        // comment가 존재하는지 여부 체크
        boolean isEdit = (editComment != null);
        %>
        <!-- comment가 이미 존재할시에는 update로 아니면 insert  -->
        <form action="<%= isEdit ? "commentUpdate.do" : "commentInsert.do" %>" method="post">
          <input type="hidden" name="communityId" value="<%= vo.getCommunityId() %>">
          <% if (isEdit && editComment != null) { %>
          <input type="hidden" name="commentIdx" value="<%= editComment.getCommentIdx() %>">
          <% } %>
          <section class="comment-write">
            <!-- 프로필 + 이름/소속반 그룹 -->
            <% Users loginUser = (Users)session.getAttribute("loginUser"); %>
            <div class="comment-form-header">
              <% if(loginUser != null && loginUser.getProfileImg() != null) { %>
                <img class="comment-avatar" src="${pageContext.request.contextPath}/resources/profile/<%= loginUser.getProfileImg() %>" alt="작성자">
              <% } else { %>
                <img class="comment-avatar" src="${pageContext.request.contextPath}/resources/profile/default_img.png" alt="작성자">
              <% } %>
              <div class="comment-id">
                <strong class="comment-name"><%= loginUser != null ? loginUser.getName() : "로그인 필요" %></strong>
                <span class="comment-role">
                  <% if (isEdit && editComment != null && editComment.getTrackName() != null) { %>
                    <%= editComment.getTrackName() %>
                  <% } else if (loginUser != null) { %>
                    <!-- 로그인한 사용자의 트랙명을 표시하려면 추가 로직 필요 -->
                    소속 정보 없음
                  <% } else { %>
                    소속 정보 없음
                  <% } %>
                </span>
              </div>
            </div>

            <!-- 댓글 입력창 -->
            <% if (!isEdit && loginUser != null) { %>
            <input type="hidden" name="writer" value="<%= loginUser.getUserId() %>">
            <% } %>
            <label for="comment-text" class="sr-only"><%= isEdit ? "댓글 수정" : "댓글 입력" %></label>
            <textarea id="comment-text" name="content" class="comment-textarea" 
                      placeholder="<%= isEdit ? "댓글을 수정하세요." : "댓글을 입력하세요." %>" required><%= (isEdit && editComment != null) ? editComment.getContent() : "" %></textarea>
          </section>
          <!-- 작성 버튼 -->
          <div class="comment-actions">
            <% if (isEdit) { %>
            <a href="boardContents.do?communityId=<%= vo.getCommunityId() %>"><button type="button" class="btn btn-outline">취소</button></a>
            <button type="submit" class="btn btn-primary">수정</button>
            <% } else { %>
            <a href="boardList.do"><button type="button" class="btn btn-outline">목록</button></a>
            <button type="submit" class="btn btn-primary">등록</button>
            <% } %>
          </div>
        </form>
      </div>
    </div>
  </main>
</body>
</html>