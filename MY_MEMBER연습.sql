DROP TABLE MY_MEMBER;
CREATE TABLE MY_MEMBER(
    NO NUMBER PRIMARY KEY
    ,ID VARCHAR2(20) NOT NULL UNIQUE
    ,PWD VARCHAR2(100) NOT NULL
    ,NICK VARCHAR2(20)
);

DROP SEQUENCE MY_MEMBER_SEQ;
CREATE SEQUENCE MY_MEMBER_SEQ NOCACHE NOCYCLE;