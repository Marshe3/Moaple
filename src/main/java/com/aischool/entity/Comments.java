package com.aischool.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Comments {
	private int commentId; 
	private int communityId;
	private int userId;
	private String content;
	private String createdAt;
	private String updatedAt;
}
