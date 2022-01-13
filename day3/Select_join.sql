-- �⺻ INNER JOIN
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') hiredate
     , e.deptno
     , d.dname
  FROM emp e
 INNER JOIN dept d
    ON e.deptno = d.deptno
-- ���� ������� ���� ���� select�ϰ� �� �� ���������� ������� ������ ����
 WHERE e.job = 'SALESMAN';

-- PL/SQL INNER JOIIN ���(ORACLE, MYSQL�� ��)
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
-- LEFT�� RIGHT�� ���̺� ���̸� ���غ���
-- INNER JOIN�� �ٸ��� ��ġ���� �ʴ� ���� NULL�� ǥ�õ�

-- PL/SQL ������ LEFT OUTER, LIGHT OUTER
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') hiredate
     , e.deptno
     , d.dname
  FROM emp e, dept d
 WHERE e.deptno = d.deptno (+); -- LEFT OUTER
-- WHERE e.deptno (+) = d.deptno; RIGHT OUTER

-- ������ ���̺� JOIN
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

-- �������� ���(ȥ���غ���)
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