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
	DROP TABLE RESERVATION;
	  

COMMIT;

SELECT * FROM RESERVATION WHERE USERID = 1 ORDER BY RESERVATIONID DESC;
SELECT * FROM RESERVATION;
