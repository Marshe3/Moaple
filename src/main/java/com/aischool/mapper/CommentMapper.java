package com.aischool.mapper;

import java.util.ArrayList;

import com.aischool.entity.Comment;

public interface CommentMapper {
    public void commentInsert(Comment comment);
    public ArrayList<Comment> commentList(int boardIdx);
    public void commentDelete(int commentIdx);
    public Comment getComment(int commentIdx);
    public void commentUpdate(Comment comment);
}