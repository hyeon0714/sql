show databases;
use mysql;
show tables;

select user, host from user;

exit;

show databases;
use hrdb;


show tables;
select	*
from employees;






create user 'webdb'@'%' identified by '1234';

grant all privileges on web_db to 'webdb'@'%';

drop user 'webdb'@'%';




################

create database web_db				# web_db라는 데이터 베이스 생성
	default character set utf8mb4	# 데이터베이스의 글자를 한글로 나올수 있게 문자 설정
    collate utf8mb4_general_ci		# utf8mb4 라는 글자의 정렬 방법 설정
    default encryption 'n';			# 암호화 사용 안함


show databases;			# web_db라는 데이터 베이스 생성 확인

drop database web_db;	# web_db라는 데이터 베이스 삭제

show databases;			# web_db 삭제 확인

#계정명 book,  비번 book, 모든곳에서 접속 가능한 계정을 만드세요      
create user 'book'@'%' identified by 'book';

#  권한은 book_db 데이타베이스의 모든 테이블에 모든 권한을 갖도록 하세요
grant all privileges on book_db.* to 'book'@'%';

# book_db 데이터베이스 생성 후 한글패치
create database book_db
	default character set utf8mb4
    collate utf8mb4_general_ci
    default encryption 'n';

/* if exists 문법 
drop user if exists 'book'@'%';		# 만약 사용자가 있다면 제거
drop database if exists book_db;	# 만약 데이터베이스가 잇다면 제거
*/

# 데이터 베이스 생성확인
show databases;
# 사용자 생성 확인
use mysql;
select user, host from user;

use book_db;

