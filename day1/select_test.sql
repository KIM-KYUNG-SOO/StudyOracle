-- �ּ�, �Ʒ��� select ������ ����
select*from emp;
-- ;�� �ѹ����� ������ ���, DB������ �Է¾��ص� �ȴ�.
-- *�� all�̶� ���̴�.
desc emp;
-- colum�� ������
-- colum�� �����ؼ� select
select ename, job, hiredate from emp;

-- �μ��� ���(�ߺ��� ���� : distinct)
select distinct deptno
 from emp;
-- �� ���� �ߺ����Ű� �ȵ�, �� ��ü���� �ߺ����� ����
select distinct empno, deptno
 from emp;

select distinct job, deptno
 from emp;
 -- ������ where
select*from emp
  where empno = 7499;
select*from emp
  where ename = 'ȫ�浿';
select*from emp
  where job = 'CLERK';
-- �޿��� 1500 �̻��� ��� ��ȸ
select*from emp
  where sal >= 1500;