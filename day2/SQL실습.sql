-- 행단위로 조회하는 셀렉션
SELECT * FROM emp
 WHERE sal = 5000;
 
SELECT * FROM emp
 WHERE job = 'CLERK';
 
-- null값의 검색 is null
SELECT * FROM emp
 WHERE comm = 0 or comm is NULL;
 
-- 보너스가 NULL이고 직업이 ANALYST인 사람만 셀렉션
SELECT * FROM emp
 WHERE comm is NULL AND job = 'ANALYST';

-- 원하는 column만 보려는 경우(프로젝션)
SELECT empno, ename, deptno
 FROM emp
 WHERE deptno = 30;

-- join, 두개이상의 테이블을 하나의 테이블처럼 조회하는 방법
-- foriegn key가 primary key가 될 수 있다.
SELECT * FROM emp
 JOIN dept
  ON emp.deptno = dept.deptno;

-- distinct 복습(중복항목을 제거하고 보여줌)
SELECT job FROM emp;
SELECT DISTINCT job FROM emp;

-- 별칭 ALIAS(사칙연산, 테이블 명, AS는 뺴도되나 표준은 아님)
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
-- 오름차순(ASC)으로 정렬, 내림차순(DESC)
 ORDER BY ename DESC;

-- 테이블 명의 별칭 AS는 쓰지 않는다.
SELECT e.empno, e.ename, e.hiredate, e.sal, d.deptno, d.dname FROM emp e
-- deptno는 dept 테이블에 있는 것으로 가져오는게 좋다.(primary key)
 JOIN dept d
  ON e.deptno = d.deptno;

-- WHERE
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE sal*12 >= 20000; --sal*12 대신 annual 쓰면 오류남

SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE sal <> 1000; -- <>, != 믾이쓰임, ^= 거의안씀

SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE NOT sal = 1000;

-- IN(사용빈도가 높진 않다.)
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE sal IN (1000,1600,5000);

-- BETWEEN A AND B
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE sal >= 1600 AND SAL <= 2975;

SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE sal BETWEEN 1600 AND 2975;

-- LIKE
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE ename LIKE '%E%'; -- %의 위치에 따라 결과가 다름(J%, %ER)

SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE ename LIKE '__RD'; -- '_'하나당 글자수 1자

-- null, 함수명 NVL()
SELECT ename, job, sal, comm
 FROM emp
 WHERE COMM IS NULL; --<> IS NOT NULL

-- UNION(테이블을 밑으로 합치는 행위, column의 갯수가 맞아야함)
-- 관계가 없는 데이터라도, 타입만 맞으면 병합이 가능함
-- UNION ALL -> 중복은 데이터는 빼고 병합
SELECT empno , ename, job FROM emp -- 기준 테이블
 WHERE comm IS NOT NULL
UNION
SELECT deptno, dname, loc FROM dept;