CREATE TABLE DEPT_TEMP
	AS(SELECT * FROM DEPT)
;

SELECT *
FROM DEPT_TEMP DT
;


-- INSERT 데이터를 입력하는 방식
-- INSERT INTO 테이블명(컬럼명1, 컬럴명2, ...)
-- 	VALUES (데이터1, 데이터2, ...)
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
	VALUES (50, 'DATABASE', 'SEOUL')
;

SELECT *
FROM DEPT_TEMP DT
;

ROLLBACK;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
	VALUES(70, 'WEB', NULL)
;

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
	VALUES(80, 'MOBILE','')
;

INSERT INTO DEPT_TEMP(DEPTNO, LOC)
	VALUES(90, 'INCHEON')
;



-- 컬러값만 복사해서 새로운 테이블 생성
-- WHERE 조건절에 1<>1
CREATE TABLE EMP_TEMP AS
	SELECT * FROM EMP
			WHERE 1 <> 1
;

SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 VALUES(9999, '홍길동', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10)
;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 VALUES(2111, '이순신', 'MANAGER', 9999, TO_DATE('07/01/1999', 'DD/MM/YYYY'), 4000, NULL, 20)
;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 VALUES(3111, '심청이', 'MANAGER', 9999, SYSDATE, 4000, NULL, 10)
;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	SELECT E.EMPNO
		, E.ENAME
		, E.JOB
		, E.MGR
		, E.HIREDATE
		, E.SAL 
		, E.COMM 
		, E.DEPTNO 
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL
			AND S.HISAL
			AND S.GRADE = 1
;


-- UPDATE : 필터된 데이터에 대해서 레코드 값을 수정
CREATE TABLE DEPT_TEMP2
	AS (SELECT * FROM DEPT)
;

SELECT *
	FROM DEPT_TEMP2
;

-- UPDATE
-- 	SET
-- WHERE가 반드시 필요
UPDATE DEPT_TEMP2 
	SET LOC = 'SEOUL'
;

ROLLBACK;


UPDATE DEPT_TEMP2 
	SET DNAME = 'DATABASE'
		, LOC = 'SEOUL'
WHERE DEPTNO = 40
;

-- 서브쿼리를 사용하여 UPDATE 
UPDATE DEPT_TEMP2
SET (DNAME, LOC) = (SELECT DNAME, LOC
					FROM DEPT
					WHERE DEPTNO = 40)
WHERE DEPTNO = 40
;

ROLLBACK;
COMMIT; -- 원복 불가 --


-- DELETE 구문으로 테이블에서 값을 제거
-- 대부분의 경우(또는 반드시) WHERE 조건이 필요
-- 보통의 경우, DELETE보다는 UPDATE 구문으로 상태 값을 변경
-- 예시 : 근무/휴직/퇴사 등의 유형으로 값을 변경
CREATE TABLE EMP_TEMP2
		AS (SELECT * FROM EMP)
;

SELECT * FROM EMP_TEMP2;

DELETE FROM EMP_TEMP2 
WHERE JOB = 'MANAGER'
;

ROLLBACK;
COMMIT;

-- WHERE 조건을 좀 더 복잡하게 주고
-- DELETE 실행
DELETE FROM EMP_TEMP2 
	WHERE EMPNO IN (SELECT e.empno
						FROM emp_temp2 e, SALGRADE s
						WHERE e.sal BETWEEN s.LOSAL AND s.HISAL
						AND s.GRADE = 3
						AND DEPTNO =30)
;


-- CREATE문을 정의 : 기존에 없는 테이블 구조를 생성
-- 데이터는 없고, 테이블의 컬럼과 데이터 타입, 제약 조건 등의 구조를 생성
CREATE TABLE emp_new
(
	empno 		number(4)
	, ename		varchar(10)
	, job		varchar(9)
	, mgr		number(4)
	, hiredate	DATE
	, SALGRADE  number(7,2)
	, deptno    number(2)
)
;

SELECT * FROM emp
WHERE rownum <= 5
;

SELECT *
FROM EMP_new e
;

ALTER table emp_new
ADD hp varchar(20)
;

ALTER TABLE EMP_NEW 
RENAME COLUMN hp TO TEL_NO	-- 잘못된 컬럼명 HP를 수정
;

ALTER TABLE EMP_NEW
	MODIFY EMPNO NUMBER(5)
;

ALTER TABLE EMP_NEW
	DROP COLUMN TEL_NO
;

-- SEQUENCE 일련번호를 생성하여 테이블 관리를 편리하게 하고자 함
CREATE SEQUENCE SEQ_DEPTNO
			INCREMENT BY 1
			START WITH 1
			MAXVALUE 999
			MINVALUE 1
			NOCYCLE NOCACHE
;


SELECT * FROM DEPT_TEMP2;

INSERT INTO DEPT_TEMP2(DEPTNO, DNAME, LOC)
	VALUES (SEQ_DEPTNO.NEXTVAL, 'DATABASE', 'SEOUL')
;

INSERT INTO DEPT_TEMP2(DEPTNO, DNAME, LOC)
	VALUES (SEQ_DEPTNO.NEXTVAL, 'WEB', 'BUSAN')
;
	
INSERT INTO DEPT_TEMP2(DEPTNO, DNAME, LOC)
	VALUES (SEQ_DEPTNO.NEXTVAL, 'MOBILE', 'SUNGSOO')
