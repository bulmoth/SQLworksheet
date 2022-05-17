--개요

-- <SQL>
-- DDL
/*
    DATA DEFINATION LANGUAGE(데이터 정의 언어)
    EX) 테이블 생성 구문
*/

-- DML
/*
    DATA MANIPULATION LANGUAGE(데이터 조작 언어)
    EX) SELELCT, INSERT, UPDATE, DELETE
*/
-- DCL
/*
    DATA CONTROL LANGUAGE(데이터 제어 언어)
    EX) GRANT,
*/

----------------------------------------------------------------------

-- 자료형

-- 문자열 형식
/*
    CHAR(SIZE)
    EX) CHAR(10) : 10 바이트 까지 담을 수 있는 문자열 칼럼 생성
    
    VARCHAR2(SIZE)
    EX) VARCHAR2(10) : 최대 10 바이트 까지 담을 수 있는 문자열 칼럼 생성
    
    NCHAR(SIZE)
    EX) NCHAR(10) : 10 글자 까지 담을 수 있는 데이터 (상황에 따라 한 글자 당 2||3 바이트로 처리됨)
*/

-- 대용량 형식
/*
    LONG : 이제는 사용 안함
    CLOB : 대용량 문자열 타입 (4GB)
    NCLOB : CLOB 과 비슷한테, 유니코드로 처리
*/

-- 숫자(NUMERIC) 형식
/*
    NUMBER : 최대 38글자로 이루어진 숫자 == NUMBER(38)
    NUMBER(10) : 최대 10글자로 이루어진 숫자
    NUMBER(10, 5) : 소수점 5자리 포함하는 최대 10자리 숫자
    NUMBER(10, -5) : 소수전 -5자리에서 반올림하는 최대 10자리 숫자
*/

-- 날짜(DATE) 형식
/*
    DATE : 날짜 저장
    TIMESTAMP : 날짜 + 시간 저장
    TIMESTAMP WITH TIME ZONE : 날짜 + 시간 + 위치 저장 ::: TIME ZONE : UTC +09:00 이런거...
    TIMESTAMP WITH LOCAL TIME ZONE : 날짜 + 시간 + 위치 저장
*/























