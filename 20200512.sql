EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT*
FROM TABLE(dbms_xplan.display);

ROWID: 테이블 행이 저장된 물리주소
        (java - 인스턴스 변수
            c - 포인터 ) 
        
SELECT ROWID, emp.*
FROM emp;

사용자에 의한 ROWID 사용
SELECT*
FROM emp
WHERE ROWID = 'AAAE56AAFAAAAE9AAF';




SELECT*
FROM TABLE(dbms_xplan.display);

INDEX 실습
emp테이블에 어제 생성한 pk_emp PRIMARY KEY 제약조건을 삭제 

ALTER TABLE emp DROP CONSTRAINT pk_emp;

인덱스 없이 empno값을 이용하여 데이터 조회
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
   
2. emp 테이블에 empno 컬럼으로 PRIMARY KEY 제약조건 생성 한 경우 
            (empno컬럼으로 생성된 unique 인덱스가 존재 

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

3. 2번 SQL을 번형(SELECT 컬럼을 변형)

2번
SELECT*
FROM emp
WHERE empno = 7782;

3번
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
   
4.empno 컬럼에 non-unique 인덱스가 생성되어 있는 경우

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
   
   
5. emp 테이블의 job값이 일치하는 데이터를 찾고 싶을때
보유인덱스
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
   
   
idx_emp_01의 경우 정렬이 empno컬럼 기준으로 되어 있기 때문에 job컬럼을 제한하는 SQL에서는
효과적으로 상요할 수가 없기 때문에 TABLE 전체 접근하는 형태의 실행계획이 세워짐

==> idx_emp_02 (job) 생성을 한후 실행계획 비교
CREATE INDEX idx_emp_02 ON emp (job);

SELECT*
FROM TABLE (dbms_xplan.display);

6. emp테이블에서 job = 'MANAGER' 이면서 ename 이 C로 시작하는 사원만 조회 
인덱스 현황
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
 

7. emp테이블에서 job = 'MANAGER' 이면서 ename 이 C로 시작하는 사원만 조회 (전체 컬럼조회)
단 새로운 인덱스 추가 : idx_emp_03 : job, ename

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




8. emp테이블에서 job = 'MANAGER' 이면서 ename 이 C로 시작하는 사원만 조회 (전체 컬럼조회)
 인덱스 현황 
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

RULE BASED OPTIMITER : 규칙기반 최적화기 (9i) ==> 수동카메라 
COST BASED OPTIMITER : 비용기반 최적화기 (10g) ==> 자동 카메라 


9.복합 컬럼 인덱스의 컬럼 순서의 중요성
인덱스 구성 컬럼 : (job, name) VS (ename, job)
*** 실행해야 하는 sql에 따라서 인덱스 컬럼순서를 조정해야한다. 

실행 sql : job='MANAGER', ename이 c로 시작하는 사원정보를 조회
기존 인덱스 삭제 : idx_emp_03;
DROP INDEX  idx_emp_03;

인덱스 신규 생성
idx_emp_04 : ename, job

CREATE INDEX idx_emp_04 ON emp (ename,job);

SELECT job, ROWID
FROM emp
ORDER BY job;

인덱스 현황
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

조인에서의 인덱스
idx_emp_01 삭제 (pk_emp 인덱스와 중복)
DROP INDEX idx_emp_01;

emp 테이블에 empno 컬럼을 PRIMARY KEY로 제약조건 생성
pk_emp : empno
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

인덱스 현황
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


인덱스는 목차, 목차를 설정해주면 찾고자하는 데이터를 보다 빠르게 검색 가능하다
(테이블을 모두 스캔할 필요없이 인덱스(목차)를 활용 ) 실행계획실행시  실행이 어떤식으로 진행되는지 확인 가능

date of date meta date