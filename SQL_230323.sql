-- EMP 테이블에서 부서번호, 평균 급여, 최고 급여, 최저 급여, 사원 수를 출력
-- 단, 평균 급여 출력 시 소수점을 제외하고 각 부서번호벼롤 출력(그룹화)
SELECT E.DEPTNO
	, ROUND(AVG(E.SAL), 0)
	, MAX(E.SAL)
	, MIN(E.SAL)
	, COUNT(E.ENAME) AS CNT
FROM EMP E
GROUP BY E.DEPTNO
;


-- 같은 직책에 있는 사원이 3명 이상인 경우 직책과 인원수를 출력(JOB으로 그룹화)
SELECT E.JOB
	, COUNT(*)
FROM EMP E
HAVING COUNT(E.JOB) >= 3
GROUP BY E.JOB
;


-- 사원들의 입사년도를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT TO_CHAR(E.HIREDATE, 'YYYY') AS HIRE_YEAR
	, E.DEPTNO
	, COUNT(*) AS CNT
FROM EMP E
GROUP BY TO_CHAR(E.HIREDATE, 'YYYY'), E.DEPTNO
;


-- 추가 수당을 받는 사원 수와 받지 않는 사원 수를 출력
SELECT NVL2(COMM, 'O', 'X') AS EXIST_COMM,
	COUNT(*) AS CNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X')
;


-- 각 부서의 입사 연도별 사원수, 최고급여, 급여합, 평균 급여를 출력하고
-- 각 부서별 소계와 총계를 함께 출력(ROLLUP 함수로 그룹화)
SELECT E.DEPTNO
	, TO_CHAR(E.HIREDATE, 'YYYY') AS HIRE_YEAR
	, COUNT(*) AS CNT
	, MAX(E.SAL) AS MAX_SAL
	, SUM(E.SAL) AS SUM_SAL
	, AVG(E.SAL) AS AVG_SAL
FROM EMP E
GROUP BY ROLLUP (E.DEPTNO, TO_CHAR(E.HIREDATE, 'YYYY'))
;


-- ALLEN과 같은 직책인 직원들의 사원명, 사원정보, 부서정보를 출력
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME
	FROM EMP E, DEPT D
	WHERE E.DEPTNO = D.DEPTNO
	AND JOB = (SELECT JOB
					FROM EMP
					WHERE ENAME = 'ALLEN')
;


-- 전체 사원의 평균 급여보다 높은 급여를 받는 사원정보, 부서정보, 급여 출력
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
	FROM EMP E, DEPT D, SALGRADE S
	WHERE E.DEPTNO = D.DEPTNO
	AND E.SAL BETWEEN S.LOSAL AND S.HISAL
	AND SAL > (SELECT AVG(SAL)
				FROM EMP)
	ORDER BY E.SAL DESC, E.EMPNO
;


-- 부서코드가 10인 부서에 근무하는 사원 중 부서코드 30번 부서에 존재하지 않는 직책을 가진 사원들의 사원 정보를 출력
SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
	FROM EMP E, DEPT D
	WHERE E.DEPTNO = D.DEPTNO
	AND E.DEPTNO = 10
	AND JOB NOT IN (SELECT DISTINCT JOB
						FROM EMP
						WHERE DEPTNO =30)
;


-- 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보를 출력
-- 다중행 함수를 사용한 경우 MAX() 사용
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
	FROM EMP E, SALGRADE S
	WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
	AND SAL > ALL(SELECT SAL
					FROM EMP
					WHERE JOB = 'SALESMAN')
	ORDER BY EMPNO
;


-- 다중행 함수를 사용하지 않고 ALL 키워드를 사용하여 결과를 출력
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
	FROM EMP E, SALGRADE S
	WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
	AND SAL > ALL(SELECT MAX(SAL)
					FROM EMP
					WHERE JOB = 'SALESMAN')
	ORDER BY EMPNO
;