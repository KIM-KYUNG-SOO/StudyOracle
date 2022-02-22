-- 4day
/*[문제]
회원정보 중에 구매내역이 있는 회원에 대한
회원아이디, 회원이름, 생일(0000-00-00 형태)을 조회해 주세요.
정렬은 생일을 기준으로 오름차순해 주세요
*/
SELECT mem_id 회원ID,
             mem_name 회원이름,
             TO_CHAR(mem_bir,'yyyy-mm-dd') 생일
   FROM member
 WHERE mem_id IN (SELECT cart_member 
                                FROM cart)
 ORDER BY TO_CHAR(mem_bir,'yyyy-mm-dd') ASC;
 
-- 한개의 테이블 전체 조회
SELECT * FROM member;

-- EXISTS(ORACLE 전용 함수)
SELECT prod_id, 
             prod_name, 
             prod_lgu
   FROM prod
 WHERE EXISTS (SELECT lprod_gu
                              FROM lprod
                            WHERE lprod_gu = prod.prod_lgu
                                 AND lprod_gu = 'P301');
                                 
-- 위와 같은결과 그러나 EXIST에 비해 처리속도가 느리다.
-- prod 전체행을 조회
SELECT prod_id, 
             prod_name, 
             prod_lgu
   FROM prod
 WHERE prod_lgu IN (SELECT lprod_gu
                              FROM lprod
                            WHERE lprod_nm = '피혁잡화');

-- JOIN
-- CROSS JOIN 데이터 형태 조회시에 씀(테스트 단계에서)
-- 모든데이터를 조회하므로 오래걸리는 경향이 있다.(n*m)
-- [일반방식]
SELECT *
   FROM member,cart, prod, lprod, buyer;

-- [별칭붙이는 것이 가능]
SELECT m.mem_id, c.cart_member, p.prod_id 
   FROM member m, cart c, prod p;

-- [국제표준방식]
SELECT *
   FROM member CROSS JOIN cart 
                         CROSS JOIN prod 
                         CROSS JOIN lprod
                         CROSS JOIN buyer;
                         
-- EQ 또는 INNER JOIN
-- 일반적으로 사용되는 JOIN
-- N개의 Table을 JOIN할떄는 최소한 n-1개의 조건식이 필요하다.

/* 상품테이블에서 상품코드, 상품명, 분류명을 조회.
    상품테이블 : prod
    분류테이블 : lprod */
-- [일반방식]
SELECT prod.prod_id 상품코드,
             prod.prod_name 상품명,
             lprod.lprod_nm 분류명
   FROM prod, lprod
 WHERE prod.prod_lgu = lprod.lprod_gu;

-- [국제표준방식]
SELECT prod.prod_id, prod.prod_name, lprod.lprod_nm
   FROM prod INNER JOIN lprod
                                ON(prod.prod_lgu = lprod.lprod_gu);

-- Alias를 사용한 방법
SELECT A.prod_id 상품코드,
             A.prod_name 상품명,
             B.lprod_nm 분류명,
             C.buyer_name 거래처명
   FROM prod A, lprod B, buyer C
 WHERE A.prod_lgu = B.lprod_gu
      AND A.prod_buyer = C.buyer_id;

-- [국제표준방식으로 전환]
SELECT prod.prod_id,
             prod.prod_name,
             lprod.lprod_nm,
             buyer.buyer_name
   FROM prod INNER JOIN lprod
                          ON(prod.prod_lgu = lprod.lprod_gu)
                    INNER JOIN buyer
                          ON(prod.prod_buyer = buyer.buyer_id);

