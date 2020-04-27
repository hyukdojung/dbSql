NVL(expr1, expr2)
if expr1 == null
    return expr2
else
    return expr1
    

NVL2(expr1, expr2, expr3)
if expr1 != null
   return expr2
else
    return expr3
    

NULLIF(expr1, expr2)
if expr1 == expr2
    return null
    else
        return expr1
sal 컬럼의 값이 3000이면 null을 리턴
SELECT empno, ename, sal, NULLIF (sal, 3000)
FROM emp;

가변인자 : 함수의 인자의 갯수가 정해져 있지 않음
            가변인자들의 타입은 동일 해야함 .
인자들중에 가장 먼저나오는 nuill이 아닌 인자 값을 리턴
coalesce(expr1, expr2..................)

if expr1 != null
 return expr1
else
    coalesce(expr2, expr3 ....)
첫번째 인자를 제외한 나머지 인자를 호출 > 제귀 함수 


mgr 컬럼 null
comm 컬럼 null

SELECT empno, ename, comm ,sal, coalesce(comm, sal)
FROM emp;

SELECT *
FROM emp;

SELECT empno, ename, mgr, nvl(mgr, 9999)MGR_N,nvl2(mgr,sal, 9999)MGR_N1,COALESCE(mgr,9999)MGR_N_2
FROM emp;

SELECT*
FROM users;

SELECT userid, usernm, REG_DT,nvl(REG_DT,sysdate) N_REG_DT
FROM users;

confdition
조건에 따라 컴럼 혹은 표현식을 다른 값으로 대체 
java if, switch 같은 개념 
1. case 구문
2. decode 함수

1. CASE
CASE
    WHEN 참/거짓을 판별할 수 있는 식 THEN리턴할 값
    [WHEN 참/거짓을 판별할 수 있는 식 THEN리턴할 값]
    [ELSE 리턴값 (판변식이 참인 WHEN 절이 없을 경우 실행)]
END

emp 테이블에 등록된 직원들에게 보너스를 추가적으로 지급할 예정
해당 직원의 job이 'SALESMAN'일 경우 SAL에서 5%인상된 금액을 보너스로 지급 (ex: sal 100 > 105)
해당 직원의 job이 'MANAGER'일 경우 SAL에서 10%인상된 금액을 보너스로 지급 (ex: sal 100 > 105)
해당 직원의 job이 'PRESIDENT'일 경우 SAL에서 20%인상된 금액을 보너스로 지급 (ex: sal 100 > 105)
그 외 직원들은 sal만큼만 지급
//컬럼에 따라 

SELECT empno, ename, job, sal, 
    CASE 
        WHEN job = 'SALESMAN' THEN sal *1.05
        WHEN job = 'MANAGER' THEN sal *1.10
        WHEN job = 'PRESIDENT' THEN sal *1.20
        ELSE sal* 1
    END bonus
FROM emp;

2. DECODE(EXPR1, search1, returnl, search2, return2, search3, return3......[default])
DECODE(EXPR1, 
    search1, returnl,
    search2, return2,
    search3, return3
    ......[default])
    -------------------

    
SELECT empno, ename, job, sal,
    DECODE( job, 'SALESMAN', sal*1.05,
                'MANAGER', sal*1.10,
                'PRESIDENT', sal*1.20,
                sal ) bonus
FROM emp;

    
 
SELECT empno, ename ,
  DECODE( job, 
            'SALESMAN', sal*1.05,
            'MANAGER', sal*1.10,
            'PRESIDENT', sal*1.20,
            sal*1 ) bonus,
    CASE 
        WHEN job = 'SALESMAN' THEN sal*1.05
        WHEN job = 'MANAGER' THEN sal*1.10
        WHEN job = 'PRESIDENT' THEN sal*1.20
        ELSE sal*1
        END DNAME
FROM emp;   
    
SELECT empno, ename ,
   DECODE (deptno,
        10, 'ACCOUNTING',
        20, 'RESEARCH',
        30, 'SALES',
        40, 'OPERATIONS',
        'DDIT')DNAME,
       CASE 
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
        END bonus2
FROM emp;   
    
    
SELECT empno, ename, hiredate,
    case 
    WHEN mod(TO_CHAR(sysdate,'YYYY')-TO_CHAR(hiredate,'YYYY'),2) = 0 THEN '검강검진 대상자'
    ELSE '검강검진 비대상자'  
    END CONTACT_TO_DOCTOR
FROM emp;
-- 형변환과 mod 연산자 사용 case를 이용해 원하고자 하는 데이터 산출

SELECT empno, ename, hiredate,
   DECODE (MOD(TO_CHAR(sysdate, 'YYYY'),2),MOD(TO_CHAR(hiredate,'YYYY'),2),'검강검진 비대상자','검강검진 대상자')CONTACT_TO_DOCTOR
FROM emp;



SELECT userid, usernm, ALIAS ,REG_DT, 
    case
    WHEN MOD(TO_CHAR(sysdate, 'YYYY'),2) = MOD(TO_CHAR(REG_DT,'YYYY'),2) THEN '대상자'
    ELSE '비대상자'
    END CONTACTTODOCTOR
FROM users;
    
    
    
   
SELECT userid, usernm, alias, REG_DT,
DECODE (MOD(TO_CHAR(sysdate, 'YYYY'),2),MOD(TO_CHAR(NVL(reg_dt,'1112/11/11'),'YYYY'),2),'검강검진 비대상자','검강검진 대상자')
FROM users;
----------------------------------20200423 정리
NULL 처리 방법(4가지중 하나 기억)
NVL, NVL2 

DESC emp;
가운데 널? null값을 허용하는지 not null이면 null값을 허용하지 않는다. 

condition: CASE, DECODE
실행계획 :  실행계획이 뭔지 
            보는 순서
---------------------------------









