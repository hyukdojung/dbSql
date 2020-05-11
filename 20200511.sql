�θ� - �ڽ� ���̺� ����

1. ���̺� ������ ���� 
 1] �θ� (dept)
 2] �ڽ� (emp)
 
2. ������ ������(insert)����
 1] �θ� (dept)
 2] �ڽ� (emp)
 
3. ������ ������(delete)����
 1] �ڽ� (emp)
 2] �θ� (dept)


���̺� ����� (���̺��� �̹� �����Ǿ� �ִ� ���) �������� �߰� ���� 

DROP TABLE emp_test;

CREATE TABLE emp_test(
		empno NUMBER(4,0),
		ename VARCHAR2(10),
		deptno NUMBER(2,0)
);

���̺� ������ ���������� Ư���� �������� ����

���̺� ������ ���� PRIMARY KEY �߰�

���� : ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� �������� Ÿ�� (������ �÷�[,]);
�������� Ÿ�� : PRIMARY KEY(UNIQUE + NOT NULL), UNIQUE(�÷��� ������ �� �ߺ�����), FOREIGN KEY(�ܷ�Ű ��������), CHECK(�÷��� ���� ����)

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);

���̺� ����� �������� ���� 
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;

������ �߰��� �������� pk_emp_test����
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

���̺� ���� ���� �ܷ�Ű �������� �߰� �ǽ� [FOREIGN KEY]
emp_test.deptno  ==> dept_test.deptno  //�ܷ�Ű ���������� �߰��ҽ� �����Ǵ��ʿ� �ε����� �־���Ѵ�. 

dept_test���̺��� deptno�� �ε��� ���� �Ǿ��ִ��� Ȯ�� //PRIMARY KEY Ȯ�θ����� �ε����� �ִ°� �˼��ִ�

ALTER TABLE dept_test ADD CONSTRAINT �������Ǹ� �������� Ÿ�� (�÷�[,]) REFERENCES �������̺�� (�������̺� �÷���);

ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno);

������  ����
ALTER TABLE emp_test DROP CONSTRAINT fk_emp_test_dept_test;   
UNIQUE , CHECK �� PRIMARY KEY ���� ���� ����

�������� Ȱ��ȭ ��Ȱ��ȭ
���̺� ������ ���������� �����ϴ°��� �ƴ϶� ��� ����� ����, Ű�� ����

���� :  ALTER TABLE ���̺�� ENABLE/DISABLE CONSTRAINT �������� ��;

ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test; //�����������μ� ����� ��� 

dept(�θ�)���̺��� 99�� �μ��� �����ϴ� ��Ȳ
SELECT *
FROM dept_test;

fk_emp_test_dept_test ���������� ��Ȱ��ȭ�Ǿ� �ֱ� ������ emp_test ���̺��� 99�� �μ� �̿��� ���� �Է� ������ ��Ȳ

dept_test���̺� 88�μ��� ������ �Ʒ� ������ ���������� ����
INSERT INTO emp_test VALUES (9999,'brown',88);

�����Ȳ : emp_test ���̺� dept_test���̺� �������� �ʴ� 88�� �μ��� ����ϰ� �ִ� ��Ȳ
        fk_emp_test_dept_test ���������� ��Ȱ��ȭ�� ����
        

�������� ���Ἲ�� ���� ���¿��� fk_emp_test_dept_test�� Ȱ��ȭ ��Ű��??
==> �������� ���Ἲ�� ��ų�� �����Ƿ� Ȱ��ȭ �� �� ����. 
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;

emp, dept ���̺��� ���� PRIMARY KEY , FOREIGN KEY ������ �ɷ� ���� ���� ��Ȳ
emp���̺��� empno�� key��
dept���̺��� deptno�� key�� �ϴ� PRIMARY KEY������ �߰��ϰ�

emp.deptno ==> dept.deptno �� �����ϵ��� FOREIGN KEY�� �߰�
�������� ���� �����ð��� �ȳ��� ������� ���.

emp, dept ��������
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);

ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);

�������� Ȯ��
Ʋ���� �������ִ� �޴�(���̺� ���� ==> �������� tab)
USER_CONSTRAINTS; �������� ����(MASTER);

