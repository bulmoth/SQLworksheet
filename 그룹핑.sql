--�׷� ������
--�׷��� ������ �����Լ��� �����

--FROM > WHERE >  GROUP BY >  HAVING > SELECT > ORDER BY

SELECT AVG(SAL), DEPTNO--4��
FROM EMP--1��
WHERE COMM IS NOT NULL--2��
GROUP BY DEPTNO--3��
ORDER BY DEPTNO DESC--5��, ORDER BY�� �׻� SELECT ���Ŀ�(��������) �̷����
;

--�׷��� �� ������տ��� ������ �ɰ� ������ HAVING
SELECT AVG(SAL), DEPTNO
FROM EMP
WHERE COMM IS NOT NULL
GROUP BY DEPTNO
HAVING AVG(SAL)>2000    --�׷��� ����� ���� ���� ����
AND DEPTNO < 15
ORDER BY DEPTNO DESC
;

--���� ����
/*
    1. FROM
    2. WHERE
    3. GROUP BY
    4. HAVING
    5. SELECT
    6. ORDER BY
*/