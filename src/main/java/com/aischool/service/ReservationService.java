package com.aischool.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.aischool.entity.Reservation;
import com.aischool.entity.StudyRooms;
import com.aischool.mapper.ReservationMapper;

@Service
public class ReservationService {
	
	@Autowired
	private ReservationMapper mapper;
	
	public String reservationList(Model model) {
		
		ArrayList<Reservation> reservationArray = mapper.reservationList();
		
		model.addAttribute("reservationArray", reservationArray);
		
		return "reservation";
		}
	public String studyRoomsList(Model model) {
		
		ArrayList<StudyRooms> roomList = mapper.studyRoomsList();
		
		
		model.addAttribute("roomList", roomList);
		System.out.println(roomList);
		return "reservation";
	}
	
	public boolean saveReservation(Reservation reservation) {
		try {
			System.out.println("=== 예약 저장 시도 ===");
			System.out.println("userId: " + reservation.getUserId());
			System.out.println("trackId: " + reservation.getTrackId());
			System.out.println("roomId: " + reservation.getRoomId());
			System.out.println("reservationDate: " + reservation.getReservationDate());
			System.out.println("startTime: " + reservation.getStartTime());
			System.out.println("endTime: " + reservation.getEndTime());
			System.out.println("participantCount: " + reservation.getParticipantCount());
			System.out.println("purpose: " + reservation.getPurpose());
			System.out.println("status: " + reservation.getStatus());
			System.out.println("createdAt: " + reservation.getCreatedAt());
			
			int result = mapper.insertReservation(reservation);
			System.out.println("DB 저장 결과: " + result);
			return result > 0;
		} catch (Exception e) {
			System.err.println("예약 저장 중 오류 발생: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}
	
	public Integer getRoomIdByName(String roomName) {
		return mapper.getRoomIdByName(roomName);
	}
	
	public void addTodayAndTomorrowReservations(Model model) {
		ArrayList<Reservation> todayTomorrowReservations = mapper.getReservationsFromTodayToTomorrow();
		model.addAttribute("todayTomorrowReservations", todayTomorrowReservations);
		System.out.println("오늘/내일 예약 개수: " + todayTomorrowReservations.size());
	}
}