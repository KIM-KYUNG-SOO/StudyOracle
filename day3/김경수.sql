SELECT COUNT(*) FROM divtbl;
SELECT COUNT(*) FROM bookstbl;
SELECT COUNT(*) FROM membertbl;
SELECT COUNT(*) FROM rentaltbl;
-- 1
SELECT LOWER(EMAIL)
     , MOBILE
     , NAMES
     , ADDR
     , LEVELS FROM MEMBERTBL
 ORDER BY NAMES DESC;

-- 2
SELECT NAMES å����
     , AUTHOR ���ڸ�
     , RELEASEDATE ������
     , PRICE ����
  FROM BOOKSTBL
 ORDER BY IDX DESC;

-- 3
SELECT D.NAMES �帣
     , B.NAMES å����
     , B.AUTHOR ����
     , TO_CHAR(B.RELEASEDATE,'yyyy-mm-dd') ������
     , B.ISBN å�ڵ��ȣ
     , TO_CHAR(B.PRICE)||'��' ����
  FROM BOOKSTBL B, DIVTBL D
 WHERE B.DIVISION = D.DIVISION (+)
 ORDER BY B.IDX DESC;

-- 4
INSERT INTO MEMBERTBL
    (IDX
    , NAMES
    , LEVELS
    , ADDR
    , MOBILE
    , EMAIL
    , USERID
    , PASSWORD
    , LASTLOGINDT
    , LOGINIPADDR)
 VALUES
    (SEQ_TEST1.nextval
    , 'ȫ�浿'
    , 'A'
    , '�λ�� ���� �ʷ���'
    , '010-7989-0909'
    , 'HGD09@NAVER.COM'
    , 'HGD7989'
    , 12345
    , NULL
    , NULL);

-- 5
SELECT NVL(D.NAMES,'--�հ�--') �帣, SUM(B.PRICE) �帣���հ�ݾ�
  FROM BOOKSTBL B, DIVTBL D
  WHERE B.DIVISION = D.DIVISION
  GROUP BY ROLLUP(D.NAMES);