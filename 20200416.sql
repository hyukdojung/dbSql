--select1
SELECT *
FROM prod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT*
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

SQL ���� : JAVA�� �ٸ��� ���� x , �Ϲ��� ��Ģ����
int b= 2; = ���Կ�����, == ��;

SQL ������ Ÿ�� : ����, ���� , ��¥ (date);

SELECT*
FROM USERS;

��¥ Ÿ�Կ� ���� ���� : ��¥�� +, -���� ����
date type + ���� : date���� ���� ��¥��Ŭ �̷� ��¥�� �̵�
date type - ���� : date���� ���� ��¥��ŭ ���� ��¥�� �̵�;

SELECT userid, reg_dt + 5, reg_dt
FROM users;
/* null�� ������ ������ ����� �׻� null �̴�.
--�÷� ��Ī : ���� �÷����� �����ϰ� ������ 
--syntax : ���� �÷��� [as] ��Ī ��Ī
--��Ī ��Ī�� ������ ǥ���Ǿ�� �� ��� ""�� ��� 
-- ���� ����Ŭ������ ��ü���� �빮�� ó�� �ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ��� ""�� ����Ѵ�.
*/
SELECT userid id, userid ���̵�
FROM users;

--select2
SELECT prod_id "id", prod_name "name"
FROM prod;

SELECT lprod_gu "gu", lprod_nm "nm"
FROM lprod;

SELECT buyer_id "���̾���̵�", buyer_name "�̸�"
FROM buyer;

--���ڿ� ���� (���տ���): || (���ڿ� ������ +�����ڰ� �ƴϴ�.)
SELECT /*userid +'test'*/userid ||'test', reg_dt +5, 'test', 15
FROM users;


SELECT userid || usernm as id_name
FROM users;

SELECT CONCAT(userid, usernm) as concat_id_name
FROM users;

SELECT '���̵� : ' || userid id
FROM users;

--user_tables : oracle  �����ϴ� ���̺� ������ ��� �ִ� ���̺� [view] ==> data dictionary

SELECT* 
FROM user_tables;

SELECT 'SELECT * FROM '||table_name ||';'"QUERY" 
FROM user_tables;



/*���̺��� ���� �÷��� Ȯ�� 
1. tool(sql developer)�� ���� Ȯ��
   ���̺� - Ȯ���ϰ��� �ϴ� ���̺�
2. SELERCT*
    FROM���̺�
    �ϴ� ��ü ��ȸ --> ��� Į�� ǥ��
3. DESC ���̺��  ������ Ÿ��
4. data dictionary : user_tab_columns

*/

DESC emp;

SELECT*
FROM user_tab_columns;
/*
���ݱ��� ��� ���
��ȸ�ϰ��� �ϴ� �ķ� ��� : SELECT
��ȸ�� ���̺� ��� : FROM
��ȸ�� ���� �����ϴ� ������ ��� : WHERE
WHERE ���� ����� ������ ��(TRUE)�϶� ����� ��ȸ
*/
SELECT *
FROM users;

java�� �� ���� : a������ b������ ���� ������ �� ==
sql�� �� ���� : =
int a = 5;
int b = 2;
a�� b�� ���� ���� ���� Ư������ ����;


SELECT*
FROM users
WHERE userid = 'cony'
;
SELECT*
FROM users
WHERE userid = userid;

SELECT*
FROM users
WHERE 1 = 1;

SELECT*
FROM users
WHERE 1 = 2;

emp���̺��� �÷��� ������ Ÿ���� Ȯ��;
DESC emp;

SELECT *
FROM emp;

emp: �����ȣ
ename: ��� �̸� 
job: ����
mgr : ����� 
hiredate : �Ի���
sal : �޿� 
comm : ������
deptno : �μ���ȣ
;
--emp ���̺��� ������ ���Ѻμ���ȣ�� 30������ ū �μ��� ���� ������ ��ȸ
SELECT*
FROM emp
WHERE deptno >= 30;

!= �ٸ��� 
users ���̺��� ����� ���̵� (userid)�� brown�� �ƴ� ����ڸ� ��ȸ ;
SELECT
    *
FROM users
WHERE userid !='brown';


SELECT ename hiredate 
FROM emp
WHERE '2020/02/30'<'2020/12/10';

SQL ���ͷ� 
����: .......
����: �̱� �����̼� ['hello world']
��¥: TO_DATE ('��¥ ���ڿ�', '��¥���ڿ��� ����');

--1920�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ 
SELECT *
FROM emp
WHERE hiredate >= '19820101';







