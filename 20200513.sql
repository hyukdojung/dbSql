CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM dept
WHERE 1= 1;

idx1]
CREATE UNIQUE INDEX idx_u_dept_01 ON DEPT_TEST2 (deptno);

ALTER TABLE dept DROP CONSTRAINT pk_dept;

CREATE INDEX idx_dept_02 ON DEPT_TEST2 (dname);

CREATE INDEX idx_dept_03 ON DEPT_TEST2 (deptno, dname);

idx2]
DROP INDEX idx_u_dept_01;

DROP INDEX idx_dept_02;

DROP INDEX idx_dept_03;

idx3]

CREATE INDEX idx_emp_01 ON emp (empno, ename, deptno);

CREATE INDEX idx_emp_02 ON emp (deptno, sal);

CREATE INDEX idx_emp_03 ON emp (deptno, mgr, hiredate);

DROP INDEX idx_emp_04;

idx4]

과제 


수행계획 

수업시간에 배운 조인 
===> 논리적 조인 형태를 이야기 함, 기술적인 이야기가 아님
inner join : 조인에 성공하는 데이터만 조회하는 조인 기법
outer join : 조인에 실패해도 기준이되는 테이블의 컬럼정보는 조회하는 조인 기법
cross join : 묻지마 조인 (카티션 프러덕트), 조인 조건을 기술하지 않아서 
            연결가능한 모든 경우의 수로 조인되는 기법
self join : 같은 테이블 끼리 조인하는 형태

개발자가 DBMS에 SQL을 실행 요청 하면 DBMS는 SQL을 분석해서 
어떻게 두 테이블 연결할 지를 결정, 3가지 방식의 조인 방식(물리적 조인 방식, 기술적인 이야기)
1. Nested Loop Join  // OLTP 환경에서 최적화 , 소량의 데이터 조회시 유리 
2. Sort Merge Join  //  조인컬럼에 인덱스가 없을경우, 대량의 데이터 조회시 (조인컬럼으로 정렬, 정렬이 끝나야 연결이 가능 응담느림)
3. Hash Join    //  조인컬럼의 값을 그대로 사용 x 해시함수로 돌린 값을 사용, 조건이 아닌 조인조건에 대해서는 사용불가

OnLine Transaction Processing : 실시간 처리 ==> 응답이 빨라야 하는 시스템(일반적인 웹 서비스)
OnLine Analysis processsing : 일괄처리 ==> 전체 처리속도가 중요한 경우
                                                (은행 이자 계산, 새벽 한번에 계산)

