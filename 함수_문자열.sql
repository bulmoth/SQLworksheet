--�Լ� (���ڿ�)

--SUBSTR(���ڿ�, ���� ��ġ, ����)
SELECT SUBSTR('ABCDEFGHIJK', 3, 50)
FROM DUAL;

SELECT *
FROM EMP
WHERE ENAME LIKE '%' || SUBSTR('ABCDEFGHIJK', 5, 1) || '%'
--WHERE ENAME LIKE '%E%'
;

--CONCAT : ���ڿ� ��ġ�� ���
--SELECT 'ABC' || '�ɿ���'
SELECT CONCAT('ABC', '�ɿ���')
FROM DUAL
;

--TRIM : ���� ���� ���� 
--LTRIM : ���� ���� ����
--RTIRM : ������ ���� ����
SELECT '   ABC   '
FROM DUAL
;

SELECT TRIM('   ABC   ')
FROM DUAL
;

--LOWER : �ҹ��ڷ� ����
--UPPER : �빮�ڷ� ����
SELECT LOWER('ABC')
FROM DUAL
;

--REPLACE
SELECT REPLACE ('ABC', 'B', 'X')
FROM DUAL
;

--PAD : ���ڿ��� Ư�� ���̸�ŭ ä����
--LPAD
--RPAD
SELECT LPAD('ABC',10, '#') AS T
FROM DUAL
;

--INITCAP : ù���ڸ� �빮�ڷ� �ٲ���
SELECT INITCAP('abc')
FROM DUAL
;

--INSTR : Ư�� ���ڿ��� ���° ���ں��� �����ϴ��� Ȯ��
SELECT INSTR('ABCDEFGKH12345KH12345', 'CD', 5, 2)
FROM DUAL
;

--LENGTH : ���ڿ� ���� Ȯ��
SELECT LENGTH('ABC123ZZZ�ȳ�')
FROM DUAL
;