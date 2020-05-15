ROLLUP : 서브그룹 생성 - 기술된 컬럼을 오른쪽에서부터 지워나가면 GROUP BY를 실행

아래 쿼리의 서브그룹
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY => 전체

ROLLUP 사용시 생성되는 서브그룹의 수는 : ROLLUP에 기술한 컬럼수 + 1;
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job,deptno);

SELECT NVL(job,'총계')job, deptno, 
        GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job,deptno);


SELECT  CASE
            WHEN GROUPING(job) = 1 THEN '총계'
            ELSE job
        END job,
        deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job,deptno);


SELECT
DECODE( GROUPING(job), 1, '총', job) job,
DECODE( GROUPING(job)+GROUPING(deptno), 2, '계', 1,'소계',TO_CHAR(deptno)) deptno
FROM emp
GROUP BY ROLLUP (job,deptno);

SELECT deptno, job, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno,job);

ROLLUP 절에 기술되는 컬럼의 순서는 조회 결과에 영향을 미친다 
****** 서브 그룹을 기술된 컬럼의 오른쪽 부터 제거해 나가면서 생성
GROUP BY ROLLUP job, deptno);
GROUP BY ROLLUP (deptno,job);

SELECT*
FROM dept;
--실패
SELECT dname, job, SUM(sal) sal
FROM emp RIGHT OUTER JOIN dept ON(emp.deptno=dept.deptno)
GROUP BY ROLLUP (job, dname);

--실습 4 정답
SELECT dept.dname, a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
FROM emp
GROUP BY ROLLUP (deptno, job) )a, dept
WHERE a.deptno = dept.deptno(+);


SELECT NVL(dept.dname,'총합'), a.job, a.sum_sal
FROM
(SELECT deptno, job, SUM(sal) sum_sal
FROM emp
GROUP BY ROLLUP (deptno, job) )a, dept
WHERE a.deptno = dept.deptno(+);


1. GROUPING SETS
ROLLUP의 단점 : 관심없는 서브그룹도 생성 해야한다. 
                ROLLUP절에 기술한 컬럼을 오른쪽에서 지워나가기 때문에
                만약 중간과정에 있는 서브그룹이 불필요 할 경우 낭비.
GROUPING SETS : 개발자가 직접 생성할 서브그룹을 명시
                ROLLUP과는 다르게 방향성이 없다 . 

사용법 : GROUP BY GROUPING SETS (col1,col2)
GROUP BY cal1
UNION ALL
GROUP BY cal2



SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

그룹기준을
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



REPORT GROUP FUNCTION ==> 확장된 GROUP BY 
REPORT GROUP FUNCTION 을 사용을 안하면 
여러개의 SQL작성, UNION ALL을 통해서 하나의 결과로 합치는 과정
==> 좀더 편하게 하는 게 REPORT GROUP FUNCTION .


3. CUBE
사용법 : GROUP BY CUBE (cal1, cal2)
기술된 컬럼의 가능한 모든 조합(순서는 지킨다)

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

SELECT job, deptno, SUM(sal) ****중요예제 
FROM emp
GROUP BY CUBE (job, deptno);


가능한 조합 분석 ppt. p38

여러개의 REPORT GROUP 사용하기 
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**발생 가능한 조합을 계산
1       2       3
job     deptno  mgr ==> GROUP BY job, deptno, mgr
job     x       mgr ==> GROUP BY job, mgr
job     deptno  x   ==> GROUP BY job, deptno
job     x       x   ==> GROUP BY job

엑셀에 색칠하기
SELECT job, deptno, mgr, SUM(sal+NVL(comm,0))sal
FROM emp
GROUP BY job, ROLLUP(job,deptno), CUBE(mgr);

상호 연관 서브 쿼리 - 서브쿼리에서 메인 쿼리를 사용하는것(서브쿼리만 따로 실행시 에러를 발생 시킨다.)

상호연관 서브쿼리 업데이트
1. emp 테이블을 잉요하여 emp_test테이블 생성
    =>기존에 생성된 emp_test테이블 삭제 먼저 진행
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT*
FROM emp;

2. emp_test 테이블에 dname컬럼 추가 (dept 테이블 참고)
ALTER TABLE emp_test ADD(dname VARCHAR2(14));

DESC dept;
SELECT*
FROM emp_test;


3. subquety를 이용하여 emp_test테이블에 추가된 dname 컬럼을 업데이트 해주는 쿼리 작성
*emp_test 의 dname 컬럼의 값을 dept테이블의 dname컬럼으로 update
emp_test테이블의 deptno값을 확인해서 dept테이블의 deptno값이랑 일치하는 dname컬럼값을 가져와 update

emp_test테이블의 dname컬럼을 dept 테이블이용해서 dname값 조회하여 업데이트
update 대상이 되는 행: 14 == 조건절을 기술을 하지 않음

모든 직원을 대상으로 dname컬럼을 dept테이블에서 조회하여 업데이트
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

SELECT 결과 전체를 대상으로 그룹 함수를 적용한 경우
대상되는 행이 없더라도 0값이 리턴

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY 절을 기술할 경우 대상이 되는 행이 없을 경우 조회되는 행이 없다 .
SELECT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;