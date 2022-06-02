--������

--����
DROP SEQUENCE MEMBER_NO_SEQ;
CREATE SEQUENCE MEMBER_NO_SEQ
INCREMENT BY 1  --�����ϴ� �� ���� ����(������ ����)
 START WITH 1    --���۰�
MINVALUE 1  --�ּҰ�
MAXVALUE 999 --�ִ밪
NOCYCLE --||CYCLE --��ȯ ����(�ִ밪���� �ٽ� �ּҰ����� �ð�����)
NOCACHE --ĳ�� ����(������) 
;

--ĳ�� : �����͸� �ӽ÷�(�̸�) �ۿ��� ��(�������� �Ϻθ�)

--���
SELECT MEMBER_NO_SEQ.NEXTVAL
FROM DUAL;  --�ϳ� �ö� ��

SELECT MEMBER_NO_SEQ.CURRVAL
FROM DUAL;  --���簪

--����
ALTER SEQUENCE MEMBER_NO_SEQ
INCREMENT BY 2
MINVALUE -1
MAXVALUE 123
CYCLE
CACHE 100
;