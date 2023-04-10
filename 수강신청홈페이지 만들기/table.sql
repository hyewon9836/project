CREATE TABLE STUDENT(
S_ID varchar(10),
S_PWD varchar(10),
S_NAME varchar(30),
PRIMARY KEY(S_ID)
);
INSERT INTO STUDENT VALUES('1714121', 'abcde', '이혜원');
INSERT INTO STUDENT VALUES('1816461', 'abcde', '노세희');
INSERT INTO STUDENT VALUES('1710385', 'abcde', '한하랑');
INSERT INTO STUDENT VALUES('1712345', 'abcde', '서인국');
INSERT INTO STUDENT VALUES('1612345', 'abcde', '박서준');
INSERT INTO STUDENT VALUES('1512345', 'abcde', '장기용');


CREATE TABLE ENROLL(
S_ID varchar(10),
C_ID varchar(10),
C_ID_NO number,
E_YEAR number,
E_SEMESTER number,
PRIMARY KEY(S_ID, C_ID),
FOREIGN KEY(S_ID) REFERENCES STUDENT,
FOREIGN KEY(C_ID,C_ID_NO) REFERENCES COURSE
);

CREATE TABLE COURSE(
C_MAJOR varchar(20),
C_ID varchar(10),
C_ID_NO number,
C_NAME varchar(50),
C_UNIT number,
C_YEAR number,
C_SEMESTER number,
C_TIME number,
C_MAX number,
C_POP number,
PRIMARY KEY (C_ID,C_ID_NO)
);
INSERT INTO COURSE VALUES('컴퓨터공학과','C700',1,'데이터베이스 프로그래밍',3,2021,1,1,5,0);
INSERT INTO COURSE VALUES('컴퓨터공학과','C800', 2, '데이터베이스 프로그래밍',3,2021,2,1,5,0);
INSERT INTO COURSE VALUES('컴퓨터공학과','C800', 3, '데이터베이스 프로그래밍',3,2021,2,1,5,0);
INSERT INTO COURSE VALUES('컴퓨터공학과','C900', 3, '멀티미디어 개론',3,2021,2,2,5,0);
INSERT INTO COURSE VALUES('컴퓨터공학과','M100', 3, '선형대수',3,2021,2,3,5,0);
INSERT INTO COURSE VALUES('컴퓨터공학과','M200', 3, '그래픽 활용',3,2021,2,4,5,0);
INSERT INTO COURSE VALUES('컴퓨터공학과','M300', 3, '윈도우 프로그래밍',3,2021,2,5,5,0);
INSERT INTO COURSE VALUES('컴퓨터공학과','M400', 3, '멀티미디어 처리',3,2021,2,6,5,0);
INSERT INTO COURSE VALUES('컴퓨터공학과','M500', 3, '게임프로그래밍',3,2021,2,7,5,0);
INSERT INTO COURSE VALUES('컴퓨터공학과','M600', 3, '컴퓨터 그래픽스',3,2021,2,1,5,0);
INSERT INTO COURSE VALUES('통계학과','S100',1,'기초통계학',3,2021,2,1,5,0);
INSERT INTO COURSE VALUES('통계학과','S200',1,'수리통계학',3,2021,2,1,5,0);


