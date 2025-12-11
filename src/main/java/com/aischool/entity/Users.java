package com.aischool.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor // 기본 생성자 -> 필수!!
@ToString
public class Users {

	private int userId;
	
	private int trackId;
	
	private String userName;
	
	private String password;
	
	private String name;
	
	private String projectTeamName;
	
	private LocalDateTime createdAt;
	
	private LocalDateTime updateAt;
	
	private String phone; //전화번호
	
	private String profileImg;
	
	
	
	
	
}