;


-- 제약조건(CONSTRAINT) 지정
-- 테이블을 생성할 때, 테이블 컬럼별 제약조건을 설정
-- 자주 사용되는 제약조건
-- Not Null
-- Unique
-- PK
-- FK
CREATE TABLE LOGIN
(
	LOG_ID 		VARCHAR2(20) NOT NULL
	, LOG_PWD 	VARCHAR2(20) NOT NULL
	, TEL 		VARCHAR2(20)
)
;

INSERT INTO LOGIN(LOG_ID, LOG_PWD)
	VALUES ('TEST01', '1234')
;

SELECT * FROM LOGIN;

-- TEL 없는 고객이 발견되어, 수소문 끝에 어렵게 전화번호를 구함
UPDATE LOGIN
	SET TEL = '010-1234-5678'
	WHERE LOG_ID = 'TEST01'
;

-- TEL 컬럼의 중요성을 나중에 인지하고, Not Null 제약조건을 설정
ALTER TABLE LOGIN
 MODIFY TEL NOT NULL
 ;
 
-- 오라클 DBMS가 상ㅇ자를 위해 만들어 놓은 제약조건 설정값 테이블
SELECT OWNER
	, CONSTRAINT_NAME
	, CONSTRAINT_TYPE
	, TABLE_NAME
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'LOGIN'
;


ALTER TABLE LOGIN
	MODIFY (TEL CONSTRAINT TEL_NN NOT NULL)
;

ALTER TABLE APEX_LOGIN 
	DROP CONSTRAINT SYS_C007040
;

CREATE TABLE LOG_UNIQUE
(
	LOG_ID 		VARCHAR2(20) UNIQUE
	, LOG_PWD 	VARCHAR2(20) NOT NULL
	, TEL 		VARCHAR2(20)
);
	

SELECT *
	FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'LOG_UNIQUE';

INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
	VALUES ('TEST01', 'PWD0123', '010-0000-0000')
;

INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
	VALUES ('TEST02', 'PWD0456', '010-1111-2222')
;
INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
	VALUES ('TEST03', 'PWD0789', '010-3333-4444')
;

INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
	VALUES (NULL, 'PWD4321', '010-5555-6666')
;

SELECT *
FROM LOG_UNIQUE;

UPDATE LOG_UNIQUE
	SET LOG_ID = 'TEST_ID_NEW'
	WHERE LOG_ID IS NULL 
	;
	
ALTER TABLE LOG_UNIQUE
	MODIFY(TEL UNIQUE)
;

CREATE TABLE LOG_PK
(
	LOG_ID		VARCHAR2(20) PRIMARY KEY
	, LOG_PWD	VARCHAR2(20) NOT NULL
	, TEL 		VARCHAR2(20)
);

INSERT INTO LOG_PK(LOG_ID, LOG_PWD, TEL)
	VALUES('PK_ID_01','PWD01','010-1234-5678')
;

-- ID가 동일하여 PK 제약조건 위반
INSERT INTO LOG_PK(LOG_ID, LOG_PWD, TEL)
	VALUES('PK_ID_01','PWD02','010-2345-6789')
;

-- NULL은 제약조건 위반
INSERT INTO LOG_PK(LOG_ID, LOG_PWD, TEL)
	VALUES(NULL,'PWD02','010-2345-6789')
;

SELECT *
	FROM EMP_TEMP
;

-- 존재하지 않는 부서번호를 EMP_TEMP 테이블에 입력을 시도
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (3333, 'GHOST', 'SURPRISE', 9999, SYSDATE, 1200, NULL, 99)
;

-- INDEX 빠른 검색을 위한 색인
-- 장점 : 순식간에 원하는 값을 찾아준다.
-- 단점 : 입력과 출력이 잦은 경우, 인덱스가 설정된 테이블의 속도가 저하된다.
CREATE INDEX IDX_EMP_JOB
	ON EMP(JOB)
;

SELECT *
	FROM CTXSYS.CTX_USER_INDEXES
	WHERE TABLE_NAME IN ('EMP','DEPT')
;

-- VIEW : 테이블을 편리하게 사용하기 위한 목적으로 생성하는 가상 테이블
CREATE VIEW VW_EMP
 AS (SELECT EMPNO, ENAME,JOB, DEPTNO
 		FROM EMP e 
 		WHERE DEPTNO = 10)
 ;
 
SELECT *
 	FROM USER_VIEWS 
 	WHERE VIEW_NAME = 'VW_EMP'
 ;
 
-- ROWNUM 사용 : 상위 N개를 출력하기 위해 사용하며
-- 컬럼에 ROWNUM 순번을 입력하여 사용할 수 있다.

-- SAL DESC와 무관하게 EMP 테이블의 순서대로
SELECT ROWNUM
	, E.*
FROM EMP E
ORDER BY SAL DESC 
;

-- SAL DESC 순서에 따라 ROWNUM 출력
SELECT ROWNUM, A.*
FROM (SELECT *
	FROM EMP
	ORDER BY SAL DESC) A
;


SELECT ROWNUM, A.*
FROM (SELECT *
	FROM EMP
	ORDER BY SAL DESC) A
WHERE ROWNUM <= 5
;


SELECT *
	FROM DICT
	WHERE TABLE_NAME LIKE 'USER_CON%' --와일드 카드
;