USER_CONS_COLUMNS ; �������� �÷� ����(��)

SELECT*
FROM USER_CONSTRAINTS;

SELECT*
FROM USER_CONS_COLUMNS;


�÷�Ȯ�� 
��
SELECT*
FROM
USER_TAB_COLUMNS (Data dictionary, ����Ŭ���� ���������� �����ϴ� view);

SELECT*
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME='EMP';

SELECT 'SELECT * FROM' || TABLE_NAME ||';'
FROM USER_TABLEs;
/**/
SELECT * /*TEST*/
FROM emp;

���̺�, �÷� �ּ� : USER_TAB_COMMENTS, USER_COL_COMMENTS;

SELECT*
FROM user_tab_comments;

���� ���񽺿��� ���Ǵ� ���̺��� ���� ���ʰ��� ������ �ʴ� ��찡 ����. 

���̺��� �ּ� �����ϱ�
���� : COMMENT ON TABLE ���̺�� IS '�ּ�';

emp ���̺� �ּ� �����ϱ� 
COMMENT ON TABLE emp IS '���� ����';

�÷��ּ� Ȯ��

SELECT*
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

�÷� �ּ� ����
COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�';

COMMENT ON COLUMN EMP.EMPNO IS '���';
COMMENT ON COLUMN EMP.HIREDATE IS '�Ի�����';
COMMENT ON COLUMN EMP.ENAME IS '�̸�';

SELECT*
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

�����͸� �빮�� ����!

SELECT t.*, c.TABLE_TYPE, c.COMMENTS
FROM user_col_comments t, user_tab_comments c
WHERE c.TABLE_NAME = t.TABLE_NAME
AND t.TABLE_NAME IN('CUSTOMER','PRODUCT','CYCLE','DAILY');


View �� ���� 
������ ������ ���� = SQL
�������� ������ ������ �ƴϴ� 

view ��� �뵵
 . �������� ����(���ʿ��� �÷� ������ ����)
 . ���ֻ���ϴ� ������ ������ ����
    .IN-LINE VIEW�� ����ص� ������ ����� ����� ���� ������ 
    MAIN ������ ������� ������ �ִ�.

View�� �����ϱ� ���ؼ��� CREATE VIEW������ ���� �־�� �Ѵ�. (DBA����)
SYSTEM ������ ����
GRANT CREATE VIEW TO ����������� �ο��� ������;

���� : CREATE [OR REPLACE] VIEW ���̸� [�÷���Ī,....] AS 
        SELECT ����;
        
emp���̺��� sal, comm�÷��� ������ 6���� �÷��� ��ȸ�� ������ v_emp view�� ����

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

view (v_emp)�� ���� ������ ��ȸ 
SELECT*
FROM v_emp;

v_emp view�� sem���� ����
HR�������� �λ� �ý��� ������ ���ؼ� EMP���̺��� �ƴ� SAL, COMM��ȸ�� ���ѵ� 
v_emp view�� ��ȸ�Ҽ� �ֵ��� ������ �ο� 

[hr�������� ����]���Ѻο��� hr �������� v_emp ��ȸ 
SELECT*
FROM PC23.v_emp;

[sem�������� ����]sem�������� hr�������� v_emp view�� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON v_EMP TO hr;

[hr�������� ����]v_emp view ������ hr������ �ο��� ���� ��ȸ �׽�Ʈ
SELECT*
FROM  PC23.v_emp;

�ǽ�
v_emp_dept �並 ����
emp, dept ���̺��� deptno�÷����� �����ϰ� 
emp.empno,enme, dept.deptno, dname 4���� �÷����� ����


CREATE OR REPLACE VIEW v_emp_dept AS
SELECT e.empno,e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

GRANT SELECT ON v_emp_dept TO hr;

SELECT*
FROM  PC23.v_emp_dept;

�� ����
DROP VIEW �� �̸�;

IN-LINE VIEW ��ȸ������ �ַ� ���

VIEW �� ���� DML ó�� 
SIMPLE VIEW �� ���� ����

SIMPLE VIEW : ���ε��� �ʰ�, �Լ� , GROUP BY, ROWNUM�� ������� ���� ������ ������ VIEW
COMPLEX VIEW: SIMPLE VIEW�� �ƴ� ����

