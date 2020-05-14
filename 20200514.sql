�����ȹ : SQL�� ���������� � ������ ���ļ� �������� ������ �ۼ�
        * ����ϴµ� ��� ���� ����� �ʿ�(�ð�)

2���� ���̺��� �����ϴ� SQL
2���� ���̺� ���� �ε����� 5���� �ֵ���
������ �����ȹ ���� �? ������ ���� ==> ª�� �ð��ȿ� �س��� �Ѵ�.(������ ���� �ؾ��ϹǷ�)


���� ������ SQL ����� ��� ������ �ۼ��� �����ȹ�� �����Ұ��
���Ӱ� ������ �ʰ� ��Ȱ�� �Ѵ�. (���ҽ� ����)

���̺� ���� ��� : ���̺� ��ü(1) , ������ �ε���(5)
a => b
b => a
����� �� : 36�� * 2�� = 72�� 

������ SQL �̶� : SQL ������ ��ҹ��� ������� ��ġ�ϴ� SQL
 �Ʒ� �ΰ��� ������ ���δٸ� ������ �ν�.
SELECT * FROM emp;
select * FROM emp;

Ư�������� ������ ��ȸ�ϰ� ������ : ����� �̿��ؼ� 
SELECT /* 202004_B */*
FROM emp
WHERE empno = :empno;

SELECT*
FROM sem.v_emp

sem.v_emp ==> v_emp

SELECT*
FROM v_emp;

SYNONYM : ��ü�� ��Ī�� �����ؼ� ��Ī�� ���� ���� ��ü�� ���

���� : CREATE SYNONYM �ó�� �̸� FOR ��� ������Ʈ;

sem.v_emp ==> v_emp �ó������ ����

CREATE SYNONYM v_emp FOR PC23.v_emp;

v_emp�� ���� ���� ��ü�� sem.v_emp �� ����Ҽ� �ֵ�. 

DROP Synonym v_emp;

SELECT *
FROM v_emp;


SQL CATEGORY
DML
DDL
DCL
TCL



-DCL-
==���� ��������==
����Ŭ�� �����ϱ�
CONNECT
��ü�� �����ϱ� 
RESOURCE
����Ŭ ����ڸ� �ű� ����
GRANT CONNECT, RESOURCE TO user_name |(=or) role;


����Ŭ ���� 
- �ý��� ���� 
�ý��� ����, ����
-��ü ����
��ü����
��Ű��
-��ü���� ����(tables, views, indexes..)


DATE DICTIONARY : �ý��� ������ �� �� �ִ� view, ����Ŭ�� ��ü������ ���� 
category (���ξ�)
USER : �ش� ����ڰ� �����ϰ� �ִ� ��ü ���
ALL : �ش� ����� ���� + ������ �ο����� ��ü ���
DBA : ��� ��ü ���
VS : ����, �ý��� ����


SELECT*
FROM user_tables;

SELECT*
FROM ALL_tables;

SELECT*
FROM DBA_tables;

SELECT*
FROM dictionary;

Multiple insert : �������� �����͸� ���ÿ� �Է��ϴ� INSERT �� Ȯ�� ����

1. unconditional insert : ������ ���� ���� ���̺� �Է��ϴ� ���
����:
    INSERT ALL
            INTO ���̺��
                [,INTO ���̺��..]
            VALUES(....) | SELECT QUERY;

SELECT*
FROM emp_test;

emp_test���̺��� �̿��Ͽ� emp_test2 ���̺� ����
CREATE TABLE emp_test2 AS
SELECT*
FROM emp_test
WHERE 1=2;

EMPNO, ENAME, DEPTNO

SELECT*
FROM emp_test2;


emp_test, emp_test2  ���̺� ���� �Է�
INSERT ALL
    INTO emp_test --[VALUES (�÷���)]
    INTO emp_test2 
SELECT 9998, 'brown', 88 FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual; 

2. conditional insert : ���ǿ� ���� �Է��� ���̺��� ����

INSERT ALL INTO
    WHEN ����.......THEN
        INTO �Է����̺� VALUES
    WHEN ����.......THEN
        INTO �Է����̺�2 VALUES
    ELSE
        INTO �Է� ���̺�3 VALUES

SELECT ����� ���� ���� EMPNO=9999�̸� EMP_TEST���� �����͸� �Է�
                            �ܿ��� EMP_TEST2���� �����͸� �Է�
        
