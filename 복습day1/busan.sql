-- ���̺� �����ϱ�
Create Table lprod (
    lprod_id number(5) not null,
    lprod_gu char(4) not null,
    lprod_nm varchar2(40) not null,
    CONSTRAINT pk_lprod Primary Key (lprod_gu)
);

Drop 



-- ������ ��ȸ�ϱ�
Select lprod_id, lprod_gu, lprod_nm -- = *
From lprod;

-- ������ �Է��ϱ�
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (1, 'P101', '��ǻ����ǰ');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm)
Values 
    (2, 'P102', '������ǰ');
Insert Into lprod
    (lprod_id, lprod_gu, lprod_nm) 
Values 
(3, 'P201', '���������');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (4, 'P202', '���������');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (5, 'P301', '������ȭ');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (6, 'P302', '������ȭ');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (7, 'P401', '����/CD');
Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
(8, 'P402', '������');

Insert Into lprod 
    (lprod_id, lprod_gu, lprod_nm) 
Values 
    (9, 'P403', '������');

-- ��ǰ�з� �������� ��ǰ�з��ڵ��� ����
-- 201�� �����͸� ��ȸ�� �ּ���.
Select * From lprod
-- �����߰�
Where lprod_gu != 'P201'; -- >, <, =, != ���� �����ڵ� ��밡��

-- ������ �����ϱ�
-- ��ǰ�з��ڵ尡 P102�� ���ؼ�
-- ��ǰ�з����� ���� ����� ������ �ּ���
Update lprod
    Set lprod_nm = '���'
Where lprod_gu = 'P102';

-- ��ǰ�з��������� ��ǰ�з��ڵ尡
-- P202�� ���� �����͸� �������ּ���.
Delete From lprod
Where lprod_gu = 'P202';

commit; -- Ŀ���ϰ��� Rollback�� �ȉ�

-- �ŷ�ó �������̺� ����
Create Table buyer
    (buyer_id char(6) Not Null,                     -- �ŷ�ó�ڵ�
    buyer_name varchar2(40) Not Null,         -- �ŷ�ó��
    buyer_lgu char(4) Not Null,                     -- ��޻�ǰ ��з�
    buyer_bank varchar2(60) Not Null,          -- ����
    buyer_bankno varchar2(60) Not Null,       -- ���¹�ȣ
    buyer_bankname varchar2(15) Not Null,   -- ������
    buyer_zip char(7) Not Null,                     -- �����ȣ
    buyer_add1 varchar2(100),                     -- �ּ�1
    buyer_add2 varchar2(70),                       -- �ּ�2
    buyer_comtel varchar2(14) Not Null,        -- ��ȭ��ȣ
    buyer_fax varchar2(20) Not Null);            -- FAX ��ȣ

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
lprod : ��ǰ�з�����
prod : ��ǰ����
buyer : �ŷ�ó����
member : ȸ������
cart : ����(��ٱ���) ����
buyprod : �԰��ǰ����
remain : ����������
*/

-- ���̺� ã��
-- ������ �ִ���?
-- � Į���� ����ϴ���?

-- ȸ�����̺��� ID, ���� �˻�
Select mem_id, mem_name From member;

-- ��ǰ���̺��� ��ǰ�ڵ�� ��ǰ�� �˻�
Select prod_id, prod_name From prod;


-- ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻�
Select mem_mileage, 
          (mem_mileage / 12) as mem_12
    From member;
    
-- ��ǰ ���̺��� ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ��� �˻�
-- (�Ǹűݾ� = �ǸŴܰ�*55)
Select prod_id, 
    prod_name,
    (prod_sale * 55)  sale_cost
From prod;

-- �ߺ� Row ���� Distinct
-- ��ǰ ���̺��� �ŷ�ó�ڵ带 �ߺ����� �ʰ� �˻�
Select Distinct prod_buyer �ŷ�ó
From prod;

-- ȸ�����̺��� ȸ�� ID, ȸ����, ����, ���ϸ��� �˻�
Select mem_id id, 
          mem_name nm, 
          mem_bir, 
          mem_mileage
  From member
 Order By id Asc; -- ��Ī�� �̿�
 
Select mem_id, mem_name, mem_bir, mem_mileage
  From member
 Order By mem_id Asc; -- �⺻�� ��������
 
SELECT prod_id ID,
            prod_name ��ǰ,
            prod_sale �ǸŰ�
   FROM prod
 WHERE prod_sale != 170000;
 
