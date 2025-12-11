<%@page import="com.aischool.entity.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 네비게이션 바 시작 -->
<header class="topbar">
  <div class="row">
    <div class="brand">
      <img src="${pageContext.request.contextPath}/resources/main/main_logo.png" 
           alt="모아플 로고" 
           style="height:28px; width:auto; object-fit:contain;"
           onerror="this.style.display='none';">
      <!-- <span>모아플</span>  --> 
    </div>
    <%
      // 현재 페이지 URL 확인
      String currentPage = request.getRequestURI();
      String contextPath = request.getContextPath();
      if (currentPage.startsWith(contextPath)) {
          currentPage = currentPage.substring(contextPath.length());
      }
    %>
    <nav class="nav" aria-label="상단 메뉴">
      <a href="reservation" class="<%= currentPage.contains("reservation") && !currentPage.contains("reservationStatus") ? "active" : "" %>">예약</a>
      <a href="mypage" class="<%= currentPage.contains("mypage") ? "active" : "" %>">마이페이지</a>
      <a href="boardList.do" class="<%= currentPage.contains("board") ? "active" : "" %>">커뮤니티</a>
      <a href="reservationStatus" class="<%= currentPage.contains("reservationStatus") ? "active" : "" %>">예약 현황</a>
    </nav>
    
    <% Users user = (Users)session.getAttribute("loginUser"); %>
    <% if(user == null) { %>
      <div class="auth">
        <a href="login.do" style="color:inherit;">로그인</a>
      </div>
    <% } else { %>
      <div class="auth">
        <%= user.getUserName() %>님 환영합니다. | 
        <a href="logout.do" style="color:inherit;" onclick="return confirmLogout()">로그아웃</a>
      </div>
    <% } %>
  </div>
</header>
<!-- 네비게이션 바 끝 -->

<style>
/* Top bar 스타일 */
.topbar{position:sticky;top:0;z-index:20;background:#fff;border-bottom:1px solid #e5e7eb}
.topbar .row{max-width:1200px;margin:0 auto;display:flex;align-items:center;justify-content:space-between;padding:14px 20px}
.brand{display:flex;align-items:center;gap:10px;font-weight:800}
.nav{display:flex;gap:36px}
.nav a{position:relative;padding:6px 2px;font-weight:600;color:#334155}
.nav a.active{color:#0b4aa2}
.nav a.active::after{content:"";position:absolute;left:0;right:0;bottom:-14px;height:3px;background:#0b4aa2;border-radius:2px}
.auth{color:#64748b;font-weight:600}
.auth a{text-decoration:none}
.auth a:hover{color:#0b4aa2}
</style>

<script>
function confirmLogout() {
    return confirm('정말 로그아웃 하시겠습니까?');
}
</script>