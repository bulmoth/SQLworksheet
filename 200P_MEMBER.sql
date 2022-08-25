DROP TABLE MEMBER CASCADE CONSTRAINTS;
CREATE TABLE MEMBER
(   NO              NUMBER              PRIMARY KEY NOT NULL         
    ,NAME            VARCHAR2(50)       NOT NULL
    ,EMAIL           VARCHAR2(100)      NOT NULL UNIQUE
    ,NICK            VARCHAR2(50)       NOT NULL UNIQUE
    ,PWD             VARCHAR2(100)      NOT NULL
    ,PHONE           VARCHAR2(15)       NOT NULL
    ,TYPE            CHAR(1)            DEFAULT 'P' CHECK(TYPE IN('P','I','B')) 
    ,REGISTRATION    NUMBER             NULL
    ,ENROLL_DATE      TIMESTAMP          DEFAULT SYSDATE  
    ,STATUS          CHAR(1)            DEFAULT 'A' CHECK(STATUS IN('A','S','Q'))
    ,QUIT_DATE       TIMESTAMP          NULL
    ,M_LEVEL         VARCHAR2(50)       DEFAULT '일반회원' CHECK(M_LEVEL IN('일반회원','골드','실버','브론즈'))
    ,SUSPEND_DATE    TIMESTAMP          NULL
    ,CODE            VARCHAR2(50)       NULL
);

DROP SEQUENCE SEQ_MEMBER_NO;
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE NOCYCLE;


INSERT INTO MEMBER 
(NO
,NAME
,EMAIL
,NICK
,PWD
,PHONE
,CODE
)
VALUES
(SEQ_MEMBER_NO.NEXTVAL
,'이회원'
,'abc@abc.com'
,'회원투'
,'1234'
,'01011111111'
,''
);

INSERT INTO MEMBER 
(NO
,NAME
,EMAIL
,NICK
,PWD
,PHONE
)
VALUES
(SEQ_MEMBER_NO.NEXTVAL
,'회원'
,'abcd@abc.com'
,'회원님'
,'1234'
,'01011111111'
);

INSERT INTO MEMBER 
(
NO
,NAME
,EMAIL
,NICK
,PWD
,PHONE
,TYPE
,REGISTRATION
,M_LEVEL
)
VALUES
(SEQ_MEMBER_NO.NEXTVAL
,'메이커1'
,'maker@abc.com'
,'메이커님'
,'1234'
,'01011111111'
,'B'
,'123123123'
,'골드'
);
COMMIT;


--------------------------------
--TEST
--------------------------------
SELECT * FROM MEMBER;