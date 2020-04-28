grp7)
dept ���̺��� Ȯ���ϸ� �� 4���� �μ� ������ ���� ==> ȸ�系�� �����ϴ� ��� �μ�����
emp ���̺��� �����Ǵ� �������� ���� ���� �μ������� ���� ==> 10,20,30 =>3��
SELECT COUNT(*) cnt
FROM
    (SELECT deptno /*dept �÷��� 1�� ����, row�� 3���� ���̺�*/
    FROM emp
    GROUP BY deptno);

DBMS : DataBase Management System
==> db
RDMBMS : Relational DataBase Management System
==>������ �����ͺ��̽� ���� �ý���

SELECT*
FROM dept;

JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE)

JOIN�� ��� ���̺��� �÷��� ����� �� �ֱ� ������ 
SELECT �Ҽ� �ִ� �÷��� ������ ��������. (����Ȯ��)

NATURAL JOIN 
    - �����Ϸ��� �� ���̺��� ����� �÷��� �̸� �������
    - emp, dept ���̺��� deptno��� �����(������ �̸���, Ÿ�Ե� ����) ����� �÷��� ����
    - �ٸ� ANSI-SQL ������ ���� ��ü�� �����ϰ� , �������̺���� �÷����� �������� ������ 
    ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����.


-emp ���̺� : 14��
-dept ���̺� : 4��

���� �Ϸ����ϴ� �÷��� ���� ������� ����.
SELECT*
FROM emp NATURAL JOIN dept;
�����̺��� �̸��� ������ �÷����� �����Ѵ�.

ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
����Ŭ ���� ����
1. ������ ���̺� ����� from ���� ����ϸ� �����ڴ� �ݷ�(,)
2. ����� ������ WHERE���� ����ϸ� �ȴ�. (ex : WHERE emp.deptno = dept.deptno)

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;
    
deptno�� 10���� �����鸸 ��ȸ 
SELECT*
FROM emp, dept
WHERE emp.deptno = dept.deptno
    AND dept.deptno = 10;

ANSI-SQL : JOIN with USING
 - JOIN �Ϸ��� ���̺� �̸��� ���� �÷��� 2�� �̻��� ��
 - �����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���
 
 SELECT*
 FROM emp JOIN dept USING (deptno);
 
 ANSI-SQL : JOIN with ON
 - �����Ϸ��� �� ���̺� �÷����� �ٸ���
 - ON���� ����� ������ ���
 
 SELECT *
 FROM emp JOIN dept ON(emp.deptno = dept.deptno);


ORACLE �������� �� SQL�� �ۼ�

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

JOIN�� ������ ����
SELF JOIN : �����Ϸ��� ���̺��� ���� ���� ��
EMP ���̺��� ������ ������ ������ ��Ÿ���� ������ ������ mgr �÷��� �ش� ������ ������ ����� ����.
�ش� ������ �������� �̸��� �˰� ���� �� 

ANSI-SQL ���� : �����Ϸ��� �ϴ� ���̺� EMP(����), EMP(������ ������)
        ����� �÷�: ����.mgr = ������.empno
            ==>���� �÷� �̸��� �ٸ��� (mgr, emptno)
                ==> NATURAL JOIN, JOIN with�� ��� �Ұ�
                =>JOIN with ON
                    
SELECT *
FROM emp;
 
SELECT *
FROM emp e JOIN emp m ON(e.mgr = m.empno);

NOT EQUAL JOIN :����� ������ =�� �ƴҶ�

�׵��� WHERE���� ����� ������ : =, !=, <>, <=, <, >, >=
                            AND, OR, NOT
                            LIKE %,_
                            OR - IN
                            BETWEEN AND ==> >=, <=

SELECT*
FROM salgrade;

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

==> ORACLE ���� �������� ����

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade 
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

�ǽ�0
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;

SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
ORDER BY deptno;

�ǽ�1
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
    AND dept.deptno IN(10,30);

SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE dept.deptno IN(10,30);

