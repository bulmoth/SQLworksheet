-- ���� ���� ����
ALTER USER C##KH DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

--���� ����
--CREATE USER ���̵� IDENTIFIED BY �н�����
CREATE USER "C##KH" IDENTIFIED BY "KH";

--������ ���� �ο�
--GRANT ����1, ����2, ... TO ������;
GRANT CONNECT, RESOURCE TO C##KH;


--���� �ּ�
/*
������ �ּ�~
*/
--SQL�� �빮�ڷ� �ۼ�
--���̺� ����
CREATE TABLE MEMBER(
    ID VARCHAR2(30),
    PWD VARCHAR2(100)
);

--���̺� ��ȸ(READ)
SELECT * FROM MEMBER;

--������ �ֱ�(CREATE)
INSERT INTO MEMBER(ID, PWD) VALUES('SWY','1234');

--������ ����(UPDATE)
UPDATE MEMBER SET PWD = '4321';

--������ ����(DELETE)
DELETE MEMBER;

--���̺� ����
DROP TABLE MEMBER;

