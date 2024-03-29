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

---------------------
--좋아요
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
--쿠폰 테이블
---------------------------------------------------
DROP TABLE COUPON CASCADE CONSTRAINTS;

CREATE TABLE COUPON
(
    NO NUMBER PRIMARY KEY,
    MEM_NO NUMBER NOT NULL,
    NAME VARCHAR2(400) NOT NULL,
    DISCOUNT NUMBER NOT NULL
);

--회원번호 외래키 지정 (쿠폰)
ALTER TABLE COUPON ADD CONSTRAINT MEM_NO 
FOREIGN KEY(NO) REFERENCES MEMBER;

--쿠폰번호 시퀀스
DROP SEQUENCE SEQ_COUPON_NO;
CREATE SEQUENCE SEQ_COUPON_NO NOCACHE NOCYCLE;


------------------------
--결제수단 테이블
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

--결제수단 시퀀스
DROP SEQUENCE SEQ_PAYMENT_NO;
CREATE SEQUENCE SEQ_PAYMENT_NO NOCACHE NOCYCLE;

--회원번호 외래키
ALTER TABLE PAYMENT_CREDIT_CARD ADD CONSTRAINT PAYMENT_MEMBER_REF_NO 
FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(NO);


----------------------------
--배송지 TABLE
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

--회원 번호 외래키
ALTER TABLE DELIVERY_ADDRESS ADD CONSTRAINT ADDR_MEMBER_REF_NO 
FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(NO);

--NO 시퀀스
DROP SEQUENCE SEQ_ADDR_NO;
CREATE SEQUENCE SEQ_ADDR_NO NOCACHE NOCYCLE;

------------------------------------
--ADMIN
------------------------------------


--관리자 테이블 삭제
DROP TABLE ADMIN CASCADE CONSTRAINTS;

--관리자 테이블 생성
CREATE TABLE ADMIN (
    NO           NUMBER           PRIMARY KEY
    , ID         VARCHAR2(100)    NOT NULL    
    , PWD        VARCHAR2(100)    NOT NULL
    , NAME       VARCHAR2(15)     DEFAULT '관리자'
);

--시퀀스 삭제
DROP SEQUENCE SEQ_ADMIN_NO;

--시퀀스 생성
CREATE SEQUENCE SEQ_ADMIN_NO
NOCACHE NOCYCLE;

--관리자 더미데이터 생성
INSERT INTO ADMIN (NO,ID,PWD) VALUES (SEQ_ADMIN_NO.NEXTVAL, 'admin', '1234');

--커밋
COMMIT;





------------------------------------
--EVENT
------------------------------------

--이벤트 테이블 삭제
DROP TABLE EVENT CASCADE CONSTRAINTS;

--이벤트 테이블 생성
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

--시퀀스 삭제
DROP SEQUENCE SEQ_EVENT_NO;

--시퀀스 생성
CREATE SEQUENCE SEQ_EVENT_NO
NOCACHE NOCYCLE;

--이벤트 더미데이터 생성
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트1' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트2' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트3' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트4' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트5' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트6' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트7' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트8' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트9' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트10' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트11' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트12' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트13' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트14' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;
INSERT INTO EVENT (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME,START_DATE,END_DATE)VALUES (SEQ_EVENT_NO.NEXTVAL , 1 , '이벤트15' , '이벤트내용' , '경로' , '이름' , '2022-08-01' , '2022-09-01' ) ;


--커밋
COMMIT;



------------------------------------
--EVENT_FILE
------------------------------------

--이벤트 파일 테이블 삭제
DROP TABLE EVENT_FILE CASCADE CONSTRAINTS;

--이벤트 파일 테이블 생성
CREATE TABLE EVENT_FILE (
    NO              NUMBER          PRIMARY KEY
    , EVENT_NO       NUMBER          NOT NULL
    , PATH          VARCHAR2(1000)  NOT NULL
    , NAME          VARCHAR2(255)   NOT NULL
    , UPLOAD_DATE   TIMESTAMP       DEFAULT SYSDATE
    , DELETE_YN     CHAR(1)         DEFAULT 'N' CHECK(DELETE_YN IN('Y','N'))
)
;

--시퀀스 삭제
DROP SEQUENCE SEQ_EVENT_FILE_NO;

--시퀀스 생성
CREATE SEQUENCE SEQ_EVENT_FILE_NO
NOCACHE NOCYCLE;

--이벤트 파일 더미데이터 생성

--커밋
COMMIT;



------------------------------------
--NOTICE
------------------------------------

--공지사항 테이블 삭제
DROP TABLE NOTICE CASCADE CONSTRAINTS;

--공지사항 테이블 생성
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

--시퀀스 삭제
DROP SEQUENCE SEQ_NOTICE_NO;

--시퀀스 생성
CREATE SEQUENCE SEQ_NOTICE_NO
NOCACHE NOCYCLE;

--공지사항 더미데이터 생성
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항1' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항2' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항3' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항4' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항5' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항6' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항7' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항8' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항9' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항10' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항11' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항12' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항13' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항14' , '공지사항내용' , '경로' , '이름') ;
INSERT INTO NOTICE (NO,ADMIN_NO,TITLE,CONTENT,THUMBNAIL_PATH,THUMBNAIL_NAME)VALUES (SEQ_NOTICE_NO.NEXTVAL , 1 , '공지사항15' , '공지사항내용' , '경로' , '이름') ;

--커밋
COMMIT;




------------------------------------
--NOTCIE_FILE
------------------------------------

--공지사항 파일 테이블 삭제
DROP TABLE NOTICE_FILE CASCADE CONSTRAINTS;

