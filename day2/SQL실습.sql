-- ������� ��ȸ�ϴ� ������
SELECT * FROM emp
 WHERE sal = 5000;
 
SELECT * FROM emp
 WHERE job = 'CLERK';
 
-- null���� �˻� is null
SELECT * FROM emp
 WHERE comm = 0 or comm is NULL;
 
-- ���ʽ��� NULL�̰� ������ ANALYST�� ����� ������
SELECT * FROM emp
 WHERE comm is NULL AND job = 'ANALYST';

-- ���ϴ� column�� ������ ���(��������)
SELECT empno, ename, deptno
 FROM emp
 WHERE deptno = 30;

-- join, �ΰ��̻��� ���̺��� �ϳ��� ���̺�ó�� ��ȸ�ϴ� ���
-- foriegn key�� primary key�� �� �� �ִ�.
SELECT * FROM emp
 JOIN dept
  ON emp.deptno = dept.deptno;

-- distinct ����(�ߺ��׸��� �����ϰ� ������)
SELECT job FROM emp;
SELECT DISTINCT job FROM emp;

-- ��Ī ALIAS(��Ģ����, ���̺� ��, AS�� �����ǳ� ǥ���� �ƴ�)
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
-- ��������(ASC)���� ����, ��������(DESC)
 ORDER BY ename DESC;

-- ���̺� ���� ��Ī AS�� ���� �ʴ´�.
SELECT e.empno, e.ename, e.hiredate, e.sal, d.deptno, d.dname FROM emp e
-- deptno�� dept ���̺� �ִ� ������ �������°� ����.(primary key)
 JOIN dept d
  ON e.deptno = d.deptno;

-- WHERE
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE sal*12 >= 20000; --sal*12 ��� annual ���� ������

SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE sal <> 1000; -- <>, != ���̾���, ^= ���ǾȾ�

SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE NOT sal = 1000;

-- IN(���󵵰� ���� �ʴ�.)
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
 WHERE ename LIKE '%E%'; -- %�� ��ġ�� ���� ����� �ٸ�(J%, %ER)

SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 WHERE ename LIKE '__RD'; -- '_'�ϳ��� ���ڼ� 1��

-- null, �Լ��� NVL()
SELECT ename, job, sal, comm
 FROM emp
 WHERE COMM IS NULL; --<> IS NOT NULL

-- UNION(���̺��� ������ ��ġ�� ����, column�� ������ �¾ƾ���)
-- ���谡 ���� �����Ͷ�, Ÿ�Ը� ������ ������ ������
-- UNION ALL -> �ߺ��� �����ʹ� ���� ����
SELECT empno , ename, job FROM emp -- ���� ���̺�
 WHERE comm IS NOT NULL
UNION
SELECT deptno, dname, loc FROM dept;