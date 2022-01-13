-- 데이터 입력 INSERT
INSERT INTO bonus
     ( ename, job, sal, comm)
values
     ( 'JACK', 'SALESMAN', 4000, NULL);
-- INSERT, UPADATE, DELETE COMMIT, ROLLBACK을 무조건 해야함
COMMIT;       -- 완전저장
ROLLBACK;     -- 취소

-- TEST 테이블 입력쿼리
INSERT INTO TEST
    (idx, title, descs)
values
    ( 1, '내용증명', NULL);

INSERT INTO TEST
    (idx, title, descs, regdate)
values
    ( 3, '내용증명', '증명합니다', sysdate);
    
INSERT INTO TEST
    (idx, title, descs, regdate)
values
    ( 4, '내용증명4', '증명합니다', TO_DATE('2021-12-31','yyyy-mm-dd'));

-- 시퀀스    
SELECT SEQ_TEST.CURRVAL FROM dual;

INSERT INTO TEST
    (idx, title, descs, regdate)
values
    ( SEQ_TEST.NEXTVAL, '내용증명5', '증명합니다5', sysdate);

INSERT INTO TEST
    (idx, title, descs, regdate)
values
    ( SEQ_TEST.CURRVAL+1, '내용증명7', '증명합니다5', sysdate);

-- UPDATE, DELETE(WHERE절을 꼭 포함해라!!!)
UPDATE TEST
   SET TITLE = '내용증명?'
      ,DESCS = '내용이 변경됩니다.'
 WHERE IDX = 7; --주로 PRIMARY KEY로 조건절을 쓴다.

DELETE FROM TEST
 WHERE idx = 6;
 
-- 서브쿼리
SELECT ROWNUM, S.ename, S.job, S.sal, S.comm 
  FROM(
    SELECT ename, job, sal, comm FROM emp
     ORDER BY sal desc
  )S
 WHERE ROWNUM <= 1;