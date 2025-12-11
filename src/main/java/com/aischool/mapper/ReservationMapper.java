package com.aischool.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.aischool.entity.Reservation;
import com.aischool.entity.StudyRooms;

@Mapper
public interface ReservationMapper {
	
	public ArrayList<Reservation> reservationList();
	
	public ArrayList<StudyRooms> studyRoomsList();
	
	public int insertReservation(Reservation reservation);
	
	public Integer getRoomIdByName(String roomName);
	
	public ArrayList<Reservation> getReservationsFromTodayToTomorrow();
}
