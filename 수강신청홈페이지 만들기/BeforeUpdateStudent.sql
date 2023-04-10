CREATE OR REPLACE TRIGGER BeforeUpdateStudent BEFORE
UPDATE ON student
FOR EACH ROW
DECLARE
	underflow_length EXCEPTION;
	invalid_value EXCEPTION;
	not_null_test EXCEPTION;
	nLength NUMBER;
	nBlank NUMBER;
	oldpwd VARCHAR(10);
   	newpwd VARCHAR(10);
BEGIN
	nLength := Length(:new.s_pwd);
	nBlank := INSTR(:new.s_pwd, ' ',1,1);
	oldpwd := :old.s_pwd;
	newpwd := :new.s_pwd;

	IF nLength < 4 THEN
		RAISE underflow_length;
	ELSIF nBlank != 0 THEN
		RAISE invalid_value;
	ELSIF oldpwd IS NULL  THEN
		RAISE not_null_test;
	ELSIF newpwd IS NULL THEN
		RAISE not_null_test;
	END IF;

	EXCEPTION
		WHEN underflow_length THEN
			RAISE_APPLICATION_ERROR(-20002, '암호는 4자리 이상이어야 합니다');
		WHEN invalid_value THEN
			RAISE_APPLICATION_ERROR(-20003, '암호에 공란은 입력되지 않습니다.');
		 WHEN not_null_test THEN
       			RAISE_APPLICATION_ERROR(-20004, '암호를 입력하셔야 합니다.');

END;
/
