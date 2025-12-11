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
public class Tracks {
	
	private int trackId;
	
	private String trackName;
	
	private LocalDateTime creatadAt;
}
