/* 5�� ���� Ǯ���
1. ��ǰ�з����� '����ĳ�־�'�̸鼭 ��ǰ�̸��� '����'�� ���� ��ǰ�̰�,
���Լ����� 30���̻��̸鼭 6���� �԰��� ��ǰ�� ���ϸ����� �ǸŰ��� ����
���� ��ȸ�Ͻÿ�
Alias �̸�, �ǸŰ���, �ǸŰ���+���ϸ���
*/
SELECT prod_name ��ǰ��,
             prod_sale �ǸŰ���,
             prod_sale + NVL(prod_mileage,0) ���ϸ���New
   FROM prod
 WHERE prod_lgu IN (SELECT lprod_gu
                                 FROM lprod
                                WHERE lprod_nm = '����ĳ�־�')
      AND prod_name like '%����%'
      AND prod_id IN (SELECT buy_prod
                                FROM buyprod
                              WHERE buy_qty >= 30
                                   AND EXTRACT(month FROM buy_date) = 6);
-- JOIN���� Ǯ��
SELECT p.prod_name ��ǰ��,
             p.prod_sale �ǸŰ���,
             p.prod_sale+NVL(p.prod_mileage,0) ���ϸ���New
   FROM prod p, lprod lp, buyprod bp
 WHERE prod_lgu = lprod_gu
      AND lprod_nm = '����ĳ�־�'
      AND prod_id = buy_prod
      AND buy_qty >= 30
      AND  EXTRACT(month FROM buy_date) = 6
      AND prod_name like '%����%';

/* 2. �ŷ�ó �ڵ尡 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
��ǰ ������� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ ���Դܰ��� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ����� 2500�̻��̸� ���ȸ�� �ƴϸ� �Ϲ�ȸ������ ����϶�
�÷� ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
*/
SELECT mem_name ȸ���̸�,
             mem_mileage ���ϸ���,
             CASE 
                    WHEN mem_mileage >= 2500 
                        THEN '���ȸ��'
                    ELSE '�Ϲ�ȸ��' 
             END ȸ�����
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

-- JOIN���� Ǯ��
SELECT m.mem_name ȸ���̸�,
             m.mem_mileage ���ϸ���,
             CASE
                  WHEN m.mem_mileage >= 2500
                    THEN '���ȸ��'
                   ELSE '�Ϲ�ȸ��'
             END ȸ�����
   FROM member m, cart c, prod p, buyer b
 WHERE m.mem_id = c.cart_member
      AND c.cart_prod = p.prod_id
      AND p.prod_buyer = b.buyer_id
      AND b.buyer_id Like 'P20%'
      AND p.prod_insdate >= '05/02/01'
      AND p.prod_cost >= 200000;

/* 3. 6���� ����(5���ޱ���)�� �԰�� ��ǰ �߿� 
���Ư������� '��Ź ����'�̸鼭 ������ null���� ��ǰ�� �߿� 
�Ǹŷ��� ��ǰ �Ǹŷ��� ��պ��� ���� �ȸ��� ������
�达 ���� ���� �մ��� �̸��� ���� ���ϸ����� ���ϰ� ������ ����Ͻÿ�
Alias �̸�, ���� ���ϸ���, ����
*/
SELECT mem_name �̸�,
             mem_mileage ���ϸ���,
             DECODE(SUBSTR(mem_regno2,1,1),1 ,'����','����') ����
   FROM member
 WHERE mem_name like '��%'
      AND mem_id IN (SELECT cart_member
                                FROM cart
                              WHERE cart_qty >= (SELECT AVG(cart_qty)
                                                          FROM cart)    
                                   AND cart_prod IN(SELECT prod_id
                                                              FROM prod
                                                            WHERE prod_delivery = '��Ź ����'
                                                                 AND prod_color is NULL                                                   
                                                                 AND prod_id IN(SELECT buy_prod
                                                                                         FROM buyprod
                                                                                       WHERE EXTRACT(month from buy_date) < 6)));
                                                                                       
-- JOIN���� Ǯ��
SELECT m.mem_name �̸�,
             m.mem_mileage ���ϸ���,
             DECODE(SUBSTR(m.mem_regno2,1,1),1 ,'����','����') ����
   FROM member m, cart c, prod p, buyprod bp
 WHERE mem_id = cart_member
      AND cart_prod = prod_id
      AND prod_id = buy_prod
      AND mem_name like '��%'
      AND cart_qty >= (SELECT AVG(cart_qty) FROM cart)
      AND prod_delivery = '��Ź ����'
      AND prod_color is NULL
      AND EXTRACT(month from buy_date) < 6;
      
/* 1�� ���� Ǯ���
[���� �����]
��ǰ �� ������������ �󵵼��� 
���� ���� ��ǰ�� ������ ȸ�� �� �ڿ��� �ƴ� ȸ���� id�� name
*/
SELECT mem_id ȸ��iD,
             mem_name �̸�
   FROM member
 WHERE not mem_job = '�ڿ���'
      AND mem_id IN (SELECT cart_member
                                FROM cart
                              WHERE cart_prod IN(SELECT prod_id
                                                              FROM prod
                                                             WHERE;

SELECT  prod_name, prod_properstock, COUNT(prod_properstock) 
   FROM prod
 GROUP BY prod_name, prod_properstock;
/*
[���� �����]
��޻�ǰ�ڵ尡 'P1'�̰� '��õ'�� ��� ���� ������� ��ǰ�� ������ 
ȸ���� ��ȥ������� 8������ �ƴϸ鼭 
��ո��ϸ���(�Ҽ���°�ڸ�����) �̸��̸鼭 
�����Ͽ� ù��°�� ������ ȸ���� 
ȸ��ID, ȸ���̸�, ȸ�����ϸ����� �˻��Ͻÿ�.  
*/
SELECT mem_id ȸ��ID,
             mem_name ȸ���̸�,
             ROUND(mem_mileage,2) ȸ�����ϸ���
   FROM member
 WHERE mem_mileage < (SELECT AVG(mem_mileage)
                                            FROM member)
      AND mem_memorial = '��ȥ�����'
      AND EXTRACT(month FROM mem_memorialday) not 8
      AND mem_add1 like '%��õ%'
      AND mem_id IN (SELECT cart_member
                                FROM cart
                              WHERE cart_no = (SELECT min(cart_no) (max(cart_no) + 1) �߰��ֹ���ȣ 
                                   AND cart_prod IN (SELECT prod_id
                                                                FROM prod
                                                             WHERE prod_buyer IN(SELECT buyer_id
                                                                                                FROM buyer
                                                                                              WHERE buyer_lgu ='P1%')))

/*
[���� �����]
�ּ����� ������ �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� 
�������� ���� ���� ���� ȸ�� �߿� 12���� ��ȥ������� �ִ�
ȸ�� ���̵�, ȸ�� �̸� ��ȸ 
�̸� �������� ���� 
*/


/*
[���� �����]
��ǻ����ǰ�� �ְ��ϸ� ������(����,��õ)�� ��� �ּҿ� '��' �� �� ���� ��� ����ڰ� ����ϴ�
��ǰ �߿��� �ǸŰ����� ��ü�ǸŰ��� �̻��� ��ǰ�� ������ ȸ������ ��� ��(����)��  �з��ϰ�
������ ȸ������ �����ϴ� ����Ϻ� ���� ���� ������� ������� �˾Ƴ��ÿ�
--����: ������
--�泲, ���� : ��û�� �������� ���
*/