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

---------------------
--���ƿ�
---------------------
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
ADD CONSTRAINT LIKE_NO_PROJECT_NO FOREIGN KEY(PROJECT_NO) REFERENCES PROJECT(NO);

DROP SEQUENCE SEQ_PROJECT_LIKE_NO;
CREATE SEQUENCE SEQ_PROJECT_LIKE_NO NOCACHE NOCYCLE;





---------------------------------------------------
--���� ���̺�
---------------------------------------------------
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


------------------------
--�������� ���̺�
------------------------

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

------------------------------------
--ADMIN
------------------------------------


--������ ���̺� ����
DROP TABLE ADMIN CASCADE CONSTRAINTS;

--������ ���̺� ����
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

--������ ���̵����� ����
INSERT INTO ADMIN (NO,ID,PWD) VALUES (SEQ_ADMIN_NO.NEXTVAL, 'admin', '1234');

--Ŀ��
COMMIT;





------------------------------------
--EVENT
------------------------------------

--�̺�Ʈ ���̺� ����
DROP TABLE EVENT CASCADE CONSTRAINTS;

--�̺�Ʈ ���̺� ����
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
)
;

--������ ����
DROP SEQUENCE SEQ_EVENT_NO;

--������ ����
CREATE SEQUENCE SEQ_EVENT_NO
NOCACHE NOCYCLE;

--�̺�Ʈ ���̵����� ����
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ1' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ2' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ3' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ4' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ5' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ6' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ7' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ8' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ9' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ10' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ11' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ12' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ13' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ14' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '�̺�Ʈ15' , '�̺�Ʈ����' , '���' , '�̸�' , '2022-08-01' , '2022-09-01' ) ;


--Ŀ��
COMMIT;



------------------------------------
--EVENT_FILE
------------------------------------

--�̺�Ʈ ���� ���̺� ����
DROP TABLE EVENT_FILE CASCADE CONSTRAINTS;

--�̺�Ʈ ���� ���̺� ����
CREATE TABLE EVENT_FILE (
    NO              NUMBER          PRIMARY KEY
    , EVENT_NO       NUMBER          NOT NULL
    , PATH          VARCHAR2(1000)  NOT NULL
    , NAME          VARCHAR2(255)   NOT NULL
    , UPLOAD_DATE   TIMESTAMP       DEFAULT SYSDATE
    , DELETE_YN     CHAR(1)         DEFAULT 'N' CHECK(DELETE_YN IN('Y','N'))
)
;

--������ ����
DROP SEQUENCE SEQ_EVENT_FILE_NO;

--������ ����
CREATE SEQUENCE SEQ_EVENT_FILE_NO
NOCACHE NOCYCLE;

--�̺�Ʈ ���� ���̵����� ����

--Ŀ��
COMMIT;



------------------------------------
--NOTICE
------------------------------------

--�������� ���̺� ����
DROP TABLE NOTICE CASCADE CONSTRAINTS;

--�������� ���̺� ����
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
)
;

--������ ����
DROP SEQUENCE SEQ_NOTICE_NO;

--������ ����
CREATE SEQUENCE SEQ_NOTICE_NO
NOCACHE NOCYCLE;

--�������� ���̵����� ����
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������1' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������2' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������3' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������4' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������5' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������6' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������7' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������8' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������9' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������10' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������11' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������12' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������13' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������14' , '�������׳���' , '���' , '�̸�') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '��������15' , '�������׳���' , '���' , '�̸�') ;

--Ŀ��
COMMIT;




------------------------------------
--NOTCIE_FILE
------------------------------------

--�������� ���� ���̺� ����
DROP TABLE NOTICE_FILE CASCADE CONSTRAINTS;

--�������� ���� ���̺� ����
CREATE TABLE NOTICE_FILE (
    NO              NUMBER          NOT NULL
    , NOTICE_NO       NUMBER          NOT NULL
    , PATH          VARCHAR2(1000)  NOT NULL
    , NAME          VARCHAR2(255)   NOT NULL
    , UPLOAD_DATE   TIMESTAMP       DEFAULT SYSDATE
    , DELETE_YN     CHAR(1)         DEFAULT 'N' CHECK(DELETE_YN IN('Y','N'))
)
;

--������ ����
DROP SEQUENCE SEQ_NOTICE_FILE_NO;

--������ ����
CREATE SEQUENCE SEQ_NOTICE_FILE_NO
NOCACHE NOCYCLE;

--�������� ���� ���̵����� ����



--Ŀ��
COMMIT;


----------------------------------------------------------
----------------------------------------------------------
--�ܷ�Ű ����
-----------------------------------------------------------

--�̺�Ʈ �ܷ�Ű
ALTER TABLE EVENT
ADD CONSTRAINT EVENT_ADMIN_REF_NO 
FOREIGN KEY (ADMIN_NO) REFERENCES ADMIN;

--�������� �ܷ�Ű
ALTER TABLE NOTICE
ADD CONSTRAINT NOTICE_ADMIN_REF_NO 
FOREIGN KEY (ADMIN_NO) REFERENCES ADMIN;

