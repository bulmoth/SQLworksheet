--Ʈ�����

/*
    �ɰ� �� ���� ���� ó���� �ּ� ����
    EX) ������ü : �� ������ ���� �ٸ� �������� �ű�� ��...
    1. ��ü�� �ݾ� Ȯ��
    2. �� ���� �ܰ� Ȯ��
    3. �� ���� �ݾ� ����
    4. ���� ���� �ܰ� ����
    
*/

--Ŀ��, �ѹ�

--Ʈ������ �׽�Ʈ�� ���� �ӽ� ���̺� ����    //����(DROP)�Ұ���
CREATE TABLE MY_TB(
      NAME CHAR(9)
    , AGE NUMBER
);

INSERT INTO MY_TB(NAME, AGE)
VALUES('ABC', 20);
COMMIT;

INSERT INTO MY_TB
VALUES('ZZZ', 22);
ROLLBACK;

SELECT * FROM MY_TB;

DROP TABLE MY_TB;   --DDL����






