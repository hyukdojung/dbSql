grp7)
dept 테이블을 확인하면 총 4개의 부서 정보가 존재 ==> 회사내에 존재하는 모든 부서정보
emp 테이블에서 관리되는 직원들이 실제 속한 부서정보의 개수 ==> 10,20,30 =>3개
SELECT COUNT(*) cnt
FROM
    (SELECT deptno /*dept 컬럼이 1개 존재, row는 3개인 테이블*/
    FROM emp
    GROUP BY deptno);

DBMS : DataBase Management System
==> db
RDMBMS : Relational DataBase Management System
==>관계형 데이터베이스 관리 시스템

SELECT*
FROM dept;

JOIN 문법의 종류
ANSI - 표준
벤더사의 문법(ORACLE)

JOIN의 경우 테이블의 컬럼을 사용할 수 있기 때문에 
SELECT 할수 있는 컬럼의 개수가 많아진다. (가로확장)

NATURAL JOIN 
    - 조인하려는 두 테이블의 연결고리 컬럼의 이름 같을경우
    - emp, dept 테이블에는 deptno라는 공통된(동일한 이름의, 타입도 동일) 연결고리 컬럼이 존재
    - 다른 ANSI-SQL 문법을 통해 대체가 가능하고 , 조인테이블들의 컬럼명이 동일하지 않으면 
    사용이 불가능하기 때문에 사용빈도는 다소 낮다.


-emp 테이블 : 14건
-dept 테이블 : 4건

조인 하려고하는 컬럼을 별도 기술하지 않음.
SELECT*
FROM emp NATURAL JOIN dept;
두테이블의 이름이 동일한 컬럼으로 연결한다.

ORACLE 조인 문법을 ANSI 문법처럼 세분화 하지 않음
오라클 조인 문법
1. 조인할 테이블 목록을 from 절에 기술하며 구분자는 콜론(,)
2. 연결고리 조건을 WHERE절에 기술하면 된다. (ex : WHERE emp.deptno = dept.deptno)

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;
    
deptno가 10번인 직원들만 조회 
SELECT*
FROM emp, dept
WHERE emp.deptno = dept.deptno
    AND dept.deptno = 10;

ANSI-SQL : JOIN with USING
 - JOIN 하려는 테이블간 이름이 같은 컬럼이 2개 이상일 때
 - 개발자가 하나의 컬럼으로만 조인하고 싶을 때 조인 컬럼명을 기술
 
 SELECT*
 FROM emp JOIN dept USING (deptno);
 
 ANSI-SQL : JOIN with ON
 - 조인하려는 두 테이블간 컬럼명이 다를때
 - ON절에 연결고리 조건을 기술
 
 SELECT *
 FROM emp JOIN dept ON(emp.deptno = dept.deptno);


ORACLE 문법으로 위 SQL을 작성

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

JOIN의 논리적인 구분
SELF JOIN : 조인하려는 테이블이 서로 같을 때
EMP 테이블의 한행은 직원의 정보를 나타내고 직원의 정보중 mgr 컬럼은 해당 직원의 관리자 사번을 관리.
해당 직원의 관리자의 이름을 알고 싶을 때 

ANSI-SQL 조인 : 조인하려고 하는 테이블 EMP(직원), EMP(직원의 관리자)
        연결고리 컬럼: 직원.mgr = 관리자.empno
            ==>조인 컬럼 이름이 다르다 (mgr, emptno)
                ==> NATURAL JOIN, JOIN with를 사용 불가
                =>JOIN with ON
                    
SELECT *
FROM emp;
 
SELECT *
FROM emp e JOIN emp m ON(e.mgr = m.empno);

NOT EQUAL JOIN :연결고리 조건이 =이 아닐때

그동안 WHERE에서 사용한 연산자 : =, !=, <>, <=, <, >, >=
                            AND, OR, NOT
                            LIKE %,_
                            OR - IN
                            BETWEEN AND ==> >=, <=

SELECT*
FROM salgrade;

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

==> ORACLE 조인 문법으로 변경

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade 
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

실습0
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;

SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
ORDER BY deptno;

실습1
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
    AND dept.deptno IN(10,30);

SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE dept.deptno IN(10,30);

실습2
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
    AND emp.sal > 2500
    ORDER BY sal DESC;

SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.sal > 2500
ORDER BY sal DESC;

실습3
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
    AND emp.sal > 2500
    AND emp.empno > 7600
    ORDER BY sal DESC;

SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.sal > 2500
 AND emp.empno > 7600
ORDER BY sal DESC;

실습4
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno 
    AND emp.sal > 2500
    AND emp.empno > 7600
    AND dept.dname = 'RESEARCH'
    ORDER BY sal DESC;

SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.sal > 2500
 AND emp.empno > 7600
 AND dept.dname = 'RESEARCH'
ORDER BY sal DESC;

base_table 실습1
SELECT e.lprod_gu, e.lprod_nm, n.prod_id, n.prod_name
FROM lprod e JOIN prod n ON(n.prod_lgu = e.lprod_gu);

SELECT e.lprod_gu, e.lprod_nm, n.prod_id, n.prod_name
FROM lprod e, prod n
WHERE n.PROD_LGU = e.LPROD_GU;

base_table 실습2
SELECT B.buyer_id,B.buyer_name,P.prod_id,P.prod_name
FROM buyer B,prod P
WHERE B.buyer_lgu = P.prod_lgu
ORDER BY buyer_id;


SELECT buyer_id,buyer_name,prod_id,prod_name
FROM buyer JOIN prod ON(buyer_lgu = prod_lgu)
ORDER BY buyer_id;

select count(*)
from
    (SELECT COUNT(*)
    FROM buyer, prod
    WHERE prod.prod_buyer = buyer.buyer_id);



base_table 실습3
SELECT M.mem_id, M.mem_name, P.prod_id, P.prod_name, C.cart_qty
FROM member M, prod P, cart C
WHERE M.MEM_ID = C.CART_MEMBER
    AND C.CART_PROD = P.PROD_ID;


SELECT M.mem_id, M.mem_name, P.prod_id, P.prod_name, C.cart_qty
FROM member M JOIN cart C ON(M.MEM_ID = C.CART_MEMBER) 
                JOIN prod P ON(C.CART_PROD = P.PROD_ID);

참고사항
SELECT *
FROM
    (SELECT deptno, COUNT(*)
    FROM emp
    GROUP BY deptno)
WHERE deptno =30;

cid : customer id
cnm : customer name
SELECT*
FROM customer;

pid : product id
pnm : product name

SELECT*
FROM product;

cycle : 애음주기
cid : 고객id
pid : 제품id
day : 애음요일(일요일 , 월, 화, 수, 목, 금)
cnt : 수량

SELECT*
FROM cycle;

실습4
SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer , cycle 
WHERE customer.cid=cycle.cid
AND CNM IN('brown', 'sally');

SELECT cid, cnm, pid, day, cnt
FROM customer NATURAL JOIN cycle 
WHERE customer.cnm IN('brown', 'sally');


실습5
SELECT customer.cid, customer.cnm, product.pnm, cycle.pid, cycle.day, cycle.cnt
FROM customer , cycle ,product
WHERE customer.cid=cycle.cid
AND cycle.pid = product.pid
AND CNM IN('brown', 'sally');


실습6
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, sum(cycle.cnt)
FROM customer , cycle , product
WHERE customer.cid=cycle.cid
AND cycle.pid = product.pid
AND CNM IN('brown', 'sally','cony')
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm;

실습7
SELECT cycle.pid, product.pnm,sum(cycle.cnt)
FROM cycle , product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, product.pnm;

실습8
SELECT REGION_ID, REGION_NAME, COUNTRY_NAME
FROM countries, regions
WHERE countries = regions;

SELECT*
FROM regions;
SELECT*
FROM countries;


SELECT*
FROM emp
WHERE TO_CHAR(hiredate,'YYYYMMDD')
	BETWEEN '19800101' AND '19821231';

