use hrdb;
-- (주석)
#(주석)

#select ~ from 절
#=>> 조회하기
select * from employees;
select*from departments;
select*from locations;
select*from countries;
select*from regions;
select*from jobs;
select*from job_history;

#select 절
select first_name, salary    #cmployees테이블에서 first_name, salary만 출력
#from 절
 from employees;
 
select employee_id, first_name, last_name from employees;     

#모든 직원의 이름(first_name)과 전화번호 입사일 연봉을 출력하세요
select first_name, phone_number, hire_date, salary from employees;

#모든 직원의 이름(first_name)과 성(last_name), 월급, 전화번호, 이메일, 입사일을 출력하세요
select  first_name 'f-name',
		last_name,
		salary,
		phone_number, 
		email, 
		hire_date 
from employees;    #절별로 컬럼별로 끊어쓰는 경우가 많다

#직원아이디, 이름, 월급을 empNO, f-name, 월 급으로 컬럼명을 출력하세요
select  job_id empNo,
		first_name as 'f-name',
        salary '월 급'     #컬럼명을 만들때 특수문자나 공백이 들어가면 ''로 감싸준다     +++  as 로 컬럼명을 구분하기도 한다
from employees;

#직원의 이름(fisrt_name)과 전화번호, 입사일, 월급 으로 표시되도록 출력하세요
select  first_name,
		phone_number,
        hire_date,
        salary
from employees;

#직원의 직원아이디를 사 번, 이름(first_name), 성(last_name), 월급, 전화번호, 이메일, 입사일로 표시되도록 출력하세요
select  employee_id 사번,
		first_name 이름,
		last_name 성,
        salary 월급,
        phone_number 전화번호,
        email 이메일,
        hire_date 입사일
from employees;

# 산술 연산자 사용해보기
select  first_name,
		salary 월급,
        salary-100 '월급-식대',
        salary*12 연봉,
        salary*12+5000 '연봉+보너스',
        salary/30 일급,
        employee_id%3 '워크샵팀'   #원본을 두고 계산결과를 출력해볼수가 있다
from employees;

select  job_id*12,    #문자열은 연산시 0으로 처리된다
		job_id+12
from employees;

#컴럼 합치기(concat)
select concat(first_name, last_name) 이름
from employees;

#concat 활용1
select concat(first_name, '-', last_name) 이름
from employees;

#concat 활용2
select 	concat(first_name, ' ',last_name, ' hire date is ', hire_date) 직원입사일
from employees;

select  first_name,
		salary,
        '(주)개발자' company,    #없는 데이터를 일괄로 적용해서 출력할수도 있다
        3 상태
from employees;

#테이플명 생략
select  '(주)개발자';  #테이블에도 포함되지 않는 내용을 입력한것이라 테이블명이 없어도 사용이 된다

select now();  #현재의 시간을 가져오는 문법이라서 테이블명이 굳이 필요없다

select now()
from employees;  #위의 문법과 결과가 같다

select now() 
from dual;  #dual이라는 가상의 테이블을 넣을수도 있다(내용은 똑같이 없음)


#where 절
#부서번호가 10인 사원의 이름을 구하시오
select  first_name
from employees
where department_id=10;

#연봉이 15000 이상인 사원들의 이름과 월급을 출력하세요
select  first_name,
		salary
from employees
where salary>=15000;

#07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select  first_name,
		hire_date
from employees
where hire_date > 20070101;

#이름이 Lex인 직원의 이름과 월급을 출력하세요  - 문자열 대소문자를 구별하지 않는다.  구별하려면 binary 사용
select  first_name,
		salary
from employees
where first_name = 'lex';   #문자를 검색할때는 ''로 감싸줘야한다

select  first_name,
		salary
from employees
where binary first_name = 'lex';   #binary 문법은 대.소문자의 기준을 명확하게 잡아야 출력이 인정된다  =>   'Lex'로 바꾸면 출력된다