/* [문제]
회원이 구매한 거래처 정보를 조회하려고 합니다.
회원아이디, 회원이름, 상품거래처명,상품분류명을
조회해주세요 */
/* 기본적으로 아래 항목을 정리 후 쿼리를 작성하면 좋다.
테이블: buyer, member, prod, lprod
조회값: mem_id, mem_name, buyer_name, lprod_nm
관계조건: a.mem_id = c.cart_member
             c.cart_prod = d.prod_id
             d.prod_buyer = b.buyer_id
             d.prod_lgu = e.lprod_gu
일반조건:
정렬조건:
*/
SELECT a.mem_id, 
             a.mem_name, 
             b.buyer_name, 
             e.lprod_nm
   FROM member a, buyer b, prod d, lprod e
 WHERE a.mem_id = c.cart_member
      AND c.cart_prod = d.prod_id
      AND d.prod_buyer = b.buyer_id
      AND d.prod_lgu = e.lprod_gu;

-- [국제표준방식]
SELECT a.mem_id, 
             a.mem_name, 
             b.buyer_name, 
             e.lprod_nm
   FROM member a
             INNER JOIN cart c
                        ON(a.mem_id = c.cart_member)
             INNER JOIN prod d
                        ON(c.cart_prod = d.prod_id)
             INNER JOIN buyer b
                        ON(d.prod_buyer = b.buyer_id)
             INNER JOIN lprod e
                        ON(d.prod_lgu = e.lprod_gu);

/*
[문제]
거래처가 '삼성전자'인 자료에 대한
상품코드, 상품명, 거래처명을 조회하려고 합니다.
*/

SELECT p.prod_id 상품코드,
             p.prod_name 상품명,
             b.buyer_name 거래처명
   FROM prod p, buyer b
 WHERE p.prod_buyer = b.buyer_id
      AND b.buyer_name like '%삼성전자%';

-- [국제표준]
SELECT p.prod_id 상품코드,
             p.prod_name 상품명,
             b.buyer_name 거래처명
   FROM prod p INNER JOIN buyer b
                                ON(p.prod_buyer = b.buyer_id
                                AND b.buyer_name like '%삼성전자%');
-- WHERE b.buyer_name like '%삼성전자%';

/*[문제]
상품테이블에서 상품코드, 상품명, 분류명, 거래처명, 거래처주소를 조회
1) 판매가격이 10만원 이하이고
2) 거래처 주소가 부산인 경우만 조회
*/
SELECT p.prod_id,
             p.prod_name,
             lp.lprod_nm,
             b.buyer_name,
             b.buyer_add1
   FROM prod p, buyer b, lprod lp
 WHERE prod_lgu = lprod_gu
      AND prod_buyer = buyer_id
      AND prod_sale <= 100000
      AND buyer_add1 like '%부산%';

--[국제표준]
SELECT  p.prod_id,
             p.prod_name,
             lp.lprod_nm,
             p.prod_sale,
             b.buyer_name,
             b.buyer_add1
   FROM prod p INNER JOIN buyer b
                                ON(prod_buyer = buyer_id
                                AND prod_sale <= 100000
                                AND buyer_add1 like '%부산%')
                       INNER JOIN lprod lp
                                ON(prod_lgu = lprod_gu);

/*[문제]
상품분류코드가 P101 인것에 대한
상품분류명, 상품아이디, 판매가, 거래처담당자, 회원아이디, 주문수량 조회
단, 상품분류명을 기준으로 내림차순, 상품아이디를 기준으로 오름차순
*/
SELECT lp.lprod_nm,
             p.prod_id,
             p.prod_sale,
             b.buyer_name,
             c.cart_member,
             c.cart_qty
   FROM prod p, buyer b, lprod lp, cart c
 WHERE prod_lgu = lprod_gu
      AND prod_buyer = buyer_id
      AND prod_id = cart_prod
      AND lprod_gu ='P101'
 ORDER BY lprod_nm DESC, prod_id ASC;

-- [국제표준]
SELECT lp.lprod_nm,
             p.prod_id,
             p.prod_sale,
             b.buyer_charger,
             c.cart_member,
             c.cart_qty
   FROM prod p INNER JOIN buyer b
                            ON(prod_buyer = buyer_id)
                       INNER JOIN lprod lp
                            ON(prod_lgu = lprod_gu
                            AND lprod_gu ='P101')
                       INNER JOIN cart c
                            ON(prod_id = cart_prod)
 ORDER BY lprod_nm DESC, prod_id ASC;