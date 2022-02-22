-- 3조 문제
/*
1. 오철희가 산 물건 중 TV 가 고장나서 교환받으려고 한다
교환받으려면 거래처 전화번호를 이용해야 한다.
구매처와 전화번호를 조회하시오.
*/
SELECT buyer_name 거래처명,
             buyer_comtel 전화번호
   FROM buyer
 WHERE buyer_id IN (SELECT prod_buyer
                                 FROM prod
                               WHERE prod_name like '%TV%'
                                    AND prod_id IN (SELECT cart_prod
                                                             FROM cart
                                                            WHERE cart_member IN (SELECT mem_id
                                                                                                 FROM member
                                                                                                WHERE mem_name = '오철희')));

/*
2. 대전에 사는 73년이후에 태어난 주부들중 2005년 4월에 구매한 물품을 조회하고, 
그상품을 거래하는 각거래처의 계좌 은행명과 계좌번호를 뽑으시오.
(단, 은행명-계좌번호).*/
SELECT (buyer_bank||' '||buyer_bankno) 계좌번호
   FROM buyer
 WHERE buyer_id IN (SELECT prod_buyer 
                                 FROM prod
                               WHERE prod_id IN (SELECT cart_prod 
                                                            FROM cart
                                                          WHERE SUBSTR(cart_no,5,2) = '04'
                                                               AND cart_member IN (SELECT mem_id
                                                                                                FROM member
                                                                                             WHERE mem_job = '주부'
                                                                                                  AND SUBSTR(mem_regno1,1,2) >= '73'
                                                                                                  AND SUBSTR(MEM_ADD1,1,2)='대전')));
/*
3. 물건을 구매한 회원들 중 5개이상 구매한 회원과 4개이하로 구매한 회원에게 쿠폰을 할인율이 다른 쿠폰을 발행할 예정이다. 
회원들을 구매횟수에 따라  오름차순으로 정렬하고  회원들의 회원id와 전화번호(HP)를 조회하라.
*/
SELECT mem_id 회원ID,
             mem_hp 회원전화번호,
             (SELECT SUM(cart_qty) 구매횟수
                 FROM cart
               WHERE cart_member = member.mem_id) cart_qty
   FROM MEMBER 
 ORDER BY cart_qty ASC ;

-- 4조 문제
/*
김성욱씨는 주문했던 제품의 배송이 지연되어 불만이다.
구매처에 문의한 결과, 제품 공급에 차질이 생겨 배송이 늦어진다는 답변을 받았다.
김성욱씨는 해당 제품의 공급 담당자에게 직접 전화하여 항의하고 싶다.
어떤 번호로 전화해야 하는가?*/
SELECT buyer_charger 담당자, 
             buyer_comtel 전화번호
   FROM buyer
 WHERE buyer_id IN (SELECT prod_buyer
                                 FROM prod
                               WHERE prod_id IN (SELECT cart_prod
                                                              FROM cart
                                                            WHERE cart_member IN (SELECT mem_id
                                                                                                 FROM member
                                                                                                WHERE mem_name = '김성욱'))); 

/*서울 외 타지역에 살며 외환은행을 사용하는 거래처 담당자가 담당하는 상품을 구매한 회원들의 이름, 생일을 조회 하며 
이름이 '이'로 시작하는 회원명을을 '리' 로 치환해서 출력해라 */
SELECT REPLACE(SUBSTR(mem_name,1,1),'이','리')||SUBSTR(mem_name,2,2) 회원이름,  
             mem_bir 생일
   FROM member
 WHERE mem_id IN (SELECT cart_member 
                                FROM cart
                              WHERE cart_prod IN (SELECT prod_id 
                                                               FROM prod
                                                             WHERE prod_buyer IN (SELECT buyer_id
                                                                                                FROM buyer
                                                                                               WHERE buyer_bank = '외환은행'
                                                                                                    AND buyer_add1 not like '서울%')));

/*짝수 달에 구매된 상품들 중 세탁 주의가 필요 없는 상품들의 ID, 이름, 판매 마진을 출력하시오.
마진 출력 시 마진이 가장 높은 값은 10퍼센트 인하된 값으로, 가장 낮은 값은 10퍼센트 추가된 값으로 출력하시오.
정렬은 ID, 이름 순으로 정렬하시오.
(단, 마진은 소비자가 - 매입가로 계산한다.)*/
SELECT m.id,
             m.name,
             CASE m.prod_m
             WHEN (SELECT max(m.prod_m) FROM m)
                THEN m.prod_m*0.9
             WHEN (SELECT min(m.prod_m) FROM m)
                THEN m.prod_m*1.1
             ELSE m.prod_m
             END 마진
   FROM (SELECT prod_id id, prod_name name,(prod_price - prod_cost) prod_m FROM prod
                            WHERE prod_delivery != '세탁 주의'
                                  AND prod_id IN (SELECT cart_prod 
                                                           FROM cart
                                                          WHERE MOD(TO_NUMBER(SUBSTR(cart_no,5,2)),2) = 0)) m;

 

/*         
Select prod_id,
       prod_name,
       prod_price - prod_cost,
       case prod_price - prod_cost
       when (Select max(prod_price - prod_cost) 
               From prod 
              Where prod_delivery not like '%세탁 주의%'
                And prod_id In(
             Select cart_prod
               From cart
              Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12)))
       then (prod_price - prod_cost) * 0.9
       when (Select min(prod_price - prod_cost) 
               From prod 
              Where prod_delivery not like '%세탁 주의%'
                And prod_id In(
             Select cart_prod
              From cart
             Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12)))
       then (prod_price - prod_cost) * 1.1
       else prod_price - prod_cost end as 마진
  From prod
 Where prod_delivery not like '%세탁 주의%'
   And prod_id In(
           Select cart_prod
             From cart
            Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12))
 Group By prod_id, prod_name, prod_price - prod_cost; */
 
 /*
회원 이름과 회원별 총 구매 금액을 조회하여 내림차순으로 정렬하시오.
총 구매 금액은 천 단위로 끊고 원화 표시를 앞에 붙여 출력하시오.
*/

 Select m.mem_name, sale.sum_sale
From member m, 
     (
        Select mem_id, 
        sum(cart_qty * prod_sale) as sum_sale
        From member, cart, prod
        Where mem_id = cart_member
          And cart_prod = prod_id
        Group by mem_id
     ) sale
Where m.mem_id = sale.mem_id;