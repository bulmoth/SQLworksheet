--전체 사원 조회, 급여는 10% 인상한 값으로 조회

SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL*1.1 급여, COMM, DEPTNO
FROM EMP
;

--전체 사원 조회, EMPNO, ENAME, 급여와 COMM의 합계를 조회

SELECT EMPNO, ENAME, ((SAL*1.1)+NVL(COMM,0)) "급여+COMM"
FROM EMP
;

--전채 사원 조회, EMPNO, ENAME, COMM을 받는 사원의 급여는 2배로 조회, 받지 않는 (NULL) 사원은 급여를 그대로 조회

SELECT EMPNO
    , ENAME
    , CASE
        WHEN COMM IS NOT NULL THEN SAL *2
        WHEN COMM IS NULL THEN SAL
    END AS 급여
FROM EMP
;

--급여가 높은 상위 3명 조회
SELECT *
FROM 
(--인라인 뷰(서브쿼리 자리에 쓴 쿼리문)
    SELECT *
    FROM EMP
    ORDER BY SAL DESC
)
WHERE ROWNUM <=3
;










---------------------------------시험이외
--서브쿼리 (다중 열)
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, SAL
                        FROM EMP
                        WHERE DEPTNO = 30);
                        
--스칼라 서브쿼리 (단일 행)
SELECT 
    ENAME
    , DEPTNO
    , SAL
    ,
    (
    SELECT TRUNC(AVG(SAL))
    FROM EMP
    WHERE DEPTNO = E.DEPTNO --현재 커서가 있는 (E의)ROW에 있는 DEOPNO와 같은 값을 가지는 (안쪽의)EMP테이블의 ROW...들의 SAL평균
    ) AS 부서평균급여
    FROM EMP E
    ;
    
--상(호 연)관 (서브)쿼리
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
;   --JOIN이랑 똑같은거....


--ORDER BY 절 서브쿼리
SELECT EMPNO, ENAME, DEPTNO, HIREDATE
FROM EMP E
ORDER BY
(
    SELECT DNAME
    FROM DEPT
    WHERE DEPTNO = E.DEPTNO
) DESC
;

--TRUNCATE --스키마만 남기고 데이터를 싹 날림...그리고 자동 커밋이기 때문에 롤백 안됨
SELECT * FROM EMP;
TRUNCATE TABLE EMP; --DELETE랑 다르게 ROLLBACK이 안됨...속도도 다르대
DELETE FROM EMP;
ROLLBACK;