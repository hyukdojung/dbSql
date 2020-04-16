--select1
SELECT *
FROM prod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT*
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

SQL 연산 : JAVA와 다르게 대입 x , 일반적 사칙연산
int b= 2; = 대입연산자, == 비교;

SQL 데이터 타입 : 문자, 숫자 , 날짜 (date);

SELECT*
FROM USERS;

날짜 타입에 대한 연산 : 날짜는 +, -연산 가능
date type + 정수 : date에서 정수 날짜만클 미래 날짜로 이동
date type - 정수 : date에서 정수 날짜만큼 과러 날짜로 이동;

SELECT userid, reg_dt + 5, reg_dt
FROM users;
/* null을 포함한 연산의 결과는 항상 null 이다.
--컬럼 병칭 : 기존 컬럼명을 변경하고 싶을때 
--syntax : 기존 컬럼명 [as] 별칭 명칭
--별칭 명칭에 공백이 표현되어야 할 경우 ""을 사용 
-- 또한 오라클에서는 객체명을 대문자 처리 하기 때문에 소문자로 별칭을 지정하기 위해서도 ""을 사용한다.
*/
SELECT userid id, userid 아이디
FROM users;

--select2
SELECT prod_id "id", prod_name "name"
FROM prod;

SELECT lprod_gu "gu", lprod_nm "nm"
FROM lprod;

SELECT buyer_id "바이어아이디", buyer_name "이름"
FROM buyer;

--문자열 연산 (결합연산): || (문자열 결합은 +연산자가 아니다.)
SELECT /*userid +'test'*/userid ||'test', reg_dt +5, 'test', 15
FROM users;


SELECT userid || usernm as id_name
FROM users;

SELECT CONCAT(userid, usernm) as concat_id_name
FROM users;

SELECT '아이디 : ' || userid id
FROM users;

--user_tables : oracle  관리하는 테이블 정보를 담고 있는 테이블 [view] ==> data dictionary

SELECT* 
FROM user_tables;

SELECT 'SELECT * FROM '||table_name ||';'"QUERY" 
FROM user_tables;



/*테이블의 구성 컬럼을 확인 
1. tool(sql developer)을 통해 확인
   테이블 - 확인하고자 하는 테이블
2. SELERCT*
    FROM테이블
    일단 전체 조회 --> 모든 칼럼 표시
3. DESC 테이블명  데이터 타입
4. data dictionary : user_tab_columns

*/

DESC emp;

SELECT*
FROM user_tab_columns;
/*
지금까지 배운 기술
조회하고자 하는 컴럼 기술 : SELECT
조회할 테이블 기술 : FROM
조회할 행을 제한하는 조건을 기술 : WHERE
WHERE 절에 기술한 조건이 참(TRUE)일때 결과를 조회
*/
SELECT *
FROM users;

java의 비교 연산 : a변수와 b변수의 값이 같은지 비교 ==
sql의 비교 연산 : =
int a = 5;
int b = 2;
a랑 b의 값이 같을 때만 특정로직 실행;


SELECT*
FROM users
WHERE userid = 'cony'
;
SELECT*
FROM users
WHERE userid = userid;

SELECT*
FROM users
WHERE 1 = 1;

SELECT*
FROM users
WHERE 1 = 2;

emp테이블의 컬럼과 데이터 타입을 확인;
DESC emp;

SELECT *
FROM emp;

emp: 사원번호
ename: 사원 이름 
job: 직무
mgr : 담당자 
hiredate : 입사일
sal : 급여 
comm : 성과금
deptno : 부서번호
;
--emp 테이블에서 직원이 속한부서번호가 30번보다 큰 부서에 속한 직원을 조회
SELECT*
FROM emp
WHERE deptno >= 30;

!= 다를때 
users 테이블에서 사용자 아이디가 (userid)가 brown이 아닌 사용자를 조회 ;
SELECT
    *
FROM users
WHERE userid !='brown';


SELECT ename hiredate 
FROM emp
WHERE '2020/02/30'<'2020/12/10';

SQL 리터럴 
숫자: .......
문자: 싱글 퀘테이션 ['hello world']
날짜: TO_DATE ('날짜 문자열', '날짜문자열의 형식');

--1920년 1월 1일 이후에 입사한 직원만 조회 
SELECT *
FROM emp
WHERE hiredate >= '19820101';







