EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT*
FROM TABLE(dbms_xplan.display);

ROWID: ���̺� ���� ����� �����ּ�
        (java - �ν��Ͻ� ����
            c - ������ ) 
        
SELECT ROWID, emp.*
FROM emp;

����ڿ� ���� ROWID ���
SELECT*
FROM emp
WHERE ROWID = 'AAAE56AAFAAAAE9AAF';




SELECT*
FROM TABLE(dbms_xplan.display);

INDEX �ǽ�
emp���̺� ���� ������ pk_emp PRIMARY KEY ���������� ���� 

ALTER TABLE emp DROP CONSTRAINT pk_emp;

�ε��� ���� empno���� �̿��Ͽ� ������ ��ȸ
EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = 7782;

SELECT*
FROM TABLE(dbms_xplan.display);

Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)
   
2. emp ���̺� empno �÷����� PRIMARY KEY �������� ���� �� ��� 
            (empno�÷����� ������ unique �ε����� ���� 

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = 7782;

SELECT*
FROM TABLE(dbms_xplan.display);

Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)

3. 2�� SQL�� ����(SELECT �÷��� ����)

2��
SELECT*
FROM emp
WHERE empno = 7782;

3��
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT*
FROM TABLE (dbms_xplan.display);

Plan hash value: 56244932
 
----------------------------------------------------------------------------
| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |     1 |     4 |     0   (0)| 00:00:01 |
|*  1 |  INDEX UNIQUE SCAN| PK_EMP |     1 |     4 |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("EMPNO"=7782)
   
4.empno �÷��� non-unique �ε����� �����Ǿ� �ִ� ���

ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX idx_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT*
FROM TABLE (dbms_xplan.display);

Plan hash value: 4208888661
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)
   
   
5. emp ���̺��� job���� ��ġ�ϴ� �����͸� ã�� ������
�����ε���
idx_emp_01 : empno

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE job = 'MANAGER';

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     3 |   114 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     3 |   114 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("JOB"='MANAGER')
   
   
idx_emp_01�� ��� ������ empno�÷� �������� �Ǿ� �ֱ� ������ job�÷��� �����ϴ� SQL������
ȿ�������� ����� ���� ���� ������ TABLE ��ü �����ϴ� ������ �����ȹ�� ������

==> idx_emp_02 (job) ������ ���� �����ȹ ��
CREATE INDEX idx_emp_02 ON emp (job);

SELECT*
FROM TABLE (dbms_xplan.display);

6. emp���̺��� job = 'MANAGER' �̸鼭 ename �� C�� �����ϴ� ����� ��ȸ 
�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job='MANAGER'
AND ename LIKE 'c%';

SELECT*
FROM TABLE (dbms_xplan.display);

Plan hash value: 2549950125
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'c%')
       filter("ENAME" LIKE 'c%')
 

7. emp���̺��� job = 'MANAGER' �̸鼭 ename �� C�� �����ϴ� ����� ��ȸ (��ü �÷���ȸ)
�� ���ο� �ε��� �߰� : idx_emp_03 : job, ename

CREATE INDEX idx_emp_03 ON emp (job,ename);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job='MANAGER'
AND ename LIKE 'c%';

SELECT*
FROM TABLE (dbms_xplan.display);

Plan hash value: 2549950125
 
------------------------------------------------------------------------------------------
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    38 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    38 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'c%')
       filter("ENAME" LIKE 'c%')




8. emp���̺��� job = 'MANAGER' �̸鼭 ename �� C�� �����ϴ� ����� ��ȸ (��ü �÷���ȸ)
 �ε��� ��Ȳ 
 idx_emp_01 : empno
 idx_emp_02 : job
 idx_emp_03 : job, ename

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE job = 'MANAGER'
    AND ename LIKE '%C';
    
SELECT*
FROM TABLE(dbms_xplan.display);

RULE BASED OPTIMITER : ��Ģ��� ����ȭ�� (9i) ==> ����ī�޶� 
COST BASED OPTIMITER : ����� ����ȭ�� (10g) ==> �ڵ� ī�޶� 


9.���� �÷� �ε����� �÷� ������ �߿伺
�ε��� ���� �÷� : (job, name) VS (ename, job)
*** �����ؾ� �ϴ� sql�� ���� �ε��� �÷������� �����ؾ��Ѵ�. 

���� sql : job='MANAGER', ename�� c�� �����ϴ� ��������� ��ȸ
���� �ε��� ���� : idx_emp_03;
DROP INDEX  idx_emp_03;

�ε��� �ű� ����
idx_emp_04 : ename, job

CREATE INDEX idx_emp_04 ON emp (ename,job);

SELECT job, ROWID
FROM emp
ORDER BY job;

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idx_emp_04 : ename, job

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE job = 'MANAGER'
    AND ename LIKE '%C';
    
SELECT*
FROM TABLE(dbms_xplan.display);

���ο����� �ε���
idx_emp_01 ���� (pk_emp �ε����� �ߺ�)
DROP INDEX idx_emp_01;

emp ���̺� empno �÷��� PRIMARY KEY�� �������� ����
pk_emp : empno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

�ε��� ��Ȳ
idx_emp : empno
idx_emp_02 : job
idx_emp_04 : ename, job


EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE  emp.deptno = dept.deptno
    AND emp.empno=7788;

Plan hash value: 2385808155
 
----------------------------------------------------------------------------------------
| Id  | Operation                    | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |         |     1 |    57 |     2   (0)| 00:00:01 |
|   1 |  NESTED LOOPS                |         |     1 |    57 |     2   (0)| 00:00:01 |
|   2 |   TABLE ACCESS BY INDEX ROWID| EMP     |     1 |    38 |     1   (0)| 00:00:01 |
|*  3 |    INDEX UNIQUE SCAN         | PK_EMP  |     1 |       |     0   (0)| 00:00:01 |
|   4 |   TABLE ACCESS BY INDEX ROWID| DEPT    |     5 |    95 |     1   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN         | PK_DEPT |     1 |       |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("EMP"."EMPNO"=7788)
   5 - access("EMP"."DEPTNO"="DEPT"."DEPTNO")
   
   
NESTED LOOP JOIN
HASH JOIN
SORT MERGE JOIN

    
SELECT*
FROM TABLE(dbms_xplan.display);


�ε����� ����, ������ �������ָ� ã�����ϴ� �����͸� ���� ������ �˻� �����ϴ�
(���̺��� ��� ��ĵ�� �ʿ���� �ε���(����)�� Ȱ�� ) �����ȹ�����  ������ ������� ����Ǵ��� Ȯ�� ����

date of date meta date