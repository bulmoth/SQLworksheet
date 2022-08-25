INSERT INTO PROJECT
(
    PROJECT_NO
    ,CATEGORY_NO
    ,NAME
    ,START_DATE
    ,END_DATE
    ,GOAL
    ,MAKER_NO
    ,TEXT
    ,ACCOUNT_NO
    ,SHIPPING_DATE
    ,THUMBNAIL_NAME
    ,THUMBNAIL_PATH
    ,ETC
    ,ACCOUNT_BANK
    ,ACCOUNT_NAME
    ,MAKER_INFO
    ,STATUS
)
VALUES
(
    SEQ_PROJECT_NO.NEXTVAL,
    1,
    '생분해 필터를 이용한 하수구 거름망',
    '2022-08-22',
    '2022-08-30',
    1000000,
    1,
    '냄새걱정 끝, 환경걱정 끝, 환경과 냄새 동시에 모두 잡는 생분해 필터 거름망입니다',
    333312341234,
    '2022-10-15',
    '필터사진',
    '/semiPrj00/resources/img/200perlogo_.png',
    '돈이 안모이면 어떡하지...',
    '카카오뱅크',
    '메이커1',
    '이탈리아 필터명장'
    ,'I'
)
;
COMMIT;



---------------------------
--TEST
---------------------------

SELECT T.*
FROM (
    SELECT ROWNUM RNUM, P.*, C.NAME CATEGORY_NAME, M.NICK NICK
    FROM PROJECT P
    JOIN CATEGORY C
    ON P.CATEGORY_NO = C.CATEGORY_NO
    JOIN MEMBER M
    ON P.MAKER_NO = M.NO
    WHERE P.CATEGORY_NO = 1
    AND P.STATUS = 'I'
    ORDER BY P.END_DATE ASC
) T
WHERE RNUM BETWEEN 20 AND 30
;

SELECT T.*
FROM (
    SELECT ROWNUM RNUM, P.*, C.NAME CATEGORY_NAME, M.NICK NICK
    FROM 
    (
    SELECT * FROM PROJECT
    ORDER BY END_DATE ASC
    )P
    JOIN CATEGORY C
    ON P.CATEGORY_NO = C.CATEGORY_NO
    JOIN MEMBER M
    ON P.MAKER_NO = M.NO
    WHERE P.CATEGORY_NO = 2
    AND P.STATUS = 'I'
) T
WHERE RNUM BETWEEN 1 AND 30
;

SELECT T.*
FROM (
    SELECT ROWNUM RNUM, P.*
    FROM PROJECT P
    WHERE
    STATUS = 'I'
    OR STATUS = 'S'
    OR STATUS = 'B'
) T
WHERE RNUM BETWEEN 1 AND 10
;

SELECT P.*, C.NAME CATEGORY_NAME
FROM PROJECT P
JOIN CATEGORY C
ON P.CATEGORY_NO = C.CATEGORY_NO
WHERE P.PROJECT_NO = ?
;


SELECT NAME
FROM CATEGORY
WHERE CATEGORY_NO = 9
;


SELECT COUNT(PROJECT_NO) COUNT
FROM PROJECT
WHERE
STATUS = 'I'
OR STATUS = 'S'
OR STATUS = 'B'
;

SELECT * FROM PROJECT;

SELECT T.*
FROM
    (SELECT ROWNUM RNUM, P.*, C.NAME CATEGORY_NAME, M.NICK NICK
    FROM PROJECT P
    JOIN CATEGORY C
    ON P.CATEGORY_NO = C.CATEGORY_NO
    JOIN MEMBER M
    ON P.MAKER_NO = M.NO
    WHERE P.NAME LIKE ?
    AND P.STATUS = ?
    ) T
WHERE RNUM BETWEEN ? AND ?
;

SELECT ROWNUM RNUM, P.*
    FROM PROJECT P
    JOIN CATEGORY C
    ON P.CATEGORY_NO = C.CATEGORY_NO
    WHERE P.NAME LIKE '%자바%'
    AND P.STATUS = 'I';
    
SELECT * FROM DONATE_LIST;

SELECT ROWNUM RNUM, P.*, C.NAME CATEGORY_NAME, M.NICK NICK
FROM PROJECT P
JOIN CATEGORY C
ON P.CATEGORY_NO = C.CATEGORY_NO
JOIN MEMBER M
ON P.MAKER_NO = M.NO
;

