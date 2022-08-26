----------------------------
--ȸ�� TABLE
----------------------------
alter session set nls_date_format='YYYY-MM-DD HH24MISS';

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
    ,M_LEVEL         VARCHAR2(50)       DEFAULT '�Ϲ�ȸ��' CHECK(M_LEVEL IN('�Ϲ�ȸ��','���','�ǹ�','�����'))
    ,SUSPEND_DATE    TIMESTAMP          NULL
    ,CODE            VARCHAR2(50)       NULL
);

DROP SEQUENCE SEQ_MEMBER_NO;
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE NOCYCLE;


----------------------------
--���ƿ� TABLE
----------------------------

DROP TABLE PROJECT_LIKE CASCADE CONSTRAINTS;

CREATE TABLE PROJECT_LIKE(
    NO              NUMBER      PRIMARY KEY,
    MEMBER_NO       NUMBER,
    PROJECT_NO      NUMBER,
    STATUS          CHAR(1)     DEFAULT 'N' CHECK (STATUS IN ('L', 'N'))
);

ALTER TABLE PROJECT_LIKE
ADD CONSTRAINT LIKE_NO_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(NO);
ALTER TABLE PROJECT_LIKE
ADD CONSTRAINT LIKE_NO_PROJECT_NO FOREIGN KEY(PROJECT_NO) REFERENCES PROJECT(PROJECT_NO);

DROP SEQUENCE SEQ_PROJECT_LIKE_NO;
CREATE SEQUENCE SEQ_PROJECT_LIKE_NO NOCACHE NOCYCLE;


----------------------------
--�ȷο� TABLE
----------------------------
DROP TABLE FOLLOW;
CREATE TABLE FOLLOW(
    NO NUMBER PRIMARY KEY
    , MEM_NO NUMBER NOT NULL
    , MAKER_NO NUMBER NOT NULL
);

DROP SEQUENCE SEQ_FOLLOW_NO;
CREATE SEQUENCE SEQ_FOLLOW_NO NOCACHE NOCYCLE;

ALTER TABLE FOLLOW ADD CONSTRAINT FOLLOW_MEMBER_NO
FOREIGN KEY(MEM_NO)REFERENCES MEMBER(NO);

----------------------------
--���� TABLE
----------------------------

DROP TABLE COUPON CASCADE CONSTRAINTS;

CREATE TABLE COUPON
(
    NO NUMBER PRIMARY KEY,
    MEM_NO NUMBER NOT NULL,
    NAME VARCHAR2(400) NOT NULL,
    DISCOUNT NUMBER NOT NULL
);

--ȸ����ȣ �ܷ�Ű ���� (����)
ALTER TABLE COUPON ADD CONSTRAINT MEM_NO 
FOREIGN KEY(NO) REFERENCES MEMBER;

--������ȣ ������
DROP SEQUENCE SEQ_COUPON_NO;
CREATE SEQUENCE SEQ_COUPON_NO NOCACHE NOCYCLE;


----------------------------
--�������� TABLE
----------------------------
DROP TABLE PAYMENT_CREDIT_CARD CASCADE CONSTRAINTS;
CREATE TABLE PAYMENT_CREDIT_CARD(
    NO              NUMBER      PRIMARY KEY
    ,MEMBER_NO       NUMBER      NOT NULL
    ,CARD_NUM        CHAR(16)    NOT NULL
    ,VALID_DATE      CHAR(4)     NOT NULL
    ,CARD_PWD        CHAR(2)     NOT NULL
    ,BIRTH           CHAR(8)
    ,PASSWORD        NUMBER      NOT NULL
    ,REGISTRATION    CHAR(10)
    ,DEFAULT_YN      CHAR(1)     DEFAULT 'N' CHECK(DEFAULT_YN IN('N','Y'))
);

--�������� ������
DROP SEQUENCE SEQ_PAYMENT_NO;
CREATE SEQUENCE SEQ_PAYMENT_NO NOCACHE NOCYCLE;

--ȸ����ȣ �ܷ�Ű
ALTER TABLE PAYMENT_CREDIT_CARD ADD CONSTRAINT PAYMENT_MEMBER_REF_NO 
FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(NO);


----------------------------
--����� TABLE
----------------------------

DROP TABLE DELIVERY_ADDRESS CASCADE CONSTRAINTS;
CREATE TABLE DELIVERY_ADDRESS(
    NO              NUMBER          PRIMARY KEY
    ,MEMBER_NO      NUMBER          NOT NULL
    ,POST_NUM       CHAR(5)         NOT NULL
    ,ADDR1          VARCHAR2(50)    NOT NULL
    ,ADDR2          VARCHAR2(100)   NOT NULL
    ,NAME           VARCHAR2(15)    NOT NULL
    ,PHONE          VARCHAR2(15)    NOT NULL
    ,DEFAULT_YN     CHAR(1)         DEFAULT 'N' CHECK(DEFAULT_YN IN('N','Y'))
);

--ȸ�� ��ȣ �ܷ�Ű
ALTER TABLE DELIVERY_ADDRESS ADD CONSTRAINT ADDR_MEMBER_REF_NO 
FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(NO);

--NO ������
DROP SEQUENCE SEQ_ADDR_NO;
CREATE SEQUENCE SEQ_ADDR_NO NOCACHE NOCYCLE;


----------------------------
--����Ŀ ���� TABLE
----------------------------

DROP TABLE MAKER_QUESTION;
CREATE TABLE MAKER_QUESTION(
    NO              NUMBER PRIMARY KEY  NOT NULL
    , MEMBER_NO     NUMBER NOT NULL
    , MAKER_NO      NUMBER NOT NULL
    , TITLE         VARCHAR2(100) NOT NULL
    , CONTENT       VARCHAR2(500) NOT NULL
    , WRITE_DATE    TIMESTAMP   DEFAULT SYSTIMESTAMP
    , ANSWER_YN     CHAR(1)     DEFAULT 'N'
    , DELETE_YN     CHAR(1)     DEFAULT 'N'
);

DROP SEQUENCE SEQ_MAKER_QUESTION_NO;
CREATE SEQUENCE SEQ_MAKER_QUESTION_NO NOCACHE NOCYCLE;


----------------------------
--����Ŀ �亯 TABLE
----------------------------

DROP TABLE MAKER_ANSWER;
CREATE TABLE MAKER_ANSWER(
    NO                  NUMBER          PRIMARY KEY
    , MAKER_QUESTION_NO NUMBER          NOT NULL
    , TITLE             VARCHAR2(100)   NOT NULL
    , CONTENT           VARCHAR2(500)   NOT NULL
    , WRITE_DATE        TIMESTAMP       DEFAULT SYSTIMESTAMP
    , CORRECTED_DATE    TIMESTAMP       DEFAULT SYSTIMESTAMP
    , DELETE_YN         CHAR(1)         DEFAULT 'N'
)
;

DROP SEQUENCE SEQ_MAKER_ANSWER_NO;
CREATE SEQUENCE SEQ_MAKER_ANSWER_NO NOCACHE NOCYCLE;


----------------------------
--������ TABLE
----------------------------
DROP TABLE ADMIN CASCADE CONSTRAINTS;

CREATE TABLE ADMIN (
    NO           NUMBER           PRIMARY KEY
    , ID         VARCHAR2(100)    NOT NULL    
    , PWD        VARCHAR2(100)    NOT NULL
    , NAME       VARCHAR2(15)     DEFAULT '������'
);

--������ ����
DROP SEQUENCE SEQ_ADMIN_NO;

