-- 뷰

SELECT *
FROM EMP
;

SELECT *
FROM DEPT
;

--SYS 계정에서 권한 부여를 해주어야 함
--GRANT  CREATE VIEW TO C##KH; 
CREATE VIEW EMPANDDEPT
AS
    SELECT 
          EMPNO
        , ENAME
        , MGR
        , HIREDATE
        , SAL
        , COMM
        , E.DEPTNO
        , DNAME
        , LOC
    FROM EMP E
    JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
;

SELECT * 
FROM EMPANDDEPT
;