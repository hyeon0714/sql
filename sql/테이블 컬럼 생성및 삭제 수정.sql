#데이터베이스 접속(이미 접속해서 할필요는 없지만 배우기 위해 실행/관리자 계정에서 실행후 이것과 동일하게 테이블을 생성, 수정, 삭제할수 있다)
use book_db;

#테이블 생성
create table	book(book_id int,			# book_id의 자료형을 정수(int)로
					title varchar(50),		# title의 자료형을 문자(50자 내외)로
                    author varchar(20),		# author의 자료형을 문자(20자 내외)로
                    pub_date datetime);		# pub_date의 자료형을 날자형식으로

show tables; 	#생성확인

alter table book add pubs varchar(50);		# book 테이블에서 컬럼을 추가->pubs이라는 테이블이고 자료형은 문자(50자내외)

select	*
from book;			# pubs 생성확인

alter table book modify title varchar(100);			# book테이블에서 수정을 진행 / 타이틀 컬럼의 문자형을 문자(100자내외로) 로 수정
alter table book rename column title to subject;	# book테이블에서 수정을 진행 / 컬럼의 이름 변경 / 기존의 title을 subject로
select	*
from book;			# title 변경확인

alter table book drop author;						# book테이블에서 수정을 진행 / 컬럼의 제거 / author 라는 컬럼을 제거

rename table book to article;						# 테이블 이름을 변경 / book에서 article로

drop table article;									# 테이블 제거 // 데이터테이블을 지운건 아님
#### truncate table 테이블명;  => 해당 테이블의 모든 row를 제거




#################### author 테이블 생성

create table author	(author_id int primary key,				#기본키 지정( not null + unique)
					author_name varchar(100) not null,		#null값 지정 안됨(값을 입력해야함)
					author_desc varchar(500));				# unipue = 해당 컬럼에서 중복값을 막는다
                    
                    
create table book	(book_id int primary key,
					title varchar(100) not null,
                    pubs varchar(100),
                    pub_date datetime,
                    author_id int,
                    constraint book foreign key (author_id)		#book 테이블의 author_id를 외부키로 지정
                    references author(author_id));				#외부키를 다른 테이블의 기본키와 연결

show tables;

## insert

insert into author	#묵시적 방법
value(1, '박경리','토지 작가');					#컬럼및 순서지정이 없는경우 테이블 생성시에 순서에 따라 값 입력

# 값 입력 확인
select	*
from author;

insert into author(author_id, author_name)	#명시적 방법
value(3, '정우성');							#컬럼의 지정이 있으므로 해당 지정한 컬럼에 순서대로 입력(입력되지 않은 값은 null로 표시) +++ author_name은 not null이라서 null값이 입력불가다

update author								
set author_name='기안84',					# author_name을 기안84로
	author_desc='웹툰작가'					# author_desc를 웹툰작가로 수정(update) 진행
where author_id=1;							# where 을 이용해서 author_id 1번 위치의 내용을 업데이트함	+++		where로 지정을 안할시 전체 내용이 바뀐다

select	*
from author;

update author
set author_name = '강풀', 
	author_desc = '인기작가' ;				# 어떤 행을 삭제하거나 수정하려할 때 나오는 에러인데, 삭제 / 수정시에는 Key 열을 이용해서만 가능하도록 설정되어 있기 때문에 등장한다(작동이 안되는 이유)

delete from author
where author_id=4;							# delete로 author_id 4번의 row를 삭제	+++		조건이 없는경우 전체가 삭제된다

select	*
from book;

insert into book
value(1,'우리들의','다림','1998-02-22',1);
insert into book
value(5,'패션왕','중앙북스','2012-02-22',3);

select	*
from book b, author a
where b.author_id=a.author_id;

drop table author;
drop table book;


##########
create table author	(author_id int				auto_increment primary key,					# auto_increment 자동으로 번호를 부여해준다
					author_name varchar(100)	not null,
                    author_desc varchar(100));

insert into author(author_name,author_desc)
value('김영하','알쓸신잡');

select	*
from author;

select	last_insert_id();					# 현재 마지막값을 보여준다



drop table author;

CREATE DATABASE  IF NOT EXISTS 테이블명 # 만약 테이블명이 없으면 생성