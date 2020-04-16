--현재 접속한 데이터 베이스 내의 테이블을 조회 한다.

SELECT * from tab;   
--원하는 테이블의 정보를 조회한다. 
DESC BONUS;

--부서의 모든 정보를 가져온다 .
SELECT * 
from DEPT;

--사원의 모든 정보를 가져온다. 
SELECT *
from emp;

--사원의 이름과 사원 번호를 가져온다.
SELECT ename, empno
from emp;
--사원의 이름과 사원번호, 직무, 급여를 가져온다. 
SELECT ename, empno, job, sal
from emp;
--부서 번호와 부서 이름을 가져온다. 
SELECT DEPTNO, DNAME
from DEPT;

--각 사원들의 급여액과 급여액에서 1000을 더한 값, 200을 뺀 값, 2를 곱한 값, 2로 나눈 값을 가져온다 .
SELECT sal, sal+1000, sal-200, sal*2, sal/2 
from emp;

--각 사원의 급여액, 커미션, 급여+커미션 액수를 가져온다. 
SELECT sal, nvl(comm, 0), sal+nvl(comm, 0)
from emp;

--사원들의 이름과 직무를 다음 양식으로 가져온다. 
--00사원의 담당 직무는 xxx입니다. 

SELECT ename || '사원의 직무는'|| job||'입니다'
from emp;

--사원들이 근무하고 있는 근무 부서의 번호를 가져온다 .

SELECT DISTINCT  DEPTNO
from emp;

--근무 부서가 10번인 사원들의 사원번호, 이름, 근무 부서를 가져온다 .

SELECT empno, ename, deptno
FROM emp
where deptno = 10;

--근무 부서 번호가 10번이 아닌 사원들의 사원번호, 이름, 근무 부서 번호를 가져온다 .
SELECT empno, ename, deptno
FROM emp
WHERE deptno <> 10;

--급여가 1500이상인 사원들의 사원번호, 이름, 급여를 가져온다. 
SELECT empno, ename, sal
FROM emp
WHERE sal >= 1500;

--이름이 SCOTT 사원의 사원번호, 이름, 직무, 급여를 가져온다 
SELECT empno, ename, job, sal
FROM emp
WHERE ename = 'SCOTT';

--직무가 SALESMAN인 사원의 직원번호, 이름, 직무를 가져온다. 
SELECT empno, ename, job
FROM emp
WHERE job = 'SALESMAN';

--직무가 CLERK가 아닌 사원의 사원번호, 이름, 직무를 가져온다. 
SELECT empno, ename, job
FROM emp
WHERE job <> 'CLERK';

--1982년 1월 1일 이후에 입사한 사원의 사원번호 이름, 입사일을 가져온다.
SELECT empno, ename, HIREDATE
FROM emp
WHERE HIREDATE >= '1982/01/01';

--10번 부서에서 근무하고 있는 직무가 MANAGER인 사원의 사원번호, 이름, 근무부서, 직무를 가져온다. 
SELECT empno, ename, deptno, job
FROM emp
WHERE DEPTNO = 10 and job = 'MANAGER';

--입사년도가 1981년인 사원중에 급여가 1500 이상인 사원의 사원번호, 이름, 급여, 입사일을 가져온다. 
SELECT empno, ename, sal, hiredate
FROM emp
WHERE hiredate >= '1981/01/10' and hiredate <= '1981/12/31' and sal>=1500;

--20번 부서에 근무하고 있는 사원 중에 급여가 1500 이상인 사원의 사원번호, 이름, 부서번호, 급여를 가져온다 .

SELECT empno, ename, deptno, sal 
FROM emp
WHERE deptno= 20 and sal>= 1500;

--직속상관 사원 번호가 7698인 사원중에 직무가 CLERK인 사원의 사원번호, 이름, 직속상관번호, 직무를 가져온다 .

SELECT empno, ename, mgr, job
FROM emp
WHERE mgr = 7698 and job = 'CLERK';

--급여가 2000보다 크거나 1000보다 작은 사원의 사원번호, 이름, 급여를 가져온다.
SELECT empno, ename, sal    
FROM emp
WHERE not(sal<=2000 and sal>=1000);

SELECT empno, ename, sal    
FROM emp
WHERE not(sal between 1000 and 2000);
--부서번호가 20이거나 30인 사원의 사원번호, 이름, 부서번호를 가져온다 .
SELECT
FROM emp
WHERE
--직무가 CLERK, SALESMAN, ANALYST인 사원의 사원번호, 이름, 직무를 가져온다. 
SELECT
FROM emp
WHERE