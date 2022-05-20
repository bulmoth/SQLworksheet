--트렌잭션

/*
    쪼갤 수 없는 업무 처리의 최소 단위
    EX) 계좌이체 : 내 통장의 돈을 다른 통장으로 옮기는 것...
    1. 이체할 금액 확인
    2. 내 통장 잔고 확인
    3. 내 통장 금액 변경
    4. 상대방 통장 잔고 변경
    
*/

--커밋, 롤백

--트렌젝션 테스트를 위한 임시 테이블 생성    //삭제(DROP)할거임
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

DROP TABLE MY_TB;   --DDL구문






