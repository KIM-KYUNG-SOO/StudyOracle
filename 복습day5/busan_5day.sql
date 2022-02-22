/*[문제]
상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회하세요
단, 상품분류 코드가 P101, P201, P301인 것들을 조회하고
매입수량이 15개 이상인 것들과,
'서울'에 살고있는 회원중에 생일이 1974년생인 사람들에 대해
조회해 주세요.

정렬은 회원 아이디를 기준으로 내림차순, 매입수량을 기준으로 내림차순해주세요
*/

SELECT p.prod_lgu 상품분류,
             p.prod_name 상품명,
             p.prod_color 상품색상,
             bp.buy_qty 매입수량,
             c.cart_qty 주문수량,
             b.buyer_name 거래처명
   FROM prod p, buyer b, buyprod bp, cart c, member m
 WHERE prod_lgu in ('P101','P201','P301')
      AND prod_id = buy_prod
      AND prod_buyer = buyer_id
      AND buy_qty >= 15
      AND prod_id = cart_prod
      AND cart_member = mem_id
      AND mem_add1 like '%서울%'
      AND EXTRACT(year from mem_bir) = 1974
ORDER BY mem_id, buy_qty DESC;

-- [국제표준]
SELECT lp.lprod_nm 상품분류명,
             p.prod_name 상품명,
             p.prod_color 상품색상,
             bp.buy_qty 매입수량,
             c.cart_qty 주문수량,
             b.buyer_name 거래처명
   FROM prod p INNER JOIN buyprod bp
                            ON(prod_id = buy_prod)
                       INNER JOIN buyer b
                            ON(prod_buyer = buyer_id)
                       INNER JOIN lprod lp
                            ON(prod_lgu = lprod_gu)
                       INNER JOIN cart c
                            ON(prod_id = cart_prod)
                       INNER JOIN member m
                            ON(cart_member = mem_id)
 WHERE prod_lgu in ('P101','P201','P301')
      AND buy_qty >= 15
      AND mem_add1 like '%서울%'
      AND EXTRACT(year from mem_bir) = 1974
 ORDER BY mem_id, buy_qty DESC;

-- OUTER JOIN
/* 두 테이블을 조인할때 조건식을 만족시키지 못하는 ROW는 검색에서
    빠지게 되는데, 이런 누락된 ROW들이 검색되도록 하는 방법
    조인에서 부족한 쪽에 "(+)" 연산자 기호를 사용한다.
    (+) 연산자는 NULL행을 생성하여 조인하게 한다.
*/
-- 기본적으로 INNER JOIN을 먼저하고 OUTER로 전환
SELECT lprod_gu 분류코드,
             lprod_nm 분류명,
             COUNT(prod_lgu) 상품자료수
   FROM lprod, prod
 WHERE lprod_gu = prod_lgu
 GROUP BY lprod_gu, lprod_nm;

-- OUTER JOIN
SELECT lprod_gu 분류코드,
             lprod_nm 분류명,
             COUNT(prod_lgu) 상품자료수
   FROM lprod, prod
 WHERE lprod_gu = prod_lgu(+)
 GROUP BY lprod_gu, lprod_nm;

-- [국제표준]
SELECT lprod_gu 분류코드,
             lprod_nm 분류명,
             COUNT(prod_lgu) 상품자료수
   FROM lprod
            LEFT OUTER JOIN prod 
                                ON(lprod_gu = prod_lgu)
  GROUP BY lprod_gu, lprod_nm;

