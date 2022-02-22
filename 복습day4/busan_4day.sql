-- 4day
/*[����]
ȸ������ �߿� ���ų����� �ִ� ȸ���� ����
ȸ�����̵�, ȸ���̸�, ����(0000-00-00 ����)�� ��ȸ�� �ּ���.
������ ������ �������� ���������� �ּ���
*/
SELECT mem_id ȸ��ID,
             mem_name ȸ���̸�,
             TO_CHAR(mem_bir,'yyyy-mm-dd') ����
   FROM member
 WHERE mem_id IN (SELECT cart_member 
                                FROM cart)
 ORDER BY TO_CHAR(mem_bir,'yyyy-mm-dd') ASC;
 
-- �Ѱ��� ���̺� ��ü ��ȸ
SELECT * FROM member;

-- EXISTS(ORACLE ���� �Լ�)
SELECT prod_id, 
             prod_name, 
             prod_lgu
   FROM prod
 WHERE EXISTS (SELECT lprod_gu
                              FROM lprod
                            WHERE lprod_gu = prod.prod_lgu
                                 AND lprod_gu = 'P301');
                                 
-- ���� ������� �׷��� EXIST�� ���� ó���ӵ��� ������.
-- prod ��ü���� ��ȸ
SELECT prod_id, 
             prod_name, 
             prod_lgu
   FROM prod
 WHERE prod_lgu IN (SELECT lprod_gu
                              FROM lprod
                            WHERE lprod_nm = '������ȭ');

-- JOIN
-- CROSS JOIN ������ ���� ��ȸ�ÿ� ��(�׽�Ʈ �ܰ迡��)
-- ��絥���͸� ��ȸ�ϹǷ� �����ɸ��� ������ �ִ�.(n*m)
-- [�Ϲݹ��]
SELECT *
   FROM member,cart, prod, lprod, buyer;

-- [��Ī���̴� ���� ����]
SELECT m.mem_id, c.cart_member, p.prod_id 
   FROM member m, cart c, prod p;

-- [����ǥ�ع��]
SELECT *
   FROM member CROSS JOIN cart 
                         CROSS JOIN prod 
                         CROSS JOIN lprod
                         CROSS JOIN buyer;
                         
-- EQ �Ǵ� INNER JOIN
-- �Ϲ������� ���Ǵ� JOIN
-- N���� Table�� JOIN�ҋ��� �ּ��� n-1���� ���ǽ��� �ʿ��ϴ�.

/* ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ.
    ��ǰ���̺� : prod
    �з����̺� : lprod */
-- [�Ϲݹ��]
SELECT prod.prod_id ��ǰ�ڵ�,
             prod.prod_name ��ǰ��,
             lprod.lprod_nm �з���
   FROM prod, lprod
 WHERE prod.prod_lgu = lprod.lprod_gu;

-- [����ǥ�ع��]
SELECT prod.prod_id, prod.prod_name, lprod.lprod_nm
   FROM prod INNER JOIN lprod
                                ON(prod.prod_lgu = lprod.lprod_gu);

-- Alias�� ����� ���
SELECT A.prod_id ��ǰ�ڵ�,
             A.prod_name ��ǰ��,
             B.lprod_nm �з���,
             C.buyer_name �ŷ�ó��
   FROM prod A, lprod B, buyer C
 WHERE A.prod_lgu = B.lprod_gu
      AND A.prod_buyer = C.buyer_id;

-- [����ǥ�ع������ ��ȯ]
SELECT prod.prod_id,
             prod.prod_name,
             lprod.lprod_nm,
             buyer.buyer_name
   FROM prod INNER JOIN lprod
                          ON(prod.prod_lgu = lprod.lprod_gu)
                    INNER JOIN buyer
                          ON(prod.prod_buyer = buyer.buyer_id);

/* [����]
ȸ���� ������ �ŷ�ó ������ ��ȸ�Ϸ��� �մϴ�.
ȸ�����̵�, ȸ���̸�, ��ǰ�ŷ�ó��,��ǰ�з�����
��ȸ���ּ��� */
/* �⺻������ �Ʒ� �׸��� ���� �� ������ �ۼ��ϸ� ����.
���̺�: buyer, member, prod, lprod
��ȸ��: mem_id, mem_name, buyer_name, lprod_nm
��������: a.mem_id = c.cart_member
             c.cart_prod = d.prod_id
             d.prod_buyer = b.buyer_id
             d.prod_lgu = e.lprod_gu
�Ϲ�����:
��������:
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

-- [����ǥ�ع��]
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
[����]
�ŷ�ó�� '�Ｚ����'�� �ڷῡ ����
��ǰ�ڵ�, ��ǰ��, �ŷ�ó���� ��ȸ�Ϸ��� �մϴ�.
*/

SELECT p.prod_id ��ǰ�ڵ�,
             p.prod_name ��ǰ��,
             b.buyer_name �ŷ�ó��
   FROM prod p, buyer b
 WHERE p.prod_buyer = b.buyer_id
      AND b.buyer_name like '%�Ｚ����%';

-- [����ǥ��]
SELECT p.prod_id ��ǰ�ڵ�,
             p.prod_name ��ǰ��,
             b.buyer_name �ŷ�ó��
   FROM prod p INNER JOIN buyer b
                                ON(p.prod_buyer = b.buyer_id
                                AND b.buyer_name like '%�Ｚ����%');
-- WHERE b.buyer_name like '%�Ｚ����%';

/*[����]
��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó�ּҸ� ��ȸ
1) �ǸŰ����� 10���� �����̰�
2) �ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
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
      AND buyer_add1 like '%�λ�%';

--[����ǥ��]
SELECT  p.prod_id,
             p.prod_name,
             lp.lprod_nm,
             p.prod_sale,
             b.buyer_name,
             b.buyer_add1
   FROM prod p INNER JOIN buyer b
                                ON(prod_buyer = buyer_id
                                AND prod_sale <= 100000
                                AND buyer_add1 like '%�λ�%')
                       INNER JOIN lprod lp
                                ON(prod_lgu = lprod_gu);

/*[����]
��ǰ�з��ڵ尡 P101 �ΰͿ� ����
��ǰ�з���, ��ǰ���̵�, �ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ����� ��ȸ
��, ��ǰ�з����� �������� ��������, ��ǰ���̵� �������� ��������
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

-- [����ǥ��]
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