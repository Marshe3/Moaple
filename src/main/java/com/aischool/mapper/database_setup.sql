-- ==============================================
-- MOAPLE 데이터베이스 전체 구축 스크립트
-- 모든 테이블 삭제 → 생성 → 샘플 데이터 삽입
-- ==============================================

-- 외래키 제약조건 비활성화 (테이블 삭제를 위해)
SET FOREIGN_KEY_CHECKS = 0;

-- ==============================================
-- 1. 기존 테이블 모두 삭제 (순서 중요: 자식테이블 먼저 삭제)
-- ==============================================
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS community;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS studyRooms;
DROP TABLE IF EXISTS tracks;

-- 외래키 제약조건 다시 활성화
SET FOREIGN_KEY_CHECKS = 1;

-- ==============================================
-- 2. 테이블 생성 (순서 중요: 부모테이블 먼저 생성)
-- ==============================================

-- 2-1. tracks 테이블 생성
CREATE TABLE tracks(
    trackId INT NOT NULL AUTO_INCREMENT,
    trackName VARCHAR(20) NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY(trackId)
);

-- 2-2. studyRooms 테이블 생성
CREATE TABLE studyRooms(
    roomId INT NOT NULL AUTO_INCREMENT,
    floor tinyint NOT NULL,
    roomName VARCHAR(50) NOT NULL,
    studyImg TEXT NOT NULL,
    isActive BOOLEAN NOT NULL,
    isEquipment BOOLEAN NOT NULL,
    createdAt TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY(roomId)
);

-- 2-3. users 테이블 생성
CREATE TABLE users(
    userId INT NOT NULL AUTO_INCREMENT,
    trackId INT NOT NULL,
    userName VARCHAR(100) NOT NULL,
    password VARCHAR(200) NOT NULL,
    name VARCHAR(100) NOT NULL,
    projectTeamName VARCHAR(200) NOT NULL,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    phone VARCHAR(20),
    profileImg VARCHAR(500) DEFAULT 'default_img.png',
    PRIMARY KEY(userId),
    FOREIGN KEY(trackId) REFERENCES tracks(trackId)
);