-- ��ǰ������ 170000 �ʰ��ϴ� ���
SELECT prod_id ID,
            prod_name ��ǰ,
            prod_sale �ǸŰ�
   FROM prod
 WHERE prod_sale > 170000
 ORDER BY �ǸŰ� ASC;

-- ��ǰ�߿� ���԰����� 200000�� ������
-- ��ǰ�˻� ��, ��ǰ�ڵ带 �������� ��������
-- ��ȸ Į���� ��ǰ��, ���԰���, ��ǰ�ڵ�

SELECT prod_id ��ǰ�ڵ�,
             prod_cost ���԰���,
             prod_name ��ǰ��
   FROM prod
   WHERE prod_cost <= 200000
 ORDER BY ��ǰ�ڵ� Desc;
 
-- ȸ�� �߿� 76�⵵ 1�� 1�� ���Ŀ� �¾
-- ȸ�� ���̵�, ȸ���̸�, �ֹε�Ϲ�ȣ ���ڸ�
SELECT mem_id ȸ�����̵�,
             mem_name ȸ���̸�,
             mem_regno1 �ֹι�ȣ���ڸ�
   FROM member
 WHERE mem_regno1 >= 760101
 ORDER BY ȸ�����̵� ASC;
 
-- ��ǰ�� ��ǰ�з��� P201(����ĳ���)�̰� 
-- �ǸŰ��� 170000���� ��ǰ��ȸ
SELECT prod_name ��ǰ,
             prod_lgu ��ǰ�з�,
             prod_sale �ǸŰ�
   FROM prod
 WHERE prod_lgu = 'P201' AND prod_sale = 170000;

-- ��ǰ�� ��ǰ�з��� P201�̰ų� 
-- �ǸŰ��� 170000���� ��ǰ��ȸ
SELECT prod_name ��ǰ,
             prod_lgu ��ǰ�з�,
             prod_sale �ǸŰ�
   FROM prod
 WHERE prod_lgu = 'P201' OR prod_sale = 170000;
 
 -- ��ǰ�� ��ǰ�з��� P201�� �ƴϰ�
 -- �ǸŰ��� 170000���� �ƴ� ��ǰ ��ȸ
SELECT prod_name ��ǰ,
             prod_lgu ��ǰ�з�,
             prod_sale �ǸŰ�
   FROM prod
 WHERE NOT (prod_lgu = 'P201' OR prod_sale = 170000);
 
-- ��ǰ�� �ǸŰ��� 300000�� �̻�
-- 500000�� ������ ��ǰ�� �˻�
SELECT prod_id ID,
             prod_name ��ǰ��,
             prod_sale �ǸŰ�
   FROM prod
 WHERE prod_sale >= 300000 AND prod_sale <= 500000;
 
 -- ��ǰ�߿� �ǸŰ����� 150000, 170000, 330000��
 -- ��ǰ���� ��ȸ. ��ǰ�ڵ�, ��ǰ��, �ǸŰ��� ��ȸ
 -- ������ ��ǰ���� �������� ��������
SELECT prod_id ID,
             prod_name ��ǰ��,
             prod_sale �ǸŰ���
   FROM prod
 WHERE prod_sale = 150000 or prod_sale = 170000 or prod_sale = 330000
 ORDER BY ��ǰ�� ASC;
 
-- ȸ���߿� ���̵� C001, F001, W001�� ȸ����ȸ
-- ȸ�����̵�, ȸ���̸� ��ȸ
-- ������ �ֹι�ȣ ���ڸ��� �������� ��������
SELECT mem_id ���̵�, 
             mem_name �̸�
   FROM member
   WHERE mem_id NOT IN ('c001','f001','w001') -- NOT�� �̷��Ե� ��밡��
-- WHERE mem_id IN ('c001','f001','w001')
-- WHERE mem_id = 'c001' or mem_id = 'f001' or mem_id = 'w001'
 ORDER BY mem_regno1;
 
-- ��ǰ �з����̺��� ���� ��ǰ���̺� �����ϴ�
-- �з��� �˻�(�з���, �ڵ��)
SELECT lprod_gu �з��ڵ�,
             lprod_nm �з���
   FROM lprod
 WHERE lprod_gu IN (SELECT prod_lgu From prod);
-- IN �ȿ� �����ִ� SELECT, WHERE ��
-- ����Į���� ������ ���¸� ���� �ִ�.

