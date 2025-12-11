-- 커뮤니티 테이블 재생성 스크립트
-- 사용법: 이 전체 스크립트를 MySQL Workbench에서 실행

-- 1. 기존 테이블 삭제 (외래키 제약조건 때문에 에러가 발생할 수 있으므로 안전하게 삭제)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS community;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. 커뮤니티 테이블 생성
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

-- 3. 샘플 데이터 삽입 (users 테이블에 해당 userId가 존재해야 함)
-- 먼저 users 테이블에 샘플 사용자가 있는지 확인
INSERT IGNORE INTO users(userId, userName, userEmail, userPw, createdAt) 
VALUES
(1, '김혜수', 'hyesoo@example.com', 'password123', NOW()),
(2, '전재홍', 'jaehong@example.com', 'password123', NOW()),
(3, '문성균', 'sungkyun@example.com', 'password123', NOW()),
(4, '김경민', 'kyungmin@example.com', 'password123', NOW());

-- 4. 커뮤니티 샘플 데이터 삽입
INSERT INTO community(userId, title, content, viewCount)
VALUES
(1, '이번 주 토요일 고려조 모임 구합니다', '아름이가 전체 삼계탕 쏜대~', 15),
(2, '내일 벌써 금요일이네 와우! 신바람 곱참 갈사람', '혹시 야곱을 아시나요?', 8),
(3, '강쥐가 나아 아니면 강지나가 나아', '재밌죠', 22),
(4, '내 이름은 경민 학생이죠', '자바를 모르신다면~', 31),
(1, '스터디룸 예약 관련 문의드립니다', '내일 오후 2시에 스터디룸 예약이 가능한가요?', 5),
(2, '모아플 사용법 공유합니다', '처음 사용하시는 분들을 위한 간단한 가이드입니다.', 12);

-- 5. 결과 확인
COMMIT;

-- 6. 생성된 데이터 확인
SELECT '=== USERS 테이블 확인 ===' as info;
SELECT userId, userName, userEmail, createdAt FROM users WHERE userId IN (1,2,3,4);

SELECT '=== COMMUNITY 테이블 확인 ===' as info;
SELECT 
    c.communityId, 
    c.userId, 
    u.userName,
    c.title, 
    c.content,
    c.viewCount,
    c.filepath,
    c.createdAt
FROM community c 
LEFT JOIN users u ON c.userId = u.userId 
ORDER BY c.communityId;

SELECT '=== 테이블 구조 확인 ===' as info;
DESCRIBE community;