INSERT ALL
    WHEN empno = 9999 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    ELSE
        INTO emp_test2 (empno, deptno) VALUES (empno, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual; 

SELECT*
FROM emp_test;

SELECT*
FROM emp_test2;

rollback;

conditional insert (all) ==> first
INSERT FIRST
        WHEN empno <= 9998 THEN
            INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual; 


INSERT FIRST
    WHEN empno = 9999 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    ELSE
        INTO emp_test2 (empno, deptno) VALUES (empno, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual; 

SELECT*
FROM emp_test; 

merge : �ϳ��� ������ ���� �ٸ� ���̺�� �����͸� �ű� �Է�, �Ǵ� ������Ʈ �ϴ� ����
����:
MERGE INTO ���� ���(EMP_TEST)
USING (�ٸ� ���̺� | VIEW | subquery)
ON (�������� USING ���� ���� ���� ���)
WHEN NOT MATCHED THEN
    INSERT (�÷�.. , ... .) VALUES (VALUES......)
WHEN MATCHED THEN
    UPDATE SET col 1 = value 1, col 2 = value 2
1. �ٸ� �����ͷ� ���� Ư�� ���̺�� �����͸� MERGE �ϴ� ��� 

2. KEY�� ���� ��� INSERT
    KEY�� ���� �� UPDATE
    
    
emp ���̺��� �����͸� emp_test ���̺�� ����
emp ���̺� �����ϰ� emp_test ���̺��� �������� �ʴ� ������ �ű��Է�
emp ���̺� �����ϰ� emp_test ���̺��� �����ϴ� ������ �̸��� ����
/*
9999	brown	88
15	sally	88
16	sally	88
17	sally	88
7369	cony	88*/

SELECT*
FROM emp_test;

INSERT INTO emp_test VALUES(7369,'cony',88);
emp���̺��� 14�����͸� emp_test���̺� ������ empno��  �����ϴ��� �˻��ؼ� 
������ empno�� ������ insert-empno,ename, ������ empno�� ������ update-ename
MERGE INTO emp_test
USING emp
ON (emp_test.empno = emp.empno) 
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (emp.empno, emp.ename)
WHEN MATCHED THEN
    UPDATE SET ename = emp.ename;
    
���� �ó������� �ϳ��� ���̺��� �ٸ� ���̺��� �����ϴ� ��� 

9999�� ������� �ű� �Է��ϰų�, ������Ʈ�� �ϰ� ������
(����ڰ� 9999��, james ����� ����ϰų�, ������Ʈ �ϰ� ������)
���� ���� ���̺� ==> �ٸ� ���̺�� ���� 
�����͸� ==> Ư�� ���̺�� ���� 

�̹��� �ϴ� �ó����� : �����͸� ==> Ư�� ���̺�� ����
(9999, james)

MERGE ������ ������� ������ 

SELECT*
FROM emp_test
WHERE empno=9999;

�����Ͱ� ������  ==> update
�����Ͱ� ������ ==> insert


MERGE INTO emp_test   --*****
USING dual
ON (emp_test.empno = 9999) 
WHEN NOT MATCHED THEN
    INSERT (empno,ename) VALUES (9999,'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';
    
SELECT*
FROM emp_test;

MERGE INTO emp_test
USING (SELECT 9999 eno, 'james' enm
        FROM dual) a
ON (emp_test.empno = a.eno) 
WHEN NOT MATCHED THEN
    INSERT (empno,ename) VALUES (9999,'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';

merge �ó����� �ѹ� �غ��� 

REPORT GROUP FUNCTION
emp���̺��� �̿��Ͽ� �μ���ȣ�� ������ �޿� �հ�, ��ü������ �޿����� ��ȸ�ϱ� ���� 
GROUP BY �� ����ϴ� �ΰ��� SQL �� ������ �ϳ��� ��ġ�� (UNION  ==> UNION ALL) �۾��� ����

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, SUM(sal)
FROM emp;

Ȯ��� GROUP BY 3����
1. GROUP BY ROLLUP
���� : GROUP BY ROLLUP (�÷�,�÷�.....)
���� : ����׷��� ������ִ� �뵵
����׷� ���� ��� : ROLLUP ���� ����� �÷��� �����ʿ��� ���� �ϳ��� �����ϸ鼭 ����׷��� ����
������ ���� �׷��� UNION�� ����� ��ȯ

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

����׷�: 1. GROUP BY job, deptno
            UNION
        2. GROUP BY job
            UNION
        3. ��ü�� GROUP BY 


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno)

UNION 

SELECT job, null, SUM(sal) sal
FROM emp
GROUP BY job

UNION

SELECT null,null, SUM(sal) sal
FROM emp;

SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno);

����׷��� ������ : ROLLUP���� ����� �÷� ����


