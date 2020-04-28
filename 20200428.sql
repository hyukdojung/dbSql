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


SELECT*
FROM regions;
SELECT*
FROM countries;

실습8
SELECT countries.REGION_ID, REGION_NAME, COUNTRY_NAME
FROM countries ,regions 
WHERE countries.REGION_ID = regions.REGION_ID
    AND REGION_NAME='Europe';
    
실습9
SELECT countries.REGION_ID, regions.REGION_NAME, countries.COUNTRY_NAME, locations.city
FROM countries ,regions ,locations
WHERE countries.REGION_ID = regions.REGION_ID
AND  locations.COUNTRY_ID = countries.COUNTRY_ID
    AND REGION_NAME='Europe';
    
    
    
실습10
SELECT countries.REGION_ID, regions.REGION_NAME, countries.COUNTRY_NAME, locations.city, departments.department_name
FROM countries ,regions ,locations, departments
WHERE countries.REGION_ID = regions.REGION_ID
AND  locations.COUNTRY_ID = countries.COUNTRY_ID
AND  locations.location_ID = departments.location_ID
    AND REGION_NAME='Europe';
    
    

실습11
SELECT countries.REGION_ID, regions.REGION_NAME, countries.COUNTRY_NAME, locations.city, departments.department_name, employees.first_name||employees.last_name
FROM countries ,regions ,locations, departments, employees
WHERE countries.REGION_ID = regions.REGION_ID
AND locations.COUNTRY_ID = countries.COUNTRY_ID
AND locations.location_ID = departments.location_ID
AND employees.department_id = departments.department_id
    AND regions.REGION_NAME='Europe';


실습12
SELECT employee_ID,first_name||last_name,jobs.job_id, job_title
FROM employees ,jobs 
WHERE employees.job_id = jobs.job_id;
   
SELECT*
FROM JOBS;

SELECT*
FROM employees;

실습13
SELECT employees.manager_id, employee_id,employees.employee_id,first_name||last_name,jobs.job_id, job_title
FROM employees ,jobs 
WHERE employees.job_id = jobs.job_id
AND employee.job_id= jobs.job_id;








SELECT*
FROM emp
WHERE TO_CHAR(hiredate,'YYYYMMDD')
	BETWEEN '19800101' AND '19821231';
