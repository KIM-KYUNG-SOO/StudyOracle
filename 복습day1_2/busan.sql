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