emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� 'SALESMAN'�� ��� SAL���� 5%�λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100 > 105)
�ش� ������ job�� 'MANAGER'�̸鼭 deptno�� 10�̸� SAL���� 30%�λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100 > 105)
                                        �� ���� �μ��� ���ϴ� ����� 10%�λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� 'PRESIDENT'�� ��� SAL���� 20%�λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100 > 105)
�� �� �������� sal��ŭ�� ����


SELECT empno, ename, job, sal, 
    DECODE( job, 
            'SALESMAN' , sal *1.05,
            'MANAGER' ,  DECODE(deptno, 10,sal *1.30, sal *1.10),           
            'PRESIDENT', sal*1.20,sal*1) DDD
FROM emp;

SELECT *
FROM emp
ORDER BY deptno;

���� A = {10, 15, 18, 23, 24, 25, 29, 30, 35, 37}
�Ҽ� : {23,29,37} : conunt-3, max-37, min-23, avg-29.66, sum-89
�� �Ҽ� : {10, 15, 18, 24, 25, 30, 35}


SELECT (23+29+37)
FROM dual;

SELECT *
FROM emp;

GROUP FUNCTION
�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���δ� 
EX: �μ��� �޿� ���
    emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10,20,30)�� ���� �ִ�.
    �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�.
    
SELECT �׷��� ���� �÷�, �׷��Լ� : SELECT ����� �� �ִ� �÷��� ���� �� 

FROM ���̺�
GROUP BY �׷��� ���� �÷�
[ORDER BY];


�μ����� ���� ���� �޿� ��
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;

SELECT deptno, MIN(ename),MAX(sal)
FROM emp
GROUP BY deptno;

SELECT deptno, 
        MIN(sal),
        MAX(sal),
        ROUND(AVG(sal),2),
        SUM(sal),
        COUNT(sal),-- �μ��� �޿�- �Ǽ�sal �÷��� ���� null�� �ƴ� row�� ��
        COUNT(*),--�μ��� ���� �� 
        COUNT(mgr)
FROM emp
GROUP BY deptno;


* �׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������ 
    ���� ���� �޿��� �޴� ����� �̸��� �� ���� ����.
    >> ���� WINDOW FUCTION�� ���� �ذ� ����
SELECT *
FROM emp;


emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� ���� �ϴ� ���
SELECT  
        MIN(sal), --��ü ������ ���� ���� �޿� ��
        MAX(sal), -- ��ü ������ ���� ���� �޿� ��
        ROUND(AVG(sal),2), --��ü ������ �޿� ���
        SUM(sal),   --��ü ������ �޿��� ��
        COUNT(sal),-- ��ü ������ �޿�- �Ǽ�sal �÷��� ���� null�� �ƴ� row�� ��
        COUNT(*),--��ü ���� �� 
        COUNT(mgr) --mgr �÷��� null�� �ƴ� �Ǽ�.
FROM emp;

GROUP BY ���� ����� �ķ��� 
    SELECT ���� ������ ������ ?? < ��� ����
    
GROUP BY ���� ������� ���� �÷��� 
    SELECT ���� ������ ?    < ���� ;


�׷�ȭ�� ���� ���� ���ڿ�, ��� ���� SELECT ���� ǥ�� �� �� �ִ�.(�����ƴ�);
SELECT deptno, 'test', 1,
        MIN(sal), 
        MAX(sal), 
        ROUND(AVG(sal),2),
        SUM(sal),  
        COUNT(sal),
        COUNT(*),
        COUNT(mgr) 
FROM emp
GROUP BY deptno;

GROUP �Լ� ����� NULL���� ���� �ȴ�.
30�� �μ����� NULL���� ���� ���� ������ SUM(comm)�� ���� ���������� ���� �� Ȯ�� �� �� �ִ�.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10,20�� �μ��� SUM(comm) �÷��� NULL�� �ƴ϶� 10�� �������� NULL ó�� 
*Ư���� ������ �ƴϸ� �׷��Լ� ��� ����� nulló���� �ϴ°��� ���ɻ� ���� 

NVL(SUM(comm),0) : comm �÷��� sum �׷� �Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��)
SUM(NVL(comm,0)) : ��� comm�÷��� NVL�Լ��� ������ (�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����

SELECT deptno, NVL(SUM(comm),10)
FROM emp
GROUP BY deptno;

single row �Լ��� where ���� ����� �� ������ 
multi row �Լ�(GROUP�Լ�)�� where ���� ����� �� ���� 
GROUP BY �� ���� HAVING���� ������ ���

SELECT*
FROM emp
WHERE LOWER(ename) = 'smith';

�μ��� �޿� ���� 5000�� �Ѵ� �μ��� ��ȸ 
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 9000
GROUP BY deptno;
-- ����
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;


SELECT
        MIN(sal), 
        MAX(sal), 
        ROUND(AVG(sal),2),
        SUM(sal),  
        COUNT(sal),
        COUNT(mgr),
        COUNT(*) 
FROM emp;

SELECT deptno,
        MAX(sal) MAX_SAL,
        MIN(sal) MIN_SAL,  
        ROUND(AVG(sal),2) AVG_SAL,
        SUM(sal) SUM_SAL,  
        COUNT(sal) COUNT_SAL,
        COUNT(mgr) COUNT_MGR,
        COUNT(*) COUNT_ALL 
FROM emp
GROUP BY deptno;

SELECT *
FROM dept;

SELECT  DECODE(deptno, 
        10,'ACCOUNTING',
        20,'RESEARCH',
        30,'SALES',
        'OPERATIONS') DNAME,
        MAX(sal) MAX_SAL,
        MIN(sal) MIN_SAL,  
        ROUND(AVG(sal),2) AVG_SAL,
        SUM(sal) SUM_SAL,  
        COUNT(sal) COUNT_SAL,
        COUNT(mgr) COUNT_MGR,
        COUNT(*) COUNT_ALL 
FROM emp 
GROUP BY deptno
ORDER BY deptno;

SELECT *
FROM dept;

SELECT TO_CHAR(hiredate,'YYYYMM')HIRE_YYYMM,
    count(hiredate)
FROM emp
GROUP BY hiredate
ORDER BY hiredate;

SELECT TO_CHAR(hiredate,'YYYY')HIRE_YYY,
    count(hiredate)CNT
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');

SELECT 
    COUNT(*)CNT
FROM dept;

SELECT 
    COUNT(COUNT(deptno)) CNT
FROM emp
GROUP BY deptno;







select *
from emp;