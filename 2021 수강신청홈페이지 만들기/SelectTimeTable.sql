CREATE OR REPLACE PROCEDURE SelectTimeTable
(sStudentId IN enroll.s_id%TYPE,
nYear IN enroll.e_year%TYPE,
nSemester IN enroll.e_semester%TYPE,
tCourse OUT NUMBER,
tUnit OUT NUMBER)
IS
BEGIN
    DECLARE
	CURSOR timeTable IS
		SELECT c_time,c_id,c_name,c_id_no,c_unit
		FROM course 
		WHERE (c_id, c_id_no) IN (SELECT c_id, c_id_no FROM enroll WHERE s_id=sStudentId AND e_year = nYear AND e_semester = nSemester );
	curTab timeTable%ROWTYPE;
      BEGIN
	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId ||'님의 ' || nYear || '년도 '  || nSemester || '학기의 수강신청 시간표입니다.');
	tCourse := 0;
	tUnit := 0;
	OPEN timeTable; 
	LOOP 
		FETCH timeTable INTO curTab; 
		EXIT WHEN timeTable%NOTFOUND; 
		tCourse := tCourse + 1;
		tUnit := tUnit + curTab.c_unit;
		DBMS_OUTPUT.put_line('교시:' || curTab.c_time || ', 과목코드:' || curTab.c_id  || ', 과목명 : ' || curTab.c_name || ', 분반 :' || curTab.c_id_no || ', 학점 : ' || curTab.c_unit );
	END LOOP;
	DBMS_OUTPUT.put_line('총 ' || tCourse || '과목과 총 ' || tUnit || '학점을 신청하였습니다.');
      END;
END;
/

DECLARE
tCourse  NUMBER;
tUnit NUMBER;
BEGIN
SelectTimeTable('1816461',2021,2,tCourse,tUnit);
END;
/