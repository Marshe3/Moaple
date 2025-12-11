package com.aischool.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Board {
	// 커뮤니티 게시글 정보를 저장하는 클래스
	
	private int communityId; // 게시글 번호
	
	private String title; // 제목
	
	private String content; // 내용
	
	private int userId; // 사용자 ID
	
	private String createdAt; // 생성일자
	
	private int viewCount; // 조회수
	
	private String filepath; // 파일 경로
	
	private String updatedAt; // 수정일자
	
	
}
