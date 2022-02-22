/* 5조 문제 풀어보기
1. 상품분류명이 '여성캐주얼'이면서 제품이름에 '여름'이 들어가는 상품이고,
매입수량이 30개이상이면서 6월에 입고한 제품의 마일리지와 판매가를 합한
값을 조회하시오
Alias 이름, 판매가격, 판매가격+마일리지
*/
SELECT prod_name 상품명,
             prod_sale 판매가격,
             prod_sale + NVL(prod_mileage,0) 마일리지New
   FROM prod
 WHERE prod_lgu IN (SELECT lprod_gu
                                 FROM lprod
                                WHERE lprod_nm = '여성캐주얼')
      AND prod_name like '%여름%'
      AND prod_id IN (SELECT buy_prod
                                FROM buyprod
                              WHERE buy_qty >= 30
                                   AND EXTRACT(month FROM buy_date) = 6);
-- JOIN으로 풀기
SELECT p.prod_name 상품명,
             p.prod_sale 판매가격,
             p.prod_sale+NVL(p.prod_mileage,0) 마일리지New
   FROM prod p, lprod lp, buyprod bp
 WHERE prod_lgu = lprod_gu
      AND lprod_nm = '여성캐주얼'
      AND prod_id = buy_prod
      AND buy_qty >= 30
      AND  EXTRACT(month FROM buy_date) = 6
      AND prod_name like '%여름%';

/* 2. 거래처 코드가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
제품 등록일이 2005년 1월 31일(2월달) 이후에 이루어졌고 매입단가가 20만원이 넘는 상품을
구매한 고객의 마일리지가 2500이상이면 우수회원 아니면 일반회원으로 출력하라
컬럼 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
*/
SELECT mem_name 회원이름,
             mem_mileage 마일리지,
             CASE 
                    WHEN mem_mileage >= 2500 
                        THEN '우수회원'
                    ELSE '일반회원' 
             END 회원등급
   FROM member
 WHERE mem_id In (Select cart_member
                               From cart
                             Where cart_prod In(Select prod_id
                                                           From prod
                                                         Where prod_buyer In(Select buyer_id
                                                                                         From buyer
                                                                                       Where buyer_id Like 'P20%')
                                                            And prod_insdate >= '05/02/01'
                                                            And prod_cost >= 200000));

-- JOIN으로 풀기
SELECT m.mem_name 회원이름,
             m.mem_mileage 마일리지,
             CASE
                  WHEN m.mem_mileage >= 2500
                    THEN '우수회원'
                   ELSE '일반회원'
             END 회원등급
   FROM member m, cart c, prod p, buyer b
 WHERE m.mem_id = c.cart_member
      AND c.cart_prod = p.prod_id
      AND p.prod_buyer = b.buyer_id
      AND b.buyer_id Like 'P20%'
      AND p.prod_insdate >= '05/02/01'
      AND p.prod_cost >= 200000;

/* 3. 6월달 이전(5월달까지)에 입고된 상품 중에 
배달특기사항이 '세탁 주의'이면서 색상이 null값인 제품들 중에 
판매량이 제품 판매량의 평균보다 많이 팔린걸 구매한
김씨 성을 가진 손님의 이름과 보유 마일리지를 구하고 성별을 출력하시오
Alias 이름, 보유 마일리지, 성별
*/
SELECT mem_name 이름,
             mem_mileage 마일리지,
             DECODE(SUBSTR(mem_regno2,1,1),1 ,'남자','여자') 성별
   FROM member
 WHERE mem_name like '김%'
      AND mem_id IN (SELECT cart_member
                                FROM cart
                              WHERE cart_qty >= (SELECT AVG(cart_qty)
                                                          FROM cart)    
                                   AND cart_prod IN(SELECT prod_id
                                                              FROM prod
                                                            WHERE prod_delivery = '세탁 주의'
                                                                 AND prod_color is NULL                                                   
                                                                 AND prod_id IN(SELECT buy_prod
                                                                                         FROM buyprod
                                                                                       WHERE EXTRACT(month from buy_date) < 6)));
                                                                                       
-- JOIN으로 풀기
SELECT m.mem_name 이름,
             m.mem_mileage 마일리지,
             DECODE(SUBSTR(m.mem_regno2,1,1),1 ,'남자','여자') 성별
   FROM member m, cart c, prod p, buyprod bp
 WHERE mem_id = cart_member
      AND cart_prod = prod_id
      AND prod_id = buy_prod
      AND mem_name like '김%'
      AND cart_qty >= (SELECT AVG(cart_qty) FROM cart)
      AND prod_delivery = '세탁 주의'
      AND prod_color is NULL
      AND EXTRACT(month from buy_date) < 6;
      
/* 1조 문제 풀어보기
[문제 만들기]
상품 중 안전재고수량별 빈도수가 
가장 높은 상품을 구매한 회원 중 자영업 아닌 회원의 id와 name
*/
SELECT mem_id 회원iD,
             mem_name 이름
   FROM member
 WHERE not mem_job = '자영업'
      AND mem_id IN (SELECT cart_member
                                FROM cart
                              WHERE cart_prod IN(SELECT prod_id
                                                              FROM prod
                                                             WHERE;

SELECT  prod_name, prod_properstock, COUNT(prod_properstock) 
   FROM prod
 GROUP BY prod_name, prod_properstock;
/*
[문제 만들기]
취급상품코드가 'P1'이고 '인천'에 사는 구매 담당자의 상품을 구매한 
회원의 결혼기념일이 8월달이 아니면서 
평균마일리지(소수두째자리까지) 미만이면서 
구매일에 첫번째로 구매한 회원의 
회원ID, 회원이름, 회원마일리지를 검색하시오.  
*/
SELECT mem_id 회원ID,
             mem_name 회원이름,
             ROUND(mem_mileage,2) 회원마일리지
   FROM member
 WHERE mem_mileage < (SELECT AVG(mem_mileage)
                                            FROM member)
      AND mem_memorial = '결혼기념일'
      AND EXTRACT(month FROM mem_memorialday) not 8
      AND mem_add1 like '%인천%'
      AND mem_id IN (SELECT cart_member
                                FROM cart
                              WHERE cart_no = (SELECT min(cart_no) (max(cart_no) + 1) 추가주문번호 
                                   AND cart_prod IN (SELECT prod_id
                                                                FROM prod
                                                             WHERE prod_buyer IN(SELECT buyer_id
                                                                                                FROM buyer
                                                                                              WHERE buyer_lgu ='P1%')))

/*
[문제 만들기]
주소지가 대전인 거래처 담당자가 담당하는 상품을 
구매하지 않은 대전 여성 회원 중에 12월에 결혼기념일이 있는
회원 아이디, 회원 이름 조회 
이름 오름차순 정렬 
*/


/*
[문제 만들기]
컴퓨터제품을 주관하며 수도권(서울,인천)에 살고 주소에 '마' 가 들어간 곳에 사는 담당자가 담당하는
제품 중에서 판매가격이 전체판매가격 이상인 상품을 구매한 회원들이 사는 곳(지역)을  분류하고
지역별 회원들이 생각하는 기념일별 가장 많은 기념일은 어떤것인지 알아내시오
--서울: 수도권
--충남, 대전 : 충청도 나머지는 경상도
*/