-- 2-4. community 테이블 생성
CREATE TABLE community(
    communityId INT NOT NULL AUTO_INCREMENT,
    userId int NOT NULL,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    viewCount int NOT NULL DEFAULT 0,
    filepath VARCHAR(300),
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (communityId),
    FOREIGN KEY (userId) REFERENCES users(userId) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 2-5. reservation 테이블 생성
CREATE TABLE reservation(
    reservationId INT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL,
    trackId INT NOT NULL,
    roomId INT NOT NULL,
    reservationDate DATE NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    participantCount INT NOT NULL,
    purpose TEXT NOT NULL,
    status ENUM('active', 'completed', 'cancelled') NOT NULL,
    createdAt TIMESTAMP NOT NULL,
    PRIMARY KEY (reservationId),
    FOREIGN KEY (trackId) REFERENCES tracks(trackId),
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (roomId) REFERENCES studyRooms(roomId)
);

-- 2-6. comments 테이블 생성
CREATE TABLE comments(
    commentId INT NOT NULL AUTO_INCREMENT,
    communityId INT NOT NULL,
    userId INT NOT NULL,
    content VARCHAR(1000) NOT NULL, 
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(commentId),
    FOREIGN KEY(communityId) REFERENCES community(communityId) ON DELETE CASCADE,
    FOREIGN KEY(userId) REFERENCES users(userId) ON DELETE CASCADE
);

-- ==============================================
-- 3. 샘플 데이터 삽입
-- ==============================================

-- 3-1. tracks 샘플 데이터
INSERT INTO tracks(trackName) VALUES 
('자연어 처리 A'),
('자연어 처리 B'),
('컴퓨터 비전 A'),
('컴퓨터 비전 B'),
('AI 플랫폼 및 인프라'),
('AI 서비스 개발 B'),
('AI 서비스 개발 A'),
('AI 서비스 기획'),
('AI 비즈니스'),
('데이터 분석');

-- 3-2. studyRooms 샘플 데이터
INSERT INTO studyRooms (floor, roomName, studyImg, isActive, isEquipment) VALUES
(1, '1층 AI Cafe', '1층 AICafe.png', TRUE, FALSE),
(2, '2층 세미나실', '2층세미나실.png', TRUE, TRUE),
(2, 'AI Lab 1', 'AILab1.png', TRUE, TRUE),
(2, '2층 휴게공간','2층휴게공간.png', TRUE, FALSE),
(3, '3층 Ai Lab 2', '3층AiLab2.png', TRUE, TRUE),
(3, '3층 세미나실', '3층세미나실.png', TRUE, TRUE),
(3, '3층 휴게공간', '3층휴게공간.png', TRUE, FALSE);

-- 3-3. users 샘플 데이터
INSERT INTO users(trackId, userName, password, name, projectTeamName, phone) VALUES
(1, 'hyesoo@aischool.com', '$2a$10$example1', '김혜수', '모아플팀', '010-1234-5678'),
(2, 'jaehong@aischool.com', '$2a$10$example2', '전재홍', '모아플팀', '010-2345-6789'),
(3, 'sungkyun@aischool.com', '$2a$10$example3', '문성균', '모아플팀', '010-3456-7890'),
(4, 'kyungmin@aischool.com', '$2a$10$example4', '김경민', '모아플팀', '010-4567-8901'),
(1, 'admin@aischool.com', '$2a$10$example5', '관리자', '관리팀', '010-0000-0000');

-- 3-4. community 샘플 데이터
INSERT INTO community(userId, title, content, viewCount) VALUES
(1, '이번 주 토요일 고려조 모임 구합니다', '아름이가 전체 삼계탕 쏜대~', 15),
(2, '내일 벌써 금요일이네 와우! 신바람 곱참 갈사람', '혹시 야곱을 아시나요?', 8),
(3, '강쥐가 나아 아니면 강지나가 나아', '재밌죠', 22),
(4, '내 이름은 경민 학생이죠', '자바를 모르신다면~', 31),
(1, '스터디룸 예약 관련 문의드립니다', '내일 오후 2시에 스터디룸 예약이 가능한가요?', 5),
(2, '모아플 사용법 공유합니다', '처음 사용하시는 분들을 위한 간단한 가이드입니다.', 12),
(3, 'AI 서비스 개발 스터디 모집', '함께 공부하실 분들 모집합니다!', 18),
(4, '프로젝트 팀원 구해요', '졸업 프로젝트 함께 하실 분 찾습니다', 25);

-- 3-5. comments 샘플 데이터
INSERT INTO comments(communityId, userId, content) VALUES
(1, 2, '저도 참여하고 싶어요!'),
(1, 3, '시간 맞으면 갈게요~'),
(2, 1, '야곱이 누구예요? ㅋㅋ'),
(3, 4, '둘 다 귀엽네요'),
(4, 1, '자바 공부 중입니다!'),
(5, 3, '2시는 예약 가능할 것 같아요'),
(6, 4, '유용한 정보 감사합니다'),
(7, 1, '저도 스터디 참여하고 싶습니다');

-- 3-6. reservation 샘플 데이터 (현재 날짜 기준)
INSERT INTO reservation(userId, trackId, roomId, reservationDate, startTime, endTime, participantCount, purpose, status, createdAt) VALUES
(1, 1, 2, CURDATE(), '09:00:00', '12:00:00', 4, '팀 프로젝트 회의', 'active', NOW()),
(2, 2, 3, CURDATE() + INTERVAL 1 DAY, '14:00:00', '17:00:00', 6, 'AI 스터디', 'active', NOW()),
(3, 3, 4, CURDATE() + INTERVAL 2 DAY, '10:00:00', '15:00:00', 3, '개인 학습', 'active', NOW());

-- ==============================================
-- 4. 데이터 확인
-- ==============================================

COMMIT;

-- 생성된 테이블 목록 확인
SHOW TABLES;

-- 각 테이블별 데이터 확인
SELECT '=== TRACKS 테이블 ===' as info;
SELECT * FROM tracks;

SELECT '=== STUDYROOMS 테이블 ===' as info;
SELECT * FROM studyRooms;

SELECT '=== USERS 테이블 ===' as info;
SELECT userId, userName, name, projectTeamName, trackId FROM users;

SELECT '=== COMMUNITY 테이블 ===' as info;
SELECT c.communityId, u.name as author, c.title, c.viewCount, c.createdAt 
FROM community c 
JOIN users u ON c.userId = u.userId 
ORDER BY c.communityId;

SELECT '=== COMMENTS 테이블 ===' as info;
SELECT cm.commentId, u.name as author, c.title as post_title, cm.content, cm.createdAt
FROM comments cm
JOIN users u ON cm.userId = u.userId
JOIN community c ON cm.communityId = c.communityId
ORDER BY cm.commentId;
select * from comments;
SELECT '=== RESERVATION 테이블 ===' as info;
SELECT r.reservationId, u.name as user_name, sr.roomName, r.reservationDate, 
       r.startTime, r.endTime, r.status
FROM reservation r
JOIN users u ON r.userId = u.userId
JOIN studyRooms sr ON r.roomId = sr.roomId
ORDER BY r.reservationId;

SELECT '=== 데이터베이스 설정 완료 ===' as result;