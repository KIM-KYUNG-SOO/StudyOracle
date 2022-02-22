/*[����]
��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ�ϼ���
��, ��ǰ�з� �ڵ尡 P101, P201, P301�� �͵��� ��ȸ�ϰ�
���Լ����� 15�� �̻��� �͵��,
'����'�� ����ִ� ȸ���߿� ������ 1974����� ����鿡 ����
��ȸ�� �ּ���.

������ ȸ�� ���̵� �������� ��������, ���Լ����� �������� �����������ּ���
*/

SELECT p.prod_lgu ��ǰ�з�,
             p.prod_name ��ǰ��,
             p.prod_color ��ǰ����,
             bp.buy_qty ���Լ���,
             c.cart_qty �ֹ�����,
             b.buyer_name �ŷ�ó��
   FROM prod p, buyer b, buyprod bp, cart c, member m
 WHERE prod_lgu in ('P101','P201','P301')
      AND prod_id = buy_prod
      AND prod_buyer = buyer_id
      AND buy_qty >= 15
      AND prod_id = cart_prod
      AND cart_member = mem_id
      AND mem_add1 like '%����%'
      AND EXTRACT(year from mem_bir) = 1974
ORDER BY mem_id, buy_qty DESC;

-- [����ǥ��]
SELECT lp.lprod_nm ��ǰ�з���,
             p.prod_name ��ǰ��,
             p.prod_color ��ǰ����,
             bp.buy_qty ���Լ���,
             c.cart_qty �ֹ�����,
             b.buyer_name �ŷ�ó��
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
      AND mem_add1 like '%����%'
      AND EXTRACT(year from mem_bir) = 1974
 ORDER BY mem_id, buy_qty DESC;

-- OUTER JOIN
/* �� ���̺��� �����Ҷ� ���ǽ��� ������Ű�� ���ϴ� ROW�� �˻�����
    ������ �Ǵµ�, �̷� ������ ROW���� �˻��ǵ��� �ϴ� ���
    ���ο��� ������ �ʿ� "(+)" ������ ��ȣ�� ����Ѵ�.
    (+) �����ڴ� NULL���� �����Ͽ� �����ϰ� �Ѵ�.
*/
-- �⺻������ INNER JOIN�� �����ϰ� OUTER�� ��ȯ
SELECT lprod_gu �з��ڵ�,
             lprod_nm �з���,
             COUNT(prod_lgu) ��ǰ�ڷ��
   FROM lprod, prod
 WHERE lprod_gu = prod_lgu
 GROUP BY lprod_gu, lprod_nm;

-- OUTER JOIN
SELECT lprod_gu �з��ڵ�,
             lprod_nm �з���,
             COUNT(prod_lgu) ��ǰ�ڷ��
   FROM lprod, prod
 WHERE lprod_gu = prod_lgu(+)
 GROUP BY lprod_gu, lprod_nm;

-- [����ǥ��]
SELECT lprod_gu �з��ڵ�,
             lprod_nm �з���,
             COUNT(prod_lgu) ��ǰ�ڷ��
   FROM lprod
            LEFT OUTER JOIN prod 
                                ON(lprod_gu = prod_lgu)
  GROUP BY lprod_gu, lprod_nm;

/*[����] ��ü��ǰ�� 2005�� 1�� �԰������ �˻���ȸ
��ǰ�ڵ�, ��ǰ��, �԰���� */
-- INNER JOIN
SELECT prod_id ��ǰ�ڵ�,
             prod_name ��ǰ��,
             SUM(buy_qty) �԰����
   FROM prod, buyprod
 WHERE prod_id = buy_prod
      AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
 GROUP BY prod_id, prod_name;
 
 -- OUTER JOIN
 SELECT prod_id ��ǰ�ڵ�,
             prod_name ��ǰ��,
             SUM(buy_qty) �԰����
   FROM prod, buyprod
 WHERE buy_date BETWEEN '2005-01-01' AND '2005-01-31'
      AND prod_id = buy_prod(+)
 GROUP BY prod_id, prod_name;
 
 -- OUTER JOIN[����ǥ��], �Ϲݹ�İ� ������� �ٸ�
 SELECT prod_id ��ǰ�ڵ�,
             prod_name ��ǰ��,
             SUM(NVL(buy_qty,0)) �԰���� -- NULL���� ó��
   FROM prod LEFT OUTER JOIN buyprod
                            ON(prod_id = buy_prod
                            AND buy_date BETWEEN '2005-01-01' AND '2005-01-31')
  GROUP BY prod_id, prod_name;
  