--������ ����
CREATE SEQUENCE SEQ_ADMIN_NO
NOCACHE NOCYCLE;


----------------------------
--�̺�Ʈ TABLE
----------------------------
DROP TABLE EVENT CASCADE CONSTRAINTS;

CREATE TABLE EVENT (
    NO                  NUMBER              PRIMARY KEY
    , ADMIN_NO           NUMBER              NOT NULL
    , TITLE             VARCHAR2(200)       NOT NULL
    , CONTENT           VARCHAR2(1000)      NOT NULL
    , THUMBNAIL_PATH    VARCHAR2(1000)      NOT NULL           
    , THUMBNAIL_NAME    VARCHAR2(255)       NOT NULL           
    , WRITE_DATE        TIMESTAMP           DEFAULT SYSDATE
    , START_DATE        DATE                NOT NULL
    , END_DATE          DATE                NOT NULL
    , IMPORTANT_YN      CHAR(1)             DEFAULT 'N' CHECK(IMPORTANT_YN IN('Y','N'))
    , EDIT_DATE         TIMESTAMP           DEFAULT SYSDATE
    , EDIT_ADMIN_NO     NUMBER              NULL
    , STATUS             CHAR(1)            DEFAULT 'B' CHECK(STATUS IN('B','I','E','D'))
);

DROP SEQUENCE SEQ_EVENT_NO;
CREATE SEQUENCE SEQ_EVENT_NO NOCACHE NOCYCLE;

ALTER TABLE EVENT
ADD CONSTRAINT EVENT_ADMIN_REF_NO 
FOREIGN KEY (ADMIN_NO) REFERENCES ADMIN;

----------------------------
--�̺�Ʈ ���� TABLE
----------------------------
DROP TABLE EVENT_FILE CASCADE CONSTRAINTS;

CREATE TABLE EVENT_FILE (
    NO              NUMBER          PRIMARY KEY
    , EVENT_NO       NUMBER          NOT NULL
    , PATH          VARCHAR2(1000)  NOT NULL
    , NAME          VARCHAR2(255)   NOT NULL
    , UPLOAD_DATE   TIMESTAMP       DEFAULT SYSDATE
    , DELETE_YN     CHAR(1)         DEFAULT 'N' CHECK(DELETE_YN IN('Y','N'))
);

DROP SEQUENCE SEQ_EVENT_FILE_NO;
CREATE SEQUENCE SEQ_EVENT_FILE_NO NOCACHE NOCYCLE;

ALTER TABLE EVENT_FILE
ADD CONSTRAINT EVENT_FILE_EVENT_REF_NO 
FOREIGN KEY (EVENT_NO) REFERENCES EVENT;

----------------------------
--�������� TABLE
----------------------------
DROP TABLE NOTICE CASCADE CONSTRAINTS;

CREATE TABLE NOTICE (
    NO                  NUMBER              PRIMARY KEY
    , ADMIN_NO          NUMBER              NOT NULL
    , TITLE             VARCHAR2(200)       NOT NULL
    , CONTENT           VARCHAR2(1000)      NOT NULL
    , THUMBNAIL_PATH    VARCHAR2(1000)      NOT NULL           
    , THUMBNAIL_NAME    VARCHAR2(255)       NOT NULL           
    , WRITE_DATE        TIMESTAMP           DEFAULT SYSDATE
    , IMPORTANT_YN      CHAR(1)             DEFAULT 'N' CHECK(IMPORTANT_YN IN('Y','N'))
    , EDIT_DATE         TIMESTAMP           DEFAULT SYSDATE
    , EDIT_ADMIN_NO     NUMBER              NULL
    , DELETE_YN         CHAR(1)             DEFAULT 'N' CHECK(DELETE_YN IN('Y','N'))
);

DROP SEQUENCE SEQ_NOTICE_NO;
CREATE SEQUENCE SEQ_NOTICE_NO NOCACHE NOCYCLE;

ALTER TABLE NOTICE
ADD CONSTRAINT NOTICE_ADMIN_REF_NO 
FOREIGN KEY (ADMIN_NO) REFERENCES ADMIN;

----------------------------
--�������� ���� TABLE
----------------------------
DROP TABLE NOTICE_FILE CASCADE CONSTRAINTS;
CREATE TABLE NOTICE_FILE (
    NO              NUMBER          NOT NULL
    , NOTICE_NO       NUMBER          NOT NULL
    , PATH          VARCHAR2(1000)  NOT NULL
    , NAME          VARCHAR2(255)   NOT NULL
    , UPLOAD_DATE   TIMESTAMP       DEFAULT SYSDATE
    , DELETE_YN     CHAR(1)         DEFAULT 'N' CHECK(DELETE_YN IN('Y','N'))
);

DROP SEQUENCE SEQ_NOTICE_FILE_NO;
CREATE SEQUENCE SEQ_NOTICE_FILE_NO NOCACHE NOCYCLE;

ALTER TABLE NOTICE_FILE
ADD CONSTRAINT NOTICE_FILE_NOTICE_REF_NO 
FOREIGN KEY (NOTICE_NO) REFERENCES NOTICE;


----------------------------
--������Ʈ TABLE
----------------------------
DROP TABLE PROJECT CASCADE CONSTRAINTS;

CREATE TABLE PROJECT
(
    PROJECT_NO NUMBER PRIMARY KEY,
    CATEGORY_NO NUMBER NOT NULL,
    NAME VARCHAR2(100) NOT NULL,
    REGISTER_DATE TIMESTAMP DEFAULT SYSDATE,
    START_DATE DATE NOT NULL,
    END_DATE DATE NOT NULL,
    GOAL NUMBER NOT NULL,
    MAKER_NO NUMBER NOT NULL,
    TEXT VARCHAR2(1000) NOT NULL,
    ACCOUNT_NO VARCHAR2(20) NOT NULL,
    SHIPPING_DATE DATE NOT NULL,
    THUMBNAIL_NAME VARCHAR2(255) NOT NULL,
    THUMBNAIL_PATH VARCHAR2(500) NOT NULL,
    ETC VARCHAR2(1000),
    ACCOUNT_BANK VARCHAR2(20) NOT NULL,
    ACCOUNT_NAME VARCHAR2(20) NOT NULL,
    MAKER_INFO VARCHAR2(500),
    STATUS CHAR(1) DEFAULT 'R' CHECK(STATUS IN('R','N','A','B','I','S','F','D'))
);

COMMENT ON COLUMN PROJECT.STATUS IS 'R=����, N=�ݷ�, A=������, B=������, I=������, S=����(����), F=����(����) D=����';

DROP SEQUENCE SEQ_PROJECT_NO;
CREATE SEQUENCE SEQ_PROJECT_NO NOCACHE NOCYCLE;

----------------------------------
--������Ʈ ���� TABLE
----------------------------------
DROP TABLE DESCRIPTION_FILE CASCADE CONSTRAINTS;

CREATE TABLE DESCRIPTION_FILE
(
    NO NUMBER PRIMARY KEY,
    PROJECT_NO NUMBER NOT NULL,
    FILE_SRC VARCHAR2(1000) NOT NULL,
    ORIGIN_NAME VARCHAR2(255) NOT NULL,
    CHANGE_NAME VARCHAR2(255)NOT NULL,
    UPLOAD_DATE TIMESTAMP DEFAULT SYSDATE
);

ALTER TABLE DESCRIPTION_FILE ADD CONSTRAINT ATT_PROJECT_REF_NO 
FOREIGN KEY(PROJECT_NO) REFERENCES PROJECT;

