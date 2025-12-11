<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모아플 - AI 사관학교 학생 전용 초간편 원클릭 공간 예약</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Malgun Gothic', sans-serif;
            line-height: 1.6;
            color: #333;
            overflow-x: hidden;
        }

        /* 헤더 */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 0.5rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: #1e40af;
            font-weight: bold;
            font-size: 1.5rem;
        }

        .logo-icon {
            height: 50px;
            margin-right: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo-image {
            height: 100%;
            width: auto;
            object-fit: contain;
        }

        .login-btn {
            background: #1e40af;
            color: white;
            padding: 0.5rem 1.5rem;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
        }

        /* 메인 섹션들 */
        .section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            position: relative;
        }

        .section-1 {
            background: #f1f5f9;
            flex-direction: column;
            text-align: center;
        }

        .hero-content h1 {
            font-size: 2.5rem;
            color: #1e40af;
            margin-bottom: 1rem;
            font-weight: 700;
        }

        .hero-content h2 {
            font-size: 2rem;
            color: #1e40af;
            margin-bottom: 2rem;
            font-weight: 600;
        }

        .cta-button {
            background: #1e40af;
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 4rem;
        }

        .cta-button:hover {
            background: #1d4ed8;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(30, 64, 175, 0.3);
        }

        /* 서비스 카드들 */
        .service-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            width: 100%;
        }

        .service-card {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
        }

        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        /* 채팅 컨테이너 */
        .chat-container {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            width: 100%;
        }

        /* 채팅 메시지 */
        .chat-message {
            display: flex;
            align-items: flex-start;
            gap: 0.8rem;
            max-width: 85%;
        }

        .chat-message.user {
            align-self: flex-end;
            flex-direction: row-reverse;
        }

        .chat-message.bot {
            align-self: flex-start;
        }

        /* 아바타 */
        .chat-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            font-weight: bold;
            flex-shrink: 0;
        }

        .chat-avatar.user {
            background: #ec4899;
            color: white;
        }

        .chat-avatar.bot {
            background: #3b82f6;
            color: white;
        }

        /* 말풍선 */
        .chat-bubble {
            background: #f8fafc;
            padding: 1rem 1.2rem;
            border-radius: 15px;
            position: relative;
            font-size: 0.9rem;
            line-height: 1.5;
        }

        .chat-bubble.user {
            background: #e0f2fe;
        }

        .chat-bubble.bot {
            background: #f0f9ff;
        }

        /* 말풍선 꼬리 */
        .chat-message.user .chat-bubble:after {
            content: '';
            position: absolute;
            top: 15px;
            right: -8px;
            width: 0;
            height: 0;
            border-left: 12px solid #e0f2fe;
            border-top: 8px solid transparent;
            border-bottom: 8px solid transparent;
        }

        .chat-message.bot .chat-bubble:after {
            content: '';
            position: absolute;
            top: 15px;
            left: -8px;
            width: 0;
            height: 0;
            border-right: 12px solid #f0f9ff;
            border-top: 8px solid transparent;
            border-bottom: 8px solid transparent;
        }

        /* 메시지 내용 */
        .chat-name {
            font-weight: 600;
            color: #1e40af;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .chat-bubble p {
            color: #374151;
            margin: 0;
        }

        .moaple-link {
            color: #1e40af;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        /* 섹션 3 - 이미지 콘텐츠 영역 */
        .section-3 {
            background: #f1f5f9;
            flex-direction: column;
            text-align: center;
            padding: 4rem 1rem;
        }

        /* 섹션 4 - 반반 나누어진 영역 */
        .section-4 {
            background: #f8fafc;
            flex-direction: row;
            align-items: center;
            padding: 4rem 2rem;
        }

        .section-4-content {
            display: flex;
            width: 100%;
            max-width: 1200px;
            align-items: center;
            gap: 4rem;
        }

        .section-4-left {
            flex: 1;
            padding-right: 2rem;
        }

        .section-4-title {
            font-size: 2.5rem;
            color: #000;
            margin-bottom: 2rem;
            font-weight: 600;
            line-height: 1.3;
        }

        .section-4-description {
            font-size: 1.1rem;
            color: #6b7280;
            line-height: 1.8;
            margin: 0;
        }

        .highlight {
            color: #1e40af;
            font-weight: 600;
        }

        .section-4-right {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .reservation-image {
            width: 100%;
            height: auto;
            transition: all 0.3s ease;
        }

        .reservation-image:hover {
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .section-4 {
                flex-direction: column;
                padding: 2rem 1rem;
            }
            
            .section-4-content {
                flex-direction: column;
                gap: 2rem;
            }
        }

        .content-area {
            max-width: 1200px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            margin: 0 auto;
        }

        .content-title {
            font-size: 2rem;
            color: #1e40af;
            margin-bottom: 2rem;
            font-weight: 600;
        }

        .content-description {
            font-size: 1.1rem;
            color: #374151;
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .image-container {
            display: flex;
            gap: 2rem;
            justify-content: center;
            align-items: center;
            margin: 3rem 0;
            flex-wrap: wrap;
        }

        .content-image {
            max-width: 45%;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .content-image:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        @media (max-width: 768px) {
            .content-image {
                max-width: 100%;
            }
            
            .image-container {
                flex-direction: column;
                gap: 1.5rem;
            }
        }

        /* 섹션 2 - 기능 소개 */
        .section-2 {
            background: #f8fafc;
            flex-direction: column;
        }

        .section-2 h2 {
            text-align: center;
            font-size: 2rem;
            color: #1e40af;
            margin-bottom: 3rem;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-template-rows: repeat(2, 1fr);
            gap: 2rem;
            max-width: 1000px;
        }

        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
        }

        .feature-icon {
            width: 50px;
            height: 50px;
            margin: 0 auto 1rem;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
        }

        .feature-icon.calendar { background: #3b82f6; color: white; }
        .feature-icon.chat { background: #06b6d4; color: white; }
        .feature-icon.check { background: #10b981; color: white; }
        .feature-icon.mobile { background: #8b5cf6; color: white; }

        /* 로그인 모달 */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 2000;
            animation: fadeIn 0.3s ease;
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 2rem;
            border-radius: 20px;
            width: 90%;
            max-width: 400px;
            animation: slideUp 0.3s ease;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #666;
        }

        .login-form input {
            width: 100%;
            padding: 1rem;
            margin-bottom: 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 1rem;
        }

        .login-form input:focus {
            outline: none;
            border-color: #1e40af;
        }

        .modal-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .login-submit {
            flex: 1;
            background: #1e40af;
            color: white;
            padding: 1rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .login-submit:hover {
            background: #1d4ed8;
        }

        .signup-btn {
            flex: 1;
            background: #f3f4f6;
            color: #374151;
            padding: 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .signup-btn:hover {
            background: #e5e7eb;
            border-color: #d1d5db;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .header {
                padding: 1rem;
            }

            .hero-content h1 {
                font-size: 2rem;
            }

            .hero-content h2 {
                font-size: 1.5rem;
            }

            .service-cards {
                grid-template-columns: 1fr;
            }

            .section {
                padding: 1rem;
                min-height: auto;
                padding-top: 5rem;
            }

            .section-1 {
                min-height: 100vh;
            }
        }

        /* 애니메이션 */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { 
                opacity: 0;
                transform: translate(-50%, -30%);
            }
            to { 
                opacity: 1;
                transform: translate(-50%, -50%);
            }
        }

        .fade-in {
            opacity: 0;
            animation: fadeInUp 0.8s ease forwards;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <!-- 헤더 -->
    <header class="header">
        <a href="#home" class="logo">
            <div class="logo-icon">
                <img src="${pageContext.request.contextPath}/resources/main/main_logo.png" 
                     alt="모아플 로고" 
                     class="logo-image"
                     onerror="this.style.display='none';">
            </div>
        </a>
        <button class="login-btn" onclick="openModal()">로그인</button>
    </header>

    <!-- 섹션 1: 히어로 -->
    <section id="home" class="section section-1">
        <div class="hero-content fade-in">
            <h1>AI 사관학교 학생 전용,</h1>
            <h2>초간편 원클릭 공간 예약!</h2>
            <button class="cta-button">예약하기</button>
            
            <div class="service-cards">
                <!-- 카드 1: 자원의 처리반 -->
                <div class="service-card">
                    <div class="chat-container">
                        <!-- 사용자 메시지 -->
                        <div class="chat-message user">
                            <div class="chat-avatar user">자</div>
                            <div class="chat-bubble user">
                                <div class="chat-name">자연어 처리반</div>
                                <p>전체 회의실의 예약 상황을 한눈에 볼 수 없어서 여러 번 파일을 확인해야 해요.</p>
                            </div>
                        </div>
                        
                        <!-- 모아플 봇 응답 -->
                        <div class="chat-message bot">
                            <div class="chat-avatar bot">모</div>
                            <div class="chat-bubble bot">
                                <a href="#" class="moaple-link">모아플(Moaple) 🏢</a>
                                <p>웹/모바일에서 전체 회의실의 예약 가능 시간표를 실시간으로 조회 가능합니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 카드 2: 서비스 기획팀 -->
                <div class="service-card">
                    <div class="chat-container">
                        <!-- 사용자 메시지 -->
                        <div class="chat-message user">
                            <div class="chat-avatar user">서</div>
                            <div class="chat-bubble user">
                                <div class="chat-name">서비스 기획반</div>
                                <p>프로젝트 회의 시 장소를 대여해야 할 때마다 일일이 확인하고 작성해야 하는 번거로움이 있습니다.</p>
                            </div>
                        </div>
                        
                        <!-- 모아플 봇 응답 -->
                        <div class="chat-message bot">
                            <div class="chat-avatar bot">모</div>
                            <div class="chat-bubble bot">
                                <a href="#" class="moaple-link">모아플(Moaple) →</a>
                                <p>저희 모아플은 회의 장소 예약을 한 번에 확인 및 신청할 수 있는 플랫폼으로 번거로움 없이 예약 가능합니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 카드 3: 데이터 분석팀 -->
                <div class="service-card">
                    <div class="chat-container">
                        <!-- 사용자 메시지 -->
                        <div class="chat-message user">
                            <div class="chat-avatar user">데</div>
                            <div class="chat-bubble user">
                                <div class="chat-name">데이터 분석반</div>
                                <p>비어 있다고 확인 후 예약했지만, 실제로는 장소 대여가 불가능한 경우가 있었습니다.</p>
                            </div>
                        </div>
                        
                        <!-- 모아플 봇 응답 -->
                        <div class="chat-message bot">
                            <div class="chat-avatar bot">모</div>
                            <div class="chat-bubble bot">
                                <a href="#" class="moaple-link">모아플(Moaple) 📊</a>
                                <p>시설 관리자 또는 담당자의 승인 절차를 거쳐 확정 예약 처리되도록 하였습니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 섹션 3: 서비스 소개 -->
    <section class="section section-3">
        <div class="fade-in">
            <div class="content-area">
                <h2 class="content-title">모아플(Moaple)은<br> 여러분을 위해 편리함을 제공합니다.</h2>

                
                <div class="image-container">
                    <img src="${pageContext.request.contextPath}/resources/main/image 1.png" 
                         alt="모아플 서비스 이미지 1" 
                         class="content-image"
                         onerror="this.style.display='none';">
                    <img src="${pageContext.request.contextPath}/resources/main/image 2.png" 
                         alt="모아플 서비스 이미지 2" 
                         class="content-image"
                         onerror="this.style.display='none';">
                </div>
            </div>
        </div>
    </section>

    <!-- 섹션 2: 기능 소개 -->
    <section class="section section-2">
        <div class="fade-in">
            <h2>복잡한 장소 대여를 편리하게<br>예약하도록 도와드려요</h2>
            
            <div class="feature-grid">
                <div class="feature-card">
                    <div class="feature-icon calendar">📅</div>
                    <h3>날짜, 장소, 시간별 예약</h3>
                    <p>필요에 맞게 날짜, 장소, 시간을 지정하여 예약을 등록할 수 있습니다.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon chat">💬</div>
                    <h3>커뮤니티 댓글 기능</h3>
                    <p>관심 있는 주제에 대해 다른 사용자와 직접 소통하고 피드백을 주고받을 수 있습니다.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon check">✓</div>
                    <h3>실시간 예약 현황 확인</h3>
                    <p>실시간 데이터로 정확한 예약 정보를 체크합니다.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon mobile">📱</div>
                    <h3>웹/모바일 모든 예약 가능</h3>
                    <p>이동 중에도 모바일로 바로 예약을 진행 할 수 있으며, PC에서도 편리하게 이용 할 수 있습니다.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- 섹션 4: 이미지 섹션 -->
    <section class="section section-4">
        <div class="section-4-content fade-in">
            <div class="section-4-left">
                <h2 class="section-4-title">빠르고 직관적인 원클릭 <br> 예약으로 시간을 절약하세요</h2>
                <p class="section-4-description">
                    사용자가 빠르고 쉽게, <span class="highlight">클릭 한 번으로 원하는 장소를 예약</span>할 수 있도록 직관적이고 간편한 예약 시스템으로 제작하였습니다. 실시간 반영과 깔끔한 UI를 통해 누구나 부담 없이 이용할 수 있습니다.
                </p>
            </div>
            <div class="section-4-right">
                <img src="${pageContext.request.contextPath}/resources/main/main-resvervation.png" 
                     alt="모아플 예약 시스템" 
                     class="reservation-image"
                     onerror="this.style.display='none';">
            </div>
        </div>
    </section>

    <!-- 이미지 섹션 3: 최종 푸터 -->
    <section class="image-section">
        <img src="${pageContext.request.contextPath}/resources/images/final-footer.png" 
             alt="최종 푸터" 
             onerror="this.style.display='none';">
    </section>

    <!-- 로그인 모달 -->
    <div id="loginModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>로그인</h3>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <form class="login-form" action="${pageContext.request.contextPath}/login.do" method="post">
            	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                <input type="text" name="userName" placeholder="아이디" required>
                <input type="password" name="password" placeholder="비밀번호" required>
                <div class="modal-buttons">
                    <button type="submit" class="login-submit">로그인</button>
                    <button type="button" class="signup-btn" onclick="goToSignup()">회원가입</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 스크롤 애니메이션
        function handleScrollAnimation() {
            const elements = document.querySelectorAll('.fade-in');
            elements.forEach(element => {
                const elementTop = element.getBoundingClientRect().top;
                const elementVisible = 150;
                
                if (elementTop < window.innerHeight - elementVisible) {
                    element.style.animationPlayState = 'running';
                }
            });
        }

        // 부드러운 스크롤
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // 모달 함수들
        function openModal() {
            document.getElementById('loginModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            document.getElementById('loginModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        // 모달 외부 클릭시 닫기
        document.getElementById('loginModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });

        // 스크롤 이벤트 리스너
        window.addEventListener('scroll', handleScrollAnimation);
        window.addEventListener('load', handleScrollAnimation);

        // ESC 키로 모달 닫기
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        });

        // 회원가입 페이지로 이동
        function goToSignup() {
            // 회원가입 페이지 URL로 이동 (필요에 따라 수정)
            window.location.href = '${pageContext.request.contextPath}/join.do';
        }

        // 페이지 로드 시 로그인 에러 체크
        window.addEventListener('load', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('loginError') === 'true') {
                alert('로그인에 실패했습니다. 아이디와 비밀번호를 확인해주세요.');
                // URL에서 에러 파라미터 제거
                const newUrl = window.location.origin + window.location.pathname;
                window.history.replaceState({}, document.title, newUrl);
            }
        });
    </script>
</body>
</html>