-- ��ǰ �з����̺��� ���� ��ǰ���̺� �������� �ʴ� �з��� �˻�
SELECT lprod_gu �з��ڵ�,
             lprod_nm �з���
   FROM lprod
 WHERE lprod_gu NOT IN (SELECT prod_lgu From prod);
 
-- ���� : �ѹ��� ��ǰ�� ���������� ���� ȸ�����̵�, �̸���ȸ
SELECT mem_id ȸ�����̵�,
             mem_name �̸�
   FROM member
 WHERE mem_id NOT IN(
                       SELECT cart_member From cart);

-- ���� �ѹ��� �Ǹŵ� ���� ���� ��ǰ�� ��ȸ�Ϸ����մϴ�.
-- �Ǹŵ� ���� ���� ��ǰ�̸��� ��ȸ
SELECT prod_id ��ǰ�ڵ�,
             prod_name ��ǰ��
   FROM prod
 WHERE prod_id NOT IN(SELECT cart_prod From cart);
 
-- ���� ȸ���߿� ������ ȸ���� ���ݱ��� �����ߴ�
-- ��� ��ǰ���� ��ȸ��

SELECT prod_name ��ǰ��
   FROM prod
 WHERE prod_id IN (
                        SELECT cart_prod
                           FROM cart
                         WHERE cart_member = 'a001');

SELECT prod_name ��ǰ��
   FROM prod
 WHERE prod_id IN (
                        SELECT cart_prod
                           FROM cart
                         WHERE cart_member IN (
                                                      SELECT mem_id 
                                                         FROM member
                                                      WHERE mem_name = '������'));

/* ��ǰ�� �ǸŰ����� 10���� �̻�, 30���� ������ ��ǰ�� ��ȸ
��ȸ �÷��� ��ǰ��, �ǸŰ��� �Դϴ�
������ �ǸŰ����� �������� �������� ���ּ���
*/
SELECT prod_name ��ǰ��,
             prod_sale �ǸŰ���
   FROM prod
 WHERE prod_sale 
 BETWEEN 100000 AND 300000
 
-- WHERE prod_sale >= 100000 
--      AND prod_sale <= 300000
 ORDER BY prod_sale DESC;

-- ȸ�� �� ������ 1975-01-01 76-12-31���̿�
-- �¾ ȸ���� �˻�
SELECT mem_id ȸ��ID,
             mem_name ȸ����,
             mem_bir ����
   FROM member
 WHERE mem_bir 
 BETWEEN '1975-01-01' AND '1976-12-31';

/* ���� �ŷ�ó ����� ���������� ����ϴ� ��ǰ��
������ ȸ������ ��ȸ�Ϸ��� �մϴ�.
ȸ�����̵�, ȸ���̸��� ��ȸ�� �ּ���.
*/

SELECT mem_id ȸ�����̵�,
             mem_name ȸ���̸�
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
                                                     WHERE buyer_charger = '������')));

-- ��ǰ �� ���԰��� 300000~1500000�̰�
-- �ǸŰ��� 800000~2000000 �� ��ǰ�� �˻�
SELECT prod_name, prod_cost, prod_sale
   FROM prod
 WHERE prod_cost BETWEEN 300000 AND 1500000
     AND prod_sale BETWEEN 800000 AND 2000000;

-- ȸ�� �� ������ 1975�⵵ ���� �ƴ� ȸ���� �˻�
SELECT mem_id ȸ��ID,
             mem_name ȸ���̸�,
             mem_bir ����
   FROM member
 WHERE mem_bir NOT BETWEEN '1975-01-01' AND '1975-12-31';

-- like ��Ÿ������
-- ȸ���� �达 ���� ���� ��� ã��
SELECT mem_id ȸ��ID,
             mem_name ����
   FROM member
 WHERE mem_name like '��%';

-- ȸ�����̺��� �ֹε�Ϲ�ȣ ���ڸ��� �˻��Ͽ� 
-- 1975����� ������ ȸ���� �˻�
SELECT mem_id ȸ��ID,
             mem_name ����,
             mem_regno1 �ֹι�ȣ��
  FROM member
 WHERE mem_regno1 not like '75%'
 ORDER BY mem_regno1 ASC;
 
-- CONCAT: �ι��ڿ��� ����
SELECT CONCAT('My Name is', mem_name)
   FROM member;

