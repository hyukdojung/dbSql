--���� ������ ������ ���̽� ���� ���̺��� ��ȸ �Ѵ�.

SELECT * from tab;   
--���ϴ� ���̺��� ������ ��ȸ�Ѵ�. 
DESC BONUS;

--�μ��� ��� ������ �����´� .
SELECT * 
from DEPT;

--����� ��� ������ �����´�. 
SELECT *
from emp;

--����� �̸��� ��� ��ȣ�� �����´�.
SELECT ename, empno
from emp;
--����� �̸��� �����ȣ, ����, �޿��� �����´�. 
SELECT ename, empno, job, sal
from emp;
--�μ� ��ȣ�� �μ� �̸��� �����´�. 
SELECT DEPTNO, DNAME
from DEPT;

--�� ������� �޿��װ� �޿��׿��� 1000�� ���� ��, 200�� �� ��, 2�� ���� ��, 2�� ���� ���� �����´� .
SELECT sal, sal+1000, sal-200, sal*2, sal/2 
from emp;

--�� ����� �޿���, Ŀ�̼�, �޿�+Ŀ�̼� �׼��� �����´�. 
SELECT sal, nvl(comm, 0), sal+nvl(comm, 0)
from emp;

--������� �̸��� ������ ���� ������� �����´�. 
--00����� ��� ������ xxx�Դϴ�. 

SELECT ename || '����� ������'|| job||'�Դϴ�'
from emp;

--������� �ٹ��ϰ� �ִ� �ٹ� �μ��� ��ȣ�� �����´� .

SELECT DISTINCT  DEPTNO
from emp;

--�ٹ� �μ��� 10���� ������� �����ȣ, �̸�, �ٹ� �μ��� �����´� .

SELECT empno, ename, deptno
FROM emp
where deptno = 10;

--�ٹ� �μ� ��ȣ�� 10���� �ƴ� ������� �����ȣ, �̸�, �ٹ� �μ� ��ȣ�� �����´� .
SELECT empno, ename, deptno
FROM emp
WHERE deptno <> 10;

--�޿��� 1500�̻��� ������� �����ȣ, �̸�, �޿��� �����´�. 
SELECT empno, ename, sal
FROM emp
WHERE sal >= 1500;

--�̸��� SCOTT ����� �����ȣ, �̸�, ����, �޿��� �����´� 
SELECT empno, ename, job, sal
FROM emp
WHERE ename = 'SCOTT';

--������ SALESMAN�� ����� ������ȣ, �̸�, ������ �����´�. 
SELECT empno, ename, job
FROM emp
WHERE job = 'SALESMAN';

--������ CLERK�� �ƴ� ����� �����ȣ, �̸�, ������ �����´�. 
SELECT empno, ename, job
FROM emp
WHERE job <> 'CLERK';

--1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �����ȣ �̸�, �Ի����� �����´�.
SELECT empno, ename, HIREDATE
FROM emp
WHERE HIREDATE >= '1982/01/01';

--10�� �μ����� �ٹ��ϰ� �ִ� ������ MANAGER�� ����� �����ȣ, �̸�, �ٹ��μ�, ������ �����´�. 
SELECT empno, ename, deptno, job
FROM emp
WHERE DEPTNO = 10 and job = 'MANAGER';

--�Ի�⵵�� 1981���� ����߿� �޿��� 1500 �̻��� ����� �����ȣ, �̸�, �޿�, �Ի����� �����´�. 
SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate >= '1981/01/10' and hiredate <= '1981/12/31' and sal>=1500;

--20�� �μ��� �ٹ��ϰ� �ִ� ��� �߿� �޿��� 1500 �̻��� ����� �����ȣ, �̸�, �μ���ȣ, �޿��� �����´� .

SELECT empno, ename, deptno, sal 
FROM emp
WHERE deptno= 20 and sal>= 1500;

--���ӻ�� ��� ��ȣ�� 7698�� ����߿� ������ CLERK�� ����� �����ȣ, �̸�, ���ӻ����ȣ, ������ �����´� .

SELECT empno, ename, mgr, job
FROM emp
WHERE mgr = 7698 and job = 'CLERK';

--�޿��� 2000���� ũ�ų� 1000���� ���� ����� �����ȣ, �̸�, �޿��� �����´�.
SELECT empno, ename, sal    
FROM emp
WHERE not(sal<=2000 and sal>=1000);

SELECT empno, ename, sal    
FROM emp
WHERE not(sal between 1000 and 2000);
--�μ���ȣ�� 20�̰ų� 30�� ����� �����ȣ, �̸�, �μ���ȣ�� �����´� .
SELECT
FROM emp
WHERE
--������ CLERK, SALESMAN, ANALYST�� ����� �����ȣ, �̸�, ������ �����´�. 
SELECT
FROM emp
WHERE