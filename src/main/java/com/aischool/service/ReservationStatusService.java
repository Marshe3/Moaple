package com.aischool.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aischool.mapper.ReservationStatusMapper;

/**
 * 예약 현황 관리 서비스
 */
@Service
public class ReservationStatusService {
    
    @Autowired
    private ReservationStatusMapper reservationStatusMapper;
    
    /**
     * 특정 날짜/시간/장소의 예약 현황 확인
     */
    public Map<String, Object> checkReservationStatus(LocalDate date, LocalTime startTime, int roomId) {
        Map<String, Object> result = reservationStatusMapper.getReservationStatus(date, startTime, roomId);
        
        if (result == null) {
            Map<String, Object> availableStatus = new HashMap<>();
            availableStatus.put("status", "예약 가능");
            availableStatus.put("date", date);
            availableStatus.put("time", startTime + " - " + startTime.plusHours(1));
            return availableStatus;
        }
        
        return result;
    }
    
    /**
     * 모든 예약 현황 조회 (페이징 포함)
     */
    public Map<String, Object> getAllReservationStatus(String status, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        
        List<Map<String, Object>> reservations = reservationStatusMapper.getAllReservationStatus(status, pageSize, offset);
        int totalCount = reservationStatusMapper.getTotalReservationCount(status);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        
        Map<String, Object> result = new HashMap<>();
        result.put("reservations", reservations);
        result.put("totalCount", totalCount);
        result.put("totalPages", totalPages);
        result.put("currentPage", page);
        result.put("hasNext", page < totalPages);
        result.put("hasPrevious", page > 1);
        result.put("pageNumbers", getPageNumbers(page, totalPages));
        
        return result;
    }
    
    /**
     * 당일/다음날 모든 시간대 예약 현황 조회 (9시-22시, 페이징 포함)
     */
    public Map<String, Object> getAllPossibleReservations(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        
        List<Map<String, Object>> reservations = reservationStatusMapper.getAllPossibleReservations(pageSize, offset);
        int totalCount = reservationStatusMapper.getTotalPossibleReservationsCount();
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        
        Map<String, Object> result = new HashMap<>();
        result.put("reservations", reservations);
        result.put("totalCount", totalCount);
        result.put("totalPages", totalPages);
        result.put("currentPage", page);
        result.put("hasNext", page < totalPages);
        result.put("hasPrevious", page > 1);
        result.put("pageNumbers", getPageNumbers(page, totalPages));
        
        return result;
    }
    
    /**
     * 상태별 필터링된 예약 현황 조회
     */
    public Map<String, Object> getFilteredReservations(String status, int page, int pageSize) {
        // 모든 장소/날짜 조합을 가져온 후 클라이언트에서 필터링
        Map<String, Object> allReservations = getAllPossibleReservations(page, pageSize);
        
        if (status == null || "전체".equals(status)) {
            return allReservations;
        }
        
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> reservations = (List<Map<String, Object>>) allReservations.get("reservations");
        
        // 상태별 필터링
        List<Map<String, Object>> filteredReservations = reservations.stream()
            .filter(reservation -> status.equals(reservation.get("status")))
            .collect(java.util.stream.Collectors.toList());
        
        // 필터링된 결과로 결과 맵 업데이트
        Map<String, Object> result = new HashMap<>();
        result.put("reservations", filteredReservations);
        result.put("totalCount", filteredReservations.size());
        result.put("totalPages", filteredReservations.size() > 0 ? Math.max(1, (int) Math.ceil((double) filteredReservations.size() / pageSize)) : 1);
        result.put("currentPage", page);
        result.put("hasNext", false);
        result.put("hasPrevious", false);
        result.put("pageNumbers", java.util.Arrays.asList(1));
        
        return result;
    }
    
    /**
     * 예약 가능 여부 확인
     */
    public boolean isReservationAvailable(LocalDate date, LocalTime startTime, int roomId) {
        Map<String, Object> status = checkReservationStatus(date, startTime, roomId);
        return "예약 가능".equals(status.get("status"));
    }
    
    /**
     * 페이지 번호 생성
     */
    private List<Integer> getPageNumbers(int currentPage, int totalPages) {
        List<Integer> pageNumbers = new ArrayList<>();
        
        int startPage = Math.max(1, currentPage - 2);
        int endPage = Math.min(totalPages, currentPage + 2);
        
        if (endPage - startPage < 4) {
            if (startPage == 1) {
                endPage = Math.min(totalPages, startPage + 4);
            } else {
                startPage = Math.max(1, endPage - 4);
            }
        }
        
        for (int i = startPage; i <= endPage; i++) {
            pageNumbers.add(i);
        }
        
        return pageNumbers;
    }
}