Rem Copyright (c) 1990 by Oracle Corporation
Rem NAME
Rem    UTLSAMPL.SQL
Rem  FUNCTION
Rem  NOTES
Rem  MODIFIED
Rem	gdudey	   06/28/95 -  Modified for desktop seed database
Rem	glumpkin   10/21/92 -  Renamed from SQLBLD.SQL
Rem	blinden   07/27/92 -  Added primary and foreign keys to EMP and DEPT
Rem	rlim	   04/29/91 -	      change char to varchar2
Rem	mmoore	   04/08/91 -	      use unlimited tablespace priv
Rem	pritto	   04/04/91 -	      change SYSDATE to 13-JUL-87
Rem MENDELS 12/07/90 - BUG 30123;
Rem ADD TO_DATE CALLS SO LANGUAGE INDEPENDENT

Rem
Rem $Header: utlsampl.sql 7020100.1 94/09/23 22:14:24 cli Generic<base> $ sqlbld.sql
Rem
SET TERMOUT OFF
SET ECHO OFF

Rem CONGDON    Invoked in RDBMS at build time.	 29-DEC-1988
Rem OATES:     Created: 16-Feb-83

/*
 * SCOTT 계정 생성 및 암호 TIGER 지정
 */

GRANT (CONNECT, RESOURCE, UNLIMITED TABLESPACE) TO SCOTT IDENTIFIED BY TIGER;

ALTER USER TEST DEFAULT TABLESPACE USERS;
ALTER USER TEST TEMPORARY TABLESPACE TEMP;

ALTER USER TEST ACCOUNT UNLOCK;	-- 계정 잠금 해제

GRANT UNLIMITED TABLESPACE TO TEST; -- TABLESPACE 공간 무제한 부여

CONNECT SCOTT/TIGER

-- DROP TABLE DEPT;

CREATE TABLE DEPT (
	DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);

SELECT *
FROM DEPT;

INSERT INTO DEPT VALUES (
	10,
	'ACCOUNTING',
	'NEW YORK'
);

INSERT INTO DEPT VALUES (
	20,
	'RESEARCH',
	'DALLAS'
);

INSERT INTO DEPT VALUES (
	30,
	'SALES',
	'CHICAGO'
);

INSERT INTO DEPT VALUES (
	40,
	'OPERATIONS',
	'BOSTON'
);

SELECT *
FROM EMP;

DROP TABLE EMP;

CREATE TABLE EMP (
	EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7, 2),
	COMM NUMBER(7, 2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
);

INSERT INTO EMP VALUES (
	7369,
	'SMITH',
	'CLERK',
	7902,
	TO_DATE('17-12-1980', 'dd-mm-yyyy'),
	800,
	NULL,
	20
);

INSERT INTO EMP VALUES (
	7499,
	'ALLEN',
	'SALESMAN',
	7698,
	TO_DATE('20-2-1981', 'dd-mm-yyyy'),
	1600,
	300,
	30
);

INSERT INTO EMP VALUES (
	7521,
	'WARD',
	'SALESMAN',
	7698,
	TO_DATE('22-2-1981', 'dd-mm-yyyy'),
	1250,
	500,
	30
);

INSERT INTO EMP VALUES (
	7566,
	'JONES',
	'MANAGER',
	7839,
	TO_DATE('2-4-1981', 'dd-mm-yyyy'),
	2975,
	NULL,
	20
);

INSERT INTO EMP VALUES (
	7654,
	'MARTIN',
	'SALESMAN',
	7698,
	TO_DATE('28-9-1981', 'dd-mm-yyyy'),
	1250,
	1400,
	30
);

INSERT INTO EMP VALUES (
	7698,
	'BLAKE',
	'MANAGER',
	7839,
	TO_DATE('1-5-1981', 'dd-mm-yyyy'),
	2850,
	NULL,
	30
);

INSERT INTO EMP VALUES (
	7782,
	'CLARK',
	'MANAGER',
	7839,
	TO_DATE('9-6-1981', 'dd-mm-yyyy'),
	2450,
	NULL,
	10
);

INSERT INTO EMP VALUES (
	7788,
	'SCOTT',
	'ANALYST',
	7566,
	TO_DATE('13-7-1987', 'dd-mm-yyyy')-85,
	3000,
	NULL,
	20
);

INSERT INTO EMP VALUES (
	7839,
	'KING',
	'PRESIDENT',
	NULL,
	TO_DATE('17-11-1981', 'dd-mm-yyyy'),
	5000,
	NULL,
	10
);

INSERT INTO EMP VALUES (
	7844,
	'TURNER',
	'SALESMAN',
	7698,
	TO_DATE('8-9-1981', 'dd-mm-yyyy'),
	1500,
	0,
	30
);

INSERT INTO EMP VALUES (
	7876,
	'ADAMS',
	'CLERK',
	7788,
	TO_DATE('13-7-1987', 'dd-mm-yyyy')-51,
	1100,
	NULL,
	20
);

