CREATE OR REPLACE PROCEDURE countstudent
(cid IN course.c_id%TYPE, 
 cidno IN course.c_id_no%TYPE)
IS
ncount NUMBER;
CURSOR course_list(cid course.c_id%TYPE, cidno course.c_id_no%TYPE) IS
      SELECT  s_id
      FROM enroll
      WHERE  c_id = cid and c_id_no=cidno ;
BEGIN 
ncount :=0 ;
   FOR courselst IN course_list(cid,cidno) LOOP
      ncount :=ncount+1;
   END LOOP;

   UPDATE course 
   SET c_pop = ncount 
   WHERE c_id = cid and c_id_no=cidno ;
END;
/