SELECT T.* 
FROM
    (
    SELECT ROWNUM RNUM, P.*, C.NAME CATEGORY_NAME, M.NICK NICK
    FROM PROJECT P
    JOIN CATEGORY C
    ON P.CATEGORY_NO = C.CATEGORY_NO
    JOIN MEMBER M
    ON P.MAKER_NO = M.NO
    ) T
WHERE RNUM BETWEEN 1 AND 10
;

SELECT T.PROJECT_NO, COUNT(*) COUNT
FROM 
(
    SELECT ROWNUM RNUM, P.*, C.NAME CATEGORY_NAME, M.NICK NICK
    FROM PROJECT P
    JOIN CATEGORY C
    ON P.CATEGORY_NO = C.CATEGORY_NO
    JOIN MEMBER M
    ON P.MAKER_NO = M.NO
) T
JOIN PROJECT_LIKE L
ON T.PROJECT_NO = L.PROJECT_NO
WHERE L.STATUS = 'L'
GROUP BY T.PROJECT_NO
ORDER BY COUNT DESC
;

SELECT U.* 
FROM 
(
    SELECT T.PROJECT_NO, COUNT(*) COUNT
    FROM 
    (
        SELECT ROWNUM RNUM, P.*, C.NAME CATEGORY_NAME, M.NICK NICK
        FROM PROJECT P
        JOIN CATEGORY C
        ON P.CATEGORY_NO = C.CATEGORY_NO
        JOIN MEMBER M
        ON P.MAKER_NO = M.NO
    ) T
    JOIN PROJECT_LIKE L
    ON T.PROJECT_NO = L.PROJECT_NO
    WHERE L.STATUS = 'L'
    GROUP BY T.PROJECT_NO
    ORDER BY COUNT DESC
) U
WHERE RNUM BETWEEN 1 AND 10
;

INSERT INTO PROJECT_LIKE
(
    NO
    ,MEMBER_NO
    ,PROJECT_NO
    ,STATUS
)
VALUES
(
    SEQ_PROJECT_LIKE_NO.NEXTVAL
    , 1
    , 1
    , 'L'
)
;
COMMIT;

SELECT U.* FROM
    (
    SELECT ROWNUM RNUM, T.*, PRJ.* FROM
        (
        SELECT P.PROJECT_NO, COUNT(*) COUNT
        FROM PROJECT P
        JOIN PROJECT_LIKE L
        ON P.PROJECT_NO = L.PROJECT_NO
        WHERE L.STATUS = 'L'
        GROUP BY P.PROJECT_NO
        ORDER BY COUNT DESC
        ) T
    JOIN PROJECT PRJ
    ON PRJ.PROJECT_NO = T.PROJECT_NO
    ) U
WHERE U.RNUM BETWEEN 1 AND 10
;

SELECT COUNT(U.PROJECT_NO) FROM
(
SELECT T.*, M.NICK NICK,
C.NAME CATEGORY_NAME
,PRJ.NAME NAME
,PRJ.REGISTER_DATE REGISTER_DATE
,PRJ.START_DATE START_DATE
,PRJ.END_DATE END_DATE
,PRJ.GOAL GOAL
,PRJ.TEXT TEXT
,PRJ.THUMBNAIL_NAME THUMBNAIL_NAME
,PRJ.THUMBNAIL_PATH THUMBNAIL_PATH
,PRJ.STATUS STATUS
FROM
(
SELECT Z.* FROM
(
SELECT P.PROJECT_NO, COUNT(*) COUNT
FROM PROJECT P
JOIN PROJECT_LIKE L
ON P.PROJECT_NO = L.PROJECT_NO
WHERE L.STATUS = 'L'
GROUP BY P.PROJECT_NO
ORDER BY COUNT DESC
) Z
WHERE COUNT > 9
) T
JOIN PROJECT PRJ
ON PRJ.PROJECT_NO = T.PROJECT_NO
JOIN MEMBER M
ON PRJ.MAKER_NO = M.NO
JOIN CATEGORY C
ON PRJ.CATEGORY_NO = C.CATEGORY_NO
WHERE
PRJ.STATUS = 'I'
OR PRJ.STATUS = 'S'
OR PRJ.STATUS = 'B'
) U
;

