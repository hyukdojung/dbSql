NVL(expr1, expr2)
if expr1 == null
    return expr2
else
    return expr1
    

NVL2(expr1, expr2, expr3)
if expr1 != null
   return expr2
else
    return expr3
    

NULLIF(expr1, expr2)
if expr1 == expr2
    return null
    else
        return expr1
sal �÷��� ���� 3000�̸� null�� ����
SELECT empno, ename, sal, NULLIF (sal, 3000)
FROM emp;

�������� : �Լ��� ������ ������ ������ ���� ����
            �������ڵ��� Ÿ���� ���� �ؾ��� .
���ڵ��߿� ���� ���������� nuill�� �ƴ� ���� ���� ����
coalesce(expr1, expr2..................)

if expr1 != null
 return expr1
else
    coalesce(expr2, expr3 ....)
ù��° ���ڸ� ������ ������ ���ڸ� ȣ�� > ���� �Լ� 


mgr �÷� null
comm �÷� null

SELECT empno, ename, comm ,sal, coalesce(comm, sal)
FROM emp;

SELECT *
FROM emp;

SELECT empno, ename, mgr, nvl(mgr, 9999)MGR_N,nvl2(mgr,sal, 9999)MGR_N1,COALESCE(mgr,9999)MGR_N_2
FROM emp;

SELECT*
FROM users;

SELECT userid, usernm, REG_DT,nvl(REG_DT,sysdate) N_REG_DT
FROM users;

confdition
���ǿ� ���� �ķ� Ȥ�� ǥ������ �ٸ� ������ ��ü 
java if, switch ���� ���� 
1. case ����
2. decode �Լ�

1. CASE
CASE
    WHEN ��/������ �Ǻ��� �� �ִ� �� THEN������ ��
    [WHEN ��/������ �Ǻ��� �� �ִ� �� THEN������ ��]
    [ELSE ���ϰ� (�Ǻ����� ���� WHEN ���� ���� ��� ����)]
END

emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� 'SALESMAN'�� ��� SAL���� 5%�λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100 > 105)
�ش� ������ job�� 'MANAGER'�� ��� SAL���� 10%�λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100 > 105)
�ش� ������ job�� 'PRESIDENT'�� ��� SAL���� 20%�λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100 > 105)
�� �� �������� sal��ŭ�� ����
//�÷��� ���� 

SELECT empno, ename, job, sal, 
    CASE 
        WHEN job = 'SALESMAN' THEN sal *1.05
        WHEN job = 'MANAGER' THEN sal *1.10
        WHEN job = 'PRESIDENT' THEN sal *1.20
        ELSE sal* 1
    END bonus
FROM emp;

2. DECODE(EXPR1, search1, returnl, search2, return2, search3, return3......[default])
DECODE(EXPR1, 
    search1, returnl,
    search2, return2,
    search3, return3
    ......[default])
    -------------------

    
SELECT empno, ename, job, sal,
    DECODE( job, 'SALESMAN', sal*1.05,
                'MANAGER', sal*1.10,
                'PRESIDENT', sal*1.20,
                sal ) bonus
FROM emp;

    
 
SELECT empno, ename ,
  DECODE( job, 
            'SALESMAN', sal*1.05,
            'MANAGER', sal*1.10,
            'PRESIDENT', sal*1.20,
            sal*1 ) bonus,
    CASE 
        WHEN job = 'SALESMAN' THEN sal*1.05
        WHEN job = 'MANAGER' THEN sal*1.10
        WHEN job = 'PRESIDENT' THEN sal*1.20
        ELSE sal*1
        END DNAME
FROM emp;   
    
SELECT empno, ename ,
   DECODE (deptno,
        10, 'ACCOUNTING',
        20, 'RESEARCH',
        30, 'SALES',
        40, 'OPERATIONS',
        'DDIT')DNAME,
       CASE 
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
        END bonus2
FROM emp;   
    
    
SELECT empno, ename, hiredate,
    case 
    WHEN mod(TO_CHAR(sysdate,'YYYY')-TO_CHAR(hiredate,'YYYY'),2) = 0 THEN '�˰����� �����'
    ELSE '�˰����� ������'  
    END CONTACT_TO_DOCTOR
FROM emp;
-- ����ȯ�� mod ������ ��� case�� �̿��� ���ϰ��� �ϴ� ������ ����

SELECT empno, ename, hiredate,
   DECODE (MOD(TO_CHAR(sysdate, 'YYYY'),2),MOD(TO_CHAR(hiredate,'YYYY'),2),'�˰����� ������','�˰����� �����')CONTACT_TO_DOCTOR
FROM emp;



SELECT userid, usernm, ALIAS ,REG_DT, 
    case
    WHEN MOD(TO_CHAR(sysdate, 'YYYY'),2) = MOD(TO_CHAR(REG_DT,'YYYY'),2) THEN '�����'
    ELSE '������'
    END CONTACTTODOCTOR
FROM users;
    
    
    
   
SELECT userid, usernm, alias, REG_DT,
DECODE (MOD(TO_CHAR(sysdate, 'YYYY'),2),MOD(TO_CHAR(NVL(reg_dt,'1112/11/11'),'YYYY'),2),'�˰����� ������','�˰����� �����')
FROM users;
----------------------------------20200423 ����
NULL ó�� ���(4������ �ϳ� ���)
NVL, NVL2 

DESC emp;
��� ��? null���� ����ϴ��� not null�̸� null���� ������� �ʴ´�. 

condition: CASE, DECODE
�����ȹ :  �����ȹ�� ���� 
            ���� ����
---------------------------------