DROP SEQUENCE SEQ_DESCRIPTION_NO;
CREATE SEQUENCE SEQ_DESCRIPTION_NO NOCACHE NOCYCLE;


----------------------------------
--������ TABLE
----------------------------------
DROP TABLE REWARD CASCADE CONSTRAINTS;

CREATE TABLE REWARD
(
    NO NUMBER PRIMARY KEY,
    PROJECT_NO NUMBER NOT NULL,
    "OPTION" VARCHAR2(50) NOT NULL,
    DETAIL VARCHAR2(200) NOT NULL,
    PRICE NUMBER NOT NULL,
    QUANTITY NUMBER NOT NULL
);

ALTER TABLE REWARD ADD CONSTRAINT REWARD_PROJECT_REF_NO 
FOREIGN KEY(PROJECT_NO) REFERENCES PROJECT;

DROP SEQUENCE SEQ_REWARD_NO;
CREATE SEQUENCE SEQ_REWARD_NO NOCACHE NOCYCLE;


----------------------------------
--ī�װ� TABLE
----------------------------------
DROP TABLE CATEGORY CASCADE CONSTRAINTS;
CREATE TABLE CATEGORY
(
    CATEGORY_NO NUMBER PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL
);

DROP SEQUENCE SEQ_CATEGORY_NO;
CREATE SEQUENCE SEQ_CATEGORY_NO NOCACHE NOCYCLE;

ALTER TABLE PROJECT ADD CONSTRAINT PROJECT_CATEGORY_REF_NO 
FOREIGN KEY(CATEGORY_NO) REFERENCES CATEGORY;

----------------------------------
--�Ŀ����� TABLE
----------------------------------
DROP TABLE DONATE_LIST CASCADE CONSTRAINTS;
CREATE TABLE DONATE_LIST
(
    NO                  NUMBER      PRIMARY KEY,
    REWARD_NO           NUMBER      NOT NULL,
    MEMBER_NO           NUMBER      NOT NULL,
    PAYMENT_METHOD_NO   NUMBER      NOT NULL,
    DELIVERY_ADDR_NO    NUMBER      NOT NULL,
    DONATE_DATE         TIMESTAMP   DEFAULT SYSDATE,
    AMOUNT              NUMBER      NOT NULL,
    QUANTITY            NUMBER      NOT NULL,
    ADDITIONAL          NUMBER      DEFAULT 0,
    CANCEL_YN           CHAR(1)     DEFAULT 'N' CHECK(CANCEL_YN IN('Y','N')),
    CANCEL_DATE         TIMESTAMP
);

DROP SEQUENCE SEQ_DONATE_LIST_NO;
CREATE SEQUENCE SEQ_DONATE_LIST_NO NOCACHE NOCYCLE;

ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_REWARD_NO FOREIGN KEY(REWARD_NO) REFERENCES REWARD(NO);
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(NO);
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_PAYMENT_METHOD_NO FOREIGN KEY(PAYMENT_METHOD_NO) REFERENCES PAYMENT_CREDIT_CARD(NO);
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_DELIVERY_ADDR_NO FOREIGN KEY(DELIVERY_ADDR_NO) REFERENCES DELIVERY_ADDRESS(NO);

----------------------------------
--������Ʈ_���ҽ� TABLE
----------------------------------

DROP TABLE NEWS CASCADE CONSTRAINTS;
CREATE TABLE NEWS(
    NO          NUMBER,
    PROJECT_NO  NUMBER,
    MEMBER_NO   NUMBER,
    CONTENT     VARCHAR2(500),
    NEWS_DATE   TIMESTAMP       DEFAULT SYSDATE,
    DELETE_YN   CHAR(1)         DEFAULT 'N' CHECK(DELETE_YN IN ('Y','N'))
);

ALTER TABLE NEWS
ADD CONSTRAINT NEWS_PROJECT_NO FOREIGN KEY(PROJECT_NO) REFERENCES PROJECT(PROJECT_NO);

ALTER TABLE NEWS
ADD CONSTRAINT NEWS_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(NO);

DROP SEQUENCE SEQ_NEWS_NO;
CREATE SEQUENCE SEQ_NEWS_NO NOCACHE NOCYCLE;

----------------------------------
--�Ű� TABLE
----------------------------------
DROP TABLE REPORT CASCADE CONSTRAINTS;

CREATE TABLE REPORT (
    NO              NUMBER          PRIMARY KEY
    , PROJECT_NO    NUMBER          NOT NULL
    , MEMBER_NO     NUMBER          NOT NULL
    , CONTENT       VARCHAR2(1000)  NOT NULL
    , SUBMIT_DATE          TIMESTAMP       DEFAULT SYSDATE
    , REPORT_AC     CHAR(1)         DEFAULT 'A' CHECK(REPORT_AC IN('A','C'))
);

DROP SEQUENCE SEQ_REPORT_NO;
CREATE SEQUENCE SEQ_REPORT_NO NOCACHE NOCYCLE;

ALTER TABLE REPORT ADD CONSTRAINT PROJECT_REPORT_REF_NO
FOREIGN KEY (PROJECT_NO) REFERENCES PROJECT;

ALTER TABLE REPORT ADD CONSTRAINT MEMBER_REPORT_REF_NO
FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER;











----------------------------
--ȸ�� ���̵�����
----------------------------

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,CODE) 
VALUES(SEQ_MEMBER_NO.NEXTVAL,'��ȸ��','abc@abc.com','ȸ����','1234','01011111111','');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE) 
VALUES(SEQ_MEMBER_NO.NEXTVAL,'ȸ��','abcd@abc.com','ȸ����','1234','01011111111');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'����Ŀ1','maker@abc.com','����Ŀ��','1234','01011111111','B','123123123','���');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'�ǹ̸�','rafl@gamil.com','���ö���','1234','01011111111','B','4471835749','���');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'������','lets@gamil.com','�Ű��� ����','1234','01022222222','I','4698371586','���');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'����','paper@naver.com','PAPER POP','1234','01033333333','B','1764932523','���');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'������','yousunny@naver.com','yousunny','1234','01074185296','I','3441976255','�����');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'�����','wepot@gamil.com','����','1234','01036985214','B','2279886419','���');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'�뿩��','uni@gamil.com','���Ϲ��','1234','01014785236','I','3006794250','�ǹ�');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'���̰�','begin@gamil.com','��佺ũ��','1234','01078965412','B','6174028982','�����');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'�ȸ�','blossom@gamil.com','ķ�۽� ����','1234','01001478523','B','6584290708','���');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'ǥ��ä','eco@naver.com','��������Ʈ','1234','01032145698','B','7925462890','�����');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'������','1umber@naver.com','����','1234','01012365478','I','5891740236','���');

INSERT INTO MEMBER (NO,NAME,EMAIL,NICK,PWD,PHONE,TYPE,REGISTRATION,M_LEVEL)
VALUES(SEQ_MEMBER_NO.NEXTVAL,'�۶��','kindigo@gamil.com','Ų���','1234','01054789632','I','7729580016','���');

COMMIT;



----------------------------
--�ȷο� ���̵�����
----------------------------

INSERT INTO FOLLOW (NO, MEM_NO, MAKER_NO)VALUES(SEQ_FOLLOW_NO.NEXTVAL, 1, 3);

COMMIT;

----------------------------
--���� ���̵�����
----------------------------

