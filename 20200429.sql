OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ���
<===>  INNER JOIN [�츮�� ���ݱ��� ��� ���]

LEFT OUTER JOIN : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
FULL OUTER JOIN : LEFT OUTER JOIN + RIGHT OUTER JOIN - [�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��]

emp ���̺��� �÷��� mgr�÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������ KING ������ ��� ����ڰ� ���� ������ �Ϲ����� inner ���� ó���� ���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ�� ��.

INNER ���� ����
����� ���, ����� �̸�, ���� ���, ���� �̸�

������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�.
==> KING�� ����� ����(mgr)�� null�̱� ������ ���ο� �÷����ϰ� 
    KING�� ������ ������ �ʴ´�. (emp ���̺� �Ǽ� 14�� ���ΰ�� 13��)
    
SELECT m.empno,  m.ename,e.empno,e.ename
FROM emp e, emp m
WHERE  e.mgr = m.empno;

SELECT m.empno,  m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

���� ������ OUTER �������� ����
KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������, 
������ ����� ������ ���� ������ ������ �ʴ´� .
ANSI-SQL : OUTER
SELECT m.empno,  m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);
//���� ���̺� 
SELECT m.empno,  m.ename, e.empno, e.ename
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno);

ORACLE-SQL : OUTER
oracle join
1. FROM���� ������ ���̺� ���(�޸��� ����)
2. WHERE���� ���� ������ ���
3. ���� �÷�(���� ��)�� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ� �ش�.
  ==> ������ ���̺� �ݴ����� ���̺��� �÷�
  
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e ,emp m 
WHERE e.mgr(+) = m.empno;

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e ,emp m 
WHERE e.mgr = m.empno(+);

OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 ����;

������ ON���� ������� ��
SELECT m.empno,  m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND e.deptno=10);

������ WHERE���� ������� ��
SELECT m.empno,  m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE e.deptno=10;

OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ°� �´� . 

SELECT m.empno,  m.ename, e.empno, e.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
    AND e.deptno=10;    
    
SELECT m.empno,  m.ename, e.empno, e.ename
FROM emp e, emp m 
WHERE e.mgr(+) = m.empno
    AND e.deptno=10;
    
SELECT *
FROM buyprod 
WHERE buy_date = TO_DATE('2005/01/25','YYYY/MM/DD');

SELECT*
FROM prod;


�ǽ�1
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod ON(prod.prod_id = buyprod.buy_prod AND buy_date = TO_DATE('2005/01/25','YYYY/MM/DD'));

�ǽ�2
SELECT TO_DATE('2005/01/25','YYYY/MM/DD') BUY_DATE, buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod 
ON(prod.prod_id = buyprod.buy_prod 
AND buy_date = TO_DATE('2005/01/25','YYYY/MM/DD'));

�ǽ�3
SELECT TO_DATE('2005/01/25','YYYY/MM/DD') BUY_DATE, buy_prod, prod_id, prod_name, nvl(buy_qty,0)
FROM prod LEFT OUTER JOIN buyprod 
ON(prod.prod_id = buyprod.buy_prod 
AND buy_date = TO_DATE('2005/01/25','YYYY/MM/DD'));


SELECT*
FROM cycle;
SELECT*
FROM product;
SELECT*
FROM customer;
�ǽ�4
SELECT p.pid, p.pnm, nvl(c.cid,1), nvl(c.day,0), nvl(c.cnt,0)
FROM product p LEFT OUTER JOIN cycle c ON(p.pid = c.pid AND c.cid = 1);

�ǽ�5
ansi ����
SELECT*
FROM
(SELECT p.pid, p.pnm, nvl(c.cid,1), nvl(c.day,0), nvl(c.cnt,0)
        FROM product p LEFT OUTER JOIN cycle c ON(p.pid = c.pid AND c.cid = 1))
        JOIN customer s ON(a.pid = s.pid AND s.cnm='brown');

oracle ����
SELECT p.pid, p.pnm, nvl(c.cid,1)cid,s.cnm, nvl(c.day,0)day, nvl(c.cnt,0)cnt
FROM product p, cycle c , customer S
WHERE p.pid = c.pid(+)
AND s.cnm = 'brown'
AND c.cid(+) = 1
ORDER BY p.pid DESC;

15===>45
3�� ==> customer ���̺��� ��� ����

SELECT*
FROM product, cycle, customer
WHERE product.pid = cycle.pid;

CROSS JOIN
���� ������ ������� ���� ���
��� ������ ���� �������� ����� ��ȸ�ȴ�.

(emp = 14) * (dept = 4) = 56
ANSI-SQL
SELECT*
FROM emp CROSS JOIN dept;

oracle-sql
SELECT*
FROM emp, dept;


�ǽ�1
SELECT*
FROM customer,product;

SELECT*
FROM customer CROSS JOIN product;

�������� 
WHERE : ������ �����ϴ� �ุ ��ȸ�ǵ��� ����

SELECT*
FROM emp
WHERE 1 = 1
    OR 1 != 1;

    1 = 1 OR 1 != 1

���� <==> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
�������� ������ ��ġ 
1. SELECT
    SCALAR SUB QUERY
    * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̾�� �Ѵ�. 
    EX> DUAL���̺�
2. FROM
    INLINE-VIEW
    SELECT ������ ��ȣ�� ���� ��
    
3. WHERE
    SUB QUERY
    WHERE ���� ���� ����
    
    
    
SMITH�� ���� �μ��� ���� �������� ���� ������?

1. SMITH�� ���� �μ��� �������?
2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ

==> �������� 2���� ������ ���� ����
    �ι�° ������ ù��°�� ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�. 
    (SMITH(20) => WARD(30) ==> �ι�° ���� �ۼ��� 20������ 30������ ������ ����
    ==> �������� ���鿡�� ����.)
ù���� ����;
SELECT*
FROM emp 
WHERE ename = 'SMITH';

�ι�° ���� ;
SELECT*
FROM emp
WHERE deptno =20;

���� ������ ���� ���� ����;
SELECT*
FROM emp
WHERE deptno =(SELECT deptno    --20
                FROM emp 
                WHERE ename = :ename);
                
//��� �޿����� ���� �޿��� �޴� ������ ���� ��ȸ�ϼ���

��ձ޿�
SELECT ROUND(AVG(sal),2)
FROM emp;

�ǽ�1
SELECT COUNT(*)
FROM emp
WHERE sal >(SELECT ROUND(AVG(sal),2)
            FROM emp);
�ǽ�2
SELECT *
FROM emp
WHERE sal >(SELECT ROUND(AVG(sal),2)
            FROM emp);

�ǽ�3
SELECT*
FROM emp
WHERE deptno=(
                SELECT *
             FROM emp
             WHERE ename IN ('SMITH','WARD'));

