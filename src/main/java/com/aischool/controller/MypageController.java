package com.aischool.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aischool.entity.Users;
import com.aischool.mapper.MypageMapper;
import com.aischool.service.MypageService;



@Controller
public class MypageController {
	
	@Autowired
	private MypageService service;
	
	
	// 사용자 수정
	@PostMapping ("/userModify")
	public String userModify(HttpServletRequest request) {
		return service.userModify(request);
	}
	
	
	
	
	@GetMapping ("/mypage")
	public String mypage(Model model,HttpServletRequest request) { 
		return service.mypage(model,request);
	}
}
