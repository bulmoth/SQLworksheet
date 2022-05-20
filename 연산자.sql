-- DML (SELECT), ������

-- ������ ������ ���̺� ���� (���� ����)
CREATE TABLE TEMP_TB(
      NAME VARCHAR2(100)
    , AGE NUMBER
);

INSERT INTO TEMP_TB(NAME, AGE) VALUES('4G', 26);
INSERT INTO TEMP_TB(NAME, AGE) VALUES('3A', 25);
INSERT INTO TEMP_TB(NAME, AGE) VALUES('2B', 20);
--COMMIT;

-- ��ȸ
SELECT * FROM TEMP_TB;

-- ���� ���ϱ� +
SELECT NAME �̸�, AGE+1 ���⳪�� FROM TEMP_TB;


SELECT NAME, AGE, 1234 �����߰� FROM TEMP_TB;
SELECT NAME, AGE, '9S' ������ FROM TEMP_TB;
SELECT NAME, AGE, '9S' AS ��������Į�� FROM TEMP_TB;
SELECT NAME, AGE, '9S' AS "���� ���� Į��" FROM TEMP_TB;
SELECT NAME, AGE, '9S' ��������Į�� FROM TEMP_TB;
SELECT NAME, AGE, AGE ��������Į�� FROM TEMP_TB;
SELECT NAME, AGE, AGE+3 ����Į�� FROM TEMP_TB;

-- ���ڿ� ���ϱ� ||
SELECT NAME, AGE FROM TEMP_TB;
SELECT NAME, AGE, NAME ��������Į�� FROM TEMP_TB;
SELECT NAME, AGE, NAME+1 ��������Į�� FROM TEMP_TB; -- ����
SELECT NAME, AGE, 1+1 ��������Į�� FROM TEMP_TB;
SELECT NAME, AGE, 1+'1' ��������Į�� FROM TEMP_TB; -- ����+���� => ����
SELECT NAME, AGE, 1||'1' ��������Į�� FROM TEMP_TB; -- ����||���� => ����
SELECT NAME, AGE, 7 ��������Į�� FROM TEMP_TB; -- ���ڴ� ������ ����
SELECT NAME, AGE, '7' ��������Į�� FROM TEMP_TB; -- ���ڴ� ���� ����
SELECT NAME, AGE, NAME+'9S' ��������Į�� FROM TEMP_TB; -- ����
SELECT NAME, AGE, NAME||' YORHA' ��������Į�� FROM TEMP_TB; -- ���ڿ� ���ϱ� ������
SELECT NAME, AGE, CONCAT(NAME,' YORHA') ��������Į�� FROM TEMP_TB; -- CONCAT() �Լ� ���

SELECT NAME||'('||AGE||')' "�̸�(����)" FROM TEMP_TB; 

SELECT SYSDATE FROM TEMP_TB;

SELECT 123+1 FROM DUAL;

-- ������
/*
    = : ����
    !=, ^=, <> : ���� �ʴ�
    >, <, >=, <= : ��� ��
    IS NULL : NULL ���� Ȯ��
    IS NOT NULL : NULL�� �ƴ��� Ȯ��
    
    NOT : ����������
    AND : �׸���(== �ڹ��� &&)
    OR : �Ǵ�(== �ڹ��� ||)
    BETWEEN A AND B : A�� B ���� ���� Ȯ��
    IN, NOT IN : ���� �Ǵ��� Ȯ��
    
    LIKE, NOT LIKE : ���ڿ� ��
    % : 0�� �̻��� ���ڿ�
    _ : �ѱ���
*/

SELECT * FROM TEMP_TB;

SELECT NAME, AGE FROM TEMP_TB; -- ��� �� ���

-- ���̰� 20�� ROW�� ���
SELECT NAME, AGE 
FROM TEMP_TB 
WHERE AGE=20; 

-- ���̰� 20�� �ƴ� ROW�� ���
SELECT NAME, AGE 
FROM TEMP_TB 
WHERE AGE!=20
--WHERE AGE^=20
--WHERE AGE<>20
;

-- ���̰� 20 �ʰ��� ROW ���
SELECT NAME, AGE
FROM TEMP_TB
WHERE AGE>20
;

-- AGE�� NULL�� ������ �ֱ�
--INSERT INTO TEMP_TB(NAME, AGE) VALUES('9S', NULL);
INSERT INTO TEMP_TB(NAME) VALUES('9S');
--ROLLBACK;
SELECT * FROM TEMP_TB;
--COMMIT;

-- AGE Į���� ���� NULL�� ROW�� ���
SELECT NAME, AGE
FROM TEMP_TB
--WHERE AGE IS NULL
WHERE AGE IS NOT NULL
;

-- AGE�� 19 �ʰ� �̸鼭 21 ���ϴ� ROW ���
SELECT NAME, AGE
FROM TEMP_TB
WHERE AGE > 10
AND AGE <= 21
;

-- AGE�� 20 ���� �̰ų�, 22 �̻��� ROW ���
SELECT NAME, AGE
FROM TEMP_TB
WHERE AGE <= 20
OR AGE >= 22
;

-- AGE�� 21~22 ���̿� �ش��ϴ� ROW ���
SELECT NAME, AGE
FROM TEMP_TB
WHERE AGE BETWEEN 25 AND 26
;

-- NAME �� '4G' �Ǵ� '3A' �Ǵ� '2B' �Ǵ� '9S' �� ROW ���
SELECT NAME, AGE
FROM TEMP_TB
--WHERE NAME IN('4G', '3A', '2B', '9S')
WHERE NAME NOT IN('2B', '9S')
;

-- �̸��� 4�� �����ϴ� ROW ���
SELECT NAME, AGE
FROM TEMP_TB
WHERE NAME LIKE '%A%'
--WHERE NAME NOT LIKE '%A%'
;

--�̸��� '��'���� �����ϴ�(3���� �̸��� ����) ROW ���
SELECT NAME, AGE
FROM TEMP_TB
WHERE NAME LIKE '��__'
--WHERE NAME NOT LIKE '��__'
;



-- ������ �ֱ�
INSERT INTO TEMP_TB(NAME) VALUES('EVE');
INSERT INTO TEMP_TB(NAME) VALUES('ADAM');
INSERT INTO TEMP_TB(NAME) VALUES('DU');
INSERT INTO TEMP_TB(NAME) VALUES('GRAHA');
INSERT INTO TEMP_TB(NAME) VALUES('HUI');
INSERT INTO TEMP_TB(NAME) VALUES('EMET');
INSERT INTO TEMP_TB(NAME) VALUES('ȫ�浿');
INSERT INTO TEMP_TB(NAME) VALUES('ȫ��ȯ');
INSERT INTO TEMP_TB(NAME) VALUES('������');
INSERT INTO TEMP_TB(NAME) VALUES('��ö��');
INSERT INTO TEMP_TB(NAME) VALUES('����ѹ��ź��̿͵η�̻�õ���ڵ����');
--COMMIT;

-- ������ ���̺� ����
-- DROP TABLE TEMP_TB;
