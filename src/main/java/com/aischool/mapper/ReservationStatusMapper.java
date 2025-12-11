package com.aischool.mapper;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReservationStatusMapper {
    
    Map<String, Object> getReservationStatus(@Param("date") LocalDate date, 
                                           @Param("startTime") LocalTime startTime, 
                                           @Param("roomId") int roomId);
    
    List<Map<String, Object>> getAllReservationStatus(@Param("status") String status,
                                                     @Param("pageSize") int pageSize,
                                                     @Param("offset") int offset);
    
    int getTotalReservationCount(@Param("status") String status);
    
    List<Map<String, Object>> getAllPossibleReservations(@Param("pageSize") int pageSize,
                                                        @Param("offset") int offset);
    
    int getTotalPossibleReservationsCount();
    
}
