CREATE OR REPLACE FUNCTION Date2EnrollYear(dDate IN DATE)
RETURN NUMBER
IS
	nMonth CHAR(2);
	nYear NUMBER;
BEGIN
	SELECT TO_NUMBER(TO_CHAR(dDate, 'YYYY')),TO_CHAR(dDate, 'MM')
	INTO nYear, nMonth
	FROM DUAL;
	IF (nMonth = '11' OR nMonth = '12')THEN
		nYear := nYear+1 ;
	END IF;
	RETURN nYear;
END;
/

CREATE OR REPLACE FUNCTION Date2EnrollSemester(dDate IN DATE)
RETURN NUMBER
IS
	nMonth CHAR(2);
	nSemester NUMBER;
BEGIN 
SELECT TO_CHAR(dDate, 'MM')
	INTO nMonth
	FROM DUAL;
	IF (nMonth >= '05' and nMonth <= '10')THEN
		nSemester := 2;
	ELSE
		nSemester := 1;
	END IF;
	RETURN nSemester;
END; 
/