/* [����] 
��ü ȸ���� 2005�⵵ 4���� ������Ȳ�� ��ȸ
ȸ��ID, ����, ���ż����� �� */
-- OUTER JOIN[����ǥ��]
SELECT mem_id ȸ��ID,
             mem_name ����,
             SUM(NVL(cart_qty,0)) ���ż���
   FROM member LEFT OUTER JOIN cart
                                    ON(mem_id = cart_member
                                    AND SUBSTR(cart_no,1,6) = '200504')
 GROUP BY mem_id, mem_name;


/*[����]
2005�⵵ ���� ������Ȳ�� �˻��Ͻÿ�
���Կ�, ���Լ���, ���Աݾ�(���Լ���*��ǰ���̺��� ���԰�)*/

SELECT SUBSTR(cart_no,5,2) �Ǹſ�,
             SUM(cart_qty) �Ǹż���,
             TO_CHAR(SUM(cart_qty*prod_price),'L999,999,999') �Ǹűݾ�
   FROM cart, prod
  WHERE cart_prod = prod_id
       AND SUBSTR(cart_no,1,4) = '2005'
 GROUP BY SUBSTR(cart_no,5,2);

/*[����] 
��ǰ�з��� ��ǻ����ǰ('P101')�� ��ǰ�� 2005�⵵ ���ں� �Ǹ���ȸ
�Ǹ���, �Ǹűݾ�(5,000,000 �ʰ��� ��츸),�Ǹż���
*/
SELECT SUBSTR(cart_no,1,8) �Ǹ���,
             SUM(cart_qty*prod_sale) �Ǹűݾ�,
             SUM(cart_qty) �Ǹż���
   FROM prod, cart
 WHERE cart_no LIKE '2005%'
     AND prod_id = cart_prod
     AND prod_lgu = 'P101'
 GROUP BY SUBSTR(cart_no, 1,8) 
 HAVING SUM(cart_qty * prod_sale)> 5000000
 ORDER BY SUBSTR(cart_no, 1,8);

-- SUB QUERY ��������
/* SQL ���� �ȿ� �� �ٸ� SELECT ������ �ִ� ���� ����
1. Subquery�� ��ȣ�� ���´�
2. �����ڿ� ����� ��� �����ʿ� �l���Ѵ�
3. FROM ���� ����ϴ� ��� View�� ���� ������ ���̺�ó�� Ȱ��Ǿ� 
    Inline View ��� �θ���.
4. Main query�� Sub query ������ ������ ���ο� ���� ����(Correlated) �Ǵ� 
    �񿬰�(Noncorrelated) ���������� ����
5. ��ȯ�ϴ� ���� ��, �÷����� ���� ������/������, �����÷�/�����÷�����
    �����ϸ� ��ü������ �������� Ư���� �����ϸ� ����.
*/

/*
SELECT (1) ------- 1���� �÷��� �ϳ��� ���� ������ SELECT��
   FROM (2) ------- n���� �÷��� n���� ���� �̾Ƴ��� SELECT��
 WHERE >= (3) ---- 1���� �÷��� �ϳ��� ���� ������ SELECT��
              IN (4) ---- 1���� �÷��� �������� ���� ������ SELECT��
              EXIST (5) -- n���� �÷��� n���� ���� ������ SELECT��
*/

/*
1. ANY, ALL�� �� �����ڿ� ���յȴ�.
2. ANY�� OR�� ����, � ���̶� ������ TRUE
3. ALL�� AND�� ����, ��� �����ؾ߸� TRUE
4. �� ������ ������ ANY �Ǵ� ALL�� ����ϰ� �������� ���
*/