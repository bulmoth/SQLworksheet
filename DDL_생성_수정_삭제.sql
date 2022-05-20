-- DDL

-- 테이블 생성(이 테이블도 삭제할 예정...)
-- 칼럼명에 공백이 있을 시, 쌍따옴표로 묶어주면 사용 가능
-- 예약어를 칼럼명으로 사용하고 싶으면, 쌍따옴표로 처리 가능
CREATE TABLE KH_MEMBER(
      NAME VARCHAR2(10)
    , AGE NUMBER
);

-- 테이블에 칼럼 추가(DDL)
ALTER TABLE KH_MEMBER ADD EMAIL VARCHAR2(100);

-- 테이블 칼럼 삭제
ALTER TABLE KH_MEMBER DROP COLUMN EMAIL;

-- 칼럼 수정하기
-- 조건에 맞지 않는 데이터가 이미 들어있다면, 수정 불가
ALTER TABLE KH_MEMBER MODIFY NAME VARCHAR2(100);
ALTER TABLE KH_MEMBER MODIFY NAME NUMBER;

--데이터 넣어보기
INSERT INTO KH_MEMBER (NAME, AGE)
VALUES('심원용', 20);
COMMIT;

-- 테이블 삭제하기
DROP TABLE KH_MEMBER;

SELECT * FROM KH_MEMBER;