select * from project;

SELECT p.*, m.*, c.name categoty_name, total FROM PROJECT P 
JOIN MEMBER M ON P.MAKER_NO = M.NO JOIN category C ON p.category_no = c.category_no 
JOIN (SELECT p.project_no, SUM(TOTAL) total FROM PROJECT P 
JOIN REWARD R ON p.project_no = r.project_no 
JOIN (SELECT R.NO, SUM((TO_NUMBER(d.amount)*TO_NUMBER(d.quantity))+TO_NUMBER(NVL(d.additional, 0))) total FROM REWARD R 
JOIN DONATE_LIST D ON r.no = d.reward_no GROUP BY R.NO) T ON T.NO = R.NO GROUP BY p.project_no) T ON p.project_no = t.PROJECT_NO 
WHERE P.STATUS = 'I' AND p.end_date >= TO_CHAR(SYSDATE, 'YYYY/MM/DD') and p.end_date <= TO_CHAR(SYSDATE+3, 'YYYY/MM/DD') ORDER BY end_date;


SELECT ROWNUM RNUM, PRJ.*, m.*, c.name CATEGORY_NAME, total FROM PROJECT PRJ JOIN MEMBER M ON PRJ.MAKER_NO = M.NO
JOIN category C ON PRJ.category_no = c.category_no
WHERE PRJ.STATUS = 'I' AND PRJ.start_date <= TO_CHAR(SYSDATE, 'YYYY/MM/DD') and PRJ.start_date >= TO_CHAR(SYSDATE-5, 'YYYY/MM/DD')
;

SELECT U.* FROM
(
SELECT ROWNUM RNUM, P.*, C.NAME CATEGORY_NAME, M.NICK NICK
FROM PROJECT P
JOIN MEMBER M ON P.MAKER_NO = M.NO
JOIN CATEGORY C ON P.CATEGORY_NO = C.CATEGORY_NO
WHERE P.STATUS = 'I'
AND
P.START_DATE <= TO_CHAR(SYSDATE, 'YYYY/MM/DD')
AND
P.START_DATE >= TO_CHAR(SYSDATE-5, 'YYYY/MM/DD')
) U
WHERE RNUM BETWEEN 1 AND 10
;


SELECT COUNT(U.PROJECT_NO) COUNT FROM
(
SELECT P.*, C.NAME CATEGORY_NAME, M.NICK NICK
FROM PROJECT P
JOIN MEMBER M ON P.MAKER_NO = M.NO
JOIN CATEGORY C ON P.CATEGORY_NO = C.CATEGORY_NO
WHERE P.STATUS = 'I'
AND
(P.END_DATE >= TO_CHAR(SYSDATE, 'YYYY/MM/DD')
AND
P.END_DATE <= TO_CHAR(SYSDATE+3, 'YYYY/MM/DD'))
) U
;




COMMIT;






SELECT COUNT(Z.PROJECT_NO) COUNT FROM
(
SELECT PRJ.*, M.*, C.NAME CATEGORY_NAME, TOTAL FROM PROJECT PRJ JOIN MEMBER M ON PRJ.MAKER_NO = M.NO
JOIN CATEGORY C ON PRJ.CATEGORY_NO = C.CATEGORY_NO
JOIN (SELECT P.PROJECT_NO, SUM(TOTAL) TOTAL FROM PROJECT P JOIN REWARD R ON P.PROJECT_NO = R.PROJECT_NO
JOIN (SELECT R.NO, SUM((TO_NUMBER(D.AMOUNT)*TO_NUMBER(D.QUANTITY))+TO_NUMBER(NVL(D.ADDITIONAL, 0))) TOTAL
FROM REWARD R JOIN DONATE_LIST D ON R.NO = D.REWARD_NO GROUP BY R.NO) T 
ON T.NO = R.NO GROUP BY P.PROJECT_NO) TBL
ON PRJ.PROJECT_NO = TBL.PROJECT_NO WHERE PRJ.STATUS = 'I' AND PRJ.START_DATE <= TO_CHAR(SYSDATE, 'YYYY/MM/DD') AND PRJ.START_DATE >= TO_CHAR(SYSDATE-5, 'YYYY/MM/DD')
) Z
;