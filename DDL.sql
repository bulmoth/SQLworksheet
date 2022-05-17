-- DDL (테이블 생성)

/*
    [문법]
    CREATE TABLE 테이블명(
        칼럼명 칼럼타입,
        칼럼명 칼럼타입,
        칼럼명 칼럼타입,
    );
*/

--테이블 생성
CREATE TABLE MEMBER(
      NO          NUMBER
    , ID          VARCHAR2(30)
    , PWD         VARCHAR2(100)
    , PHONE       CHAR(13)
    , ENROLL_DATE TIMESTAMP
);

-- 데이터 조회
SELECT * FROM MEMBER;

-- 데이터 넣기
INSERT INTO MEMBER
VALUES (1, 'SWY', '1234', '010-1234-5678', SYSDATE);

--데이터 수정

-- 데이터 삭제