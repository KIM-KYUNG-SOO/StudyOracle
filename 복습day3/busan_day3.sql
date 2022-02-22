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
