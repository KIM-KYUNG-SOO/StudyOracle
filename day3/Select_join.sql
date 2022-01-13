-- 기본 INNER JOIN
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') hiredate
     , e.deptno
     , d.dname
  FROM emp e
 INNER JOIN dept d
    ON e.deptno = d.deptno
-- 먼저 보고싶은 열을 먼저 select하고 난 후 지워나가는 방식으로 쿼리를 구성
 WHERE e.job = 'SALESMAN';

-- PL/SQL INNER JOIIN 방식(ORACLE, MYSQL도 됨)
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') hiredate
     , e.deptno
     , d.dname
  FROM emp e, dept d
 -- WHERE 1 = 1 -- TIP
 WHERE e.deptno = d.deptno
   AND e.job = 'SALESMAN';

-- LEFT OUTER JOIN
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') hiredate
     , e.deptno
     , d.dname
  FROM emp e
  LEFT OUTER JOIN dept d
    ON e.deptno = d.deptno;
    
-- RIGHT OUTER JOIN
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') hiredate
     , e.deptno
     , d.dname
  FROM emp e
 RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno;
-- LEFT와 RIGHT의 테이블 차이를 비교해보자
-- INNER JOIN과 다르게 일치하지 않는 값은 NULL로 표시됨

-- PL/SQL 형식의 LEFT OUTER, LIGHT OUTER
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') hiredate
     , e.deptno
     , d.dname
  FROM emp e, dept d
 WHERE e.deptno = d.deptno (+); -- LEFT OUTER
-- WHERE e.deptno (+) = d.deptno; RIGHT OUTER

-- 세개의 테이블 JOIN
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') hiredate
     , e.deptno
     , d.dname
     , b.comm
  FROM emp e, dept d, bonus b
 WHERE e.deptno (+) = d.deptno
   AND e.ename = b.ename (+);

-- 여러절의 사용(혼자해본거)
SELECT e.ename
     , e.job
     , e.sal
     , sum(e.sal) sum
     , avg(e.sal) avg
     , NVL(e.comm, 0) comm
     , d.deptno
     , d.dname
  FROM emp e, dept d
 WHERE e.deptno = d.deptno
 GROUP BY e.ename
        , e.job
        , e.sal
        , e.comm
        , d.deptno
        , d.dname
HAVING SUM(e.sal) > 1300
 ORDER BY e.ename DESC;