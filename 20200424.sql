emp 테이블에 등록된 직원들에게 보너스를 추가적으로 지급할 예정
해당 직원의 job이 'SALESMAN'일 경우 SAL에서 5%인상된 금액을 보너스로 지급 (ex: sal 100 > 105)
해당 직원의 job이 'MANAGER'이면서 deptno가 10이면 SAL에서 30%인상된 금액을 보너스로 지급 (ex: sal 100 > 105)
                                        그 외의 부서에 속하는 사람은 10%인상된 금액을 보너스로 지급
해당 직원의 job이 'PRESIDENT'일 경우 SAL에서 20%인상된 금액을 보너스로 지급 (ex: sal 100 > 105)
그 외 직원들은 sal만큼만 지급


SELECT empno, ename, job, sal, 
    DECODE( job, 
            'SALESMAN' , sal *1.05,
            'MANAGER' ,  DECODE(deptno, 10,sal *1.30, sal *1.10),           
            'PRESIDENT', sal*1.20,sal*1) DDD
FROM emp;

SELECT *
FROM emp
ORDER BY deptno;

집합 A = {10, 15, 18, 23, 24, 25, 29, 30, 35, 37}
소수 : {23,29,37} : conunt-3, max-37, min-23, avg-29.66, sum-89
비 소수 : {10, 15, 18, 24, 25, 30, 35}


SELECT (23+29+37)
FROM dual;

SELECT *
FROM emp;

GROUP FUNCTION
여러행의 데이터를 이용하여 같은 그룹끼리 묶어 연산하는 함수
여러행을 입력받아 하나의 행으로 결과가 묶인다 
EX: 부서별 급여 평균
    emp 테이블에는 14명의 직원이 있고, 14명의 직원은 3개의 부서(10,20,30)에 속해 있다.
    부서별 급여 평균은 3개의 행으로 결과가 반환된다.
    
SELECT 그룹핑 기준 컬럼, 그룹함수 : SELECT 기술할 수 있는 컬럼이 제한 됨 

FROM 테이블
GROUP BY 그룹핑 기준 컬럼
[ORDER BY];


부서별로 가장 높은 급여 값
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
        COUNT(sal),-- 부서별 급여- 건수sal 컬럼의 값이 null이 아닌 row의 수
        COUNT(*),--부서별 행의 수 
        COUNT(mgr)
FROM emp
GROUP BY deptno;


* 그룹 함수를 통해 부서번호 별 가장 높은 급여를 구할 수는 있지만 
    가장 높은 급여를 받는 사람의 이름을 알 수는 없다.
    >> 추후 WINDOW FUCTION을 통해 해결 가능
SELECT *
FROM emp;


emp 테이블의 그룹 기준을 부서번호가 아닌 전체 직원으로 설정 하는 방법
SELECT  
        MIN(sal), --전체 직원중 가장 높은 급여 값
        MAX(sal), -- 전체 직원중 가장 낮은 급여 값
        ROUND(AVG(sal),2), --전체 직원의 급여 평균
        SUM(sal),   --전체 직원의 급여의 합
        COUNT(sal),-- 전체 직원의 급여- 건수sal 컬럼의 값이 null이 아닌 row의 수
        COUNT(*),--전체 행의 수 
        COUNT(mgr) --mgr 컬럼이 null이 아닌 건수.
FROM emp;

GROUP BY 절에 기술된 컴럼이 
    SELECT 절에 나오지 않으면 ?? < 상관 없음
    
GROUP BY 절에 기술되지 않은 컬럼이 
    SELECT 절에 나오면 ?    < 에러 ;


그룹화와 관련 없는 문자열, 상수 등은 SELECT 절에 표현 될 수 있다.(에러아님);
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

GROUP 함수 연산시 NULL값은 제외 된다.
30번 부서에는 NULL값을 갖는 행이 있지만 SUM(comm)의 값이 정상적으로 계산된 걸 확인 할 수 있다.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10,20번 부서의 SUM(comm) 컬럼이 NULL이 아니라 10이 나오도록 NULL 처리 
*특별한 사유가 아니면 그룹함수 계산 결과에 null처리를 하는것이 성능상 유리 

NVL(SUM(comm),0) : comm 컬럼에 sum 그룹 함수를 적용하고 최종 결과에 NVL을 적용(1회 호출)
SUM(NVL(comm,0)) : 모든 comm컬럼에 NVL함수를 적용후 (해당 그룹의 ROW수 만큼 호출) SUM 그룹함수 적용

SELECT deptno, NVL(SUM(comm),10)
FROM emp
GROUP BY deptno;

single row 함수는 where 절에 기술할 수 있지만 
multi row 함수(GROUP함수)는 where 절에 기술할 수 없고 
GROUP BY 절 이후 HAVING절에 별도로 기술

SELECT*
FROM emp
WHERE LOWER(ename) = 'smith';

부서별 급여 합이 5000이 넘는 부서만 조회 
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 9000
GROUP BY deptno;
-- 에러
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