-- 문자열 함수
-- 대문자
SELECT * FROM EMP
 WHERE job = UPPER('analyst');
-- upper('analyst')의 결과값이 보고싶을때 dual을 사용
SELECT UPPER('analyst') FROM dual;

--소문자, 첫글자만 대문자
SELECT LOWER(ename) ename, INITCAP(job) job FROM emp
 where comm is not null;

-- LENGH 길이
SELECT ename, LENGTH(ename) 글자수, job, LENGTH(job) 바이트수
 FROM emp;

-- SUBSTRING 글자를 잘라서 리턴
SELECT SUBSTR('안녕하세요, 한가람IT전문학원 빅데이터반입니다.',18,5) phase FROM dual;

-- REPLACE 글자대체
SELECT REPLACE('안녕하세요, 한가람 IT전문학원 빅데이터반입니다.','안녕하세요','저리가세요') phase 
 FROM dual;

-- CONCAT 두 문자의 병합
SELECT 'A' || 'B' FROM dual;
SELECT CONCAT('A','B') FROM dual;

-- TRIM, LTRIM, RTRIM 특정 문자지우기
SELECT '     안녕하세요.     ' FROM dual;
SELECT LTRIM('     안녕하세요.     ') FROM dual;
SELECT RTRIM('     안녕하세요.     ') FROM dual;
SELECT TRIM('     안녕하세요.     ') RES FROM dual;

SELECT ROUND(15.193,1) FROM dual;

-- SYSDATE
SELECT SYSDATE FROM dual;

-- TO_CHAR
SELECT ename, hiredate, TO_CHAR(hiredate,'yyyy-mm-dd'), 
 TO_CHAR(sal) || '$' FROM emp;
 
-- TO_NUMBER
SELECT TO_NUMBER('이천사백') FROM dual;

-- TO_DATE
SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22','mm/dd/yy') FROM dual;

-- NULL 처리함수(NVL, NVL2)
SELECT ename, job, sal, NVL(comm,0) comm, sal*12 annsal,
(sal*12) + NVL(comm,0) AS annsalC
 FROM emp
-- 오름차순(ASC)으로 정렬, 내림차순(DESC)
 ORDER BY ename DESC;

-- 집계함수(SUM, COUNTI, MIN, MAX, AVG)
SELECT sal, NVL(comm,0) comm FROM emp;
SELECT sum(sal) totalsalary FROM emp;
SELECT sum(comm) totalcommision FROM emp;
SELECT max(sal) sal FROM emp;
SELECT MIN(sal) sal FROM emp;
SELECT ROUND(AVG(sal)) sal FROM emp;

-- GROUP BY 결과값을 원하는 열로 묶어 출력
SELECT MAX(sal), job
 FROM emp
 GROUP BY job;

SELECT MAX(sal) 월급최대, SUM(sal) 직업군당급여합계, job, deptno
 FROM emp
  GROUP BY job,deptno;
-- SELECT절에서 함수를 여러개 사용하는건 상관없지만, 열의 갯수는 GROUP절과 맞춰야한다.
-- 여기서는 job, deptno 두개의 열을 맞춰줌
-- 지금 쿼리는 원하는 결과에 도출한 것은 아니다.

-- HAVING
SELECT MAX(sal) 월급최대, SUM(sal) 직업군당급여합계, job
 FROM emp
  GROUP BY job
  HAVING MAX(sal) > 4000; -- WHERE절에는 집계함수를 쓸수없다.

SELECT deptno, job, AVG(sal), SUM(sal), count(*)
 FROM emp
 GROUP BY deptno, job
  HAVING AVG(sal) >= 1000 -- HAVING절은 GROUP BY절 밑으로
 ORDER BY deptno, job; -- 오름차순이 기본값

-- ROLLUP
SELECT NVL(TO_CHAR(deptno),'총합계') 부서번호, NVL(job,'합계') JOB
, ROUND(AVG(sal)) 급여평균, SUM(sal) 급여합계
, MAX(sal) 급여최대, COUNT(*) 직원수
 FROM emp
 GROUP BY ROLLUP(deptno, job);
-- HAVING AVG(sal) >= 1000 -- HAVING절은 GROUP BY절 밑으로