--�̺�Ʈ_���� �ܷ�Ű
ALTER TABLE EVENT_FILE
ADD CONSTRAINT EVENT_FILE_EVENT_REF_NO 
FOREIGN KEY (EVENT_NO) REFERENCES EVENT;

--��������_���� �ܷ�Ű
ALTER TABLE NOTICE_FILE
ADD CONSTRAINT NOTICE_FILE_NOTICE_REF_NO 
FOREIGN KEY (NOTICE_NO) REFERENCES NOTICE;

--Ŀ��
COMMIT;





---------------------------------------------------
--PROJECT ������Ʈ
---------------------------------------------------

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

--������Ʈ ���� �ڸ�Ʈ
COMMENT ON COLUMN PROJECT.STATUS IS 'R=����, N=�ݷ�, A=������, B=������, I=������, S=����(����), F=����(����) D=����';

--������Ʈ ��ȣ ������
DROP SEQUENCE SEQ_PROJECT_NO;
CREATE SEQUENCE SEQ_PROJECT_NO NOCACHE NOCYCLE;

---------------------------------------------------
--DESCRIPTION_FILE ������Ʈ �������� ÷������
---------------------------------------------------

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

--������Ʈ ��ȣ �ܷ�Ű ���� (����)
ALTER TABLE DESCRIPTION_FILE ADD CONSTRAINT ATT_PROJECT_REF_NO 
FOREIGN KEY(PROJECT_NO) REFERENCES PROJECT;

--÷������ ��ȣ ������
DROP SEQUENCE SEQ_DESCRIPTION_NO;
CREATE SEQUENCE SEQ_DESCRIPTION_NO NOCACHE NOCYCLE;


---------------------------------------------------
--REWARD ������
---------------------------------------------------

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

--������Ʈ ��ȣ �ܷ�Ű ���� (������)
ALTER TABLE REWARD ADD CONSTRAINT REWARD_PROJECT_REF_NO 
FOREIGN KEY(PROJECT_NO) REFERENCES PROJECT;

--÷������ ��ȣ ������
DROP SEQUENCE SEQ_REWARD_NO;
CREATE SEQUENCE SEQ_REWARD_NO NOCACHE NOCYCLE;

---------------------------------------------------
--CATEGORY ī�װ���
---------------------------------------------------

DROP TABLE CATEGORY CASCADE CONSTRAINTS;

CREATE TABLE CATEGORY
(
    CATEGORY_NO NUMBER PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL
);

--ī�װ��� ��ȣ ������
DROP SEQUENCE SEQ_CATEGORY_NO;
CREATE SEQUENCE SEQ_CATEGORY_NO NOCACHE NOCYCLE;

--ī�װ��� ��ȣ �ܷ�Ű ���� (������Ʈ)
ALTER TABLE "PROJECT" ADD CONSTRAINT PROJECT_CATEGORY_REF_NO 
FOREIGN KEY(CATEGORY_NO) REFERENCES CATEGORY;

--ī�װ��� INSERT
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




---------------------------------------
--DONATE_LIST �Ŀ����� ���̺�
---------------------------------------
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

--������
DROP SEQUENCE SEQ_DONATE_LIST_NO;
CREATE SEQUENCE SEQ_DONATE_LIST_NO NOCACHE NOCYCLE;

--��������
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_REWARD_NO FOREIGN KEY(REWARD_NO) REFERENCES REWARD(NO);
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(NO);
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_PAYMENT_METHOD_NO FOREIGN KEY(PAYMENT_METHOD_NO) REFERENCES PAYMENT_CREDIT_CARD(NO);
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_DELIVERY_ADDR_NO FOREIGN KEY(DELIVERY_ADDR_NO) REFERENCES DELIVERY_ADDRESS(NO);


---------------------------------
--REPORT(�Ű�)
--------------------------------

DROP TABLE REPORT CASCADE CONSTRAINTS;

CREATE TABLE REPORT (
    NO              NUMBER          PRIMARY KEY
    , PROJECT_NO    NUMBER          NOT NULL
    , MEMBER_NO     NUMBER          NOT NULL
    , CONTENT       VARCHAR2(1000)  NOT NULL
    , SUBMIT_DATE          TIMESTAMP       DEFAULT SYSDATE
    , REPORT_AC     CHAR(1)         DEFAULT 'A' CHECK(REPORT_AC IN('A','C'))
)
;

DROP SEQUENCE SEQ_REPORT_NO;
CREATE SEQUENCE SEQ_REPORT_NO NOCACHE NOCYCLE;

ALTER TABLE "REPORT" ADD CONSTRAINT PROJECT_REPORT_REF_NO
FOREIGN KEY (PROJECT_NO) REFERENCES "PROJECT";

ALTER TABLE "REPORT" ADD CONSTRAINT MEMBER_REPORT_REF_NO
FOREIGN KEY (MEMBER_NO) REFERENCES "MEMBER";


commit;

---------------------------------------
--NEWS ������Ʈ ���ҽ� ���̺�
---------------------------------------
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

COMMIT;