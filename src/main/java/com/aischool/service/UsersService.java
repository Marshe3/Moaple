package com.aischool.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.aischool.entity.Users;
import com.aischool.mapper.UsersMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Service
public class UsersService {
		@Autowired
		private PasswordEncoder encoder;
		
		@Autowired
		private UsersMapper mapper;

	public String join(HttpServletRequest request) {
		MultipartRequest multi = null;

        int size = 1000 * 1024;
        String save = request.getRealPath("resources/profile");
        String enc = "UTF-8";
        DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
		
        try {
			multi = new MultipartRequest(request, save, size, enc, df);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        String trackIdStr = multi.getParameter("trackId");
        // string으로 값을 가져와서 int로 전환
        int trackId = Integer.parseInt(trackIdStr);
        String userName = multi.getParameter("userName");
        String password = multi.getParameter("password");
        // 비밀번호 해싱 처리 진행해야 됨
        String enc_pw = hashPw(password);
        
        String name = multi.getParameter("name");
        String projectTeamName = multi.getParameter("projectTeamName");
        String phone = multi.getParameter("phone");
        String profileImg = multi.getFilesystemName("profileImg");
        if(profileImg == null || profileImg.isEmpty()) {
            profileImg = "default_img.png";
        }
        
        Users user = new Users();
        user.setTrackId(trackId);
        user.setUserName(userName);
        user.setPassword(enc_pw);
        user.setName(name);
        user.setProjectTeamName(projectTeamName);
        user.setPhone(phone);
        user.setProfileImg(profileImg);
        
        try {
            mapper.UsersJoin(user);
            return "redirect:/?joinSuccess=true";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/join.do?error=true";
        }
	}
	
	// 비밀번호 해싱 메서드
	public String hashPw(String password) {
		String enc = encoder.encode(password);
		return enc;
	}
	
	// 중복 아이디 체크 메서드
	public String checkUserName(String userName) {
		int count = mapper.checkUserName(userName);
		if(count > 0) {
			return "duplicate"; // 중복됨
		} else {
			return "available"; // 사용 가능
		}
	}
	
	public String logout(HttpSession session) {
		// 세션 삭제하는 방법
		// 1. session.removeAttribute("user"); --> user와 일치하는 세션 값 삭제, 세션 자체는 여전히 유효하게 남아있음, 다른 속성들은 그대로 유지, 로그아웃 시 사용자 정보만 삭제하고 싶을 때 사용
		// 2. 이 방법을 사용 -> session.invalidate(); --> 세션을 완전히 무효화하고 제거, 모든 세션 속성이 삭제, 완전한 세션 종료를 원할 때 사용
		session.invalidate();
		return "redirect:/";
	}

	public String login(Users users, HttpSession session) {
		// 문제.
		// mapper에 login 메소드를 통해 id와 pw가 일치하는 회원의 모든 정보를 가져오고
		// 아니면 null을 반환하는 기능을 구현하시오.

		Users user = mapper.login(users);
		// 매개변수로 첫번째는 실제 입력값 두번째는 해싱된 암호값을 matches 메서드 안에 넣는다
		if(user != null && encoder.matches(users.getPassword(), user.getPassword())) {
			session.setAttribute("loginUser", user);
			return "redirect:/reservation";
		}else {
			return "redirect:/?loginError=true";
		}
	}
	
}
