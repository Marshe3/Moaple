<%@page import="com.aischool.entity.Board"%>
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

.board-header {
  margin-bottom: 15px;
  font-size: 18px;
  color: #000;
}

/* 테이블 */
.board-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
}

.board-table .m_table_title { 
  display:none;
}

.board-table thead {
  height: 70px;
  border-top: 1px solid #000;
}

.board-table tbody tr {
  height: 70px;
  border-bottom: 1px solid #DDD;
}

.board-table th, .board-table td {
  padding: 12px;
  text-align: center;
  font-size: 18px;
}

.board-table th {
  background: #f1f3f5;
  font-weight: bold;
}

.board-table td:nth-child(2) {  
  text-align: left;
}

.board-table td:last-child {
  width:15%;
}

.board-table td:nth-child(2) a  {
  display: block;
  width:70%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  color: #000;
  font-weight: 500;
}

/* 페이징 */
.pagination {
  position: absolute;
  bottom: 40px;
  left:510px;
  align-items: center;
  display: flex;
  justify-content: center;
  gap: 6px;
  font-size:14px;
}

.pagination .prev {
  display: block;
  width: 35px;
  height: 37px;
  background:url("${pageContext.request.contextPath}/resources/main/prev.png") no-repeat center center;
  text-indent: -9999px;
  margin-right: 10px;
}

.pagination .next {
  display: block;
  width: 35px;
  height: 37px;
  background:url("${pageContext.request.contextPath}/resources/main/next.png") no-repeat center center;
  text-indent: -9999px;
  margin-left: 10px;
}

.pagination button {
  width: 35px;
  height: 35px;
  border:none;
  background: #fff;
  color: #98A4B4;
  cursor: pointer;
  border-radius: 5px;
}

.pagination button.active {
  background: #00459b;
  color: #fff;
  font-weight: bold;
  border-radius: 100%;
}

/* 글쓰기 버튼 */
.board-footer {
  display: flex;
  justify-content: flex-end;
  position: absolute;
  bottom: 106px;
  right: 35px;
}

.write-btn {
  padding: 10px 20px;
  background: #00459b;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 18px;
}

@media (max-width: 1200px) {
  .board-container {
    padding:50px 60px;
  }
  .board-box {
    width: 100%;
  }
  .board-table th, .board-table td {
    padding:1%;
  }
  .pagination {
    left:calc(50% - 100px);
  }
}

@media (max-width: 1024px) {
  .board-box {
    padding:40px 35px;
    height: 740px;
  }

  .board-table .m_table_title { 
    display:flex;
    gap: 2.5%;
    list-style: none;
    color: #666;
    font-size:16px;
    margin-top: 10px;
  }

  .board-table thead {
    display: none;
  }

  .board-table tbody tr {
    height: 95px;
  }

  .board-table tbody tr:first-child {
    border-top:1px solid #000;
  }

  .board-table td:first-child {
    display: none;
  }

  .board-table td:nth-child(2) {
    padding:1% 1% 1% 2%;
  }

  .board-table td:nth-child(3), 
  .board-table td:nth-child(4), 
  .board-table td:nth-child(5),
  .board-table td:last-child {
    display: none;
  }

}

@media (max-width: 768px) {
  .board-box {
    height:auto;
  }

  table, thead, tbody, tr, td, th {
    display: block;   
    width: 100%;
    border-top:none;
  }
  
  .board-table.list {
    height:600px;
  }

  .board-table td:nth-child(2) {
    padding: 25px 1% 1% 3%;
    height: 100%;
  }

  .board-table .m_table_title { 
    gap: 4%;
  }
  
  .write-btn {
    font-size:14px;
    padding: 10px 15px;
  }

  .pagination {
    gap:0.5%;
  }
}

@media (max-width: 480px) {
  .board-container {
    padding:40px 24px;
  }

  .board-box {
    padding: 40px 15px;
  }

  .board-header {
    font-size:16px;
  }
  .board-table tbody tr {
    height: 75px;
  }

  .board-table td:nth-child(2) {
    padding: 14px 1% 1% 3%;
  }

  .board-table td:nth-child(2) a {
    font-size:16px;
  }

  .board-table .m_table_title { 
    gap: 5%;
    font-size: 14px;
  }

  .pagination {
      left: calc(50% - 115px);
  }

  .pagination .prev {
    margin-right:0;
  }

  .pagination .next {
    margin-left:0;
  }

  .pagination button {
    width: 30px;
    height: 30px;
  }
}
</style>

<body>
  <jsp:include page="nav.jsp"></jsp:include>

  <!-- 게시판 박스 -->
  <main class="board-container">
    <div class="board-box">
      <div class="board-header">
        <p>총 ${page} / ${totalPages} page</p>
      </div>
      
      <table class="board-table list">
        <thead>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>작성일</th>
          </tr>
        </thead>
        <tbody>
        <% ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list"); %>
        <% 
	    	for(int i = 0; i < list.size(); i++) { %>
          <tr>
            <td><%= list.get(i).getCommunityId() %></td>
            <td>
              <a href="boardContents.do?communityId=<%= list.get(i).getCommunityId() %>"><%= list.get(i).getTitle() %></a>
              <ul class="m_table_title">
                <li>등록일</li>
                <li><%= list.get(i).getCreatedAt() %></li>
                <li><%= list.get(i).getViewCount() %></li>
              </ul>
            </td>
            <td><%= list.get(i).getUserId() %></td>
            <td><%= list.get(i).getViewCount() %></td>
            <td><%= list.get(i).getCreatedAt() %></td>
          </tr>
          <% 
				}
			%>
        </tbody>
      </table>

      <!-- 페이징 -->
      <div class="pagination">
        <% if (request.getAttribute("startPage") != null && (Integer)request.getAttribute("startPage") > 1) { %>
          <a href="boardList.do?page=<%= (Integer)request.getAttribute("startPage") - 1 %>" class="prev">이전</a>
        <% } else { %>
          <a href="#none" class="prev">이전</a>
        <% } %>
        
        <% 
          int startPage = (Integer)request.getAttribute("startPage");
          int endPage = (Integer)request.getAttribute("endPage");
          int currentPage = (Integer)request.getAttribute("page");
          
          for (int p = startPage; p <= endPage; p++) {
        %>
          <% if (p == currentPage) { %>
            <button class="active"><%= p %></button>
          <% } else { %>
            <a href="boardList.do?page=<%= p %>"><button><%= p %></button></a>
          <% } %>
        <% } %>
        
        <% if (request.getAttribute("endPage") != null && (Integer)request.getAttribute("endPage") < (Integer)request.getAttribute("totalPages")) { %>
          <a href="boardList.do?page=<%= (Integer)request.getAttribute("endPage") + 1 %>" class="next">다음</a>
        <% } else { %>
          <a href="#none" class="next">다음</a>
        <% } %>
      </div>

      <!-- 글쓰기 버튼 -->
      <div class="board-footer">
        <a href="boardInsert.do"><button class="write-btn">글쓰기</button></a>
      </div>
    </div>
  </main>
</body>
</html>