ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY�� ����

�Ʒ� ������ ����׷�
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY => ��ü

ROLLUP ���� �����Ǵ� ����׷��� ���� : ROLLUP�� ����� �÷��� + 1;
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job,deptno);

SELECT NVL(job,'�Ѱ�')job, deptno, 
        GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job,deptno);


SELECT  CASE
            WHEN GROUPING(job) = 1 THEN '�Ѱ�'
            ELSE job
        END job,
        deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job,deptno);


SELECT
DECODE( GROUPING(job), 1, '��', job) job,
DECODE( GROUPING(job)+GROUPING(deptno), 2, '��', 1,'�Ұ�',TO_CHAR(deptno)) deptno
FROM emp
GROUP BY ROLLUP (job,deptno);

SELECT deptno, job, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno,job);

ROLLUP ���� ����Ǵ� �÷��� ������ ��ȸ ����� ������ ��ģ�� 
****** ���� �׷��� ����� �÷��� ������ ���� ������ �����鼭 ����
GROUP BY ROLLUP job, deptno);
GROUP BY ROLLUP (deptno,job);

SELECT*
FROM dept;
--����
SELECT dname, job, SUM(sal) sal
FROM emp RIGHT OUTER JOIN dept ON(emp.deptno=dept.deptno)
GROUP BY ROLLUP (job, dname);

--�ǽ� 4 ����
SELECT dept.dname, a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
FROM emp
GROUP BY ROLLUP (deptno, job) )a, dept
WHERE a.deptno = dept.deptno(+);


SELECT NVL(dept.dname,'����'), a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
FROM emp
GROUP BY ROLLUP (deptno, job) )a, dept
WHERE a.deptno = dept.deptno(+);


1. GROUPING SETS
ROLLUP�� ���� : ���ɾ��� ����׷쵵 ���� �ؾ��Ѵ�. 
                ROLLUP���� ����� �÷��� �����ʿ��� ���������� ������
                ���� �߰������� �ִ� ����׷��� ���ʿ� �� ��� ����.
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
                ROLLUP���� �ٸ��� ���⼺�� ���� . 

���� : GROUP BY GROUPING SETS (col1,col2)
GROUP BY cal1
UNION ALL
GROUP BY cal2



SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

�׷������
1. job, deptno
2. mgr

GROUP BY GROUPING SETS ( (job, deptno), mgr)

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ( (job, deptno), mgr);


SELECT job, deptno, null, SUM(sal)
FROM emp
GROUP BY job, deptno

UNION ALL

SELECT null, null, mgr, SUM(sal)
FROM emp
GROUP BY deptno;



REPORT GROUP FUNCTION ==> Ȯ��� GROUP BY 
REPORT GROUP FUNCTION �� ����� ���ϸ� 
�������� SQL�ۼ�, UNION ALL�� ���ؼ� �ϳ��� ����� ��ġ�� ����
==> ���� ���ϰ� �ϴ� �� REPORT GROUP FUNCTION .


3. CUBE
���� : GROUP BY CUBE (cal1, cal2)
����� �÷��� ������ ��� ����(������ ��Ų��)

GROUP BY CUBE (job, deptno);
1.      2.
job     deptno
job       x
x       deptno
x         x


GROUP BY CUBE (job, deptno, mgr);
1.          2.          3.
job     deptno          mgr
job     deptno          x
job      x              mgr
job      x              x
x       deptno          mgr
x        x              x
x       deptno          mgr
x        x              x

SELECT job, deptno, SUM(sal) ****�߿俹�� 
FROM emp
GROUP BY CUBE (job, deptno);


������ ���� �м� ppt. p38

�������� REPORT GROUP ����ϱ� 
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**�߻� ������ ������ ���
1       2       3
job     deptno  mgr ==> GROUP BY job, deptno, mgr
job     x       mgr ==> GROUP BY job, mgr
job     deptno  x   ==> GROUP BY job, deptno
job     x       x   ==> GROUP BY job

������ ��ĥ�ϱ�
SELECT job, deptno, mgr, SUM(sal+NVL(comm,0))sal
FROM emp
GROUP BY job, ROLLUP(job,deptno), CUBE(mgr);

��ȣ ���� ���� ���� - ������������ ���� ������ ����ϴ°�(���������� ���� ����� ������ �߻� ��Ų��.)

��ȣ���� �������� ������Ʈ
1. emp ���̺��� �׿��Ͽ� emp_test���̺� ����
    =>������ ������ emp_test���̺� ���� ���� ����
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT*
FROM emp;

2. emp_test ���̺� dname�÷� �߰� (dept ���̺� ����)
ALTER TABLE emp_test ADD(dname VARCHAR2(14));

DESC dept;
SELECT*
FROM emp_test;


3. subquety�� �̿��Ͽ� emp_test���̺� �߰��� dname �÷��� ������Ʈ ���ִ� ���� �ۼ�
*emp_test �� dname �÷��� ���� dept���̺��� dname�÷����� update
emp_test���̺��� deptno���� Ȯ���ؼ� dept���̺��� deptno���̶� ��ġ�ϴ� dname�÷����� ������ update

emp_test���̺��� dname�÷��� dept ���̺��̿��ؼ� dname�� ��ȸ�Ͽ� ������Ʈ
update ����� �Ǵ� ��: 14 == �������� ����� ���� ����

��� ������ ������� dname�÷��� dept���̺��� ��ȸ�Ͽ� ������Ʈ
UPDATE emp_test SET dname = (SELECT dname
                            FROM dept
                            WHERE emp_test.deptno = dept.deptno)

DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT*
FROM dept;

DESC dept;
ALTER TABLE dept_test ADD(empcnt NUMBER);



UPDATE dept_test SET empcnt = (SELECT count(*)
                                FROM emp
                                WHERE dept_test.deptno = emp.deptno);

SELECT*
FROM dept_test;

SELECT count(deptno)
FROM emp
GROUP BY deptno;

SELECT ��� ��ü�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ���� .
SELECT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;