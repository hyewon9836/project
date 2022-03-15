Set ServerOutput On;
VAR tCourse NUMBER;
VAR tunit NUMBER;
DECLARE
result  VARCHAR2(70) := '';
BEGIN

DBMS_OUTPUT.enable;

DBMS_OUTPUT.put_line('**************** Insert 및 에러 처리 테스트 ********************');

/* 에러 처리 2 : 동일한 수업 신청 여부 :데이터베이스프로그래밍 수업 신청 */
InsertEnroll('1710385', 'C800', 2, result);
DBMS_OUTPUT.put_line('결과 : ' || result);


/* 에러 처리 3 : 수강신청 인원 초과 여부 : 멀티미디어 개론 신청*/
InsertEnroll('1710385', 'C900', 3, result);
DBMS_OUTPUT.put_line('결과 : ' || result);


/* 에러 처리 4 : 신청한 수업들 시간 중복 여부  : 컴퓨터 그래픽스 신청 */
InsertEnroll('1710385', 'M600', 3, result);
DBMS_OUTPUT.put_line('결과 : ' || result);


/*  에러가 없는 경우  : 게임프로그래밍 신청  */
InsertEnroll('1710385', 'M500', 3, result);
DBMS_OUTPUT.put_line('결과 : ' || result);


/*  에러 처리 1 : 최대 학점 초과 여부 검사 : 기초통계 신청 */
InsertEnroll('1710385', 'S100', 1, result);
DBMS_OUTPUT.put_line('결과  : ' || result);


DBMS_OUTPUT.put_line('***************** CURSOR를 이용한 SELECT 테스트 ****************');

/* 최종 결과 확인 */
SelectTimeTable('1710385', 2021, 2,:tCourse,:tUnit);

delete from enroll where s_id='1710385' and c_id='C800' and c_id_no=3;

END;
/

SELECT s_id,s_pwd FROM STUDENT WHERE s_id='1710385';
UPDATE STUDENT SET s_pwd='12' WHERE s_id='1710385';
UPDATE STUDENT SET s_pwd='1 345' WHERE s_id='1710385';
UPDATE STUDENT SET s_pwd=NULL WHERE s_id='1710385';
UPDATE STUDENT SET s_pwd='12345' WHERE s_id='1710385';
SELECT s_id,s_pwd FROM STUDENT WHERE s_id='1710385';
