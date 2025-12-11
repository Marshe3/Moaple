<%@page import="com.aischool.entity.Board"%>
<%@page import="com.aischool.entity.Users"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
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

.board-scroll.insert {
    max-height: 600px;
}
/* 파이어폭스 */
.post-content {
  scrollbar-width: thin;       
  scrollbar-color: #c8c8c8 #fff; 
}
/* ===== 폼 레이아웃 ===== */
.form{ border-top:1px solid #111; background:#fff; }

/* 한 줄 */
.row{
  display:flex; align-items:flex-start;
  gap:24px; padding:29px 0;
  border-bottom:1px solid #ddd;
}

/* 좌측 라벨 */
.label{
  flex:0 0 110px; 
  padding:10px 0 0 10px;
  font-weight:600; 
  position:relative;
}

/* 우측 필드 */
.field{ 
  flex:1; 
  padding-right:24px; 
}

/* ===== 입력 요소 ===== */
input[type="text"], textarea{
  width:100%; 
  padding:10px 20px; 
  font-size:15px; 
  color:var(--text);
  border:1px solid #A3B5C2; 
  background:#fff; 
  outline:none;
  border-radius:8px; 
  height:46px;
}
textarea{ 
  min-height:140px; 
  height:auto; 
  resize:vertical; 
}
input[type="text"]::placeholder, textarea::placeholder{ 
  color:#98A4B4; 
}

/* ===== 파일 업로드 ===== */
.filebox{ 
  display:flex; 
  align-items:center; 
  gap:14px; 
  flex-wrap:wrap; 
}
.filebox input[type="file"]{ 
  display:none; 
}

.-file{
  height:36px; 
  padding:0 16px; 
  border-radius:5px;
  background:#00459b; 
  color:#fff; 
  font-weight:500; 
  cursor:pointer;
  border:none;
}
.file-name{ 
  color:#98A4B4; 
 }

/* ===== 하단 버튼 ===== */
.actions{ 
  display:flex; 
  justify-content:center; 
  gap:8px; 
  padding:24px 0 0; 
}

.:focus-visible{ 
  outline:3px solid rgba(0,69,155,.25); 
  outline-offset:2px; 
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
  .board-scroll.insert {
    max-height: 630px;
  }
  .row{ 
    flex-direction:column; 
    gap:15px; 
    padding:18px 0; 
  }
  .row.required .label::before {
    top: 2px;
  }
  .label{ 
    flex: none;
    padding: 0 0 0 10px; 
  }
  .field{ 
    width: 100%;
    padding:0px 9px; 
  }
  .actions{ 
    padding:20px 0 28px; 
  }
  .btn { 
    min-width: 104px; 
    height: 50px; 
    padding: 0 18px; 
  }
  .btn-primary {
    font-size: 16px;
    line-height: 51px;
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
  
  .board-scroll.insert {
    max-height: 530px;
  }
  .btn { 
    min-width: 96px; 
  }
  
  .comment-actions { 
    margin-top: 50px;
  }
  
}
</style>
<body>
	<jsp:include page="nav.jsp"></jsp:include>

    <main class="board-container">
	   <div class="board-box">
	      <div class="board-scroll insert">
	    	 
	      <% Board vo = (Board)request.getAttribute("vo"); %>
	      <form id="postForm" class="form" action="boardUpdate.do" method="post" enctype="multipart/form-data">
	    	
	    	
		    <input type="hidden" name="communityId" value="<%= vo.getCommunityId() %>"> <!-- hidden은 눈에 보이지 않게 숨겨 놓겠다-->
		    <input type="hidden" name="currentFilepath" value="<%= vo.getFilepath() %>"> <!-- 기존 파일 경로 -->
	    	
    	    <!-- 제목 -->
	        <div class="row">
	          <div class="label subject">제목</div>
	          <div class="field">
	            <input value="<%= vo.getTitle() %>" type="text" name="title" id="title" placeholder="제목을 입력하세요." />
	          </div>
	        </div>
		      
		    <!-- 내용 -->
	        <div class="row required">
	          <div class="label">내용</div>
	          <div class="field">
	            <textarea name="content" id="content" placeholder="내용을 입력하세요." required><%= vo.getContent() %></textarea>
	          </div>
	        </div>
	    	
	    	<!-- 작성자 -->
		    <div class="row required">
		      <div class="label">작성자</div>
		      <div class="field">
		        <input value="사용자 ID: <%= vo.getUserId() %>" readonly style="background-color: #f5f5f5; cursor: not-allowed;" />
		        <input type="hidden" name="userId" value="<%= vo.getUserId() %>" />
		      </div>
		    </div>
		    
		    <!-- 첨부파일 -->
            <div class="row">
              <div class="label file">첨부파일</div>
              <div class="field">
                <% if(vo.getFilepath() != null && !vo.getFilepath().isEmpty()) { %>
                  <div class="current-image" style="margin-bottom: 15px;">
                    <p style="margin-bottom: 10px; color: #666; font-size: 14px;">현재 첨부된 이미지:</p>
                    <img src="resources/upload/<%= vo.getFilepath() %>" 
                         style="max-width: 200px; height: auto; border: 1px solid #ddd; border-radius: 5px; display: block; margin-bottom: 10px;">
                    <p style="color: #666; font-size: 14px;"><%= vo.getFilepath() %></p>
                  </div>
                <% } %>
                <div class="filebox">
                  <input type="file" name="filepath" id="fileInput">
                  <button type="button" class="-file" id="fileBtn">
                    <% if(vo.getFilepath() != null && !vo.getFilepath().isEmpty()) { %>
                      이미지 변경
                    <% } else { %>
                      파일 선택
                    <% } %>
                  </button>
                  <span class="file-name" id="fileName">
                    <% if(vo.getFilepath() != null && !vo.getFilepath().isEmpty()) { %>
                      새 파일을 선택하면 기존 이미지가 교체됩니다
                    <% } else { %>
                      선택된 파일 없음
                    <% } %>
                  </span>
                </div>
              </div>
            </div>
			
	        <!-- 하단 버튼 -->
	        <div class="actions">
	          <a href="boardList.do"><button type="button" class="btn btn-outline">목록</button></a>
		      <button type="reset" class="btn">취소</button>
			  <button type="submit" class="btn btn-primary">수정</button>
	        </div>
	      </form>
	    </div>
      </div>
   </main>
<script>
  // 파일 선택 버튼 → 파일 탐색기 열기
  const fileBtn = document.getElementById('fileBtn');
  const fileIn = document.getElementById('fileInput');
  const fileName = document.getElementById('fileName');
  
  fileBtn.addEventListener('click', () => fileIn.click());
  
  fileIn.addEventListener('change', () => {
    if (fileIn.files && fileIn.files.length) {
      fileName.textContent = fileIn.files[0].name + ' (새 이미지로 교체될 예정)';
    } else {
      <% if(vo.getFilepath() != null && !vo.getFilepath().isEmpty()) { %>
        fileName.textContent = '새 파일을 선택하면 기존 이미지가 교체됩니다';
      <% } else { %>
        fileName.textContent = '선택된 파일 없음';
      <% } %>
    }
  });
</script>

</body>
</html>