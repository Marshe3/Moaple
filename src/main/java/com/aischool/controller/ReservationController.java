package com.aischool.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aischool.entity.Reservation;
import com.aischool.entity.Users;
import com.aischool.service.ReservationService;

import com.aischool.service.TracksService;


@Controller
public class ReservationController {
	
	@Autowired
	private ReservationService reservationService;
	
	
	
	
	@GetMapping("/reservation")
	public String reservation(Model model) {
		// 스터디룸 목록 추가
		reservationService.studyRoomsList(model);
		// 오늘과 내일 예약 목록 추가
		reservationService.addTodayAndTomorrowReservations(model);
		return "reservation";
	}
	
	@PostMapping("/reservation")
	public String saveReservation(
			@RequestParam("date") String date,
			@RequestParam("time") String time,
			@RequestParam("place") String place,
			@RequestParam("equip") String equip,
			@RequestParam("participants") String participants,
			@RequestParam("reason") String reason,
			HttpSession session,
			RedirectAttributes redirectAttributes) {
		
		try {
			// 로그인된 사용자 정보 가져오기
			Users loginUser = (Users) session.getAttribute("loginUser");
			if (loginUser == null) {
				redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
				return "redirect:/";
			}
			
			// Reservation 객체 생성 및 데이터 설정
			Reservation reservation = new Reservation();
			reservation.setUserId(loginUser.getUserId());
			reservation.setTrackId(loginUser.getTrackId());
			
			// 날짜 파싱 (YYYY.MM.DD 형식)
			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
			LocalDate reservationDate = LocalDate.parse(date, dateFormatter);
			reservation.setReservationDate(reservationDate);
			
			// 장소에서 roomId 추출
			Integer roomId = reservationService.getRoomIdByName(place);
			if (roomId == null) {
				redirectAttributes.addFlashAttribute("message", "선택한 장소를 찾을 수 없습니다.");
				return "redirect:/reservation";
			}
			
			// 참여인원 파싱
			String participantStr = participants.replaceAll("[^0-9]", ""); // 숫자만 추출
			int participantCount = participantStr.isEmpty() ? 1 : Integer.parseInt(participantStr);
			
			// 디버깅용 로그 추가
			System.out.println("받은 시간 파라미터: " + time);
			
			// 시간 파싱 전 유효성 검사
			if (time == null || time.trim().isEmpty()) {
				redirectAttributes.addFlashAttribute("message", "시간을 선택해주세요.");
				return "redirect:/reservation";
			}
			
			// 시간 파싱 (모든 시간대 처리)
			String[] timeSlots = time.split(",");
			System.out.println("파싱된 시간 슬롯 개수: " + timeSlots.length);
			for (int i = 0; i < timeSlots.length; i++) {
				System.out.println("시간 슬롯 " + (i+1) + ": [" + timeSlots[i] + "]");
			}
			boolean allSuccess = true;
			
			// 각 시간대마다 별도의 예약 생성
			for (String timeSlot : timeSlots) {
				String trimmedTimeSlot = timeSlot.trim(); // "09:00 ~ 10:00" 형식
				
				// 시간 슬롯 유효성 검사
				if (trimmedTimeSlot.isEmpty() || !trimmedTimeSlot.contains(" ~ ")) {
					System.out.println("잘못된 시간 형식: [" + trimmedTimeSlot + "]");
					redirectAttributes.addFlashAttribute("message", "시간 형식이 올바르지 않습니다: " + trimmedTimeSlot);
					return "redirect:/reservation";
				}
				
				String[] timeParts = trimmedTimeSlot.split(" ~ ");
				if (timeParts.length != 2) {
					System.out.println("시간 파싱 실패 - 부분 개수: " + timeParts.length);
					redirectAttributes.addFlashAttribute("message", "시간 형식이 올바르지 않습니다: " + trimmedTimeSlot);
					return "redirect:/reservation";
				}
				
				try {
					LocalTime startTime = LocalTime.parse(timeParts[0].trim());
					LocalTime endTime = LocalTime.parse(timeParts[1].trim());
					
					// 각 시간대별로 새로운 예약 객체 생성
					Reservation timeReservation = new Reservation();
				timeReservation.setUserId(loginUser.getUserId());
				timeReservation.setTrackId(loginUser.getTrackId());
				timeReservation.setRoomId(roomId);
				timeReservation.setReservationDate(reservationDate);
				timeReservation.setStartTime(startTime);
				timeReservation.setEndTime(endTime);
				timeReservation.setParticipantCount(participantCount);
				timeReservation.setPurpose(reason);
				timeReservation.setStatus(Reservation.ReservationStatus.active);
				timeReservation.setCreatedAt(LocalDateTime.now());
				
					// 각 시간대별 예약 저장
					System.out.println("예약 저장 시도: " + trimmedTimeSlot + " (시작: " + startTime + ", 종료: " + endTime + ")");
					boolean result = reservationService.saveReservation(timeReservation);
					System.out.println("예약 저장 결과: " + result);
					if (!result) {
						allSuccess = false;
					}
				} catch (Exception parseEx) {
					System.out.println("시간 파싱 오류: " + parseEx.getMessage());
					redirectAttributes.addFlashAttribute("message", "시간 형식 오류: " + trimmedTimeSlot);
					return "redirect:/reservation";
				}
			}
			
			if (allSuccess) {
				redirectAttributes.addFlashAttribute("message", "모든 시간대 예약이 성공적으로 완료되었습니다!");
			} else {
				redirectAttributes.addFlashAttribute("message", "일부 시간대 예약 처리 중 오류가 발생했습니다.");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("message", "예약 처리 중 오류가 발생했습니다: " + e.getMessage());
		}
		
		return "redirect:/reservation";
	}
	
	
}
