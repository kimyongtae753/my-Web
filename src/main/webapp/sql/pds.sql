--pds.sql
--포토갤러리

--테이블 생성
CREATE TABLE tb_pds (
    pdsno      INT            AUTO_INCREMENT PRIMARY KEY,   -- 게시물 번호
    wname      VARCHAR(100)   NOT NULL,   -- 작성자 이름
    subject    VARCHAR(250)   NOT NULL,   -- 제목
    regdate    DATE           NOT NULL,   -- 등록일
    passwd     VARCHAR(15)    NOT NULL,   -- 비밀번호
    readcnt    INT            DEFAULT 0,  -- 조회수
    filename   VARCHAR(250)   NOT NULL,   -- 파일명
    filesize   INT            DEFAULT 0   -- 파일크기
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- pds_seq 시퀀스 생성
CREATE SEQUENCE pds_seq
    START WITH 1        -- 시퀀스 시작 값
    INCREMENT BY 1      -- 시퀀스 증가 값
    NO CACHE;           -- 캐시 사용 안 함 (필요시 변경 가능)


--행추가
pdsno				:시퀀스에서 일련번호 발생
wname, subject, passwd : 사용자 입력 <form></form>
regdate				:오늘 날짜(sysdate)