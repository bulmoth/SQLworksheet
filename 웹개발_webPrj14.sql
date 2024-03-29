-- webPrj14member


--회원 테이블 ----------------------------
DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    NO NUMBER PRIMARY KEY
    ,ID VARCHAR2(50) UNIQUE NOT NULL
    , PWD VARCHAR(100) NOT NULL
    , NICK VARCHAR2(30) NOT NULL
    , ENROLL_DATE TIMESTAMP DEFAULT SYSDATE
    , QUIT_YN CHAR(1) DEFAULT 'N' CHECK(QUIT_YN IN ('Y','N')) 
);

--회원 시퀀스 -----------------------------
DROP SEQUENCE SEQ_MEMBER_NO;
CREATE SEQUENCE SEQ_MEMBER_NO
NOCACHE NOCYCLE
;

--회원 데이터-------------------------------
INSERT INTO MEMBER (NO, ID, PWD, NICK, ENROLL_DATE, QUIT_YN)
VALUES (SEQ_MEMBER_NO.NEXTVAL, 'ADMIN', '1234', '김관리', DEFAULT, DEFAULT)
;

SELECT NO, ID, NICK, ENROLL_DATE
FROM MEMBER
WHERE ID='ADMIN'
AND PWD='1234'
AND QUIT_YN = 'N'
;

INSERT INTO MEMBER(NO, ID, PWD, NICK)
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'USER01','1234','NICK01')
;

SELECT *
FROM MEMBER
;