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
INSERT INTO studyRooms (floor, roomName, studyImg, isActive, isEquipment) VALUES
  (1, '1층 AI Cafe', '1층 AICafe.png', FALSE, FALSE),
  (2, '2층 세미나실', '2층세미나실.png', FALSE, FALSE),
  (2, 'AI Lab 1', 'AILab1.png', FALSE, FALSE),
  (2, '2층 휴게공간','2층휴게공간.png', FALSE,FALSE),
  (3, '3층 Ai Lab 2', '3층AiLab2.png', FALSE, FALSE),
  (3, '3층 세미나실', '3층세미나실.png', FALSE, FALSE),
  (3, '3층 휴게공간', '3층휴게공간.png', FALSE, FALSE);

DROP TABLE STUDYROOMS;
SELECT * FROM studyRooms;
COMMIT;
SHOW TABLES;