INSERT INTO COUPON(NO,MEM_NO,NAME,DISCOUNT)VALUES(SEQ_COUPON_NO.NEXTVAL,SEQ_MEMBER_NO.NEXTVAL,'��������','3000');
INSERT INTO COUPON(NO,MEM_NO,NAME,DISCOUNT)VALUES(SEQ_COUPON_NO.NEXTVAL,SEQ_MEMBER_NO.NEXTVAL,'�ű�����','1000');
INSERT INTO COUPON(NO,MEM_NO,NAME,DISCOUNT)VALUES(SEQ_COUPON_NO.NEXTVAL,SEQ_MEMBER_NO.NEXTVAL,'��������','7000');

COMMIT;

--------------------------------
--�������� ���̵�����
--------------------------------
INSERT INTO PAYMENT_CREDIT_CARD(NO,MEMBER_NO,CARD_NUM,VALID_DATE,CARD_PWD,BIRTH,PASSWORD,DEFAULT_YN)
VALUES(SEQ_PAYMENT_NO.NEXTVAL,1,'1111222233334444','0326','22','20000101',123456,'Y');

INSERT INTO PAYMENT_CREDIT_CARD(NO,MEMBER_NO,CARD_NUM,VALID_DATE,CARD_PWD,BIRTH,PASSWORD,DEFAULT_YN)
VALUES(SEQ_PAYMENT_NO.NEXTVAL,2,'1111222233335555','0326','22','20000101',123456,'N');

INSERT INTO PAYMENT_CREDIT_CARD(NO,MEMBER_NO,CARD_NUM,VALID_DATE,CARD_PWD,PASSWORD,REGISTRATION,DEFAULT_YN)
VALUES(SEQ_PAYMENT_NO.NEXTVAL,3,'1111222233337777','0326','22',123456,'0123456789','Y');

INSERT INTO PAYMENT_CREDIT_CARD(NO,MEMBER_NO,CARD_NUM,VALID_DATE,CARD_PWD,PASSWORD,REGISTRATION,DEFAULT_YN)
VALUES(SEQ_PAYMENT_NO.NEXTVAL,3,'1111222233338888','0326','22',123456,'0123456789','N');

COMMIT;

-------------------------
--����� ���̵�����
-------------------------
INSERT INTO DELIVERY_ADDRESS(NO,MEMBER_NO,POST_NUM,ADDR1,ADDR2,NAME,PHONE,DEFAULT_YN)VALUES(SEQ_ADDR_NO.NEXTVAL,1,12345,'���� ������','������� 1�� ���￪','�ɿ���','01012341234','Y');
INSERT INTO DELIVERY_ADDRESS(NO,MEMBER_NO,POST_NUM,ADDR1,ADDR2,NAME,PHONE,DEFAULT_YN)VALUES(SEQ_ADDR_NO.NEXTVAL,1,12242,'���� ������','������� 2�� ������','������','01012341234','N');
INSERT INTO DELIVERY_ADDRESS(NO,MEMBER_NO,POST_NUM,ADDR1,ADDR2,NAME,PHONE,DEFAULT_YN)VALUES(SEQ_ADDR_NO.NEXTVAL,1,13342,'���� ������','������� 3�� �ų�����','�ɻ��','01045661234','N');
COMMIT;

-------------------------
--����Ŀ ���� ���̵�����
-------------------------
INSERT INTO MAKER_QUESTION(NO, MEMBER_NO, MAKER_NO, TITLE, CONTENT)
VALUES(SEQ_MAKER_QUESTION_NO.NEXTVAL, 1, 3, '����', '����');

COMMIT;

-------------------------
--����Ŀ �亯 ���̵�����
-------------------------
INSERT INTO MAKER_ANSWER(NO, MAKER_QUESTION_NO, TITLE, CONTENT)
VALUES(SEQ_MAKER_ANSWER_NO.NEXTVAL, 1, '����', '����');

COMMIT;

-------------------------
--������ ���̵�����
-------------------------
INSERT INTO ADMIN (NO,ID,PWD) VALUES (SEQ_ADMIN_NO.NEXTVAL, 'admin', '1234');

COMMIT;

-------------------------
--�̺�Ʈ ���̵�����
-------------------------
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ1' , '�̺�Ʈ 1 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ1.jpg' , '2021-03-01' , '2021-04-20' , 'E', 'N') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ2' , '�̺�Ʈ 2 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ2.jpg' , '2021-04-20' , '2021-06-01' , 'E', 'Y') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ3' , '�̺�Ʈ 3 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ3.jpg' , '2021-06-01' , '2021-07-15' , 'E', 'Y') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ4' , '�̺�Ʈ 4 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ4.jpg' , '2021-07-04' , '2021-08-01' , 'E', 'N') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ5' , '�̺�Ʈ 5 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ5.jpg' , '2021-08-03' , '2021-09-30' , 'E', 'N') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ6' , '�̺�Ʈ 6 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ6.jpg' , '2021-09-14' , '2021-11-06' , 'E', 'Y') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ7' , '�̺�Ʈ 7 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ7.jpg' , '2021-10-19' , '2021-11-23' , 'E', 'N') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ8' , '�̺�Ʈ 8 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ8.jpg' , '2021-11-08' , '2021-12-11' , 'E', 'N') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ9' , '�̺�Ʈ 9 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ9.jpg' , '2021-12-07' , '2021-12-31', 'E' , 'Y') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ10' , '�̺�Ʈ 10 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ10.jpg' , '2022-12-01' , '2022-02-01' , 'E', 'Y') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ11' , '�̺�Ʈ 11 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ11.jpg' , '2022-02-01' , '2022-03-26' , 'E', 'N') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ12' , '�̺�Ʈ 12 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ12.jpg' , '2022-03-15' , '2022-05-01' , 'E', 'Y') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ13' , '�̺�Ʈ 13 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ13.jpg' , '2022-04-28' , '2022-06-13' , 'E', 'N') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ14' , '�̺�Ʈ 14 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ14.jpg' , '2022-07-01' , '2022-09-10' , 'I', 'N') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ15' , '�̺�Ʈ 15 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ15.jpg' , '2022-07-30' , '2022-09-20' , 'I', 'Y') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ16' , '�̺�Ʈ 16 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ16.jpg' , '2022-08-15' , '2022-10-30' , 'I', 'Y') ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE,STATUS,IMPORTANT_YN)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ16' , '�̺�Ʈ 16 ���̵����� �����Դϴ�. ' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' , '�̺�Ʈ17.jpg' , '2022-08-25' , '2022-11-01' , 'I', 'N') ;


COMMIT;

-------------------------
--�̺�Ʈ ���� ���̵�����
-------------------------
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,1, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ23.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,2, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ22.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,3, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ21.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,4, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ20.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,5, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ19.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,6, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ18.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,7, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ17.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,8, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ16.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,9, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ20.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,10, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ13.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,11, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ14.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,12, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ11.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,13, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ10.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,14, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ9.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,15, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ8.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,16, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ7.jpg');
INSERT INTO EVENT_FILE (NO, EVENT_NO, PATH, NAME) VALUES (SEQ_EVENT_FILE_NO.NEXTVAL,17, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ4.jpg');
-------

COMMIT;

-------------------------
--�������� ���̵�����
-------------------------
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������1' , '��������1 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ1.jpg', 'Y') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������2' , '��������2 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ2.jpg', 'N') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������3' , '��������3 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ3.jpg', 'N') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������4' , '��������4 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ4.jpg', 'Y') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������5' , '��������5 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ5.jpg', 'N') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������6' , '��������6 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ6.jpg', 'N') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������7' , '��������7 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ7.jpg', 'Y') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������8' , '��������8 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ8.jpg', 'Y') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������9' , '��������9 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ9.jpg', 'N') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������10' , '��������10 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ10.jpg', 'Y') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������11' , '��������11 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ11.jpg', 'Y') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������12' , '��������12 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ12.jpg', 'Y') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������13' , '��������13 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ13.jpg', 'N') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������14' , '��������14 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ14.jpg', 'Y') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,IMPORTANT_YN)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������15' , '��������15 ���̵����� ����' , 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ15.jpg', 'Y') ;

