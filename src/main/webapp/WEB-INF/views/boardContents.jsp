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

.board-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.board-actions button {
  padding: 12px 24px;
  cursor: pointer;
  border-radius: 4px;
  font-size:18px;
}

.list-btn {
  border:1px solid #98A4B4;
  background-color:#fff;
  margin-right: 4px;
}

.comment-btn {
  background-color:#F1F1F1;
  color: #000;
  border:none;
}

.edit-btn {
  border: none;
  background: #E2568C;
  color: white;
}

.delete-btn {
  border: none;
  background: #00459B; 
  color: white;
}

.right-btns {
  display: flex;
  gap: 8px;
}
/* 댓글 섹션 */
.comment-section {
  padding: 25px 0 0 30px;
  margin: 20px 0 30px;
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

  .board-actions button {
    padding: 8px 13px;
    font-size: 16px;
  }

  .list-btn {
    margin-right: 2px;
  }

  .right-btns {
    gap: 5px;
  }
}

/* 댓글 섹션 */
.comment-section {
  padding: 25px 0 0 20px;
  margin: 20px 0 30px;
}

.comment-title {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 15px;
  color: #333;
}

.comment-item {
  border-bottom: 1px solid #f0f0f0;
  padding: 20px 0;
}

.comment-header {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
  gap: 12px;
}

.comment-avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  object-fit: cover;
}

.comment-info {
  flex: 1;
}

.comment-writer {
  font-weight: bold;
  font-size: 14px;
  color: #333;
  display: block;
  margin-bottom: 2px;
}

.comment-role {
  font-size: 12px;
  color: #98A4B4;
  display: block;
}

.comment-date {
  font-size: 12px;
  color: #666;
  margin-left: auto;
}

.comment-content {
  font-size: 14px;
  line-height: 1.5;
  color: #333;
  margin-left: 44px;
}

.comment-actions {
  margin-left: 44px;
  margin-top: 8px;
  opacity: 0;
  transition: opacity 0.2s ease;
}

.comment-item:hover .comment-actions {
  opacity: 1;
}

.comment-edit, .comment-delete {
  font-size: 12px;
  color: #777;
  text-decoration: none;
  margin-right: 6px;
  cursor: pointer;
}

.comment-edit:hover, .comment-delete:hover {
  color: #00459B;
}

.no-comments {
  text-align: center;
  color: #777;
  font-size: 14px;
  padding: 30px 0;
}

@media (max-width: 480px) {

  body {
    padding-bottom:85px;
    box-sizing: border-box;
  }
  .boa1rd-container {
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
  .board-image img {
  	width:100% !important;
  }
  .comment-section {
  padding: 25px 0 0 15px;
  margin: 20px 0 30px;
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
      	// 해당 게시판의 사용자 정보
        Users user = (Users)request.getAttribute("user");
      	if (vo == null) {
            response.sendRedirect("boardList.do");
            return;
        }
      %>
      <div class="board-detail-header">
        <h2 class="board-title"><%= vo.getTitle() %></h2>
        <div class="board-info">
          <span class="writer"><%= user.getName() %></span>
          <span class="date"><%= vo.getCreatedAt() %></span>
          <span class="view">조회수: <%= vo.getViewCount() %></span>
        </div>
      </div>

      <!-- 게시글 본문 -->
      <div class="board-content">
        <% if(vo.getFilepath() != null) { %>
          <div class="board-image">
            <img style="width:200px; height:auto; max-width:100%; margin-bottom:20px; display:block;" src="resources/upload/<%= vo.getFilepath() %>">
          </div>
        <% } %>
        <div class="board-text">
          <%= vo.getContent() != null ? vo.getContent().replace("\n", "<br>") : "" %>
        </div>
      </div>

      <!-- 댓글 섹션 -->
      <div class="comment-section">
        <h3 class="comment-title">댓글</h3>
        <% 
          ArrayList<Comment> commentList = (ArrayList<Comment>)request.getAttribute("commentList");
          Users loginUser = (Users)session.getAttribute("loginUser");
          if (commentList != null && !commentList.isEmpty()) {
            for (Comment comment : commentList) {
        %>
        <div class="comment-item">
          <div class="comment-header">
            <% if(comment.getProfileImg() != null) { %>
              <img class="comment-avatar" src="${pageContext.request.contextPath}/resources/profile/<%= comment.getProfileImg() %>" alt="댓글 작성자">
            <% } else { %>
              <img class="comment-avatar" src="${pageContext.request.contextPath}/resources/profile/default_img.png" alt="댓글 작성자">
            <% } %>
            <div class="comment-info">
              <span class="comment-writer"><%= comment.getWriter() %></span>
              <span class="comment-role"><%= comment.getTrackName() != null ? comment.getTrackName() : "소속 정보 없음" %></span>
            </div>
            <span class="comment-date"><%= comment.getIndate() %></span>
          </div>
          <div class="comment-content">
            <%= comment.getContent() != null ? comment.getContent().replace("\n", "<br>") : "" %>
          </div>
          <% if (loginUser != null && loginUser.getName() != null && loginUser.getName().equals(comment.getWriter())) { %>
          <div class="comment-actions">
            <a href="boardChat.do?communityId=<%= vo.getCommunityId() %>&editComment=<%= comment.getCommentIdx() %>" class="comment-edit">수정</a>
            <a href="commentDelete.do?commentIdx=<%= comment.getCommentIdx() %>&communityId=<%= vo.getCommunityId() %>" class="comment-delete" onclick="return confirm('댓글을 삭제하시겠습니까?')">삭제</a>
          </div>
          <% } %>
        </div>
        <% 
            }
          } else {
        %>
        <div class="no-comments">등록된 댓글이 없습니다.</div>
        <% } %>
      </div>

      <!-- 게시글 버튼 -->
      <div class="board-actions">
        <div class="left-btns">
          <a href="boardList.do"><button class="list-btn">목록</button></a>
          <a href="boardChat.do?communityId=<%= vo.getCommunityId() %>"><button class="comment-btn">댓글</button></a>
        </div>
        <% if (loginUser.getUserId() == vo.getUserId()) { %>
        <div class="right-btns">
          <a href="boardUpdate.do?communityId=<%= vo.getCommunityId() %>"><button class="edit-btn">수정</button></a>
          <a href="boardDelete.do?communityId=<%= vo.getCommunityId() %>"><button class="delete-btn">삭제</button></a>
        </div>
      	<% } %>
      </div>
    </div>
  </div>
</main>
</body>
</html>