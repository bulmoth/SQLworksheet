--함수 (문자열)

--SUBSTR(문자열, 시작 위치, 갯수)
SELECT SUBSTR('ABCDEFGHIJK', 3, 50)
FROM DUAL;

SELECT *
FROM EMP
WHERE ENAME LIKE '%' || SUBSTR('ABCDEFGHIJK', 5, 1) || '%'
--WHERE ENAME LIKE '%E%'
;

--CONCAT : 문자열 합치는 기능
--SELECT 'ABC' || '심원용'
SELECT CONCAT('ABC', '심원용')
FROM DUAL
;

--TRIM : 양쪽 공백 제거 
--LTRIM : 왼쪽 공백 제거
--RTIRM : 오른쪽 공백 제거
SELECT '   ABC   '
FROM DUAL
;

SELECT TRIM('   ABC   ')
FROM DUAL
;

--LOWER : 소문자로 변경
--UPPER : 대문자로 변경
SELECT LOWER('ABC')
FROM DUAL
;

--REPLACE
SELECT REPLACE ('ABC', 'B', 'X')
FROM DUAL
;

--PAD : 문자열을 특정 길이만큼 채워줌
--LPAD
--RPAD
SELECT LPAD('ABC',10, '#') AS T
FROM DUAL
;

--INITCAP : 첫글자를 대문자로 바꿔줌
SELECT INITCAP('abc')
FROM DUAL
;

--INSTR : 특정 문자열이 몇번째 글자부터 시작하는지 확인
SELECT INSTR('ABCDEFGKH12345KH12345', 'CD', 5, 2)
FROM DUAL
;

--LENGTH : 문자열 길이 확인
SELECT LENGTH('ABC123ZZZ안녕')
FROM DUAL
;