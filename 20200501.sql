�Ѱ��� ��, �ϳ��� �÷��� �����ϴ� �������� 
ex : ��ü ������ �޿� ���, SMITH ������ ���� �μ��� �μ���ȣ

WHERE���� ��밡���� ������
WHERE deptno = 10
==> 

�μ���ȣ�� 10 Ȥ�� 30���� ���
WHERE deptno IN (10, 30)
WHERE deptno = 10 OR deptno = 30

WHERE deptno = (10,30) < ����

������ ������
�������� ��ȸ�ϴ� ���������� ��� = �����ڸ� ���Ұ�
WHERE deptno IN (�������� ���� �����ϰ�, �ϳ��� �÷����� �̷���� ���� )

SMITH - 20, ALLEN�� 30�� �μ��� ����

SMITH �Ǵ� ALLEN�� ���ϴ� �μ��� ������ ������ ��ȸ

���� ��������, �÷��� �ϳ���
==> ������������ ��밡���� ������ IN(���� ��, �߿�),(ANY,ALL, �󵵰� ����)
IN : ���������� ������� ������ ���� ���� �� TRUE
WHERE �÷�|ǥ���� IN (��������)

ANY : �����ڸ� �����ϴ� ���� �ϳ��� ���� �� TRUE
    WHERE �÷�|ǥ���� ������ ANY (��������)

ALL : ���������� ��� ���� �����ڸ� ������ �� TRUE
    WHERE �÷�|ǥ���� ������ ALL (��������)

SMITH�� ALLEN�� ���� �μ����� �ٹ��ϴ� ��� ������ ��ȸ

1. ���������� ������� ���� ��� : �ΰ��� ������ ����
1-1. SMITH, ALLEN�� ���� �μ��� �μ���ȣ�� Ȯ���ϴ� ���� 
20,30
SELECT*
FROM emp
WHERE ename IN ('SMITH','ALLEN');
1-2. 1-1���� ���� �μ���ȣ�� IN���긦 ���� �ش� �μ��� ���ϴ� �������� ��ȸ
SELECT*
FROM emp
WHERE deptno IN (20,30);
==> ���� ������ �̿��ϸ� �ϳ��� SQL���� ���డ��
SELECT*
FROM emp
WHERE deptno IN(SELECT deptno
            FROM emp
            WHERE ename IN ('SMITH','ALLEN'));
            
�ǽ�3
SELECT*
FROM emp
WHERE deptno IN(SELECT deptno
            FROM emp
            WHERE ename IN ('SMITH','WARD'));
ANY, ALL
SMITH�� WARD �λ���� �޿��� �ƹ� ���̳� ���� �޿��� �޴� ���� ��ȸ

SELECT*
FROM emp
WHERE sal < ANY (SELECT sal
            FROM emp
            WHERE ename = 'SMITH'
            OR ename = 'WARD');

SMITH�� WARD �λ���� �޿����� ���� �޿��� �޴� ������ȸ
SELECT*
FROM emp
WHERE sal > ALL (SELECT sal
            FROM emp
            WHERE ename = 'SMITH'
            OR ename = 'WARD');
IN �������� ����
�ҼӺμ��� 20, Ȥ�� 30�� ���
WHERE deptno IN (20,30)

�ҼӺμ��� 20, 30�� ������ �ʴ� ���
WHERE deptno NOT IN(20,30)
NOT IN �����ڸ� ����� ��� ���� ������ ���� NULL�� �ִ��� ���ΰ� �߿�
�Ʒ� ������ ��ȸ�ϴ� ����� � �ǹ��ΰ�? [mgr�� ������ �ʴ� empno�� ��ȸ]
NULL���� ������ ���� ����
SELECT*
FROM emp
WHERE empno NOT IN(SELECT mgr 
                    FROM emp
                    WHERE mgr IS NOT NULL);

null ó�� �Լ��� ���� ������ ������ ���� �ʴ� ������ ġȯ
SELECT*
FROM emp
WHERE empno NOT IN(SELECT NVL(mgr,-1) 
                    FROM emp);

���� �÷��� �����ϴ� ���������� ���� ���� ==> ���� �÷��� �����ϴ� �������� 
PAIRWISE ���� (������) ==> ���ÿ� ����

SELECT mgr, deptno
FROM emp
WHERE empno IN (7499, 7782); WHERE empno = 7499;

