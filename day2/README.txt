## 2일차 학습
### WHERE절

```SQL
SELECT ename, job, sal, sal*12 AS annsal
  FROM emp
  WHERE sal*12 >= 20000; --sal*12 대신 annual 쓰면 오류남