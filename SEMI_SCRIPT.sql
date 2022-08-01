-- SEMI DDL

--------------------------------
-- MEMBER
--------------------------------

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    NO              NUMBER          PRIMARY KEY
    , ID            VARCHAR2(30)    NOT NULL UNIQUE
    , PWD           VARCHAR2(100)   NOT NULL
    , NAME          VARCHAR2(15)    NOT NULL
    , PHONE         CHAR(13)
    , EMAIL         VARCHAR2(100)
    , ADDR          VARCHAR2(100)
    , INTEREST      VARCHAR2(100)
    , ENROLL_DATE   TIMESTAMP       DEFAULT SYSDATE
    , MODIFY_DATE   TIMESTAMP       DEFAULT SYSDATE
    , STATUS        CHAR(1)         DEFAULT 'N' CHECK(STATUS IN ('Y','N')) 
);

DROP SEQUENCE SEQ_MEMBER_NO;
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE NOCYCLE;

INSERT INTO MEMBER(NO, ID, PWD, NAME, PHONE, EMAIL, ADDR, INTEREST) VALUES(SEQ_MEMBER_NO.NEXTVAL, 'USER00', '1234', '홍길동', '01012341234', 'abc@naver.com', '강남구 역삼동 테헤란로 1번길', '');

COMMIT;



-----TEST. 사용하고 지울 예정--------
INSERT INTO MEMBER(
    NO
    , ID
    , PWD
    , NAME
    , PHONE
    , EMAIL
    , ADDR
    , INTEREST
    )
VALUES(
    SEQ_MEMBER_NO.NEXTVAL
    , 'USER0728'
    , '1234'
    , '유저'
    , '01012341234'
    , 'user@yaho.com'
    , '강남구 역삼동 테헤란로 123'
    , 'game,cook,book'
);

SELECT * FROM MEMBER;

SELECT *
FROM MEMBER
WHERE ID = 'USER00'
AND PWD = '1234'
AND STATUS = 'N'
;