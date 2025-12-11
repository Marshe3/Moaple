package com.aischool.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.aischool.entity.Board;

// Spring과 MyBatis를 연결해주는 녀석
@Mapper
public interface BoardMapper {
	// MyBaties에게 요청하고 싶은 JDBC 기능과 SQL문장을 여기다가 적는다
	
	// 페이지 기능 추가
	int boardTotalCount();

    ArrayList<Board> boardListPaged(@Param("limit") int limit, @Param("offset") int offset);
	
	public void boardUpdate(Board vo);
	
	public void boardCount(int communityId);
	
	public void boardDelete(int communityId);
	
	public void boardInsert(Board vo); // boardInsert에 Board vo를 넘겨준다
	
	public ArrayList<Board> boardList(); 
	
	public Board boardContents(int communityId);
	
}
