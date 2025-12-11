package com.aischool.service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.aischool.entity.Board;
import com.aischool.entity.Comment;
import com.aischool.entity.Users;
import com.aischool.mapper.BoardMapper;
import com.aischool.mapper.CommentMapper;
import com.aischool.mapper.UsersMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

// 실제 게시판 관련 모든 일을 할 클래스
@Service
public class BoardService {
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private UsersMapper usersMapper;
	
	@Autowired
	private CommentMapper commentMapper;
	
	 // 페이지네이션 적용 목록
    public String boardList(int page, int size, Model model) {
        if (page < 1) page = 1;
        if (size <= 0) size = 10;

        int total = mapper.boardTotalCount();
        int totalPages = (int) Math.ceil((double) total / size);
        if (totalPages == 0) totalPages = 1; // 빈 목록 대비
        if (page > totalPages) page = totalPages;

        int offset = (page - 1) * size;

        ArrayList<Board> list = mapper.boardListPaged(size, offset);

        // 페이지 블록(1~5, 6~10 ...)
        int blockSize = 5;
        int startPage = ((page - 1) / blockSize) * blockSize + 1;
        int endPage = Math.min(startPage + blockSize - 1, totalPages);

        model.addAttribute("list", list);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("total", total);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "boardList"; // /WEB-INF/views/boardList.jsp
    }


	public String boardInsert(HttpServletRequest request) {
		
		
		MultipartRequest multi = null;
		
		int size = 1000 * 1024;
        String save = request.getRealPath("resources/upload");
        
        // 업로드 디렉토리가 없으면 생성
        java.io.File uploadDir = new java.io.File(save);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
            System.out.println("Upload directory created: " + save);
        }
        
        String enc = "UTF-8";
        DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
		
        try {
			multi = new MultipartRequest(request, save, size, enc, df);
		} catch (IOException e) {
			System.out.println("File upload failed. Upload path: " + save);
			e.printStackTrace();
		}
        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        String userIdStr = multi.getParameter("userId");
        int userId = Integer.parseInt(userIdStr);
        
        // 로그인 체크 - userId가 0이면 로그인되지 않은 상태
        if(userId == 0) {
            return "redirect:/login.do";
        }
        
        String filePath = multi.getFilesystemName("filepath");
        if(filePath == null || filePath.isEmpty()) {
        	filePath = "default_img.png";
        }
        
        Board board = new Board();
        board.setContent(content);
        board.setTitle(title);
        board.setUserId(userId);
        board.setFilepath(filePath);
        
    

        mapper.boardInsert(board);
        return "redirect:/boardList.do";
	}

	public String boardContents(int communityId, Model model) {
		// communityId와 일치하는 게시글 가져와서 출력
		mapper.boardCount(communityId); // 게시글 조회수 증가
		Board vo = mapper.boardContents(communityId);
		// 임시로 댓글 기능 비활성화 (COMMENT 테이블이 없을 때)
		ArrayList<Comment> commentList = commentMapper.commentList(communityId);
		//ArrayList<Comment> commentList = new ArrayList<>();
		System.out.println(vo);
		Users user = usersMapper.getUser(vo.getUserId());
		model.addAttribute("vo", vo);
		model.addAttribute("commentList", commentList);
		model.addAttribute("user", user);
		return "boardContents";
	}

	public String boardDelete(int communityId) {
		mapper.boardDelete(communityId);
		return "redirect:/boardList.do";
	}
	
	
	// 게시글 수정 메서드
	public String boardUpdate(HttpServletRequest request) {
		
		
		MultipartRequest multi = null;
		
		int size = 1000 * 1024;
        String save = request.getRealPath("resources/upload");
        
        // 업로드 디렉토리가 없으면 생성
        java.io.File uploadDir = new java.io.File(save);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
            System.out.println("Upload directory created: " + save);
        }
        
        String enc = "UTF-8";
        DefaultFileRenamePolicy df = new DefaultFileRenamePolicy();
		
        try {
			multi = new MultipartRequest(request, save, size, enc, df);
		} catch (IOException e) {
			System.out.println("File upload failed. Upload path: " + save);
			e.printStackTrace();
		}
        // communityId값 String으로 가져오기
        String communityIdStr = multi.getParameter("communityId");
        int communityId = Integer.parseInt(communityIdStr);
        Board vo = new Board();
        vo = mapper.boardContents(communityId);
        
        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        String userIdStr = multi.getParameter("userId");
        int userId = Integer.parseInt(userIdStr);
        String filePath = multi.getFilesystemName("filepath");
        if(filePath == null || filePath.isEmpty()) {
        	// 파일 변경이 없으면 기존 파일 경로 유지
        	filePath = vo.getFilepath();
        }
        
        
        vo.setContent(content);
        vo.setTitle(title);
        vo.setUserId(userId);
        vo.setFilepath(filePath);
        vo.setCommunityId(communityId);
        
    

        mapper.boardUpdate(vo);
        return "redirect:/boardContents.do?communityId="+vo.getCommunityId();
	}
	
	
	
	// 수정 페이지 진입 메서드
	public String boardUpdate(int communityId, Model model) {
		Board vo = mapper.boardContents(communityId); 
		model.addAttribute("vo", vo);
		return "boardUpdate";
	}

	
	
	public String commentInsert(Comment comment) {
		commentMapper.commentInsert(comment);
		return "redirect:/boardContents.do?communityId=" + comment.getBoardIdx();
	}
	
	public ArrayList<Comment> commentList(int boardIdx) {
		return commentMapper.commentList(boardIdx);
	}
	
	public String commentDelete(int commentIdx, int boardIdx) {
		commentMapper.commentDelete(commentIdx);
		return "redirect:/boardContents.do?communityId=" + boardIdx;
	}
	
	public Comment getComment(int commentIdx) {
		return commentMapper.getComment(commentIdx);
	}
	
	public String commentUpdate(Comment comment) {
		commentMapper.commentUpdate(comment);
		return "redirect:/boardContents.do?communityId=" + comment.getBoardIdx();
	}
	
}
