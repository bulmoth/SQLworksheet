--��ü ��� ��ȸ, �޿��� 10% �λ��� ������ ��ȸ

SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL*1.1 �޿�, COMM, DEPTNO
FROM EMP
;

--��ü ��� ��ȸ, EMPNO, ENAME, �޿��� COMM�� �հ踦 ��ȸ

SELECT EMPNO, ENAME, ((SAL*1.1)+NVL(COMM,0)) "�޿�+COMM"
FROM EMP
;

--��ä ��� ��ȸ, EMPNO, ENAME, COMM�� �޴� ����� �޿��� 2��� ��ȸ, ���� �ʴ� (NULL) ����� �޿��� �״�� ��ȸ

SELECT EMPNO
    , ENAME
    , CASE
        WHEN COMM IS NOT NULL THEN SAL *2
        WHEN COMM IS NULL THEN SAL
    END AS �޿�
FROM EMP
;

--�޿��� ���� ���� 3�� ��ȸ
SELECT *
FROM 
(--�ζ��� ��(�������� �ڸ��� �� ������)
    SELECT *
    FROM EMP
    ORDER BY SAL DESC
)
WHERE ROWNUM <=3
;










---------------------------------�����̿�
--�������� (���� ��)
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, SAL
                        FROM EMP
                        WHERE DEPTNO = 30);
                        
--��Į�� �������� (���� ��)
SELECT 
    ENAME
    , DEPTNO
    , SAL
    ,
    (
    SELECT TRUNC(AVG(SAL))
    FROM EMP
    WHERE DEPTNO = E.DEPTNO --���� Ŀ���� �ִ� (E��)ROW�� �ִ� DEOPNO�� ���� ���� ������ (������)EMP���̺��� ROW...���� SAL���
    ) AS �μ���ձ޿�
    FROM EMP E
    ;
    
--��(ȣ ��)�� (����)����
SELECT 
    ENAME
    , JOB
    , DEPTNO
    ,
    (
    SELECT DNAME
    FROM DEPT
    WHERE DEPTNO = E.DEPTNO
    ) DNAME
FROM EMP E
;   --JOIN�̶� �Ȱ�����....


--ORDER BY �� ��������
SELECT EMPNO, ENAME, DEPTNO, HIREDATE
FROM EMP E
ORDER BY
(
    SELECT DNAME
    FROM DEPT
    WHERE DEPTNO = E.DEPTNO
) DESC
;

--TRUNCATE --��Ű���� ����� �����͸� �� ����...�׸��� �ڵ� Ŀ���̱� ������ �ѹ� �ȵ�
SELECT * FROM EMP;
TRUNCATE TABLE EMP; --DELETE�� �ٸ��� ROLLBACK�� �ȵ�...�ӵ��� �ٸ���
DELETE FROM EMP;
ROLLBACK;