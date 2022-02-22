-- 3�� ����
/*
1. ��ö�� �� ���� �� TV �� ���峪�� ��ȯ�������� �Ѵ�
��ȯ�������� �ŷ�ó ��ȭ��ȣ�� �̿��ؾ� �Ѵ�.
����ó�� ��ȭ��ȣ�� ��ȸ�Ͻÿ�.
*/
SELECT buyer_name �ŷ�ó��,
             buyer_comtel ��ȭ��ȣ
   FROM buyer
 WHERE buyer_id IN (SELECT prod_buyer
                                 FROM prod
                               WHERE prod_name like '%TV%'
                                    AND prod_id IN (SELECT cart_prod
                                                             FROM cart
                                                            WHERE cart_member IN (SELECT mem_id
                                                                                                 FROM member
                                                                                                WHERE mem_name = '��ö��')));

/*
2. ������ ��� 73�����Ŀ� �¾ �ֺε��� 2005�� 4���� ������ ��ǰ�� ��ȸ�ϰ�, 
�׻�ǰ�� �ŷ��ϴ� ���ŷ�ó�� ���� ������ ���¹�ȣ�� �����ÿ�.
(��, �����-���¹�ȣ).*/
SELECT (buyer_bank||' '||buyer_bankno) ���¹�ȣ
   FROM buyer
 WHERE buyer_id IN (SELECT prod_buyer 
                                 FROM prod
                               WHERE prod_id IN (SELECT cart_prod 
                                                            FROM cart
                                                          WHERE SUBSTR(cart_no,5,2) = '04'
                                                               AND cart_member IN (SELECT mem_id
                                                                                                FROM member
                                                                                             WHERE mem_job = '�ֺ�'
                                                                                                  AND SUBSTR(mem_regno1,1,2) >= '73'
                                                                                                  AND SUBSTR(MEM_ADD1,1,2)='����')));
/*
3. ������ ������ ȸ���� �� 5���̻� ������ ȸ���� 4�����Ϸ� ������ ȸ������ ������ �������� �ٸ� ������ ������ �����̴�. 
ȸ������ ����Ƚ���� ����  ������������ �����ϰ�  ȸ������ ȸ��id�� ��ȭ��ȣ(HP)�� ��ȸ�϶�.
*/
SELECT mem_id ȸ��ID,
             mem_hp ȸ����ȭ��ȣ,
             (SELECT SUM(cart_qty) ����Ƚ��
                 FROM cart
               WHERE cart_member = member.mem_id) cart_qty
   FROM MEMBER 
 ORDER BY cart_qty ASC ;

-- 4�� ����
/*
�輺���� �ֹ��ߴ� ��ǰ�� ����� �����Ǿ� �Ҹ��̴�.
����ó�� ������ ���, ��ǰ ���޿� ������ ���� ����� �ʾ����ٴ� �亯�� �޾Ҵ�.
�輺���� �ش� ��ǰ�� ���� ����ڿ��� ���� ��ȭ�Ͽ� �����ϰ� �ʹ�.
� ��ȣ�� ��ȭ�ؾ� �ϴ°�?*/
SELECT buyer_charger �����, 
             buyer_comtel ��ȭ��ȣ
   FROM buyer
 WHERE buyer_id IN (SELECT prod_buyer
                                 FROM prod
                               WHERE prod_id IN (SELECT cart_prod
                                                              FROM cart
                                                            WHERE cart_member IN (SELECT mem_id
                                                                                                 FROM member
                                                                                                WHERE mem_name = '�輺��'))); 

/*���� �� Ÿ������ ��� ��ȯ������ ����ϴ� �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� ������ ȸ������ �̸�, ������ ��ȸ �ϸ� 
�̸��� '��'�� �����ϴ� ȸ�������� '��' �� ġȯ�ؼ� ����ض� */
SELECT REPLACE(SUBSTR(mem_name,1,1),'��','��')||SUBSTR(mem_name,2,2) ȸ���̸�,  
             mem_bir ����
   FROM member
 WHERE mem_id IN (SELECT cart_member 
                                FROM cart
                              WHERE cart_prod IN (SELECT prod_id 
                                                               FROM prod
                                                             WHERE prod_buyer IN (SELECT buyer_id
                                                                                                FROM buyer
                                                                                               WHERE buyer_bank = '��ȯ����'
                                                                                                    AND buyer_add1 not like '����%')));

/*¦�� �޿� ���ŵ� ��ǰ�� �� ��Ź ���ǰ� �ʿ� ���� ��ǰ���� ID, �̸�, �Ǹ� ������ ����Ͻÿ�.
���� ��� �� ������ ���� ���� ���� 10�ۼ�Ʈ ���ϵ� ������, ���� ���� ���� 10�ۼ�Ʈ �߰��� ������ ����Ͻÿ�.
������ ID, �̸� ������ �����Ͻÿ�.
(��, ������ �Һ��ڰ� - ���԰��� ����Ѵ�.)*/
SELECT m.id,
             m.name,
             CASE m.prod_m
             WHEN (SELECT max(m.prod_m) FROM m)
                THEN m.prod_m*0.9
             WHEN (SELECT min(m.prod_m) FROM m)
                THEN m.prod_m*1.1
             ELSE m.prod_m
             END ����
   FROM (SELECT prod_id id, prod_name name,(prod_price - prod_cost) prod_m FROM prod
                            WHERE prod_delivery != '��Ź ����'
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
              Where prod_delivery not like '%��Ź ����%'
                And prod_id In(
             Select cart_prod
               From cart
              Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12)))
       then (prod_price - prod_cost) * 0.9
       when (Select min(prod_price - prod_cost) 
               From prod 
              Where prod_delivery not like '%��Ź ����%'
                And prod_id In(
             Select cart_prod
              From cart
             Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12)))
       then (prod_price - prod_cost) * 1.1
       else prod_price - prod_cost end as ����
  From prod
 Where prod_delivery not like '%��Ź ����%'
   And prod_id In(
           Select cart_prod
             From cart
            Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12))
 Group By prod_id, prod_name, prod_price - prod_cost; */
 
 /*
ȸ�� �̸��� ȸ���� �� ���� �ݾ��� ��ȸ�Ͽ� ������������ �����Ͻÿ�.
�� ���� �ݾ��� õ ������ ���� ��ȭ ǥ�ø� �տ� �ٿ� ����Ͻÿ�.
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