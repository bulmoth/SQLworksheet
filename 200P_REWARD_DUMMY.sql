INSERT INTO REWARD(
    NO
    ,PROJECT_NO
    ,"OPTION"
    ,DETAIL
    ,PRICE
    ,QUANTITY
) VALUES
(
    SEQ_REWARD_NO.NEXTVAL
    ,2
    ,'¹Ì²ø°Å¸§¸Á'
    ,'°Å¸§¸Á10°³ÀÔ'
    ,50000
    ,10
)
;

COMMIT;

---------------------
--TEST
---------------------

SELECT *
FROM REWARD
WHERE NO = ?
;