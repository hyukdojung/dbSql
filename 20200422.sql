--���� �ð� ����

SELECT '201912' PARAN,
        TO_CHAR(LAST_DAY(TO_DATE('201912','YYMM')), 'DD') DT
FROM dual;


SELECT TO_CHAR(TO_DATE('201912','YYMM'), 'YYMM') PARAM,
    TO_CHAR(LAST_DAY(TO_DATE('201912','YYYYMM')), 'DD') DT
FROM dual;
-- :(201912)������ ���� ���ε� ������ �����ټ� ����. 



--���� ����
1. �ֹ߼� �����͸� DB�� Ȱ���Ͽ� ��ȣ ����
2. Ʈ����� : �����ܰ��� ������ �ϳ��� �۾����� ���� ����
3. Ʈ����� ���ڼ� : Ʈ����ǳ��� �۾��� ���� �ǰų� / �ȵǰų� 
18.����¡ ó�� SQL �ٽ� ���� .. 

����ȯ
������ ����ȯ



EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = '7369';

   
SELECT*
FROM TABLE(DBMS_XPLAN.DISPLAY);




�����ȹ�� ���� ���� (id)
* �鿩���� �Ǿ������� �ڽ� ���۷��̼�
1. ������ �Ʒ��� 
 *�� �ڽ� ���۷��̼��� ������ �ڽĺ��� �д´�. 


Plan hash value: 3956160932
 1 >> 0
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 | //���� ������ �����ϴ� �����͸� �о���. 
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)



EXPLAIN PLAN FOR
SELECT*
FROM emp 
WHERE to_char(empno) = '7369';

SELECT*
FROM TABLE(dbms_xplan.display);


EXPLAIN PLAN FOR
SELECT*
FROM emp 
WHERE empno = 7300+'69';

SELECT*
FROM TABLE(dbms_xplan.display);

SQL �������� ĥ������
7. ������� �������� ���� �����ȹ�� ������ ������ ������ ������ ������ ������ �ϳ��� SQL�� �ӹ��� �ϼ���� �϶�.

SELECT ename, sal, TO_CHAR(sal, 'L009,999.00')
FROM emp;                       --������

NULL�� ���õ� �Լ� 
NVL
NNL2
COALESCE

�� nulló���� �ؾ��ұ�?
null�� ���� �������� null�̴� 

���� �� emp ���̺� �����ϴ� sal, comm �ΰ��� �÷� ���� ���� ���� �˰� �; 
������ ���� SQL�� �ۼ�.

SELECT empno, ename, sal, comm, sal +comm AS sal_plus_comm
FROM emp;

SELECT empno, ename, sal, comm, sal +NVL(comm,0) AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1�� NULL�̸� expr2���� �����ϰ� 
expr1�� NULL�� �ƴϸ� expr1�� ����



REG_DT �÷��� null�� ��� ���� ��¥�� ���� ���� ������ ���ڷ� ǥ��
SELECT userid, usernm, NVL(reg_dt,LAST_DAY(SYSDATE))
FROM users;