INSERT INTO EMP VALUES (
	7900,
	'JAMES',
	'CLERK',
	7698,
	TO_DATE('3-12-1981', 'dd-mm-yyyy'),
	950,
	NULL,
	30
);

INSERT INTO EMP VALUES (
	7902,
	'FORD',
	'ANALYST',
	7566,
	TO_DATE('3-12-1981', 'dd-mm-yyyy'),
	3000,
	NULL,
	20
);

INSERT INTO EMP VALUES (
	7934,
	'MILLER',
	'CLERK',
	7782,
	TO_DATE('23-1-1982', 'dd-mm-yyyy'),
	1300,
	NULL,
	10
);




DROP TABLE BONUS;

CREATE TABLE BONUS (
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	SAL NUMBER,
	COMM NUMBER
);



DROP TABLE SALGRADE;

CREATE TABLE SALGRADE (
	GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER
);

INSERT INTO SALGRADE VALUES (
	1,
	700,
	1200
);

INSERT INTO SALGRADE VALUES (
	2,
	1201,
	1400
);

INSERT INTO SALGRADE VALUES (
	3,
	1401,
	2000
);

INSERT INTO SALGRADE VALUES (
	4,
	2001,
	3000
);

INSERT INTO SALGRADE VALUES (
	5,
	3001,
	9999
);

COMMIT;

SET TERMOUT ON

SET ECHO ON


-- SELECT문 : 원하는 레코드(행)만 가져온느 명령어
-- FROM 테이블명 : 데이터 장소
SELECT *
FROM EMP a;

SELECT ename
, upper(ename) AS to_upper_name
, lower(ename) AS to_lower_name
FROM EMP e ;


SELECT '['||TRIM(' _Oracle_ ') ||']' AS TRIM,
'['|| LTRIM('<_Oracle_>','_<') ||']' AS LTRIM_2
FROM dual;


-- CONCAT : 문자열 연결
SELECT empno
	, ename
	, concat(empno, ename)
	, concat(empno, ' ')
FROM EMP e WHERE ENAME = UPPER('smith');


SELECT '010-1234-5678' AS mobile_phone
	,replace('010-1234-5678','-',' ') AS REPLACE
FROM dual;



SELECT lpad('ORA_1234_XE', 20) AS lpad_20	-- 왼쪽부터 부족한거 채움	
, rpad('WE_NEED_20DIGITS', 20) AS rpad_20			-- 오른쪽부터 부족한거 채움
FROM dual;

SELECT rpad('971225-', 14, '*') AS rpad_jmno
, rpad('010-1234-', 13, '*') AS rpad_phone
FROM dual;


SELECT ADD_MONTHS(sysdate, :month)
FROM dual;


SELECT EMPNO, ENAME, hiredate,
	ADD_MONTHS(hiredate, 12 * 20) AS work20year
	FROM emp;
	

SELECT ENAME, HIREDATE, SYSDATE 
	, MONTHS_BETWEEN(HIREDATE, SYSDATE)/12 AS YEAR1
	, MONTHS_BETWEEN(SYSDATE, HIREDATE)/12 AS YEAR2
	, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)/12) AS YEAR3 
FROM EMP e ;


SELECT EMPNO
FROM EMP e 
WHERE DEPTNO = 20;

-- 24시간 표시
SELECT to_char(SYSDATE, 'YYYY/MM/DD HH24')
FROM dual;

-- 시분초까지 표시
SELECT TO_CHAR(sysdate, 'DD HH24:MI:SS')
FROM dual;

SELECT SYSDATE 
, TO_CHAR(SYSDATE, 'MM') AS MM 
, TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KOR
FROM DUAL;

SELECT SYSDATE
, TO_CHAR(SYSDATE, 'HH24:MI:SS') AS TM
FROM DUAL;

SELECT TO_NUMBER('1,000,000', '999,999,999') AS CURRENCY
FROM DUAL;

SELECT TO_DATE('2023/03/20', 'YYYY-MM-DD') AS YMD
FROM DUAL;

SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR_49
, TO_DATE('49/12/10', 'RR/MM/DD') AS RR_YEAR_49
, TO_DATE('50/12/10', 'YY/MM/DD') AS YY_YEAR_50
, TO_DATE('50/12/10', 'RR/MM/DD') AS RR_YEAR_50
, TO_DATE('51/12/10', 'YY/MM/DD') AS YY_YEAR_51
, TO_DATE('51/12/10', 'RR/MM/DD') AS RR_YEAR_51
FROM DUAL;



-- NVL(입력값, NULL인 경우 대체할 값) --> 매우 중요
SELECT EMPNO
, SAL * 12 + NVL(COMM, 0) AS SALL12
, JOB
, TO_CHAR(HIREDATE, 'YYYY-MM-DD') AS YMD
FROM EMP e
ORDER BY SALL12 DESC;

--DECODE (입력 컬럼값,
--		'값1', '처리1'
--		'값2', '처리2'
--		'값n', '처리n') AS 별칭
		
--CASE 칼럼
--	WHEN '값1' THEN 처리1
--	WHEN '값2' THEN 처리2
--	ELSE
--	END AS 별칭

