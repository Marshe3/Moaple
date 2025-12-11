DROP TABLE IF EXISTS community;

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
    FOREIGN KEY (userId) REFERENCES users(userId)
);

-- 샘플 데이터 (userId는 실제 users 테이블의 userId와 매핑되어야 함)
INSERT INTO community(userId, title, content)
VALUES(1, '이번 주 토요일 고려조 모임 구합니다', '아름이가 전체 삼계탕 쏜대~'),
(2, '내일 벌써 금요일이네 와우! 신바람 곱참 갈사람', '혹시 야곱을 아시나요?'),
(3, '강쥐가 나아 아니면 강지나가 나아', '재밌죠'),
(4, '내 이름은 경민 학생이죠', '자바를 모르신다면~');

COMMIT;
drop table community;
SELECT * FROM community;