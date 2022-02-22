-- 테이블 생성하기
Create Table lprod (
    lprod_id number(5) not null,
    lprod_gu char(4) not null,
    lprod_nm varchar2(40) not null,
    CONSTRAINT pk_lprod Primary Key (lprod_gu)
);

Drop 



-- 데이터 조회하기
Select lprod_id, lprod_gu, lprod_nm -- = *
From lprod;

-- 데이터 입력하기
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (1, 'P101', '컴퓨터제품');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm)
Values 
    (2, 'P102', '전자제품');
Insert Into lprod
    (lprod_id, lprod_gu, lprod_nm) 
Values 
(3, 'P201', '여성케쥬얼');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (4, 'P202', '남성케쥬얼');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (5, 'P301', '피혁잡화');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (6, 'P302', '피혁잡화');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (7, 'P401', '음반/CD');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
(8, 'P402', '문구류');

Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (9, 'P403', '문구류');

-- 상품분류 정보에서 상품분류코드의 값이
-- 201인 데이터를 조회해 주세요.
Select * From lprod
-- 조건추가
Where lprod_gu != 'P201'; -- >, <, =, != 등의 연산자도 사용가능

-- 데이터 수정하기
-- 상품분류코드가 P102에 대해서
-- 상품분류명의 값을 향수로 수정해 주세요
Update lprod
    Set lprod_nm = '향수'
Where lprod_gu = 'P102';

-- 상품분류정보에서 상품분류코드가
-- P202에 대한 데이터를 삭제해주세요.
Delete From lprod
Where lprod_gu = 'P202';

commit; -- 커밋하고나면 Rollback은 안됌

-- 거래처 정보테이블 생성
Create Table buyer
    (buyer_id char(6) Not Null,                     -- 거래처코드
    buyer_name varchar2(40) Not Null,         -- 거래처명
    buyer_lgu char(4) Not Null,                     -- 취급상품 대분류
    buyer_bank varchar2(60) Not Null,          -- 은행
    buyer_bankno varchar2(60) Not Null,       -- 계좌번호
    buyer_bankname varchar2(15) Not Null,   -- 예금주
    buyer_zip char(7) Not Null,                     -- 우편번호
    buyer_add1 varchar2(100),                     -- 주소1
    buyer_add2 varchar2(70),                       -- 주소2
    buyer_comtel varchar2(14) Not Null,        -- 전화번호
    buyer_fax varchar2(20) Not Null);            -- FAX 번호

Alter Table buyer
    Add
        (buyer_mail varchar2(60) Not Null,
        buyer_charger varchar2(20),
        buyer_telext varchar(2))
    Modify
        (buyer_name varchar(60));
Alter Table buyer
    Add
    (Constraint pk_buyer Primary Key (buyer_id),
    Constraint fr_buyer_lprod Foreign Key (buyer_lgu) 
        References lprod (lprod_gu));

/*
lprod : 상품분류정보
prod : 상품정보
buyer : 거래처정보
member : 회원정보
cart : 구매(장바구니) 정보
buyprod : 입고상품정보
remain : 재고수불정보
*/

-- 테이블 찾기
-- 조건이 있는지?
-- 어떤 칼럼을 사용하는지?

-- 회원테이블에서 ID, 성명 검색
Select mem_id, mem_name From member;

-- 상품테이블에서 상품코드와 상품명 검색
Select prod_id, prod_name From prod;


-- 회원 테이블에서 마일리지를 12로 나눈 값을 검색
Select mem_mileage, 
          (mem_mileage / 12) as mem_12
    From member;
    
-- 상품 테이블의 상품코드, 상품명, 판매금액을 검색
-- (판매금액 = 판매단가*55)
Select prod_id, 
    prod_name,
    (prod_sale * 55)  sale_cost
From prod;

-- 중복 Row 제거 Distinct
-- 상품 테이블의 거래처코드를 중복되지 않게 검색
Select Distinct prod_buyer 거래처
From prod;

-- 회원테이블에서 회원 ID, 회원명, 생일, 마일리지 검색
Select mem_id id, 
          mem_name nm, 
          mem_bir, 
          mem_mileage
  From member
 Order By id Asc; -- 별칭을 이용
 
Select mem_id, mem_name, mem_bir, mem_mileage
  From member
 Order By mem_id Asc; -- 기본값 오름차순
 
SELECT prod_id ID,
            prod_name 상품,
            prod_sale 판매가
   FROM prod
 WHERE prod_sale != 170000;
 
-- 상품가격이 170000 초과하는 경우
SELECT prod_id ID,
            prod_name 상품,
            prod_sale 판매가
   FROM prod
 WHERE prod_sale > 170000
 ORDER BY 판매가 ASC;