�ǽ�2
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
    AND emp.sal > 2500
    ORDER BY sal DESC;

SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.sal > 2500
ORDER BY sal DESC;

�ǽ�3
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
    AND emp.sal > 2500
    AND emp.empno > 7600
    ORDER BY sal DESC;

SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.sal > 2500
 AND emp.empno > 7600
ORDER BY sal DESC;

�ǽ�4
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
    AND emp.sal > 2500
    AND emp.empno > 7600
    AND dept.dname = 'RESEARCH'
    ORDER BY sal DESC;

SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.sal > 2500
 AND emp.empno > 7600
 AND dept.dname = 'RESEARCH'
ORDER BY sal DESC;

base_table �ǽ�1
SELECT e.lprod_gu, e.lprod_nm, n.prod_id, n.prod_name
FROM lprod e JOIN prod n ON(n.prod_lgu = e.lprod_gu);

SELECT e.lprod_gu, e.lprod_nm, n.prod_id, n.prod_name
FROM lprod e, prod n
WHERE n.PROD_LGU = e.LPROD_GU;

base_table �ǽ�2
SELECT B.buyer_id,B.buyer_name,P.prod_id,P.prod_name
FROM buyer B,prod P
WHERE B.buyer_lgu = P.prod_lgu
ORDER BY buyer_id;


SELECT buyer_id,buyer_name,prod_id,prod_name
FROM buyer JOIN prod ON(buyer_lgu = prod_lgu)
ORDER BY buyer_id;

select count(*)
from
    (SELECT COUNT(*)
    FROM buyer, prod
    WHERE prod.prod_buyer = buyer.buyer_id);



base_table �ǽ�3
SELECT M.mem_id, M.mem_name, P.prod_id, P.prod_name, C.cart_qty
FROM member M, prod P, cart C
WHERE M.MEM_ID = C.CART_MEMBER
    AND C.CART_PROD = P.PROD_ID;


SELECT M.mem_id, M.mem_name, P.prod_id, P.prod_name, C.cart_qty
FROM member M JOIN cart C ON(M.MEM_ID = C.CART_MEMBER) 
                JOIN prod P ON(C.CART_PROD = P.PROD_ID);

�������
SELECT *
FROM
    (SELECT deptno, COUNT(*)
    FROM emp
    GROUP BY deptno)
WHERE deptno =30;

cid : customer id
cnm : customer name
SELECT*
FROM customer;

pid : product id
pnm : product name

SELECT*
FROM product;

cycle : �����ֱ�
cid : ��id
pid : ��ǰid
day : ��������(�Ͽ��� , ��, ȭ, ��, ��, ��)
cnt : ����

SELECT*
FROM cycle;

�ǽ�4
SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer , cycle 
WHERE customer.cid=cycle.cid
AND CNM IN('brown', 'sally');

SELECT cid, cnm, pid, day, cnt
FROM customer NATURAL JOIN cycle 
WHERE customer.cnm IN('brown', 'sally');


�ǽ�5
SELECT customer.cid, customer.cnm, product.pnm, cycle.pid, cycle.day, cycle.cnt
FROM customer , cycle ,product
WHERE customer.cid=cycle.cid
AND cycle.pid = product.pid
AND CNM IN('brown', 'sally');


�ǽ�6
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, sum(cycle.cnt)
FROM customer , cycle , product
WHERE customer.cid=cycle.cid
AND cycle.pid = product.pid
AND CNM IN('brown', 'sally','cony')
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm;

�ǽ�7
SELECT cycle.pid, product.pnm,sum(cycle.cnt)
FROM cycle , product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, product.pnm;

�ǽ�8
SELECT REGION_ID, REGION_NAME, COUNTRY_NAME
FROM countries, regions
WHERE countries = regions;

SELECT*
FROM regions;
SELECT*
FROM countries;


SELECT*
FROM emp
WHERE TO_CHAR(hiredate,'YYYYMMDD')
	BETWEEN '19800101' AND '19821231';

