-- member.sql

-- 회원테이블 생성
CREATE TABLE member (
    id       VARCHAR(10)  NOT NULL, -- 아이디, 중복 안됨.
    passwd   VARCHAR(10)  NOT NULL, -- 패스워드
    mname    VARCHAR(20)  NOT NULL, -- 성명
    tel      VARCHAR(14)  NULL,     -- 전화번호
    email    VARCHAR(50)  NOT NULL  UNIQUE, -- 전자우편 주소, 중복 안됨
    zipcode  VARCHAR(7)   NULL,     -- 우편번호, 12345
    address1 VARCHAR(255) NULL,     -- 주소 1
    address2 VARCHAR(255) NULL,     -- 주소 2(나머지주소)
    job      VARCHAR(20)  NOT NULL, -- 직업
    mlevel   CHAR(2)      NOT NULL, -- 회원 등급, A1, B1, C1, D1, E1, F1
    mdate    DATE         NOT NULL, -- 가입일    
    PRIMARY KEY (id)
)ENGINE=MyISAM DEFAULT CHARSET="utf8";

-- 회원등급
A1: 관리자
B1: 중간 관리자
C1: 우수 사용자
D1: 일반 사용자 (기본)
E1: 비회원
F1: 탈퇴한 회원

/////////////////////////////////////////////////////////////////////


--행추가
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
values('webmaster', '12341234', '웹마스터', '123-4567', 'webmaster@greenit.co.kr'
     , '12345', '서울시 강남구 역삼동', '삼원타워4층', 'A02', 'A1', now() );

insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
values('greenit', '12341234', '웹마스터', '123-4567', 'greenit@greenit.co.kr'
     , '12345', '서울시 강남구 역삼동', '삼원타워4층', 'A02', 'D1', sysdate );

insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
values('korea', '12341234', '웹마스터', '123-4567', 'korea@greenit.co.kr'
     , '12345', '서울시 종로구 관철동', '국일드림팰리스 5층', 'A02', 'F1', sysdate );
     
commit;          

/////////////////////////////////////////////////////////////////////


-- 로그인
-- 아이디/비번이 일치하면 회원등급 가져오기
-- 단, 비회원과 탈퇴회원은 제외
select mlevel
from member
where id='webmaster' and passwd='12341234' and mlevel in ('A1','B1','C1','D1');

select mlevel
from member
where id='greenit' and passwd='12341234' and mlevel in ('A1','B1','C1','D1');

select mlevel
from member
where id='korea' and passwd='12341234' and mlevel in ('A1','B1','C1','D1');


/////////////////////////////////////////////////////////////////////


-- 아이디 중복확인
select count(id)
from member where id = ?;

-- 회원가입
INSERT INTO member (id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'D1', sysdate)

● [아이디/비번찾기] - findID.jsp
1) 이름과 이메일을 입력받아서 일치가 되면 id를 가져오고
2) 임시 비밀번호를 발급 해서
3) 아이디와 임시 비밀번호를 이메일로 전송하기
4) 임시비밀번호로 로그인 한후,
5) 본인이 회원 정보 수정(memberModify.jsp)에서 비밀번호를 수정한다
● [임시 비밀번호 발급]
1) 대문자, 소문자, 숫자를 이용해서 랜덤하게 10글자를 만들기
2) 1)에서 생성된 임시 비밀번호를 테이블에서 수정하기
이강사
오전 10:04

insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
values('kimkim', '12341234', '김연아', '123-4567', '???????@naver.com'
     , '12345', '서울시 종로구 인사동', '역삼빌딩8층', 'A02', 'D1', sysdate );
     
commit;     
     

--아이디/비번찾기 연습용 데이터 행추가
1)이름과 이메일을 입력받아서 일치가 되면 id를 가져오고

select id
from member
where mname=? and email=?

2) 임시 비밀번호를 테이블에서 수정하기

update member
set passwd=?
where mname=? and email=?





