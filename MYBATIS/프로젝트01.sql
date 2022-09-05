-------------------
--MEMBER 테이블
-------------------

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    ID              VARCHAR2(50)
    ,PWD            VARCHAR2(100)
    ,NICK           VARCHAR2(50)
    ,ENROLL_DATE    TIMESTAMP DEFAULT SYSDATE
    ,QUIT_YN        CHAR(1) DEFAULT 'N'
);

----------------------
--BOARD 테이블
----------------------

DROP TABLE BOARD;
CREATE TABLE BOARD(
    TITLE              VARCHAR2(100)
    ,CONTENT            VARCHAR2(4000)
    ,ENROLL_DATE    TIMESTAMP DEFAULT SYSDATE
    ,DELETE_YN        CHAR(1) DEFAULT 'N'
);


-----------------------테스트
SELECT
    TITLE
    ,CONTENT
    ,ENROLL_DATE
    ,DELETE_YN
FROM BOARD
WHERE DELETE_YN = 'N'
;

ROLLBACK;

SELECT * FROM BOARD;
SELECT * FROM MEMBER;