-- 상품중에 매입가격이 200000원 이하인
-- 상품검색 단, 상품코드를 기준으로 내림차순
-- 조회 칼럼은 상품명, 매입가격, 상품코드

SELECT prod_id 상품코드,
             prod_cost 매입가격,
             prod_name 상품명
   FROM prod
   WHERE prod_cost <= 200000
 ORDER BY 상품코드 Desc;
 
-- 회원 중에 76년도 1월 1일 이후에 태어난
-- 회원 아이디, 회원이름, 주민등록번호 앞자리
SELECT mem_id 회원아이디,
             mem_name 회원이름,
             mem_regno1 주민번호앞자리
   FROM member
 WHERE mem_regno1 >= 760101
 ORDER BY 회원아이디 ASC;
 
-- 상품중 상품분류가 P201(여성캐쥬얼)이고 
-- 판매가가 170000원인 상품조회
SELECT prod_name 상품,
             prod_lgu 상품분류,
             prod_sale 판매가
   FROM prod
 WHERE prod_lgu = 'P201' AND prod_sale = 170000;

-- 상품중 상품분류가 P201이거나 
-- 판매가가 170000원인 상품조회
SELECT prod_name 상품,
             prod_lgu 상품분류,
             prod_sale 판매가
   FROM prod
 WHERE prod_lgu = 'P201' OR prod_sale = 170000;
 
 -- 상품중 상품분류가 P201도 아니고
 -- 판매가가 170000원도 아닌 상품 조회
SELECT prod_name 상품,
             prod_lgu 상품분류,
             prod_sale 판매가
   FROM prod
 WHERE NOT (prod_lgu = 'P201' OR prod_sale = 170000);
 
-- 상품중 판매가가 300000원 이상
-- 500000원 이하인 상품을 검색
SELECT prod_id ID,
             prod_name 상품명,
             prod_sale 판매가
   FROM prod
 WHERE prod_sale >= 300000 AND prod_sale <= 500000;
 
 -- 상품중에 판매가격이 150000, 170000, 330000인
 -- 상품정보 조회. 상품코드, 상품명, 판매가격 조회
 -- 정렬은 상품명을 기준으로 오름차순
SELECT prod_id ID,
             prod_name 상품명,
             prod_sale 판매가격
   FROM prod
 WHERE prod_sale = 150000 or prod_sale = 170000 or prod_sale = 330000
 ORDER BY 상품명 ASC;
 
-- 회원중에 아이디가 C001, F001, W001인 회원조회
-- 회원아이디, 회원이름 조회
-- 정렬은 주민번호 앞자리를 기준으로 내림차순
SELECT mem_id 아이디, 
             mem_name 이름
   FROM member
   WHERE mem_id NOT IN ('c001','f001','w001') -- NOT을 이렇게도 사용가능
-- WHERE mem_id IN ('c001','f001','w001')
-- WHERE mem_id = 'c001' or mem_id = 'f001' or mem_id = 'w001'
 ORDER BY mem_regno1;
 
-- 상품 분류테이블에서 현재 상품테이블에 존재하는
-- 분류만 검색(분류명, 코드명)
SELECT lprod_gu 분류코드,
             lprod_nm 분류명
   FROM lprod
 WHERE lprod_gu IN (SELECT prod_lgu From prod);
-- IN 안에 쓸수있는 SELECT, WHERE 절
-- 단일칼럼에 다중행 형태만 쓸수 있다.

-- 상품 분류테이블에서 현재 상품테이블에 존재하지 않는 분류만 검색
SELECT lprod_gu 분류코드,
             lprod_nm 분류명
   FROM lprod
 WHERE lprod_gu NOT IN (SELECT prod_lgu From prod);
 
-- 문제 : 한번도 상품을 구매한적이 없는 회원아이디, 이름조회
SELECT mem_id 회원아이디,
             mem_name 이름
   FROM member
 WHERE mem_id NOT IN(
                       SELECT cart_member From cart);

-- 문제 한번도 판매된 적이 없는 상품을 조회하려고합니다.
-- 판매된 적이 없는 상품이름을 조회
SELECT prod_id 상품코드,
             prod_name 상품명
   FROM prod
 WHERE prod_id NOT IN(SELECT cart_prod From cart);
 
-- 문제 회원중에 김은대 회원이 지금까지 구매했던
-- 모든 상품명을 조회해

SELECT prod_name 상품명
   FROM prod
 WHERE prod_id IN (
                        SELECT cart_prod
                           FROM cart
                         WHERE cart_member = 'a001');

SELECT prod_name 상품명
   FROM prod
 WHERE prod_id IN (
                        SELECT cart_prod
                           FROM cart
                         WHERE cart_member IN (
                                                      SELECT mem_id 
                                                         FROM member
                                                      WHERE mem_name = '김은대'));

