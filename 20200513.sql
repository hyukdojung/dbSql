CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM dept
WHERE 1= 1;

idx1]
CREATE UNIQUE INDEX idx_u_dept_01 ON DEPT_TEST2 (deptno);

ALTER TABLE dept DROP CONSTRAINT pk_dept;

CREATE INDEX idx_dept_02 ON DEPT_TEST2 (dname);

CREATE INDEX idx_dept_03 ON DEPT_TEST2 (deptno, dname);

idx2]
DROP INDEX idx_u_dept_01;

DROP INDEX idx_dept_02;

DROP INDEX idx_dept_03;

idx3]

CREATE INDEX idx_emp_01 ON emp (empno, ename, deptno);

CREATE INDEX idx_emp_02 ON emp (deptno, sal);

CREATE INDEX idx_emp_03 ON emp (deptno, mgr, hiredate);

DROP INDEX idx_emp_04;

idx4]

���� 


�����ȹ 

�����ð��� ��� ���� 
===> ���� ���� ���¸� �̾߱� ��, ������� �̾߱Ⱑ �ƴ�
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
outer join : ���ο� �����ص� �����̵Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join : ������ ���� (īƼ�� ������Ʈ), ���� ������ ������� �ʾƼ� 
            ���ᰡ���� ��� ����� ���� ���εǴ� ���
self join : ���� ���̺� ���� �����ϴ� ����

�����ڰ� DBMS�� SQL�� ���� ��û �ϸ� DBMS�� SQL�� �м��ؼ� 
��� �� ���̺� ������ ���� ����, 3���� ����� ���� ���(������ ���� ���, ������� �̾߱�)
1. Nested Loop Join  // OLTP ȯ�濡�� ����ȭ , �ҷ��� ������ ��ȸ�� ���� 
2. Sort Merge Join  //  �����÷��� �ε����� �������, �뷮�� ������ ��ȸ�� (�����÷����� ����, ������ ������ ������ ���� �������)
3. Hash Join    //  �����÷��� ���� �״�� ��� x �ؽ��Լ��� ���� ���� ���, ������ �ƴ� �������ǿ� ���ؼ��� ���Ұ�

OnLine Transaction Processing : �ǽð� ó�� ==> ������ ����� �ϴ� �ý���(�Ϲ����� �� ����)
OnLine Analysis processsing : �ϰ�ó�� ==> ��ü ó���ӵ��� �߿��� ���
                                                (���� ���� ���, ���� �ѹ��� ���)

