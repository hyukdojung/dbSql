SELECT ���� ����:
 ��¥ ���� : ��¥ + ���� , -����, ��¥���� +-������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ 
 ���� ���� : �����ð��� �ٷ��� ����
  ���ͷ�: ǥ����
        ���� ���ͷ� : ���� ǥ��
        ���� ���ͷ� : java: "���ڿ�" / sql : 'sql'
        SELECT SELECT * FROM  ||table_name
        SELECT 'SELECT * FROM ' ||table_name
        
    ���ڿ� ���տ��� : +�� �ƴ϶� || (java������ +)
    ��¥ : TO_DATE('��¥ ���ڿ�', '��¥ ���ڿ��� ���� ����')
        TO_DATE('20200417', 'yyyymmdd')
        
        
WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ �ǵ��� ����
;

SELECT *
FROM users
WHERE 1=1;

SELECT *
FROM users
WHERE userid = 'brown';
/*sal ���� 1000 ���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==> BETWEEN AND
���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �������� ���� 
*/

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;


SELECT
    *
FROM emp
WHERE sal >= 1000 and sal <= 2000;



SELECT
    *
FROM emp
WHERE sal >= 1000
  AND sal <= 2000;
  

exclusive or (��Ÿ�� or)
a or b
���� �ϳ��� ���̿����Ѵ�

SELECT ename, hiredate
FROM emp
WHERE hiredate >= '1982/01/01'
  AND hiredate <= '1983/01/01';
  
  

IN ������ 
�ķ�|Ư���� IN (��1, ��2 , ......)
�÷��̳� Ư������ ��ȣ�ȿ� ���߿� �ϳ��� ��ġ�� �ϸ� true
;

.


SELECT *
FROM emp
WHERE deptno IN (10,30);
==> deptno�� 10�̰ų� 30���� ����
deptno = 10 or deptno = 30

SELECT * 
FROM emp
WHERE deptno = 10
or deptno = 30;


SELECT userid "���̵�", usernm "�̸�", alias "����" 
FROM users
WHERE userid IN('brown','cony','sally');

SELECT 
FROM
WHERE 
ALIAS
IN

���ڿ� ��Ī ����  : LIKE ���� / JAVA: . startsWiht(prefix), .endWith(suffix)
����ŷ ���ڿ� : % - ��� ���ڿ� (���� ����) 
                _ -� ���ڿ��̵��� �� �ϳ��� ���� 
���ڿ��� �Ϻΰ� ������ true


'cony' : cony�� ���ڿ�
'co%': ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵� �� �� �ִ�. 
 'co''con' 'cony'
 '%co%': co�� �����ϴ� ���ڿ�
 'cony' 'sally cony'
 
 'co__' : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ�
 '_on_' : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ��̵��� �ϳ��� ���ڰ� �ü� �ִ� ���ڿ�
 
 �÷� Ư���� LIKE ���� ���ڿ�; 
 ���� �̸�(ename)�� �빮�� s�� �����ϴ� ������ ��ȸ ;
 
 SELECT*
 FROM emp
 WHERE ename LIKE 'S%';
 
 member ���̺��� ȸ���� ���� �ž��� ����� mem_id, mem_name �� ��ȸ�ϴ� ����
 
 SELECT mem_id, mem_name
 FROM member
 WHERE mem_name LIKE '��%';
 
 
 SELECT mem_id, mem_name
 FROM member
 WHERE mem_name LIKE '%��%';
 
 
 NULL ��
 SQL �񱳿����� : = 
 
 MGR�÷� ���� ���� ��� ������ ��ȸ 
 
 SELECT *
 FROM emp
 WHERE mgr IS null;
 
 SQL���� NULL ���� ���� ��� �Ϲ����� 
 �񱳿����ڸ� ��� ���ϰ� 
 IS �����ڸ� ���
 
 ���� �ִ� ��Ȳ���� � ��: =, !=, <>
 NULL : IS NULL , IS NOT NULL
 
 emp���̺��� mgr �÷� ���� null�� �ƴ� ������ ��ȸ 
 SELECT *
 FROM emp
 WHERE mgr IS NOT null;
 
 emp���̺��� �󿩰� �ִ� ȸ���� ������ ������ ���� ��ȸ �ǵ��� ������ �ۼ��Ͻÿ� 
 
 SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
 FROM emp 
 WHERE comm IS NOT NULL;
 
 SELECT
     *
FROM emp
WHERE mgr = 7698
AND sal > 1000;
  
SELECT
     *
FROM emp
WHERE mgr = 7698
 OR sal > 1000;
 

SELECT *
FROM emp ;
 
SELECT *
FROM emp 
WHERE mgr IN (7698, 7839);
������
==> WHERE mgr = 7698 OR mgr = 7839

SELECT *
FROM emp 
WHERE mgr NOT IN (7698, 7839);
==> WHERE (mgr != 7698 AND mgr !=7839)

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);


emp ���̺��� job�� SALESMAN �̰� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���


SELECT *
FROM emp
WHERE job = 'salesman' AND hiredate >= '19810601';
WHERE job IN ('SALESMAN')
AND hiredate >= ('1921/06/01');

emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���.
SELECT *
FROM emp
WHERE deptno <> 10 AND hiredate >= '1981/06/01';

NOT IN ��� 

SELECT*
FROM emp
WHERE deptno NOT IN 10 AND hiredate >= '1981/06/01';

IN ���

SELECT*
FROM emp
WHERE deptno IN (20,30) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
---
WHERE deptno IN (10,20,30)
AND deptno != 10
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
----



SELECT*
FROM emp
WHERE job IN 'SALESMAN' OR hiredate >= '1981/06/01';


SELECT*
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%'; --LIKE '78%' �ڵ� ����ȯ ����Ÿ���ε� ���ڷ� �Է�.



SELECT*
FROM emp
WHERE job = 'SALESMAN' OR empno IN (7800, 7899);

OR 7800< empno AND empno< 7900
OR 780< empno AND empno <790
OR empno = 78;
 
 
 ������ �켱������ ��ȣ()�� ���� �켱������ ���� �� �� �ִ�. 
 
SELECT*
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%' AND hiredate >= '1981/06/01'; 

 
 
 TABLE ��ü���� �����͸� ���� / ��ȸ�� ������ �������� ����
 ==> ���� ���հ� ������ ����  
       [  ���� : (a,b,c)==(a,c,b)  ] 
 - ���������� �����Ͱ� �Էµ� ������� ��ȸ��
 - �����Ͱ� �׻� ������ ������ ��ȸ�Ǵ� ���� �������� �ʴ´� 
 - �����Ͱ� �����ǰ�, �ٸ� �����Ͱ� ���� �� ����
 
SQL������ �����͸� �����Ϸ��� ������ ������ �ʿ�
ORDER BY �÷��� [��������], �÷��� ........

������ ���� : ��������(DEFAULT) - ASC, �������� - DESC

���� �̸����� ���� ���� ����

��������
SELECT*
FROM emp
ORDER BY ename ASC;
��������
SELECT*
FROM emp
ORDER BY ename desc;
 
 desc emp << Ÿ��
 
SELECT*
FROM emp
ORDER BY job  ASC, hiredate desc;

 
 
 
 
 



