SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY ROLLUP (detpno, job);

����׷� ���� ���
ROLLUP : �ڿ��� (�����ʿ���) �ϳ��� �������鼭 ����׷��� ����
        ==> (deptno, job), deptno, (ALL)

CUBE: ������ ��� ����

GROUP BY SET :�����ڰ� ����׷� ������ ���� ���

sub_a2]
DROP TABLE dept_test;

SELECT*
FROM dept;

CREATE TABLE dept_test AS
SELECT*
FROM dept;


insert into dept_test values(99, 'it1', 'daejeon');
insert into dept_test values(98, 'it2', 'daejeon');

SELECT*
FROM dept_test;


DELETE dept_test d
WHERE NOT EXISTS 
    ( SELECT 'x'
        FROM emp e
        WHERE d.deptno = e.deptno);

ROLLBACK;

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT*
FROM emp;

UPDATE emp_test a SET sal = sal+ 200  
WHERE sal < (SELECT ROUND(AVG(SAL),2)sal
                FROM emp_test b
                WHERE a.deptno = b.deptno
                GROUP BY deptno);
               
SELECT*
FROM emp_test;

���Ŀ��� �ƴ�����, �˻�-������ ���� ������ ǥ��
���������� ���� ���
1. Ȯ���� : ��ȣ���� ��������(EXISTS)
        ==>���� ���� ���� ���� ==> �������� ����
2. ������ : ���������� ���� ����Ǽ� ���������� ���� ���� ���ִ� ����

13�� : �Ŵ����� �����ϴ� ������ ��ȸ
SELECT*
FROM emp
WHERE mgr IN (SELECT empno
                    FROM emp);
                    
SELECT*
FROM emp
WHERE mgr IN (7369,7499,7521....);

�μ��� �޿������ ��ü �޿���պ��� ū �μ��� �μ���ȣ, �μ��� �޿���� ���ϱ�

�μ��� ��� �޿� (�Ҽ��� ��° �ڸ����� ��� �����)
SELECT deptno ,round(AVG(sal),2)
FROM emp
GROUP BY deptno;

��ü �޿� ���
SELECT ROUND(AVG(sal),2)
FROM emp;


SELECT deptno ,round(AVG(sal),2)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),2) > (SELECT ROUND(AVG(sal),2)
                            FROM emp);

WITH �� : SQL���� �ݺ������� ������ QUERY BLOCK(SUBQUERY)�� ������ �����Ͽ� 
        SQL ����� �ѹ��� �޸𸮿� �ε��� �ϰ� �ݺ������� ����Ҷ� �޸� ������ �����͸� 
        Ȱ���Ͽ� �ӵ� ������ �� �� �ִ� KEYWORD
        ��, �ϳ��� SQL���� �ݺ����� SQL���� ������ ���� �߸� �ۼ��� SQL�� ���ɼ��� ���� ������ 
        �ٸ� ���·� ������ �� �ִ����� �����غ��°��� ��õ.
        
WITH emp_avg_sal AS(
    SELECT ROUND(AVG(sal),2)
    FROM emp
    )
SELECT deptno ,round(AVG(sal),2),(SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),2) > (SELECT *
                            FROM emp_avg_sal);
��������
CONNECT BY LEVEL : ���� �ݺ��ϰ� ���� ����ŭ ������ ���ִ� ���
��ġ : FROM(WHERE)�� ������ ���
DUAL ���̺� ���� ���

���̺� ���� �Ѱ�, �޸𸮿��� ����
SELECT LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

���� ���� ���� �̹� ��� KEYWORD�� �̿��Ͽ� �ۼ� ����
5�� �̻��� �����ϴ� ���̺��� ���� ���� ���� 
���࿡ �츮�� ������ �����Ͱ� 10000���̸� 10000�ǿ� ���� DISK I/O�� �߻�

SELECT ROWNUM
FROM emp
WHERE ROWNUM <=5;


1. �츮���� �־��� ���ڿ� ��� : 202005
    �־��� ����� �ϼ��� ���Ͽ� �ϼ��� ���� ����
SELECT LEVEL
FROM dual
CONNECT BY LEVEL <=31;

SELECT TO_DATE('202005','yyyymm'),LEVEL,
        TO_DATE('202005','yyyymm') + LEVEL
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005','yyyymm')),'dd');

SELECT TO_CHAR(LAST_DAY(TO_DATE('202005','yyyymm')),'dd')
FROM dual;


