<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.aischool.entity.StudyRooms" %>
<%@ page import="com.aischool.entity.Reservation" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>예약</title>
  <style>
    :root{
      --bg:#edf1f7; --panel:#ffffff; --primary:#0b4aa2; --primary-600:#0a3f8a;
      --muted:#6b7280; --text:#0f172a; --line:#e5e7eb; --chip:#f1f5f9; --chip-text:#1f2937;
    }
    *{box-sizing:border-box}
    html,body{height:100%}
    body{margin:0;background:var(--bg);color:var(--text);
      font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Apple SD Gothic Neo,Helvetica,Arial,"Noto Sans KR","맑은 고딕",sans-serif;}
    a{color:inherit;text-decoration:none}


    /* Layout */
    .wrap{max-width:1200px;margin:28px auto;padding:0 16px}
    .card{background:var(--panel);border-radius:18px;box-shadow:0 8px 28px rgba(16,24,40,.08);
      overflow:hidden;display:grid;grid-template-columns:1fr 1px 1fr;min-height:520px}
    .divider{background:var(--primary)}
    .pane{padding:28px}
    .pane h2{margin:0;background:var(--primary);color:#fff;padding:14px 18px;border-radius:12px;font-size:18px;letter-spacing:.2px}

    .section{margin-top:18px}
    .section-title{margin:20px 0 10px;font-weight:800;color:#374151}

    /* Calendar (weekly) */
    .calendar{margin-top:16px;border:1px solid var(--line);border-radius:12px;padding:12px;background:#fbfdff;position:relative}
    .cal-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:8px}
    .cal-left{display:flex;align-items:center;gap:8px}
    .cal-month{font-weight:800}
    .navbtn{border:none;background:#eef2ff;border-radius:10px;width:34px;height:34px;cursor:pointer;font-size:16px}
    .iconbtn{border:none;background:#eef2ff;border-radius:10px;width:34px;height:34px;cursor:pointer;font-size:16px}
    .dow{display:grid;grid-template-columns:repeat(7,1fr);gap:6px;margin:6px 0 8px;color:#64748b;font-size:12px;text-align:center}
    .week-grid{display:grid;grid-template-columns:repeat(7,1fr);gap:6px}
    .day{height:40px;display:flex;align-items:center;justify-content:center;border-radius:10px;border:1px solid transparent;background:#fff;cursor:pointer}
    .day:hover{border-color:#cbd5e1}
    .day.today{outline:2px solid #c7d2fe}
    .day.selected{background:var(--primary) !important;color:#fff !important;border-color:var(--primary) !important;outline:none !important}
    .day.today.selected{background:var(--primary) !important;color:#fff !important;outline:2px solid #fff !important}
    .day[disabled], .day.disabled{color:#cbd5e1;background:#f8fafc;border-color:transparent;cursor:not-allowed;pointer-events:none}

    /* Notice popover */
    .notice-pop{position:absolute;right:8px;top:46px;background:#fff;border:1px solid var(--line);
      border-radius:12px;padding:12px 14px;width:260px;box-shadow:0 20px 40px rgba(16,24,40,.12)}
    .notice-pop .title{font-weight:800;margin-bottom:6px}
    .notice-pop .tip{position:absolute;top:-7px;right:18px;width:12px;height:12px;background:#fff;border-left:1px solid var(--line);border-top:1px solid var(--line);transform:rotate(45deg)}
    .hidden{display:none}

    /* Time chips/buttons */
    .time-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:10px}
    .time-btn{height:42px;border:1px solid var(--line);background:#fff;border-radius:12px;cursor:pointer;font-weight:700}
    .time-btn.active{background:var(--primary);color:#fff;border-color:var(--primary)}
    .time-btn.disabled{background:#f3f4f6;color:#9ca3af;cursor:not-allowed}

    /* Select boxes */
    .select{border:1px solid var(--line);border-radius:12px; position: relative;overflow: visible;background:#f8fafc}
    .select-btn{width:100%;text-align:left;padding:14px;border:none;background:transparent;cursor:pointer;font-weight:700;display:flex;align-items:center;justify-content:space-between}
    .select-list{
  list-style:none;
  margin:0;
  padding:6px;
  max-height:220px;
  overflow:auto;

  position:absolute;          /* 추가: 절대배치 */
  bottom:calc(100% + 6px);    /* 버튼 위로 배치 */
  left:0; right:0;            /* 너비 맞춤 */
  background:#fff;
  border:1px solid var(--line);      /* 위쪽 테두리 대신 전체 테두리 */
  border-radius:12px;
  box-shadow:0 12px 24px rgba(16,24,40,.12);
  z-index:50;                 /* 다른 요소 위에 보이도록 */
}
    .select-list li{padding:10px;border-radius:8px;cursor:pointer}
    .select-list li:hover{background:#f3f4f6}
    .check-list li{display:flex;align-items:center;gap:10px}
    .chip{display:inline-flex;align-items:center;padding:6px 10px;border-radius:999px;background:var(--chip);color:var(--chip-text);font-size:12px;font-weight:700;margin-right:6px;margin-top:6px}

    /* Right pane */
    .summary{margin:22px 0 16px;border:1px solid var(--line);border-radius:12px;padding:16px;background:#fbfdff}
    .srow{display:flex;gap:12px;align-items:center;margin:8px 0;color:#374151;font-weight:700}
    .srow .icon{width:22px;text-align:center}
    .form label{display:block;font-size:14px;font-weight:800;margin:12px 0 8px}
    .input,.textarea{width:100%;border:1px solid var(--line);border-radius:12px;padding:12px 14px;background:#fff;font-size:14px}
    .textarea{min-height:120px;resize:vertical}
    .btn-primary{width:100%;height:54px;border:none;border-radius:12px;background:var(--primary);color:#fff;font-weight:800;font-size:16px;cursor:pointer;margin-top:10px}
    .btn-primary:hover{background:var(--primary-600)}
    .helper{color:#64748b;font-size:12px;margin-top:6px}

    @media (max-width:980px){.card{grid-template-columns:1fr}.divider{display:none}.pane{padding:20px}}
    
    
  </style>
</head>
<body>
<!-- 네비게이션 바 포함 -->
<jsp:include page="nav.jsp"></jsp:include>

<main class="wrap">
  <div class="card">
    <!-- LEFT -->
    <section class="pane" aria-label="예약 패널">
      <h2>예약</h2>

      <!-- 주간 달력 -->
      <form class="form" id="reservationForm" action="reservation" method="post" novalidate>
      <div class="calendar section" id="calendar">
        <div class="cal-head">
          <div class="cal-left">
            <button type="button" class="navbtn" id="prevWeek" aria-label="이전 주">‹</button>
            <div class="cal-month"><span id="monthLabel">8월</span></div>
            <button type="button" class="navbtn" id="nextWeek" aria-label="다음 주">›</button>
          </div>
          <button type="button" class="iconbtn" id="noticeBtn" aria-label="공지사항">📣</button>
        </div>

        <div class="dow">
          <div style="color: red">일</div><div>월</div><div>화</div><div>수</div><div>목</div><div>금</div><div style="color: blue">토</div>
        </div>
        <div class="week-grid" id="weekGrid"><!-- JS render --></div>

        <!-- 공지 팝오버 -->
        <div class="notice-pop hidden" id="noticePop" role="dialog" aria-label="공지사항">
          <div class="tip" aria-hidden="true"></div>
          <div class="title">공지사항</div>
          <div class="body">
            공간 사용 신청 가능 일자는 <b>다음 날까지</b>이며,<br/>
            가능 시간은 <b>1일 4시간</b>입니다.
          </div>
        </div>
      </div>

      <!-- 시간 -->
      <div class="section">
        <div class="section-title">시간</div>
        <div class="time-grid" id="timeGrid">
          <% 
            String[] times = {"09:00 ~ 10:00", "10:00 ~ 11:00", "11:00 ~ 12:00", "13:00 ~ 14:00", "14:00 ~ 15:00", "15:00 ~ 16:00", "16:00 ~ 17:00", "17:00 ~ 18:00", "18:00 ~ 19:00", "20:00 ~ 21:00", "21:00 ~ 22:00"};
            
            for(String timeSlot : times) {
              String[] timeParts = timeSlot.split(" ~ ");
              String startTime = timeParts[0];
              String endTime = timeParts[1];
          %>
            <button type="button" class="time-btn" 
                    data-time="<%= timeSlot %>"
                    data-start="<%= startTime %>"
                    data-end="<%= endTime %>">
              <%= timeSlot %>
            </button>
          <% } %>
        </div>
      </div>

      <!-- 장소 -->
      
      <div class="section">
        <div class="section-title">장소</div>
        <div class="select" id="placeSelectBox">
          <button type="button" class="select-btn" id="placeBtn">장소 선택 <span>▾</span></button>
          <ul class="select-list hidden" id="placeList" name="plac">
             <% ArrayList<StudyRooms> s = (ArrayList<StudyRooms>)request.getAttribute("roomList"); 
                        	for(int i = 0; i < s.size() ; i++){
             %>
           		<li data-value="<%= s.get(i).getRoomName() %>"><%= s.get(i).getRoomName() %></li>
           	<% }
           %>
          </ul>
        </div>
      </div>

      <!-- 장비 -->
<div class="section">
  <div class="section-title">장비 사용</div>
  <div class="select" id="equipSelectBox">
    <button type="button" class="select-btn" id="equipBtn">장비 미사용 <span>▾</span></button>
    <ul class="select-list hidden" id="equipList">
      <li data-value="장비 사용">장비 사용</li>
      <li data-value="장비 미사용">장비 미사용</li>
    </ul>
  </div>
</div>

    </section>

    <div class="divider" aria-hidden="true"></div>

    <!-- RIGHT -->
    <section class="pane" aria-label="사용자 정보 패널">
      <h2>사용자 정보 입력</h2>

      <!-- 요약 -->
      <div class="summary" id="summaryBox">
        <div class="srow"><span class="icon">📅</span><span id="sumDate">날짜 선택</span></div>
        <div class="srow"><span class="icon">⏱️</span><span id="sumTime">시간 선택</span></div>
        <div class="srow"><span class="icon">📍</span><span id="sumPlace">장소 선택</span></div>
        <div class="srow"><span class="icon">⚙️</span><span id="sumEquip">장비 없음</span></div>
      </div>
	
      <!-- 폼 -->
      
        <label for="participants">참여 인원</label>
        <input id="participants" name="participants" class="input" type="text" placeholder="예: 5" oninput="validateParticipants(this)"/>

        <label for="reason">사용 사유</label>
        <textarea id="reason" name="reason" class="textarea" placeholder="사용 목적을 입력하세요."></textarea>

        <!-- 서버 연동용 hidden 값들 -->
        <input type="hidden" name="date"  id="hidDate"/>
        <input type="hidden" name="time"  id="hidTime"/>
        <input type="hidden" name="place" id="hidPlace"/>
        <input type="hidden" name="equip" id="hidEquip"/>

        <button type="submit" class="btn-primary">예약하기</button>
        <div class="helper">※ 선택한 정보를 확인하고 예약하기 버튼을 클릭하세요.</div>
        
        <!-- 메시지 표시 영역 -->
        <% String message = (String) request.getAttribute("message"); 
           if (message == null) message = (String) session.getAttribute("message");
           if (message != null) { %>
        <div class="alert" style="margin-top: 10px; padding: 12px; border-radius: 8px; background: #d4edda; border: 1px solid #c3e6cb; color: #155724;">
            <%= message %>
        </div>
        <% session.removeAttribute("message"); } %>
      </form>
    </section>
  </div>
</main>

<script>
  // ===== 예약 데이터 =====
  <%
    ArrayList<Reservation> todayTomorrowReservations = (ArrayList<Reservation>) request.getAttribute("todayTomorrowReservations");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
  %>
  
  // 서버사이드에서 예약 충돌 체크하는 함수 (디버깅 추가)
  function isTimeSlotReserved(selectedDate, timeSlot, roomId) {
    const reservationsData = [
      <% if (todayTomorrowReservations != null) {
           boolean first = true;
           for (int i = 0; i < todayTomorrowReservations.size(); i++) {
             Reservation res = todayTomorrowReservations.get(i); 
             if (res.getReservationDate() != null && res.getStartTime() != null && res.getEndTime() != null) { 
               if (!first) out.print(",");
               first = false; %>
        {
          date: "<%= res.getReservationDate().format(dateFormatter) %>",
          startTime: "<%= res.getStartTime().format(timeFormatter) %>",
          endTime: "<%= res.getEndTime().format(timeFormatter) %>",
          roomId: <%= res.getRoomId() %>
        }
      <% }
         } %>
      <% } %>
    ];
    
    console.log('reservationsData:', reservationsData);
    console.log('체크할 timeSlot:', timeSlot);
    
    const [startTime, endTime] = timeSlot.split(" ~ ");
    const dateStr = selectedDate.getFullYear() + '-' + 
                    String(selectedDate.getMonth() + 1).padStart(2, '0') + '-' + 
                    String(selectedDate.getDate()).padStart(2, '0');
    
    console.log('변환된 dateStr:', dateStr);
    console.log('startTime:', startTime);
    console.log('roomId:', roomId);
    
    const result = reservationsData.some(res => {
      const dateMatch = res.date === dateStr;
      const timeMatch = res.startTime === startTime;
      const roomMatch = res.roomId === roomId;
      
      console.log(`예약 비교: date(${res.date}===${dateStr})=${dateMatch}, time(${res.startTime}===${startTime})=${timeMatch}, room(${res.roomId}===${roomId})=${roomMatch}`);
      
      return dateMatch && timeMatch && roomMatch;
    });
    
    console.log('최종 결과:', result);
    return result;
  }
  
  // ===== 상태 =====
  const now = new Date();
  const today = new Date(now.getFullYear(), now.getMonth(), now.getDate()); // 오늘 00:00
  const tomorrow = new Date(today); tomorrow.setDate(today.getDate() + 1);  // 내일 00:00

  const state = { date: today, times: [], place: "", equip: "장비 미사용" };

  // ===== 공통 DOM =====
  const monthLabel = document.getElementById('monthLabel');
  const weekGrid   = document.getElementById('weekGrid');
  const prevWeek   = document.getElementById('prevWeek');
  const nextWeek   = document.getElementById('nextWeek');

  const sumDate   = document.getElementById('sumDate');
  const sumTime   = document.getElementById('sumTime');
  const sumPlace  = document.getElementById('sumPlace');
  const sumEquip  = document.getElementById('sumEquip');

  const hidDate   = document.getElementById('hidDate');
  const hidTime   = document.getElementById('hidTime');
  const hidPlace  = document.getElementById('hidPlace');
  const hidEquip  = document.getElementById('hidEquip');

  const timeGrid  = document.getElementById('timeGrid');
  const placeBtn  = document.getElementById('placeBtn');
  const placeList = document.getElementById('placeList');
  const equipBtn  = document.getElementById('equipBtn');
  const equipList = document.getElementById('equipList');
  const equipChips= document.getElementById('equipChips');

  const noticeBtn = document.getElementById('noticeBtn');
  const noticePop = document.getElementById('noticePop');

  // ===== 유틸 =====
  const fmtMonth = new Intl.DateTimeFormat('ko-KR', { month: 'long' });
  function fmtDate(d){ const y=d.getFullYear(), m=(d.getMonth()+1+'').padStart(2,'0'), dd=(d.getDate()+'').padStart(2,'0'); return `${y}.${m}.${dd}`; }
  function dateOnly(d){ return new Date(d.getFullYear(), d.getMonth(), d.getDate()); }
  function inRange(d){ const x=dateOnly(d).getTime(); return x >= today.getTime() && x <= tomorrow.getTime(); } // 오늘~내일만
  function getWeekStart(d){ const s=new Date(d.getFullYear(), d.getMonth(), d.getDate()); s.setDate(s.getDate() - s.getDay()); return s; } // 일요일 시작
  function addDays(d, n){ const r=new Date(d); r.setDate(r.getDate()+n); return r; }

  // ===== 주간 렌더 =====
  let viewBase = today; // 현재 보고 있는 기준일(해당 주 표시)
  function renderWeek(){
    const start = getWeekStart(viewBase);
    weekGrid.innerHTML = "";

    // 헤더 월 라벨(해당 주의 기준일 기준)
    monthLabel.textContent = fmtMonth.format(viewBase); // 예: "8월"

    // 네비 제한: 오늘이 속한 주 ~ 내일이 속한 주
    const minKey = getWeekStart(today).getTime();
    const maxKey = getWeekStart(tomorrow).getTime();
    const currKey= start.getTime();
    prevWeek.disabled = (currKey <= minKey);
    nextWeek.disabled = (currKey >= maxKey);

    for(let i=0;i<7;i++){
      const d = addDays(start,i);
      const btn = document.createElement('button');
      btn.type="button"; btn.className="day";
      btn.textContent = d.getDate();

      if (d.toDateString() === today.toDateString()) btn.classList.add('today');
      if (dateOnly(d).getTime() === dateOnly(state.date).getTime()) btn.classList.add('selected');

      if (!inRange(d)) { btn.disabled = true; btn.classList.add('disabled'); }
      else {
        btn.addEventListener('click', ()=>{
          console.log('날짜 클릭됨:', d); // 디버깅용
          state.date = d;
          console.log('state.date 업데이트됨:', state.date);
          
          // 날짜 포맷팅
          const year = d.getFullYear();
          const month = d.getMonth() + 1;
          const day = d.getDate();
          const formattedDate = year + '.' + (month < 10 ? '0' + month : month) + '.' + (day < 10 ? '0' + day : day);
          
          console.log('포맷된 날짜:', formattedDate);
          
          // sumDate 요소 업데이트
          const sumDateElement = document.getElementById('sumDate');
          if (sumDateElement) {
            sumDateElement.textContent = formattedDate;
            sumDateElement.style.color = 'red';
            sumDateElement.style.fontWeight = 'bold';
            console.log('sumDate 업데이트됨:', formattedDate);
          }
          
          // hidden input 업데이트
          const hidDateElement = document.getElementById('hidDate');
          if (hidDateElement) {
            hidDateElement.value = formattedDate;
          }
          
          // selected 갱신 - 모든 버튼에서 selected 제거
          weekGrid.querySelectorAll('.day').forEach(el => {
            el.classList.remove('selected');
            el.style.backgroundColor = '';
            el.style.color = '';
            el.style.outline = '';
          });
          
          // 클릭한 버튼에 selected 추가 (클래스와 인라인 스타일 모두)
          btn.classList.add('selected');
          btn.style.backgroundColor = '#0b4aa2';
          btn.style.color = '#fff';
          btn.style.outline = 'none';
          
          console.log('selected 클래스 추가됨:', btn.classList.contains('selected'));
          console.log('버튼 배경색:', btn.style.backgroundColor);
          
          // 시간 버튼 상태 업데이트
          updateTimeButtonsDisabled();
        });
      }
      weekGrid.appendChild(btn);
    }
  }

  // ===== 요약 =====
  function updateDateSummary(){ 
    console.log('updateDateSummary 호출됨 - 이 함수가 덮어쓰고 있을 수 있음');
    const v=fmtDate(state.date); 
    sumDate.textContent=v; 
    hidDate.value=v; 
  }
  function updateTimeSummary(){
    if(state.times.length===0){ sumTime.textContent='시간 선택'; hidTime.value=''; }
    else { sumTime.textContent=state.times.join(', '); hidTime.value=state.times.join(','); }
  }

  // 시간 버튼 비활성화 함수 (디버깅 추가)
  function updateTimeButtonsDisabled() {
    console.log('=== updateTimeButtonsDisabled 호출 ===');
    console.log('state.date:', state.date);
    console.log('state.place:', state.place);
    
    const timeButtons = document.querySelectorAll('.time-btn');
    console.log('시간 버튼 개수:', timeButtons.length);
    
    timeButtons.forEach((btn, index) => {
      const timeSlot = btn.getAttribute('data-time');
      console.log(`버튼 ${index}: data-time="${timeSlot}"`);
      
      if (!timeSlot) {
        console.log(`버튼 ${index}: data-time 속성이 없습니다.`);
        return;
      }
      
      const roomId = getRoomIdFromSelectedPlace();
      console.log(`선택된 roomId: ${roomId}`);
      
      if (state.date && roomId) {
        const isReserved = isTimeSlotReserved(state.date, timeSlot, roomId);
        console.log(`${timeSlot} 예약 여부: ${isReserved}`);
        
        if (isReserved) {
          btn.classList.add('disabled');
          btn.disabled = true;
          console.log(`${timeSlot} 버튼 비활성화`);
        } else {
          btn.classList.remove('disabled');
          btn.disabled = false;
        }
      } else {
        console.log('날짜 또는 방이 선택되지 않았습니다.');
        btn.classList.remove('disabled');
        btn.disabled = false;
      }
    });
  }
  
  // 선택된 장소의 방 ID 가져오기
  function getRoomIdFromSelectedPlace() {
    const roomMapping = {
      <% 
      ArrayList<StudyRooms> roomList = (ArrayList<StudyRooms>) request.getAttribute("roomList");
      if (roomList != null) {
        for (int i = 0; i < roomList.size(); i++) {
          StudyRooms room = roomList.get(i); %>
        "<%= room.getRoomName() %>": <%= room.getRoomId() %><%= i < roomList.size() - 1 ? "," : "" %>
      <% }
       } %>
    };
    return roomMapping[state.place] || null;
  }

  // 초기 렌더
  renderWeek(); 
  // updateDateSummary(); // 이 함수가 문제일 수 있으니 주석처리
  
  // 초기 날짜 설정
  const initialDate = fmtDate(state.date);
  sumDate.textContent = initialDate;
  hidDate.value = initialDate;
  
  // 초기 시간 버튼 상태 설정
  setTimeout(() => {
    updateTimeButtonsDisabled();
  }, 100);

  // 주간 네비
  prevWeek.addEventListener('click', ()=>{ const s=getWeekStart(viewBase); const next=new Date(s); next.setDate(s.getDate()-7); viewBase=next; renderWeek(); });
  nextWeek.addEventListener('click', ()=>{ const s=getWeekStart(viewBase); const next=new Date(s); next.setDate(s.getDate()+7); viewBase=next; renderWeek(); });

  // 시간: 최대 4개
  timeGrid.addEventListener('click', (e)=>{
    const btn = e.target.closest('.time-btn');
    if(!btn || btn.classList.contains('disabled')) return;
    const label = btn.textContent.trim();
    if (btn.classList.contains('active')) {
      btn.classList.remove('active'); state.times = state.times.filter(t=>t!==label);
    } else {
      if (state.times.length >= 4) { alert('시간은 최대 4개까지 선택 가능합니다.'); return; }
      btn.classList.add('active'); state.times.push(label);
    }
    updateTimeSummary();
  });

  // 장소
  placeBtn.addEventListener('click', ()=>{ placeList.classList.toggle('hidden'); });
  placeList.addEventListener('click', (e)=>{
    const li=e.target.closest('li'); if(!li) return;
    state.place = li.dataset.value;
    placeBtn.firstChild.textContent = state.place+" ";
    sumPlace.textContent = state.place; hidPlace.value = state.place;
    placeList.classList.add('hidden');
    
    // 시간 버튼 상태 업데이트
    updateTimeButtonsDisabled();
  });

//장비 드롭다운 (단일 선택)
  equipBtn.addEventListener('click', ()=>{
    equipList.classList.toggle('hidden');
    // 화살표 토글(선택)
    const arrow = equipBtn.querySelector('span');
    if (arrow) arrow.textContent = equipList.classList.contains('hidden') ? '▾' : '▴';
  });
  equipList.addEventListener('click', (e)=>{
    const li = e.target.closest('li'); if (!li) return;
    state.equipUse = li.dataset.value;               // "장비 사용" | "장비 미사용"
    sumEquip.textContent = state.equipUse;           // 요약 갱신
    hidEquip.value = state.equipUse;                 // hidden 갱신
    equipBtn.firstChild.textContent = state.equipUse + " "; // 버튼 라벨도 변경
    equipList.classList.add('hidden');
    const arrow = equipBtn.querySelector('span'); if (arrow) arrow.textContent = '▾';
  });


  // 공지 팝오버
  noticeBtn.addEventListener('click', (e)=>{ e.stopPropagation(); noticePop.classList.toggle('hidden'); });
  document.addEventListener('click', (e)=>{
    if(!document.getElementById('calendar').contains(e.target)) noticePop.classList.add('hidden');
    if(!document.getElementById('placeSelectBox').contains(e.target)) placeList.classList.add('hidden');
    if(!document.getElementById('equipSelectBox').contains(e.target)) equipList.classList.add('hidden');
  });

  // 참여인원 실시간 유효성 검사
  function validateParticipants(input) {
    const value = input.value;
    const numericValue = value.replace(/[^0-9]/g, '');
    
    if (value !== numericValue) {
      alert('참여 인원은 숫자만 입력 가능합니다.');
      input.value = numericValue;
    }
  }


  // 폼 제출
  document.getElementById('reservationForm').addEventListener('submit',(e)=>{
    // 유효성 검사
    console.log(hidDate.value)
    console.log(state.times.length===0)
    console.log(hidPlace.value)
    if(!hidDate.value || !hidPlace.value || state.times.length===0){
      e.preventDefault();
      alert("날짜/시간(최소 1개)/장소를 선택하세요."); 
      return;
    }
    
    // 시간 데이터 검증
    console.log("폼 제출 시 시간 데이터:", state.times);
    console.log("hidTime.value:", hidTime.value);
    if (state.times.some(time => !time || !time.includes(' ~ '))) {
      e.preventDefault();
      alert("올바르지 않은 시간 형식이 있습니다.");
      return;
    }
    
    const participants = document.getElementById('participants').value;
    const reason = document.getElementById('reason').value;
    
    if(!participants.trim()){
      e.preventDefault();
      alert("참여 인원을 입력하세요."); 
      return;
    }
    
    // 참여인원 숫자 검증
    if(!/^\d+$/.test(participants.trim()) || parseInt(participants) <= 0){
      e.preventDefault();
      alert("참여 인원은 1 이상의 숫자만 입력 가능합니다.");
      return;
    }
    
    if(!reason.trim()){
      e.preventDefault();
      alert("사용 사유를 입력하세요."); 
      return;
    }
    
    // 폼이 정상적으로 서버로 제출됨
  });
</script>
</body>
</html>
