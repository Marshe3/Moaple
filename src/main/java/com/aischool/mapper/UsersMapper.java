package com.aischool.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.aischool.entity.Users;

@Mapper
public interface UsersMapper {
	public void UsersJoin(Users users);
	public int checkUserName(String userName);
	
	public Users login(Users users);
	
	public Users getUser(int userId);
}
