CREATE OR REPLACE VIEW ComScience(c_major,c_id,c_id_no,c_name,c_unit,c_time,c_year,c_semester,c_pop,c_max)
AS
SELECT c_major,c_id,c_id_no,c_name,c_unit,c_time,c_year,c_semester,c_pop,c_max
FROM course
WHERE c_major='컴퓨터공학과';

CREATE OR REPLACE VIEW Statistics(c_major,c_id,c_id_no,c_name,c_unit,c_time,c_year,c_semester,c_pop,c_max)
AS
SELECT c_major,c_id,c_id_no,c_name,c_unit,c_time,c_year,c_semester,c_pop,c_max
FROM course
WHERE c_major='통계학과';