v_emp : simple view

SELECT *
FROM v_emp;

v_emp�� ���� 7369 SMITH ����� �̸��� brown���� ����
UPDATE v_emp SET ename='brown'
WHERE empno=7369;


v_emp �÷����� SAL �÷��� �������� �ʱ� ������ ����
UPDATE v_emp SET sal=1000
WHERE empno=7369;


SEQUENCE
������ �������� �������ִ� ����Ŭ ��ü
�����ĺ��� ���� ������ �� �ַ� ���

�ĺ��� ==> �ش� ���� �����ϰ� ������ �� �ִ� ��
 ���� <==> ���� �ĺ���
 ���� : ���� �׷��� ��.
 ���� : �ٸ糽 ��.
 
 �Ϲ������� � ���̺�(��ƼƼ)�� �ĺ��ڸ� ���ϴ� �����
 [����], [����], [������]
 
 �Խ����� �Խñ� : �Խñ� �ۼ��ڰ� ���� ����� �ۼ� �ߴ���  
 �Խñ� �ĺ��� : �ۼ��� id, �ۼ�����, ������
    ==> ���� �ĺ��ڰ� �ʹ� �����ϱ� ������ ������ ���̼��� ���� 
        ���� �ĺ��ڸ� ��ü�� �� �ִ� (�ߺ����� �ʴ�) �����ĺ��ڸ� ���
        


SEQUENCE
������ �ϴٺ��� ������ ���� �����ؾ��� ���� ����
ex : ���, �й�, �Խñ� ��ȣ
     ���, �й� : ü��
     ��� : 15101001 - ȸ�� �������� 15, 10��10��, �ش� ��¥�� ù��° �Ի��� ��� 01 //100���� ���ÿ� �Ի� �Ұ� 
     �й� : 1484037 - ���г⵵ 14, �̸����� 
     
     ü�谡 �ִ� ���� �ڵ�ȭ�Ǳ� ���ٴ� ����� ���� Ÿ�� ��찡 ����
     
     �Խñ� ��ȣ: ü�谡.. , ��ġ�� �ʴ� ����
     ü�谡 ���°��� �ڵ�ȭ�� ���� ==> SEQUENCE ��ü�� Ȱ���Ͽ� �ս��� ���� ����
                                    ==> �ߺ����� �ʴ� ���� ���� ��ȯ

�ߺ����� �ʴ� ���� �����ϴ� ���
1. KEY table�� ����
    ==> SELECT FOR UPDATE �ٸ� ����� ���ÿ� ������� ���ϵ��� ���°� ���� 
    ==> ���� ���� ���� ��, ������ ���� �̻ڰ� �����ϴ°� ���� (SEQUENCE ������ �Ұ���)
2. JAVA�� UUID Ŭ������ Ȱ��, ������ ���̺귯�� Ȱ��(����) ==> ������, ����, ī��
    ==> jsp �Խ��� ���� 
    
    
3. ORACLE DB - SEQUENCE 



SEQUENCE ����
���� CREATE SEQUENCE ������ ��;


seq_emp��� �������� ����
CREATE SEQUENCE seq_emp;

���� : ��ü���� �������ִ� �Լ��� ���ؼ� ���� �޾ƿ´�. 
NEXTVAL : �������� ���� ���ο� ���� �޾ƿ´� //�������� ���� ���� ��ȸ
CURRVAL : ������ ��ü�� NEXTVAL�� ���� ���� ���� �ٽ� Ȯ���� �� ���  / ���� �������� ���� ��ȸ 
        (Ʈ����ǿ��� NEXTVAL �����ϰ� ���� ����� ����)

SELECT seq_emp.NEXTVAL
FROM dual;
        
SELECT seq_emp.CURRVAL
FROM dual;

SELECT*
FROM emp_test;

SEQUENCE �� ���� �ߺ����� �ʴ� empno �� �����Ͽ� insert �ϱ� 
�Ʒ��� ������ ������ ���� 
INSERT INTO emp_test VALUES(seq_emp.NEXTVAL, 'sally', 88);

������ �ɼ� ��� ���� *





