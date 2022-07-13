--춘 대학교 워크북 과제
--SQL02_SELECT(Function)

-- 1번
-- 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL문장을 작성하시오.
-- (단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE
    DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE DESC
;

-- 2번
-- 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 그 교수의 이름과 주민번호를 화면에 출력하는 SQL문장을 작성해보자.
-- (*이때 올바르게 작성한 SQL 문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇인지 생각해볼 것) 
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE 
    LENGTH(PROFESSOR_NAME) = 2
;

-- 3번
-- 춘 기술대학교의 남자 교수들의 이름을 출력하는 SQL 문장을 작성하시오. 단 이때 나이가 적은 사람에서 많은 사람 순서
-- (나이가 같다면 이름의 가나다 순서)로 화면에 출력되도록 만드시오.
-- (단, 교수 중 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름"으로 한다. 나이는 '만'으로 계산한다.)
-- 실행 월에 따라 결과 값 다를 수 있으므로 PROFESSOR_SSN 같이 SELECT 해서 확인해보기!!
SELECT PROFESSOR_NAME 교수이름, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE
    SUBSTR(PROFESSOR_SSN,8,1) = 1
ORDER BY FLOOR(MONTHS_BETWEEN(SYSDATE,TO_DATE(SUBSTR(PROFESSOR_SSN,0,6)))/12) ASC
;

-- 4번
-- 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는 "이름"이 찍히도록 한다.
-- (성이 2자인 경우의 교수는 없다고 가정하시오)
SELECT SUBSTR(PROFESSOR_NAME,2,2) 이름
FROM TB_PROFESSOR
;


-- 5번
-- 춘 기술대학교의 재수생 입학자 학번과 이름을 표시하시오.(이때, 19살에 입학하면 재수를 하지 않은 것으로 간주)
-- 문제에서 요구하는 내용은 현역과 삼수생을 모두 제외한 재수생만 추려내는 것 (삼수생도 포함한 결과는 245행)
-- 0301생인 김정현 학생을 제외시키기 위해 19 초과 20 이하라는 조건식 사용
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE FLOOR(MONTHS_BETWEEN(ENTRANCE_DATE,TO_DATE(SUBSTR(STUDENT_SSN,0,6)))/12) > 19
    OR FLOOR(MONTHS_BETWEEN(ENTRANCE_DATE,TO_DATE(SUBSTR(STUDENT_SSN,0,6)))/12) <= 20
;

-- 6번
-- 2020년 크리스마스는 무슨 요일인가?
--'DAY': 금요일 'DY': 금 'D': 6
SELECT TO_CHAR(TO_DATE('20/12/25'),'DAY')
FROM DUAL
;

-- 7번
-- TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')은


--답 : 문자열을 날짜로 바꾸는 것
