-- DDL

-- ���̺� ����(�� ���̺� ������ ����...)
-- Į���� ������ ���� ��, �ֵ���ǥ�� �����ָ� ��� ����
-- ���� Į�������� ����ϰ� ������, �ֵ���ǥ�� ó�� ����
CREATE TABLE KH_MEMBER(
      NAME VARCHAR2(10)
    , AGE NUMBER
);

-- ���̺� Į�� �߰�(DDL)
ALTER TABLE KH_MEMBER ADD EMAIL VARCHAR2(100);

-- ���̺� Į�� ����
ALTER TABLE KH_MEMBER DROP COLUMN EMAIL;

-- Į�� �����ϱ�
-- ���ǿ� ���� �ʴ� �����Ͱ� �̹� ����ִٸ�, ���� �Ұ�
ALTER TABLE KH_MEMBER MODIFY NAME VARCHAR2(100);
ALTER TABLE KH_MEMBER MODIFY NAME NUMBER;

--������ �־��
INSERT INTO KH_MEMBER (NAME, AGE)
VALUES('�ɿ���', 20);
COMMIT;

-- ���̺� �����ϱ�
DROP TABLE KH_MEMBER;

SELECT * FROM KH_MEMBER;


