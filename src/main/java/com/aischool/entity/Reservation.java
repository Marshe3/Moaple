package com.aischool.entity;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Reservation {
	public enum ReservationStatus{
		ACTIVE,
		active,
		COMPLETED,
		completed,
		CANCELLED,
		cancelled
	}
	// 게시글 정보를 저장하는 클래스
	// 번호, 제목, 내용, 작성자, 날짜, 조회수
	private int reservationId;
	private int reservationUserId;
	private int reservationRoomId;
	private int userId;
	private int trackId;
	private int roomId;
	private LocalDate reservationDate;
	private LocalTime startTime;
	private LocalTime endTime;
	private int participantCount;
	private String purpose;
	private ReservationStatus status;
	private LocalDateTime createdAt;
	
}
