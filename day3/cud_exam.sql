-- ������ �Է� INSERT
INSERT INTO bonus
     ( ename, job, sal, comm)
values
     ( 'JACK', 'SALESMAN', 4000, NULL);
-- INSERT, UPADATE, DELETE COMMIT, ROLLBACK�� ������ �ؾ���
COMMIT;       -- ��������
ROLLBACK;     -- ���

-- TEST ���̺� �Է�����
INSERT INTO TEST
    (idx, title, descs)
values
    ( 1, '��������', NULL);

INSERT INTO TEST
    (idx, title, descs, regdate)
values
    ( 3, '��������', '�����մϴ�', sysdate);
    
INSERT INTO TEST
    (idx, title, descs, regdate)
values
    ( 4, '��������4', '�����մϴ�', TO_DATE('2021-12-31','yyyy-mm-dd'));

-- ������    
SELECT SEQ_TEST.CURRVAL FROM dual;

INSERT INTO TEST
    (idx, title, descs, regdate)
values
    ( SEQ_TEST.NEXTVAL, '��������5', '�����մϴ�5', sysdate);

INSERT INTO TEST
    (idx, title, descs, regdate)
values
    ( SEQ_TEST.CURRVAL+1, '��������7', '�����մϴ�5', sysdate);

-- UPDATE, DELETE(WHERE���� �� �����ض�!!!)
UPDATE TEST
   SET TITLE = '��������?'
      ,DESCS = '������ ����˴ϴ�.'
 WHERE IDX = 7; --�ַ� PRIMARY KEY�� �������� ����.

DELETE FROM TEST
 WHERE idx = 6;
 
-- ��������
SELECT ROWNUM, S.ename, S.job, S.sal, S.comm 
  FROM(
    SELECT ename, job, sal, comm FROM emp
     ORDER BY sal desc
  )S
 WHERE ROWNUM <= 1;