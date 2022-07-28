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

INSERT INTO MEMBER(NO, ID, PWD, NAME, PHONE, EMAIL, ADDR, INTEREST) VALUES(SEQ_MEMBER_NO.NEXTVAL, 'USER00', '1234', 'ȫ�浿', '01012341234', 'abc@naver.com', '������ ���ﵿ ������� 1����', '');

COMMIT;