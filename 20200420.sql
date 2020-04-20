--table 에는 조회/저장 순서가 없다 
==> ORDER BY 컬럼명 정렬방식,...
참고*
ORDER BY 컬럼순서 번호 로 정렬 가능
==>SELECT 컬럼의 순서가 바뀌거나, 컴럼 추가가 되면 원래의도대로 동작하지 않을 가능성이 있음
SELECT*
FROM emp
ORDER BY 3;

별칭으로 정렬
컬럼에다가 연산을 통해 새로운 컬럼을 만드는 경우
SAL*DEPTNO SAL_DEPT

SELECT empno, ename, sal, deptno, sal*deptno sal_dept
FROM emp
ORDER BY sal_dept;

SELECT*
FROM dept
ORDER BY deptno;

SELECT*
FROM dept
ORDER BY deptno DESC;

SELECT*
FROM dept
ORDER BY dname;

SELECT*
FROM dept
ORDER BY loc desc;


&& = AND
리터럴 
    숫자:숫자
    문자:'문자'

SELECT*
FROM emp
WHERE comm > 0
ORDER BY empno desc, empno;


SELECT*
FROM emp
WHERE comm != 0     -- NULL은 연산시 자동 제외 되어진다.
ORDER BY comm desc, empno ;

SELECT*
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno desc;

SELECT*
FROM emp
WHERE (deptno = 10 or deptno = 30)
AND sal > 1500
ORDER BY ename desc;

페이징 처리를 하는 이유 
1. 데이터가 너무 많으니까 
 . 한화면에 담으면 사용성이 떨어짐
 . 성능면에서 느려짐
오라클에서 페이징 처리 방법 ==> ROWNUM

ROWNUM : SELECT 순서대로 1번부터 차례대로 번호를 부여해주는 특수 KEYWORD

SELECT절에 *표기하고 콤마를 통해 
다른 표현(ROWNUM)을 기술할경우 
*앞에 어떤 테이블에 대한건지 테이블 명칭/별칭을 기술해야한다. 
SELECT ROWNUM, e.*
FROM emp e;


페이징 처리를 위해 필요한 사항: 
1. 페이지 사이즈 [10]
2. 데이터 정렬 기준
1page: 1~10
2page: 11~20 (11~14)

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

2 페이징 쿼리
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20;

ROWNUM의 특징
1. ORACLE에만 존재 
    . 다른 DBMS의 경우 페이징 처리를 위한 별도의 키워드가 제공 (LIMIT)
2. 1부터 순차적으로 읽는경우만 가능
    ROWNUM BETWEEN 1 AND 10 >> 1~10
    ROWNUM BETWEEN 11 AND 20 >> 1~10을 SKIP하고 11~20를 읽으려고 시도 
    
    WHERE 절에서 ROWNUM을 사용할 경우 다음 형태 
    ROWNUM = 1;
    ROWNUM BETWEEN 1 AND N
    ROWNUM <, <= N (1,N)
    
ROWNUM과 ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY empno;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

ROWNUM은 ORDER BY 이전에 실행
SELECT > ROWNUM > ORDER BY

ROWNUM의 실행순서에 의해 정렬이 된상태로 ROWNUM을 부여하면 IN-LINE VIEW를 사용해야 한다.
**IN-LINE : 직접 기술을 했다.;

SELECT ROWNUM, a.*
FROM
(SELECT ROWNUM rn, e.*
FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) e) a
WHERE rn BETWEEN 1+(:page -1)*:pageSize AND :page * :pageSize;
-- 괄호 부분이 IN-LINE VIEW
WHERE rn BETWEEN 1 AND 10; 1page
WHERE rn BETWEEN 2 AND 20; 2page
WHERE rn BETWEEN 3 AND 30; 3page
.
.
WHERE rn BETWEEN 1+(n-1)*10 AND pageSize * n; n page

복습
SELECT*
FROM
(SELECT empno, ename
    FROM emp
    ORDER BY ename);
--ORDER BY 실행 순서로 인해 

INLINE - view와 비교를 위해 view를 직접 생성 (선행학습, 나중에 나옴)
view - 쿼리 (view 테이블 - x)
----------------------------------------------------------------------------
DML - Data Manipulation Language : SELECT, INSERT, UPDATE, DELETE
DDL - Data Definition Language : CREATE, DROP, MODIFY, RENAME
CREATE OR REPLACE VIEW emp_ord_by_ename AS
    SELECT empno, ename
    FROM emp
    ORDER BY ename;

SELECT*
FROM (SELECT empno, ename
    FROM emp
        ORDER BY ename);

view로 작성한 쿼리 
SELECT*
FROM emp_ord_by_ename;

----------------------------------------------------------------------------------

emp 테이블에 데이터를 추가하면 
in - line view, view를 사용한 쿼리의 결과는 어떻게 영향을 받을까??

INSERT emp (empno, ename) VALURES (9999, '브라운');
SELECT empno, ename
FROM emp;

쿼리 작성시 문제점 찾아가기 
java : 디버깅
SQL : 디버깅 툴이 없음 

페이징 처리 ==> 정렬작업, ROWNUM
정렬, ROWNUM을 하나의 쿼리에서 실행할 경우 ROWNUM잏 정렬을 하여 숫자가 섞이는 현상 >> INLINE- VIEW
    정렬에 대한 INLINE_VIEW
    ROWNUM에 대한 INLINE_VIEW
    
    
    
SELECT *
FROM
(SELECT ROWNUM rn, a.*
 FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a )
WHERE rn BETWEEN 11 AND 20;



SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 14;

SELECT *
FROM
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT *
        FROM prod
        ORDER BY PROD_LGU desc, PROD_COST) a)
WHERE rn BETWEEN 1+(:page -1)*:pageSize AND :page * :pageSize;
