--공지사항 파일 테이블 생성
CREATE TABLE NOTICE_FILE (
    NO              NUMBER          NOT NULL
    , NOTICE_NO       NUMBER          NOT NULL
    , PATH          VARCHAR2(1000)  NOT NULL
    , NAME          VARCHAR2(255)   NOT NULL
    , UPLOAD_DATE   TIMESTAMP       DEFAULT SYSDATE
    , DELETE_YN     CHAR(1)         DEFAULT 'N' CHECK(DELETE_YN IN('Y','N'))
)
;

--시퀀스 삭제
DROP SEQUENCE SEQ_NOTICE_FILE_NO;

--시퀀스 생성
CREATE SEQUENCE SEQ_NOTICE_FILE_NO
NOCACHE NOCYCLE;

--공지사항 파일 더미데이터 생성



--커밋
COMMIT;


----------------------------------------------------------
----------------------------------------------------------
--외래키 설정
-----------------------------------------------------------

--이벤트 외래키
ALTER TABLE EVENT
ADD CONSTRAINT EVENT_ADMIN_REF_NO 
FOREIGN KEY (ADMIN_NO) REFERENCES ADMIN;

--공지사항 외래키
ALTER TABLE NOTICE
ADD CONSTRAINT NOTICE_ADMIN_REF_NO 
FOREIGN KEY (ADMIN_NO) REFERENCES ADMIN;

--이벤트_파일 외래키
ALTER TABLE EVENT_FILE
ADD CONSTRAINT EVENT_FILE_EVENT_REF_NO 
FOREIGN KEY (EVENT_NO) REFERENCES EVENT;

--공지사항_파일 외래키
ALTER TABLE NOTICE_FILE
ADD CONSTRAINT NOTICE_FILE_NOTICE_REF_NO 
FOREIGN KEY (NOTICE_NO) REFERENCES NOTICE;

--커밋
COMMIT;





---------------------------------------------------
--PROJECT 프로젝트
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

--프로젝트 상태 코멘트
COMMENT ON COLUMN PROJECT.STATUS IS 'R=접수, N=반려, A=검토중, B=진행전, I=진행중, S=마감(성공), F=마감(실패) D=삭제';

--프로젝트 번호 시퀀스
DROP SEQUENCE SEQ_PROJECT_NO;
CREATE SEQUENCE SEQ_PROJECT_NO NOCACHE NOCYCLE;

---------------------------------------------------
--DESCRIPTION_FILE 프로젝트 상세페이지 첨부파일
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

--프로젝트 번호 외래키 지정 (파일)
ALTER TABLE DESCRIPTION_FILE ADD CONSTRAINT ATT_PROJECT_REF_NO 
FOREIGN KEY(PROJECT_NO) REFERENCES PROJECT;

--첨부파일 번호 시퀀스
DROP SEQUENCE SEQ_DESCRIPTION_NO;
CREATE SEQUENCE SEQ_DESCRIPTION_NO NOCACHE NOCYCLE;


---------------------------------------------------
--REWARD 리워드
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

--프로젝트 번호 외래키 지정 (리워드)
ALTER TABLE REWARD ADD CONSTRAINT REWARD_PROJECT_REF_NO 
FOREIGN KEY(PROJECT_NO) REFERENCES PROJECT;

--첨부파일 번호 시퀀스
DROP SEQUENCE SEQ_REWARD_NO;
CREATE SEQUENCE SEQ_REWARD_NO NOCACHE NOCYCLE;

---------------------------------------------------
--CATEGORY 카테고리
---------------------------------------------------

DROP TABLE CATEGORY CASCADE CONSTRAINTS;

CREATE TABLE CATEGORY
(
    CATEGORY_NO NUMBER PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL
);

--카테고리 번호 시퀀스
DROP SEQUENCE SEQ_CATEGORY_NO;
CREATE SEQUENCE SEQ_CATEGORY_NO NOCACHE NOCYCLE;

--카테고리 번호 외래키 지정 (프로젝트)
ALTER TABLE "PROJECT" ADD CONSTRAINT PROJECT_CATEGORY_REF_NO 
FOREIGN KEY(CATEGORY_NO) REFERENCES CATEGORY;

--카테고리 INSERT
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(1, '푸드');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(2, '홈, 리빙');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(3, '모빌리티');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(4, '테크, 가전');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(5, '패션, 잡화');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(6, '반려동물');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(7, '도서, 출판');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(8, '여행, 레저');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(9, '클래스');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(10, '뷰티');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(11, '스포츠');
INSERT INTO CATEGORY(CATEGORY_NO , NAME) VALUES(12, '식테크');

COMMIT;




---------------------------------------
--DONATE_LIST 후원내역 테이블
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

--시퀀스
DROP SEQUENCE SEQ_DONATE_LIST_NO;
CREATE SEQUENCE SEQ_DONATE_LIST_NO NOCACHE NOCYCLE;

--제약조건
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_REWARD_NO FOREIGN KEY(REWARD_NO) REFERENCES REWARD(NO);
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(NO);
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_PAYMENT_METHOD_NO FOREIGN KEY(PAYMENT_METHOD_NO) REFERENCES PAYMENT_CREDIT_CARD(NO);
ALTER TABLE DONATE_LIST
ADD CONSTRAINT DONATE_LIST_DELIVERY_ADDR_NO FOREIGN KEY(DELIVERY_ADDR_NO) REFERENCES DELIVERY_ADDRESS(NO);


---------------------------------
--REPORT(신고)
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
--NEWS 프로젝트 새소식 테이블
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