package com.aischool.controller;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aischool.service.ReservationStatusService;

@Controller
@RequestMapping
public class ReservationStatusController {
    
    @Autowired
    private ReservationStatusService reservationStatusService;
    
    @GetMapping("/reservationStatus")
    public String getReservationStatus(
            @RequestParam(value = "status", defaultValue = "전체") String status,
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        
        int pageSize = 10;
        
        // 항상 당일/다음날 시간별 예약 현황을 조회
        Map<String, Object> result = reservationStatusService.getFilteredReservations(status, page, pageSize);
        
        model.addAttribute("allReservations", result.get("reservations"));
        model.addAttribute("currentStatus", status);
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("totalPages", result.get("totalPages"));
        model.addAttribute("totalItems", result.get("totalCount"));
        model.addAttribute("hasNext", result.get("hasNext"));
        model.addAttribute("hasPrevious", result.get("hasPrevious"));
        model.addAttribute("pageNumbers", result.get("pageNumbers"));
        
        return "reservationStatus";
    }
    
    @GetMapping("/api/reservation/list")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getReservationListApi(
            @RequestParam(value = "status", defaultValue = "전체") String status,
            @RequestParam(value = "page", defaultValue = "1") int page) {
        
        try {
            int pageSize = 10;
            Map<String, Object> result = reservationStatusService.getFilteredReservations(status, page, pageSize);
            
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("data", result);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "예약 현황 조회 중 오류가 발생했습니다.");
            
            return ResponseEntity.ok(response);
        }
    }
    
    @PostMapping("/api/reservation/click")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> handleReservationClick(@RequestBody Map<String, String> requestData) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String floor = requestData.get("floor");
            String room = requestData.get("room");
            String date = requestData.get("date");
            String time = requestData.get("time");
            String status = requestData.get("status");
            
            System.out.println("=== 예약 클릭 처리 ===");
            System.out.println("층: " + floor);
            System.out.println("방: " + room);
            System.out.println("날짜: " + date);
            System.out.println("시간: " + time);
            System.out.println("상태: " + status);
            
            if ("예약 가능".equals(status)) {
                response.put("success", true);
                response.put("message", "예약이 완료되었습니다!");
                response.put("data", requestData);
            } else {
                response.put("success", false);
                response.put("message", "예약할 수 없는 상태입니다.");
            }
            
        } catch (Exception e) {
            System.err.println("예약 처리 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
        }
        
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/api/reservation/status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getReservationStatusApi(
            @RequestParam("date") String dateStr,
            @RequestParam("startTime") String startTimeStr,
            @RequestParam("roomId") int roomId) {
        
        try {
            LocalDate date = LocalDate.parse(dateStr);
            LocalTime startTime = LocalTime.parse(startTimeStr);
            
            Map<String, Object> status = reservationStatusService.checkReservationStatus(date, startTime, roomId);
            
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("data", status);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "예약 상태 조회 중 오류가 발생했습니다.");
            
            return ResponseEntity.ok(response);
        }
    }
    
    @GetMapping("/api/reservation/available")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkAvailability(
            @RequestParam("date") String dateStr,
            @RequestParam("startTime") String startTimeStr,
            @RequestParam("roomId") int roomId) {
        
        try {
            LocalDate date = LocalDate.parse(dateStr);
            LocalTime startTime = LocalTime.parse(startTimeStr);
            
            boolean isAvailable = reservationStatusService.isReservationAvailable(date, startTime, roomId);
            
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("available", isAvailable);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "예약 가능 여부 확인 중 오류가 발생했습니다.");
            
            return ResponseEntity.ok(response);
        }
    }
}
