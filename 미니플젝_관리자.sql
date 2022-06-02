-------------------
--관리자 계정
-------------------

DROP TABLE ADMIN;

CREATE TABLE ADMIN(
      ADM_NO NUMBER PRIMARY KEY
    , ADM_ID VARCHAR2(100) NOT NULL UNIQUE
    , ADM_PWD VARCHAR2(100) NOT NULL
);

CREATE SEQUENCE ADM_NO_SEQ
NOCACHE
NOCYCLE
;

INSERT INTO ADMIN(ADM_NO, ADM_ID, ADM_PWD) VALUES(ADM_NO_SEQ.NEXTVAL, 'ADMIN1', '1234');
INSERT INTO ADMIN(ADM_NO, ADM_ID, ADM_PWD) VALUES(ADM_NO_SEQ.NEXTVAL, 'ADMIN2', '1234');
COMMIT;