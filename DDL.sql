-- DDL (���̺� ����)

/*
    [����]
    CREATE TABLE ���̺��(
        Į���� Į��Ÿ��,
        Į���� Į��Ÿ��,
        Į���� Į��Ÿ��,
    );
*/

--���̺� ����
CREATE TABLE MEMBER(
      NO          NUMBER
    , ID          VARCHAR2(30)
    , PWD         VARCHAR2(100)
    , PHONE       CHAR(13)
    , ENROLL_DATE TIMESTAMP
);

-- ������ ��ȸ
SELECT * FROM MEMBER;

-- ������ �ֱ�
INSERT INTO MEMBER
VALUES (1, 'SWY', '1234', '010-1234-5678', SYSDATE);

--������ ����

-- ������ ����