-------------------------
COMMIT;

-------------------------
--�������� ���� ���̵�����
-------------------------
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 1, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ23.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 2, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ22.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 3, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ21.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 4, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ20.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 5, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ19.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 6, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ18.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 7, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ17.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 8, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ16.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 9, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ15.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 10, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ14.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 11, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ13.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 12, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ12.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 13, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ11.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 14, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ10.jpg' );
INSERT INTO NOTICE_FILE ( NO, NOTICE_NO, PATH, NAME ) VALUES ( SEQ_NOTICE_FILE_NO.NEXTVAL, 15, 'C:\dev\semiPrj200\semiPrj00\WebContent\resources\admin\event' ,'�̺�Ʈ9.jpg' );

-------

COMMIT;

-------------------------
--ī�װ� ���̵�����
-------------------------
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(1, 'Ǫ��');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(2, 'Ȩ, ����');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(3, '�����Ƽ');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(4, '��ũ, ����');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(5, '�м�, ��ȭ');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(6, '�ݷ�����');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(7, '����, ����');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(8, '����, ����');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(9, 'Ŭ����');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(10, '��Ƽ');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(11, '������');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(12, '����ũ');

COMMIT;

-------------------------
--������Ʈ ���̵�����
-------------------------
SET DEFINE OFF;

Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,2,'1008�ð��� ��ٸ����� ���� ��¥! õ���� [���ö���]',to_timestamp('22/07/22 22:04:43.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-08-02 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-08-27 23:59:59','YYYY-MM-DD HH24:MI:SS'),1000000,4,'����� �Ǻ� ����! "1008�ð��� ��ȿ"���� ���� ã�Ҿ��!
���κ��� ���ɸ��� ����� ''�������� ���� ���� �ʴ´�''��� ���� ����. ��, ��ȿ�� ������� ���ɸ��� �����̰�, �� �λ깰�� ''���Թ�''���� �Ǻ� ����, ����� ȿ������ ���е��� ����Ǿ� �־��.
�׵��� �׾ƿ� ��ȿ����� ���Թ̿� �Ҵ����� Ȱ���� �Ѿ���κ��� �̹�, ����, ����, ��߿� ������ �ִ� ���е��� ��ȿ �����߾��. �׸���, õ����� 99.99%! �̰��� ��¥ õ����[���ö���] ����!  ���Ȱ����, ����󿢽�Ʈ������ø������, õ������, õ�������ȿ���, õ���и� ��!','1234567890',to_date('2022-09-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661173482898_c2626a08.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload',null,'�츮','�ǹ̸�','RA:FL(����)�� Ǯ������ Rice Flower �� ��, ��ȿ�� ���� �� TOL(��)�� ���� �Ǵ� ��� �ǹ��Դϴ�. ��ȿ�� ������ ������ ������ ���� ��� ���� õ���� RA:FL�� ��������ϴ�.','I');
Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,7,'<LET.S> 2ȣ�� : ���� �� ���, �������� ��Ŵ���',to_timestamp('22/07/24 22:08:32.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-08-24 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-09-30 23:59:59','YYYY-MM-DD HH24:MI:SS'),500000,5,'�Ű��� <LET.S> 2ȣ�� - ���� �� ���, �������� ��Ŵ��� 
���ο� �мǿ� �̾� ������ ������ �ٷ�� �Ű��� ���� 2ȣ���� ������ ��Ŵ����Դϴ�.
�̹� 2ȣ���� 11������ �۾��Ⱓ ���ȿ� ����� ��õ�ϴ� �پ��� ������� �������. ����� �޽����� ������ �ٷ�� ������, ��� �귣��� ��� ���� ����� ���� �����, ��� � Ȱ����, �ϻ� �� ����� ��õ�ϴ� �츮 ���� �̿������. ���Ӱ��ɼ��� ��õ�ϱ� ���� ��ȭ�� �߱��ؿ� �����, �� ��ȭ�� �̷�� ���� ������� ��Ŵ����� ���� �����. �ڽŸ��� �پ��� ������� ����� ��õ�ϰ� ȫ���ϴ� ������� �������ϴ�. ���� �� ��ǿ����� �ϰ� ��Ȱ, 
���԰� ������ ���̿��� ������ ����ϰ� �ڽŸ��� ����� ������ ������� �̾߱⸦ ���� �پ��� �������� ������ �� �ֽ��ϴ�.','9876543210',to_date('2022-10-17 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661173712532_6e51abe6.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�� ���� �μ⹰�� ȭ��� ���̰� ���� �� �ֽ��ϴ�. �ִ��� �Ƹ��ٿ� ������ ���鵵�� ����ϰڽ��ϴ�.
�� ����/���� ���������� ������ ������ ���� ������ ���� �� �ֽ��ϴ�. ������ �����Ǵ� ��� �ż��ϰ� �����ϰڽ��ϴ�.','����','������','���Ӱ��ɼ��� ���� ������ ������ ������ �Ű��� �����Դϴ�.','I');
Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,2,'[���� ����]���� ��𼭵� ������ ������ ���ϴ� ��ſ���',to_timestamp('22/08/22 22:15:35.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-09-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-10-31 23:59:59','YYYY-MM-DD HH24:MI:SS'),500000,6,'������ ��߰�!
�ڽ� ȸ�翡�� PM���� �ٹ��ϸ�, �Һ��ڷμ��� ���� ���ߴ� �پ��� �������� ���̸� ���� �� �־����ϴ�. 1���� �Ѵ� ��ȭ���� �̵��ϴ� ��ħ �뵵�ε� ���Ǵ� ���̶��, ����� �߰��ϰ� ��� �Ŀ��� ��Ȱ��� �� �ִ� ������ ������ ���� ������ ª�� ������ ��ü ����� ����߽��ϴ�. ','3698521470',to_date('2022-11-14 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661174134992_759a2835.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','���� ������ ���� �߻����� ���� ������ ������ �� �ֽ��ϴ�.
���� �������� ���� �߻����� ���� ������ ������ �� �ֽ��ϴ�. ���� �߻� �� ��� �����ϸ� ��Ȳ�� �����ϵ��� �ϰڽ��ϴ�.','īī��','����','���������� 2013����� �ϻ��� ������ ���̷� ����� �ֽ��ϴ�.','B');
Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,5,'�����*��å���� �ݷ������� ������ �����ϰ� ��å�ؿ�!',to_timestamp('22/06/20 00:29:47.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-07-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-08-30 23:59:59','YYYY-MM-DD HH24:MI:SS'),200000,7,'ũ�ν��� �ް� ��å�̳� ���̵� �� ������ �߿� Ȱ���� �� ����� ������. ��� �� �� ��ġ�� �ٴڿ� ��� ���� �� �ִ� ������ ������ ��å�����̿���.
�򰳿����� �����*Ŀ���� ����� �ָ��ϰ� ���� ������ Ȱ���ߴ�ϴ�.�����*��ǰ�� �����Ⱑ �ϳ��� ������ �ʾƿ�.�����*��ǰ�� ȯ���� ���� �뷮������ ���� �������� �մϴ�.','3482156624',to_date('2022-12-12 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661182187429_3e1d6406.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','��ǰ �ϳ��� ���۾����� ����Ǵ� �ý������� ���� ������ ���� �� �����Ǵ� ��Ȳ�� �߻��� �� ������ �̸� ���� ��Ź�帳�ϴ�.','����','������','�����*�� ��ȭ�ǻ� �����̳ʷ� Ȱ���ؿ� â���ڰ� �����ϴ� ���Ӱ����� �������� �ǻ�Ȱ �귣���Դϴ�.','I');
Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,12,'���� ���ϰ� ��������, �Ĺ� ������ ���� [���� �Ĺ�ŰƮ]',to_timestamp('22/06/23 00:34:21.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-08-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-09-06 23:59:59','YYYY-MM-DD HH24:MI:SS'),500000,8,'������ �̿��� �����ϴ� ��������
�̸�ŭ �����ϰ� �Ű���� [������ �Ĺ�ŰƮ]�� �Ŀ��ںа� �Ĺ����� ù ������ �ִ��� ���������� �� �ֵ���, �غ� ������ ���� ���ŷο��� ���̰� ���Ǽ��� ���̱� ���� ������ �׽�Ʈ�� ����� ���� ������ �Ǿ����ϴ�.
','73002698412',to_date('2022-09-14 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661182461514_eca62d43.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�ε����ϰ� �Ұ��ص帰 �Ĺ� ������ ����� ���, ����� �����ǰų� ���� ������ ǰ������ �ٲ� �� �ִ� ���� �������ּ���.','īī��','�����','���� �Ĺ��� ä���ִ� �̱׷��� ����. �Բ� ���� �ذ�, ���� �� ���� ���� �����ο�.','I');
Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,6,'��Ŵ�� ���� �ݷ��߰� �Բ� ���� ���� <ģȯ�� ���Ϲ��>',to_timestamp('22/08/23 00:56:17.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-08-27 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-08-29 23:59:59','YYYY-MM-DD HH24:MI:SS'),300000,9,'��ǰ �����̳� 2���� ���� �����̳� ����ó���� ���� ���� ���̸� ����� ���� ��Ű���� ����Ͽ����ϴ�.
���Ϲ�带 ��ǥ�ϴ� �ɲ��� ����� �׷��� �Ϳ��� ��Ű���� �� �տ� �� ���� ũ��� �޴밡 �����ϸ�, ����Ҽ��� ���� �� �ε巯������ ������ ������ ��� ���� �մϴ�. �ո���� �����ؽ��� KC ��ũ���� ģȯ�� ������ ���� ��ǰ����, �ո� ������ �����Ͽ��� �����մϴ�','542109466152',to_date('2022-10-24 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661183777290_45dd5006.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload',null,'����','�뿩��','ģȯ�� ��� ��带 ����� �츮�� ���Ϲ���Դϴ�.','I');
Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,1,'��Ű�� ������ ���Ƴ���, ����&��Ʈ���� ��� ���̽�ũ��',to_timestamp('22/06/27 01:04:06.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-08-25 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-09-25 23:59:59','YYYY-MM-DD HH24:MI:SS'),500000,10,'��佺ũ���� �̹� ������ �귣�忹��. ���� 10��, ó������ 3���� ��(����/����/����)�� ��� ���̽�ũ���� ���������. ���ݱ��� ���� �ı� ������ 4.8��!?  ���� �е��� ����� �ǵ���� �������� �� �ε巯������, ���������� ���־��� ��佺ũ���� ���ο� ���� ����߾��!
��Űũ��ġ�� ��-�� �ֱ� ������ �� �����ϰ� �� Ư���ؿ�. ���ں�, ����Ĩ���� ���� ���� �־ �� ��Ǭ�� �Ծ �ٻ�ٻ��� �İ��� ���� ��ſ�����.','100264733698',to_date('2022-10-13 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661184246480_73d552be.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload',null,'����','���̰�','��� ���̽�ũ�� �귣�� <��佺ũ��>�� ��Ī�� Team Begin''s�Դϴ�. ��, �絹��, �ﷹ�� 3���� �� �̷��������� �系��ó�� ���ִ� ��� ���̽�ũ���� ����� �ֽ��ϴ�.','I');
Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,10,'�ΰ��� �Ǻθ� ���� ��� ȭ��ǰ "��"�ڱ� ��ũ��Ŭ �����',to_timestamp('22/05/20 01:07:59.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-06-19 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-07-29 23:59:59','YYYY-MM-DD HH24:MI:SS'),100000,11,'���������� ���� ������ �ݴ��ϰ���
''�䳢'' �׸��� ��� ȭ��ǰ ���� ���������� ���Ǳ� �����߽��ϴ�.Ŀ�������� �β��� �ö󰡴� ����ũ�� ���Ƿ��ʹ� �ٸ� ''���''�� ����� ���ο� ��ǰ, ''�����''�Դϴ�. ���� �Ǻ��� �� ���� �ڿ������� ����� ��� ������ ȭ������ ���Ѵٴ� �е鲲 ���ο� ���踦 �����帱
�̹� ��ɼ� ȭ��ǰ','666461398022',to_date('2022-10-22 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661184479849_5d285e88.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','������ ����� �� ���� �̷�����⿡, �ΰǺ� ���� �߻��� �� ������ ���� ���� �������� ������ ���� ���Դϴ�.','����','�ȿ�','"The vegan beauty to blossom yourself"
�ڽ��� �� �ǿ�� ����� �Ƹ��ٿ� �ΰ��� �Ǻθ� ���� ������ ��� ȭ��ǰ','F');
Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,9,'�ȳ� ���� �츮�� ������ ���� ȯ���̺�Ʈ <��������Ʈ> ��Ƽ',to_timestamp('22/07/10 01:12:26.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-07-21 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-08-21 23:59:59','YYYY-MM-DD HH24:MI:SS'),100000,12,'���� ����Ʈ�� ���� �̺�Ʈ�Դϴ�. �׸��� �� ��翡 �����ϴ� ��� ��ŸƮ���� ����, ��ü, �����õ��� ��� �ڿ� ����� �����ϰ� �ֽ��ϴ�. 
��� ������ ���ؼ� ��翡 �������ֽô� �е鲲 ������ ������ ����� ���� ����� ����� ������ �巯���� ���� ������ ��Ż, ��� ���α׷����� �����ϱ� ���� �ʿ��� ��ǰ�� �����ϱ� ���� ���, �׸��� ��縦 �˸��� ���� �������� �����ϱ� ���ؼ��� �����е��� �Ŀ��� �ʿ��մϴ�. 
��̰� ����ְ� ���ο� ������ȭ�� ���� ��������Ʈ ù ȸ�� ���� �������ּ���. ','245662878931',to_date('2022-08-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661184746185_e4ddc366.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload',null,'īī��','ǥ��ä','�ȳ��ϼ���! ��������Ʈ�� ��ȹ�ϰ� �ִ� ��ȹ�� �߿� �ϳ��� DE Studio�Դϴ�.','S');
Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,2,'�������� �翡 �ӹ��� ģȯ�� ��Ű�� ��� ����޷�',to_timestamp('22/06/21 01:17:33.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-08-10 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-08-26 23:59:59','YYYY-MM-DD HH24:MI:SS'),600000,13,'�������� ���� ������ ������ ��ǰ�� �������ϴ�.
���� ��� ���� Hard wood�� �̿��� ���۵˴ϴ�. �ܴ���, ��޽������� ���ÿ� ���� ȣ�γ���(walnut) ���� ��� ���� �������� ���� ������(oak) ����� ������ ������ ġ���ϰ� ������ ��ǳ����(maple) �� ������ ����Ͽ� �ð��� �������� �������� �ڿ����� ���� �ö�ɴϴ�.
ȣ�γ����� �̿��� ������, ���븦 �����Ͽ����ϴ�.','02564113269',to_date('2022-10-13 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661185053563_93037153.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�� ���� Ư���� �����ϴ� ��ǰ�� ���� ����, ���� �� ���̰� ���� �� �ֽ��ϴ�.
�� ���̴� ��ƿ� ������ �����Դϴ�. �ڿ� �״���� �������� �˷��帳�ϴ�.','�ϳ�','������','1umber = warmber �ڿ��� ������ ������ ���ϴ� ���귣�� �����Դϴ�.','I');
Insert into C##SEMI200.PROJECT (PROJECT_NO,CATEGORY_NO,NAME,REGISTER_DATE,START_DATE,END_DATE,GOAL,MAKER_NO,TEXT,ACCOUNT_NO,SHIPPING_DATE,THUMBNAIL_NAME,THUMBNAIL_PATH,ETC,ACCOUNT_BANK,ACCOUNT_NAME,MAKER_INFO,STATUS) 
values (SEQ_PROJECT_NO.NEXTVAL,2,'�̼��ö�ƽFREE! ���忡�� �� ��¥ õ��������',to_timestamp('22/07/20 01:21:17.000000000','RR/MM/DD HH24:MI:SSXFF'),to_date('2022-07-25 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2022-08-28 23:59:59','YYYY-MM-DD HH24:MI:SS'),200000,14,'�ڿ����� �ڿ�����, zero waste ������
õ�� �����̴� �ı���� �츮 �Ǻ� ���� �̼� �ö�ƽ ���ڸ� ������ ������, ȯ���� ������Ű�� �ʴ� 100% �ڿ����Դϴ�. �Ϻ� õ�� ������ ���Ǵ� �ռ� �� ������ �Ǵ� ȭ�� ȯ������ ��ü ������� �ʾ�, �� �����ϰ� �ǰ��� �������Դϴ�.','987542578648',to_date('2022-10-09 00:00:00','YYYY-MM-DD HH24:MI:SS'),'200_1661185277501_ab3eb39c.PNG','C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload',null,'����','�۶��','FROM FARM TO OUR LIFE. Ų���� ���� ģȯ�� ��縦 ���� �ѱ��� ���� �ʰ� ���� �۹��� ����ϸ�, ȭ�� ��� ���� õ�� �� ���� ��ǰ���� ��������Ÿ�� �귣�� <Ų��� ����>�� ������ �ֽ��ϴ�.','I');

COMMIT;



-------------------------
--������ ���̵�����
-------------------------

Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,1,'RAFL A','RAFL 5�� ���, �޴�� �ռ��� ��',54300,50);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,1,'RAFL B','RAFL 5�� ���, �޴�� �ռ��� ��, �����ݸ��ɸ� 1�ڽ�',86700,30);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,2,'only-Ebook','�̺� ������',10000,60);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,2,'�Ű��� 2ȣ�� A','�Ű��� 2ȣ�� �ܱ�, �Ŀ��� ��� ����, �⺻ ��ƼĿ��',23000,30);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,2,'�Ű��� 2ȣ�� B','�Ű��� 2ȣ�� �ܱ�, �Ŀ��� ��� ����, å���� 2��, ��� ���� ����, ����� ��ƼĿ��',40000,30);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,3,'2����!','���̽��� 2��',18000,50);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,3,'5����!','���̽��� 5��',39000,20);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,3,'10����!','���̽��� 10��',69000,10);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,4,'����� ŰƮ','����� ��å���� ����� ŰƮ  ������',45000,50);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,4,'��å���� P','����� ��å����  �� ���',89000,30);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,4,'��å���� B','����� ��å����  ������',89000,30);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,5,'[�󸮹���] S','S ������ ŰƮ �Ĺ�, �۶��� S������, ŰƮ�Ұ��� & ���� ���̵�',27000,10);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,5,'���� S','S ������ ŰƮ �Ĺ�, �۶��� S������, ŰƮ�Ұ��� & ���� ���̵�',29000,40);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,5,'Ŭ���� M','M ������ ŰƮ �Ĺ�, �۶��� M������, ŰƮ�Ұ��� & ���� ���̵�',35000,40);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,6,'�ո���','�ո��� set',14800,15);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,6,'�����','����� set',12800,15);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,6,'��� set','�ո��� set, ����� set',27600,20);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,6,'�ո��� 2','�ո��� set (x 2)',29600,5);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,7,'����Ʈ ����','����Ʈ ���� 3�� + ��Űũ��ġ',24900,600);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,7,'����Ʈ ��Ʈ','����Ʈ ��Ʈ 3�� + ��Űũ��ġ',24900,600);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,7,'��Ʈ�� ����','����Ʈ ���� 3�� + ��Ʈ 3�� + ��Űũ��ġ',39900,300);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,7,'[�󸮹���]','����Ʈ ���� 3�� + ��Űũ��ġ',22900,20);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,8,'�������2','��ī�պ������ x2',23800,30);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,8,'�������5','��ī�պ������ x5, ��ī�� Ǫ�縳�� x1',49000,30);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,9,'����A','�Ŀ��� ��� ����, ������ ���漼Ʈ',9000,15);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,9,'����B','�Ŀ��� ��� ����, ���� �����Ŀ�ġ',13000,30);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,9,'����C','�Ŀ��� ��� ����, ���� ū �Ŀ�ġ, ���� ������ ĵ����',20000,20);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,9,'����D','�Ŀ��� ��� ����, ������ ����',28000,15);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,9,'����E','�Ŀ��� ��� ����, ���� �����Ŀ�ġ, ���� ū �Ŀ�ġ',32000,50);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,10,'[�󸮹���]','��� ����޷� (��ü) - ��ǳ���� ( x 2 ) ��� ����޷� (��ü) - ������ ( x 2 ) ��� ����޷� (������) - ȣ�γ��� ( x 4 )',188000,10);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,10,'��ǳ����set','��� ����޷� (��ü) - ��ǳ���� ( x 1 )
��� ����޷� (������) - ȣ�γ��� ( x 1 )',61200,50);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,10,'��ǳ����set','��� ����޷� (��ü) - ��ǳ���� ( x 2 ) ��� ����޷� (������) - ȣ�γ��� ( x 2 )',108800,10);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,10,'������set','��� ����޷� (��ü) - ������ ( x 2 ) ��� ����޷� (������) - ȣ�γ��� ( x 2 )',108800,10);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,11,'�йи� set ','������ ��Ʈ x1 ���������� 2��',45000,35);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,11,'������ set','õ������ ������ 3��',10000,40);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,11,'�� ������ ','������ ���� 2��',16000,20);
Insert into C##SEMI200.REWARD (NO,PROJECT_NO,"OPTION",DETAIL,PRICE,QUANTITY) values (SEQ_REWARD_NO.NEXTVAL,11,'�� ������','������ ���� 3��',24000,20);

