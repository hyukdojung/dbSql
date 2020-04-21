����¡ ó�� 
. ROWNUM
. INLINE-VIEW
. pagig ���� 
. ���ε� ����

�Լ� : ������ ���ȭ �� �ڵ�
==> ���� ���(ȣ��)�ϴ� ���� �Լ��� �����Ǿ��ִ� �κ��� �и� ==> ���������� ���̼��� ����

�Լ��� ������� �������
 ȣ���ϴ� �κп� �Լ� �ڵ带 ���� ����ؾ� �ϹǷ�, �ڵ尡 �������. => �������� ��������.
 
 ����Ŭ �Լ��� ����
 �Է� ���� : 
  . single row function
  . muti row function
  
������ ����:
  . ���� �Լ�: ����Ŭ���� ������ �ִ� �Լ�
  . ����� ���� �Լ�: �����ڰ� ���������� �Լ� (pl/sql��� ��)

Function  
���α׷��־��, �ĺ��̸� �ο� ... �߿��� ��Ģ

concat ���ڿ� ����
SUBSTR ���ڿ� �и� 
length ���ڿ� ����

TRIM �յ� ��������

DUAL TABLE
SYS ������ ���� �ִ� ���̺�
����Ŭ�� ��� ����ڰ� �������� ����� �� �ִ� ���̺�

�Ѱ��� ��, �ϳ��� �÷� (dummy)- ���� 'x'

��� �뵵 
1. �Լ��� �׽�Ʈ�� ����
2. *merge ����
3. *������ ����


