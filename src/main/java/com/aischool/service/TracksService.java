package com.aischool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.aischool.entity.Tracks;
import com.aischool.mapper.TracksMapper;

@Service
public class TracksService {
	@Autowired
	private TracksMapper mapper;
	
	public String getTracks(Model model) {
		List<Tracks> tracks = mapper.tracksList();
		model.addAttribute("tracks", tracks);
		System.out.println(tracks);
		return "join";
	}
}