COMMIT;

SET DEFINE ON;

-------------------------
--������Ʈ ������ ���̵�����
-------------------------

Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,1,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','��1.PNG','200_1661173482906_9407f8af.PNG',to_timestamp('22/08/22 22:04:43.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,1,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','��2.PNG','200_1661173482913_eedc04fa.PNG',to_timestamp('22/08/22 22:04:43.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,1,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','��3.PNG','200_1661173482918_fd655a34.PNG',to_timestamp('22/08/22 22:04:43.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,2,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�������1.PNG','200_1661173712539_d08949aa.PNG',to_timestamp('22/08/22 22:08:32.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,2,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�������2.PNG','200_1661173712545_c1b15b82.PNG',to_timestamp('22/08/22 22:08:32.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,2,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�������3.PNG','200_1661173712550_daacec8d.PNG',to_timestamp('22/08/22 22:08:32.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,3,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','���̽���1.PNG','200_1661174134998_e9005fff.PNG',to_timestamp('22/08/22 22:15:35.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,3,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','���̽���2.PNG','200_1661174135004_eceb83c3.PNG',to_timestamp('22/08/22 22:15:35.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,3,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','���̽���3.PNG','200_1661174135009_f3d8c5d1.PNG',to_timestamp('22/08/22 22:15:35.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,5,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','����2.PNG','200_1661182461527_17bb35ea.PNG',to_timestamp('22/08/23 00:34:21.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,5,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','����3.PNG','200_1661182461533_1ada79db.PNG',to_timestamp('22/08/23 00:34:21.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,6,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','���1.PNG','200_1661183777298_a59b37e6.PNG',to_timestamp('22/08/23 00:56:17.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,6,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','���2.PNG','200_1661183777303_4e092f09.PNG',to_timestamp('22/08/23 00:56:17.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,6,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','���3.PNG','200_1661183777307_c3391b4c.PNG',to_timestamp('22/08/23 00:56:17.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,7,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','���̽�1.PNG','200_1661184246487_29c732b2.PNG',to_timestamp('22/08/23 01:04:06.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,7,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','���̽�2.PNG','200_1661184246494_74550535.PNG',to_timestamp('22/08/23 01:04:06.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,7,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','���̽�3.PNG','200_1661184246498_9868d045.PNG',to_timestamp('22/08/23 01:04:06.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,8,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�����1.PNG','200_1661184479856_15a0b05b.PNG',to_timestamp('22/08/23 01:07:59.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,4,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','����1.PNG','200_1661182187437_8a018233.PNG',to_timestamp('22/08/23 00:29:47.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,4,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','����2.PNG','200_1661182187443_a107ba30.PNG',to_timestamp('22/08/23 00:29:47.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,4,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','����3.PNG','200_1661182187450_f3507525.PNG',to_timestamp('22/08/23 00:29:47.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,5,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','����1.PNG','200_1661182461521_59b0090e.PNG',to_timestamp('22/08/23 00:34:21.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,8,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�����2.PNG','200_1661184479860_733f052f.PNG',to_timestamp('22/08/23 01:07:59.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,8,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�����3.PNG','200_1661184479867_0356cdb4.PNG',to_timestamp('22/08/23 01:07:59.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,9,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','����1.PNG','200_1661184746191_5fc0ac91.PNG',to_timestamp('22/08/23 01:12:26.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,9,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','����2.PNG','200_1661184746196_297ae17a.PNG',to_timestamp('22/08/23 01:12:26.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,10,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�޷�1.PNG','200_1661185053569_8bb8bc7d.PNG',to_timestamp('22/08/23 01:17:33.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,10,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�޷�2.PNG','200_1661185053573_5111dbc5.PNG',to_timestamp('22/08/23 01:17:33.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,10,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','�޷�3.PNG','200_1661185053578_d92eba29.PNG',to_timestamp('22/08/23 01:17:33.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,11,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','������1.PNG','200_1661185277507_97ae8e7a.PNG',to_timestamp('22/08/23 01:21:17.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,11,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','������2.PNG','200_1661185277513_ad3315c1.PNG',to_timestamp('22/08/23 01:21:17.000000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into C##SEMI200.DESCRIPTION_FILE (NO,PROJECT_NO,FILE_SRC,ORIGIN_NAME,CHANGE_NAME,UPLOAD_DATE) values (SEQ_DESCRIPTION_NO.NEXTVAL,11,'C:\dev\semiPrj200\semiPrj00\WebContent\resources\upload','������3.PNG','200_1661185277518_3fb05ec8.PNG',to_timestamp('22/08/23 01:21:17.000000000','RR/MM/DD HH24:MI:SSXFF'));

