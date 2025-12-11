CREATE TABLE tracks(
	trackId INT NOT NULL AUTO_INCREMENT,
	trackName VARCHAR(20) NOT NULL,
	createdAt TIMESTAMP DEFAULT NOW(),
	PRIMARY KEY(trackId)
);
drop table tracks;
SELECT * FROM tracks;
INSERT  INTO tracks(trackName) values ("자연어 처리 A");  
SELECT * FROM tracks;
INSERT  INTO tracks(trackName) values ("자연어 처리 B");
INSERT  INTO tracks(trackName) values ("컴퓨터 비전 A");
INSERT  INTO tracks(trackName) values ("컴퓨터 비전 B");
INSERT  INTO tracks(trackName) values ("AI 플랫폼 및 인프라");
INSERT  INTO tracks(trackName) values ("AI 서비스 개발 B");
INSERT  INTO tracks(trackName) values ("AI 서비스 개발 A");
INSERT  INTO tracks(trackName) values ("AI 서비스 기획");
INSERT  INTO tracks(trackName) values ("AI 비즈니스");
INSERT  INTO tracks(trackName) values ("데이터 분석");  

COMMIT;