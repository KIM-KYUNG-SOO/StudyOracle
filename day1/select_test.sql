-- 주석, 아래의 select 구문을 실행
select*from emp;
-- ;은 한문장이 끝날떄 사용, DB에서는 입력안해도 된다.
-- *은 all이란 뜻이다.
desc emp;
-- colum을 보여줌
-- colum을 구분해서 select
select ename, job, hiredate from emp;

-- 부서명만 출력(중복값 제외 : distinct)
select distinct deptno
 from emp;
-- 이 경우는 중복제거가 안됨, 열 전체에서 중복값이 없음
select distinct empno, deptno
 from emp;

select distinct job, deptno
 from emp;
 -- 조건절 where
select*from emp
  where empno = 7499;
select*from emp
  where ename = '홍길동';
select*from emp
  where job = 'CLERK';
-- 급여가 1500 이상인 사람 조회
select*from emp
  where sal >= 1500;