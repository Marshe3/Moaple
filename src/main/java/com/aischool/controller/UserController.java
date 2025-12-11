package com.aischool.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.aischool.entity.Users;
import com.aischool.service.TracksService;
import com.aischool.service.UsersService;

@Controller
public class UserController {
	@Autowired
	private TracksService service;
	
	@Autowired
	private UsersService usersservice;
	
	@GetMapping("/join.do") // join.do > 주소
		public String join(Model model) { //위에 주소 가져오기
		return service.getTracks(model);
		}
	
	@PostMapping("/join.do")
	public String join(HttpServletRequest request) {
		return usersservice.join(request);//비밀번호 암호화 초기화
	}
	
	@PostMapping("/checkUserName.do")
	@ResponseBody
	public String checkUserName(String userName) {
		return usersservice.checkUserName(userName);
	}
	
	
	@PostMapping("/login.do")
	public String login(Users user, HttpSession session) {
		return usersservice.login(user, session);
	}
	
	// 로그아웃
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
	

