package com.aischool.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor // 기본 생성자 -> 필수!!
@ToString
public class StudyRooms {
	
	private int roomId;
		
	private int floor;
	
	
	private String roomName;
	
	private String studyImg;
	
	private boolean isActive;
	
	private boolean isEquipment;
	
	private LocalDateTime createdAt;
}

