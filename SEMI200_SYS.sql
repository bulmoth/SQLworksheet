--200% 계정

-- 계정 생성
CREATE USER C##SEMI200 IDENTIFIED BY "1234";

-- 계정 권한
GRANT CREATE SESSION, CONNECT, RESOURCE TO C##SEMI200;

ALTER USER C##SEMI200 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;