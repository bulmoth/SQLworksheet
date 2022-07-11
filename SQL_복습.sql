-- SELECT

/*
    산술연산
    칼럼 별칭 지정
    테이블에 별칭 지정
    중복제거 DISTINCT
    || 연산자로 문자열 합치기 기능
*/

/*
    WHERE
        비교 연산자로 비교
        BETWEEN A AND B
        IS [NOT] NULL
        AND, OR
        괄호 이용해서 우선순위 지정 가능
        LIKE %, _
*/

SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC NULLS FIRST
;

--EMP_ID = 200
SELECT *
FROM EMPLOYEE
WHERE EMP_ID < 210
ORDER BY EMP_NAME ASC --DESC 내림차순
;

/*
    --단일행 함수
        LENGTH
        LENGTHB
        INSTR : 지정한 위치부터 지정된 숫자 번째까지 나타나는 문자의 시작 위치
        LPAD / RPAD : 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여줌
        LTRIM / RTRIM / TRIM : 공백제거
        SUBSTR : 지정한 위치부터, 지정한 갯수만큼 문자열 추출
        LOWER / UPPER / INITCAP
        CONCAT : 문자열 합치기
        REPLACE : 변경하려는 문자 변경
        
        ABS
        MOD
        ROUND
        FLOOR
        CELL
        TRUNC
        
        MONTS_BETWEEN
        ADD_MONTHS
        
        EXTRACT(YEAR|MONTH|DAY FROM DATE) : 
*/


SELECT INSTR('HELLO WOLRD', 'L', 2) FROM DUAL;

SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL;

/*
    문자열 : TO_CHAR
    숫자 : TO_NUMBER
    날짜 : TO_DATE
*/

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')FROM DUAL;

/*
    NULL 처리 함수
        NVL
        NVL2
        DECODE
        CASE ~ WHEN ~ THEN ~ ELSE ~ END
*/

--EMPLOYEE 테이블에서 사원명, 급여, 보너스, 보너스 포함 월급 조회
SELECT 
    EMP_NAME 사원명
    , SALARY 급여
    , SALARY*NVL(BONUS,0) 보너스
    , SALARY+SALARY*NVL(BONUS,0) 총급여
FROM EMPLOYEE
;

SELECT
    EMP_NAME 사원명
    , NVL(BONUS, 0) 기존보너스율
    , NVL2(BONUS, 0.1, 0) 변경된보너스율
    , (SALARY+SALARY*NVL2(BONUS, 0.1, 0))*12 연봉
FROM EMPLOYEE
;

--DECODE
--EMPLOYEE 테이블에서 사원 번호, 사원명, 주민번호, 성별 조회
SELECT
    EMP_ID 사원번호
    , EMP_NAME 사원명
    , EMP_NO 주민번호
    , DECODE(SUBSTR(EMP_NO,8,1),1, '남자', 2, '여자') 성별
FROM EMPLOYEE
;
--CASE
SELECT
    EMP_ID 사원번호
    , EMP_NAME 사원명
    , EMP_NO 주민번호
    , CASE
        WHEN SUBSTR(EMP_NO,8,1)=1 THEN '남자'
        WHEN SUBSTR(EMP_NO,8,1)=2 THEN '여자'
        ELSE '응답 없음'
    END
        성별
FROM EMPLOYEE
;

/*
    그룹 함수
        SUM
        AVG
        MIN
        MAX
        COUNT
*/

SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY)>3000000
;

--각 부서별 그룹으로 묶어서 부서별 급여 총 합 조회
SELECT DEPT_CODE 부서명, SUM(SALARY) 부서급여총합
FROM EMPLOYEE
GROUP BY DEPT_CODE
;

--전체 사원 수 조회
SELECT COUNT(*) 사원수
FROM EMPLOYEE
;

--각 부서별 사원 수 조회
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
;

--각 부서별, 보너스 받는 사원 수
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
;

/*
    집계함수
        CUBE
        ROLLUP
        GROUPING SETS
        
        GROUPING
*/

SELECT 
    DEPT_CODE
    , GROUPING(DEPT_CODE)
    , SUM(SALARY)
    , AVG(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE)
;

/*
    집합 연산자
        UNION
        UNION ALL --중복 포함
        INTERSECT
        MINUS
*/

/*
    JOIN
        INNER JOIN
        OUTER JOIN
            -LEFT, RIGHT, FULL
        CROSS JOIN
        ==> EQUL JOIN
        
        <-> NON-EQUL JOIN(부등호, BETWEEN 등을 이용해 JOIN)
        
        SELF JOIN
*/

--사원의 테이블의 부서코드를 이용해서, 부서 이름도 함께 출력
SELECT A.EMP_NAME, A.DEPT_CODE, B.DEPT_TITLE
FROM EMPLOYEE A
--FULL OUTER JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
CROSS JOIN DEPARTMENT B
;

--NO EQUAL JOIN (비등가 조인)
SELECT E.EMP_NAME, E.SALARY, S.SAL_LEVEL, S.MIN_SAL, S.MAX_SAL
FROM EMPLOYEE E
--JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL)
JOIN SAL_GRADE S ON (E.SALARY > S.MIN_SAL) --MIN_SAL 보다 높기만 하면 전부 출력
ORDER BY EMP_NAME
;