@ mariaDB
-- bbs.sql

-- 답변형 게시판
CREATE TABLE tb_bbs (
    bbsno       INT           AUTO_INCREMENT PRIMARY KEY
   ,wname       VARCHAR(20)   NOT NULL
   ,subject     VARCHAR(100)  NOT NULL
   ,content     TEXT          NOT NULL
   ,grpno       TINYINT       NOT NULL
   ,indent      TINYINT       DEFAULT 0    NOT NULL
   ,ansnum      TINYINT       DEFAULT 0    NOT NULL
   ,regdt       DATETIME      NOT NULL
   ,passwd      VARCHAR(15)   NOT NULL
   ,readcnt     INT           DEFAULT 0    NOT NULL
   ,ip          VARCHAR(15)   NOT NULL
);

INSERT tb_bbs( wname, subject, content, grpno, indent, ansnum, regdt, passwd, readcnt, ip)
VALUES ('메시', '바르셀로나', '공격수', '9', '124.0.0.1', (select ifnull(max(bbsno),0)+1 from tb_bbs as TB), now())


CREATE TABLE tb_bbs (
    bbsno       INT           AUTO_INCREMENT PRIMARY KEY
   ,wname       VARCHAR(20)   NOT NULL
   ,subject     VARCHAR(100)  NOT NULL
   ,content     TEXT          NOT NULL
   ,grpno       TINYINT       NOT NULL
   ,indent      TINYINT       DEFAULT 0    NOT NULL
   ,ansnum      TINYINT       DEFAULT 0    NOT NULL
   ,regdt       DATETIME      NOT NULL
   ,passwd      VARCHAR(15)   NOT NULL
   ,readcnt     INT           DEFAULT 0    NOT NULL
   ,ip          VARCHAR(15)   NOT NULL
)ENGINE=MyISAM DEFAULT CHARSET="utf8"; 