COMMIT;



-------------------------
--�Ŀ����� ���̵�����
-------------------------

INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,1,1,1,1,10000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,1,2,2,1,24000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,2,3,3,1,50000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,2,3,4,1,73000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY,ADDITIONAL)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,9,1,1,1,32000,2,2000);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY,ADDITIONAL)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,34,2,2,1,20000,1,5000);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY,ADDITIONAL)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,9,1,1,1,43000,3,1000);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY,ADDITIONAL)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,9,1,1,1,73000,2,2000);
    INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,6,1,1,1,30000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,2,2,2,1,24000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,5,3,4,1,50000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,8,3,3,1,73000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY,ADDITIONAL)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,11,1,1,1,16000,2,2000);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY,ADDITIONAL)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,9,2,2,1,24000,1,2000);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY,ADDITIONAL)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,12,1,1,1,62000,3,2000);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY,ADDITIONAL)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,14,2,2,1,73000,2,2000);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,22,2,2,1,24000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,19,3,3,1,50000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,28,2,2,1,73000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY,ADDITIONAL)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,30,1,1,1,16000,2,2000);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY,ADDITIONAL)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,14,2,2,1,73000,2,2000);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,15,2,2,1,24000,1);
INSERT INTO DONATE_LIST(NO,REWARD_NO,MEMBER_NO,PAYMENT_METHOD_NO,DELIVERY_ADDR_NO,AMOUNT,QUANTITY)
    VALUES(SEQ_DONATE_LIST_NO.NEXTVAL,18,3,4,1,50000,1);

