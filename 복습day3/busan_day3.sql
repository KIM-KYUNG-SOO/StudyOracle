-- 3일차
/*
수행 순서
 : select -> from + 테이블 -> where + 일반 조건 (in, and, or, ..) (맞는 조건들을 걸러냄)
   -> group by + 일반컬럼 -> having + 그룹 조건 
   -> (select 줄) 출력할 컬럼(그룹 함수) 체크 -> order by 
*/

-- GROUP
-- count
-- count(컬럼) : null 값은 제외
-- count(*)     : null 값도 포함

/*
[문제] 
구매내역(장바구니) 정보에서 회원아이디로 주문(수량)에 대한 평균을 조회해 주세요.
회원아이디를 기준으로 내림차순
*/
select cart_member, avg(cart_qty) as avg_qty
from cart 
group by cart_member
order by cart_member desc;

/*
[문제]
상품 정보에서 판매가격의 평균 값을 구해주세요.
단, 평균값은 소수점 둘째자리까지 표현해주세요.
*/
select round(avg(prod_sale), 2) avg_sale
from prod ;

/*
[문제]
상품정보에서 상품분류별 판매가격의 평균값을 구해주세요.
조회 컬럼은 상품분류코드, 상품분류별 판매가격의 평균
단, 평균값은 소수점 둘째자리까지 표현해주세요.
*/
select prod_lgu, round(avg(prod_sale), 2) avg_sale
from prod
group by prod_lgu;

-- 회원테이블의 취미종류수를 count 집계
select count(DISTINCT mem_like) 취미종류수
from member ;

-- 회원테이블의 취미별 count집계
select mem_like 취미, 
         count(mem_like) 자료수, count(*) "자료수(*)"
from member
group by  mem_like ;

-- 회원테이블의 직업종류수는 count집계
select count(DISTINCT mem_job) kind_job
from member ;

select mem_id, count(mem_job) cnt_job
from member 
group by mem_id
order by ;

/*
[문제]
회원 전체의 마일리지 평균보다 큰 회원에 대한 아이디, 이름, 마일리지를 조회해 주세요
정렬은 마일리지가 높은 순으로
*/
select avg(mem_mileage)
from member ;

select mem_id, mem_name, mem_mileage 
from member
where mem_mileage >= (
                                  select avg(mem_mileage)
                                  from member
                                  )
order by mem_mileage desc;


-- max(col), min(col)
select cart_member 회원ID,
        max(distinct cart_qty) "최대수량(distinct)",
        max(cart_qty) 최대수량
from cart
group by cart_member ;


select *
from cart ;

-- 오늘이 2005년도 7월 11일이라 가정하고 장바구니테이블에 발생될 추가주문번호를 검색하시오
-- alias 최고치주문번호, 추가주문번호
select max(cart_no) 마지막주문번호, (max(cart_no) + 1) 추가주문번호 
from cart
where cart_no LIKE '20050711%' ;
-- like / substr / to_date 등 사용 가능

/*
[문제]
구매정보에서 연도별로 판매된 상품의 갯수, 평균구매수량을 조회하려고 합니다.
정렬은 연도를 기준으로 내림차순해주세요
*/
select substr(cart_no, 1, 4) as yyyy, 
         sum(cart_qty) as sum_qty,
         avg(cart_qty) as avg_qty
from cart 
group by substr(cart_no, 1, 4)
order by yyyy desc;
-- 단일 그룹의 그룹 함수가 아니다 : 그룹함수를 제외한 일반함수가 들어가있다라는 뜻

/*
[문제]
구매정보에서 연도별, 상품분류코드별로 상품의 갯수를 조회하려고 합니다.
정렬은 연도를 기준으로 내림차순해주세요.
*/
SELECT SUBSTR(cart_no,1,4) 연도,
             SUBSTR(cart_prod,1,4) 상품분류코드,
             COUNT(cart_qty) 상품갯수
   FROM cart
 GROUP BY SUBSTR(cart_no,1,4), SUBSTR(cart_prod,1,4)
 ORDER BY 연도 DESC;
 
 /* 회원테이블의 회원전체의 마일리지 평균, 마일리지합계,
 최고 마일리지, 최소 마일리지, 인원수를 검색하시오
 마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 인원수*/
 SELECT AVG(mem_mileage) 마일리지평균,
              MAX(mem_mileage) 최고마일리지,
              MIN(mem_mileage) 최소마일리지,
              COUNT(DISTINCT mem_id)
   FROM member;

/* 상품테이블에서 상품분류별 판매전체의 
평균, 합계, 최고값, 최저값, 자료수를 검색하시요
평균, 합계, 최고값, 최저값, 자료수 
조건: 자료수가 20개 이상인 것만
*/
SELECT prod_lgu 상품분류,
             ROUND(AVG(prod_sale),0) 판매가평균,
             MAX(prod_sale) 최고판매가,
             MIN(prod_sale) 최소판매가,
             COUNT(prod_sale) 자료수
   FROM prod
 GROUP BY prod_lgu
 HAVING COUNT(prod_sale) >= 20;
-- WHERE: 일반조건만
-- HAVING: 그룹조건만
 
 /* 회원테이블에서 지역(주소1, 2자리), 생일년도별로 마일리지평균,
 마일리지합계, 최고마일맂, 최소마일리지, 자료수를 검색하시오
 지역, 생일연도, 마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 자료수 */
 SELECT SUBSTR(mem_add1,1,2) 지역,
              to_char(mem_bir,'yyyy') 생일연도,
              avg(mem_mileage) 마일리지평균,
              max(mem_mileage) 최고마일리지,
              min(mem_mileage) 최소마일리지,
              sum(mem_mileage) 마일리지합계,
              count(mem_mileage) 자료수
    FROM member
 GROUP BY SUBSTR(mem_add1,1,2), to_char(mem_bir,'yyyy');
 
 -- null값의 처리(0,1 같은 특정한 값이 아니고 아무것도 없는 것을 뜻함)
