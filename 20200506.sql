DML
�����͸� �Է�(INSERT), ����(UPDATE), ����(DELETE) �Ҷ� ����ϴ� SQL

INSERT

����
INSERT INTO ���̺�� [(���̺��� �÷���, .......)]VALUES (�Է��� ��,........);

ũ�� ���� �ΰ��� ���·� ���
1. ���̺��� ��� �÷��� ���� �Է��ϴ� ���, �÷����� �������� �ʾƵ� �ȴ�.
    �� �Է��� ���� ������ ���̺� ���ǵ� �÷� ������ �ν��� �ȴ�.
INSERT INTO ���̺�� VALUES(�Է��� �� , .. . );

2. �Է��ϰ��� �ϴ� �÷��� ����ϴ� ���
    ����ڰ� �Է��ϰ��� �ϴ� �÷��� �����Ͽ� �����͸� �Է��� ���.
    �� ���̺� NOT NULL ������ �Ǿ� �ִ� �÷��� �����Ǹ� INSERT �� ����
INSERT INTO ���̺�� [(�÷���, ..)]VALUES(�Է°�, .. );

3.SELECT ����� INSERT
    SELECT ������ �̿��ؼ� ������ ���� ��ȸ�Ǵ� ����� ���̺� �Է� ����.
    ==> �������� �����͸� �ϳ��� ������ �Է� ����(ONE-QUERY) == > ���� ����
    
    ����ڷ� ���� �����͸� ���� �Է� �޴� ���(ex ȸ������)�� ���� �Ұ�
    db�� �����ϴ� �����͸� ���� �����ϴ� ��� Ȱ�� ����(�̷� ��� ����)
    
    INSERT INTO ���̺�� [(�÷���,...)]
    SELECT ........
    FROM ..........

dept ���̺� dept 99, dname DDIT, loc deajeon ���� �Է��ϴ� INSERT ���� �ۼ�

SELECT*
FROM dept;

������ �Է��� Ȯ�� �������� : commit -Ʈ����� �Ϸ�
������ �Է��� ��� �Ϸ��� : rollback - Ʈ����� ���

rollback;

INSERT INTO dept VALUES (99, 'DDIT','deajeon');

INSERT INTO dept (loc, deptno, dname) VALUES ('daejeon', 99,'DDIT');


���� INSERT ������ ���ڿ�, ����� �Է��� ���
INSERT �������� ��Į�� ��������, �Լ� ��� ����
EX ; ���̺��� �����Ͱ� �� ����� �Ͻ� ������ ��� �ϴ� ��찡 ���� ==> SYSDATE

SELECT*
FROM emp;

emp ���̺��� ��� �÷� �� ������ 8�� NOT NULL�� 1��(EMPNO)
empno�� 9999�̰� ename�� ���� �̸�, hiredate�� ���� �Ͻø� �����ϴ� INSERT ����


INSERT INTO emp VALUES (9999, '������',NULL,NULL,SYSDATE,NULL,NULL,NULL);

9999�� ������� jw ����� �Է�, �Ի����ڴ� 2020��4��13�Ϸ� �����Ͽ� ������ �Է�

INSERT INTO emp VALUES (9999, '������',NULL,NULL,TO_DATE('2020/04/13','YYYY/MM/DD'),NULL,NULL,NULL);

empno �÷��� NOT NULL
INSERT INTO emp VALUES ('������',NULL,NULL,TO_DATE('2020/04/13','YYYY/MM/DD'),NULL,NULL,NULL);

3. SELECT ����� ���̺� �Է��ϱ� (�뷮 �Է�)

DESC dept;

dept ���̺��� 4���� �����Ͱ� ����(10~40)
�Ʒ� ���� ���� �� ���� ���� 4�� + SELECT �� �ԷµǴ� 4�� �� 8���� �����Ͱ� dept���̺� �Է�
INSERT INTO dept
SELECT*
FROM dept;

������ Ȯ�� 
SELECT*
FROM dept;

������ �۾��� ������ ���
ROLLBACK;

UPDATE : ������ ����
UPDATE ���̺�� SET ������ �÷�1 = ������ ��1
                [������ �÷�1 = ������ ��1,.....]
[WHERE condition - SELECT ������ ��� WHERE�� ����
        ������ ���� �ν��ϴ� ������ ���]
        
        
dept ���̺� 99,DDIT,daejeon;

INSERT INTO dept VALUES (99,'DDIT','daejeon');

99�� �μ��� �μ����� ��� IT��, ��ġ�� ���κ������� ����
UPDATE dept SET dname = '��� IT',
                loc = '���κ���'
WHERE deptno = 99;
�Ʒ��� ������ ���̺��� ��� ���� �μ���� ��ġ�� ����
UPDATE dept SET dname = '��� IT',
                loc = '���κ���';
                
INSERT : ���� �� ���� ����
UPDATE, DELETE : ������ �ִ°� ����, ���� 
 ==> ������ �ۼ��� ��� ����
  1. WHERE ���� �������� �ʾҴ���
  2. UPDATE, DELETE ���� �����ϱ� ���� WHERE���� �����ؼ� SELECT�� �Ͽ� 
        ������ ������ ���� ������ Ȯ��


ORACLE ����ڿ��Դ� UPDATE, DELETE �� �Ǽ� ���� ��� �ѹ��� ��ȸ�� ����
ROLLBACK;