/* 상품중 판매가격이 10만원 이상, 30만원 이하인 상품을 조회
조회 컬럼은 상품명, 판매가격 입니다
정렬은 판매가격을 기준으로 내림차순 해주세요
*/
SELECT prod_name 상품명,
             prod_sale 판매가격
   FROM prod
 WHERE prod_sale 
 BETWEEN 100000 AND 300000
 
-- WHERE prod_sale >= 100000 
--      AND prod_sale <= 300000
 ORDER BY prod_sale DESC;

-- 회원 중 생일이 1975-01-01 76-12-31사이에
-- 태어난 회원을 검색
SELECT mem_id 회원ID,
             mem_name 회원명,
             mem_bir 생일
   FROM member
 WHERE mem_bir 
 BETWEEN '1975-01-01' AND '1976-12-31';

/* 문제 거래처 담당자 강남구씨가 담당하는 상품을
구매한 회원들을 조회하려고 합니다.
회원아이디, 회원이름을 조회해 주세요.
*/

SELECT mem_id 회원아이디,
             mem_name 회원이름
   FROM member
 WHERE mem_id IN(
                SELECT cart_member
                   FROM cart
                 WHERE cart_prod IN(
                                    SELECT prod_id
                                      FROM prod
                                     WHERE prod_buyer IN(
                                                    SELECT buyer_id
                                                       FROM buyer
                                                     WHERE buyer_charger = '강남구')));

-- 상품 중 매입가가 300000~1500000이고
-- 판매가가 800000~2000000 인 상품을 검색
SELECT prod_name, prod_cost, prod_sale
   FROM prod
 WHERE prod_cost BETWEEN 300000 AND 1500000
     AND prod_sale BETWEEN 800000 AND 2000000;

-- 회원 중 생일이 1975년도 생이 아닌 회원을 검색
SELECT mem_id 회원ID,
             mem_name 회원이름,
             mem_bir 생일
   FROM member
 WHERE mem_bir NOT BETWEEN '1975-01-01' AND '1975-12-31';

-- like 기타연산자
-- 회원중 김씨 성을 가진 사람 찾기
SELECT mem_id 회원ID,
             mem_name 성명
   FROM member
 WHERE mem_name like '김%';

-- 회원테이블의 주민등록번호 앞자리를 검색하여 
-- 1975년생을 제외한 회원을 검색
SELECT mem_id 회원ID,
             mem_name 성명,
             mem_regno1 주민번호앞
  FROM member
 WHERE mem_regno1 not like '75%'
 ORDER BY mem_regno1 ASC;
 
-- CONCAT: 두문자열을 연결
SELECT CONCAT('My Name is', mem_name)
   FROM member;

-- ASCII값을 문자로, 문자를 ASCII 값으로 변환   
SELECT chr(66) "CHR", ascii('A') "ASCII" FROM dual;

-- LOWER, UPPER, INITCAP 
-- 소문자, 대문자, 첫글자만 대문자로 나머지는 소문자로
SELECT INITCAP('DATA manipulation LanGGGage') d
   FROM dual;
   
-- 회원테이블의 회원ID를 대문자로 변환하여 검색
SELECT mem_id 변환전ID,
             UPPER(mem_id) 변환후ID
   FROM member;

-- SUBSTR 문자열을 자르는 함수
-- REPLACE
SELECT REPLACE('SQL Project', 'SQL', 'SSQQLL') 문자치환1,
            REPLACE('Java Flex Via', 'a') 문자치환2
   FROM dual;
   
-- 회원테이블의 회원성명 성씨중 '이' ---> '리'로 치환 검색하시오
SELECT mem_name 회원이름,
             CONCAT(REPLACE(SUBSTR(mem_name,1,1),'이','리'),
             SUBSTR(mem_name,2)) 회원명치환
   FROM member;

-- MOD(c, n) n으로 나눈 나머지
SELECT MOD(10,3) 나머지 FROM dual;

-- 날짜함수(SYSDATE: 시스템에서 재공하는 현재시간,날짜)
SELECT sysdate FROM dual;
SELECT sysdate +1 FROM dual; -- 연산도 가능하다
SELECT sysdate -1 FROM dual; -- 연산도 가능하다

SELECT next_day(sysdate, '월요일'),
             last_day(sysdate)
   FROM dual;

-- 이번달이 며칠 남았는지 검색하시오
select last_day(sysdate)-sysdate 잔여일 FROM dual;

-- EXTRACT 날짜에서 필요한 부분만 추출
-- 컬럼사용시 날짜 컬럼만 사용 가능함
-- 생일이 3월인 회원만 검색
SELECT mem_name 회원이름,
             mem_bir 생일
   FROM member
 WHERE EXTRACT(MONTH FROM mem_bir) = 3;
