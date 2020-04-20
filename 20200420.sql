--table ���� ��ȸ/���� ������ ���� 
==> ORDER BY �÷��� ���Ĺ��,...
����*
ORDER BY �÷����� ��ȣ �� ���� ����
==>SELECT �÷��� ������ �ٲ�ų�, �ķ� �߰��� �Ǹ� �����ǵ���� �������� ���� ���ɼ��� ����
SELECT*
FROM emp
ORDER BY 3;

��Ī���� ����
�÷����ٰ� ������ ���� ���ο� �÷��� ����� ���
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
���ͷ� 
    ����:����
    ����:'����'

SELECT*
FROM emp
WHERE comm > 0
ORDER BY empno desc, empno;


SELECT*
FROM emp
WHERE comm != 0     -- NULL�� ����� �ڵ� ���� �Ǿ�����.
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

����¡ ó���� �ϴ� ���� 
1. �����Ͱ� �ʹ� �����ϱ� 
 . ��ȭ�鿡 ������ ��뼺�� ������
 . ���ɸ鿡�� ������
����Ŭ���� ����¡ ó�� ��� ==> ROWNUM

ROWNUM : SELECT ������� 1������ ���ʴ�� ��ȣ�� �ο����ִ� Ư�� KEYWORD

SELECT���� *ǥ���ϰ� �޸��� ���� 
�ٸ� ǥ��(ROWNUM)�� ����Ұ�� 
*�տ� � ���̺� ���Ѱ��� ���̺� ��Ī/��Ī�� ����ؾ��Ѵ�. 
SELECT ROWNUM, e.*
FROM emp e;


����¡ ó���� ���� �ʿ��� ����: 
1. ������ ������ [10]
2. ������ ���� ����
1page: 1~10
2page: 11~20 (11~14)

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

2 ����¡ ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20;

ROWNUM�� Ư¡
1. ORACLE���� ���� 
    . �ٸ� DBMS�� ��� ����¡ ó���� ���� ������ Ű���尡 ���� (LIMIT)
2. 1���� ���������� �д°�츸 ����
    ROWNUM BETWEEN 1 AND 10 >> 1~10
    ROWNUM BETWEEN 11 AND 20 >> 1~10�� SKIP�ϰ� 11~20�� �������� �õ� 
    
    WHERE ������ ROWNUM�� ����� ��� ���� ���� 
    ROWNUM = 1;
    ROWNUM BETWEEN 1 AND N
    ROWNUM <, <= N (1,N)
    
ROWNUM�� ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY empno;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

ROWNUM�� ORDER BY ������ ����
SELECT > ROWNUM > ORDER BY

ROWNUM�� ��������� ���� ������ �Ȼ��·� ROWNUM�� �ο��ϸ� IN-LINE VIEW�� ����ؾ� �Ѵ�.
**IN-LINE : ���� ����� �ߴ�.;

SELECT ROWNUM, a.*
FROM
(SELECT ROWNUM rn, e.*
FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) e) a
WHERE rn BETWEEN 1+(:page -1)*:pageSize AND :page * :pageSize;
-- ��ȣ �κ��� IN-LINE VIEW
WHERE rn BETWEEN 1 AND 10; 1page
WHERE rn BETWEEN 2 AND 20; 2page
WHERE rn BETWEEN 3 AND 30; 3page
.
.
WHERE rn BETWEEN 1+(n-1)*10 AND pageSize * n; n page

����
SELECT*
FROM
(SELECT empno, ename
    FROM emp
    ORDER BY ename);
--ORDER BY ���� ������ ���� 

INLINE - view�� �񱳸� ���� view�� ���� ���� (�����н�, ���߿� ����)
view - ���� (view ���̺� - x)
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

view�� �ۼ��� ���� 
SELECT*
FROM emp_ord_by_ename;

----------------------------------------------------------------------------------

emp ���̺� �����͸� �߰��ϸ� 
in - line view, view�� ����� ������ ����� ��� ������ ������??

INSERT emp (empno, ename) VALURES (9999, '����');
SELECT empno, ename
FROM emp;

���� �ۼ��� ������ ã�ư��� 
java : �����
SQL : ����� ���� ���� 

����¡ ó�� ==> �����۾�, ROWNUM
����, ROWNUM�� �ϳ��� �������� ������ ��� ROWNUM�� ������ �Ͽ� ���ڰ� ���̴� ���� >> INLINE- VIEW
    ���Ŀ� ���� INLINE_VIEW
    ROWNUM�� ���� INLINE_VIEW
    
    
    
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
