-- ASCII���� ���ڷ�, ���ڸ� ASCII ������ ��ȯ   
SELECT chr(66) "CHR", ascii('A') "ASCII" FROM dual;

-- LOWER, UPPER, INITCAP 
-- �ҹ���, �빮��, ù���ڸ� �빮�ڷ� �������� �ҹ��ڷ�
SELECT INITCAP('DATA manipulation LanGGGage') d
   FROM dual;
   
-- ȸ�����̺��� ȸ��ID�� �빮�ڷ� ��ȯ�Ͽ� �˻�
SELECT mem_id ��ȯ��ID,
             UPPER(mem_id) ��ȯ��ID
   FROM member;

-- SUBSTR ���ڿ��� �ڸ��� �Լ�
-- REPLACE
SELECT REPLACE('SQL Project', 'SQL', 'SSQQLL') ����ġȯ1,
            REPLACE('Java Flex Via', 'a') ����ġȯ2
   FROM dual;
   
-- ȸ�����̺��� ȸ������ ������ '��' ---> '��'�� ġȯ �˻��Ͻÿ�
SELECT mem_name ȸ���̸�,
             CONCAT(REPLACE(SUBSTR(mem_name,1,1),'��','��'),
             SUBSTR(mem_name,2)) ȸ����ġȯ
   FROM member;

-- MOD(c, n) n���� ���� ������
SELECT MOD(10,3) ������ FROM dual;

-- ��¥�Լ�(SYSDATE: �ý��ۿ��� ����ϴ� ����ð�,��¥)
SELECT sysdate FROM dual;
SELECT sysdate +1 FROM dual; -- ���굵 �����ϴ�
SELECT sysdate -1 FROM dual; -- ���굵 �����ϴ�

SELECT next_day(sysdate, '������'),
             last_day(sysdate)
   FROM dual;

-- �̹����� ��ĥ ���Ҵ��� �˻��Ͻÿ�
select last_day(sysdate)-sysdate �ܿ��� FROM dual;

-- EXTRACT ��¥���� �ʿ��� �κи� ����
-- �÷����� ��¥ �÷��� ��� ������
-- ������ 3���� ȸ���� �˻�
SELECT mem_name ȸ���̸�,
             mem_bir ����
   FROM member
 WHERE EXTRACT(MONTH FROM mem_bir) = 3;
select extract(year from sysdate) from dual;
-- ȸ�� ���� �� 1973����� �ַ� ������ ��ǰ��
-- ������������ ��ȸ�Ϸ��� �մϴ�.
-- ��ȸĮ�� : ��ǰ��
-- ��, ��ǰ�� �Ｚ�� Ǫ�Ե� ��ǰ�� ��ȸ,
-- �׸��� ��ȸ ����� �ߺ�����

SELECT DISTINCT(prod_name) ��ǰ��
   FROM prod
 WHERE prod_name like '%�Ｚ%'
 AND prod_id in (
                    SELECT cart_prod 
                       FROM cart
                     WHERE cart_member in(
                                                SELECT mem_id 
                                                   FROM member
                                                 WHERE EXTRACT(year from mem_bir) = 1973))
 ORDER BY prod_name ASC;
 
-- �� ��ȯ �Լ� CAST: ����� ��ȯ
-- to_char, to_number, to_date

-- ��ǰ���̺��� ��ǰ�԰����� '2008-09-28'  ��������
-- ������ �˻�
SELECT p.prod_name ��ǰ��,
             p.prod_sale ��ǰ�ǸŰ�,
             to_char(b.buy_date,'yyyy-mm-dd') �԰���
   FROM prod p, buyprod b
 WHERE p.prod_id = b.buy_prod;
 
SELECT prod_name ��ǰ��,
             prod_sale ��ǰ�ǸŰ�,
             to_char(prod_insdate, 'yyyy-mm-dd') �԰���
   FROM prod;
   
-- ȸ���̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ��Ͻÿ�.
-- ��������� 1976�� 1�� ����̰� �¾ ������ �����
-- �̻��̴��� 1974�� 1�� ����̰� �¾ ������ ������

SELECT mem_name||'���� '||to_char(mem_bir,'yyyy')||'�� '||to_char(mem_bir, 'mon')||' ����̰� �¾ ������ '||to_char(mem_bir, 'day')
   FROM member;