select extract(year from sysdate) from dual;
-- 회원 생일 중 1973년생이 주로 구매한 상품을
-- 오름차순으로 조회하려고 합니다.
-- 조회칼럼 : 상품명
-- 단, 상품명에 삼성이 푸함된 상품만 조회,
-- 그리고 조회 결과는 중복제거

SELECT DISTINCT(prod_name) 상품명
   FROM prod
 WHERE prod_name like '%삼성%'
 AND prod_id in (
                    SELECT cart_prod 
                       FROM cart
                     WHERE cart_member in(
                                                SELECT mem_id 
                                                   FROM member
                                                 WHERE EXTRACT(year from mem_bir) = 1973))
 ORDER BY prod_name ASC;
 
-- 형 변환 함수 CAST: 명시적 변환
-- to_char, to_number, to_date

-- 상품테이블에서 상품입고일을 '2008-09-28'  형식으로
-- 나오게 검색
SELECT p.prod_name 상품명,
             p.prod_sale 상품판매가,
             to_char(b.buy_date,'yyyy-mm-dd') 입고일
   FROM prod p, buyprod b
 WHERE p.prod_id = b.buy_prod;
 
SELECT prod_name 상품명,
             prod_sale 상품판매가,
             to_char(prod_insdate, 'yyyy-mm-dd') 입고일
   FROM prod;
   
-- 회원이름과 생일로 다음처럼 출력되게 작성하시오.
-- 김은대님은 1976년 1월 출생이고 태어난 요일은 목요일
-- 이쁜이님은 1974년 1월 출생이고 태어난 요일은 월요일

SELECT mem_name||'님은 '||to_char(mem_bir,'yyyy')||'년 '||to_char(mem_bir, 'mon')||' 출생이고 태어난 요일은 '||to_char(mem_bir, 'day')
   FROM member;

SELECT to_char(1234.6,'99,999.00') FROM dual;
SELECT to_char(-1234.6,'L9999.00PR') FROM dual;

-- 상품테이블에서 상품코드, 상품명, 매입가격, 
-- 소비자가격, 판매가격을 출력(천단위 구분, 원화표시)
SELECT prod_id 상품코드,
             prod_name 상품명,
             to_char(prod_cost,'L9,999,999,999') 매입가격,
             to_char(prod_price,'L9,999,999,999') 소비자가격,
             to_char(prod_sale,'L9,999,999,999') 판매가격
   FROM prod
 ORDER BY prod_sale desc;

-- 회원테이블에서 이쁜이회원의 회원ID 2~4 문자열을 숫자형으로
-- 치환한후 10을 더하여 새로운 회원ID로 조합
SELECT MEM_ID 회원ID,
       CONCAT(SUBSTR(MEM_ID,1,2) ,
       TO_NUMBER(SUBSTR(MEM_ID,3,2))+10) 조합회원ID
        FROM MEMBER
            WHERE MEM_NAME='이쁜이';
 
 /* [규칙]
 일반컬럼과 그룹함수를 같이 사용할 경우에는
 꼭!! GROUP BY절을 넣어 주어야 합니다.
 그리고 GROUP BY절에는 일반칼럼이 모두 들어가야 합니다.
 */
-- GROUP BY 최대, 최소, 평균, 합, COUNT
SELECT prod_lgu,
             ROUND(AVG(prod_cost),2) "분류별 매입가격 평균"
   FROM prod
 GROUP BY prod_lgu;

-- 상품테이블의 판매가격 평균 값을 구하시오
SELECT ROUND(avg(prod_sale),0) 상품판매가격의평균 FROM prod;

-- 상품테이블의 상품분류별 판매가격 평균 값을 구하시오
SELECT prod_lgu 상품분류,
             ROUND(avg(prod_sale),0) 상품분류별평균
   FROM prod
 GROUP BY prod_lgu;
 
-- 장바구니테이블의 회원별 COUNT집계
SELECT cart_member 회원ID,
             COUNT(cart_member) 자료수,
             COUNT(*) "자료수(*)"
   FROM cart
 GROUP BY cart_member;
 
/*[문제]
구매수량의 전체평균 이상을 구매한 회원들의
아이디와 이름을 조회해 주세요
단, 정렬은 주민번호(앞)를 기준으로 오름차순
*/

SELECT mem_id 회원ID,
             mem_name 회원이름
   FROM member
 WHERE mem_id in (
                    SELECT cart_member
                       FROM cart
                     WHERE cart_qty >= 
                                        (SELECT AVG(cart_qty) 
                                            FROM cart))
ORDER BY mem_regno1 ASC;

 SELECT cart_member
                       FROM cart
                     WHERE cart_qty >= 
                                        (SELECT AVG(cart_qty) 
                                            FROM cart);
                                            
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







