--지난 시간 복습

SELECT '201912' PARAN,
        TO_CHAR(LAST_DAY(TO_DATE('201912','YYMM')), 'DD') DT
FROM dual;


SELECT TO_CHAR(TO_DATE('201912','YYMM'), 'YYMM') PARAM,
    TO_CHAR(LAST_DAY(TO_DATE('201912','YYYYMM')), 'DD') DT
FROM dual;
-- :(201912)고정된 값을 바인드 변수로 묶어줄수 있음. 



--쪽지 시험
1. 휘발성 데이터를 DB를 활용하여 보호 가능
2. 트랜잭션 : 여러단계의 과정을 하나의 작업으로 묶는 단위
3. 트랜잭션 원자성 : 트랜잭션내의 작업이 실행 되거나 / 안되거나 
18.페이징 처리 SQL 다시 공부 .. 

형변환
묵시적 형변환



EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = '7369';

   
SELECT*
FROM TABLE(DBMS_XPLAN.DISPLAY);




실행계획을 보는 순서 (id)
* 들여쓰기 되어있으면 자식 오퍼레이션
1. 위에서 아래로 
 *단 자식 오퍼레이션이 있으면 자식부터 읽는다. 


Plan hash value: 3956160932
 1 >> 0
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 | //필터 조건을 충족하는 데이터를 읽었따. 
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)



EXPLAIN PLAN FOR
SELECT*
FROM emp 
WHERE to_char(empno) = '7369';

SELECT*
FROM TABLE(dbms_xplan.display);


EXPLAIN PLAN FOR
SELECT*
FROM emp 
WHERE empno = 7300+'69';

SELECT*
FROM TABLE(dbms_xplan.display);

SQL 개발자의 칠거지악
7. 결과에만 만족하지 말고 실행계획에 관심을 가지고 절차형 로직을 버리고 집합적 하나의 SQL로 임무를 완수토록 하라.

SELECT ename, sal, TO_CHAR(sal, 'L009,999.00')
FROM emp;                       --포맷팅

NULL과 관련된 함수 
NVL
NNL2
COALESCE

왜 null처리를 해야할까?
null에 대한 연산결과는 null이다 

예를 들어서 emp 테이블에 존재하는 sal, comm 두개의 컬럼 값을 합한 값을 알고 싶어서 
다음과 같이 SQL을 작성.

SELECT empno, ename, sal, comm, sal +comm AS sal_plus_comm
FROM emp;

SELECT empno, ename, sal, comm, sal +NVL(comm,0) AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1이 NULL이면 expr2값을 리턴하고 
expr1이 NULL이 아니면 expr1을 리턴



REG_DT 컬럼이 null일 경우 현재 날짜가 속한 월의 마지막 일자로 표현
SELECT userid, usernm, NVL(reg_dt,LAST_DAY(SYSDATE))
FROM users;












