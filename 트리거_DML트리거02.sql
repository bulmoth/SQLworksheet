--Ʈ����

CREATE OR REPLACE TRIGGER TRG_BOARD_DML_CNT
AFTER INSERT OR DELETE OR UPDATE ON BOARD
    BEGIN 
        INSERT INTO BOARD_DML_CNT VALUES(NVL((SELECT MAX(CNT) FROM BOARD_DML_CNT),0)+1);
        
        DELETE BOARD_DML_CNT WHERE CNT != (SELECT MAX(CNT) FROM BOARD_DML_CNT);
    END TRG_BOARD_DML_CNT;