SELECT to_char(1234.6,'99,999.00') FROM dual;
SELECT to_char(-1234.6,'L9999.00PR') FROM dual;

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, ���԰���, 
-- �Һ��ڰ���, �ǸŰ����� ���(õ���� ����, ��ȭǥ��)
SELECT prod_id ��ǰ�ڵ�,
             prod_name ��ǰ��,
             to_char(prod_cost,'L9,999,999,999') ���԰���,
             to_char(prod_price,'L9,999,999,999') �Һ��ڰ���,
             to_char(prod_sale,'L9,999,999,999') �ǸŰ���
   FROM prod
 ORDER BY prod_sale desc;

-- ȸ�����̺��� �̻���ȸ���� ȸ��ID 2~4 ���ڿ��� ����������
-- ġȯ���� 10�� ���Ͽ� ���ο� ȸ��ID�� ����
SELECT MEM_ID ȸ��ID,
       CONCAT(SUBSTR(MEM_ID,1,2) ,
       TO_NUMBER(SUBSTR(MEM_ID,3,2))+10) ����ȸ��ID
        FROM MEMBER
            WHERE MEM_NAME='�̻���';
 
 /* [��Ģ]
 �Ϲ��÷��� �׷��Լ��� ���� ����� ��쿡��
 ��!! GROUP BY���� �־� �־�� �մϴ�.
 �׸��� GROUP BY������ �Ϲ�Į���� ��� ���� �մϴ�.
 */
-- GROUP BY �ִ�, �ּ�, ���, ��, COUNT
SELECT prod_lgu,
             ROUND(AVG(prod_cost),2) "�з��� ���԰��� ���"
   FROM prod
 GROUP BY prod_lgu;

-- ��ǰ���̺��� �ǸŰ��� ��� ���� ���Ͻÿ�
SELECT ROUND(avg(prod_sale),0) ��ǰ�ǸŰ�������� FROM prod;

-- ��ǰ���̺��� ��ǰ�з��� �ǸŰ��� ��� ���� ���Ͻÿ�
SELECT prod_lgu ��ǰ�з�,
             ROUND(avg(prod_sale),0) ��ǰ�з������
   FROM prod
 GROUP BY prod_lgu;
 
-- ��ٱ������̺��� ȸ���� COUNT����
SELECT cart_member ȸ��ID,
             COUNT(cart_member) �ڷ��,
             COUNT(*) "�ڷ��(*)"
   FROM cart
 GROUP BY cart_member;
 
/*[����]
���ż����� ��ü��� �̻��� ������ ȸ������
���̵�� �̸��� ��ȸ�� �ּ���
��, ������ �ֹι�ȣ(��)�� �������� ��������
*/

SELECT mem_id ȸ��ID,
             mem_name ȸ���̸�
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
                                            
-- 3����
/*
���� ����
 : select -> from + ���̺� -> where + �Ϲ� ���� (in, and, or, ..) (�´� ���ǵ��� �ɷ���)
   -> group by + �Ϲ��÷� -> having + �׷� ���� 
   -> (select ��) ����� �÷�(�׷� �Լ�) üũ -> order by 
*/

-- GROUP
-- count
-- count(�÷�) : null ���� ����
-- count(*)     : null ���� ����

/*
[����] 
���ų���(��ٱ���) �������� ȸ�����̵�� �ֹ�(����)�� ���� ����� ��ȸ�� �ּ���.
ȸ�����̵� �������� ��������
*/
select cart_member, avg(cart_qty) as avg_qty
from cart 
group by cart_member
order by cart_member desc;

/*
[����]
��ǰ �������� �ǸŰ����� ��� ���� �����ּ���.
��, ��հ��� �Ҽ��� ��°�ڸ����� ǥ�����ּ���.
*/
select round(avg(prod_sale), 2) avg_sale
from prod ;

/*
[����]
��ǰ�������� ��ǰ�з��� �ǸŰ����� ��հ��� �����ּ���.
��ȸ �÷��� ��ǰ�з��ڵ�, ��ǰ�з��� �ǸŰ����� ���
��, ��հ��� �Ҽ��� ��°�ڸ����� ǥ�����ּ���.
*/
select prod_lgu, round(avg(prod_sale), 2) avg_sale
from prod
group by prod_lgu;

-- ȸ�����̺��� ����������� count ����
select count(DISTINCT mem_like) ���������
from member ;

-- ȸ�����̺��� ��̺� count����
select mem_like ���, 
         count(mem_like) �ڷ��, count(*) "�ڷ��(*)"
from member
group by  mem_like ;

