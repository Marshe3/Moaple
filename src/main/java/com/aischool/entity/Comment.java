package com.aischool.entity;

import java.sql.Timestamp;

public class Comment {
    private int commentIdx;
    private int boardIdx;
    private String writer;
    private String content;
    private Timestamp indate;
    private String profileImg;
    private int trackId;
    private String trackName;
    
    public Comment() {}
    
    public Comment(int commentIdx, int boardIdx, String writer, String content, Timestamp indate) {
        this.commentIdx = commentIdx;
        this.boardIdx = boardIdx;
        this.writer = writer;
        this.content = content;
        this.indate = indate;
    }
    
    public int getCommentIdx() {
        return commentIdx;
    }
    
    public void setCommentIdx(int commentIdx) {
        this.commentIdx = commentIdx;
    }
    
    public int getBoardIdx() {
        return boardIdx;
    }
    
    public void setBoardIdx(int boardIdx) {
        this.boardIdx = boardIdx;
    }
    
    public String getWriter() {
        return writer;
    }
    
    public void setWriter(String writer) {
        this.writer = writer;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public Timestamp getIndate() {
        return indate;
    }
    
    public void setIndate(Timestamp indate) {
        this.indate = indate;
    }
    
    public String getProfileImg() {
        return profileImg;
    }
    
    public void setProfileImg(String profileImg) {
        this.profileImg = profileImg;
    }
    
    public int getTrackId() {
        return trackId;
    }
    
    public void setTrackId(int trackId) {
        this.trackId = trackId;
    }
    
    public String getTrackName() {
        return trackName;
    }
    
    public void setTrackName(String trackName) {
        this.trackName = trackName;
    }
    
    @Override
    public String toString() {
        return "Comment [commentIdx=" + commentIdx + ", boardIdx=" + boardIdx + ", writer=" + writer + ", content="
                + content + ", indate=" + indate + ", profileImg=" + profileImg + ", trackId=" + trackId + ", trackName=" + trackName + "]";
    }
}