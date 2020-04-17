SELECT 에서 연산:
 날짜 연산 : 날짜 + 정수 , -정수, 날짜에서 +-정수를 한 과거 혹은 미래일자의 데이트 타입 반환 
 정수 연산 : 수업시간에 다루진 않음
  리터럴: 표기방법
        숫자 리터럴 : 숫자 표현
        문자 리터럴 : java: "문자열" / sql : 'sql'
        SELECT SELECT * FROM  ||table_name
        SELECT 'SELECT * FROM ' ||table_name
        
    문자열 결합연산 : +가 아니라 || (java에서는 +)
    날짜 : TO_DATE('날짜 문자열', '날짜 문자열에 대한 포맷')
        TO_DATE('20200417', 'yyyymmdd')
        
        
WHERE : 기술한 조건에 만족하는 행만 조회 되도록 제한
;

SELECT *
FROM users
WHERE 1=1;

SELECT *
FROM users
WHERE userid = 'brown';
/*sal 값이 1000 보다 크거나 같고, 2000보다 작거나 같은 직원만 조회 ==> BETWEEN AND
시작값과 종료값의 위치를 바꾸면 정상 동작하지 않음 
*/

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;


SELECT
    *
FROM emp
WHERE sal >= 1000 and sal <= 2000;



SELECT
    *
FROM emp
WHERE sal >= 1000
  AND sal <= 2000;
  

exclusive or (배타적 or)
a or b
둘중 하나만 참이여야한다

SELECT ename, hiredate
FROM emp
WHERE hiredate >= '1982/01/01'
  AND hiredate <= '1983/01/01';
  
  

IN 연산자 
컴럼|특정값 IN (값1, 값2 , ......)
컬럼이나 특정값이 괄호안에 값중에 하나라도 일치를 하면 true
;

.


SELECT *
FROM emp
WHERE deptno IN (10,30);
==> deptno가 10이거나 30번인 직원
deptno = 10 or deptno = 30

SELECT * 
FROM emp
WHERE deptno = 10
or deptno = 30;


SELECT userid "아이디", usernm "이름", alias "별명" 
FROM users
WHERE userid IN('brown','cony','sally');

SELECT 
FROM
WHERE 
ALIAS
IN

문자열 매칭 연산  : LIKE 연산 / JAVA: . startsWiht(prefix), .endWith(suffix)
마스킹 문자열 : % - 모든 문자열 (공백 포함) 
                _ -어떤 문자열이든지 딱 하나의 문자 
문자열의 일부가 맞으면 true


'cony' : cony인 문자열
'co%': 문자열이 co로 시작하고 뒤에서 어떤 문자열이든 올 수 있다. 
 'co''con' 'cony'
 '%co%': co를 포함하는 문자열
 'cony' 'sally cony'
 
 'co__' : co로 시작하고 뒤에 두개의 문자가 오는 문자열
 '_on_' : 가운데 두글자가 on이고 앞뒤로 어떤 문자열이든지 하나의 문자가 올수 있는 문자열
 
 컬럼 특정값 LIKE 패턴 문자열; 
 직원 이름(ename)이 대문자 s로 시작하는 직원만 조회 ;
 
 SELECT*
 FROM emp
 WHERE ename LIKE 'S%';
 
 member 테이블에서 회원의 성이 신씨인 사람의 mem_id, mem_name 을 조회하는 쿼리
 
 SELECT mem_id, mem_name
 FROM member
 WHERE mem_name LIKE '신%';
 
 
 SELECT mem_id, mem_name
 FROM member
 WHERE mem_name LIKE '%이%';
 
 
 NULL 비교
 SQL 비교연산자 : = 
 
 MGR컬럼 값이 없는 모든 직원을 조회 
 
 SELECT *
 FROM emp
 WHERE mgr IS null;
 
 SQL에서 NULL 값을 비교할 경우 일반적은 
 비교연산자를 사용 못하고 
 IS 연산자를 사용
 
 값이 있는 상황에서 등가 비교: =, !=, <>
 NULL : IS NULL , IS NOT NULL
 
 emp테이블에서 mgr 컬럼 값이 null이 아닌 직원을 조회 
 SELECT *
 FROM emp
 WHERE mgr IS NOT null;
 
 emp테이블에서 상여가 있는 회원의 정보를 다음과 같이 조회 되도록 쿼리를 작성하시오 
 
 SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
 FROM emp 
 WHERE comm IS NOT NULL;
 
 SELECT
     *
FROM emp
WHERE mgr = 7698
AND sal > 1000;
  
SELECT
     *
FROM emp
WHERE mgr = 7698
 OR sal > 1000;
 

SELECT *
FROM emp ;
 
SELECT *
FROM emp 
WHERE mgr IN (7698, 7839);
부정형
==> WHERE mgr = 7698 OR mgr = 7839

SELECT *
FROM emp 
WHERE mgr NOT IN (7698, 7839);
==> WHERE (mgr != 7698 AND mgr !=7839)

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);


emp 테이블에서 job이 SALESMAN 이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요


SELECT *
FROM emp
WHERE job = 'salesman' AND hiredate >= '19810601';
WHERE job IN ('SALESMAN')
AND hiredate >= ('1921/06/01');

emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
SELECT *
FROM emp
WHERE deptno <> 10 AND hiredate >= '1981/06/01';

NOT IN 사용 

SELECT*
FROM emp
WHERE deptno NOT IN 10 AND hiredate >= '1981/06/01';

IN 사용

SELECT*
FROM emp
WHERE deptno IN (20,30) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
---
WHERE deptno IN (10,20,30)
AND deptno != 10
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
----



SELECT*
FROM emp
WHERE job IN 'SALESMAN' OR hiredate >= '1981/06/01';


SELECT*
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%'; --LIKE '78%' 자동 형변환 숫자타입인데 문자로 입력.



SELECT*
FROM emp
WHERE job = 'SALESMAN' OR empno IN (7800, 7899);

OR 7800< empno AND empno< 7900
OR 780< empno AND empno <790
OR empno = 78;
 
 
 연산자 우선순위는 괄호()를 통해 우선순위를 변경 할 수 있다. 
 
SELECT*
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%' AND hiredate >= '1981/06/01'; 

 
 
 TABLE 객체에는 데이터를 저장 / 조회시 순서를 보장하지 않음
 ==> 수학 집합과 유사한 개념  
       [  집합 : (a,b,c)==(a,c,b)  ] 
 - 보편적으로 데이터가 입력된 순서대로 조회됨
 - 데이터가 항상 동일한 순서로 조회되는 것을 보장하지 않는다 
 - 데이터가 삭제되고, 다른 데이터가 들어올 수 있음
 
SQL에서는 데이터를 정렬하려면 별도의 구문이 필요
ORDER BY 컬럼명 [정렬형태], 컬럼명 ........

정렬의 형태 : 오름차순(DEFAULT) - ASC, 내림차순 - DESC

직원 이름으로 오름 차순 정렬

오름차순
SELECT*
FROM emp
ORDER BY ename ASC;
내림차순
SELECT*
FROM emp
ORDER BY ename desc;
 
 desc emp << 타입
 
SELECT*
FROM emp
ORDER BY job  ASC, hiredate desc;

 
 
 
 
 



