--ROWNUM

--���̺��.�÷��� (���̺�� ���� ����)
SELECT E.EMPNO, E.ENAME
FROM EMP E
;

--ROWNUM : ��(==ROW ==RECORD) ��ȣ�� �ٿ���
SELECT ROWNUM AS RNUM, E.*
FROM EMP E
WHERE ROWNUM <10
;