-- ȸ�����̺��� ������������ count����
select count(DISTINCT mem_job) kind_job
from member ;

select mem_id, count(mem_job) cnt_job
from member 
group by mem_id
order by ;

/*
[����]
ȸ�� ��ü�� ���ϸ��� ��պ��� ū ȸ���� ���� ���̵�, �̸�, ���ϸ����� ��ȸ�� �ּ���
������ ���ϸ����� ���� ������
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
select cart_member ȸ��ID,
        max(distinct cart_qty) "�ִ����(distinct)",
        max(cart_qty) �ִ����
from cart
group by cart_member ;


select *
from cart ;

-- ������ 2005�⵵ 7�� 11���̶� �����ϰ� ��ٱ������̺� �߻��� �߰��ֹ���ȣ�� �˻��Ͻÿ�
-- alias �ְ�ġ�ֹ���ȣ, �߰��ֹ���ȣ
select max(cart_no) �������ֹ���ȣ, (max(cart_no) + 1) �߰��ֹ���ȣ 
from cart
where cart_no LIKE '20050711%' ;
-- like / substr / to_date �� ��� ����

/*
[����]
������������ �������� �Ǹŵ� ��ǰ�� ����, ��ձ��ż����� ��ȸ�Ϸ��� �մϴ�.
������ ������ �������� �����������ּ���
*/
select substr(cart_no, 1, 4) as yyyy, 
         sum(cart_qty) as sum_qty,
         avg(cart_qty) as avg_qty
from cart 
group by substr(cart_no, 1, 4)
order by yyyy desc;
-- ���� �׷��� �׷� �Լ��� �ƴϴ� : �׷��Լ��� ������ �Ϲ��Լ��� ���ִٶ�� ��

/*
[����]
������������ ������, ��ǰ�з��ڵ庰�� ��ǰ�� ������ ��ȸ�Ϸ��� �մϴ�.
������ ������ �������� �����������ּ���.
*/
SELECT SUBSTR(cart_no,1,4) ����,
             SUBSTR(cart_prod,1,4) ��ǰ�з��ڵ�,
             COUNT(cart_qty) ��ǰ����
   FROM cart
 GROUP BY SUBSTR(cart_no,1,4), SUBSTR(cart_prod,1,4)
 ORDER BY ���� DESC;
 
 /* ȸ�����̺��� ȸ����ü�� ���ϸ��� ���, ���ϸ����հ�,
 �ְ� ���ϸ���, �ּ� ���ϸ���, �ο����� �˻��Ͻÿ�
 ���ϸ������, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ο���*/
 SELECT AVG(mem_mileage) ���ϸ������,
              MAX(mem_mileage) �ְ��ϸ���,
              MIN(mem_mileage) �ּҸ��ϸ���,
              COUNT(DISTINCT mem_id)
   FROM member;

/* ��ǰ���̺��� ��ǰ�з��� �Ǹ���ü�� 
���, �հ�, �ְ�, ������, �ڷ���� �˻��Ͻÿ�
���, �հ�, �ְ�, ������, �ڷ�� 
����: �ڷ���� 20�� �̻��� �͸�
*/
SELECT prod_lgu ��ǰ�з�,
             ROUND(AVG(prod_sale),0) �ǸŰ����,
             MAX(prod_sale) �ְ��ǸŰ�,
             MIN(prod_sale) �ּ��ǸŰ�,
             COUNT(prod_sale) �ڷ��
   FROM prod
 GROUP BY prod_lgu
 HAVING COUNT(prod_sale) >= 20;
-- WHERE: �Ϲ����Ǹ�
-- HAVING: �׷����Ǹ�
 
 /* ȸ�����̺��� ����(�ּ�1, 2�ڸ�), ���ϳ⵵���� ���ϸ������,
 ���ϸ����հ�, �ְ��ϐ�, �ּҸ��ϸ���, �ڷ���� �˻��Ͻÿ�
 ����, ���Ͽ���, ���ϸ������, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ڷ�� */
 SELECT SUBSTR(mem_add1,1,2) ����,
              to_char(mem_bir,'yyyy') ���Ͽ���,
              avg(mem_mileage) ���ϸ������,
              max(mem_mileage) �ְ��ϸ���,
              min(mem_mileage) �ּҸ��ϸ���,
              sum(mem_mileage) ���ϸ����հ�,
              count(mem_mileage) �ڷ��
    FROM member
 GROUP BY SUBSTR(mem_add1,1,2), to_char(mem_bir,'yyyy');
 
 -- null���� ó��(0,1 ���� Ư���� ���� �ƴϰ� �ƹ��͵� ���� ���� ����)