����Ŭ ���� �Լ� �׽�Ʈ (��ҹ��� ����
LOWER, UPPER, INITCAP : ���ڷ� ���ڿ� �ϳ��� �޴´�. 

SELECT LOWER('Hello, world'), UPPER('Hello, world'), INITCAP('hello, world')
FROM DUAL;

SELECT empno, 5, LOWER('Hello, world'), UPPER('Hello, world'), INITCAP('hello, world')
FROM emp;

�Լ��� WHERE �������� ����� �����ϴ�
emp ���̺��� SMITH ����� �̸��� �빮�ڷ� ����Ǿ� ����

SELECT *
FROM emp 
WHERE LOWER(ename) = 'smith'; �̷������� �ۼ��ϸ� �ȵȴ�. �Լ��� �� ������ŭ ����
WHERE ename = UPPER('smith'); �ΰ��� ����߿��� �������� �Ʒ����

WHERE ename = 'smith'; ���̺��� ������ ���� �빮�ڷ� ����Ǿ� �����Ƿ� ��ȸ�Ǽ� 0
WHERE ename = 'SMITH'; �������

���ڿ� ����
CONCAT : �ΰ��� ���ڿ��� �Է����� �޾�, ������ ���ڿ��� ��ȯ
SELECT CONCAT('test','end')
FROM dual;

SELECT table_name, tablespace_name, CONCAT('start','end')
        CONCAT(table_name, tablespace_name),
        'SELECT * FROM ' || table_name || ';'
            CONCAT �Լ��� �ۼ�
FROM user_tables;

SELECT CONCAT(table_name, tablespace_name)
FROM user_tables;

SELECT  'SELECT * FROM ' || table_name || ';'
FROM user_tables;

SELECT CONCAT('SELECT * FROM ',CONCAT(table_name, ';')) CONCAT����
FROM user_tables;

SUBSTR(���ڿ�, ���� �ε���, ���� �ε���) : ���ڿ��� ���� �ε��� ���� .. �����ε������� �κй��ڿ�
�����ε����� 1���� (*�ڹ��� ��� 0����)

SELECT SUBSTR('Hello, World',1,5)
FROM dual;

LENGTH(���ڿ�): ���ڿ��� ���̸� ��ȯ
SELECT LENGTH('Hello, World') len
FROM dual; 

INSTR(���ڿ� , ã�� ���ڿ�, �˻� ���� �ε���[��������]) : 
                    ���ڿ����� ã�� ���ڿ��� �����ϴ���, ������ ��� ã�� ���ڿ��� �ε���(��ġ)��ȯ

SELECT INSTR('Hello, World', 'o', 5) ins
FROM dual; 

SELECT INSTR('Hello, World', 'o', INSTR('Hello, World','o')+1) ins
FROM dual; 

LPAD, RPAD(���ڿ�, ���߰� ���� ��ü ���ڿ� ����, [�е� ���ڿ�-�⺻���� ����])

SELECT LPAD('hello',15, '*') LP
FROM dual; 

SELECT RPAD('hello',15, '*') RP
FROM dual; 

SELECT LPAD('hello',15) LP
FROM dual;

REPLACE(���ڿ�, �˻��� ���ڿ�, ������ ���ڿ�)  : ���ڿ����� �˻��� ���ڿ� ã�� ������ ���ڿ� ����

SELECT REPLACE('Hello, world','ll', 'LL') REP
FROM dual; 

TRIM(���ڿ�) : ���ڿ��� �յ��� �����ϴ� ������ ���� , ���ڿ� �߰��� �ִ� ������ ���� ����� �ƴ�

SELECT TRIM('      Hello      ') tr
FROM dual; 

SELECT TRIM('H'FROM'Hello') tr
FROM dual; 

number ���� �Լ�
ROUND(����, �ݿø� ��ġ-default 0): �ݿø�
ROUND(105.54, 1) �Ҽ��� ù��°�ڸ����� ����� ���� >> �ι�° �ڸ����� �ݿø�
 : 105.5
TRUNC(����, ���� ��ġ-default 0): ����
MOD(������, ����) ������ ����

 SELECT ROUND(105.54, 1) round,
        ROUND(105.55, 1) round,
        ROUND(105.55, 0) round,
        ROUND(105.55, -1) round
 FROM dual;


 SELECT TRUNC(105.54, 1) trunc,
        TRUNC(105.55, 1) trunc,
        TRUNC(105.55, 0) trunc,
        TRUNC(105.55, -1) trunc
 FROM dual;

SELECT MOD (10, 3), sal, MOD(sal, 1000)
FROM emp;


��¥ ���� �Լ�
SYSDATE : ������� ����Ŭ �����ͺ��̽� ������ ���� �ð� , ��¥�� ��ȯ�Ѵ�.
            �Լ������� ���ڰ� ���� �Լ�
            (���ڰ� ������ java : �޼ҵ�()
                            SQL: �Լ���);

date type -+ ���� : ���� ���ϱ� ����
���� 1 = �Ϸ�
1/24 = �ѽð�
1/24/60 = �Ϻ�
SELECT SYSDATE , SYSDATE + 5
FROM dual;

���ͷ� 
���� :
���� : ''
��¥ : TO_DATE ('��¥���ڿ�', '����')'2020,10,02'


SELECT TO_DATE ('2019/12/31', 'YYYY/MM/DD') LASTDAY, TO_DATE ('2019/12/31', 'YYYY/MM/DD') -5 LASTDAY_BEFORE5, SYSDATE NOW, SYSDATE -3 NOW_BEFORE3
FROM dual;


TO_DATE(���ڿ�, ����) : ���ڿ��� ���˿� �°� �ؼ��Ͽ� ��¥ Ÿ������ ����ȯ
TO_CHAR(��¥, ����) : ��¥Ÿ���� ���˿� �°� ���ڿ��� ��ȯ

YYYY : ����
MM : ��
DD : ����
D : �ְ�����(1~7, 1-�Ͽ���, 2-������... 7-�����)
IW : ����(52~53) �ش����ڰ� �������� ���ϴ���
HH : �ð�(12�ð�)
HH24 : 24�ð� ǥ��
MI : ��
SS : ��

����ð� (SYSDATE) �ú��� �������� ǥ�� >> TO_CHAR�� �̿��Ͽ� ����ȯ

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now
FROM dual;


SELECT TO_CHAR(SYSDATE-3, 'YYYY/MM/DD HH24:MI:SS') now_before3
FROM dual;

SELECT TO_CHAR(SYSDATE-1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1hour
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH, 
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') DT_DASH_WITH_TIME,
        TO_CHAR(SYSDATE, 'DD-MM-YYYY')DT_DD_MM_YYYY
FROM dual;

MONTHS_BETWEEN(DATE1, DATE2) :DATE1�� DATE2������ �������� ��ȯ
4���� ��¥ �����Լ��߿� ���󵵰� ����
SELECT MONTHS_BETWEEN( TO_DATE ('2020/04/21', 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD')),
    MONTHS_BETWEEN( TO_DATE ('2020/04/22', 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD'))
FROM dual;

ADD_MONTHS(DATE1, ������ ������) : DATE1�κ��� �ι��� �Էµ� ������ ��ŭ ������ DATE
���� ��¥�κ��� 5������ ��¥ 
SELECT ADD_MONTHS(SYSDATE, 5) dt1,
    ADD_MONTHS(SYSDATE, -5) dt2
FROM dual;

NEXT_DAY(DATE1, �ְ�����) : date ���� �����ϴ� ù���� �ְ������� ��¥�� ��ȯ 

SELECT NEXT_DAY(SYSDATE, 7)
FROM dual;

LAST_DAY(DATE1): DATE1�� ���� ���� ������ ��¥�� ��ȯ
SYSDATE: 2020/04/21 >> 2020/04/30

SELECT LAST_DAY(SYSDATE)
FROM dual;

SELECT ADD_MONTHS(LAST_DAY(SYSDATE)+1,-1),
    TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM') ||'01','YYYY/MM/DD')
FROM dual;


























