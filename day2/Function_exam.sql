-- ���ڿ� �Լ�
-- �빮��
SELECT * FROM EMP
 WHERE job = UPPER('analyst');
-- upper('analyst')�� ������� ��������� dual�� ���
SELECT UPPER('analyst') FROM dual;

--�ҹ���, ù���ڸ� �빮��
SELECT LOWER(ename) ename, INITCAP(job) job FROM emp
 where comm is not null;

-- LENGH ����
SELECT ename, LENGTH(ename) ���ڼ�, job, LENGTH(job) ����Ʈ��
 FROM emp;

-- SUBSTRING ���ڸ� �߶� ����
SELECT SUBSTR('�ȳ��ϼ���, �Ѱ���IT�����п� �����͹��Դϴ�.',18,5) phase FROM dual;

-- REPLACE ���ڴ�ü
SELECT REPLACE('�ȳ��ϼ���, �Ѱ��� IT�����п� �����͹��Դϴ�.','�ȳ��ϼ���','����������') phase 
 FROM dual;

-- CONCAT �� ������ ����
SELECT 'A' || 'B' FROM dual;
SELECT CONCAT('A','B') FROM dual;

-- TRIM, LTRIM, RTRIM Ư�� ���������
SELECT '     �ȳ��ϼ���.     ' FROM dual;
SELECT LTRIM('     �ȳ��ϼ���.     ') FROM dual;
SELECT RTRIM('     �ȳ��ϼ���.     ') FROM dual;
SELECT TRIM('     �ȳ��ϼ���.     ') RES FROM dual;

SELECT ROUND(15.193,1) FROM dual;

-- SYSDATE
SELECT SYSDATE FROM dual;

-- TO_CHAR
SELECT ename, hiredate, TO_CHAR(hiredate,'yyyy-mm-dd'), 
 TO_CHAR(sal) || '$' FROM emp;
 
-- TO_NUMBER
SELECT TO_NUMBER('��õ���') FROM dual;

-- TO_DATE
SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22','mm/dd/yy') FROM dual;

-- NULL ó���Լ�(NVL, NVL2)
SELECT ename, job, sal, NVL(comm,0) comm, sal*12 annsal,
(sal*12) + NVL(comm,0) AS annsalC
 FROM emp
-- ��������(ASC)���� ����, ��������(DESC)
 ORDER BY ename DESC;

-- �����Լ�(SUM, COUNTI, MIN, MAX, AVG)
SELECT sal, NVL(comm,0) comm FROM emp;
SELECT sum(sal) totalsalary FROM emp;
SELECT sum(comm) totalcommision FROM emp;
SELECT max(sal) sal FROM emp;
SELECT MIN(sal) sal FROM emp;
SELECT ROUND(AVG(sal)) sal FROM emp;

-- GROUP BY ������� ���ϴ� ���� ���� ���
SELECT MAX(sal), job
 FROM emp
 GROUP BY job;

SELECT MAX(sal) �����ִ�, SUM(sal) ��������޿��հ�, job, deptno
 FROM emp
  GROUP BY job,deptno;
-- SELECT������ �Լ��� ������ ����ϴ°� ���������, ���� ������ GROUP���� ������Ѵ�.
-- ���⼭�� job, deptno �ΰ��� ���� ������
-- ���� ������ ���ϴ� ����� ������ ���� �ƴϴ�.

-- HAVING
SELECT MAX(sal) �����ִ�, SUM(sal) ��������޿��հ�, job
 FROM emp
  GROUP BY job
  HAVING MAX(sal) > 4000; -- WHERE������ �����Լ��� ��������.

SELECT deptno, job, AVG(sal), SUM(sal), count(*)
 FROM emp
 GROUP BY deptno, job
  HAVING AVG(sal) >= 1000 -- HAVING���� GROUP BY�� ������
 ORDER BY deptno, job; -- ���������� �⺻��

-- ROLLUP
SELECT NVL(TO_CHAR(deptno),'���հ�') �μ���ȣ, NVL(job,'�հ�') JOB
, ROUND(AVG(sal)) �޿����, SUM(sal) �޿��հ�
, MAX(sal) �޿��ִ�, COUNT(*) ������
 FROM emp
 GROUP BY ROLLUP(deptno, job);
-- HAVING AVG(sal) >= 1000 -- HAVING���� GROUP BY�� ������