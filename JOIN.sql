--JOIN

/*
    -EQUI JOIN : INNER JOIN,
    -NON-EQUI JOIN

    -INNER JOIN : �Ȱ��� ���� �ִ� ��츸 JOIN ���ְڴ�
    -OUTER JOIN(LEFT, RIGHT, FULL) : 
    -CROSS JOIN
    -SELF JOIN
*/

SELECT *
FROM EMP
;

SELECT *
FROM DEPT
;

SELECT 
      ENAME �����
    , E.DEPTNO �μ���ȣ
    , DNAME �μ��̸�
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO --ANSIǥ��
;

SELECT 
      ENAME �����
    , E.DEPTNO �μ���ȣ
    , DNAME �μ��̸�
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO --ORACLE����
;