SELECT null,SUM(sal)
FROM emp;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno);

JOIN ������ ��
CROSS JOIN : ������ ���� �Ҷ�./..


�μ���ȣ��, ��ü �� �� SAL ���� ���ϴ� 3��° ���
SELECT DECODE(lv, 1, deptno, 2, null)deptno,SUM(sal)
FROM emp, (SELECT LEVEL lv
            FROM dual    
            CONNECT BY LEVEL <= 2)
GROUP BY DECODE(lv, 1, deptno, 2, null)
ORDER BY 1;


������ ����
START WITH : ���� ������ ������ ���
CONNECT BY : ����(��)�� ������� ǥ��

SELECT *
FROM emp, emp d
WHERE emp.mgr = d.empno;


XXȸ�����(�ֻ��� ���)���� ���� ��������� ���������� Ž���ϴ� ����Ŭ ������ ���� �ۼ�
1. �������� ���� : xxȸ��
2. ������ ����� ǥ��
    PRIOR : ���� ���� �а� �ִ� ���� ǥ��
    


    �ƹ��͵� ������ ���� : ���� ������ ���� ���� ǥ��
SELECT *
FROM dept_h;

SELECT dept_h.*, LEVEL, LPAD(' ',(LEVEL-1)*3) || deptnm lpad
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;



SELECT level lv, dept_h.*
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

�����
������ ; �������� - dept0_00_0
SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;


SELECT LEVEL lv,deptcd,LPAD(' ',(LEVEL-1)*3) || deptnm deptnm ,p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

SELECT h_sum.*
FROM h_sum;

SELECT level lv,h_sum.*,LPAD(' ',(LEVEL-1)*3) || s_id sid
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

SELECT*
FROM no_emp;

CONNECT BY �� ���Ŀ� �̾ PRIOR�� ���� �ʾƵ� ��� ����.
PRIOR�� ���� �а� �ִ� ���� ��Ī�ϴ� Ű����

SELECT LPAD(' ',(LEVEL-1)*3) || org_cd org_cd,no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;


Pruning branch : ���� ġ��
WHERE ���� ������ ��� ������ : ������ ������ ������ ���� �������� ����
CONNECT BY ���� ��� ���� �� : �����߿� ������ ����
�� ���̸� ��
* �� ������ �������� FROM -> START WITH CONNECT BY -> WHERE�� ������ ó���ȴ�.


1.WHERE���� ������ ����� ���

SELECT LEVEL lv,deptcd,LPAD(' ',(LEVEL-1)*3) || deptnm deptnm ,p_deptcd
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;


2.CONNECT BY���� ������ ����� ���

SELECT LEVEL lv,deptcd,LPAD(' ',(LEVEL-1)*3) || deptnm deptnm ,p_deptcd
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '������ȹ��';

������ �������� ����� �� �ִ� Ư�� �Լ�
CONNECT_BY_ROOT(colum): �ش� �÷��� �ֻ��� �����͸� ��ȸ
SYS_CONNECT_BY_PATH(colum, ������) : �ش� ���� ������� ���Ŀ� ���� colnm���� ǥ���ϰ� �����ڸ� ���� ����
CONNECT_BY_ISLEAF ���ڰ� ���� : �ش� ���� ������ ���̻� ���� ������ ������� (LEAF ���)
                                LEAF��� : 1,NO LEAF��� : 0

������
    ==���
        ==���
������
    ==���
    ==���
SELECT LEVEL lv,deptcd,LPAD(' ',(LEVEL-1)*3) || deptnm deptnm ,p_deptcd,
            CONNECT_BY_ROOT('dept0'),
            LTRIM(SYS_CONNECT_BY_PATH(deptnm,'-'),'-'),
            CONNECT_BY_ISLEAF
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;


SELECT *
FROM board_test;

SELECT seq, LPAD(' ',(LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR SEQ = parent_seq;            


h7] �ֽű��� ���� ������ ����
SELECT seq, LPAD(' ',(LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR SEQ = parent_seq
ORDER BY seq desc; --��Ī������ ��������

h8]
ORDER SIBLINGS BY : ������ ������ ���Ľ� ���� ������ �����ϸ鼭 ���� �ϴ� ����� ����
SELECT seq, LPAD(' ',(LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR SEQ = parent_seq
ORDER SIBLINGS BY seq desc; 



h9]
SELECT seq, LPAD(' ',(LEVEL-1)*3) || title title,
        CASE WHEN parent_seq IS NULL THEN seq ELSE 0 END o1,
        CASE WHEN parent_seq IS NOT NULL THEN seq ELSE 0 END o2
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR SEQ = parent_seq
ORDER SIBLINGS BY CASE WHEN parent_seq IS NULL THEN seq ELSE 0 END DESC, seq;

ALTER TABLE board_test ADD (gp_no NUMBER);

UPDATE board_test SET gp_no = 4
WHERE seq IN(4,10,11,5,8,6,7);

UPDATE board_test SET gp_no = 2
WHERE seq IN(2,3);

UPDATE board_test SET gp_no = 1
WHERE seq IN(1,9);
commit;

SELECT *
FROM board_test;

SELECT gp_no,CONNECT_BY_ROOT(seq), seq, LPAD(' ',(LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR SEQ = parent_seq
ORDER BY CONNECT_BY_ROOT(seq) desc, seq asc; 

��ü �����߿� ���� ���� �޿��� �޴� ����� �޿�����
�ٵ� �װ� ������?
SELECT*
FROM emp;

emp ���̺��� 2�� �о ������ �޼� ==> ���ݴ� ȿ������ ����� ������ ? ==> WINDOW / ANALYSIS function
SELECT ename
FROM emp
WHERE sal = (SELECT MAX(sal)
               FROM emp);




SELECT bb.ename,bb.sal,bb.deptno,aa.lv
FROM
 (SELECT ROWNUM rn,b.*
  FROM
   (SELECT *
    FROM emp
    ORDER BY deptno, sal DESC)b)bb,
    
 (SELECT ROWNUM rn, a.*
  FROM 
   (SELECT a.*,b.lv
    FROM 
     (SELECT deptno, count(*) cnt
      FROM emp
      GROUP BY deptno)a, 
     (SELECT LEVEL lv
      FROM dual
      CONNECT BY LEVEL <=6)b 
  WHERE a.cnt >= lv
  ORDER BY a.deptno, b.lv)a)aa
WHERE aa.rn = bb.rn;





