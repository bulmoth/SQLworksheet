--서브쿼리

SELECT T.*
FROM 
(
    SELECT 
          ROWNUM RN
        , ENAME 이름
        , HIREDATE 입사일
        , SAL 급여
        , DEPTNO 부서번호
    FROM EMP E
    WHERE SAL > 2000
) T
WHERE 부서번호 = 10
OR 부서번호 = 20
ORDER BY RN
;

SELECT 
      ROWNUM RN
    , ENAME 이름
    , HIREDATE 입사일
    , SAL 급여
    , DEPTNO 부서번호
FROM EMP E
WHERE SAL > 2000
;