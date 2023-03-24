#   프로젝트 이름 : MUZE 인력관리시스템

## 5조는 SQL을 활용해 KB국민은행의 차세대 인력관리시스템인 MUZE를 설계하였습니다.
기업의 요구사항은 다음과 같습니다.
 - 전년도 개편한 KB 연수 시스템의 데이터를 활용하여 차세대 인력관리시스템 구축 요구
 - 신입행원 이탈률 증가 추세에 따라 직무 적합도에 따른 CDP 관리 필요성 증대
 - 개편된 조직 구조에 따른 직무별 POOL 관리


### 프로젝트 구조
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/UML.jpg?raw=true" >

​
### DB 구조

-- KB_EMP(인사정보)
CREATE TABLE KB_EMP(
	 EMPNO		VARCHAR2(10)  PRIMARY KEY
	,ENAME		VARCHAR2(10)	NOT NULL
	,BIRTH		DATE		 	    NOT NULL
	,GENDER		VARCHAR2(2)	  NOT NULL
	,CONTACT	VARCHAR2(20)	NOT NULL
	,ADDRESS	VARCHAR2(30)	NOT NULL
	,EMAIL		VARCHAR2(20)	
	,HIREDATE	DATE		    	NOT NULL
	,TITLE		VARCHAR2(10)	NOT NULL
	,MAJOR		VARCHAR2(20)
);

-- EMP_POOL(직원별 직무 점수 정보)
CREATE TABLE EMP_POOL(
	 EMPNO	VARCHAR2(10)
	,JOBNO	VARCHAR2(3)
	,SCORE	NUMBER(5,0) DEFAULT 0
	,CONSTRAINT EMP_POOL_PK PRIMARY KEY(EMPNO, JOBNO)
);

-- EMP_WORK(근무이력)
CREATE TABLE EMP_WORK(
	 EMPNO			VARCHAR2(10)
	,SEQ			NUMBER(3,0)
	,WORK_STARTDATE	DATE			NOT NULL
	,WORK_ENDDATE	DATE			  NOT NULL
	,DEPTNAME		VARCHAR2(50)	NOT NULL
	,JOBNO			VARCHAR2(10)
	,CONSTRAINT EMP_WORK_PK PRIMARY KEY(EMPNO, SEQ)
);

-- EMP_STUDY(연수이력)
CREATE TABLE EMP_STUDY(
	 EMPNO		VARCHAR2(10)
	,STUDYNO	NUMBER(5,0)
	,STUDYNAME	VARCHAR2(50)	NOT NULL
	,STUDYCODE	VARCHAR2(10)	NOT NULL
	,SCORE		NUMBER(3,0)		  NOT NULL
	,JOBNO		VARCHAR2(3)		  NOT NULL
	,CONSTRAINT EMP_STUDY_PK  PRIMARY KEY(EMPNO, STUDYNO)
);

-- EMP_CERTIFICATE(자격증이력)
CREATE TABLE EMP_CERTIFICATE(
	 EMPNO			VARCHAR2(10)
	,CERTNO			VARCHAR2(20)
	,CERTNAME		VARCHAR2(100)	NOT NULL
	,CERTGETDATE	DATE		  	NOT NULL
	,GRADE			VARCHAR2(10)	NOT NULL
	,JOBNO			VARCHAR2(3)		NOT NULL
	,CONSTRAINT EMP_CERTIFICATE_PK PRIMARY KEY(EMPNO, CERTNO)
);
​
# 적용 기술 및 개발자 정보
​
## 기술 스택
  ### Back-end
    - DBeaver

​
## 개발 인원 및 일자
- 개발 인원 : 4명 (이성영, 조현손, 김진희, 정인보)
- 개발 일자 : 2023.03.24 ~ 종료시 까지

## 실행결과
- 1. 직원정보조회(기본)
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/%EC%8B%A4%ED%96%89%EA%B2%B0%EA%B3%BC/01.%EC%A7%81%EC%9B%90%EA%B8%B0%EB%B3%B8%EC%A0%95%EB%B3%B4%EC%A1%B0%ED%9A%8C.png?raw=true">

- 2. 직원정보조회2(수정 전)
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/%EC%8B%A4%ED%96%89%EA%B2%B0%EA%B3%BC/02.%EC%A7%81%EC%9B%90%EA%B8%B0%EB%B3%B8%EC%A0%95%EB%B3%B4%EC%A1%B0%ED%9A%8C2.png?raw=true">

- 3. 직원정보조회2(수정 후)
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/%EC%8B%A4%ED%96%89%EA%B2%B0%EA%B3%BC/03.%EC%A7%81%EC%9B%90%EA%B8%B0%EB%B3%B8%EC%A0%95%EB%B3%B4%EC%88%98%EC%A0%95.png?raw=true">

- 4. 직원근무이력
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/%EC%8B%A4%ED%96%89%EA%B2%B0%EA%B3%BC/04.%EC%A7%81%EC%9B%90%EA%B7%BC%EB%AC%B4%EC%9D%B4%EB%A0%A5.png?raw=true">

- 5. 직원연수내역
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/%EC%8B%A4%ED%96%89%EA%B2%B0%EA%B3%BC/05.%EC%A7%81%EC%9B%90%EC%97%B0%EC%88%98%EA%B3%BC%EC%A0%95.png?raw=true">

- 6. 직원자격내역
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/%EC%8B%A4%ED%96%89%EA%B2%B0%EA%B3%BC/06.%EC%A7%81%EC%9B%90%EC%9E%90%EA%B2%A9%EB%82%B4%EC%97%AD.png?raw=true">

- 7. 직원 직무점수 조회
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/%EC%8B%A4%ED%96%89%EA%B2%B0%EA%B3%BC/07.%EC%A7%81%EC%9B%90%EC%A7%81%EB%AC%B4%EC%A0%90%EC%88%98%EC%A1%B0%ED%9A%8C.png?raw=true">

- 8. 직무별 POOL(UB)
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/%EC%8B%A4%ED%96%89%EA%B2%B0%EA%B3%BC/08.%EC%A7%81%EB%AC%B4%EB%B3%84POOL(UB).png?raw=true">

- 9. 직무별 POOL(IT)
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/%EC%8B%A4%ED%96%89%EA%B2%B0%EA%B3%BC/09.%EC%A7%81%EB%AC%B4%EB%B3%84POOL(IT).png?raw=true">

- 10. 직무별 POOL(BIZ)
<img width="800" src="https://github.com/Dungkool/SQL/blob/assignment/MINI%20PROJECT(5%EC%A1%B0)/%EC%8B%A4%ED%96%89%EA%B2%B0%EA%B3%BC/10.%EC%A7%81%EB%AC%B4%EB%B3%84POOL(BIZ).png?raw=true">

# Reference
​
- 이 프로젝트는 5조의 학습목적으로 제작된 차세대 인력관리시스템입니다.
- 학습용으로 만들었기 떄문에 이 코드를 활용하여 이득을 취하거나 무단 배포할 경우 법적으로 심히 문제될 수 있습니다.
- 이 프로젝트에서 사용하고 있는 로고와 배너는 해당 프로젝트 팀 소유이므로 해당 프로젝트 외부인이 사용할 수 없습니다.
​
![Footer](https://capsule-render.vercel.app/api?type=waving&color=ff385c&height=100&section=footer)
