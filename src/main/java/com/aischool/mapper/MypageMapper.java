package com.aischool.mapper;

import java.util.ArrayList;
import java.util.List;



import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.Model;

import com.aischool.entity.Comment;
import com.aischool.entity.Comments;
import com.aischool.entity.Reservation;
import com.aischool.entity.Tracks;
import com.aischool.entity.Users;

@Mapper
public interface MypageMapper {

	public void userModify(Users user);
	
	public ArrayList<Comments> usercomment(int userId);

	public Users mypage(int userId);

	public ArrayList<Reservation> myReservation(int userId);


	public String myRoomName(int roomId);

	public String myTrackName(int trackId);

	public String IprofileImg(int userId);
	
}