7499, 7782����� ������ ���� �μ�, ���� �Ŵ����� ��� ���� ���� ��ȸ 
�Ŵ����� 7698�̸鼭 �Ҽ� �μ��� 30���ΰ��
�Ŵ����� 7839�̸鼭 �Ҽ� �μ��� 10���ΰ��
(7698,30)
(7839,10)
mgr �÷��� deptno�÷��� �������� ���� 
(mge, deptno)
(7698,10)
(7698,30)
(7839,10)
(7839,30);
SELECT*
FROM emp
WHERE mgr IN (7698,7839)
    AND deptno IN (10,30);
    
    
PAIRWISE ���� (���� �������� ����� �Ѱ� ����)
SELECT*
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499,7782));


�������� ����- �����ġ 
SELECT - ��Į�� ���� ���� 
FROM - �ζ��� �� 
WHERE - ��������


�������� ���� - ��ȯ�ϴ� ��, �÷��� �� 
���� ��
    ���� �÷�(��Į�� ���� ����)
    ���� �÷�
���� ��
    ���� �÷�(���� ���� ����)
    ���� �÷�

��Į�� ���� ���� 
SELECT ���� ǥ���Ǵ� �������� 
������ ���� �÷��� �����ϴ� ���������� ��� ����
���� ������ �ϳ��� �÷�ó�� �ν�;

SELECT 'x', (SELECT SYSDATE FROM dual)
FROM dual;

��Į�� ���� ������ �ϳ��� ��, �ϳ��� �÷��� ��ȯ �ؾ��Ѵ�. 
���� �ϳ����� �÷��� 2������ ����
SELECT 'x', (SELECT empno, ename FROM emp WHERE empno='SMITH')
FROM dual;

������ �ϳ��� �÷��� �����ϴ� ��Į�� �������� ==> ����
SELECT 'x', (SELECT empno FROM emp)
FROM dual;

emp ���̺� ����� ��� �ش� ������ �Ҽ� �μ� �̸��� �� ���� ����. ==> JOIN
Ư�� �μ��� �μ� �̸��� ��ȸ�ϴ� ���� 
SELECT dname
FROM dept
WHERE deptno = 10;

�� ������ ��Į�� ���������� ����

join���� ����
SELECT empno, ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT empno, ename, emp.deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno )
FROM emp;

�������� ���� - ���������� �÷��� ������������ ����ϴ��� ���ο� ���� ����
��ȣ���� ��������(corelated sub query)
    .���� ������ ���� �Ǿ�� ���� ������ ������ ����
    
���ȣ ���� ��������(non corelated sub query)
    .main ������ ���̺��� ���� ��ȸ �� ���� �ְ�
    sub ������ ���̺��� ���� ��ȸ �� ���� �ִ�. 
    ==> ����Ŭ�� �Ǵ������� ���ɻ� ������ �������� ���� ������ ����
��� ������ �޿� ��պ��� ���� �޿��� �޴� ���� ����
SELECT*
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
�����غ� ����, ���� ������ ��ȣ ���� ���� �����ΰ�? ���ȣ ���� ���� �����ΰ�?


������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴� ����
��ü ������ �޿� ��� ==> ������ ���� �μ��� �޿� ���
Ư�� �μ�(10)�� ��� ������ ���ϴ� SQL
SELECT AVG(sal)
FROM emp
WHERE deptno =10;

SELECT*
FROM emp e
WHERE sal > (SELECT AVG(sal)
            FROM emp
            WHERE deptno = e.DEPTNO);

INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
emp ���̺� ��ϵ� �������� (10,20,30)�� �μ����� �Ҽ��� �Ǿ�����
���� �Ҽӵ��� ���� �μ�: 40,99
�ǽ�4
SELECT*
FROM dept d
WHERE deptno NOT IN(SELECT deptno
                FROM emp
                WHERE deptno = d.deptno); 
���������� �̿��Ͽ� IN�����ڸ� ���� ��ġ�ϴ� ���� �ִ��� ������ ��
���� ������ �־ ��� ����(����)

�ǽ�5
SELECT*              
FROM product
WHERE pid NOT IN(SELECT pid
                FROM cycle
                WHERE cid = 1);
�ǽ�6                
SELECT*
FROM cycle
WHERE cid = 1 
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2);

�ǽ�7
��Į�� ���������� �̿��� ���
SELECT cid,(SELECT cnm FROM customer WHERE cid = cycle.cid) cnm,
        pid,(SELECT pnm FROM product WHERE pid = cycle.pid) pnm, day, cnt
FROM cycle
WHERE cid = 1 
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2);

������ �̿��� ���
SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.cid = customer.cid
AND cycle.pid = product.pid
AND cycle.pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2);


SELECT cc.cid,cc.cnm, p.pnm,c.pid, c.day, c.cnt
FROM cycle c, customer cc, product p
WHERE c.cid = 1 
AND c.cid = cc.cid
AND c.pid = p.pid
AND c.pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2);