UPDATE buyer SET buyer_charger = NULL
 WHERE buyer_charger LIKE '��%';

SELECT buyer_name �ŷ�ó,
             buyer_charger �����
   FROM buyer
 WHERE buyer_charger LIKE '��%';

UPDATE buyer SET buyer_charger = ''
 WHERE buyer_charger LIKE '��%';

-- IS NULL, IS NOT NULL �� �������� WHERE�������� ���!
-- NULL�� �̿��� NULL�� ��
SELECT buyer_name �ŷ�ó,
             buyer_charger �����
   FROM buyer
 WHERE buyer_charger = NULL;

-- IS NULL ���
SELECT buyer_name �ŷ�ó,
             buyer_charger �����
   FROM buyer
 WHERE buyer_charger IS NULL;

-- IS NOT NULL�� ���
SELECT buyer_name �ŷ�ó,
             buyer_charger �����
   FROM buyer
 WHERE buyer_charger IS NOT NULL;

-- �ش��÷��� NULL�� ��� ���ڳ�, ����ġȯ
SELECT buyer_name �ŷ�ó,
             buyer_charger �����
   FROM buyer;

SELECT buyer_name �ŷ�ó,
             NVL(buyer_charger,'����') �����
   FROM buyer;

-- ȸ�� ���ϸ����� 100�� ���� ��ġ�� �˻�(NVL���)
SELECT mem_name ����,
             mem_mileage ���ϸ���,
             (NVL(mem_mileage,0)+100) ���渶�ϸ���
   FROM member;
   
-- ȸ�� ���ϸ����� ������ '����ȸ��', NULL�̸� '������ȸ��'���� �˻�
SELECT mem_name ȸ���̸�,
             mem_mileage ���ϸ���,
             NVL2(mem_mileage,'����ȸ��','������ȸ��') ȸ������
   FROM member;

--DECODE �Լ�(���� ����)
--DECODE(����(��),10,A,9,B,8,C,D)
SELECT DECODE(SUBSTR(prod_lgu,1,2),
                          'P1','��ǻ��/������ǰ',
                          'P2','�Ƿ�',
                          'P3','��ȭ','��Ÿ')
   FROM prod;

/* ��ǰ�з��� ���� �α��ڰ� P1�̸� �ǸŰ��� 10% �λ�
P2�̸� �ǸŰ��� 15% �λ��ϰ�, �������� ���� �ǸŰ��� �˻�
��ǰ��, �ǸŰ�, �����ǸŰ�*/

SELECT prod_name ��ǰ��,
             prod_sale �ǸŰ�,
             DECODE(SUBSTR(prod_lgu,1,2),
                            'P1',prod_sale*1.1,
                            'P2',prod_sale*1.15,prod_sale) �����ǸŰ�
   FROM prod;
   
-- CASE �Լ�
/* ȸ���������̺��� �ֹε�� ���ڸ����� ���� ������ �˻�
case �������, ȸ����, �ֹε�Ϲ�ȣ(�ֹ�1-�ֹ�2), ����*/
SELECT mem_name ȸ����,
             mem_regno1||'-'||mem_regno2 �ֹι�ȣ,
             CASE 
                    WHEN SUBSTR(mem_regno2,1,1) = 1 
                        THEN '����'
                    ELSE '����' 
             END ����
   FROM member;

/* ���� ����� ���� 3���� �����.....*/
SELECT prod_id ��ǰ�ڵ�,
             prod_name ��ǰ��,
             to_char(prod_sale,'999,999,999') �ǸŰ�,
             NVL(prod_color,'����') ��ǰ����,
             COUNT(prod_color) ���򺰰���
   FROM prod
 WHERE prod_sale > (SELECT AVG(prod_sale)
                                 FROM prod)
             AND prod_id IN(SELECT cart_prod 
                                     FROM cart
                                    WHERE cart_member IN(SELECT mem_id
                                                                        FROM member
                                                                      WHERE EXTRACT(year from mem_bir) = 1975
                                                                           AND SUBSTR(mem_add1,1,2) = '����'))
             AND prod_name like '%�Ｚ%'
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
                        '02', prod_sale + (prod_sale * 5/100)),'L9,999,999') as "�����ǸŰ�"                     
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