COMMIT;

-------------------------
--������Ʈ_���ҽ� ���̵�����
-------------------------
INSERT INTO NEWS(NO,PROJECT_NO,MEMBER_NO,CONTENT)VALUES(SEQ_NEWS_NO.NEXTVAL,3,3,'7�� ���ο� ���� �Դϴ�!');
INSERT INTO NEWS(NO,PROJECT_NO,MEMBER_NO,CONTENT)VALUES(SEQ_NEWS_NO.NEXTVAL,3,3,'8�� �� ���� �Դϴ�!');

COMMIT;

-------------------------
--�Ű� ���̵�����
-------------------------
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,1,1,'�Ű�1');
Insert into C##SEMI200.REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT,SUBMIT_DATE,REPORT_AC) values (SEQ_REPORT_NO.nextval,3,3,'�ش� ������ ������ �������� ������ �̹� �Ǹŵǰ� �ֽ��ϴ�. ��� ��ǰ�� ���������� �𸣰ڽ��ϴٸ�, �ϴ� Ȯ���� ���ֽô� ���� �����Ͱ��� �ǰ߳���ϴ�. �����մϴ�.',to_timestamp('220823 015732.000000000','RRMMDD HH24MISSXFF'),'A');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,3,2,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,10,12,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,3,6,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,10,13,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,10,5,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,10,4,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,2,6,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,5,2,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,10,2,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,11,2,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,10,8,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,6,9,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,6,1,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,3,10,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,10,7,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,10,4,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,4,5,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,5,1,'�Ű� ���̵������Դϴ�. 11');
INSERT INTO REPORT (NO,PROJECT_NO,MEMBER_NO,CONTENT) VALUES (SEQ_REPORT_NO.nextval,2,4,'�Ű� ���̵������Դϴ�. 11');

COMMIT;

