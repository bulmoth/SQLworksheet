--�Լ� (NULL ó��)

--NVL
SELECT EMPNO, ENAME, JOB, SAL, NVL(COMM,0)
FROM EMP
;

--NVL2 
--NULL�� �ƴ� ���� ������ ���� ��쿡�� �̰� ���� �� �� ȿ������(������ �����ư�)
--NVL�� ����ϰ� �Ǵ��ϰ� �ϴµ� ��� �Ǵ� �ϰ� ����� �ϱ� ������ ������ ����...
SELECT EMPNO, ENAME, JOB, SAL, NVL2(COMM,COMM*12,0)
FROM EMP
;

--NULLIF
SELECT EMPNO, ENAME, JOB, SAL, COMM, NULLIF(SAL, 800) AS "800�� NULL�� ǥ��"
FROM EMP;