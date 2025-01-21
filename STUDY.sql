CREATE TABLE TB_CLASS_TYPE (
	NUM varchar2(50),
	CLASS_TYPE VARCHAR2(50),
	
	CONSTRAINT NAME_PK PRIMARY KEY (NUM),
	CONSTRAINT CL_TYPE unique(CLASS_TYPE)
);

DROP TABLE TB_CLASS_TYPE;
SELECT * FROM TB_CLASS_TYPE;

INSERT INTO TB_CLASS_TYPE
VALUES ('01', '전공필수');
INSERT INTO TB_CLASS_TYPE
VALUES ('02', '전공선택');
INSERT INTO TB_CLASS_TYPE
VALUES ('03', '교양필수');
INSERT INTO TB_CLASS_TYPE
VALUES ('04', '교양선택');
INSERT INTO TB_CLASS_TYPE
VALUES ('05', '논문지도');
------------------------------

CREATE TABLE TB_학생일반정보 AS (
	SELECT student_NO 학번, student_name 학생이름, student_address 주소
	FROM TB_STUDENT
);

SELECT * FROM TB_학생일반정보;
-----------------------------------------------------
CREATE TABLE TB_국어국문학과
AS (SELECT STUDENT_NO 학번, STUDENT_NAME 학생이름, 
	EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,2), 'RR')) 출생년도, 
	PROFESSOR_NAME 교수이름
      FROM TB_STUDENT S NATURAL JOIN TB_PROFESSOR P NATURAL JOIN TB_DEPARTMENT D
     WHERE  DEPARTMENT_NAME = '국어국문학과');

SELECT * FROM TB_국어국문학과;

----------------------------------------------------
UPDATE TB_DEPARTMENT SET capacity = capacity+(capacity*0.1);
SELECT * FROM TB_DEPARTMENT;
----------------------------------------------------
SELECT * FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';

UPDATE TB_STUDENT SET student_address = '서울시 종로구 숭인동 181-21'WHERE STUDENT_NO = 'A413042';

----------------------------------------------------
SELECT * FROM TB_STUDENT;
UPDATE TB_STUDENT SET student_ssn = substr(student_ssn,1,6);
----------------------------------------------------
SELECT TG.POINT  FROM TB_STUDENT ts
NATURAL JOIN TB_DEPARTMENT td 
NATURAL JOIN TB_CLASS tc 
NATURAL JOIN TB_GRADE tg 
WHERE STUDENT_NAME = '김명훈'
AND TD.DEPARTMENT_NAME = '의학과'
AND TC.CLASS_NAME = '피부생리학'
AND TG.TERM_NO = '200501';

UPDATE TB_GRADE SET point = 3.5 WHERE point = (SELECT TG.POINT  FROM TB_STUDENT ts
NATURAL JOIN TB_DEPARTMENT td 
NATURAL JOIN TB_CLASS tc 
NATURAL JOIN TB_GRADE tg 
WHERE STUDENT_NAME = '김명훈'
AND TD.DEPARTMENT_NAME = '의학과'
AND TC.CLASS_NAME = '피부생리학'
AND TG.TERM_NO = '200501');
----------------------------------------------------
SELECT student_no FROM TB_GRADE
NATURAL JOIN TB_STUDENT
WHERE ABSENCE_YN = 'N';

DELETE TB_GRADE WHERE student_no IN (SELECT student_no FROM TB_GRADE
NATURAL JOIN TB_STUDENT
WHERE ABSENCE_YN = 'N');