/*[문제] 전체상품의 2005년 1월 입고수량을 검색조회
상품코드, 상품명, 입고수량 */
-- INNER JOIN
SELECT prod_id 상품코드,
             prod_name 상품명,
             SUM(buy_qty) 입고수량
   FROM prod, buyprod
 WHERE prod_id = buy_prod
      AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
 GROUP BY prod_id, prod_name;
 
 -- OUTER JOIN
 SELECT prod_id 상품코드,
             prod_name 상품명,
             SUM(buy_qty) 입고수량
   FROM prod, buyprod
 WHERE buy_date BETWEEN '2005-01-01' AND '2005-01-31'
      AND prod_id = buy_prod(+)
 GROUP BY prod_id, prod_name;
 
 -- OUTER JOIN[국제표준], 일반방식과 결과값이 다름
 SELECT prod_id 상품코드,
             prod_name 상품명,
             SUM(NVL(buy_qty,0)) 입고수량 -- NULL값의 처리
   FROM prod LEFT OUTER JOIN buyprod
                            ON(prod_id = buy_prod
                            AND buy_date BETWEEN '2005-01-01' AND '2005-01-31')
  GROUP BY prod_id, prod_name;
  
/* [문제] 
전체 회원의 2005년도 4월의 구매현황을 조회
회원ID, 성명, 구매수량의 합 */
-- OUTER JOIN[국제표준]
SELECT mem_id 회원ID,
             mem_name 성명,
             SUM(NVL(cart_qty,0)) 구매수량
   FROM member LEFT OUTER JOIN cart
                                    ON(mem_id = cart_member
                                    AND SUBSTR(cart_no,1,6) = '200504')
 GROUP BY mem_id, mem_name;


/*[문제]
2005년도 월별 매입현황을 검색하시오
매입월, 매입수량, 매입금액(매입수량*상품테이블의 매입가)*/

SELECT SUBSTR(cart_no,5,2) 판매월,
             SUM(cart_qty) 판매수량,
             TO_CHAR(SUM(cart_qty*prod_price),'L999,999,999') 판매금액
   FROM cart, prod
  WHERE cart_prod = prod_id
       AND SUBSTR(cart_no,1,4) = '2005'
 GROUP BY SUBSTR(cart_no,5,2);

/*[문제] 
상품분류가 컴퓨터제품('P101')인 상품의 2005년도 일자별 판매조회
판매일, 판매금액(5,000,000 초과의 경우만),판매수량
*/
SELECT SUBSTR(cart_no,1,8) 판매일,
             SUM(cart_qty*prod_sale) 판매금액,
             SUM(cart_qty) 판매수량
   FROM prod, cart
 WHERE cart_no LIKE '2005%'
     AND prod_id = cart_prod
     AND prod_lgu = 'P101'
 GROUP BY SUBSTR(cart_no, 1,8) 
 HAVING SUM(cart_qty * prod_sale)> 5000000
 ORDER BY SUBSTR(cart_no, 1,8);

-- SUB QUERY 서브쿼리
/* SQL 구문 안에 또 다른 SELECT 구문이 있는 것을 말함
1. Subquery는 괄호로 묶는다
2. 연산자와 사용할 경우 오른쪽에 뱇이한다
3. FROM 절에 사용하는 경우 View와 같이 독립된 테이블처럼 활용되어 
    Inline View 라고 부른다.
4. Main query와 Sub query 사이의 참조성 여부에 따라 연관(Correlated) 또는 
    비연관(Noncorrelated) 서브쿼리로 구분
5. 반환하는 행의 수, 컬럼수에 따라 단일행/다중행, 단일컬럼/다중컬럼으로
    구분하며 대체적으로 연산자의 특성을 이해하면 쉽다.
*/

/*
SELECT (1) ------- 1개의 컬럼에 하나의 값만 나오는 SELECT문
   FROM (2) ------- n개의 컬럼에 n개의 값을 뽑아내는 SELECT문
 WHERE >= (3) ---- 1개의 컬럼에 하나의 값만 나오는 SELECT문
              IN (4) ---- 1개의 컬럼에 여러개의 값이 나오는 SELECT문
              EXIST (5) -- n개의 컬럼에 n개의 행이 나오는 SELECT문
*/

/*
1. ANY, ALL은 비교 연산자와 조합된다.
2. ANY는 OR의 개념, 어떤 것이라도 맞으면 TRUE
3. ALL은 AND의 개념, 모두 만족해야만 TRUE
4. 비교 연산자 다음에 ANY 또는 ALL을 기술하고 서브쿼리 사용
*/