UPDATE buyer SET buyer_charger = NULL
 WHERE buyer_charger LIKE '김%';

SELECT buyer_name 거래처,
             buyer_charger 담당자
   FROM buyer
 WHERE buyer_charger LIKE '김%';

UPDATE buyer SET buyer_charger = ''
 WHERE buyer_charger LIKE '성%';

-- IS NULL, IS NOT NULL 은 조건절인 WHERE절에서만 사용!
-- NULL을 이용한 NULL값 비교
SELECT buyer_name 거래처,
             buyer_charger 담당자
   FROM buyer
 WHERE buyer_charger = NULL;

-- IS NULL 사용
SELECT buyer_name 거래처,
             buyer_charger 담당자
   FROM buyer
 WHERE buyer_charger IS NULL;

-- IS NOT NULL의 사용
SELECT buyer_name 거래처,
             buyer_charger 담당자
   FROM buyer
 WHERE buyer_charger IS NOT NULL;

-- 해당컬럼이 NULL일 경우 문자나, 숫자치환
SELECT buyer_name 거래처,
             buyer_charger 담당자
   FROM buyer;

SELECT buyer_name 거래처,
             NVL(buyer_charger,'없다') 담당자
   FROM buyer;

-- 회원 마일리지에 100을 더한 수치를 검색(NVL사용)
SELECT mem_name 성명,
             mem_mileage 마일리지,
             (NVL(mem_mileage,0)+100) 변경마일리지
   FROM member;
   
-- 회원 마일리지가 있으면 '정상회원', NULL이면 '비정상회원'으로 검색
SELECT mem_name 회원이름,
             mem_mileage 마일리지,
             NVL2(mem_mileage,'정상회원','비정상회원') 회원상태
   FROM member;

--DECODE 함수(사용빈도 높음)
--DECODE(조건(값),10,A,9,B,8,C,D)
SELECT DECODE(SUBSTR(prod_lgu,1,2),
                          'P1','컴퓨터/전자제품',
                          'P2','의류',
                          'P3','잡화','기타')
   FROM prod;

/* 상품분류중 앞의 두글자가 P1이면 판매가를 10% 인상
P2이면 판매가를 15% 인상하고, 나머지는 동일 판매가로 검색
상품명, 판매가, 변경판매가*/

SELECT prod_name 상품명,
             prod_sale 판매가,
             DECODE(SUBSTR(prod_lgu,1,2),
                            'P1',prod_sale*1.1,
                            'P2',prod_sale*1.15,prod_sale) 변경판매가
   FROM prod;
   
-- CASE 함수
/* 회원정보테이블의 주민등록 뒷자리에서 성별 구분을 검색
case 구문사용, 회원명, 주민등록번호(주민1-주민2), 성별*/
SELECT mem_name 회원명,
             mem_regno1||'-'||mem_regno2 주민번호,
             CASE 
                    WHEN SUBSTR(mem_regno2,1,1) = 1 
                        THEN '남자'
                    ELSE '여자' 
             END 성별
   FROM member;

/* 가장 어려운 문제 3문제 만들기.....*/
SELECT prod_id 상품코드,
             prod_name 상품명,
             to_char(prod_sale,'999,999,999') 판매가,
             NVL(prod_color,'검정') 상품색상,
             COUNT(prod_color) 색깔별갯수
   FROM prod
 WHERE prod_sale > (SELECT AVG(prod_sale)
                                 FROM prod)
             AND prod_id IN(SELECT cart_prod 
                                     FROM cart
                                    WHERE cart_member IN(SELECT mem_id
                                                                        FROM member
                                                                      WHERE EXTRACT(year from mem_bir) = 1975
                                                                           AND SUBSTR(mem_add1,1,2) = '대전'))
             AND prod_name like '%삼성%'
 GROUP BY prod_id,
             prod_name,
             prod_sale,
             prod_color
 HAVING COUNT(prod_color) >= 1
 ORDER BY prod_sale DESC;
 
select distinct prod_color from prod;
--------------------------------------------------------------------
Select prod_name,
         prod_lgu,
         TO_CHAR(prod_sale,'L9,999,999'),
         TO_CHAR(DECODE(SUBSTR(prod_lgu,3,4),
                        '01', prod_sale - (prod_sale * 10/100),
                        '02', prod_sale + (prod_sale * 5/100)),'L9,999,999') as "변경판매가"                     
From prod
Where prod_id IN(SELECT cart_prod 
                            From cart
                            WHERE cart_member IN (SELECT mem_id
                                                                FROM member    
                                                                Where EXTRACT(MONTH From mem_bir) = '1' ))                                                          
and prod_sale Between 500000 AND 1000000;

-------------------------------------------------------------------------------------------------------
SELECT 
          SUBSTR(cart_no, 1, 6) AS YYYYMM,
          SUM(cart_qty) AS sum_qty,
          AVG(cart_qty) AS avg_qty
FROM cart
  WHERE cart_member = 'c001'
  GROUP BY SUBSTR(cart_no, 1, 6)
  HAVING AVG(cart_qty) < 5
ORDER BY YYYYMM DESC;
