<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모아플 - 예약 현황</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .header-logo {
            font-size: 24px;
            font-weight: bold;
            color: #1a73e8;
        }

        .user-menu {
            display: flex;
            align-items: center;
        }

        .user-menu span {
            margin-right: 15px;
            font-size: 14px;
            color: #555;
            cursor: pointer;
        }

        .user-menu-profile {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background-color: #e0e0e0;
            cursor: pointer;
        }

        .nav-bar {
            display: flex;
            background-color: #1a73e8;
            color: #fff;
            padding: 15px 0;
            justify-content: center;
        }

        .nav-link {
            padding: 0 30px;
            font-size: 16px;
            cursor: pointer;
            position: relative;
            color: #fff;
            text-decoration: none;
        }

        .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: #fff;
        }

        .container {
            padding: 40px;
        }

        .reservation-board {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .board-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .tab-menu {
            display: flex;
            border-bottom: 1px solid #e0e0e0;
            margin-bottom: 20px;
        }

        .tab {
            padding: 10px 20px;
            cursor: pointer;
            color: #555;
            font-weight: bold;
            transition: color 0.3s;
            text-decoration: none;
        }

        .tab.active {
            color: #1a73e8;
            border-bottom: 2px solid #1a73e8;
        }

        .tab:hover {
            color: #1a73e8;
        }

        .reservation-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
            min-height: 500px;
        }

        .reservation-item {
            display: flex;
            align-items: center;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            transition: box-shadow 0.3s;
        }

        .reservation-item:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .item-image {
            width: 120px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 8px;
            margin-right: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
            font-weight: bold;
            text-align: center;
        }

        .item-details {
            flex-grow: 1;
        }

        .item-info {
            font-size: 14px;
            color: #777;
            margin-bottom: 5px;
        }

        .item-room {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .item-button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .status-completed {
            background-color: #e0e0e0;
            color: #777;
            cursor: not-allowed;
            opacity: 0.7;
        }

        .status-available {
            background-color: #1a73e8;
            color: #fff;
            cursor: pointer;
        }

        .status-available:hover {
            background-color: #0d47a1;
            transform: translateY(-1px);
        }

        .status-unavailable {
            background-color: #f44336;
            color: #fff;
            cursor: not-allowed;
            opacity: 0.7;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            gap: 5px;
        }

        .pagination a {
            padding: 8px 12px;
            text-decoration: none;
            color: #555;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: all 0.3s;
        }

        .pagination a.active {
            background-color: #1a73e8;
            color: #fff;
            border-color: #1a73e8;
        }

        .pagination a:hover:not(.active) {
            background-color: #f0f0f0;
        }

        .no-data {
            text-align: center;
            color: #777;
            font-size: 16px;
            padding: 100px 0;
        }

        .status-info {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 20px;
            font-size: 14px;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <jsp:include page="nav.jsp"></jsp:include>

    <div class="container">
        <div class="reservation-board">
            <div class="board-title">전체 예약 현황</div>
            
            <div class="status-info">
                현재 상태: <strong>${currentStatus}</strong> | 
                페이지: <strong>${currentPage}</strong> / <strong>${totalPages}</strong> | 
                전체 항목: <strong>${totalItems}</strong>개
            </div>
            
            <div class="tab-menu">
                <a href="#" class="tab ${currentStatus == '전체' ? 'active' : ''}" onclick="loadReservations('전체', 1)">전체</a>
                <a href="reservation" class="tab ${currentStatus == '예약 가능' ? 'active' : ''}" onclick="loadReservations('예약 가능', 1)">예약 가능</a>
                <a href="reservation" class="tab ${currentStatus == '예약 불가' ? 'active' : ''}" onclick="loadReservations('예약 불가', 1)">예약 불가</a>
            </div>

            <div class="reservation-list">
                <c:choose>
                    <c:when test="${empty allReservations}">
                        <div class="no-data">
                            해당하는 예약 현황이 없습니다.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="reservation" items="${allReservations}">
                            <div class="reservation-item">
                                <div class="item-image">
                                    <c:choose>
                                        <c:when test="${fn:contains(reservation.room, 'AI Cafe') || fn:contains(reservation.room, 'AI 카페')}">
                                            <img src="${pageContext.request.contextPath}/resources/main/aicafe.jpg" alt="AI 카페" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />
                                        </c:when>
                                        <c:when test="${fn:contains(reservation.room, '세미나실') && fn:contains(reservation.floorDisplay, '2층')}">
                                            <img src="${pageContext.request.contextPath}/resources/main/f2seminar.jpg" alt="2층 세미나실" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />
                                        </c:when>
                                        <c:when test="${fn:contains(reservation.room, '휴게공간') && fn:contains(reservation.floorDisplay, '2층')}">
                                            <img src="${pageContext.request.contextPath}/resources/main/f2foyer.jpg" alt="2층 휴게공간" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />
                                        </c:when>
                                        <c:when test="${fn:contains(reservation.room, 'AI Lab 1') || fn:contains(reservation.room, 'AI Lab1')}">
                                            <img src="${pageContext.request.contextPath}/resources/main/f2ailab.jpg" alt="2층 AI Lab 1" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />
                                        </c:when>
                                        <c:when test="${fn:contains(reservation.room, 'AI Lab 2') || fn:contains(reservation.room, 'Ai Lab 2') || fn:contains(reservation.room, 'AI Lab2')}">
                                            <img src="${pageContext.request.contextPath}/resources/main/f3ailab.jpg" alt="3층 AI Lab 2" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />
                                        </c:when>
                                        <c:when test="${fn:contains(reservation.room, '세미나실') && fn:contains(reservation.floorDisplay, '3층')}">
                                            <img src="${pageContext.request.contextPath}/resources/main/f3seminar.jpg" alt="3층 세미나실" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />
                                        </c:when>
                                        <c:when test="${fn:contains(reservation.room, '휴게공간') && fn:contains(reservation.floorDisplay, '3층')}">
                                            <img src="${pageContext.request.contextPath}/resources/main/f3foyer.jpg" alt="3층 휴게공간" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />
                                        </c:when>
                                        <c:otherwise>
                                            <div style="display: flex; align-items: center; justify-content: center; color: white; font-size: 12px; font-weight: bold; text-align: center;">
                                                ${reservation.room}<br/>이미지
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="item-details">
                                    <div class="item-info">${reservation.date}</div>
                                    <div class="item-info">예약 현황: ${reservation.time_info}</div>
                                    <div class="item-room">${reservation.floorDisplay} ${reservation.room}</div>
                                </div>
                                <c:choose>
                                    <c:when test="${reservation.status == '예약 가능'}">
                                        <button class="item-button status-available">${reservation.status}</button>
                                    </c:when>
                                    <c:when test="${reservation.status == '예약 불가'}">
                                        <button class="item-button status-unavailable" disabled>${reservation.status}</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="item-button status-completed" disabled>${reservation.status}</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- 페이지네이션 -->
            <div id="paginationContainer">
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <!-- 이전 페이지 -->
                        <c:if test="${hasPrevious}">
                            <a href="#" onclick="loadReservations('${currentStatus}', ${currentPage - 1})">&lt;</a>
                        </c:if>
                        
                        <!-- 페이지 번호들 -->
                        <c:forEach var="pageNum" items="${pageNumbers}">
                            <c:choose>
                                <c:when test="${pageNum == currentPage}">
                                    <a href="#" class="active">${pageNum}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="#" onclick="loadReservations('${currentStatus}', ${pageNum})">${pageNum}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        
                        <!-- 다음 페이지 -->
                        <c:if test="${hasNext}">
                            <a href="#" onclick="loadReservations('${currentStatus}', ${currentPage + 1})">&gt;</a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        function logout() {
            alert('로그아웃 기능은 구현 예정입니다.');
        }

        // 페이지 로드 완료 확인
        console.log('reservationStatus.jsp 로드 완료');
        console.log('현재 상태:', '${currentStatus}');
        console.log('현재 페이지:', '${currentPage}');
        console.log('총 페이지:', '${totalPages}');
        console.log('데이터 개수:', ${empty allReservations ? 0 : allReservations.size()});

        // 예약 버튼 처리 시스템
        document.addEventListener('DOMContentLoaded', function() {
            console.log('=== 예약 버튼 시스템 초기화 ===');
            
            const buttons = document.querySelectorAll('.item-button');
            console.log('발견된 버튼 개수:', buttons.length);
            
            buttons.forEach(function(button, index) {
                const reservationItem = button.closest('.reservation-item');
                if (!reservationItem) {
                    console.log('예약 아이템을 찾을 수 없음:', index);
                    return;
                }
                
                // 예약 정보 추출
                const itemInfos = reservationItem.querySelectorAll('.item-info');
                const itemRoom = reservationItem.querySelector('.item-room');
                
                const date = itemInfos[0] ? itemInfos[0].textContent.trim() : '';
                const timeInfo = itemInfos[1] ? itemInfos[1].textContent.replace('예약 현황: ', '').trim() : '';
                const roomText = itemRoom ? itemRoom.textContent.trim() : '';
                const status = button.textContent.trim();
                
                // "1층 AI 카페" → floor: "1층", room: "AI 카페" 분리
                const roomParts = roomText.split(' ');
                const floor = roomParts[0] || '';
                const room = roomParts.slice(1).join(' ') || '';
                
                console.log('버튼 ' + (index + 1) + ' 정보:');
                console.log('  - 층:', floor);
                console.log('  - 방:', room);
                console.log('  - 날짜:', date);
                console.log('  - 시간 정보:', timeInfo);
                console.log('  - 상태:', status);
                
                // 상태별 버튼 처리
                if (status === '예약 가능') {
                    setupAvailableButton(button, floor, room, date, timeInfo, status);
                } else if (status === '예약 완료' || status === '예약 불가') {
                    setupDisabledButton(button, status);
                }
            });
            
            console.log('버튼 시스템 초기화 완료');
        });
        
        function setupAvailableButton(button, floor, room, date, timeInfo, status) {
            console.log('예약 가능 버튼 설정:', floor, room);
            
            button.style.cursor = 'pointer';
            button.addEventListener('click', function(event) {
                event.preventDefault();
                event.stopPropagation();
                
                console.log('=== 예약 가능 버튼 클릭 ===');
                console.log('예약 페이지로 이동:', {floor, room, date, timeInfo, status});
                
                // reservation.jsp로 이동하면서 필요한 데이터를 URL 파라미터로 전달
                const urlParams = new URLSearchParams({
                    floor: floor || '',
                    room: room || '',
                    date: date || '',
                    timeInfo: timeInfo || '',
                    status: status || ''
                });
                
                const reservationUrl = 'reservation?' + urlParams.toString();
                console.log('이동할 URL:', reservationUrl);
                
                // 예약 페이지로 이동
                window.location.href = reservationUrl;
            });
        }
        
        function setupDisabledButton(button, status) {
            console.log('비활성화 버튼 설정:', status);
            
            button.style.cursor = 'not-allowed';
            button.addEventListener('click', function(event) {
                event.preventDefault();
                event.stopPropagation();
                
                console.log('비활성화된 버튼 클릭:', status);
                
                let message = '';
                if (status === '예약 완료') {
                    message = '이미 예약이 완료된 항목입니다.';
                } else if (status === '예약 불가') {
                    message = '예약이 불가능한 항목입니다.';
                } else {
                    message = '클릭할 수 없는 상태입니다.';
                }
                
                showNotification(message, 'warning');
            });
        }
        
        
        function showNotification(message, type) {
            console.log('알림 표시:', message, '타입:', type);
            
            // 기존 알림 제거
            const existingNotification = document.querySelector('.reservation-notification');
            if (existingNotification) {
                existingNotification.remove();
            }
            
            // 새 알림 생성
            const notification = document.createElement('div');
            notification.className = 'reservation-notification';
            notification.textContent = message;
            
            // 기본 스타일
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 16px 24px;
                border-radius: 8px;
                color: white;
                font-weight: bold;
                font-size: 14px;
                z-index: 10000;
                max-width: 320px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.3);
                transform: translateX(100%);
                transition: transform 0.3s ease-out;
                word-wrap: break-word;
            `;
            
            // 타입별 색상
            switch (type) {
                case 'success':
                    notification.style.backgroundColor = '#28a745';
                    break;
                case 'error':
                    notification.style.backgroundColor = '#dc3545';
                    break;
                case 'warning':
                    notification.style.backgroundColor = '#ffc107';
                    notification.style.color = '#212529';
                    break;
                default:
                    notification.style.backgroundColor = '#007bff';
            }
            
            // DOM에 추가
            document.body.appendChild(notification);
            
            // 슬라이드 인 애니메이션
            setTimeout(function() {
                notification.style.transform = 'translateX(0)';
            }, 100);
            
            // 3.5초 후 슬라이드 아웃 및 제거
            setTimeout(function() {
                notification.style.transform = 'translateX(100%)';
                setTimeout(function() {
                    if (notification.parentNode) {
                        notification.remove();
                    }
                }, 300);
            }, 3500);
        }
        
        console.log('예약 시스템 JavaScript 로드 완료');
        
        // 비동기 예약 현황 로딩 함수
        function loadReservations(status, page) {
            console.log('예약 현황 로딩:', status, page);
            
            // 로딩 인디케이터 표시
            showLoadingIndicator();
            
            // API 호출
            fetch('/api/reservation/list?status=' + encodeURIComponent(status) + '&page=' + page, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            })
            .then(function(response) {
                console.log('API 응답 상태:', response.status);
                if (!response.ok) {
                    throw new Error('HTTP 오류: ' + response.status);
                }
                return response.json();
            })
            .then(function(result) {
                console.log('API 응답 데이터:', result);
                
                if (result.success) {
                    updateReservationList(result.data);
                    updatePagination(result.data, status);
                    updateActiveTab(status);
                    updateStatusInfo(result.data, status);
                } else {
                    showNotification(result.message || '데이터 로딩에 실패했습니다.', 'error');
                }
            })
            .catch(function(error) {
                console.error('예약 현황 로딩 오류:', error);
                showNotification('예약 현황을 불러오는 중 오류가 발생했습니다.', 'error');
            })
            .finally(function() {
                hideLoadingIndicator();
            });
        }
        
        // 예약 목록 업데이트
        function updateReservationList(data) {
            const reservationList = document.querySelector('.reservation-list');
            const reservations = data.reservations;
            
            if (!reservations || reservations.length === 0) {
                reservationList.innerHTML = '<div class="no-data">해당하는 예약 현황이 없습니다.</div>';
                return;
            }
            
            let html = '';
            reservations.forEach(function(reservation) {
                const statusClass = getStatusClass(reservation.status);
                const isDisabled = reservation.status !== '예약 가능' ? 'disabled' : '';
                const imageHtml = getImageHtml(reservation.room, reservation.floorDisplay);
                
                html += `
                    <div class="reservation-item">
                        <div class="item-image">
                            \${imageHtml}
                        </div>
                        <div class="item-details">
                            <div class="item-info">\${reservation.date}</div>
                            <div class="item-info">예약 현황: \${reservation.time_info}</div>
                            <div class="item-room">\${reservation.floorDisplay} \${reservation.room}</div>
                        </div>
                        <button class="item-button \${statusClass}" \${isDisabled}>\${reservation.status}</button>
                    </div>
                `;
            });
            
            reservationList.innerHTML = html;
            
            // 버튼 이벤트 재설정
            initializeButtons();
        }
        
        // 페이지네이션 업데이트
        function updatePagination(data, status) {
            const paginationContainer = document.getElementById('paginationContainer');
            
            if (data.totalPages <= 1) {
                paginationContainer.innerHTML = '';
                return;
            }
            
            let html = '<div class="pagination">';
            
            // 이전 페이지
            if (data.hasPrevious) {
                html += `<a href="#" onclick="loadReservations('\${status}', \${data.currentPage - 1})">&lt;</a>`;
            }
            
            // 페이지 번호들
            data.pageNumbers.forEach(function(pageNum) {
                if (pageNum === data.currentPage) {
                    html += `<a href="#" class="active">\${pageNum}</a>`;
                } else {
                    html += `<a href="#" onclick="loadReservations('\${status}', \${pageNum})">\${pageNum}</a>`;
                }
            });
            
            // 다음 페이지
            if (data.hasNext) {
                html += `<a href="#" onclick="loadReservations('\${status}', \${data.currentPage + 1})">&gt;</a>`;
            }
            
            html += '</div>';
            paginationContainer.innerHTML = html;
        }
        
        // 활성 탭 업데이트
        function updateActiveTab(status) {
            document.querySelectorAll('.tab').forEach(function(tab) {
                tab.classList.remove('active');
            });
            
            document.querySelectorAll('.tab').forEach(function(tab) {
                if (tab.textContent.trim() === status) {
                    tab.classList.add('active');
                }
            });
        }
        
        // 상태 정보 업데이트
        function updateStatusInfo(data, status) {
            const statusInfo = document.querySelector('.status-info');
            statusInfo.innerHTML = `
                현재 상태: <strong>\${status}</strong> | 
                페이지: <strong>\${data.currentPage}</strong> / <strong>\${data.totalPages}</strong> | 
                전체 항목: <strong>\${data.totalCount}</strong>개
            `;
        }
        
        // 상태별 CSS 클래스 반환
        function getStatusClass(status) {
            switch(status) {
                case '예약 가능': return 'status-available';
                case '예약 불가': return 'status-unavailable';
                default: return 'status-completed';
            }
        }
        
        // 방 정보에 따른 이미지 HTML 반환
        function getImageHtml(room, floorDisplay) {
            const contextPath = '${pageContext.request.contextPath}';
            
            if (room && (room.includes('AI Cafe') || room.includes('AI 카페'))) {
                return `<img src="\${contextPath}/resources/main/aicafe.jpg" alt="AI 카페" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />`;
            } else if (room && room.includes('세미나실') && floorDisplay && floorDisplay.includes('2층')) {
                return `<img src="\${contextPath}/resources/main/f2seminar.jpg" alt="2층 세미나실" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />`;
            } else if (room && room.includes('휴게공간') && floorDisplay && floorDisplay.includes('2층')) {
                return `<img src="\${contextPath}/resources/main/f2foyer.jpg" alt="2층 휴게공간" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />`;
            } else if (room && (room.includes('AI Lab 1') || room.includes('AI Lab1'))) {
                return `<img src="\${contextPath}/resources/main/f2ailab.jpg" alt="2층 AI Lab 1" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />`;
            } else if (room && (room.includes('AI Lab 2') || room.includes('Ai Lab 2') || room.includes('AI Lab2'))) {
                return `<img src="\${contextPath}/resources/main/f3ailab.jpg" alt="3층 AI Lab 2" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />`;
            } else if (room && room.includes('세미나실') && floorDisplay && floorDisplay.includes('3층')) {
                return `<img src="\${contextPath}/resources/main/f3seminar.jpg" alt="3층 세미나실" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />`;
            } else if (room && room.includes('휴게공간') && floorDisplay && floorDisplay.includes('3층')) {
                return `<img src="\${contextPath}/resources/main/f3foyer.jpg" alt="3층 휴게공간" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;" />`;
            } else {
                return `<div style="display: flex; align-items: center; justify-content: center; color: white; font-size: 12px; font-weight: bold; text-align: center;">\${room}<br/>이미지</div>`;
            }
        }
        
        // 로딩 인디케이터 표시
        function showLoadingIndicator() {
            const reservationList = document.querySelector('.reservation-list');
            reservationList.innerHTML = '<div style="text-align: center; padding: 50px; color: #666;">로딩 중...</div>';
        }
        
        // 로딩 인디케이터 숨김
        function hideLoadingIndicator() {
            // 로딩 상태 해제는 updateReservationList에서 처리됨
        }
        
        // 버튼 초기화 (기존 버튼 이벤트 시스템 재사용)
        function initializeButtons() {
            const buttons = document.querySelectorAll('.item-button');
            console.log('버튼 재초기화:', buttons.length);
            
            buttons.forEach(function(button, index) {
                const reservationItem = button.closest('.reservation-item');
                if (!reservationItem) return;
                
                const itemInfos = reservationItem.querySelectorAll('.item-info');
                const itemRoom = reservationItem.querySelector('.item-room');
                
                const date = itemInfos[0] ? itemInfos[0].textContent.trim() : '';
                const timeInfo = itemInfos[1] ? itemInfos[1].textContent.replace('예약 현황: ', '').trim() : '';
                const roomText = itemRoom ? itemRoom.textContent.trim() : '';
                const status = button.textContent.trim();
                
                const roomParts = roomText.split(' ');
                const floor = roomParts[0] || '';
                const room = roomParts.slice(1).join(' ') || '';
                
                if (status === '예약 가능') {
                    setupAvailableButton(button, floor, room, date, timeInfo, status);
                } else {
                    setupDisabledButton(button, status);
                }
            });
        }
        
        // 페이지 로드 시 전역 변수로 현재 상태 저장
        window.currentReservationStatus = '${currentStatus}';
        window.currentReservationPage = ${currentPage};
        
        console.log('비동기 예약 시스템 초기화 완료');
    </script>
</body>
</html>