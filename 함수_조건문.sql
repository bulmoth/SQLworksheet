--함수

--DECODE
SELECT EMPNO, ENAME, DEPTNO, DECODE(DEPTNO, 10, '영업1팀', 20, '영업2팀', 30, '영업3팀')
FROM EMP;

--CASE WHEN THEN END (ELSE)
--DECODE에서 가독성이 높아짐, 유지보수가 편함, 연산자를 쓸 수가 있다...
SELECT 
      EMPNO
    , ENAME
    , DEPTNO
    , CASE
        WHEN DEPTNO = 10 THEN '영업1팀'
        WHEN DEPTNO = 20 THEN '영업2팀'
        WHEN DEPTNO = 30 THEN '영업3팀'
        ELSE '부서없음'
      END
FROM EMP
ORDER BY DEPTNO ASC
;

--실습
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
    , CASE
        WHEN SAL < 1000 THEN '신입'
        WHEN SAL < 2000 THEN '초급'
        WHEN SAL < 3000 THEN '중급'
        WHEN SAL < 4000 THEN '고급'
        ELSE '특급'
      END AS "구분"
FROM EMP
;