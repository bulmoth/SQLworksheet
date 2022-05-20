--�Լ�

--DECODE
SELECT EMPNO, ENAME, DEPTNO, DECODE(DEPTNO, 10, '����1��', 20, '����2��', 30, '����3��')
FROM EMP;

--CASE WHEN THEN END (ELSE)
--DECODE���� �������� ������, ���������� ����, �����ڸ� �� ���� �ִ�...
SELECT 
      EMPNO
    , ENAME
    , DEPTNO
    , CASE
        WHEN DEPTNO = 10 THEN '����1��'
        WHEN DEPTNO = 20 THEN '����2��'
        WHEN DEPTNO = 30 THEN '����3��'
        ELSE '�μ�����'
      END
FROM EMP
ORDER BY DEPTNO ASC
;

--�ǽ�
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
    , CASE
        WHEN SAL < 1000 THEN '����'
        WHEN SAL < 2000 THEN '�ʱ�'
        WHEN SAL < 3000 THEN '�߱�'
        WHEN SAL < 4000 THEN '���'
        ELSE 'Ư��'
      END AS "����"
FROM EMP
;