���������� �̿��� ������ ����
INSERT INTO emp (empno, ename, job) VALUES (9999,'brown', NULL);
SELECT*
FROM emp;

9999�� ������ deptno, job �ΰ��� �÷��� SMITH ����� ������ �����ϰ� ����

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
                job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

�Ϲ����� UPDATE ���������� �÷����� ���������� �ۼ��Ͽ� ��ȿ���� ����
==> MERGE ������ ���� ��ȿ���� ���� �� �� �ִ�.

DELETE ; ���̺� �����ϴ� �����͸� ���� 
����

DELETE [FROM] ���̺��
[WHERE condition]

������
1. Ư�� �÷��� ���� ���� ==> �ش� �÷��� NULL�� UPDATE
    DELETE ���� �� ��ü�� ���� 
2. UPDATE ���������� DELETE ������ �����ϱ� ���� SELECT �� ���� ���� ����� �Ǵ� ���� ��ȸ, Ȯ������.

���� �׽�Ʈ ������ �Է�
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brown', NULL);
����� 9999���� ���� �����ϴ� ���� �ۼ�

DELETE emp
WHERE empno = 9999;

SELECT *
FROM emp;
WHERE empno = 9999;

ROLLBACK;

�Ʒ� ������ �ǹ� : emp ���̺��� ��� ���� ����
DELETE emp;

UPDATE, DELETE ���� ��� ���̺� �����ϴ� �����Ϳ� ����, ������ �ϴ� ���̱� ������
��� ���� �����ϱ� ���� WHERE ���� ����� �� �ְ�
WHERE���� SELECT ������ ����� ������ ���� �� �� �ִ�. 
���� ��� ���������� ���� ���� ������ ����

�Ŵ����� 7698�� �������� ��� �����ϰ� ������

SELECT*
FROM emp
WHERE mgr = 7698;

DELETE emp
WHERE empno IN
        (SELECT empno
        FROM emp
        WHERE mgr = 7698);


DML : SELECT, INSERT, UPDATE, DELETE
WHERE ���� ��� ������ DML : SELECT, UPDATE, DELETE
    1���� ������ �����͸� �ĺ��ϴ� WHERE ���� ��� �� �� �ִ�. 
    �����͸� �ĺ��ϴ� �ӵ��� ���� ������ ���� ������ �¿� ��.
    ==> INDEX ��ü�� ���� �ӵ� ����� ����
    
INSERT : �� ������ �ű� �����͸� �Է��ϴ°�
        ����� �ĺ��ϴ°� �߿�
            ==>�����ڰ� �� �� �ִ� Ʃ�� ����Ʈ�� ���� ����.
            
���̺��� �����͸� ����� ��� (��� ������ �����)
1. DELETE : WHERE���� ������� ������ ��.
2. TRUNCATE 
���� : TRUNCATE TABLE ���̺��
Ư¡ : 1) ������ �α׸� ������ ����
        ==> ������ �Ұ���
        2) �α׸� ������ �ʱ� ������ ���� �ӵ��� ������.
            ==> �ȯ�濡���� �� ������� ����( ������ �ȵ��� ������)
                �׽�Ʈ ȯ�濡�� �ַ� ���
                

�����͸� �����Ͽ� ���̺� ���� (���� �غ���)

CREATE TABLE emp_copy AS
SELECT *
FROM emp;

SELECT *
FROM emp_copy;

emp_copy ���̺��� TRUNCATE ����� ���� ��� �����͸� ����

TRUNCATE TABLE emp_copy;

ROLLBACK;


Ʈ����� _ ���� ���� ����
ex ) ATM - ��ݰ� �Ա��� �Ѵ� ���������� �̷������ ������ �߻����� ����
            ����� ���� ó�� �Ǿ����� �Ա��� ������ ó�� �Ǿ��ٸ�
            ���� ó���� ��ݵ� ó�� ������Ѵ�.
            

���
�Ա�(����)
ROLLBACK;

����Ŭ������ ù��° DML�� ������ �Ǹ� Ʈ���� �������� �ν�
Ʈ������� ROLLBACK, Ȥ�� COMMIT�� ���� ���ᰡ �ȴ�.

Ʈ����� ���� �� ���ο� DML�� ����Ǹ� ���ο� Ʈ������� ����

��� ����ϴ� �Խ����� �����غ��� 
�Խñ� �Է��� �� �Է� �ϴ°� ; ����(1��), ����(1��), ÷������(���� ����)
RDBMS������ �Ӽ��� �ߺ��� ��� ������ ��ƼƼ(���̺�)�� �и��� �Ѵ�.
�Խñ� ���̺�(����, ����) / �Խñ� ÷������ ���̺�(÷�����Ͽ� ���� ����)

�Խñ��� �ϳ� ����� �ϴ���
�Խñ� ���̺��, �Խñ� ÷������ ���̺� �����͸� �űԷ� ����� �Ѵ�. 
INSERT INTO �Խñ� ���̺� (����, ����, �����, ���(�Ͻ�)) VALUES (......);
INSERT INTO �Խñ� ÷������ ���̺� (÷�����ϸ�, ÷������ ������) VALUES (......);

�ΰ��� INSERT������ �Խñ� ����� Ʈ����� ����
�� �ΰ��߿� �ϳ��� ������ ����� �Ϲ������� ROLLBACK ó���Ͽ� �ΰ��� INSERT������ ���.