#월급이 14000이상 17000이하인 사원의이름과 월급을 구하시오
SELECT 
    first_name, salary
FROM
    employees
WHERE
    14000 <= salary AND salary <= 17000;   #한번에 표시는 안되고 and와 or을 써줘야한다

#월급이 14000 이하이거나 17000 이상인 사원의 이름과 월급을 출력하세요
select  first_name,
		salary
from employees
where 14000>=salary 
or salary >=17000;

#입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select  first_name,
		hire_date
from employees
where 20040101<=hire_date 
and hire_date<=20051231;

#월급이 14000 이상 17000이하인 사원의이름과 월급을 구하시오
select  first_name,
		salary
from employees
where salary between 14000 and 17000;    #between 문법은 사이의 값만 구할 때 사용할수 있다(비교연산자를 사용하지 않을때)  ##### between은 작은값을 먼저 써야 적용된다

#Neena, Lex, John 의 이름, 성, 월급의 구하시오
select  first_name,
		last_name,
        salary
from employees
where first_name in('lex', 'neena', 'john');    #in 문법은 찾고자 하는 내용을 처음부터 끝까지 지정해줘야 그 내용을 찾는다(중간값만으로는 찾기 안됨)

select  first_name,
		last_name,
        salary
from employees
where 	first_name = 'lex'
or		first_name = 'neena'
or		first_name = 'john';       # in문법을 사용하면 or만 써서 내용을 찾는것보다 문법을 줄일수 있다

#월급이 2100, 3100, 4100, 5100 인 사원의 이름과 월급을 구하시오
select  first_name,
        salary
from employees
where salary in (2100, 3100, 4100, 5100);

select now()
from dual;

select  hire_date,
		job_id,
        commission_pct
from employees
where job_id like 'it%';  # where의 like 사용은 비슷한 내용을 가진것을 찾는다 'it%'는 %라는 특수문자가 들어가서 ''로 감싸줫고 %는 공백을 포함한 임의의 문자열을 포함한다
						  # 여기서 'it%'는 it로 시작한 임의의 문자열을 의미한다
                          
select  first_name,
		last_name,
        salary
from employees
where first_name like '%e%';   # first_name 중에 중간에 e가 들어간 내용을 전부 찾는다

select  first_name,
		last_name,
        salary
from employees
where first_name like '_e%';  # like에서 '_'는 문자 한개를 의미하므로 2번째 글자가 e인 first_name을 찾는다

#이름에 am을 포함한 사원의 이름과 월급을 출력
select  first_name,
		salary
from employees
where first_name like '%am%';

#이름의 두번째 글자가 a 인 사원의 이름과 월급을 출력하세요
select  first_name,
		salary
from employees
where first_name like '_am%';

#이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select  first_name
from employees
where first_name like '___a%';

#이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select  first_name
from employees
where first_name like '_a__';

select  first_name, 
		salary, 
        commission_pct, 
        salary*commission_pct
from employees
where salary between 13000 and 15000;

select  first_name, 
		salary, 
        commission_pct
from employees
where commission_pct is null;  #커미션이 null인 사람

select  first_name, 
		salary, 
        commission_pct
from employees
where commission_pct is not null;   #커미션이 null이 아닌사람

#담당매니저가 없고 커미션비율이 없는 직원의 이름과 매니저아이디 커미션 비율을 출력하세요
select  first_name, 
		manager_id,
        commission_pct
from employees
where commission_pct is null and manager_id is null;   #and를 써주더라도 각각의 조건에 null을 넣어줘야한다

#부서가 없는 직원의 이름과 월급을 출력하세요
select  first_name, 
        commission_pct
from employees
where department_id is null;


select  *
from employees
order by last_name;    # order by 오름차순 정렬을 준다 기존의 employee_id 정렬이 아닌 last_nanme을 정렬을 주었다

select  *
from employees
order by last_name desc;    # order by절의 끝에 desc를 입력하면 오름차순이 아닌 내림차순으로 정렬이 가능하다

