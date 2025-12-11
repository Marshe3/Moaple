package com.aischool.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.aischool.entity.Tracks;

@Mapper
public interface TracksMapper {
	public List<Tracks> tracksList();
}