�޷��� �÷��� 7�� - �÷��� ������ ���� : Ư�����ڴ� �ϳ��� ���Ͽ� ����
SELECT TO_DATE('202005','yyyymm') + (LEVEL-1) dt, 7���� �÷��� �߰��� ����
    �Ͽ����̸� dt �÷� �������̸� dt �÷� ȭ�����̸� dt....������̸� dt �÷�
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005','yyyymm')),'dd');

�Ʒ��� ������� SQL�� �ۼ��ص� ���� �ϼ��� �����ϳ�
������ ���鿡�� �ʹ� �����Ͽ� �ζ��κ並 �̿��Ͽ� ������ ���� �ܼ��ϰ� �����. 
SELECT TO_DATE('202005','yyyymm') + (LEVEL-1) dt,
        DECODE(TO_CHAR(TO_DATE('202005','yyyymm')+(LEVEL-1),'D'),'1',TO_DATE('202005','yyyymm') + (LEVEL-1),'��'),
        DECODE(TO_CHAR(TO_DATE('202005','yyyymm')+(LEVEL-1),'D'),'2',TO_DATE('202005','yyyymm') + (LEVEL-1),'ȭ'),
        DECODE(TO_CHAR(TO_DATE('202005','yyyymm')+(LEVEL-1),'D'),'3',TO_DATE('202005','yyyymm') + (LEVEL-1),'��'),
        DECODE(TO_CHAR(TO_DATE('202005','yyyymm')+(LEVEL-1),'D'),'4',TO_DATE('202005','yyyymm') + (LEVEL-1),'��'),
        DECODE(TO_CHAR(TO_DATE('202005','yyyymm')+(LEVEL-1),'D'),'5',TO_DATE('202005','yyyymm') + (LEVEL-1),'��'),
        DECODE(TO_CHAR(TO_DATE('202005','yyyymm')+(LEVEL-1),'D'),'6',TO_DATE('202005','yyyymm') + (LEVEL-1),'��'),
        DECODE(TO_CHAR(TO_DATE('202005','yyyymm')+(LEVEL-1),'D'),'7',TO_DATE('202005','yyyymm') + (LEVEL-1),'��')
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005','yyyymm')),'dd');

�÷��� ����ȭ �Ͽ� ǥ��
TO_DATE('202005','yyyymm') ==> dt

SELECT dt, dt�� �������̸� dt�� ȭ�����̸� dt 1���� �÷��߿� �� �ϳ��� �÷����� dt ���� ǥ���ȴ�. 
FROM
(SELECT TO_DATE('202005','yyyymm') + (LEVEL-1) dt
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005','yyyymm')),'dd'));

SELECT dt, d
FROM
(SELECT TO_DATE('202005','yyyymm') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE('202005','yyyymm')+(LEVEL-1),'D') d
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005','yyyymm')),'DD'));





------------------------------------------------------------------------
SELECT DECODE(d,1,iw+1,iw),
            MIN(DECODE(d,1,dt)) sun, MIN(DECODE(d,2,dt)) mon,
            MIN(DECODE(d,3,dt)) tue, MIN(DECODE(d,4,dt)) wed, 
            MIN(DECODE(d,5,dt)) thu, MIN(DECODE(d,6,dt)) fri, 
            MIN(DECODE(d,7,dt)) sat
FROM
(SELECT TO_DATE(:yyyymm,'yyyymm') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm,'yyyymm')+(LEVEL-1),'D') d,
        TO_CHAR(TO_DATE(:yyyymm,'yyyymm')+(LEVEL-1),'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'DD'))
 GROUP BY DECODE(d,1,iw+1,iw)
 ORDER BY DECODE(d,1,iw+1,iw) ;
------------------------------------------------------------------------
SELECT 
            MIN(DECODE(d,1,dt)) sun, MIN(DECODE(d,2,dt)) mon,
            MIN(DECODE(d,3,dt)) tue, MIN(DECODE(d,4,dt)) wed, 
            MIN(DECODE(d,5,dt)) thu, MIN(DECODE(d,6,dt)) fri, 
            MIN(DECODE(d,7,dt)) sat
FROM
(SELECT TO_DATE(:yyyymm,'yyyymm') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm,'yyyymm')+(LEVEL-1),'D') d,
        TO_CHAR(TO_DATE(:yyyymm,'yyyymm')+(LEVEL-1),'iw') iw,
        CEIL(LEVEL / 7) weekn
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')),'DD'))
 GROUP BY weekn
 ORDER BY weekn ;

