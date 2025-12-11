package com.aischool.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.aischool.entity.Board;
import com.aischool.entity.Comment;
import com.aischool.mapper.BoardMapper;
import com.aischool.service.BoardService;

import lombok.Getter;

@Controller
public class BoardController {
	
	// 매퍼가 필요없어서 삭제해준다.
	
	@Autowired
	private BoardService service;
	
	// 페이징
	@RequestMapping("/boardList.do")
    public String boardList(@RequestParam(defaultValue = "1") int page,
                            @RequestParam(defaultValue = "5") int size,
                            Model model) {
        return service.boardList(page, size, model);
	}
	
	@PostMapping("/boardUpdate.do")
	public String boardUpdate(HttpServletRequest request) { // 게시글 수정
		return service.boardUpdate(request);
	}
	
	@GetMapping("/boardDelete.do") // 게시글 삭제
	public String boardDelete(@RequestParam("communityId") int communityId) { 
		return service.boardDelete(communityId);
	}
	
	@GetMapping("/boardUpdate.do") // 게시글 수정페이지 이동
	public String boardUpdate(@RequestParam("communityId") int communityId, Model model) {
		return service.boardUpdate(communityId, model);
	}
	
	@GetMapping("/boardContents.do") // 게시글 상세보기
	public String boardContents(@RequestParam("communityId") int communityId, Model model) { 
		return service.boardContents(communityId, model);
	}
	
	
	@PostMapping("/boardInsert.do") // 게시글 작성
	public String boardInsert(HttpServletRequest request) {
		
		
	return service.boardInsert(request);
	}
	
	// RequestMapping -> Get과 Post요청방식을 다 받아들이는 방식
	@GetMapping("/boardInsert.do") // 게시글 작성페이지 이동
	public void boardInsert() { // 페이지 이동할때는 spring에서 알아서 리턴해주기 때문에 굳이 return 값이 없어도 됨
	}
	
	@GetMapping("/boardChat.do") // 댓글 페이지 이동
	public String boardChat(@RequestParam("communityId") int communityId, 
	                       @RequestParam(value = "editComment", required = false) Integer editCommentIdx,
	                       Model model) {
		System.out.println(communityId);
		service.boardContents(communityId, model);
		if (editCommentIdx != null) {
			Comment editComment = service.getComment(editCommentIdx);
			model.addAttribute("editComment", editComment);
		}
		return "boardChat";
	}
	
	@PostMapping("/commentInsert.do") // 댓글 등록
	public String commentInsert(@RequestParam("communityId") int communityId, 
	                           @RequestParam("writer") String writer,
	                           @RequestParam("content") String content) {
		Comment comment = new Comment();
		comment.setBoardIdx(communityId);
		comment.setWriter(writer);
		comment.setContent(content);
		System.out.println(comment.getWriter());
		return service.commentInsert(comment);
	}
	
	@GetMapping("/commentDelete.do") // 댓글 삭제
	public String commentDelete(@RequestParam("commentIdx") int commentIdx,
	                          @RequestParam("communityId") int communityId) {
		return service.commentDelete(commentIdx, communityId);
	}
	
	@PostMapping("/commentUpdate.do") // 댓글 수정
	public String commentUpdate(@RequestParam("commentIdx") int commentIdx,
	                           @RequestParam("communityId") int communityId,
	                           @RequestParam("content") String content) {
		Comment comment = new Comment();
		comment.setCommentIdx(commentIdx);
		comment.setBoardIdx(communityId);
		comment.setContent(content);
		
		return service.commentUpdate(comment);
	}
	
	
}
