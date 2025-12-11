package com.aischool.service;

import java.beans.Encoder;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.aischool.entity.Comment;
import com.aischool.entity.Comments;

import com.aischool.entity.Reservation;
import com.aischool.entity.StudyRooms;
import com.aischool.entity.Tracks;
import com.aischool.entity.Users;

import com.aischool.mapper.MypageMapper;
import com.aischool.mapper.ReservationMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Service
public class MypageService {
	
	@Autowired
	private MypageMapper mapper;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private ReservationMapper reservationMapper;

	public String userModify(HttpServletRequest request) {
		
		MultipartRequest multi = null;
		
		int size = 1000 * 1024;
		String save = request.getRealPath("resources/profile");
		String enc ="UTF-8";
		DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
		
		try {
			multi =new MultipartRequest(request, save, size, enc, df);
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "redirect:/error";
		}
		
		 HttpSession session = request.getSession();
		 Users loginUser = (Users) session.getAttribute("loginUser");
		 System.out.println(loginUser);
		 String profileImg;
		 String IprofileImg = mapper.IprofileImg(loginUser.getUserId());
		 String uploadedFileName = multi.getFilesystemName("profileImg");
		 if(uploadedFileName != null && !uploadedFileName.isEmpty()) {
		 profileImg = uploadedFileName;
		}else {
			profileImg = IprofileImg;
		}
		
		String password = multi.getParameter("password");
		String name = multi.getParameter("name");
		String phone = multi.getParameter("phone");
		String trackIdstr = multi.getParameter("trackId");
		String projectTeamName = multi.getParameter("projectTeamName");
		int trackId = Integer.parseInt(trackIdstr);
		int userId = loginUser.getUserId();
		
		Users user = new Users();
		user.setProfileImg(profileImg); 
		user.setUserId(userId); 
		user.setName(name);
		
		user.setPhone(phone); 
		user.setTrackId(trackId); 
		user.setProjectTeamName(projectTeamName); 
		user.setCreatedAt(loginUser.getCreatedAt());
		String encod;
		if(password != null && !password.isEmpty()) {
			encod = encoder.encode(password);
			
		}else {
			encod = loginUser.getPassword();
		}
		user.setPassword(encod);
		System.out.println(user);
		mapper.userModify(user);
		
		return "redirect:/mypage";
	}

	public String mypage(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Users loginUser = (Users) session.getAttribute("loginUser");
		int userId = loginUser.getUserId();
		System.out.println("유저 아이디 값 : " + userId);
		
		ArrayList<Comments> comment = mapper.usercomment(userId);
		System.out.println(comment.toString());
		Users user = mapper.mypage(userId);
		ArrayList<Reservation> reservation = mapper.myReservation(userId);
		// 데이터 값이 없을때
		System.out.println(reservation.toString());
		

		String[] roomName = new String[reservation.size()];
		  for(int i = 0;i<reservation.size();i++) {
		      int roomId = reservation.get(i).getRoomId(); // 각 예약의 roomId
		      roomName[i] = mapper.myRoomName(roomId);
		  }
		String trackName = mapper.myTrackName(user.getTrackId());
		model.addAttribute("trackName", trackName);
		
		
		String[] myroom = roomName;
		
		model.addAttribute("trackName", trackName);
		model.addAttribute("myroom", myroom);
		model.addAttribute("reservation", reservation);
		model.addAttribute("loginUser", user);
		model.addAttribute("comment", comment);
		
		
		return "mypage";
	}
	
	
	
}
