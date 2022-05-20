--함수 (NULL 처리)

--NVL
SELECT EMPNO, ENAME, JOB, SAL, NVL(COMM,0)
FROM EMP
;

--NVL2 
--NULL이 아닌 값에 연산이 들어가는 경우에는 이걸 쓰는 게 더 효과적임(연산이 덜돌아감)
--NVL은 계산하고 판단하고 하는데 얘는 판단 하고 계산을 하기 때문에 연산이 덜들어감...
SELECT EMPNO, ENAME, JOB, SAL, NVL2(COMM,COMM*12,0)
FROM EMP
;

--NULLIF
SELECT EMPNO, ENAME, JOB, SAL, COMM, NULLIF(SAL, 800) AS "800은 NULL로 표시"
FROM EMP;