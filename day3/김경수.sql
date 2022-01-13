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
SELECT NAMES 책제목
     , AUTHOR 저자명
     , RELEASEDATE 출판일
     , PRICE 가격
  FROM BOOKSTBL
 ORDER BY IDX DESC;

-- 3
SELECT D.NAMES 장르
     , B.NAMES 책제목
     , B.AUTHOR 저자
     , TO_CHAR(B.RELEASEDATE,'yyyy-mm-dd') 출판일
     , B.ISBN 책코드번호
     , TO_CHAR(B.PRICE)||'원' 가격
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
    , '홍길동'
    , 'A'
    , '부산시 동구 초량동'
    , '010-7989-0909'
    , 'HGD09@NAVER.COM'
    , 'HGD7989'
    , 12345
    , NULL
    , NULL);

-- 5
SELECT NVL(D.NAMES,'--합계--') 장르, SUM(B.PRICE) 장르별합계금액
  FROM BOOKSTBL B, DIVTBL D
  WHERE B.DIVISION = D.DIVISION
  GROUP BY ROLLUP(D.NAMES);