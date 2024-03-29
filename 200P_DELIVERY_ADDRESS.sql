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


-------------------------
--DUMMY DATA
-------------------------
INSERT INTO DELIVERY_ADDRESS(NO,MEMBER_NO,POST_NUM,ADDR1,ADDR2,NAME,PHONE,DEFAULT_YN)VALUES(SEQ_ADDR_NO.NEXTVAL,1,12345,'서울 강남구','테헤란로 1길 역삼역?','심원용','01012341234','Y');
INSERT INTO DELIVERY_ADDRESS(NO,MEMBER_NO,POST_NUM,ADDR1,ADDR2,NAME,PHONE,DEFAULT_YN)VALUES(SEQ_ADDR_NO.NEXTVAL,1,12242,'서울 강남구','테헤란로 2길 강남역?','심투용','01012341234','N');
INSERT INTO DELIVERY_ADDRESS(NO,MEMBER_NO,POST_NUM,ADDR1,ADDR2,NAME,PHONE,DEFAULT_YN)VALUES(SEQ_ADDR_NO.NEXTVAL,1,13342,'서울 강남구','테헤란로 3길 신논현역?','심삼용','01045661234','N');
COMMIT;


--------------------------
--TEST
--------------------------
INSERT INTO DELIVERY_ADDRESS
(
    NO
    ,MEMBER_NO
    ,POST_NUM
    ,ADDR1
    ,ADDR2
    ,NAME
    ,PHONE
    ,DEFAULT_YN
)
VALUES
(
    SEQ_ADDR_NO.NEXTVAL
    ,?
    ,?
    ,?
    ,?
    ,?
    ,?
    ,?
)
;

SELECT * FROM DELIVERY_ADDRESS;

UPDATE DELIVERY_ADDRESS
SET
DEFAULT_YN = 'N'
WHERE MEMBER_NO = ?
AND DEFAULT_YN = 'Y'
;

ROLLBACK;

SELECT * FROM DELIVERY_ADDRESS WHERE MEMBER_NO = 1 ORDER BY DEFAULT_YN DESC
;